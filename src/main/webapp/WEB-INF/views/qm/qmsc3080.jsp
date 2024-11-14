<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">최종검사현황</li>
			</ol>
		</nav>
	</header>
		<!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">
                  <!--======================== .left-list ========================-->
                  <div class="left-list left-60" id="left-60" style="width:99%; padding-bottom:0px; padding-top:9px;">
                      <div class="card">
                        <!-- .table-responsive -->

						<div class="row">
							<label class="input-label-sm ml-1">검사일</label>
							<div class="form-group input-sub m-0 row">
								<input class="form-control" style="width: 97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />
								<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">
									<span class="oi oi-calendar"></span>
								</button>
							</div>
							<label class="input-label-sm ml-1">~</label>
							<div class="form-group input-sub m-0 row">
								<input class="form-control" style="width: 97px;" type="text" id="chooseDateTo" name="chooseDateTo" />
								<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="chooseDateCalendar" type="button">
									<span class="oi oi-calendar"></span>
								</button>
							</div>
							<input class="input-label-sm ml-2" style="width: 20px; height: 20px;" type="checkbox" checked id="workOrderGubun" value="ok"> 
								<label for="workOrderGubun" class="input-label-sm" id="workOrderGubunLabel">엣지불량수함 포함</label> 
								<label class="input-label-sm ml-1">검사자</label> 
								<input type="hidden" class="form-control" id="preWorkCharger" name="preWorkCharger">
							<div class="input-sub m-0 row">
								<input type="text" class="form-control" id="preWorkChargerNm" name="preWorkChargerNm" disabled>
								<button type="button" class="btn btn-primary input-sub-search" id="btnSelPreWorkCharger"">
									<span class="oi oi-magnifying-glass"></span>
								</button>
							</div>
							<div>
								<a href="javascript:void(0)" id="cancelSearchUser"
									class="closebtn"><i class="mdi mdi-close"></i></a>
							</div>
							&nbsp;
							<button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button>
							&nbsp;<button type="button" class="btn btn-primary ml-2" id="btnPackingNumberInquiry">포장번호 조회</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">형식</label>
							<select class="custom-select" style="min-width: 70px; max-width: 70px;" id="showType">
								<option value="showType001">개수</option>
								<option value="showType002">%</option>
							</select>
						</div>


					<div class="d-none" id="goodsFaultyDateLookup"></div>
						<div class="d-none" id="edgeGoodsFaultyDateLookup"></div>
						<div id="workOrderDateLokkup"></div>

						<div class="card-header card-tab mt-2">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item"><a class="nav-link active show"
									data-toggle="tab" id="tab3">작업지시별</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab"
									id="tab1">외관검사</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab"
									id="tab2">엣지검사</a></li>

							</ul>
						</div>

						<div class="d-none" id="goodsFaultyView">
							<div class="table-responsive" style="padding-bottom: 10px;">
								<table id="faultyStatsDay" class="table table-bordered mt-0">
									<thead class="thead-light">
										<tr>
											<th rowspan="2" style="min-width: 70px" class="text-center">검사일</th>
											<th rowspan="2" style="min-width: 55px" class="text-center">검사자</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">검사수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">양품수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">불량수량</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">불량률(%)</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">생산일</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">설비명</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">작지번호</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">생산LotNo</th>
											<th rowspan="2" style="min-width: 130px" class="text-center">생산전표번호</th>
											<th rowspan="2" style="min-width: 40px" class="text-center">주야</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">생산<br>작업자
											</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">제품</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">재질</th>
											<th rowspan="2" style="min-width: 200px" class="text-center">규격</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">주자재</th>
											<th colspan="13" style="min-width: 70px;" class="text-center"
												class="text-center" id="metalHd">메탈부 불량</th>
											<th colspan="15" style="min-width: 70px;" class="text-center"
												class="text-center" id="filmHd">필름부 불량</th>
											<!-- <th colspan="2" style="min-width: 70px;" class="text-center"
												class="text-center" id="visonHd">비전부 불량</th>
											<th colspan="2" style="min-width: 70px;" class="text-center"
												class="text-center" id="fiveHd">5 부불량</th> -->
											<!-- <th colspan="2" style="min-width: 70px;" class="text-center" class="text-center" id="sixHd">6 부불량</th> -->
											<!-- <th colspan="19" style="min-width: 70px;" class="text-center" class="text-center">기타 불량</th> -->
										</tr>
										<tr id="appearHeader">
											<!-- 
										<th style="min-width: 70px">검사일</th>
										<th style="min-width: 55px">검사자</th>
										<th style="min-width: 50px" class="text-center">검사수량</th>
										<th style="min-width: 50px" class="text-center">양품수량</th>
										<th style="min-width: 50px" class="text-center">불량수량</th>
										<th style="min-width: 70px" class="text-center">불량률(%)</th>
										<th style="min-width: 70px">생산일</th>
										<th style="min-width: 40px">주야</th>
										<th style="min-width: 50px">설비명</th>
										<th style="min-width: 120px">Lot No</th>
										<th style="min-width: 50px">작업자</th>
										<th style="min-width: 50px">제품</th>
										<th style="min-width: 50px">재질</th>
										<th style="min-width: 200px">규격</th>
										 
										<th style="min-width: 55px" class="text-center">MMB</th>
										<th style="min-width: 55px" class="text-center">MMS</th>
										<th style="min-width: 55px" class="text-center">PMS</th>
										<th style="min-width: 55px" class="text-center">M찍힘</th>
										<th style="min-width: 55px" class="text-center">P찍힘</th>
										<th style="min-width: 55px" class="text-center">M이물</th>
										<th style="min-width: 55px" class="text-center">M꺽임</th>
										<th style="min-width: 55px" class="text-center">M오염</th>
										<th style="min-width: 55px" class="text-center">M갈변</th>
										<th style="min-width: 55px" class="text-center">P오염</th>
										<th style="min-width: 55px" class="text-center">도금박리</th>
										<th style="min-width: 55px" class="text-center">총두께</th>
										<th style="min-width: 55px" class="text-center">메탈-기타</th>
										<th style="min-width: 55px" class="text-center">PFS</th>
										<th style="min-width: 55px" class="text-center">F꺽임</th>
										<th style="min-width: 55px" class="text-center">뜯김</th>
										<th style="min-width: 55px" class="text-center">표면기포</th>
										<th style="min-width: 55px" class="text-center">엣지기포</th>
										<th style="min-width: 55px" class="text-center">테프론</th>
										<th style="min-width: 55px" class="text-center">P이물</th>

										<th style="min-width: 55px" class="text-center">P오염</th>
										<th style="min-width: 55px" class="text-center">F뭉침</th>
										<th style="min-width: 55px" class="text-center">필름겹침</th>
										<th style="min-width: 55px" class="text-center">미진접</th>
										<th style="min-width: 55px" class="text-center">미부착</th>
										<th style="min-width: 55px" class="text-center">MF</th>
										<th style="min-width: 55px" class="text-center">날개꺽임</th>
										<th style="min-width: 55px" class="text-center">필름-기타</th>
										<th style="min-width: 55px" class="text-center">치수</th>
										<th style="min-width: 55px" class="text-center">컷팅</th>
										<th style="min-width: 55px" class="text-center">필름눌림</th>
										<th style="min-width: 55px" class="text-center">필름폭</th>
										<th style="min-width: 55px" class="text-center">레이어</th>
										<th style="min-width: 55px" class="text-center">빨래판</th>
										<th style="min-width: 55px" class="text-center">백색테이프</th>
										<th style="min-width: 55px" class="text-center">결무늬</th>
										<th style="min-width: 55px" class="text-center">F찍힘</th>
										<th style="min-width: 55px" class="text-center">아지랑이</th>
										<th style="min-width: 55px" class="text-center">표면처리</th>
										<th style="min-width: 55px" class="text-center">돌기</th>
										<th style="min-width: 55px" class="text-center">피딩</th>
										<th style="min-width: 55px" class="text-center">필름농</th>
										<th style="min-width: 55px" class="text-center">F사선</th>
										<th style="min-width: 55px" class="text-center">진접터짐</th>
										<th style="min-width: 55px" class="text-center">들뜸</th>
										<th style="min-width: 55px" class="text-center">P.P주름</th>
										<th style="min-width: 55px" class="text-center">기타-기타</th>
										-->
										</tr>
									<tfoot>
										<tr>
											<td colspan="2" style="text-align: center">합계</td>
											<td colspan="" id="sumOutputCnt" style="text-align: right">0</td>
											<td colspan="" id="sumAppearOutputCnt"
												style="text-align: right">0</td>
											<td colspan="" id="sumFaulty" style="text-align: right">0</td>
											<td colspan="" id="sumFaultyPercent"
												style="text-align: right">0</td>
											<td colspan="11"></td>
											<td colspan="" id="faulty1" style="text-align: right">0</td>
											<td colspan="" id="faulty2" style="text-align: right">0</td>
											<td colspan="" id="faulty3" style="text-align: right">0</td>
											<td colspan="" id="faulty4" style="text-align: right">0</td>
											<td colspan="" id="faulty5" style="text-align: right">0</td>
											<td colspan="" id="faulty6" style="text-align: right">0</td>
											<td colspan="" id="faulty7" style="text-align: right">0</td>
											<td colspan="" id="faulty8" style="text-align: right">0</td>
											<td colspan="" id="faulty9" style="text-align: right">0</td>
											<td colspan="" id="faulty10" style="text-align: right">0</td>
											<td colspan="" id="faulty11" style="text-align: right">0</td>
											<td colspan="" id="faulty12" style="text-align: right">0</td>
											<td colspan="" id="faulty13" style="text-align: right">0</td>
											<td colspan="" id="faulty14" style="text-align: right">0</td>
											<td colspan="" id="faulty15" style="text-align: right">0</td>
											<td colspan="" id="faulty16" style="text-align: right">0</td>
											<td colspan="" id="faulty17" style="text-align: right">0</td>
											<td colspan="" id="faulty18" style="text-align: right">0</td>
											<td colspan="" id="faulty19" style="text-align: right">0</td>
											<td colspan="" id="faulty20" style="text-align: right">0</td>
											<td colspan="" id="faulty21" style="text-align: right">0</td>
											<td colspan="" id="faulty22" style="text-align: right">0</td>
											<td colspan="" id="faulty23" style="text-align: right">0</td>
											<td colspan="" id="faulty24" style="text-align: right">0</td>
											<td colspan="" id="faulty25" style="text-align: right">0</td>
											<td colspan="" id="faulty26" style="text-align: right">0</td>
											<td colspan="" id="faulty27" style="text-align: right">0</td>
											<td colspan="" id="faulty28" style="text-align: right">0</td>
											<td colspan="" id="faulty29" style="text-align: right">0</td>
											<td colspan="" id="faulty30" style="text-align: right">0</td>
											<td colspan="" id="faulty31" style="text-align: right">0</td>
											<td colspan="" id="faulty32" style="text-align: right">0</td>
											<td colspan="" id="faulty33" style="text-align: right">0</td>
											<td colspan="" id="faulty34" style="text-align: right">0</td>
											<td colspan="" id="faulty35" style="text-align: right">0</td>
											<td colspan="" id="faulty36" style="text-align: right">0</td>
											<td colspan="" id="faulty37" style="text-align: right">0</td>
											<td colspan="" id="faulty38" style="text-align: right">0</td>
											<td colspan="" id="faulty39" style="text-align: right">0</td>
											<td colspan="" id="faulty40" style="text-align: right">0</td>
											<td colspan="" id="faulty41" style="text-align: right">0</td>
											<td colspan="" id="faulty42" style="text-align: right">0</td>
											<td colspan="" id="faulty43" style="text-align: right">0</td>
											<td colspan="" id="faulty44" style="text-align: right">0</td>
											<td colspan="" id="faulty45" style="text-align: right">0</td>
											<td colspan="" id="faulty46" style="text-align: right">0</td>
											<td colspan="" id="faulty47" style="text-align: right">0</td>
											<td colspan="" id="faulty48" style="text-align: right">0</td>
											<td colspan="" id="faulty49" style="text-align: right">0</td>
											<td colspan="" id="faulty50" style="text-align: right">0</td>
											<td colspan="" id="faulty51" style="text-align: right">0</td>
											<td colspan="" id="faulty52" style="text-align: right">0</td>
											<td colspan="" id="faulty53" style="text-align: right">0</td>
											<td colspan="" id="faulty54" style="text-align: right">0</td>
											<td colspan="" id="faulty55" style="text-align: right">0</td>
											<td colspan="" id="faulty56" style="text-align: right">0</td>
											<td colspan="" id="faulty57" style="text-align: right">0</td>
											<td colspan="" id="faulty58" style="text-align: right">0</td>
											<td colspan="" id="faulty59" style="text-align: right">0</td>
											<td colspan="" id="faulty60" style="text-align: right">0</td>
											<td colspan="" id="faulty61" style="text-align: right">0</td>
											<td colspan="" id="faulty62" style="text-align: right">0</td>
											<td colspan="" id="faulty63" style="text-align: right">0</td>
											<td colspan="" id="faulty64" style="text-align: right">0</td>
											<td colspan="" id="faulty65" style="text-align: right">0</td>
											<td colspan="" id="faulty66" style="text-align: right">0</td>
											<td colspan="" id="faulty67" style="text-align: right">0</td>
											<td colspan="" id="faulty68" style="text-align: right">0</td>
											<td colspan="" id="faulty69" style="text-align: right">0</td>
											<td colspan="" id="faulty70" style="text-align: right">0</td>
											<td colspan="" id="faulty71" style="text-align: right">0</td>
											<td colspan="" id="faulty72" style="text-align: right">0</td>
											<td colspan="" id="faulty73" style="text-align: right">0</td>
											<td colspan="" id="faulty74" style="text-align: right">0</td>
											<td colspan="" id="faulty75" style="text-align: right">0</td>
											<td colspan="" id="faulty76" style="text-align: right">0</td>
											<td colspan="" id="faulty77" style="text-align: right">0</td>
											<td colspan="" id="faulty78" style="text-align: right">0</td>
											<td colspan="" id="faulty79" style="text-align: right">0</td>
											<td colspan="" id="faulty80" style="text-align: right">0</td>
											<td colspan="" id="faulty81" style="text-align: right">0</td>
											<td colspan="" id="faulty82" style="text-align: right">0</td>
											<td colspan="" id="faulty83" style="text-align: right">0</td>
											<td colspan="" id="faulty84" style="text-align: right">0</td>
											<td colspan="" id="faulty85" style="text-align: right">0</td>
											<td colspan="" id="faulty86" style="text-align: right">0</td>
											<td colspan="" id="faulty87" style="text-align: right">0</td>
											<td colspan="" id="faulty88" style="text-align: right">0</td>
											<td colspan="" id="faulty89" style="text-align: right">0</td>
											<td colspan="" id="faulty90" style="text-align: right">0</td>
											<td colspan="" id="faulty91" style="text-align: right">0</td>
											<td colspan="" id="faulty92" style="text-align: right">0</td>
											<td colspan="" id="faulty93" style="text-align: right">0</td>
											<td colspan="" id="faulty94" style="text-align: right">0</td>
											<td colspan="" id="faulty95" style="text-align: right">0</td>
											<td colspan="" id="faulty96" style="text-align: right">0</td>
											<td colspan="" id="faulty97" style="text-align: right">0</td>
											<td colspan="" id="faulty98" style="text-align: right">0</td>
											<td colspan="" id="faulty99" style="text-align: right">0</td>
											<td colspan="" id="faulty100" style="text-align: right">0</td>
											<td colspan="" id="faulty101" style="text-align: right">0</td>
											<td colspan="" id="faulty102" style="text-align: right">0</td>
											<td colspan="" id="faulty103" style="text-align: right">0</td>
											<td colspan="" id="faulty104" style="text-align: right">0</td>
											<td colspan="" id="faulty105" style="text-align: right">0</td>
											<td colspan="" id="faulty106" style="text-align: right">0</td>
											<td colspan="" id="faulty107" style="text-align: right">0</td>
											<td colspan="" id="faulty108" style="text-align: right">0</td>
											<td colspan="" id="faulty109" style="text-align: right">0</td>
											<td colspan="" id="faulty110" style="text-align: right">0</td>
											<td colspan="" id="faulty111" style="text-align: right">0</td>
											<td colspan="" id="faulty112" style="text-align: right">0</td>
											<td colspan="" id="faulty113" style="text-align: right">0</td>
											<td colspan="" id="faulty114" style="text-align: right">0</td>
											<td colspan="" id="faulty115" style="text-align: right">0</td>
											<td colspan="" id="faulty116" style="text-align: right">0</td>
											<td colspan="" id="faulty117" style="text-align: right">0</td>
											<td colspan="" id="faulty118" style="text-align: right">0</td>
											<td colspan="" id="faulty119" style="text-align: right">0</td>
											<td colspan="" id="faulty120" style="text-align: right">0</td>
											<td colspan="" id="faulty121" style="text-align: right">0</td>
											<td colspan="" id="faulty122" style="text-align: right">0</td>
											<td colspan="" id="faulty123" style="text-align: right">0</td>
											<td colspan="" id="faulty124" style="text-align: right">0</td>
											<td colspan="" id="faulty125" style="text-align: right">0</td>
											<td colspan="" id="faulty126" style="text-align: right">0</td>
											<td colspan="" id="faulty127" style="text-align: right">0</td>
											<td colspan="" id="faulty128" style="text-align: right">0</td>
											<td colspan="" id="faulty129" style="text-align: right">0</td>
											<td colspan="" id="faulty130" style="text-align: right">0</td>
											<td colspan="" id="faulty131" style="text-align: right">0</td>
											<td colspan="" id="faulty132" style="text-align: right">0</td>
											<td colspan="" id="faulty133" style="text-align: right">0</td>
											<td colspan="" id="faulty134" style="text-align: right">0</td>
											<td colspan="" id="faulty135" style="text-align: right">0</td>
											<td colspan="" id="faulty136" style="text-align: right">0</td>
											<td colspan="" id="faulty137" style="text-align: right">0</td>
											<td colspan="" id="faulty138" style="text-align: right">0</td>
											<td colspan="" id="faulty139" style="text-align: right">0</td>
											<td colspan="" id="faulty140" style="text-align: right">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<!-- /.table-responsive -->
						</div>
						<!-- 외관검사 뷰 끝 -->

						<!--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->

						<!-- 엣지검사 뷰 -->
						<div class="d-none" id="edgeGoodsFaultyView">
							<div class="table-responsive" style="padding-bottom: 10px;">
								<table id="edgeGoodsFaultyTable" class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th rowspan="2" style="min-width: 70px" class="text-center">검사일</th>
											<th rowspan="2" style="min-width: 55px" class="text-center">검사자</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">검사수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">양품수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">불량수량</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">불량률(%)</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">생산일</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">설비명</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">작지번호</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">생산LotNo</th>
											<th rowspan="2" style="min-width: 130px" class="text-center">생산전표번호</th>
											<th rowspan="2" style="min-width: 40px" class="text-center">주야</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">생산<br>작업자
											</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">제품</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">재질</th>
											<th rowspan="2" style="min-width: 200px" class="text-center">규격</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">주자재</th>
											<th colspan="13" style="min-width: 70px;" class="text-center"
												class="text-center" id="edgeHd">메탈부 불량</th>
											<th colspan="13" style="min-width: 70px;" class="text-center"
												class="text-center" id="edgeHd2">메탈부 불량</th>
											<!-- <th colspan="19" style="min-width: 70px;" class="text-center" class="text-center">기타 불량</th> -->
										</tr>
										<tr id="edgeAppearHeader"></tr>
									<tfoot>
										<tr>
											<td colspan="2" style="text-align: center">합계</td>
											<td colspan="" id="edgeSumOutputCnt"
												style="text-align: right">0</td>
											<td colspan="" id="edgeSumAppearOutputCnt"
												style="text-align: right">0</td>
											<td colspan="" id="edgeSumFaulty" style="text-align: right">0</td>
											<td colspan="" id="edgeSumFaultyPercent"
												style="text-align: right">0</td>
											<td colspan="11"></td>
											<td colspan="" id="edgeFaulty1" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty2" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty3" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty4" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty5" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty6" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty7" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty8" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty9" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty10" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty11" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty12" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty13" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty14" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty15" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty16" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty17" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty18" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty19" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty20" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty21" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty22" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty23" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty24" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty25" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty26" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty27" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty28" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty29" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty30" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty31" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty32" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty33" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty34" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty35" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty36" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty37" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty38" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty39" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty40" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty41" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty42" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty43" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty44" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty45" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty46" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty47" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty48" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty49" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty50" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty51" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty52" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty53" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty54" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty55" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty56" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty57" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty58" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty59" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty60" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty61" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty62" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty63" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty64" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty65" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty66" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty67" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty68" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty69" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty70" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty71" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty72" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty73" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty74" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty75" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty76" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty77" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty78" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty79" style="text-align: right">0</td>
											<td colspan="" id="edgeFaulty80" style="text-align: right">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<!-- /.table-responsive -->
						</div>
						<!-- 엣지검사 뷰 끝 -->
						<!-- 작지번호별 뷰 시작 -->
						<div id="workOrderView">
							<div class="table-responsive" style="padding-bottom: 10px;">
								<table id="workOrderTable" class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th rowspan="2" style="min-width: 70px" class="text-center">작업지시일</th>
											<!-- <th rowspan="2"style="min-width: 55px" class="text-center">검사자</th> -->
											<th rowspan="2" style="min-width: 50px" class="text-center">검사수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">양품수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">불량수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">생산<br>비전불량</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">불량률(%)</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">생산일</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">설비명</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">작지번호</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">생산LotNo</th>
											<!-- <th rowspan="2"style="min-width: 130px"class="text-center">생산전표번호</th>
										<th rowspan="2"style="min-width: 40px" class="text-center">주야</th>
										<th rowspan="2"style="min-width: 50px" class="text-center">생산<br>작업자</th> -->
											<th rowspan="2" style="min-width: 50px" class="text-center">제품</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">재질</th>
											<th rowspan="2" style="min-width: 200px" class="text-center">규격</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">주자재</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">부자재1</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">부자재2</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">부자재3</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">부자재4</th>
											<th colspan="13" style="min-width: 70px;" class="text-center"
												class="text-center" id="workOrderMetalHd">메탈부 불량</th>
											<th colspan="15" style="min-width: 70px;" class="text-center"
												class="text-center" id="workOrderFilmHd">필름부 불량</th>
											<!-- <th colspan="2" style="min-width: 70px;" class="text-center"
												class="text-center" id="workOrderVisonHd">비전부 불량</th>
											<th colspan="2" style="min-width: 70px;" class="text-center"
												class="text-center" id="workOrderFiveHd">5 부불량</th> -->
										</tr>
										<tr id="workOrderHeader"></tr>
									<tfoot>
										<tr>
											<td colspan="1" style="text-align: center">합계</td>
											<td colspan="" id="workOrderSumOutputCnt"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderSumAppearOutputCnt"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderSumFaulty"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderSumVisionFaulty"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderSumFaultyPercent"
												style="text-align: right">0</td>
											<td colspan="12"></td>
											<td colspan="" id="workOrderFaulty1"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty2"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty3"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty4"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty5"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty6"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty7"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty8"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty9"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty10"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty11"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty12"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty13"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty14"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty15"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty16"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty17"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty18"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty19"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty20"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty21"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty22"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty23"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty24"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty25"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty26"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty27"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty28"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty29"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty30"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty31"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty32"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty33"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty34"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty35"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty36"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty37"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty38"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty39"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty40"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty41"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty42"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty43"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty44"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty45"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty46"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty47"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty48"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty49"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty50"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty51"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty52"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty53"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty54"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty55"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty56"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty57"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty58"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty59"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty60"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty61"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty62"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty63"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty64"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty65"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty66"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty67"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty68"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty69"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty70"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty71"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty72"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty73"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty74"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty75"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty76"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty77"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty78"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty79"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty80"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty81"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty82"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty83"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty84"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty85"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty86"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty87"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty88"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty89"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty90"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty91"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty92"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty93"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty94"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty95"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty96"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty97"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty98"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty99"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty100"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty101"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty102"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty103"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty104"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty105"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty106"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty107"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty108"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty109"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty110"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty111"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty112"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty113"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty114"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty115"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty116"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty117"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty118"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty119"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty120"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty121"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty122"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty123"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty124"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty125"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty126"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty127"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty128"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty129"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty130"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty131"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty132"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty133"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty134"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty135"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty136"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty137"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty138"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty139"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderFaulty140"
												style="text-align: right">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<!-- /.table-responsive -->
						</div>
						<!-- 엣지검사 뷰 끝 -->

					</div>
				</div><!-- /.left-list -->
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div>
<!-- /.page-wrapper -->
<!-- 삭제 모달 -->
<div class="modal fade bd-example-modal-lg" id="boxNoTraceModal" tabindex="-1" role="dialog" aria-labelledby="userPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width:1800px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">포장번호</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="boxNoTraceTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th class="text-center" style="min-width:80px;">포장일</th>
							<th class="text-center" style="min-width:110px;">작지 번호</th>
							<th class="text-center" style="min-width:110px;">생산LotNo</th>
							<th class="text-center" style="min-width:110px;">BOX NO</th>
							<th class="text-center" style="min-width:80px;">제품코드</th>
							<th class="text-center" style="min-width:100px;">제품명</th>
							<th class="text-center" style="min-width:100px;">오더구분</th>
							<th class="text-center" style="min-width:70px;">포장 수량</th>
							<th class="text-center" style="min-width:70px;">잔여 수량</th>
							<th class="text-center" style="min-width:70px;">포장 단위</th>
							<th class="text-center" style="min-width:70px;">제품 상태</th>
							<th class="text-center" style="min-width:70px;">불량 상태</th>
							<th class="text-center" style="min-width:70px;">재분할</th>
							<th class="text-center" style="min-width:70px;">불량일</th>
							<th class="text-center" style="min-width:200px;">불량 유형</th>
							<th class="text-center" style="min-width:100px;">비고</th>
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

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'qmsc3080';
	let currentHref = 'qmsc3080';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","최종검사현황");

	//공통코드 처리 시작
    var goodsFaultyType=new Array();	//제품불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>

	var goodsFaultyBigNameCd=new Array();	//외관검사 대분류
    <c:forEach items="${goodsFaultyBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyBigNameCd.push(json);
    </c:forEach>

	var systemCommonCode=new Array();	//외관검사 소분류
    <c:forEach items="${systemCommonCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";		
		systemCommonCode.push(json);
    </c:forEach>

	var edgeBigNameCd=new Array();	//엣지검사 대분류
    <c:forEach items="${edgeBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		edgeBigNameCd.push(json);
    </c:forEach>

	var edgeGoodsFaultyCode=new Array();	//엣지검사 소분류
    <c:forEach items="${edgeGoodsFaultyCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";		
		edgeGoodsFaultyCode.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    
    //외관대분류명
   	$('#metalHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmHd').text(goodsFaultyBigNameCd[1].baseCdNm);
	//$('#visonHd').text(goodsFaultyBigNameCd[3].baseCdNm);
	//$('#fiveHd').text(goodsFaultyBigNameCd[4].baseCdNm);
	//$('#sixHd').text(goodsFaultyBigNameCd[5].baseCdNm);
	
    //엣지대분류명
   	$('#edgeHd').text(edgeBigNameCd[0].baseCdNm);
	$('#edgeHd2').text(edgeBigNameCd[1].baseCdNm);
	
	//작지번호별 대분류명
   	$('#workOrderMetalHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#workOrderFilmHd').text(goodsFaultyBigNameCd[1].baseCdNm);
	//$('#workOrderVisonHd').text(goodsFaultyBigNameCd[3].baseCdNm);
	//$('#workOrderFiveHd').text(goodsFaultyBigNameCd[4].baseCdNm);

	let tabView = 'tabView3';
    //탭 1클릭 시
   	$('#tab1').click(function() {
   	   	//화면 
		$('#goodsFaultyView').removeClass("d-none");
		$('#goodsFaultyDateLookup').removeClass("d-none");
		$('#workOrderDateLokkup').addClass("d-none");
		$('#workOrderView').addClass("d-none");
		$('#edgeGoodsFaultyDateLookup').addClass("d-none");
		$('#edgeGoodsFaultyView').addClass("d-none");
		// 버튼
		$('#btnPackingNumberInquiry').removeClass("d-none");
		$('#workOrderGubun').addClass("d-none");
		$('#workOrderGubunLabel').addClass("d-none");
		// 검색기
		$("#faultyStatsDay_filter").removeClass("d-none");
		$("#edgeGoodsFaultyTable_filter").addClass("d-none");
		$("#workOrderTable_filter").addClass("d-none");
		// 리로드
		chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		userNumber	= $('#preWorkCharger').val();
 		$('#faultyStatsDay').DataTable().ajax.reload();
 		tabView = 'tabView1';
	});

	//탭 2클릭 시
	$('#tab2').click(function() {
		$('#edgeGoodsFaultyView').removeClass("d-none");
		$('#edgeGoodsFaultyDateLookup').removeClass("d-none");
		$('#workOrderDateLokkup').addClass("d-none");
		$('#workOrderView').addClass("d-none");
		$('#goodsFaultyDateLookup').addClass("d-none");
		$('#goodsFaultyView').addClass("d-none");
		
		$('#btnPackingNumberInquiry').addClass("d-none");
		$('#workOrderGubun').addClass("d-none");
		$('#workOrderGubunLabel').addClass("d-none");

		$("#faultyStatsDay_filter").addClass("d-none");
		$("#edgeGoodsFaultyTable_filter").removeClass("d-none");
		$("#workOrderTable_filter").addClass("d-none");

		chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		userNumber	= $('#preWorkCharger').val();
 		$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
 		tabView = 'tabView2';
	});
	
	//탭 3클릭 시
	$('#tab3').click(function() {
		$('#workOrderView').removeClass("d-none");
		$('#workOrderDateLokkup').removeClass("d-none");		
		$('#goodsFaultyDateLookup').addClass("d-none");
		$('#goodsFaultyView').addClass("d-none");
		$('#edgeGoodsFaultyDateLookup').addClass("d-none");
		$('#edgeGoodsFaultyView').addClass("d-none");
		
		$('#btnPackingNumberInquiry').removeClass("d-none");
		$('#workOrderGubun').removeClass("d-none");
		$('#workOrderGubunLabel').removeClass("d-none");
		
		$("#faultyStatsDay_filter").addClass("d-none");
		$("#edgeGoodsFaultyTable_filter").addClass("d-none");
		$("#workOrderTable_filter").removeClass("d-none");

		chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		userNumber	= $('#preWorkCharger').val();
		$('#workOrderTable').DataTable().ajax.reload();
		tabView = 'tabView3';

	});
	
	var chooseDate1 		= "${serverDateFrom}";
	var chooseDate2 		= "${serverDate}";
	var showType 			= "showType001";
	//var sumOutputCnt		= 0;
	//var sumAppearOutputCnt	= 0;
	//var sumFaulty 			= 0;
	var userNumber 			= null;
	var workOrdNo 			= "empty";
	var workOrdLotNo		= "empty";
	
	appearHeaderCreate();			//외관검사
	edgeAppearHeaderCreate();		//엣지검사
	workOrderAppearHeaderCreate();  //작지번호별
	
	//외관 목록
	$.fn.dataTable.ext.errMode = 'none';
	let faultyStatsDay = $('#faultyStatsDay').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/faultyTotalDataList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
            },
        },
		//rowId: 'workOrdNo',
        columns: [
			{
				render: function(data, type, row) {
					return moment(row['appearInspctDate']).format('YYYY-MM-DD');
				}
			},//검사일
        	{data:'appearInspctChargerNm'},//검사자
        	{data:'userInputInspctCnt'},//검사수량
        	{data:'appearOutputCnt'},//양품수량
        	//{
        	//	render: function(data, type, row) {
        	//		return addCommas(parseInt(row['userInputInspctCnt']-row['appearOutputCnt']));
			//	}
        	//},
        	{data:'appearFaultyCnt'},//불량수량
        	{
        		render: function(data, type, row) {
        			return parseFloat((parseInt(row['appearFaultyCnt']))/row['userInputInspctCnt']*100).toFixed(2) + " %";
				}
        	},//불량률
        	{
        		render: function(data, type, row) {
					return moment(row['ordDate']).format('YYYY-MM-DD');
        		}
			},//생산일
        	{data:'equipNm'},//설비명
        	{data:'workOrdNo'},//작지번호
        	{data:'workOrdLotNo'},//생산lotNo
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
			},//생산전표번호
			{ data: 'ordGubunNm',
				render: function(data, type, row) {
					var html = '';
					if( row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					
					return html;
				}
			},//주야
        	{data:'mainWorkChargrNm'},//생산작업자
        	{data:'goodsNm'},//제품
        	{data:'qutyNm'},//재질
        	{data:'model'},//규격
        	{data:'lotNo'},//주자재
        	{ data: 'faulty1',
        		render: function(data, type, row) {
            		if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty2',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty3',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty4',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty5',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty6',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty7',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty8',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty9',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty10',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty11',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty12',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty13',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty14',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty15',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty16',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty17',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty18',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty19',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty20',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty21',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty22',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty23',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty24',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty25',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty26',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty27',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty28',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty29',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty30',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty31',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty32',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty33',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty34',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty35',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty36',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty37',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty38',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty39',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty40',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty41',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty42',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty43',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty44',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty45',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty46',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty47',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty48',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty49',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty50',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty51',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty52',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty53',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty54',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty55',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty56',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty57',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty58',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty59',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty60',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty61',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty62',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty63',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty64',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty65',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty66',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty67',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty68',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty69',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty70',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty71',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty72',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {						
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty73',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty74',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty75',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty76',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty77',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty78',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty79',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty80',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty81',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty82',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty83',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty84',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty85',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty86',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty87',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty88',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty89',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty90',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty91',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty92',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty93',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty94',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty95',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty96',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty97',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty98',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty99',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty100',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty101',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty102',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty103',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty104',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty105',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty106',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty107',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty108',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty109',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty110',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty111',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty112',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty113',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty114',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty115',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty116',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty117',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty118',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty119',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty120',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty121',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty122',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty123',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty124',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty125',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty126',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty127',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty128',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty129',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty130',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty131',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty132',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty133',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty134',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty135',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty136',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty137',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty138',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty139',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty140',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	

        ],
        buttons: [
            {
                extend: 'copy',
                title: '최종검사현황-외관검사',
            },
            {
				extend: 'excel',
				title: '최종검사현황-외관검사',
				exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (row == 10 || row == 11) {
								data = data.replace('<p style="color:red; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('<p style="color:blue; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('</p>', '');
								return data;
							}
							if (showType == 'showType001') {
								if (row == 5) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 5) { return data.replace(" %", ""); }
								else if (row == 17) { return data.replace(" %", ""); }
								else if (row == 18) { return data.replace(" %", ""); }
								else if (row == 19) { return data.replace(" %", ""); }
								else if (row == 20) { return data.replace(" %", ""); }
								else if (row == 21) { return data.replace(" %", ""); }
								else if (row == 22) { return data.replace(" %", ""); }
								else if (row == 23) { return data.replace(" %", ""); }
								else if (row == 24) { return data.replace(" %", ""); }
								else if (row == 25) { return data.replace(" %", ""); }
								else if (row == 26) { return data.replace(" %", ""); }
								else if (row == 27) { return data.replace(" %", ""); }
								else if (row == 28) { return data.replace(" %", ""); }
								else if (row == 29) { return data.replace(" %", ""); }
								else if (row == 30) { return data.replace(" %", ""); }
								else if (row == 31) { return data.replace(" %", ""); }
								else if (row == 32) { return data.replace(" %", ""); }
								else if (row == 33) { return data.replace(" %", ""); }
								else if (row == 34) { return data.replace(" %", ""); }
								else if (row == 35) { return data.replace(" %", ""); }
								else if (row == 36) { return data.replace(" %", ""); }
								else if (row == 37) { return data.replace(" %", ""); }
								else if (row == 38) { return data.replace(" %", ""); }
								else if (row == 39) { return data.replace(" %", ""); }
								else if (row == 40) { return data.replace(" %", ""); }
								else if (row == 41) { return data.replace(" %", ""); }
								else if (row == 42) { return data.replace(" %", ""); }
								else if (row == 43) { return data.replace(" %", ""); }
								else if (row == 44) { return data.replace(" %", ""); }
								else if (row == 45) { return data.replace(" %", ""); }
								else if (row == 46) { return data.replace(" %", ""); }
								else if (row == 47) { return data.replace(" %", ""); }
								else if (row == 48) { return data.replace(" %", ""); }
								else if (row == 49) { return data.replace(" %", ""); }
								else if (row == 50) { return data.replace(" %", ""); }
								else if (row == 51) { return data.replace(" %", ""); }
								else if (row == 52) { return data.replace(" %", ""); }
								else if (row == 53) { return data.replace(" %", ""); }
								else if (row == 54) { return data.replace(" %", ""); }
								else if (row == 55) { return data.replace(" %", ""); }
								else if (row == 56) { return data.replace(" %", ""); }
								else if (row == 57) { return data.replace(" %", ""); }
								else if (row == 58) { return data.replace(" %", ""); }
								else if (row == 59) { return data.replace(" %", ""); }
								else if (row == 60) { return data.replace(" %", ""); }
								else if (row == 61) { return data.replace(" %", ""); }
								else if (row == 62) { return data.replace(" %", ""); }
								else if (row == 63) { return data.replace(" %", ""); }
								else if (row == 64) { return data.replace(" %", ""); }
								else if (row == 65) { return data.replace(" %", ""); }
								else if (row == 66) { return data.replace(" %", ""); }							
								else if (row == 67) { return data.replace(" %", ""); }
								else if (row == 68) { return data.replace(" %", ""); }
								else if (row == 69) { return data.replace(" %", ""); }
								else if (row == 70) { return data.replace(" %", ""); }
								else if (row == 71) { return data.replace(" %", ""); }
								else if (row == 72) { return data.replace(" %", ""); }
								else if (row == 73) { return data.replace(" %", ""); }
								else if (row == 74) { return data.replace(" %", ""); }
								else if (row == 75) { return data.replace(" %", ""); }
								else if (row == 76) { return data.replace(" %", ""); }
								else if (row == 77) { return data.replace(" %", ""); }
								else if (row == 78) { return data.replace(" %", ""); }
								else if (row == 79) { return data.replace(" %", ""); }
								else if (row == 80) { return data.replace(" %", ""); }
								else if (row == 81) { return data.replace(" %", ""); }
								else if (row == 82) { return data.replace(" %", ""); }
								else if (row == 83) { return data.replace(" %", ""); }
								else if (row == 84) { return data.replace(" %", ""); }
								else if (row == 85) { return data.replace(" %", ""); }
								else if (row == 86) { return data.replace(" %", ""); }
								else if (row == 87) { return data.replace(" %", ""); }
								else if (row == 88) { return data.replace(" %", ""); }
								else if (row == 89) { return data.replace(" %", ""); }
								else if (row == 90) { return data.replace(" %", ""); }
								else if (row == 91) { return data.replace(" %", ""); }
								else if (row == 92) { return data.replace(" %", ""); }
								else if (row == 93) { return data.replace(" %", ""); }
								else if (row == 94) { return data.replace(" %", ""); }
								else if (row == 95) { return data.replace(" %", ""); }
								else if (row == 96) { return data.replace(" %", ""); }
								else if (row == 97) { return data.replace(" %", ""); }
								else if (row == 98) { return data.replace(" %", ""); }
								else if (row == 99) { return data.replace(" %", ""); }
								else if (row == 100) { return data.replace(" %", ""); }
								else if (row == 101) { return data.replace(" %", ""); }
								else if (row == 102) { return data.replace(" %", ""); }
								else if (row == 103) { return data.replace(" %", ""); }
								else if (row == 104) { return data.replace(" %", ""); }
								else if (row == 105) { return data.replace(" %", ""); }
								else if (row == 106) { return data.replace(" %", ""); }
								else if (row == 107) { return data.replace(" %", ""); }
								else if (row == 108) { return data.replace(" %", ""); }
								else if (row == 109) { return data.replace(" %", ""); }
								else if (row == 110) { return data.replace(" %", ""); }
								else if (row == 111) { return data.replace(" %", ""); }
								else if (row == 112) { return data.replace(" %", ""); }
								else if (row == 113) { return data.replace(" %", ""); }
								else if (row == 114) { return data.replace(" %", ""); }
								else if (row == 115) { return data.replace(" %", ""); }
								else if (row == 116) { return data.replace(" %", ""); }
								else if (row == 117) { return data.replace(" %", ""); }
								else if (row == 118) { return data.replace(" %", ""); }
								else if (row == 119) { return data.replace(" %", ""); }
								else if (row == 120) { return data.replace(" %", ""); }
								else if (row == 121) { return data.replace(" %", ""); }
								else if (row == 122) { return data.replace(" %", ""); }
								else if (row == 123) { return data.replace(" %", ""); }
								else if (row == 124) { return data.replace(" %", ""); }
								else if (row == 125) { return data.replace(" %", ""); }
								else if (row == 126) { return data.replace(" %", ""); }
								else if (row == 127) { return data.replace(" %", ""); }
								else if (row == 128) { return data.replace(" %", ""); }
								else if (row == 129) { return data.replace(" %", ""); }
								else if (row == 130) { return data.replace(" %", ""); }
								else if (row == 131) { return data.replace(" %", ""); }
								else if (row == 132) { return data.replace(" %", ""); }
								else if (row == 133) { return data.replace(" %", ""); }
								else if (row == 134) { return data.replace(" %", ""); }
								else if (row == 135) { return data.replace(" %", ""); }
								else if (row == 136) { return data.replace(" %", ""); }
								else if (row == 137) { return data.replace(" %", ""); }
								else if (row == 138) { return data.replace(" %", ""); }
								else if (row == 139) { return data.replace(" %", ""); }
								else if (row == 140) { return data.replace(" %", ""); }
								else if (row == 141) { return data.replace(" %", ""); }
								else if (row == 142) { return data.replace(" %", ""); }
								else if (row == 143) { return data.replace(" %", ""); }
								else if (row == 144) { return data.replace(" %", ""); }
								else if (row == 145) { return data.replace(" %", ""); }
								else if (row == 146) { return data.replace(" %", ""); }
								else if (row == 147) { return data.replace(" %", ""); }
								else if (row == 148) { return data.replace(" %", ""); }
								else if (row == 149) { return data.replace(" %", ""); }
								else if (row == 150) { return data.replace(" %", ""); }
								else if (row == 151) { return data.replace(" %", ""); }
								else if (row == 152) { return data.replace(" %", ""); }
								else if (row == 153) { return data.replace(" %", ""); }
								else if (row == 154) { return data.replace(" %", ""); }
								else if (row == 155) { return data.replace(" %", ""); }
								else if (row == 156) { return data.replace(" %", ""); }
								else { return data; }
							}
						}
				    }
				}
            },
            {
                extend: 'print',
                title: '최종검사현황-외관검사',
            },
        ],
		columnDefs: [
			{ targets: [2,3,4,5,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [2,3,4,5,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], className: 'text-right' },
		],
		drawCallback: function () {
			$('#faultyStatsDay').attr('style', 'margin-top: -1px !important;');
			
			$.each($('#faultyStatsDay tbody tr'),function(index,item) {
				if ($('#faultyStatsDay .0').text() == "") {
					$('#faultyStatsDay .0').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(6).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .1').text() == "") {
					$('#faultyStatsDay .1').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(7).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .2').text() == "") {
					$('#faultyStatsDay .2').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(8).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .3').text() == "") {
					$('#faultyStatsDay .3').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(9).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .4').text() == "") {
					$('#faultyStatsDay .4').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(10).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .5').text() == "") {
					$('#faultyStatsDay .5').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(11).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .6').text() == "") {
					$('#faultyStatsDay .6').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(12).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .7').text() == "") {
					$('#faultyStatsDay .7').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(13).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .8').text() == "") {
					$('#faultyStatsDay .8').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(14).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .9').text() == "") {
					$('#faultyStatsDay .9').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(15).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .10').text() == "") {
					$('#faultyStatsDay .10').addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(16).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .11').text() == "") {
					$('#faultyStatsDay .11').addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(17).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .12').text() == "") {
					$('#faultyStatsDay .12').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(18).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .13').text() == "") {
					$('#faultyStatsDay .13').addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(19).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .14').text() == "") {
					$('#faultyStatsDay .14').addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(20).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .15').text() == "") {
					$('#faultyStatsDay .15').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(21).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .16').text() == "") {
					$('#faultyStatsDay .16').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(22).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .17').text() == "") {
					$('#faultyStatsDay .17').addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(23).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .18').text() == "") {
					$('#faultyStatsDay .18').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(24).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .19').text() == "") {
					$('#faultyStatsDay .19').addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(25).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .20').text() == "") {
					$('#faultyStatsDay .20').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(26).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .21').text() == "") {
					$('#faultyStatsDay .21').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(27).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .22').text() == "") {
					$('#faultyStatsDay .22').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(28).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .23').text() == "") {
					$('#faultyStatsDay .23').addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(29).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .24').text() == "") {
					$('#faultyStatsDay .24').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(30).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .25').text() == "") {
					$('#faultyStatsDay .25').addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(31).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .26').text() == "") {
					$('#faultyStatsDay .26').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(32).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .27').text() == "") {
					$('#faultyStatsDay .27').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(33).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .28').text() == "") {
					$('#faultyStatsDay .28').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(34).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .29').text() == "") {
					$('#faultyStatsDay .29').addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(35).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .30').text() == "") {
					$('#faultyStatsDay .30').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(36).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .31').text() == "") {
					$('#faultyStatsDay .31').addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(37).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .32').text() == "") {
					$('#faultyStatsDay .32').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(38).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .33').text() == "") {
					$('#faultyStatsDay .33').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(39).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .34').text() == "") {
					$('#faultyStatsDay .34').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(40).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .35').text() == "") {
					$('#faultyStatsDay .35').addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(41).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .36').text() == "") {
					$('#faultyStatsDay .36').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(42).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .37').text() == "") {
					$('#faultyStatsDay .37').addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(43).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .38').text() == "") {
					$('#faultyStatsDay .38').addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(44).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .39').text() == "") {
					$('#faultyStatsDay .39').addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(45).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .40').text() == "") {
					$('#faultyStatsDay .40').addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(46).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .41').text() == "") {
					$('#faultyStatsDay .41').addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(47).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .42').text() == "") {
					$('#faultyStatsDay .42').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(48).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .43').text() == "") {
					$('#faultyStatsDay .43').addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(49).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .44').text() == "") {
					$('#faultyStatsDay .44').addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(50).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .45').text() == "") {
					$('#faultyStatsDay .45').addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(51).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .46').text() == "") {
					$('#faultyStatsDay .46').addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(52).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .47').text() == "") {
					$('#faultyStatsDay .47').addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(53).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .48').text() == "") {
					$('#faultyStatsDay .48').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(54).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .49').text() == "") {
					$('#faultyStatsDay .49').addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(55).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .50').text() == "") {
					$('#faultyStatsDay .50').addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(56).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .51').text() == "") {
					$('#faultyStatsDay .51').addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(57).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .52').text() == "") {
					$('#faultyStatsDay .52').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(58).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .53').text() == "") {
					$('#faultyStatsDay .53').addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(59).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .54').text() == "") {
					$('#faultyStatsDay .54').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(60).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .55').text() == "") {
					$('#faultyStatsDay .55').addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(61).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .56').text() == "") {
					$('#faultyStatsDay .56').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(62).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .57').text() == "") {
					$('#faultyStatsDay .57').addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(63).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .58').text() == "") {
					$('#faultyStatsDay .58').addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(64).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .59').text() == "") {
					$('#faultyStatsDay .59').addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(65).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .60').text() == "") {
					$('#faultyStatsDay .60').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(66).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .61').text() == "") {
					$('#faultyStatsDay .61').addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(67).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .62').text() == "") {
					$('#faultyStatsDay .62').addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(68).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .63').text() == "") {
					$('#faultyStatsDay .63').addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(69).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .64').text() == "") {
					$('#faultyStatsDay .64').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(70).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .65').text() == "") {
					$('#faultyStatsDay .65').addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(71).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .66').text() == "") {
					$('#faultyStatsDay .66').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(72).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .67').text() == "") {
					$('#faultyStatsDay .67').addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(73).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .68').text() == "") {
					$('#faultyStatsDay .68').addClass('d-none');
					$(this).find('td').eq(85).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(74).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .69').text() == "") {
					$('#faultyStatsDay .69').addClass('d-none');
					$(this).find('td').eq(86).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(75).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .70').text() == "") {
					$('#faultyStatsDay .70').addClass('d-none');
					$(this).find('td').eq(87).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(76).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .71').text() == "") {
					$('#faultyStatsDay .71').addClass('d-none');
					$(this).find('td').eq(88).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(77).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .72').text() == "") {
					$('#faultyStatsDay .72').addClass('d-none');
					$(this).find('td').eq(89).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(78).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .73').text() == "") {
					$('#faultyStatsDay .73').addClass('d-none');
					$(this).find('td').eq(90).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(79).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .74').text() == "") {
					$('#faultyStatsDay .74').addClass('d-none');
					$(this).find('td').eq(91).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(80).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .75').text() == "") {
					$('#faultyStatsDay .75').addClass('d-none');
					$(this).find('td').eq(92).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(81).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .76').text() == "") {
					$('#faultyStatsDay .76').addClass('d-none');
					$(this).find('td').eq(93).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(82).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .77').text() == "") {
					$('#faultyStatsDay .77').addClass('d-none');
					$(this).find('td').eq(94).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(83).addClass('d-none');
					
				}
				if ($('#faultyStatsDay .78').text() == "") {
					$('#faultyStatsDay .78').addClass('d-none');
					$(this).find('td').eq(95).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(84).addClass('d-none');
				}
				if ($('#faultyStatsDay .79').text() == "") {
					$('#faultyStatsDay .79').addClass('d-none');
					$(this).find('td').eq(96).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(85).addClass('d-none');
				}
				if ($('#faultyStatsDay .80').text() == "") {
					$('#faultyStatsDay .80').addClass('d-none');
					$(this).find('td').eq(97).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(86).addClass('d-none');
				}
				if ($('#faultyStatsDay .81').text() == "") {
					$('#faultyStatsDay .81').addClass('d-none');
					$(this).find('td').eq(98).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(87).addClass('d-none');
				}
				if ($('#faultyStatsDay .82').text() == "") {
					$('#faultyStatsDay .82').addClass('d-none');
					$(this).find('td').eq(99).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(88).addClass('d-none');
				}
				if ($('#faultyStatsDay .83').text() == "") {
					$('#faultyStatsDay .83').addClass('d-none');
					$(this).find('td').eq(100).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(89).addClass('d-none');
				}
				if ($('#faultyStatsDay .84').text() == "") {
					$('#faultyStatsDay .84').addClass('d-none');
					$(this).find('td').eq(101).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(90).addClass('d-none');
				}
				if ($('#faultyStatsDay .85').text() == "") {
					$('#faultyStatsDay .85').addClass('d-none');
					$(this).find('td').eq(102).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(91).addClass('d-none');
				}
				if ($('#faultyStatsDay .86').text() == "") {
					$('#faultyStatsDay .86').addClass('d-none');
					$(this).find('td').eq(103).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(92).addClass('d-none');
				}
				if ($('#faultyStatsDay .87').text() == "") {
					$('#faultyStatsDay .87').addClass('d-none');
					$(this).find('td').eq(104).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(93).addClass('d-none');
				}
				if ($('#faultyStatsDay .88').text() == "") {
					$('#faultyStatsDay .88').addClass('d-none');
					$(this).find('td').eq(105).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(94).addClass('d-none');
				}	
				if ($('#faultyStatsDay .89').text() == "") {
					$('#faultyStatsDay .89').addClass('d-none');
					$(this).find('td').eq(106).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(95).addClass('d-none');
				}
				if ($('#faultyStatsDay .90').text() == "") {
					$('#faultyStatsDay .90').addClass('d-none');
					$(this).find('td').eq(107).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(96).addClass('d-none');
				}
				if ($('#faultyStatsDay .91').text() == "") {
					$('#faultyStatsDay .91').addClass('d-none');
					$(this).find('td').eq(108).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(97).addClass('d-none');
				}
				if ($('#faultyStatsDay .92').text() == "") {
					$('#faultyStatsDay .92').addClass('d-none');
					$(this).find('td').eq(109).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(98).addClass('d-none');
				}
				if ($('#faultyStatsDay .93').text() == "") {
					$('#faultyStatsDay .93').addClass('d-none');
					$(this).find('td').eq(110).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(99).addClass('d-none');
				}
				if ($('#faultyStatsDay .94').text() == "") {
					$('#faultyStatsDay .94').addClass('d-none');
					$(this).find('td').eq(111).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(100).addClass('d-none');
				}
				if ($('#faultyStatsDay .95').text() == "") {
					$('#faultyStatsDay .95').addClass('d-none');
					$(this).find('td').eq(112).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(101).addClass('d-none');
				}
				if ($('#faultyStatsDay .96').text() == "") {
					$('#faultyStatsDay .96').addClass('d-none');
					$(this).find('td').eq(113).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(102).addClass('d-none');
				}
				if ($('#faultyStatsDay .97').text() == "") {
					$('#faultyStatsDay .97').addClass('d-none');
					$(this).find('td').eq(114).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(103).addClass('d-none');
				}
				if ($('#faultyStatsDay .98').text() == "") {
					$('#faultyStatsDay .98').addClass('d-none');
					$(this).find('td').eq(115).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(104).addClass('d-none');
				}
				if ($('#faultyStatsDay .99').text() == "") {
					$('#faultyStatsDay .99').addClass('d-none');
					$(this).find('td').eq(116).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(105).addClass('d-none');
				}
				if ($('#faultyStatsDay .100').text() == "") {
					$('#faultyStatsDay .100').addClass('d-none');
					$(this).find('td').eq(117).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(106).addClass('d-none');
				}
				if ($('#faultyStatsDay .101').text() == "") {
					$('#faultyStatsDay .101').addClass('d-none');
					$(this).find('td').eq(118).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(107).addClass('d-none');
				}
				if ($('#faultyStatsDay .102').text() == "") {
					$('#faultyStatsDay .102').addClass('d-none');
					$(this).find('td').eq(119).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(108).addClass('d-none');
				}
				if ($('#faultyStatsDay .103').text() == "") {
					$('#faultyStatsDay .103').addClass('d-none');
					$(this).find('td').eq(120).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(109).addClass('d-none');
				}
				if ($('#faultyStatsDay .104').text() == "") {
					$('#faultyStatsDay .104').addClass('d-none');
					$(this).find('td').eq(121).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(110).addClass('d-none');
				}
				if ($('#faultyStatsDay .105').text() == "") {
					$('#faultyStatsDay .105').addClass('d-none');
					$(this).find('td').eq(122).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(111).addClass('d-none');
				}
				if ($('#faultyStatsDay .106').text() == "") {
					$('#faultyStatsDay .106').addClass('d-none');
					$(this).find('td').eq(123).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(112).addClass('d-none');
				}
				if ($('#faultyStatsDay .107').text() == "") {
					$('#faultyStatsDay .107').addClass('d-none');
					$(this).find('td').eq(124).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(113).addClass('d-none');
				}
				if ($('#faultyStatsDay .108').text() == "") {
					$('#faultyStatsDay .108').addClass('d-none');
					$(this).find('td').eq(125).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(114).addClass('d-none');
				}
				if ($('#faultyStatsDay .109').text() == "") {
					$('#faultyStatsDay .109').addClass('d-none');
					$(this).find('td').eq(126).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(115).addClass('d-none');
				}
				if ($('#faultyStatsDay .110').text() == "") {
					$('#faultyStatsDay .110').addClass('d-none');
					$(this).find('td').eq(127).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(116).addClass('d-none');
				}





				

				if ($('#faultyStatsDay .111').text() == "") {
					$('#faultyStatsDay .111').addClass('d-none');
					$(this).find('td').eq(128).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(117).addClass('d-none');
				}
				if ($('#faultyStatsDay .112').text() == "") {
					$('#faultyStatsDay .112').addClass('d-none');
					$(this).find('td').eq(129).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(118).addClass('d-none');
				}
				if ($('#faultyStatsDay .113').text() == "") {
					$('#faultyStatsDay .113').addClass('d-none');
					$(this).find('td').eq(130).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(119).addClass('d-none');
				}
				if ($('#faultyStatsDay .114').text() == "") {
					$('#faultyStatsDay .114').addClass('d-none');
					$(this).find('td').eq(131).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(120).addClass('d-none');
				}
				if ($('#faultyStatsDay .115').text() == "") {
					$('#faultyStatsDay .115').addClass('d-none');
					$(this).find('td').eq(132).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(121).addClass('d-none');
				}
				if ($('#faultyStatsDay .116').text() == "") {
					$('#faultyStatsDay .116').addClass('d-none');
					$(this).find('td').eq(133).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(122).addClass('d-none');
				}
				if ($('#faultyStatsDay .117').text() == "") {
					$('#faultyStatsDay .117').addClass('d-none');
					$(this).find('td').eq(134).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(123).addClass('d-none');
				}
				if ($('#faultyStatsDay .118').text() == "") {
					$('#faultyStatsDay .118').addClass('d-none');
					$(this).find('td').eq(135).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(124).addClass('d-none');
				}
				if ($('#faultyStatsDay .119').text() == "") {
					$('#faultyStatsDay .119').addClass('d-none');
					$(this).find('td').eq(136).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(125).addClass('d-none');
				}
				if ($('#faultyStatsDay .120').text() == "") {
					$('#faultyStatsDay .120').addClass('d-none');
					$(this).find('td').eq(137).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(126).addClass('d-none');
				}
				if ($('#faultyStatsDay .121').text() == "") {
					$('#faultyStatsDay .121').addClass('d-none');
					$(this).find('td').eq(138).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(127).addClass('d-none');
				}
				if ($('#faultyStatsDay .122').text() == "") {
					$('#faultyStatsDay .122').addClass('d-none');
					$(this).find('td').eq(139).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(128).addClass('d-none');
				}
				if ($('#faultyStatsDay .123').text() == "") {
					$('#faultyStatsDay .123').addClass('d-none');
					$(this).find('td').eq(140).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(129).addClass('d-none');
				}
				if ($('#faultyStatsDay .124').text() == "") {
					$('#faultyStatsDay .124').addClass('d-none');
					$(this).find('td').eq(141).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(130).addClass('d-none');
				}
				if ($('#faultyStatsDay .125').text() == "") {
					$('#faultyStatsDay .125').addClass('d-none');
					$(this).find('td').eq(142).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(131).addClass('d-none');
				}
				if ($('#faultyStatsDay .126').text() == "") {
					$('#faultyStatsDay .126').addClass('d-none');
					$(this).find('td').eq(143).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(132).addClass('d-none');
				}
				if ($('#faultyStatsDay .127').text() == "") {
					$('#faultyStatsDay .127').addClass('d-none');
					$(this).find('td').eq(144).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(133).addClass('d-none');
				}
				if ($('#faultyStatsDay .128').text() == "") {
					$('#faultyStatsDay .128').addClass('d-none');
					$(this).find('td').eq(145).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(134).addClass('d-none');
				}
				if ($('#faultyStatsDay .129').text() == "") {
					$('#faultyStatsDay .129').addClass('d-none');
					$(this).find('td').eq(146).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(135).addClass('d-none');
				}
				if ($('#faultyStatsDay .130').text() == "") {
					$('#faultyStatsDay .130').addClass('d-none');
					$(this).find('td').eq(147).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(136).addClass('d-none');
				}
				if ($('#faultyStatsDay .131').text() == "") {
					$('#faultyStatsDay .131').addClass('d-none');
					$(this).find('td').eq(148).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(137).addClass('d-none');
				}
				if ($('#faultyStatsDay .132').text() == "") {
					$('#faultyStatsDay .132').addClass('d-none');
					$(this).find('td').eq(149).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(138).addClass('d-none');
				}
				if ($('#faultyStatsDay .133').text() == "") {
					$('#faultyStatsDay .133').addClass('d-none');
					$(this).find('td').eq(150).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(139).addClass('d-none');
				}
				if ($('#faultyStatsDay .134').text() == "") {
					$('#faultyStatsDay .134').addClass('d-none');
					$(this).find('td').eq(151).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(140).addClass('d-none');
				}
				if ($('#faultyStatsDay .135').text() == "") {
					$('#faultyStatsDay .135').addClass('d-none');
					$(this).find('td').eq(152).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(141).addClass('d-none');
				}
				if ($('#faultyStatsDay .136').text() == "") {
					$('#faultyStatsDay .136').addClass('d-none');
					$(this).find('td').eq(153).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(142).addClass('d-none');
				}
				if ($('#faultyStatsDay .137').text() == "") {
					$('#faultyStatsDay .137').addClass('d-none');
					$(this).find('td').eq(154).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(143).addClass('d-none');
				}
				if ($('#faultyStatsDay .138').text() == "") {
					$('#faultyStatsDay .138').addClass('d-none');
					$(this).find('td').eq(155).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(144).addClass('d-none');
				}
				if ($('#faultyStatsDay .139').text() == "") {
					$('#faultyStatsDay .139').addClass('d-none');
					$(this).find('td').eq(156).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(145).addClass('d-none');
				}
				if ($('#faultyStatsDay .140').text() == "") {
					$('#faultyStatsDay .140').addClass('d-none');
					$(this).find('td').eq(157).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(146).addClass('d-none');
				}
				if ($('#faultyStatsDay .141').text() == "") {
					$('#faultyStatsDay .141').addClass('d-none');
					$(this).find('td').eq(158).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(147).addClass('d-none');
				}
				if ($('#faultyStatsDay .142').text() == "") {
					$('#faultyStatsDay .142').addClass('d-none');
					$(this).find('td').eq(159).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(148).addClass('d-none');
				}
				if ($('#faultyStatsDay .143').text() == "") {
					$('#faultyStatsDay .143').addClass('d-none');
					$(this).find('td').eq(160).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(149).addClass('d-none');
				}
				if ($('#faultyStatsDay .144').text() == "") {
					$('#faultyStatsDay .144').addClass('d-none');
					$(this).find('td').eq(161).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(150).addClass('d-none');
				}
				if ($('#faultyStatsDay .145').text() == "") {
					$('#faultyStatsDay .145').addClass('d-none');
					$(this).find('td').eq(162).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(151).addClass('d-none');
				}
				if ($('#faultyStatsDay .146').text() == "") {
					$('#faultyStatsDay .146').addClass('d-none');
					$(this).find('td').eq(163).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(152).addClass('d-none');
				}
				if ($('#faultyStatsDay .147').text() == "") {
					$('#faultyStatsDay .147').addClass('d-none');
					$(this).find('td').eq(164).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(153).addClass('d-none');
				}
				if ($('#faultyStatsDay .148').text() == "") {
					$('#faultyStatsDay .148').addClass('d-none');
					$(this).find('td').eq(165).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(154).addClass('d-none');
				}
				if ($('#faultyStatsDay .149').text() == "") {
					$('#faultyStatsDay .149').addClass('d-none');
					$(this).find('td').eq(166).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(155).addClass('d-none');
				}
				if ($('#faultyStatsDay .150').text() == "") {
					$('#faultyStatsDay .150').addClass('d-none');
					$(this).find('td').eq(167).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(156).addClass('d-none');
				}
				if ($('#faultyStatsDay .151').text() == "") {
					$('#faultyStatsDay .151').addClass('d-none');
					$(this).find('td').eq(168).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(157).addClass('d-none');
				}
				if ($('#faultyStatsDay .152').text() == "") {
					$('#faultyStatsDay .152').addClass('d-none');
					$(this).find('td').eq(169).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(158).addClass('d-none');
				}
				if ($('#faultyStatsDay .153').text() == "") {
					$('#faultyStatsDay .153').addClass('d-none');
					$(this).find('td').eq(170).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(160).addClass('d-none');
				}
				if ($('#faultyStatsDay .154').text() == "") {
					$('#faultyStatsDay .154').addClass('d-none');
					$(this).find('td').eq(171).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(161).addClass('d-none');
				}
				if ($('#faultyStatsDay .155').text() == "") {
					$('#faultyStatsDay .155').addClass('d-none');
					$(this).find('td').eq(172).addClass('d-none');
					$('#faultyStatsDay tfoot tr').eq(0).find('td').eq(162).addClass('d-none');
				}
	
			});
			
			//전역변수들
 			let sumOutputCnt = $('#faultyStatsDay').DataTable().column(2,{ page: 'all'} ).data().sum();
			let sumAppearOutputCnt = $('#faultyStatsDay').DataTable().column(3,{ page: 'all'} ).data().sum();
			let sumFaulty = $('#faultyStatsDay').DataTable().column(4,{ page: 'all'} ).data().sum();
			let sumFaultyPercent = 100 * sumFaulty / sumOutputCnt;

			$('#sumOutputCnt').html(addCommas(sumOutputCnt));
			$('#sumAppearOutputCnt').html(addCommas(sumAppearOutputCnt));
			$('#sumFaulty').html(addCommas(sumFaulty));
			$('#sumFaultyPercent').html(sumFaultyPercent.toFixed(2) + "%");
			
			//지역변수들
			let faulty1	=	showTypeChange($('#faultyStatsDay').DataTable().column(17,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty2	=	showTypeChange($('#faultyStatsDay').DataTable().column(18,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty3	=	showTypeChange($('#faultyStatsDay').DataTable().column(19,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty4	=	showTypeChange($('#faultyStatsDay').DataTable().column(20,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty5	=	showTypeChange($('#faultyStatsDay').DataTable().column(21,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty6	=	showTypeChange($('#faultyStatsDay').DataTable().column(22,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty7	=	showTypeChange($('#faultyStatsDay').DataTable().column(23,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty8	=	showTypeChange($('#faultyStatsDay').DataTable().column(24,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty9	=	showTypeChange($('#faultyStatsDay').DataTable().column(25,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty10	=	showTypeChange($('#faultyStatsDay').DataTable().column(26,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty11	=	showTypeChange($('#faultyStatsDay').DataTable().column(27,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty12	=	showTypeChange($('#faultyStatsDay').DataTable().column(28,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty13	=	showTypeChange($('#faultyStatsDay').DataTable().column(29,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty14	=	showTypeChange($('#faultyStatsDay').DataTable().column(30,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty15	=	showTypeChange($('#faultyStatsDay').DataTable().column(31,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty16	=	showTypeChange($('#faultyStatsDay').DataTable().column(32,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty17	=	showTypeChange($('#faultyStatsDay').DataTable().column(33,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty18	=	showTypeChange($('#faultyStatsDay').DataTable().column(34,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty19	=	showTypeChange($('#faultyStatsDay').DataTable().column(35,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty20	=	showTypeChange($('#faultyStatsDay').DataTable().column(36,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty21	=	showTypeChange($('#faultyStatsDay').DataTable().column(37,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty22	=	showTypeChange($('#faultyStatsDay').DataTable().column(38,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty23	=	showTypeChange($('#faultyStatsDay').DataTable().column(39,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty24	=	showTypeChange($('#faultyStatsDay').DataTable().column(40,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty25	=	showTypeChange($('#faultyStatsDay').DataTable().column(41,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty26	=	showTypeChange($('#faultyStatsDay').DataTable().column(42,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty27	=	showTypeChange($('#faultyStatsDay').DataTable().column(43,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty28	=	showTypeChange($('#faultyStatsDay').DataTable().column(44,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty29	=	showTypeChange($('#faultyStatsDay').DataTable().column(45,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty30	=	showTypeChange($('#faultyStatsDay').DataTable().column(46,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty31	=	showTypeChange($('#faultyStatsDay').DataTable().column(47,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty32	=	showTypeChange($('#faultyStatsDay').DataTable().column(48,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty33	=	showTypeChange($('#faultyStatsDay').DataTable().column(49,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty34	=	showTypeChange($('#faultyStatsDay').DataTable().column(50,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty35	=	showTypeChange($('#faultyStatsDay').DataTable().column(51,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty36	=	showTypeChange($('#faultyStatsDay').DataTable().column(52,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty37	=	showTypeChange($('#faultyStatsDay').DataTable().column(53,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty38	=	showTypeChange($('#faultyStatsDay').DataTable().column(54,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty39	=	showTypeChange($('#faultyStatsDay').DataTable().column(55,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty40	=	showTypeChange($('#faultyStatsDay').DataTable().column(56,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty41	=	showTypeChange($('#faultyStatsDay').DataTable().column(57,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty42	=	showTypeChange($('#faultyStatsDay').DataTable().column(58,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty43	=	showTypeChange($('#faultyStatsDay').DataTable().column(59,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty44	=	showTypeChange($('#faultyStatsDay').DataTable().column(60,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty45	=	showTypeChange($('#faultyStatsDay').DataTable().column(61,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty46	=	showTypeChange($('#faultyStatsDay').DataTable().column(62,{ page: 'all'} ).data().sum(), sumOutputCnt);
			let faulty47	=	showTypeChange($('#faultyStatsDay').DataTable().column(63,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty48    =   showTypeChange($('#faultyStatsDay').DataTable().column(64,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty49    =   showTypeChange($('#faultyStatsDay').DataTable().column(65,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty50    =   showTypeChange($('#faultyStatsDay').DataTable().column(66,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty51    =   showTypeChange($('#faultyStatsDay').DataTable().column(67,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty52    =   showTypeChange($('#faultyStatsDay').DataTable().column(68,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty53    =   showTypeChange($('#faultyStatsDay').DataTable().column(69,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty54    =   showTypeChange($('#faultyStatsDay').DataTable().column(70,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty55    =   showTypeChange($('#faultyStatsDay').DataTable().column(71,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty56    =   showTypeChange($('#faultyStatsDay').DataTable().column(72,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty57    =   showTypeChange($('#faultyStatsDay').DataTable().column(73,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty58    =   showTypeChange($('#faultyStatsDay').DataTable().column(74,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty59    =   showTypeChange($('#faultyStatsDay').DataTable().column(75,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty60    =   showTypeChange($('#faultyStatsDay').DataTable().column(76,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty61    =   showTypeChange($('#faultyStatsDay').DataTable().column(77,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty62    =   showTypeChange($('#faultyStatsDay').DataTable().column(78,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty63    =   showTypeChange($('#faultyStatsDay').DataTable().column(79,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty64    =   showTypeChange($('#faultyStatsDay').DataTable().column(80,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty65    =   showTypeChange($('#faultyStatsDay').DataTable().column(81,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty66    =   showTypeChange($('#faultyStatsDay').DataTable().column(82,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty67    =   showTypeChange($('#faultyStatsDay').DataTable().column(83,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty68    =   showTypeChange($('#faultyStatsDay').DataTable().column(84,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty69    =   showTypeChange($('#faultyStatsDay').DataTable().column(85,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty70    =   showTypeChange($('#faultyStatsDay').DataTable().column(86,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty71    =   showTypeChange($('#faultyStatsDay').DataTable().column(87,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty72    =   showTypeChange($('#faultyStatsDay').DataTable().column(88,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty73    =   showTypeChange($('#faultyStatsDay').DataTable().column(89,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty74    =   showTypeChange($('#faultyStatsDay').DataTable().column(90,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty75    =   showTypeChange($('#faultyStatsDay').DataTable().column(91,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty76    =   showTypeChange($('#faultyStatsDay').DataTable().column(92,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty77    =   showTypeChange($('#faultyStatsDay').DataTable().column(93,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty78    =   showTypeChange($('#faultyStatsDay').DataTable().column(94,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty79    =   showTypeChange($('#faultyStatsDay').DataTable().column(95,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty80    =   showTypeChange($('#faultyStatsDay').DataTable().column(96,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty81    =   showTypeChange($('#faultyStatsDay').DataTable().column(97,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty82    =   showTypeChange($('#faultyStatsDay').DataTable().column(98,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty83    =   showTypeChange($('#faultyStatsDay').DataTable().column(99,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty84    =   showTypeChange($('#faultyStatsDay').DataTable().column(100,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty85    =   showTypeChange($('#faultyStatsDay').DataTable().column(101,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty86    =   showTypeChange($('#faultyStatsDay').DataTable().column(102,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty87    =   showTypeChange($('#faultyStatsDay').DataTable().column(103,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty88    =   showTypeChange($('#faultyStatsDay').DataTable().column(104,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty89    =   showTypeChange($('#faultyStatsDay').DataTable().column(105,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty90    =   showTypeChange($('#faultyStatsDay').DataTable().column(106,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty91    =   showTypeChange($('#faultyStatsDay').DataTable().column(107,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty92    =   showTypeChange($('#faultyStatsDay').DataTable().column(108,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty93    =   showTypeChange($('#faultyStatsDay').DataTable().column(109,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty94    =   showTypeChange($('#faultyStatsDay').DataTable().column(110,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty95    =   showTypeChange($('#faultyStatsDay').DataTable().column(111,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty96    =   showTypeChange($('#faultyStatsDay').DataTable().column(112,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty97    =   showTypeChange($('#faultyStatsDay').DataTable().column(113,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty98    =   showTypeChange($('#faultyStatsDay').DataTable().column(114,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty99    =   showTypeChange($('#faultyStatsDay').DataTable().column(115,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty100    =   showTypeChange($('#faultyStatsDay').DataTable().column(116,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty101    =   showTypeChange($('#faultyStatsDay').DataTable().column(117,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty102    =   showTypeChange($('#faultyStatsDay').DataTable().column(118,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty103    =   showTypeChange($('#faultyStatsDay').DataTable().column(119,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty104    =   showTypeChange($('#faultyStatsDay').DataTable().column(120,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty105    =   showTypeChange($('#faultyStatsDay').DataTable().column(121,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty106    =   showTypeChange($('#faultyStatsDay').DataTable().column(122,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty107    =   showTypeChange($('#faultyStatsDay').DataTable().column(123,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty108    =   showTypeChange($('#faultyStatsDay').DataTable().column(124,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty109    =   showTypeChange($('#faultyStatsDay').DataTable().column(125,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty110    =   showTypeChange($('#faultyStatsDay').DataTable().column(126,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty111    =   showTypeChange($('#faultyStatsDay').DataTable().column(127,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty112    =   showTypeChange($('#faultyStatsDay').DataTable().column(128,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty113    =   showTypeChange($('#faultyStatsDay').DataTable().column(129,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty114    =   showTypeChange($('#faultyStatsDay').DataTable().column(130,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty115    =   showTypeChange($('#faultyStatsDay').DataTable().column(131,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty116    =   showTypeChange($('#faultyStatsDay').DataTable().column(132,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty117    =   showTypeChange($('#faultyStatsDay').DataTable().column(133,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty118    =   showTypeChange($('#faultyStatsDay').DataTable().column(134,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty119    =   showTypeChange($('#faultyStatsDay').DataTable().column(135,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty120    =   showTypeChange($('#faultyStatsDay').DataTable().column(136,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty121    =   showTypeChange($('#faultyStatsDay').DataTable().column(137,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty122    =   showTypeChange($('#faultyStatsDay').DataTable().column(138,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty123    =   showTypeChange($('#faultyStatsDay').DataTable().column(139,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty124    =   showTypeChange($('#faultyStatsDay').DataTable().column(140,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty125    =   showTypeChange($('#faultyStatsDay').DataTable().column(141,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty126    =   showTypeChange($('#faultyStatsDay').DataTable().column(142,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty127    =   showTypeChange($('#faultyStatsDay').DataTable().column(143,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty128    =   showTypeChange($('#faultyStatsDay').DataTable().column(144,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty129    =   showTypeChange($('#faultyStatsDay').DataTable().column(145,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty130    =   showTypeChange($('#faultyStatsDay').DataTable().column(146,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty131    =   showTypeChange($('#faultyStatsDay').DataTable().column(147,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty132    =   showTypeChange($('#faultyStatsDay').DataTable().column(148,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty133    =   showTypeChange($('#faultyStatsDay').DataTable().column(149,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty134    =   showTypeChange($('#faultyStatsDay').DataTable().column(150,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty135    =   showTypeChange($('#faultyStatsDay').DataTable().column(151,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty136    =   showTypeChange($('#faultyStatsDay').DataTable().column(152,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty137    =   showTypeChange($('#faultyStatsDay').DataTable().column(153,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty138    =   showTypeChange($('#faultyStatsDay').DataTable().column(154,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty139    =   showTypeChange($('#faultyStatsDay').DataTable().column(155,{ page: 'all'} ).data().sum(), sumOutputCnt);
            let faulty140    =   showTypeChange($('#faultyStatsDay').DataTable().column(156,{ page: 'all'} ).data().sum(), sumOutputCnt);
            
			$('#faulty1').html(addCommas(faulty1));
			$('#faulty2').html(addCommas(faulty2));
			$('#faulty3').html(addCommas(faulty3));
			$('#faulty4').html(addCommas(faulty4));
			$('#faulty5').html(addCommas(faulty5));
			$('#faulty6').html(addCommas(faulty6));
			$('#faulty7').html(addCommas(faulty7));
			$('#faulty8').html(addCommas(faulty8));
			$('#faulty9').html(addCommas(faulty9));
			$('#faulty10').html(addCommas(faulty10));
			$('#faulty11').html(addCommas(faulty11));
			$('#faulty12').html(addCommas(faulty12));
			$('#faulty13').html(addCommas(faulty13));
			$('#faulty14').html(addCommas(faulty14));
			$('#faulty15').html(addCommas(faulty15));
			$('#faulty16').html(addCommas(faulty16));
			$('#faulty17').html(addCommas(faulty17));
			$('#faulty18').html(addCommas(faulty18));
			$('#faulty19').html(addCommas(faulty19));
			$('#faulty20').html(addCommas(faulty20));
			$('#faulty21').html(addCommas(faulty21));
			$('#faulty22').html(addCommas(faulty22));
			$('#faulty23').html(addCommas(faulty23));
			$('#faulty24').html(addCommas(faulty24));
			$('#faulty25').html(addCommas(faulty25));
			$('#faulty26').html(addCommas(faulty26));
			$('#faulty27').html(addCommas(faulty27));
			$('#faulty28').html(addCommas(faulty28));
			$('#faulty29').html(addCommas(faulty29));
			$('#faulty30').html(addCommas(faulty30));
			$('#faulty31').html(addCommas(faulty31));
			$('#faulty32').html(addCommas(faulty32));
			$('#faulty33').html(addCommas(faulty33));
			$('#faulty34').html(addCommas(faulty34));
			$('#faulty35').html(addCommas(faulty35));
			$('#faulty36').html(addCommas(faulty36));
			$('#faulty37').html(addCommas(faulty37));
			$('#faulty38').html(addCommas(faulty38));
			$('#faulty39').html(addCommas(faulty39));
			$('#faulty40').html(addCommas(faulty40));
			$('#faulty41').html(addCommas(faulty41));
			$('#faulty42').html(addCommas(faulty42));
			$('#faulty43').html(addCommas(faulty43));
			$('#faulty44').html(addCommas(faulty44));
			$('#faulty45').html(addCommas(faulty45));
			$('#faulty46').html(addCommas(faulty46));
			$('#faulty47').html(addCommas(faulty47));
			$('#faulty48').html(addCommas(faulty48));
			$('#faulty49').html(addCommas(faulty49));
			$('#faulty50').html(addCommas(faulty50));
			$('#faulty51').html(addCommas(faulty51));
			$('#faulty52').html(addCommas(faulty52));
			$('#faulty53').html(addCommas(faulty53));
			$('#faulty54').html(addCommas(faulty54));
			$('#faulty55').html(addCommas(faulty55));
			$('#faulty56').html(addCommas(faulty56));
			$('#faulty57').html(addCommas(faulty57));
			$('#faulty58').html(addCommas(faulty58));
			$('#faulty59').html(addCommas(faulty59));
			$('#faulty60').html(addCommas(faulty60));
			$('#faulty61').html(addCommas(faulty61));
			$('#faulty62').html(addCommas(faulty62));
			$('#faulty63').html(addCommas(faulty63));
			$('#faulty64').html(addCommas(faulty64));
			$('#faulty65').html(addCommas(faulty65));
			$('#faulty66').html(addCommas(faulty66));
			$('#faulty67').html(addCommas(faulty67));
			$('#faulty68').html(addCommas(faulty68));
			$('#faulty69').html(addCommas(faulty69));
			$('#faulty70').html(addCommas(faulty70));
			$('#faulty71').html(addCommas(faulty71));
			$('#faulty72').html(addCommas(faulty72));
			$('#faulty73').html(addCommas(faulty73));
			$('#faulty74').html(addCommas(faulty74));
			$('#faulty75').html(addCommas(faulty75));
			$('#faulty76').html(addCommas(faulty76));
			$('#faulty77').html(addCommas(faulty77));
			$('#faulty78').html(addCommas(faulty78));
			$('#faulty79').html(addCommas(faulty79));
			$('#faulty80').html(addCommas(faulty80));
			$('#faulty81').html(addCommas(faulty81));
			$('#faulty82').html(addCommas(faulty82));
			$('#faulty83').html(addCommas(faulty83));
			$('#faulty84').html(addCommas(faulty84));
			$('#faulty85').html(addCommas(faulty85));
			$('#faulty86').html(addCommas(faulty86));
			$('#faulty87').html(addCommas(faulty87));
			$('#faulty88').html(addCommas(faulty88));
			$('#faulty89').html(addCommas(faulty89));
			$('#faulty90').html(addCommas(faulty90));
			$('#faulty91').html(addCommas(faulty91));
			$('#faulty92').html(addCommas(faulty92));
			$('#faulty93').html(addCommas(faulty93));
			$('#faulty94').html(addCommas(faulty94));
			$('#faulty95').html(addCommas(faulty95));
			$('#faulty96').html(addCommas(faulty96));
			$('#faulty97').html(addCommas(faulty97));
			$('#faulty98').html(addCommas(faulty98));
			$('#faulty99').html(addCommas(faulty99));
			$('#faulty100').html(addCommas(faulty100));
			$('#faulty101').html(addCommas(faulty101));
			$('#faulty102').html(addCommas(faulty102));
			$('#faulty103').html(addCommas(faulty103));
			$('#faulty104').html(addCommas(faulty104));
			$('#faulty105').html(addCommas(faulty105));
			$('#faulty106').html(addCommas(faulty106));
			$('#faulty107').html(addCommas(faulty107));
			$('#faulty108').html(addCommas(faulty108));
			$('#faulty109').html(addCommas(faulty109));
			$('#faulty110').html(addCommas(faulty110));
			$('#faulty111').html(addCommas(faulty111));
			$('#faulty112').html(addCommas(faulty112));
			$('#faulty113').html(addCommas(faulty113));
			$('#faulty114').html(addCommas(faulty114));
			$('#faulty115').html(addCommas(faulty115));
			$('#faulty116').html(addCommas(faulty116));
			$('#faulty117').html(addCommas(faulty117));
			$('#faulty118').html(addCommas(faulty118));
			$('#faulty119').html(addCommas(faulty119));
			$('#faulty120').html(addCommas(faulty120));
			$('#faulty121').html(addCommas(faulty121));
			$('#faulty122').html(addCommas(faulty122));
			$('#faulty123').html(addCommas(faulty123));
			$('#faulty124').html(addCommas(faulty124));
			$('#faulty125').html(addCommas(faulty125));
			$('#faulty126').html(addCommas(faulty126));
			$('#faulty127').html(addCommas(faulty127));
			$('#faulty128').html(addCommas(faulty128));
			$('#faulty129').html(addCommas(faulty129));
			$('#faulty130').html(addCommas(faulty130));
			$('#faulty131').html(addCommas(faulty131));
			$('#faulty132').html(addCommas(faulty132));
			$('#faulty133').html(addCommas(faulty133));
			$('#faulty134').html(addCommas(faulty134));
			$('#faulty135').html(addCommas(faulty135));
			$('#faulty136').html(addCommas(faulty136));
			$('#faulty137').html(addCommas(faulty137));
			$('#faulty138').html(addCommas(faulty138));
			$('#faulty139').html(addCommas(faulty139));
			$('#faulty140').html(addCommas(faulty140));
        },
    });

	/* var html1 = '<div class="row">';
		html1 += '<label class="input-label-sm ml-1">검사일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '<label class="input-label-sm ml-1">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateTo" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="btnChooseDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		
		html1 += '<label class="input-label-sm ml-3">검사자</label>';
		html1 += '<input type="hidden" class="form-control" id="preWorkCharger"  name="preWorkCharger">';
		html1 += '	<div class="input-sub m-0 row">';
	    html1 += '	<input type="text" class="form-control" id="preWorkChargerNm"  name="preWorkChargerNm" disabled>';
	    html1 += '	<button type="button" class="btn btn-primary input-sub-search" id="btnSelPreWorkCharger" ">';//onClick="selectPreWorkCharger()
		html1 += '	<span class="oi oi-magnifying-glass"></span>';
	    html1 += '</button>';
	    html1 += '</div>';
	    html1 += '<div>';
	    html1 += '<a href="javascript:void(0)" id="cancelSearchUser" class="closebtn"><i class="mdi mdi-close"></i></a>';
	    html1 += '</div>';
	    
		html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
		html1 += '&nbsp;<button type="button" class="btn btn-primary ml-2" id="btnPackingNumberInquiry">포장번호 조회</button>';
		html1 += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">형식</label>';
		html1 += '<select class="custom-select" style="min-width:70px; max-width: 70px;" id="showType">';
		html1 += '<option value="showType001">개수</option>';
		html1 += '<option value="showType002">%</option>';
		html1 += '</select>';
		html1 += '</div>'; */

	//$('#goodsFaultyDateLookup').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);

	//외관검사 검색
	$('#faultyStatsDay_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#faultyStatsDay_filter').find('label').eq(0).addClass('row ml-3');
	$('#faultyStatsDay_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#faultyStatsDay_filter").insertAfter("#showType");
	$("#faultyStatsDay_filter").addClass("d-none");
	//외관검사 검색
  	$('#faultyStatsDay tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
// 			$(this).removeClass('selected');
		} else {
			$('#faultyStatsDay').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		workOrdLotNo = faultyStatsDay.row(this).data().workOrdLotNo;
  	});

	//외관검사 테이블 더블클릭 시
	$('#faultyStatsDay tbody').on('dblclick', 'tr', function() {
		//workOrdNo = faultyStatsDay.row(this).data().workOrdNo;
		workOrdLotNo = faultyStatsDay.row(this).data().workOrdLotNo;
		$('#boxNoTraceTable').DataTable().clear().draw();
		$('#boxNoTraceTable').DataTable().ajax.reload();
		$('#boxNoTraceModal').modal('show');
	});

	//포장조회 버튼 클릭시
	$('#btnPackingNumberInquiry').on('click', function(){

		if ($('#faultyStatsDay tbody tr').hasClass('selected')=='' && tabView == 'tabView1'){
			toastr.warning("조회할 항목을 선택&더블 클릭 해주세요!.");
			return false;
		}
		if ($('#workOrderTable tbody tr').hasClass('selected')=='' && tabView == 'tabView3'){
			toastr.warning("조회할 항목을 선택&더블 클릭 해주세요!.");
			return false;
		}
		$('#boxNoTraceTable').DataTable().clear().draw();
		$('#boxNoTraceTable').DataTable().ajax.reload();
		$('#boxNoTraceModal').modal('show');
	});
	
	//목록
    $.fn.dataTable.ext.errMode = 'none';
	let boxNoTraceTable = $('#boxNoTraceTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12'tr>>" +
			 "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/qm/goodsDisuseListScan"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
	           	'workOrdLotNo'		: 	function() { return workOrdLotNo; },
            },
        },
        rowId: '',
        columns: [
			{ data: 'packDate',
			 render: function(data, type, row) {	
				 if(data == "Invalid date" || data == null){
					 return "";
				}
					return moment(data).format("YYYY-MM-DD");
			    }
			},
			{ data: 'workOrdNo' },
			{ data: 'workOrdLotNo' },
			{ data: 'boxNo' },
			{ data: 'goodsCd' },
			{ data: 'goodsNm' },
			{ data: 'ordGubunNm' },
			{
				data: "packDtlCnt",
				render: function(data, type, row, meta) {
					if(data == '0') {
						let html = '<p style="margin-bottom: 0px;">-</p>';
						return html;
					} else {
						return data;
					}
				}
			},
			{ data: 'remainCnt' },
			{ data: 'packUnitNm' },
			{ data: 'goodsStatusNm' },
			{
				data: "faultyStatusNm",
				render: function(data, type, row, meta) {
					if(data == '폐기') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else {
						return data;
					}
				}
			},
			{
				data: "divisionYnNm",
				render: function(data, type, row, meta) {
					if(row['divisionYn'] == 'N') {
						let html = '<p style="margin-bottom: 0px;">-</p>';
						return html;
					} else if(row['divisionYn'] == 'D') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else if(row['divisionYn'] == 'M') {
						let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else {
						return data;
					}
				}
			},
            {
                data: 'faultyDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            {
				data: 'faultyType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += goodsFaultyType[jj].baseCdNm + ', ';
								count++;
							}
						}
						if (count == 0) {
							faultyTypeNm = '-';
						} else {
							faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
						}
					} else {
						faultyTypeNm = '';
					}
					return faultyTypeNm;
				}
            },
            { data: 'faultyDesc' },
        ],
        columnDefs: [
           	{ targets: [7,8,9], render: $.fn.dataTable.render.number( ',' )},
           	{ targets: [7,8,9], className: 'text-right' },
           	{ targets: [0,1,2,3,4,5,6,9,10,11,12,13,14,15], className: 'text-center' },
        ],
        order: [
            [ 1, 'asc' ]
		],
		buttons: [
		    {
		        extend: 'copy',
		        title: '포장번호',
		    },
		    {
		        extend: 'excel',
		        title: '포장번호',
		    },
		    {
		        extend: 'print',
		        title: '포장번호',
		    }
		],
		drawCallback : function( settings ) {
		    
		},
		rowCallback: function (row, data) {
            if ( data.divisionYn == 'D' ) {
                $(row).addClass('skyYellow');
            } else if ( data.divisionYn == 'M' ) {
                $(row).addClass('skyBlue');
            }
        },
    });






//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ엣지 검사ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	
	
	var edgeSumOutputCnt		= 0;
	var edgeSumAppearOutputCnt	= 0;
	var edgeSumFaulty 			= 0;
	var edgeUserNumber 			= null;
	var edgeWorkOrdNo 			= "empty";
	var edgeWorkOrdLotNo		= "empty";


	//엣지목록
	$.fn.dataTable.ext.errMode = 'none';
	let edgeGoodsFaultyTable = $('#edgeGoodsFaultyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/edgeFaultyTotalDataList_F2"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
            },
        },
		//rowId: 'workOrdNo',
        columns: [
			{
				render: function(data, type, row) {
					return moment(row['edgeInspctDate']).format('YYYY-MM-DD');
				}
			},
        	{data:'edgeInspctChargerNm'	},
        	{data:'userInputInspctCnt'	},
        	{data:'edgeOutputCnt'		},
        	//{
        	//	render: function(data, type, row) {
        	//		return addCommas(parseInt(row['userInputInspctCnt']-row['appearOutputCnt']));
			//	}
        	//},
        	{data:'edgeFaultyCnt'},
        	{
        		render: function(data, type, row) {
        			return parseFloat((parseInt(row['edgeFaultyCnt']))/row['userInputInspctCnt']*100).toFixed(2) + " %";
				}
        	},
        	{
        		render: function(data, type, row) {
					return moment(row['ordDate']).format('YYYY-MM-DD');
        		}
			},
        	{data:'equipNm'},
        	{data:'workOrdNo'},
        	{data:'workOrdLotNo'},
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
			{ data: 'ordGubunNm',
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
        	{data:'mainWorkChargrNm'},
        	{data:'goodsNm'},
        	{data:'qutyNm'},
        	{data:'model'},
        	{data:'lotNo'},
        	{ data: 'faulty1',
        		render: function(data, type, row) {
            		if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty2',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty3',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty4',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty5',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty6',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty7',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty8',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty9',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty10',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty11',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty12',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty13',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty14',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty15',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty16',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty17',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty18',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty19',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty20',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty21',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty22',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty23',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty24',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty25',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty26',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty27',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty28',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty29',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty30',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty31',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty32',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty33',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty34',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty35',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty36',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty37',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty38',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty39',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty40',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty41',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty42',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty43',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty44',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty45',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty46',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty47',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty48',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty49',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty50',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty51',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty52',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty53',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty54',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty55',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty56',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty57',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty58',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty59',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty60',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty61',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty62',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty63',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty64',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty65',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty66',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty67',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty68',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty69',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty70',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty71',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty72',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {						
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty73',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty74',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty75',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty76',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty77',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty78',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty79',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty80',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},

        ],
        buttons: [
            {
                extend: 'copy',
                title: '최종검사현황-엣지검사',
            },
            {
				extend: 'excel',
				title: '최종검사현황-엣지검사',
				exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (row == 10 || row == 11) {
								data = data.replace('<p style="color:red; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('<p style="color:blue; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('</p>', '');
								return data;
							}
							if (showType == 'showType001') {
								if (row == 5) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 5) { return data.replace(" %", ""); }
								else if (row == 17) { return data.replace(" %", ""); }
								else if (row == 18) { return data.replace(" %", ""); }
								else if (row == 19) { return data.replace(" %", ""); }
								else if (row == 20) { return data.replace(" %", ""); }
								else if (row == 21) { return data.replace(" %", ""); }
								else if (row == 22) { return data.replace(" %", ""); }
								else if (row == 23) { return data.replace(" %", ""); }
								else if (row == 24) { return data.replace(" %", ""); }
								else if (row == 25) { return data.replace(" %", ""); }
								else if (row == 26) { return data.replace(" %", ""); }
								else if (row == 27) { return data.replace(" %", ""); }
								else if (row == 28) { return data.replace(" %", ""); }
								else if (row == 29) { return data.replace(" %", ""); }
								else if (row == 30) { return data.replace(" %", ""); }
								else if (row == 31) { return data.replace(" %", ""); }
								else if (row == 32) { return data.replace(" %", ""); }
								else if (row == 33) { return data.replace(" %", ""); }
								else if (row == 34) { return data.replace(" %", ""); }
								else if (row == 35) { return data.replace(" %", ""); }
								else if (row == 36) { return data.replace(" %", ""); }
								else if (row == 37) { return data.replace(" %", ""); }
								else if (row == 38) { return data.replace(" %", ""); }
								else if (row == 39) { return data.replace(" %", ""); }
								else if (row == 40) { return data.replace(" %", ""); }
								else if (row == 41) { return data.replace(" %", ""); }
								else if (row == 42) { return data.replace(" %", ""); }
								else if (row == 43) { return data.replace(" %", ""); }
								else if (row == 44) { return data.replace(" %", ""); }
								else if (row == 45) { return data.replace(" %", ""); }
								else if (row == 46) { return data.replace(" %", ""); }
								else if (row == 47) { return data.replace(" %", ""); }
								else if (row == 48) { return data.replace(" %", ""); }
								else if (row == 49) { return data.replace(" %", ""); }
								else if (row == 50) { return data.replace(" %", ""); }
								else if (row == 51) { return data.replace(" %", ""); }
								else if (row == 52) { return data.replace(" %", ""); }
								else if (row == 53) { return data.replace(" %", ""); }
								else if (row == 54) { return data.replace(" %", ""); }
								else if (row == 55) { return data.replace(" %", ""); }
								else if (row == 56) { return data.replace(" %", ""); }
								else if (row == 57) { return data.replace(" %", ""); }
								else if (row == 58) { return data.replace(" %", ""); }
								else if (row == 59) { return data.replace(" %", ""); }
								else if (row == 60) { return data.replace(" %", ""); }
								else if (row == 61) { return data.replace(" %", ""); }
								else if (row == 62) { return data.replace(" %", ""); }
								else if (row == 63) { return data.replace(" %", ""); }
								else if (row == 64) { return data.replace(" %", ""); }
								else if (row == 65) { return data.replace(" %", ""); }
								else if (row == 66) { return data.replace(" %", ""); }							
								else if (row == 67) { return data.replace(" %", ""); }
								else if (row == 68) { return data.replace(" %", ""); }
								else if (row == 69) { return data.replace(" %", ""); }
								else if (row == 70) { return data.replace(" %", ""); }
								else if (row == 71) { return data.replace(" %", ""); }
								else if (row == 72) { return data.replace(" %", ""); }
								else if (row == 73) { return data.replace(" %", ""); }
								else if (row == 74) { return data.replace(" %", ""); }
								else if (row == 75) { return data.replace(" %", ""); }
								else if (row == 76) { return data.replace(" %", ""); }
								else if (row == 77) { return data.replace(" %", ""); }
								else if (row == 78) { return data.replace(" %", ""); }
								else if (row == 79) { return data.replace(" %", ""); }
								else if (row == 80) { return data.replace(" %", ""); }
								else if (row == 81) { return data.replace(" %", ""); }
								else if (row == 82) { return data.replace(" %", ""); }
								else if (row == 83) { return data.replace(" %", ""); }
								else if (row == 84) { return data.replace(" %", ""); }
								else if (row == 85) { return data.replace(" %", ""); }
								else if (row == 86) { return data.replace(" %", ""); }
								else if (row == 87) { return data.replace(" %", ""); }
								else if (row == 88) { return data.replace(" %", ""); }
								else if (row == 89) { return data.replace(" %", ""); }
								else if (row == 90) { return data.replace(" %", ""); }
								else if (row == 91) { return data.replace(" %", ""); }
								else if (row == 92) { return data.replace(" %", ""); }
								else if (row == 93) { return data.replace(" %", ""); }
								else if (row == 94) { return data.replace(" %", ""); }
								else if (row == 95) { return data.replace(" %", ""); }
								else { return data; }
							}
						}
				    }
				}
            },
            {
                extend: 'print',
                title: '최종검사현황-엣지검사',
            },
        ],
		columnDefs: [
			{ targets: [2,3,4,5,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [2,3,4,5,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96], className: 'text-right' },
		],
		drawCallback: function () {
			$('#edgeGoodsFaultyTable').attr('style', 'margin-top: -1px !important;');
			$.each($('#edgeGoodsFaultyTable tbody tr'),function(index,item){
				if ($('#edgeGoodsFaultyTable .0').text()==""){            	
					$('#edgeGoodsFaultyTable .0').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(6).addClass('d-none');
				}
				if ($('#edgeGoodsFaultyTable .1').text() == "") {
					$('#edgeGoodsFaultyTable .1').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(7).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .2').text() == "") {
					$('#edgeGoodsFaultyTable .2').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(8).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .3').text() == "") {
					$('#edgeGoodsFaultyTable .3').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(9).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .4').text() == "") {
					$('#edgeGoodsFaultyTable .4').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(10).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .5').text() == "") {
					$('#edgeGoodsFaultyTable .5').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(11).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .6').text() == "") {
					$('#edgeGoodsFaultyTable .6').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(12).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .7').text() == "") {
					$('#edgeGoodsFaultyTable .7').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(13).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .8').text() == "") {
					$('#edgeGoodsFaultyTable .8').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(14).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .9').text() == "") {
					$('#edgeGoodsFaultyTable .9').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(15).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .10').text() == "") {
					$('#edgeGoodsFaultyTable .10').addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(16).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .11').text() == "") {
					$('#edgeGoodsFaultyTable .11').addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(17).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .12').text() == "") {
					$('#edgeGoodsFaultyTable .12').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(18).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .13').text() == "") {
					$('#edgeGoodsFaultyTable .13').addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(19).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .14').text() == "") {
					$('#edgeGoodsFaultyTable .14').addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(20).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .15').text() == "") {
					$('#edgeGoodsFaultyTable .15').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(21).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .16').text() == "") {
					$('#edgeGoodsFaultyTable .16').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(22).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .17').text() == "") {
					$('#edgeGoodsFaultyTable .17').addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(23).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .18').text() == "") {
					$('#edgeGoodsFaultyTable .18').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(24).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .19').text() == "") {
					$('#edgeGoodsFaultyTable .19').addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(25).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .20').text() == "") {
					$('#edgeGoodsFaultyTable .20').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(26).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .21').text() == "") {
					$('#edgeGoodsFaultyTable .21').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(27).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .22').text() == "") {
					$('#edgeGoodsFaultyTable .22').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(28).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .23').text() == "") {
					$('#edgeGoodsFaultyTable .23').addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(29).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .24').text() == "") {
					$('#edgeGoodsFaultyTable .24').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(30).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .25').text() == "") {
					$('#edgeGoodsFaultyTable .25').addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(31).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .26').text() == "") {
					$('#edgeGoodsFaultyTable .26').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(32).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .27').text() == "") {
					$('#edgeGoodsFaultyTable .27').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(33).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .28').text() == "") {
					$('#edgeGoodsFaultyTable .28').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(34).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .29').text() == "") {
					$('#edgeGoodsFaultyTable .29').addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(35).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .30').text() == "") {
					$('#edgeGoodsFaultyTable .30').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(36).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .31').text() == "") {
					$('#edgeGoodsFaultyTable .31').addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(37).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .32').text() == "") {
					$('#edgeGoodsFaultyTable .32').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(38).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .33').text() == "") {
					$('#edgeGoodsFaultyTable .33').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(39).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .34').text() == "") {
					$('#edgeGoodsFaultyTable .34').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(40).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .35').text() == "") {
					$('#edgeGoodsFaultyTable .35').addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(41).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .36').text() == "") {
					$('#edgeGoodsFaultyTable .36').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(42).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .37').text() == "") {
					$('#edgeGoodsFaultyTable .37').addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(43).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .38').text() == "") {
					$('#edgeGoodsFaultyTable .38').addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(44).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .39').text() == "") {
					$('#edgeGoodsFaultyTable .39').addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(45).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .40').text() == "") {
					$('#edgeGoodsFaultyTable .40').addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(46).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .41').text() == "") {
					$('#edgeGoodsFaultyTable .41').addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(47).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .42').text() == "") {
					$('#edgeGoodsFaultyTable .42').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(48).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .43').text() == "") {
					$('#edgeGoodsFaultyTable .43').addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(49).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .44').text() == "") {
					$('#edgeGoodsFaultyTable .44').addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(50).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .45').text() == "") {
					$('#edgeGoodsFaultyTable .45').addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(51).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .46').text() == "") {
					$('#edgeGoodsFaultyTable .46').addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(52).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .47').text() == "") {
					$('#edgeGoodsFaultyTable .47').addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(53).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .48').text() == "") {
					$('#edgeGoodsFaultyTable .48').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(54).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .49').text() == "") {
					$('#edgeGoodsFaultyTable .49').addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(55).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .50').text() == "") {
					$('#edgeGoodsFaultyTable .50').addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(56).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .51').text() == "") {
					$('#edgeGoodsFaultyTable .51').addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(57).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .52').text() == "") {
					$('#edgeGoodsFaultyTable .52').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(58).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .53').text() == "") {
					$('#edgeGoodsFaultyTable .53').addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(59).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .54').text() == "") {
					$('#edgeGoodsFaultyTable .54').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(60).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .55').text() == "") {
					$('#edgeGoodsFaultyTable .55').addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(61).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .56').text() == "") {
					$('#edgeGoodsFaultyTable .56').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(62).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .57').text() == "") {
					$('#edgeGoodsFaultyTable .57').addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(63).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .58').text() == "") {
					$('#edgeGoodsFaultyTable .58').addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(64).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .59').text() == "") {
					$('#edgeGoodsFaultyTable .59').addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(65).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .60').text() == "") {
					$('#edgeGoodsFaultyTable .60').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(66).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .61').text() == "") {
					$('#edgeGoodsFaultyTable .61').addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(67).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .62').text() == "") {
					$('#edgeGoodsFaultyTable .62').addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(68).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .63').text() == "") {
					$('#edgeGoodsFaultyTable .63').addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(69).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .64').text() == "") {
					$('#edgeGoodsFaultyTable .64').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(70).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .65').text() == "") {
					$('#edgeGoodsFaultyTable .65').addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(71).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .66').text() == "") {
					$('#edgeGoodsFaultyTable .66').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(72).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .67').text() == "") {
					$('#edgeGoodsFaultyTable .67').addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(73).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .68').text() == "") {
					$('#edgeGoodsFaultyTable .68').addClass('d-none');
					$(this).find('td').eq(85).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(74).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .69').text() == "") {
					$('#edgeGoodsFaultyTable .69').addClass('d-none');
					$(this).find('td').eq(86).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(75).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .70').text() == "") {
					$('#edgeGoodsFaultyTable .70').addClass('d-none');
					$(this).find('td').eq(87).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(76).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .71').text() == "") {
					$('#edgeGoodsFaultyTable .71').addClass('d-none');
					$(this).find('td').eq(88).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(77).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .72').text() == "") {
					$('#edgeGoodsFaultyTable .72').addClass('d-none');
					$(this).find('td').eq(89).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(78).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .73').text() == "") {
					$('#edgeGoodsFaultyTable .73').addClass('d-none');
					$(this).find('td').eq(90).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(79).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .74').text() == "") {
					$('#edgeGoodsFaultyTable .74').addClass('d-none');
					$(this).find('td').eq(91).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(80).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .75').text() == "") {
					$('#edgeGoodsFaultyTable .75').addClass('d-none');
					$(this).find('td').eq(92).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(81).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .76').text() == "") {
					$('#edgeGoodsFaultyTable .76').addClass('d-none');
					$(this).find('td').eq(93).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(82).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .77').text() == "") {
					$('#edgeGoodsFaultyTable .77').addClass('d-none');
					$(this).find('td').eq(94).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(83).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .78').text() == "") {
					$('#edgeGoodsFaultyTable .78').addClass('d-none');
					$(this).find('td').eq(95).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(84).addClass('d-none');
					
				}
				if ($('#edgeGoodsFaultyTable .79').text() == "") {
					$('#edgeGoodsFaultyTable .79').addClass('d-none');
					$(this).find('td').eq(96).addClass('d-none');
					$('#edgeGoodsFaultyTable tfoot tr').eq(0).find('td').eq(85).addClass('d-none');
				}
			});
			
			//전역변수들
 			let edgeSumOutputCnt		= $('#edgeGoodsFaultyTable').DataTable().column(2,{ page: 'all'} ).data().sum();
			let edgeSumAppearOutputCnt	= $('#edgeGoodsFaultyTable').DataTable().column(3,{ page: 'all'} ).data().sum();
			let edgeSumFaulty			= $('#edgeGoodsFaultyTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			let edgeSumFaultyPercent = 100 * edgeSumFaulty / edgeSumOutputCnt;

			$('#edgeSumOutputCnt').html(addCommas(edgeSumOutputCnt));
			$('#edgeSumAppearOutputCnt').html(addCommas(edgeSumAppearOutputCnt));
			$('#edgeSumFaulty').html(addCommas(edgeSumFaulty));
			
			$('#edgeSumFaultyPercent').html(edgeSumFaultyPercent.toFixed(2) + "%");
			
			//지역변수들
			let edgeFaulty1		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(17,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty2		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(18,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty3		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(19,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty4		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(20,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty5		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(21,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty6		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(22,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty7		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(23,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty8		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(24,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty9		=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(25,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty10	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(26,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty11	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(27,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty12	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(28,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty13	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(29,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty14	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(30,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty15	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(31,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty16	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(32,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty17	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(33,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty18	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(34,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty19	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(35,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty20	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(36,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty21	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(37,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty22	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(38,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty23	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(39,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty24	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(40,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty25	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(41,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty26	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(42,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty27	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(43,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty28	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(44,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty29	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(45,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty30	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(46,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty31	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(47,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty32	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(48,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty33	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(49,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty34	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(50,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty35	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(51,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty36	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(52,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty37	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(53,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty38	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(54,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty39	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(55,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty40	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(56,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty41	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(57,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty42	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(58,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty43	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(59,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty44	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(60,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty45	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(61,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty46	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(62,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
			let edgeFaulty47	=	showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(63,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty48    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(64,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty49    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(65,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty50    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(66,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty51    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(67,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty52    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(68,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty53    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(69,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty54    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(70,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty55    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(71,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty56    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(72,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty57    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(73,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty58    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(74,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty59    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(75,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty60    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(76,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty61    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(77,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty62    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(78,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty63    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(79,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty64    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(80,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty65    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(81,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty66    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(82,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty67    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(83,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty68    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(84,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty69    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(85,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty70    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(86,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty71    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(87,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty72    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(88,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty73    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(89,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty74    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(90,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty75    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(91,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty76    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(92,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty77    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(93,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty78    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(94,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty79    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(95,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);
            let edgeFaulty80    =   showTypeChange($('#edgeGoodsFaultyTable').DataTable().column(96,{ page: 'all'} ).data().sum(), edgeSumOutputCnt);

			$('#edgeFaulty1').html(addCommas(edgeFaulty1));
			$('#edgeFaulty2').html(addCommas(edgeFaulty2));
			$('#edgeFaulty3').html(addCommas(edgeFaulty3));
			$('#edgeFaulty4').html(addCommas(edgeFaulty4));
			$('#edgeFaulty5').html(addCommas(edgeFaulty5));
			$('#edgeFaulty6').html(addCommas(edgeFaulty6));
			$('#edgeFaulty7').html(addCommas(edgeFaulty7));
			$('#edgeFaulty8').html(addCommas(edgeFaulty8));
			$('#edgeFaulty9').html(addCommas(edgeFaulty9));
			
			$('#edgeFaulty10').html(addCommas(edgeFaulty10));
			$('#edgeFaulty11').html(addCommas(edgeFaulty11));
			$('#edgeFaulty12').html(addCommas(edgeFaulty12));
			$('#edgeFaulty13').html(addCommas(edgeFaulty13));
			$('#edgeFaulty14').html(addCommas(edgeFaulty14));
			$('#edgeFaulty15').html(addCommas(edgeFaulty15));
			$('#edgeFaulty16').html(addCommas(edgeFaulty16));
			$('#edgeFaulty17').html(addCommas(edgeFaulty17));
			$('#edgeFaulty18').html(addCommas(edgeFaulty18));
			$('#edgeFaulty19').html(addCommas(edgeFaulty19));
			$('#edgeFaulty20').html(addCommas(edgeFaulty20));
			$('#edgeFaulty21').html(addCommas(edgeFaulty21));
			$('#edgeFaulty22').html(addCommas(edgeFaulty22));
			$('#edgeFaulty23').html(addCommas(edgeFaulty23));
			$('#edgeFaulty24').html(addCommas(edgeFaulty24));
			$('#edgeFaulty25').html(addCommas(edgeFaulty25));
			$('#edgeFaulty26').html(addCommas(edgeFaulty26));
			$('#edgeFaulty27').html(addCommas(edgeFaulty27));
			$('#edgeFaulty28').html(addCommas(edgeFaulty28));
			$('#edgeFaulty29').html(addCommas(edgeFaulty29));
			$('#edgeFaulty30').html(addCommas(edgeFaulty30));
			$('#edgeFaulty31').html(addCommas(edgeFaulty31));
			$('#edgeFaulty32').html(addCommas(edgeFaulty32));
			$('#edgeFaulty33').html(addCommas(edgeFaulty33));
			$('#edgeFaulty34').html(addCommas(edgeFaulty34));
			$('#edgeFaulty35').html(addCommas(edgeFaulty35));
			$('#edgeFaulty36').html(addCommas(edgeFaulty36));
			$('#edgeFaulty37').html(addCommas(edgeFaulty37));
			$('#edgeFaulty38').html(addCommas(edgeFaulty38));
			$('#edgeFaulty39').html(addCommas(edgeFaulty39));
			$('#edgeFaulty40').html(addCommas(edgeFaulty40));
			$('#edgeFaulty41').html(addCommas(edgeFaulty41));
			$('#edgeFaulty42').html(addCommas(edgeFaulty42));
			$('#edgeFaulty43').html(addCommas(edgeFaulty43));
			$('#edgeFaulty44').html(addCommas(edgeFaulty44));
			$('#edgeFaulty45').html(addCommas(edgeFaulty45));
			$('#edgeFaulty46').html(addCommas(edgeFaulty46));
			$('#edgeFaulty47').html(addCommas(edgeFaulty47));
			$('#edgeFaulty48').html(addCommas(edgeFaulty48));
			$('#edgeFaulty49').html(addCommas(edgeFaulty49));
			$('#edgeFaulty50').html(addCommas(edgeFaulty50));
			$('#edgeFaulty51').html(addCommas(edgeFaulty51));
			$('#edgeFaulty52').html(addCommas(edgeFaulty52));
			$('#edgeFaulty53').html(addCommas(edgeFaulty53));
			$('#edgeFaulty54').html(addCommas(edgeFaulty54));
			$('#edgeFaulty55').html(addCommas(edgeFaulty55));
			$('#edgeFaulty56').html(addCommas(edgeFaulty56));
			$('#edgeFaulty57').html(addCommas(edgeFaulty57));
			$('#edgeFaulty58').html(addCommas(edgeFaulty58));
			$('#edgeFaulty59').html(addCommas(edgeFaulty59));
			$('#edgeFaulty60').html(addCommas(edgeFaulty60));
			$('#edgeFaulty61').html(addCommas(edgeFaulty61));
			$('#edgeFaulty62').html(addCommas(edgeFaulty62));
			$('#edgeFaulty63').html(addCommas(edgeFaulty63));
			$('#edgeFaulty64').html(addCommas(edgeFaulty64));
			$('#edgeFaulty65').html(addCommas(edgeFaulty65));
			$('#edgeFaulty66').html(addCommas(edgeFaulty66));
			$('#edgeFaulty67').html(addCommas(edgeFaulty67));
			$('#edgeFaulty68').html(addCommas(edgeFaulty68));
			$('#edgeFaulty69').html(addCommas(edgeFaulty69));
			$('#edgeFaulty70').html(addCommas(edgeFaulty70));
			$('#edgeFaulty71').html(addCommas(edgeFaulty71));
			$('#edgeFaulty72').html(addCommas(edgeFaulty72));
			$('#edgeFaulty73').html(addCommas(edgeFaulty73));
			$('#edgeFaulty74').html(addCommas(edgeFaulty74));
			$('#edgeFaulty75').html(addCommas(edgeFaulty75));
			$('#edgeFaulty76').html(addCommas(edgeFaulty76));
			$('#edgeFaulty77').html(addCommas(edgeFaulty77));
			$('#edgeFaulty78').html(addCommas(edgeFaulty78));
			$('#edgeFaulty79').html(addCommas(edgeFaulty79));
			$('#edgeFaulty80').html(addCommas(edgeFaulty80));
			
        },
    });

	/* var html2 = '<div class="row">';
	html2 += '<label class="input-label-sm ml-1">검사일</label><div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control" style="width:97px;" type="text" id="edgeChooseDateFrom" name="edgeChooseDateFrom"/>';
	html2 += '<button onclick="fnPopUpCalendar(edgeChooseDateFrom,edgeChooseDateFrom,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="edgeChooseDateFromCalendar" type="button">';
	html2 += '<span class="oi oi-calendar"></span>';
	html2 += '</button>'; 
	html2 += '</div>';
	html2 += '<label class="input-label-sm ml-1">~</label><div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control" style="width:97px;" type="text" id="edgeChooseDateTo" name="edgeChooseDateTo" />';
	html2 += '<button onclick="fnPopUpCalendar(edgeChooseDateTo,edgeChooseDateTo,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="btnEdgeChooseDateCalendar" type="button">';
	html2 += '<span class="oi oi-calendar"></span>';
	html2 += '</button>'; 
	html2 += '</div>';
	
	html2 += '<label class="input-label-sm ml-3">검사자</label>';
	html2 += '<input type="hidden" class="form-control" id="preWorkCharger2"  name="preWorkCharge2">';
	html2 += '	<div class="input-sub m-0 row">';
	html2 += '	<input type="text" class="form-control" id="preWorkChargerNm2"  name="preWorkChargerNm2" disabled>';
    html2 += '	<button type="button" class="btn btn-primary input-sub-search" id="btnSelPreWorkCharger2" ">';//onClick="selectPreWorkCharger()
	html2 += '	<span class="oi oi-magnifying-glass"></span>';
    html2 += '</button>';
    html2 += '</div>';
    html2 += '<div>';
    html2 += '<a href="javascript:void(0)" id="edgeCancelSearchUser" class="closebtn"><i class="mdi mdi-close"></i></a>';
    html2 += '</div>';
    
	html2 += '&nbsp;<button type="button" class="btn btn-primary ml-2" id="btnEdgeRetv">조회</button>';
	html2 += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">형식</label>';
	html2 += '<select class="custom-select" style="min-width:70px; max-width: 70px;" id="edgeShowType">';
	html2 += '<option value="edgeShowType001">개수</option>';
	html2 += '<option value="edgeShowType002">%</option>';
	html2 += '</select>';
	html2 += '</div>'; */

	//$('#edgeGoodsFaultyDateLookup').html(html2);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	
	//엣지검사 검색
	$('#edgeGoodsFaultyTable_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#edgeGoodsFaultyTable_filter').find('label').eq(0).addClass('row ml-3');
	$('#edgeGoodsFaultyTable_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#edgeGoodsFaultyTable_filter").insertAfter("#showType");
	$("#edgeGoodsFaultyTable_filter").addClass("d-none");
	
	//엣지검사 테이블 클릭 시
  	$('#edgeGoodsFaultyTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
// 			$(this).removeClass('selected');
		} else {
			$('#edgeGoodsFaultyTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});



  	//---------------------------------------------------------------------작지 번호 별 -----------------------------------------------------//
  	

	let workOrderUserNumber         = null;
	let workOrderGubunVal = 'check';
	//작지번호별 목록
	$.fn.dataTable.ext.errMode = 'none';
	let workOrderTable = $('#workOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX: false,
//        scroolY : "58vh",
        lengthChange: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/workOrderTotalDataList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
				'workOrderGubun'    :       function() { return workOrderGubunVal;},
            },
        },
		//rowId: 'workOrdNo',
        columns: [
        	{
				render: function(data, type, row) {
					return moment(row['workOrdDate']).format('YYYY-MM-DD');
				}
			},//작업지시일
        	{data:'userInputInspctCnt'},//검사수량
        	{data:'appearOutputCnt'},//양품수량
        	{data:'appearFaultyCnt'},//불량수량
        	{data:'visionFaultySum',//생산비전불량수량
        		render: function(data, type, row) {
            		let temp;
        			if(data == 'null'){
                		temp = 0;
                	} else {
                		temp = addCommas(data);
                    }
                    return temp;
        		}
        	},
        	{
        		render: function(data, type, row) {
        			return parseFloat((parseInt(row['appearFaultyCnt']))/row['userInputInspctCnt']*100).toFixed(2) + " %";
				}
        	},//불량률
        	{
        		render: function(data, type, row) {
					return moment(row['ordDate']).format('YYYY-MM-DD');
        		}
			},//생산일
        	{data:'equipNm'},//설비명
        	{data:'workOrdNo'},//작지번호
        	{data:'workOrdLotNo'},//생산lotNo
        	{data:'goodsNm'},//제품
        	{data:'qutyNm'},//재질
        	{data:'model'},//규격
        	{data:'lotNo'},//주자재
        	{data:'subFilm1'},
        	{data:'subFilm2'},
        	{data:'subFilm3'},
        	{data:'subFilm4'},
        	{ data: 'faulty1',
        		render: function(data, type, row) {
            		if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty2',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty3',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty4',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty5',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty6',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty7',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty8',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty9',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty10',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty11',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty12',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty13',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty14',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty15',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty16',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty17',
        		render: function(data, type, row) {
        			if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty18',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty19',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty20',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty21',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty22',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty23',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty24',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty25',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty26',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty27',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty28',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty29',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty30',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty31',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty32',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty33',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty34',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty35',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty36',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty37',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty38',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty39',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty40',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty41',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty42',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty43',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty44',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty45',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty46',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty47',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty48',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty49',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty50',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty51',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty52',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty53',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty54',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty55',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty56',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty57',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty58',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty59',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty60',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty61',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty62',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty63',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty64',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty65',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty66',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty67',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty68',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty69',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty70',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty71',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty72',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {						
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty73',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty74',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty75',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty76',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty77',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty78',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty79',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty80',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty81',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty82',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty83',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty84',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty85',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty86',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty87',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty88',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty89',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty90',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty91',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty92',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty93',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty94',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty95',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty96',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty97',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty98',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty99',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty100',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty101',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty102',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty103',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty104',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty105',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty106',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty107',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty108',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty109',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty110',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty111',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty112',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty113',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty114',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty115',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty116',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty117',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty118',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty119',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty120',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty121',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty122',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty123',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty124',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty125',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty126',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty127',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty128',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty129',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty130',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty131',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty132',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty133',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty134',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty135',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty136',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty137',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty138',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty139',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty140',
        		render: function(data, type, row) {
        			if( data =='null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},

        ],
        buttons: [
            {
                extend: 'copy',
                title: '최종검사현황-작업지시별',
            },
            {
				extend: 'excel',
				title: '최종검사현황-작업지시별',
				exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (row == 10 || row == 11) {
								data = data.replace('<p style="color:red; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('<p style="color:blue; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('</p>', '');
								return data;
							}
							if (showType == 'showType001') {
								if (row == 6) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 6) { return data.replace(" %", ""); }
								else if (row == 17) { return data.replace(" %", ""); }
								else if (row == 18) { return data.replace(" %", ""); }
								else if (row == 19) { return data.replace(" %", ""); }
								else if (row == 20) { return data.replace(" %", ""); }
								else if (row == 21) { return data.replace(" %", ""); }
								else if (row == 22) { return data.replace(" %", ""); }
								else if (row == 23) { return data.replace(" %", ""); }
								else if (row == 24) { return data.replace(" %", ""); }
								else if (row == 25) { return data.replace(" %", ""); }
								else if (row == 26) { return data.replace(" %", ""); }
								else if (row == 27) { return data.replace(" %", ""); }
								else if (row == 28) { return data.replace(" %", ""); }
								else if (row == 29) { return data.replace(" %", ""); }
								else if (row == 30) { return data.replace(" %", ""); }
								else if (row == 31) { return data.replace(" %", ""); }
								else if (row == 32) { return data.replace(" %", ""); }
								else if (row == 33) { return data.replace(" %", ""); }
								else if (row == 34) { return data.replace(" %", ""); }
								else if (row == 35) { return data.replace(" %", ""); }
								else if (row == 36) { return data.replace(" %", ""); }
								else if (row == 37) { return data.replace(" %", ""); }
								else if (row == 38) { return data.replace(" %", ""); }
								else if (row == 39) { return data.replace(" %", ""); }
								else if (row == 40) { return data.replace(" %", ""); }
								else if (row == 41) { return data.replace(" %", ""); }
								else if (row == 42) { return data.replace(" %", ""); }
								else if (row == 43) { return data.replace(" %", ""); }
								else if (row == 44) { return data.replace(" %", ""); }
								else if (row == 45) { return data.replace(" %", ""); }
								else if (row == 46) { return data.replace(" %", ""); }
								else if (row == 47) { return data.replace(" %", ""); }
								else if (row == 48) { return data.replace(" %", ""); }
								else if (row == 49) { return data.replace(" %", ""); }
								else if (row == 50) { return data.replace(" %", ""); }
								else if (row == 51) { return data.replace(" %", ""); }
								else if (row == 52) { return data.replace(" %", ""); }
								else if (row == 53) { return data.replace(" %", ""); }
								else if (row == 54) { return data.replace(" %", ""); }
								else if (row == 55) { return data.replace(" %", ""); }
								else if (row == 56) { return data.replace(" %", ""); }
								else if (row == 57) { return data.replace(" %", ""); }
								else if (row == 58) { return data.replace(" %", ""); }
								else if (row == 59) { return data.replace(" %", ""); }
								else if (row == 60) { return data.replace(" %", ""); }
								else if (row == 61) { return data.replace(" %", ""); }
								else if (row == 62) { return data.replace(" %", ""); }
								else if (row == 63) { return data.replace(" %", ""); }
								else if (row == 64) { return data.replace(" %", ""); }
								else if (row == 65) { return data.replace(" %", ""); }
								else if (row == 66) { return data.replace(" %", ""); }							
								else if (row == 67) { return data.replace(" %", ""); }
								else if (row == 68) { return data.replace(" %", ""); }
								else if (row == 69) { return data.replace(" %", ""); }
								else if (row == 70) { return data.replace(" %", ""); }
								else if (row == 71) { return data.replace(" %", ""); }
								else if (row == 72) { return data.replace(" %", ""); }
								else if (row == 73) { return data.replace(" %", ""); }
								else if (row == 74) { return data.replace(" %", ""); }
								else if (row == 75) { return data.replace(" %", ""); }
								else if (row == 76) { return data.replace(" %", ""); }
								else if (row == 77) { return data.replace(" %", ""); }
								else if (row == 78) { return data.replace(" %", ""); }
								else if (row == 79) { return data.replace(" %", ""); }
								else if (row == 80) { return data.replace(" %", ""); }
								else if (row == 81) { return data.replace(" %", ""); }
								else if (row == 82) { return data.replace(" %", ""); }
								else if (row == 83) { return data.replace(" %", ""); }
								else if (row == 84) { return data.replace(" %", ""); }
								else if (row == 85) { return data.replace(" %", ""); }
								else if (row == 86) { return data.replace(" %", ""); }
								else if (row == 87) { return data.replace(" %", ""); }
								else if (row == 88) { return data.replace(" %", ""); }
								else if (row == 89) { return data.replace(" %", ""); }
								else if (row == 90) { return data.replace(" %", ""); }
								else if (row == 91) { return data.replace(" %", ""); }
								else if (row == 92) { return data.replace(" %", ""); }
								else if (row == 93) { return data.replace(" %", ""); }
								else if (row == 94) { return data.replace(" %", ""); }
								else if (row == 95) { return data.replace(" %", ""); }
								else if (row == 96) { return data.replace(" %", ""); }
								else if (row == 97) { return data.replace(" %", ""); }
								else if (row == 98) { return data.replace(" %", ""); }
								else if (row == 99) { return data.replace(" %", ""); }
								else if (row == 100) { return data.replace(" %", ""); }
								else if (row == 101) { return data.replace(" %", ""); }
								else if (row == 102) { return data.replace(" %", ""); }
								else if (row == 103) { return data.replace(" %", ""); }
								else if (row == 104) { return data.replace(" %", ""); }
								else if (row == 105) { return data.replace(" %", ""); }
								else if (row == 106) { return data.replace(" %", ""); }
								else if (row == 107) { return data.replace(" %", ""); }
								else if (row == 108) { return data.replace(" %", ""); }
								else if (row == 109) { return data.replace(" %", ""); }
								else if (row == 110) { return data.replace(" %", ""); }
								else if (row == 111) { return data.replace(" %", ""); }
								else if (row == 112) { return data.replace(" %", ""); }
								else if (row == 113) { return data.replace(" %", ""); }
								else if (row == 114) { return data.replace(" %", ""); }
								else if (row == 115) { return data.replace(" %", ""); }
								else if (row == 116) { return data.replace(" %", ""); }
								else if (row == 117) { return data.replace(" %", ""); }
								else if (row == 118) { return data.replace(" %", ""); }
								else if (row == 119) { return data.replace(" %", ""); }
								else if (row == 120) { return data.replace(" %", ""); }
								else if (row == 121) { return data.replace(" %", ""); }
								else if (row == 122) { return data.replace(" %", ""); }
								else if (row == 123) { return data.replace(" %", ""); }
								else if (row == 124) { return data.replace(" %", ""); }
								else if (row == 125) { return data.replace(" %", ""); }
								else if (row == 126) { return data.replace(" %", ""); }
								else if (row == 127) { return data.replace(" %", ""); }
								else if (row == 128) { return data.replace(" %", ""); }
								else if (row == 129) { return data.replace(" %", ""); }
								else if (row == 130) { return data.replace(" %", ""); }
								else if (row == 131) { return data.replace(" %", ""); }
								else if (row == 132) { return data.replace(" %", ""); }
								else if (row == 133) { return data.replace(" %", ""); }
								else if (row == 134) { return data.replace(" %", ""); }
								else if (row == 135) { return data.replace(" %", ""); }
								else if (row == 136) { return data.replace(" %", ""); }
								else if (row == 137) { return data.replace(" %", ""); }
								else if (row == 138) { return data.replace(" %", ""); }
								else if (row == 139) { return data.replace(" %", ""); }
								else if (row == 140) { return data.replace(" %", ""); }
								else if (row == 141) { return data.replace(" %", ""); }
								else if (row == 142) { return data.replace(" %", ""); }
								else if (row == 143) { return data.replace(" %", ""); }
								else if (row == 144) { return data.replace(" %", ""); }
								else if (row == 145) { return data.replace(" %", ""); }
								else if (row == 146) { return data.replace(" %", ""); }
								else if (row == 147) { return data.replace(" %", ""); }
								else if (row == 148) { return data.replace(" %", ""); }
								else if (row == 149) { return data.replace(" %", ""); }
								else if (row == 150) { return data.replace(" %", ""); }
								else if (row == 151) { return data.replace(" %", ""); }
								else if (row == 152) { return data.replace(" %", ""); }
								else if (row == 153) { return data.replace(" %", ""); }
								else if (row == 154) { return data.replace(" %", ""); }
								else if (row == 155) { return data.replace(" %", ""); }
								else if (row == 156) { return data.replace(" %", ""); }
								else { return data; }
							}
						}
				    }
				}
            },
            {
                extend: 'print',
                title: '최종검사현황-작업지시별',
            },
        ],
		columnDefs: [
			{ targets: [1,2,3,4,5,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [1,2,3,4,5,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], className: 'text-right' },
		],
		drawCallback: function () {
			$('#workOrderTable').attr('style', 'margin-top: -1px !important;');
			$.each($('#workOrderTable tbody tr'),function(index,item){
				if ($('#workOrderTable .0').text()==""){            	
					$('#workOrderTable .0').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(7).addClass('d-none');
				}
				if ($('#workOrderTable .1').text() == "") {
					$('#workOrderTable .1').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(8).addClass('d-none');
					
				}
				if ($('#workOrderTable .2').text() == "") {
					$('#workOrderTable .2').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(9).addClass('d-none');
					
				}
				if ($('#workOrderTable .3').text() == "") {
					$('#workOrderTable .3').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(10).addClass('d-none');
					
				}
				if ($('#workOrderTable .4').text() == "") {
					$('#workOrderTable .4').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(11).addClass('d-none');
					
				}
				if ($('#workOrderTable .5').text() == "") {
					$('#workOrderTable .5').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(12).addClass('d-none');
					
				}
				if ($('#workOrderTable .6').text() == "") {
					$('#workOrderTable .6').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(13).addClass('d-none');
					
				}
				if ($('#workOrderTable .7').text() == "") {
					$('#workOrderTable .7').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(14).addClass('d-none');
					
				}
				if ($('#workOrderTable .8').text() == "") {
					$('#workOrderTable .8').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(15).addClass('d-none');
					
				}
				if ($('#workOrderTable .9').text() == "") {
					$('#workOrderTable .9').addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(16).addClass('d-none');
					
				}
				if ($('#workOrderTable .10').text() == "") {
					$('#workOrderTable .10').addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(17).addClass('d-none');
					
				}
				if ($('#workOrderTable .11').text() == "") {
					$('#workOrderTable .11').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(18).addClass('d-none');
					
				}
				if ($('#workOrderTable .12').text() == "") {
					$('#workOrderTable .12').addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(19).addClass('d-none');
					
				}
				if ($('#workOrderTable .13').text() == "") {
					$('#workOrderTable .13').addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(20).addClass('d-none');
					
				}
				if ($('#workOrderTable .14').text() == "") {
					$('#workOrderTable .14').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(21).addClass('d-none');
					
				}
				if ($('#workOrderTable .15').text() == "") {
					$('#workOrderTable .15').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(22).addClass('d-none');
					
				}
				if ($('#workOrderTable .16').text() == "") {
					$('#workOrderTable .16').addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(23).addClass('d-none');
					
				}
				if ($('#workOrderTable .17').text() == "") {
					$('#workOrderTable .17').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(24).addClass('d-none');
					
				}
				if ($('#workOrderTable .18').text() == "") {
					$('#workOrderTable .18').addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(25).addClass('d-none');
					
				}
				if ($('#workOrderTable .19').text() == "") {
					$('#workOrderTable .19').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(26).addClass('d-none');
					
				}
				if ($('#workOrderTable .20').text() == "") {
					$('#workOrderTable .20').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(27).addClass('d-none');
					
				}
				if ($('#workOrderTable .21').text() == "") {
					$('#workOrderTable .21').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(28).addClass('d-none');
					
				}
				if ($('#workOrderTable .22').text() == "") {
					$('#workOrderTable .22').addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(29).addClass('d-none');
					
				}
				if ($('#workOrderTable .23').text() == "") {
					$('#workOrderTable .23').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(30).addClass('d-none');
					
				}
				if ($('#workOrderTable .24').text() == "") {
					$('#workOrderTable .24').addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(31).addClass('d-none');
					
				}
				if ($('#workOrderTable .25').text() == "") {
					$('#workOrderTable .25').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(32).addClass('d-none');
					
				}
				if ($('#workOrderTable .26').text() == "") {
					$('#workOrderTable .26').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(33).addClass('d-none');
					
				}
				if ($('#workOrderTable .27').text() == "") {
					$('#workOrderTable .27').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(34).addClass('d-none');
					
				}
				if ($('#workOrderTable .28').text() == "") {
					$('#workOrderTable .28').addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(35).addClass('d-none');
					
				}
				if ($('#workOrderTable .29').text() == "") {
					$('#workOrderTable .29').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(36).addClass('d-none');
					
				}
				if ($('#workOrderTable .30').text() == "") {
					$('#workOrderTable .30').addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(37).addClass('d-none');
					
				}
				if ($('#workOrderTable .31').text() == "") {
					$('#workOrderTable .31').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(38).addClass('d-none');
					
				}
				if ($('#workOrderTable .32').text() == "") {
					$('#workOrderTable .32').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(39).addClass('d-none');
					
				}
				if ($('#workOrderTable .33').text() == "") {
					$('#workOrderTable .33').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(40).addClass('d-none');
					
				}
				if ($('#workOrderTable .34').text() == "") {
					$('#workOrderTable .34').addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(41).addClass('d-none');
					
				}
				if ($('#workOrderTable .35').text() == "") {
					$('#workOrderTable .35').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(42).addClass('d-none');
					
				}
				if ($('#workOrderTable .36').text() == "") {
					$('#workOrderTable .36').addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(43).addClass('d-none');
					
				}
				if ($('#workOrderTable .37').text() == "") {
					$('#workOrderTable .37').addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(44).addClass('d-none');
					
				}
				if ($('#workOrderTable .38').text() == "") {
					$('#workOrderTable .38').addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(45).addClass('d-none');
					
				}
				if ($('#workOrderTable .39').text() == "") {
					$('#workOrderTable .39').addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(46).addClass('d-none');
					
				}
				if ($('#workOrderTable .40').text() == "") {
					$('#workOrderTable .40').addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(47).addClass('d-none');
					
				}
				if ($('#workOrderTable .41').text() == "") {
					$('#workOrderTable .41').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(48).addClass('d-none');
					
				}
				if ($('#workOrderTable .42').text() == "") {
					$('#workOrderTable .42').addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(49).addClass('d-none');
					
				}
				if ($('#workOrderTable .43').text() == "") {
					$('#workOrderTable .43').addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(50).addClass('d-none');
					
				}
				if ($('#workOrderTable .44').text() == "") {
					$('#workOrderTable .44').addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(51).addClass('d-none');
					
				}
				if ($('#workOrderTable .45').text() == "") {
					$('#workOrderTable .45').addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(52).addClass('d-none');
					
				}
				if ($('#workOrderTable .46').text() == "") {
					$('#workOrderTable .46').addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(53).addClass('d-none');
					
				}
				if ($('#workOrderTable .47').text() == "") {
					$('#workOrderTable .47').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(54).addClass('d-none');
					
				}
				if ($('#workOrderTable .48').text() == "") {
					$('#workOrderTable .48').addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(55).addClass('d-none');
					
				}
				if ($('#workOrderTable .49').text() == "") {
					$('#workOrderTable .49').addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(56).addClass('d-none');
					
				}
				if ($('#workOrderTable .50').text() == "") {
					$('#workOrderTable .50').addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(57).addClass('d-none');
					
				}
				if ($('#workOrderTable .51').text() == "") {
					$('#workOrderTable .51').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(58).addClass('d-none');
					
				}
				if ($('#workOrderTable .52').text() == "") {
					$('#workOrderTable .52').addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(59).addClass('d-none');
					
				}
				if ($('#workOrderTable .53').text() == "") {
					$('#workOrderTable .53').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(60).addClass('d-none');
					
				}
				if ($('#workOrderTable .54').text() == "") {
					$('#workOrderTable .54').addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(61).addClass('d-none');
					
				}
				if ($('#workOrderTable .55').text() == "") {
					$('#workOrderTable .55').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(62).addClass('d-none');
					
				}
				if ($('#workOrderTable .56').text() == "") {
					$('#workOrderTable .56').addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(63).addClass('d-none');
					
				}
				if ($('#workOrderTable .57').text() == "") {
					$('#workOrderTable .57').addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(64).addClass('d-none');
					
				}
				if ($('#workOrderTable .58').text() == "") {
					$('#workOrderTable .58').addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(65).addClass('d-none');
					
				}
				if ($('#workOrderTable .59').text() == "") {
					$('#workOrderTable .59').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(66).addClass('d-none');
					
				}
				if ($('#workOrderTable .60').text() == "") {
					$('#workOrderTable .60').addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(67).addClass('d-none');
					
				}
				if ($('#workOrderTable .61').text() == "") {
					$('#workOrderTable .61').addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(68).addClass('d-none');
					
				}
				if ($('#workOrderTable .62').text() == "") {
					$('#workOrderTable .62').addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(69).addClass('d-none');
					
				}
				if ($('#workOrderTable .63').text() == "") {
					$('#workOrderTable .63').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(70).addClass('d-none');
					
				}
				if ($('#workOrderTable .64').text() == "") {
					$('#workOrderTable .64').addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(71).addClass('d-none');
					
				}
				if ($('#workOrderTable .65').text() == "") {
					$('#workOrderTable .65').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(72).addClass('d-none');
					
				}
				if ($('#workOrderTable .66').text() == "") {
					$('#workOrderTable .66').addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(73).addClass('d-none');
					
				}
				if ($('#workOrderTable .67').text() == "") {
					$('#workOrderTable .67').addClass('d-none');
					$(this).find('td').eq(85).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(74).addClass('d-none');
					
				}
				if ($('#workOrderTable .68').text() == "") {
					$('#workOrderTable .68').addClass('d-none');
					$(this).find('td').eq(86).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(75).addClass('d-none');
					
				}
				if ($('#workOrderTable .69').text() == "") {
					$('#workOrderTable .69').addClass('d-none');
					$(this).find('td').eq(87).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(76).addClass('d-none');
					
				}
				if ($('#workOrderTable .70').text() == "") {
					$('#workOrderTable .70').addClass('d-none');
					$(this).find('td').eq(88).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(77).addClass('d-none');
					
				}
				if ($('#workOrderTable .71').text() == "") {
					$('#workOrderTable .71').addClass('d-none');
					$(this).find('td').eq(89).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(78).addClass('d-none');
					
				}
				if ($('#workOrderTable .72').text() == "") {
					$('#workOrderTable .72').addClass('d-none');
					$(this).find('td').eq(90).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(79).addClass('d-none');
					
				}
				if ($('#workOrderTable .73').text() == "") {
					$('#workOrderTable .73').addClass('d-none');
					$(this).find('td').eq(91).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(80).addClass('d-none');
					
				}
				if ($('#workOrderTable .74').text() == "") {
					$('#workOrderTable .74').addClass('d-none');
					$(this).find('td').eq(92).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(81).addClass('d-none');
					
				}
				if ($('#workOrderTable .75').text() == "") {
					$('#workOrderTable .75').addClass('d-none');
					$(this).find('td').eq(93).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(82).addClass('d-none');
					
				}
				if ($('#workOrderTable .76').text() == "") {
					$('#workOrderTable .76').addClass('d-none');
					$(this).find('td').eq(94).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(83).addClass('d-none');
					
				}
				if ($('#workOrderTable .77').text() == "") {
					$('#workOrderTable .77').addClass('d-none');
					$(this).find('td').eq(95).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(84).addClass('d-none');
					
				}
				if ($('#workOrderTable .78').text() == "") {
					$('#workOrderTable .78').addClass('d-none');
					$(this).find('td').eq(96).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(85).addClass('d-none');
					
				}
				if ($('#workOrderTable .79').text() == "") {
					$('#workOrderTable .79').addClass('d-none');
					$(this).find('td').eq(97).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(86).addClass('d-none');
				}

				if ($('#workOrderTable .80').text() == "") {
					$('#workOrderTable .80').addClass('d-none');
					$(this).find('td').eq(98).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(87).addClass('d-none');
				}
				if ($('#workOrderTable .81').text() == "") {
					$('#workOrderTable .81').addClass('d-none');
					$(this).find('td').eq(99).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(88).addClass('d-none');
				}
				if ($('#workOrderTable .82').text() == "") {
					$('#workOrderTable .82').addClass('d-none');
					$(this).find('td').eq(100).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(89).addClass('d-none');
				}
				if ($('#workOrderTable .83').text() == "") {
					$('#workOrderTable .83').addClass('d-none');
					$(this).find('td').eq(101).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(90).addClass('d-none');
				}
				if ($('#workOrderTable .84').text() == "") {
					$('#workOrderTable .84').addClass('d-none');
					$(this).find('td').eq(102).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(91).addClass('d-none');
				}
				if ($('#workOrderTable .85').text() == "") {
					$('#workOrderTable .85').addClass('d-none');
					$(this).find('td').eq(103).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(92).addClass('d-none');
				}
				if ($('#workOrderTable .86').text() == "") {
					$('#workOrderTable .86').addClass('d-none');
					$(this).find('td').eq(104).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(93).addClass('d-none');
				}
				if ($('#workOrderTable .87').text() == "") {
					$('#workOrderTable .87').addClass('d-none');
					$(this).find('td').eq(105).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(94).addClass('d-none');
				}
				if ($('#workOrderTable .88').text() == "") {
					$('#workOrderTable .88').addClass('d-none');
					$(this).find('td').eq(106).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(95).addClass('d-none');
				}	
				if ($('#workOrderTable .89').text() == "") {
					$('#workOrderTable .89').addClass('d-none');
					$(this).find('td').eq(107).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(96).addClass('d-none');
				}
				if ($('#workOrderTable .90').text() == "") {
					$('#workOrderTable .90').addClass('d-none');
					$(this).find('td').eq(108).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(97).addClass('d-none');
				}
				if ($('#workOrderTable .91').text() == "") {
					$('#workOrderTable .91').addClass('d-none');
					$(this).find('td').eq(109).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(98).addClass('d-none');
				}
				if ($('#workOrderTable .92').text() == "") {
					$('#workOrderTable .92').addClass('d-none');
					$(this).find('td').eq(110).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(99).addClass('d-none');
				}
				if ($('#workOrderTable .93').text() == "") {
					$('#workOrderTable .93').addClass('d-none');
					$(this).find('td').eq(111).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(100).addClass('d-none');
				}
				if ($('#workOrderTable .94').text() == "") {
					$('#workOrderTable .94').addClass('d-none');
					$(this).find('td').eq(112).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(101).addClass('d-none');
				}
				if ($('#workOrderTable .95').text() == "") {
					$('#workOrderTable .95').addClass('d-none');
					$(this).find('td').eq(113).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(102).addClass('d-none');
				}
				if ($('#workOrderTable .96').text() == "") {
					$('#workOrderTable .96').addClass('d-none');
					$(this).find('td').eq(114).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(103).addClass('d-none');
				}
				if ($('#workOrderTable .97').text() == "") {
					$('#workOrderTable .97').addClass('d-none');
					$(this).find('td').eq(115).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(104).addClass('d-none');
				}
				if ($('#workOrderTable .98').text() == "") {
					$('#workOrderTable .98').addClass('d-none');
					$(this).find('td').eq(116).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(105).addClass('d-none');
				}
				if ($('#workOrderTable .99').text() == "") {
					$('#workOrderTable .99').addClass('d-none');
					$(this).find('td').eq(117).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(106).addClass('d-none');
				}
				if ($('#workOrderTable .100').text() == "") {
					$('#workOrderTable .100').addClass('d-none');
					$(this).find('td').eq(118).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(107).addClass('d-none');
				}
				if ($('#workOrderTable .101').text() == "") {
					$('#workOrderTable .101').addClass('d-none');
					$(this).find('td').eq(119).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(108).addClass('d-none');
				}
				if ($('#workOrderTable .102').text() == "") {
					$('#workOrderTable .102').addClass('d-none');
					$(this).find('td').eq(120).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(109).addClass('d-none');
				}
				if ($('#workOrderTable .103').text() == "") {
					$('#workOrderTable .103').addClass('d-none');
					$(this).find('td').eq(121).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(110).addClass('d-none');
				}
				if ($('#workOrderTable .104').text() == "") {
					$('#workOrderTable .104').addClass('d-none');
					$(this).find('td').eq(122).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(111).addClass('d-none');
				}
				if ($('#workOrderTable .105').text() == "") {
					$('#workOrderTable .105').addClass('d-none');
					$(this).find('td').eq(123).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(112).addClass('d-none');
				}
				if ($('#workOrderTable .106').text() == "") {
					$('#workOrderTable .106').addClass('d-none');
					$(this).find('td').eq(124).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(113).addClass('d-none');
				}
				if ($('#workOrderTable .107').text() == "") {
					$('#workOrderTable .107').addClass('d-none');
					$(this).find('td').eq(125).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(114).addClass('d-none');
				}
				if ($('#workOrderTable .108').text() == "") {
					$('#workOrderTable .108').addClass('d-none');
					$(this).find('td').eq(126).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(115).addClass('d-none');
				}
				if ($('#workOrderTable .109').text() == "") {
					$('#workOrderTable .109').addClass('d-none');
					$(this).find('td').eq(127).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(116).addClass('d-none');
				}
				if ($('#workOrderTable .110').text() == "") {
					$('#workOrderTable .110').addClass('d-none');
					$(this).find('td').eq(128).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(117).addClass('d-none');
				}
				if ($('#workOrderTable .111').text() == "") {
					$('#workOrderTable .111').addClass('d-none');
					$(this).find('td').eq(129).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(118).addClass('d-none');
				}
				if ($('#workOrderTable .112').text() == "") {
					$('#workOrderTable .112').addClass('d-none');
					$(this).find('td').eq(130).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(119).addClass('d-none');
				}
				if ($('#workOrderTable .113').text() == "") {
					$('#workOrderTable .113').addClass('d-none');
					$(this).find('td').eq(131).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(120).addClass('d-none');
				}
				if ($('#workOrderTable .114').text() == "") {
					$('#workOrderTable .114').addClass('d-none');
					$(this).find('td').eq(132).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(121).addClass('d-none');
				}
				if ($('#workOrderTable .115').text() == "") {
					$('#workOrderTable .115').addClass('d-none');
					$(this).find('td').eq(133).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(122).addClass('d-none');
				}
				if ($('#workOrderTable .116').text() == "") {
					$('#workOrderTable .116').addClass('d-none');
					$(this).find('td').eq(134).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(123).addClass('d-none');
				}
				if ($('#workOrderTable .117').text() == "") {
					$('#workOrderTable .117').addClass('d-none');
					$(this).find('td').eq(135).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(124).addClass('d-none');
				}
				if ($('#workOrderTable .118').text() == "") {
					$('#workOrderTable .118').addClass('d-none');
					$(this).find('td').eq(136).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(125).addClass('d-none');
				}
				if ($('#workOrderTable .119').text() == "") {
					$('#workOrderTable .119').addClass('d-none');
					$(this).find('td').eq(137).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(126).addClass('d-none');
				}
				if ($('#workOrderTable .120').text() == "") {
					$('#workOrderTable .120').addClass('d-none');
					$(this).find('td').eq(138).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(127).addClass('d-none');
				}
				if ($('#workOrderTable .121').text() == "") {
					$('#workOrderTable .121').addClass('d-none');
					$(this).find('td').eq(139).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(128).addClass('d-none');
				}
				if ($('#workOrderTable .122').text() == "") {
					$('#workOrderTable .122').addClass('d-none');
					$(this).find('td').eq(140).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(129).addClass('d-none');
				}
				if ($('#workOrderTable .123').text() == "") {
					$('#workOrderTable .123').addClass('d-none');
					$(this).find('td').eq(141).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(130).addClass('d-none');
				}
				if ($('#workOrderTable .124').text() == "") {
					$('#workOrderTable .124').addClass('d-none');
					$(this).find('td').eq(142).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(131).addClass('d-none');
				}
				if ($('#workOrderTable .125').text() == "") {
					$('#workOrderTable .125').addClass('d-none');
					$(this).find('td').eq(143).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(132).addClass('d-none');
				}
				if ($('#workOrderTable .126').text() == "") {
					$('#workOrderTable .126').addClass('d-none');
					$(this).find('td').eq(144).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(133).addClass('d-none');
				}
				if ($('#workOrderTable .127').text() == "") {
					$('#workOrderTable .127').addClass('d-none');
					$(this).find('td').eq(145).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(134).addClass('d-none');
				}
				if ($('#workOrderTable .128').text() == "") {
					$('#workOrderTable .128').addClass('d-none');
					$(this).find('td').eq(146).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(135).addClass('d-none');
				}
				if ($('#workOrderTable .129').text() == "") {
					$('#workOrderTable .129').addClass('d-none');
					$(this).find('td').eq(147).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(136).addClass('d-none');
				}
				if ($('#workOrderTable .130').text() == "") {
					$('#workOrderTable .130').addClass('d-none');
					$(this).find('td').eq(148).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(137).addClass('d-none');
				}
				if ($('#workOrderTable .131').text() == "") {
					$('#workOrderTable .131').addClass('d-none');
					$(this).find('td').eq(149).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(138).addClass('d-none');
				}
				if ($('#workOrderTable .132').text() == "") {
					$('#workOrderTable .132').addClass('d-none');
					$(this).find('td').eq(150).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(139).addClass('d-none');
				}
				if ($('#workOrderTable .133').text() == "") {
					$('#workOrderTable .133').addClass('d-none');
					$(this).find('td').eq(151).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(140).addClass('d-none');
				}
				if ($('#workOrderTable .134').text() == "") {
					$('#workOrderTable .134').addClass('d-none');
					$(this).find('td').eq(152).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(141).addClass('d-none');
				}
				if ($('#workOrderTable .135').text() == "") {
					$('#workOrderTable .135').addClass('d-none');
					$(this).find('td').eq(153).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(142).addClass('d-none');
				}
				if ($('#workOrderTable .136').text() == "") {
					$('#workOrderTable .136').addClass('d-none');
					$(this).find('td').eq(154).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(143).addClass('d-none');
				}
				if ($('#workOrderTable .137').text() == "") {
					$('#workOrderTable .137').addClass('d-none');
					$(this).find('td').eq(155).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(144).addClass('d-none');
				}
				if ($('#workOrderTable .138').text() == "") {
					$('#workOrderTable .138').addClass('d-none');
					$(this).find('td').eq(156).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(145).addClass('d-none');
				}
				if ($('#workOrderTable .139').text() == "") {
					$('#workOrderTable .139').addClass('d-none');
					$(this).find('td').eq(157).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(146).addClass('d-none');
				}
				if ($('#workOrderTable .140').text() == "") {
					$('#workOrderTable .140').addClass('d-none');
					$(this).find('td').eq(158).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(147).addClass('d-none');
				}
				if ($('#workOrderTable .141').text() == "") {
					$('#workOrderTable .141').addClass('d-none');
					$(this).find('td').eq(159).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(148).addClass('d-none');
				}
				if ($('#workOrderTable .142').text() == "") {
					$('#workOrderTable .142').addClass('d-none');
					$(this).find('td').eq(160).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(149).addClass('d-none');
				}
				if ($('#workOrderTable .143').text() == "") {
					$('#workOrderTable .143').addClass('d-none');
					$(this).find('td').eq(161).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(150).addClass('d-none');
				}
				if ($('#workOrderTable .144').text() == "") {
					$('#workOrderTable .144').addClass('d-none');
					$(this).find('td').eq(162).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(151).addClass('d-none');
				}
				if ($('#workOrderTable .145').text() == "") {
					$('#workOrderTable .145').addClass('d-none');
					$(this).find('td').eq(163).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(152).addClass('d-none');
				}
				if ($('#workOrderTable .146').text() == "") {
					$('#workOrderTable .146').addClass('d-none');
					$(this).find('td').eq(164).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(153).addClass('d-none');
				}
				if ($('#workOrderTable .147').text() == "") {
					$('#workOrderTable .147').addClass('d-none');
					$(this).find('td').eq(165).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(154).addClass('d-none');
				}
				if ($('#workOrderTable .148').text() == "") {
					$('#workOrderTable .148').addClass('d-none');
					$(this).find('td').eq(166).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(155).addClass('d-none');
				}
				if ($('#workOrderTable .149').text() == "") {
					$('#workOrderTable .149').addClass('d-none');
					$(this).find('td').eq(167).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(156).addClass('d-none');
				}
				if ($('#workOrderTable .150').text() == "") {
					$('#workOrderTable .150').addClass('d-none');
					$(this).find('td').eq(168).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(157).addClass('d-none');
				}
				if ($('#workOrderTable .151').text() == "") {
					$('#workOrderTable .151').addClass('d-none');
					$(this).find('td').eq(169).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(158).addClass('d-none');
				}
				if ($('#workOrderTable .152').text() == "") {
					$('#workOrderTable .152').addClass('d-none');
					$(this).find('td').eq(170).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(159).addClass('d-none');
				}
				if ($('#workOrderTable .153').text() == "") {
					$('#workOrderTable .153').addClass('d-none');
					$(this).find('td').eq(171).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(160).addClass('d-none');
				}
				if ($('#workOrderTable .154').text() == "") {
					$('#workOrderTable .154').addClass('d-none');
					$(this).find('td').eq(172).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(161).addClass('d-none');
				}
				if ($('#workOrderTable .155').text() == "") {
					$('#workOrderTable .155').addClass('d-none');
					$(this).find('td').eq(173).addClass('d-none');
					$('#workOrderTable tfoot tr').eq(0).find('td').eq(162).addClass('d-none');
				}
			});
			
			//전역변수들
 			let workOrderSumOutputCnt		= $('#workOrderTable').DataTable().column(1,{ page: 'all'} ).data().sum();
			let workOrderSumAppearOutputCnt	= $('#workOrderTable').DataTable().column(2,{ page: 'all'} ).data().sum();
			let workOrderSumFaulty			= $('#workOrderTable').DataTable().column(3,{ page: 'all'} ).data().sum();
			let workOrderSumVisionFaulty= $('#workOrderTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			let workOrderSumFaultyPercent = 100 * workOrderSumFaulty / workOrderSumOutputCnt;

			$('#workOrderSumOutputCnt').html(addCommas(workOrderSumOutputCnt));
			$('#workOrderSumAppearOutputCnt').html(addCommas(workOrderSumAppearOutputCnt));
			$('#workOrderSumFaulty').html(addCommas(workOrderSumFaulty));
            $('#workOrderSumVisionFaulty').html(addCommas(workOrderSumVisionFaulty));
			$('#workOrderSumFaultyPercent').html(workOrderSumFaultyPercent.toFixed(2) + "%");
			
			//지역변수들
			let workOrderFaulty1	=	showTypeChange($('#workOrderTable').DataTable().column(18,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty2	=	showTypeChange($('#workOrderTable').DataTable().column(19,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty3	=	showTypeChange($('#workOrderTable').DataTable().column(20,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty4	=	showTypeChange($('#workOrderTable').DataTable().column(21,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty5	=	showTypeChange($('#workOrderTable').DataTable().column(22,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty6	=	showTypeChange($('#workOrderTable').DataTable().column(23,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty7	=	showTypeChange($('#workOrderTable').DataTable().column(24,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty8	=	showTypeChange($('#workOrderTable').DataTable().column(25,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty9	=	showTypeChange($('#workOrderTable').DataTable().column(26,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty10	=	showTypeChange($('#workOrderTable').DataTable().column(27,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty11	=	showTypeChange($('#workOrderTable').DataTable().column(28,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty12	=	showTypeChange($('#workOrderTable').DataTable().column(29,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty13	=	showTypeChange($('#workOrderTable').DataTable().column(30,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty14	=	showTypeChange($('#workOrderTable').DataTable().column(31,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty15	=	showTypeChange($('#workOrderTable').DataTable().column(32,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty16	=	showTypeChange($('#workOrderTable').DataTable().column(33,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty17	=	showTypeChange($('#workOrderTable').DataTable().column(34,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty18	=	showTypeChange($('#workOrderTable').DataTable().column(35,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty19	=	showTypeChange($('#workOrderTable').DataTable().column(36,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty20	=	showTypeChange($('#workOrderTable').DataTable().column(37,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty21	=	showTypeChange($('#workOrderTable').DataTable().column(38,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty22	=	showTypeChange($('#workOrderTable').DataTable().column(39,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty23	=	showTypeChange($('#workOrderTable').DataTable().column(40,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty24	=	showTypeChange($('#workOrderTable').DataTable().column(41,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty25	=	showTypeChange($('#workOrderTable').DataTable().column(42,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty26	=	showTypeChange($('#workOrderTable').DataTable().column(43,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty27	=	showTypeChange($('#workOrderTable').DataTable().column(44,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty28	=	showTypeChange($('#workOrderTable').DataTable().column(45,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty29	=	showTypeChange($('#workOrderTable').DataTable().column(46,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty30	=	showTypeChange($('#workOrderTable').DataTable().column(47,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty31	=	showTypeChange($('#workOrderTable').DataTable().column(48,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty32	=	showTypeChange($('#workOrderTable').DataTable().column(49,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty33	=	showTypeChange($('#workOrderTable').DataTable().column(50,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty34	=	showTypeChange($('#workOrderTable').DataTable().column(51,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty35	=	showTypeChange($('#workOrderTable').DataTable().column(52,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty36	=	showTypeChange($('#workOrderTable').DataTable().column(53,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty37	=	showTypeChange($('#workOrderTable').DataTable().column(54,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty38	=	showTypeChange($('#workOrderTable').DataTable().column(55,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty39	=	showTypeChange($('#workOrderTable').DataTable().column(56,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty40	=	showTypeChange($('#workOrderTable').DataTable().column(57,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty41	=	showTypeChange($('#workOrderTable').DataTable().column(58,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty42	=	showTypeChange($('#workOrderTable').DataTable().column(59,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty43	=	showTypeChange($('#workOrderTable').DataTable().column(60,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty44	=	showTypeChange($('#workOrderTable').DataTable().column(61,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty45	=	showTypeChange($('#workOrderTable').DataTable().column(62,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty46	=	showTypeChange($('#workOrderTable').DataTable().column(63,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
			let workOrderFaulty47	=	showTypeChange($('#workOrderTable').DataTable().column(64,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty48    =   showTypeChange($('#workOrderTable').DataTable().column(65,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty49    =   showTypeChange($('#workOrderTable').DataTable().column(66,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty50    =   showTypeChange($('#workOrderTable').DataTable().column(67,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty51    =   showTypeChange($('#workOrderTable').DataTable().column(68,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty52    =   showTypeChange($('#workOrderTable').DataTable().column(69,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty53    =   showTypeChange($('#workOrderTable').DataTable().column(70,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty54    =   showTypeChange($('#workOrderTable').DataTable().column(71,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty55    =   showTypeChange($('#workOrderTable').DataTable().column(72,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty56    =   showTypeChange($('#workOrderTable').DataTable().column(73,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty57    =   showTypeChange($('#workOrderTable').DataTable().column(74,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty58    =   showTypeChange($('#workOrderTable').DataTable().column(75,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty59    =   showTypeChange($('#workOrderTable').DataTable().column(76,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty60    =   showTypeChange($('#workOrderTable').DataTable().column(77,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty61    =   showTypeChange($('#workOrderTable').DataTable().column(78,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty62    =   showTypeChange($('#workOrderTable').DataTable().column(79,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty63    =   showTypeChange($('#workOrderTable').DataTable().column(80,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty64    =   showTypeChange($('#workOrderTable').DataTable().column(81,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty65    =   showTypeChange($('#workOrderTable').DataTable().column(82,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty66    =   showTypeChange($('#workOrderTable').DataTable().column(83,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty67    =   showTypeChange($('#workOrderTable').DataTable().column(84,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty68    =   showTypeChange($('#workOrderTable').DataTable().column(85,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty69    =   showTypeChange($('#workOrderTable').DataTable().column(86,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty70    =   showTypeChange($('#workOrderTable').DataTable().column(87,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty71    =   showTypeChange($('#workOrderTable').DataTable().column(88,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty72    =   showTypeChange($('#workOrderTable').DataTable().column(89,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty73    =   showTypeChange($('#workOrderTable').DataTable().column(90,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty74    =   showTypeChange($('#workOrderTable').DataTable().column(91,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty75    =   showTypeChange($('#workOrderTable').DataTable().column(92,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty76    =   showTypeChange($('#workOrderTable').DataTable().column(93,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty77    =   showTypeChange($('#workOrderTable').DataTable().column(94,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty78    =   showTypeChange($('#workOrderTable').DataTable().column(95,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty79    =   showTypeChange($('#workOrderTable').DataTable().column(96,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty80    =   showTypeChange($('#workOrderTable').DataTable().column(97,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty81    =   showTypeChange($('#workOrderTable').DataTable().column(98,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty82    =   showTypeChange($('#workOrderTable').DataTable().column(99,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty83    =   showTypeChange($('#workOrderTable').DataTable().column(100,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty84    =   showTypeChange($('#workOrderTable').DataTable().column(101,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty85    =   showTypeChange($('#workOrderTable').DataTable().column(102,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty86    =   showTypeChange($('#workOrderTable').DataTable().column(103,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty87    =   showTypeChange($('#workOrderTable').DataTable().column(104,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty88    =   showTypeChange($('#workOrderTable').DataTable().column(105,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty89    =   showTypeChange($('#workOrderTable').DataTable().column(106,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty90    =   showTypeChange($('#workOrderTable').DataTable().column(107,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty91    =   showTypeChange($('#workOrderTable').DataTable().column(108,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty92    =   showTypeChange($('#workOrderTable').DataTable().column(109,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty93    =   showTypeChange($('#workOrderTable').DataTable().column(110,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty94    =   showTypeChange($('#workOrderTable').DataTable().column(111,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty95    =   showTypeChange($('#workOrderTable').DataTable().column(112,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty96    =   showTypeChange($('#workOrderTable').DataTable().column(113,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty97    =   showTypeChange($('#workOrderTable').DataTable().column(114,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty98    =   showTypeChange($('#workOrderTable').DataTable().column(115,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty99    =   showTypeChange($('#workOrderTable').DataTable().column(116,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty100    =   showTypeChange($('#workOrderTable').DataTable().column(117,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty101    =   showTypeChange($('#workOrderTable').DataTable().column(118,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty102    =   showTypeChange($('#workOrderTable').DataTable().column(119,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty103    =   showTypeChange($('#workOrderTable').DataTable().column(120,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty104    =   showTypeChange($('#workOrderTable').DataTable().column(121,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty105    =   showTypeChange($('#workOrderTable').DataTable().column(122,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty106    =   showTypeChange($('#workOrderTable').DataTable().column(123,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty107    =   showTypeChange($('#workOrderTable').DataTable().column(124,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty108    =   showTypeChange($('#workOrderTable').DataTable().column(125,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty109    =   showTypeChange($('#workOrderTable').DataTable().column(126,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty110    =   showTypeChange($('#workOrderTable').DataTable().column(127,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty111    =   showTypeChange($('#workOrderTable').DataTable().column(128,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty112    =   showTypeChange($('#workOrderTable').DataTable().column(129,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty113    =   showTypeChange($('#workOrderTable').DataTable().column(130,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty114    =   showTypeChange($('#workOrderTable').DataTable().column(131,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty115    =   showTypeChange($('#workOrderTable').DataTable().column(132,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty116    =   showTypeChange($('#workOrderTable').DataTable().column(133,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty117    =   showTypeChange($('#workOrderTable').DataTable().column(134,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty118    =   showTypeChange($('#workOrderTable').DataTable().column(135,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty119    =   showTypeChange($('#workOrderTable').DataTable().column(136,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty120    =   showTypeChange($('#workOrderTable').DataTable().column(137,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty121    =   showTypeChange($('#workOrderTable').DataTable().column(138,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty122    =   showTypeChange($('#workOrderTable').DataTable().column(139,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty123    =   showTypeChange($('#workOrderTable').DataTable().column(140,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty124    =   showTypeChange($('#workOrderTable').DataTable().column(141,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty125    =   showTypeChange($('#workOrderTable').DataTable().column(142,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty126    =   showTypeChange($('#workOrderTable').DataTable().column(143,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty127    =   showTypeChange($('#workOrderTable').DataTable().column(144,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty128    =   showTypeChange($('#workOrderTable').DataTable().column(145,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty129    =   showTypeChange($('#workOrderTable').DataTable().column(146,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty130    =   showTypeChange($('#workOrderTable').DataTable().column(147,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty131    =   showTypeChange($('#workOrderTable').DataTable().column(148,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty132    =   showTypeChange($('#workOrderTable').DataTable().column(149,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty133    =   showTypeChange($('#workOrderTable').DataTable().column(150,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty134    =   showTypeChange($('#workOrderTable').DataTable().column(151,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty135    =   showTypeChange($('#workOrderTable').DataTable().column(152,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty136    =   showTypeChange($('#workOrderTable').DataTable().column(153,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty137    =   showTypeChange($('#workOrderTable').DataTable().column(154,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty138    =   showTypeChange($('#workOrderTable').DataTable().column(155,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty139    =   showTypeChange($('#workOrderTable').DataTable().column(156,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);
            let workOrderFaulty140    =   showTypeChange($('#workOrderTable').DataTable().column(157,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt); 

			$('#workOrderFaulty1').html(addCommas(workOrderFaulty1));
			$('#workOrderFaulty2').html(addCommas(workOrderFaulty2));
			$('#workOrderFaulty3').html(addCommas(workOrderFaulty3));
			$('#workOrderFaulty4').html(addCommas(workOrderFaulty4));
			$('#workOrderFaulty5').html(addCommas(workOrderFaulty5));
			$('#workOrderFaulty6').html(addCommas(workOrderFaulty6));
			$('#workOrderFaulty7').html(addCommas(workOrderFaulty7));
			$('#workOrderFaulty8').html(addCommas(workOrderFaulty8));
			$('#workOrderFaulty9').html(addCommas(workOrderFaulty9));
			
			$('#workOrderFaulty10').html(addCommas(workOrderFaulty10));
			$('#workOrderFaulty11').html(addCommas(workOrderFaulty11));
			$('#workOrderFaulty12').html(addCommas(workOrderFaulty12));
			$('#workOrderFaulty13').html(addCommas(workOrderFaulty13));
			$('#workOrderFaulty14').html(addCommas(workOrderFaulty14));
			$('#workOrderFaulty15').html(addCommas(workOrderFaulty15));
			$('#workOrderFaulty16').html(addCommas(workOrderFaulty16));
			$('#workOrderFaulty17').html(addCommas(workOrderFaulty17));
			$('#workOrderFaulty18').html(addCommas(workOrderFaulty18));
			$('#workOrderFaulty19').html(addCommas(workOrderFaulty19));
			$('#workOrderFaulty20').html(addCommas(workOrderFaulty20));
			$('#workOrderFaulty21').html(addCommas(workOrderFaulty21));
			$('#workOrderFaulty22').html(addCommas(workOrderFaulty22));
			$('#workOrderFaulty23').html(addCommas(workOrderFaulty23));
			$('#workOrderFaulty24').html(addCommas(workOrderFaulty24));
			$('#workOrderFaulty25').html(addCommas(workOrderFaulty25));
			$('#workOrderFaulty26').html(addCommas(workOrderFaulty26));
			$('#workOrderFaulty27').html(addCommas(workOrderFaulty27));
			$('#workOrderFaulty28').html(addCommas(workOrderFaulty28));
			$('#workOrderFaulty29').html(addCommas(workOrderFaulty29));
			$('#workOrderFaulty30').html(addCommas(workOrderFaulty30));
			$('#workOrderFaulty31').html(addCommas(workOrderFaulty31));
			$('#workOrderFaulty32').html(addCommas(workOrderFaulty32));
			$('#workOrderFaulty33').html(addCommas(workOrderFaulty33));
			$('#workOrderFaulty34').html(addCommas(workOrderFaulty34));
			$('#workOrderFaulty35').html(addCommas(workOrderFaulty35));
			$('#workOrderFaulty36').html(addCommas(workOrderFaulty36));
			$('#workOrderFaulty37').html(addCommas(workOrderFaulty37));
			$('#workOrderFaulty38').html(addCommas(workOrderFaulty38));
			$('#workOrderFaulty39').html(addCommas(workOrderFaulty39));
			$('#workOrderFaulty40').html(addCommas(workOrderFaulty40));
			$('#workOrderFaulty41').html(addCommas(workOrderFaulty41));
			$('#workOrderFaulty42').html(addCommas(workOrderFaulty42));
			$('#workOrderFaulty43').html(addCommas(workOrderFaulty43));
			$('#workOrderFaulty44').html(addCommas(workOrderFaulty44));
			$('#workOrderFaulty45').html(addCommas(workOrderFaulty45));
			$('#workOrderFaulty46').html(addCommas(workOrderFaulty46));
			$('#workOrderFaulty47').html(addCommas(workOrderFaulty47));
			$('#workOrderFaulty48').html(addCommas(workOrderFaulty48));
			$('#workOrderFaulty49').html(addCommas(workOrderFaulty49));
			$('#workOrderFaulty50').html(addCommas(workOrderFaulty50));
			$('#workOrderFaulty51').html(addCommas(workOrderFaulty51));
			$('#workOrderFaulty52').html(addCommas(workOrderFaulty52));
			$('#workOrderFaulty53').html(addCommas(workOrderFaulty53));
			$('#workOrderFaulty54').html(addCommas(workOrderFaulty54));
			$('#workOrderFaulty55').html(addCommas(workOrderFaulty55));
			$('#workOrderFaulty56').html(addCommas(workOrderFaulty56));
			$('#workOrderFaulty57').html(addCommas(workOrderFaulty57));
			$('#workOrderFaulty58').html(addCommas(workOrderFaulty58));
			$('#workOrderFaulty59').html(addCommas(workOrderFaulty59));
			$('#workOrderFaulty60').html(addCommas(workOrderFaulty60));
			$('#workOrderFaulty61').html(addCommas(workOrderFaulty61));
			$('#workOrderFaulty62').html(addCommas(workOrderFaulty62));
			$('#workOrderFaulty63').html(addCommas(workOrderFaulty63));
			$('#workOrderFaulty64').html(addCommas(workOrderFaulty64));
			$('#workOrderFaulty65').html(addCommas(workOrderFaulty65));
			$('#workOrderFaulty66').html(addCommas(workOrderFaulty66));
			$('#workOrderFaulty67').html(addCommas(workOrderFaulty67));
			$('#workOrderFaulty68').html(addCommas(workOrderFaulty68));
			$('#workOrderFaulty69').html(addCommas(workOrderFaulty69));
			$('#workOrderFaulty70').html(addCommas(workOrderFaulty70));
			$('#workOrderFaulty71').html(addCommas(workOrderFaulty71));
			$('#workOrderFaulty72').html(addCommas(workOrderFaulty72));
			$('#workOrderFaulty73').html(addCommas(workOrderFaulty73));
			$('#workOrderFaulty74').html(addCommas(workOrderFaulty74));
			$('#workOrderFaulty75').html(addCommas(workOrderFaulty75));
			$('#workOrderFaulty76').html(addCommas(workOrderFaulty76));
			$('#workOrderFaulty77').html(addCommas(workOrderFaulty77));
			$('#workOrderFaulty78').html(addCommas(workOrderFaulty78));
			$('#workOrderFaulty79').html(addCommas(workOrderFaulty79));
			$('#workOrderFaulty80').html(addCommas(workOrderFaulty80));
			$('#workOrderFaulty81').html(addCommas(workOrderFaulty81));
			$('#workOrderFaulty82').html(addCommas(workOrderFaulty82));
			$('#workOrderFaulty83').html(addCommas(workOrderFaulty83));
			$('#workOrderFaulty84').html(addCommas(workOrderFaulty84));
			$('#workOrderFaulty85').html(addCommas(workOrderFaulty85));
			$('#workOrderFaulty86').html(addCommas(workOrderFaulty86));
			$('#workOrderFaulty87').html(addCommas(workOrderFaulty87));
			$('#workOrderFaulty88').html(addCommas(workOrderFaulty88));
			$('#workOrderFaulty89').html(addCommas(workOrderFaulty89));
			$('#workOrderFaulty90').html(addCommas(workOrderFaulty90));
			$('#workOrderFaulty91').html(addCommas(workOrderFaulty91));
			$('#workOrderFaulty92').html(addCommas(workOrderFaulty92));
			$('#workOrderFaulty93').html(addCommas(workOrderFaulty93));
			$('#workOrderFaulty94').html(addCommas(workOrderFaulty94));
			$('#workOrderFaulty95').html(addCommas(workOrderFaulty95));
			$('#workOrderFaulty96').html(addCommas(workOrderFaulty96));
			$('#workOrderFaulty97').html(addCommas(workOrderFaulty97));
			$('#workOrderFaulty98').html(addCommas(workOrderFaulty98));
			$('#workOrderFaulty99').html(addCommas(workOrderFaulty99));
			$('#workOrderFaulty100').html(addCommas(workOrderFaulty100));
			$('#workOrderFaulty101').html(addCommas(workOrderFaulty101));
			$('#workOrderFaulty102').html(addCommas(workOrderFaulty102));
			$('#workOrderFaulty103').html(addCommas(workOrderFaulty103));
			$('#workOrderFaulty104').html(addCommas(workOrderFaulty104));
			$('#workOrderFaulty105').html(addCommas(workOrderFaulty105));
			$('#workOrderFaulty106').html(addCommas(workOrderFaulty106));
			$('#workOrderFaulty107').html(addCommas(workOrderFaulty107));
			$('#workOrderFaulty108').html(addCommas(workOrderFaulty108));
			$('#workOrderFaulty109').html(addCommas(workOrderFaulty109));
			$('#workOrderFaulty110').html(addCommas(workOrderFaulty110));
			$('#workOrderFaulty111').html(addCommas(workOrderFaulty111));
			$('#workOrderFaulty112').html(addCommas(workOrderFaulty112));
			$('#workOrderFaulty113').html(addCommas(workOrderFaulty113));
			$('#workOrderFaulty114').html(addCommas(workOrderFaulty114));
			$('#workOrderFaulty115').html(addCommas(workOrderFaulty115));
			$('#workOrderFaulty116').html(addCommas(workOrderFaulty116));
			$('#workOrderFaulty117').html(addCommas(workOrderFaulty117));
			$('#workOrderFaulty118').html(addCommas(workOrderFaulty118));
			$('#workOrderFaulty119').html(addCommas(workOrderFaulty119));
			$('#workOrderFaulty120').html(addCommas(workOrderFaulty120));
			$('#workOrderFaulty121').html(addCommas(workOrderFaulty121));
			$('#workOrderFaulty122').html(addCommas(workOrderFaulty122));
			$('#workOrderFaulty123').html(addCommas(workOrderFaulty123));
			$('#workOrderFaulty124').html(addCommas(workOrderFaulty124));
			$('#workOrderFaulty125').html(addCommas(workOrderFaulty125));
			$('#workOrderFaulty126').html(addCommas(workOrderFaulty126));
			$('#workOrderFaulty127').html(addCommas(workOrderFaulty127));
			$('#workOrderFaulty128').html(addCommas(workOrderFaulty128));
			$('#workOrderFaulty129').html(addCommas(workOrderFaulty129));
			$('#workOrderFaulty130').html(addCommas(workOrderFaulty130));
			$('#workOrderFaulty131').html(addCommas(workOrderFaulty131));
			$('#workOrderFaulty132').html(addCommas(workOrderFaulty132));
			$('#workOrderFaulty133').html(addCommas(workOrderFaulty133));
			$('#workOrderFaulty134').html(addCommas(workOrderFaulty134));
			$('#workOrderFaulty135').html(addCommas(workOrderFaulty135));
			$('#workOrderFaulty136').html(addCommas(workOrderFaulty136));
			$('#workOrderFaulty137').html(addCommas(workOrderFaulty137));
			$('#workOrderFaulty138').html(addCommas(workOrderFaulty138));
			$('#workOrderFaulty139').html(addCommas(workOrderFaulty139));
			$('#workOrderFaulty140').html(addCommas(workOrderFaulty140));
        },
    });
	
	//엣지검사 테이블 클릭 시
  	$('#workOrderTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		workOrdLotNo = workOrderTable.row(this).data().workOrdLotNo;
  	});
  //외관검사 테이블 더블클릭 시
	$('#workOrderTable tbody').on('dblclick', 'tr', function() {
		//workOrdNo = faultyStatsDay.row(this).data().workOrdNo;
		workOrdLotNo = workOrderTable.row(this).data().workOrdLotNo;
		$('#boxNoTraceTable').DataTable().clear().draw();
		$('#boxNoTraceTable').DataTable().ajax.reload();
		$('#boxNoTraceModal').modal('show');
	});
	
	//작지번호별
	/*  var html3 = '<div class="row">';
	html3 += '<label class="input-label-sm ml-1">검사일</label><div class="form-group input-sub m-0 row">';
	html3 += '<input class="form-control" style="width:97px;" type="text" id="workOrderChooseDateFrom" name="workOrderChooseDateFrom" />';
	html3 += '<button onclick="fnPopUpCalendar(workOrderChooseDateFrom,workOrderChooseDateFrom,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="workOrderChooseDateFromCalendar" type="button">';
	html3 += '<span class="oi oi-calendar"></span>';
	html3 += '</button>'; 
	html3 += '</div>'; 
	html3 += '<label class="input-label-sm ml-1">~</label><div class="form-group input-sub m-0 row">';
	html3 += '<input class="form-control" style="width:97px;" type="text" id="workOrderChooseDateTo" name="workOrderChooseDateTo" />';
	html3 += '<button onclick="fnPopUpCalendar(workOrderChooseDateTo,workOrderChooseDateTo,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="btnworkOrderChooseDateCalendar" type="button">';
	html3 += '<span class="oi oi-calendar"></span>';
	html3 += '</button>'; 
	html3 += '</div>';
	html3 += '<input class = "input-label-sm ml-2" style = "width:20px; height:20px;" type="checkbox" checked id="workOrderGubun" value="ok">';
	html3 += '<label for="workOrderGubun" class="input-label-sm">엣지불량수함 포함</label>';
	
	html3 += '<label class="input-label-sm">검사자</label>';
	html3 += '<input type="hidden" class="form-control" id="preWorkCharger3"  name="preWorkCharger3">';
	html3 += '	<div class="input-sub m-0 row">';
	html3 += '	<input type="text" class="form-control" id="preWorkChargerNm3"  name="preWorkChargerNm3" disabled>';
    html3 += '	<button type="button" class="btn btn-primary input-sub-search" id="btnSelPreWorkCharger3" ">';//onClick="selectPreWorkCharger()
	html3 += '	<span class="oi oi-magnifying-glass"></span>';
    html3 += '</button>';
    html3 += '</div>';
    html3 += '<div>';
    html3 += '<a href="javascript:void(0)" id="workOrderCancelSearchUser" class="closebtn"><i class="mdi mdi-close"></i></a>';
    html3 += '</div>';
    
	html3 += '&nbsp;<button type="button" class="btn btn-primary ml-2" id="btnworkOrderRetv">조회</button>';
	html3 += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">형식</label>';
	html3 += '<select class="custom-select" style="min-width:70px; max-width: 70px;" id="workOrderShowType">';
	html3 += '<option value="workOrderShowType001">개수</option>';
	html3 += '<option value="workOrderShowType002">%</option>';
	html3 += '</select>';
	html3 += '</div>'; */
	

	//$('#workOrderDateLokkup').html(html3);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	//작지번호별 검색
	$('#workOrderTable_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#workOrderTable_filter').find('label').eq(0).addClass('row ml-3');
	$('#workOrderTable_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#workOrderTable_filter").insertAfter("#showType");

	//검사자 선택 취소
	$('#cancelSearchUser').on('click', function() {
		$('#preWorkChargerNm').val('');
		$('#preWorkCharger').val('');
		userNumber = '';
	});
	//조회
  	$('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		
  		chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		userNumber	= $('#preWorkCharger').val();
  		
  		showType = $("#showType option:selected").val();
  		if($('#goodsFaultyDateLookup').hasClass("d-none") == false ){
  			$('#faultyStatsDay').DataTable().ajax.reload();
  	  	} else if($('#edgeGoodsFaultyDateLookup').hasClass("d-none") == false ){
  	  		$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
  	  	} else {
  		  	$('#workOrderTable').DataTable().ajax.reload();
  	  	}
	});
    // 형식 변경시 테이블 리로드   
  	$('#showType').change(function() {
  		showType = $("#showType option:selected").val();
  		if($('#goodsFaultyDateLookup').hasClass("d-none") == false ){
  			$('#faultyStatsDay').DataTable().ajax.reload();
  	  	} else if($('#edgeGoodsFaultyDateLookup').hasClass("d-none") == false ){
  	  		$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
  	  	} else {
  		  	$('#workOrderTable').DataTable().ajax.reload();
  	  	}
  		
    });
	function showTypeChange(data, sumOutputCnt) {
		if (showType == 'showType001') {
			return data;
		} else if (showType == 'showType002'){
			let temp = parseFloat(data/sumOutputCnt) * 100;
			if (Number.isInteger(temp)) {
				return temp  + ' %';
			} else {
				return temp.toFixed(2) + ' %';
			}
		}
	}

	//외관검사
	function appearHeaderCreate() {
    	var metal = '';
    	var film = '';
    	var vision = '';
    	var five = '';
    	var six = '';
		var metalIdx = 0;
		var filmIdx = 0;
		var visionIdx = 0;
		var fiveIdx = 0;
		var sixIdx = 0;
		
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
        	}
    		/* if(item.etc1 == '004'){
    			vision += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			visionIdx++;  
        	}
    		if(item.etc1 == '005'){
    			five += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			fiveIdx++;  
        	} */
    		//if(item.etc1 == '006'){
    		//	six += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    		//	sixIdx++;  
        	//}
		});
    	metal = metal + film +vision + five + six;
        $('#metalHd').attr('colspan', metalIdx);   
        $('#filmHd').attr('colspan', filmIdx);        
        //$('#visonHd').attr('colspan', visionIdx);   
        //$('#fiveHd').attr('colspan', fiveIdx);
        //$('#sixHd').attr('colspan', sixIdx);
        
		$('#appearHeader').html(metal);
	}

  	//엣지검사
	function edgeAppearHeaderCreate() {
    	var metal = '';
    	var film = '';
		var metalIdx = 0;
		var filmIdx = 0;
    	$.each(edgeGoodsFaultyCode, function(index,item){				
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
        	}
		});
    	metal += film;
        $('#edgeHd').attr('colspan', metalIdx);   
        $('#edgeHd2').attr('colspan', filmIdx);        
		$('#edgeAppearHeader').html(metal);
	}
	
	//작지번호별
	function workOrderAppearHeaderCreate() {
    	var metal = '';
    	var film = '';
    	var vision = '';
    	var five = '';
    	var six = '';
		var metalIdx = 0;
		var filmIdx = 0;
		var visionIdx = 0;
		var fiveIdx = 0;
		var sixIdx = 0;
		
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
        	}
    		/*if(item.etc1 == '004'){
    			vision += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			visionIdx++;  
        	}
    		if(item.etc1 == '005'){
    			five += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			fiveIdx++;  
        	} */
    		//if(item.etc1 == '006'){
    		//	six += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    		//	sixIdx++;  
        	//}
		});
    	metal = metal + film +vision + five + six;
        $('#workOrderMetalHd').attr('colspan', metalIdx);   
        $('#workOrderFilmHd').attr('colspan', filmIdx);        
        //$('#workOrderVisonHd').attr('colspan', visionIdx);   
        //$('#workOrderFiveHd').attr('colspan', fiveIdx);
        //$('#sixHd').attr('colspan', sixIdx);
        
		$('#workOrderHeader').html(metal);
	}
	// 담당자조회 팝업 시작
   	let userPopUpTable;	
   	let data;
   	$('#btnSelPreWorkCharger, #btnSelPreWorkCharger2, #btnSelPreWorkCharger3').on('click', function() {
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
		        	{ "targets": [0,1,2,3,4],  "className": "text-center"}
		        ],		      
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [
		            
		        ],
		    });
		    $('#userPopUpTable tbody').on('click', 'tr', function () {
		    	data = userPopUpTable.row( this ).data();
                $('#preWorkCharger').val(data.userNumber);
                $('#preWorkChargerNm').val(data.userNm);
                $('#userPopUpModal').modal('hide');
                
		    });
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		    
		$('#userPopUpModal').modal('show');	
   	});
  	// 담당자조회 팝업 종료
  	

  	//구분체크
  	$('#workOrderGubun').click(function() {
		if ($(this).prop('checked')) {
			workOrderGubunVal = 'check';
			
		} else {
			workOrderGubunVal = '';
		}
		$('#workOrderTable').DataTable().ajax.reload( function () {});
	});

</script>
</body>
</html>
