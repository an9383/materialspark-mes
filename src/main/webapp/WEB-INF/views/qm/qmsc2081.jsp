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
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">생산검사현황</li>
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
						
							<select class="custom-select mr-2" style="min-width: 100px; max-width: 100px;" id="showDate" onChange="showDateChange()">
								<option value="showDate001">(외관)검사일</option>
								<option value="showDate002">생산일</option>
							</select>
							<!-- 검사일 -->
							<div class="row" id="chooseDateDiv">
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="width: 97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />
									<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">
										<span class="oi oi-calendar"></span>
									</button>
								</div>
								<label class="input-label-sm ml-2">~</label>
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="width: 97px;" type="text" id="chooseDateTo" name="chooseDateTo" />
									<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="chooseDateCalendar" type="button">
										<span class="oi oi-calendar"></span>
									</button>
								</div>
							</div>
							<!-- 검사일 끝 -->
							<!-- 생산일  -->
							<div class="row d-none" id="productionDiv">
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="width: 97px;" type="text" id="productionFrom" name="productionFrom" />
									<button onclick="fnPopUpCalendar(productionFrom,productionFrom,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar2" type="button">
										<span class="oi oi-calendar"></span>
									</button>
								</div>
								<label class="input-label-sm ml-2">~</label>
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="width: 97px;" type="text" id="productionTo" name="productionTo" />
									<button onclick="fnPopUpCalendar(productionTo,productionTo,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">
										<span class="oi oi-calendar"></span>
									</button>
								</div>
							</div>
<!-- 							<div class=""> -->
<!-- 							<label style="font-size: 16px;">&nbsp;&nbsp;/&nbsp;&nbsp;</label> -->
								
<!-- 							<input type="checkbox" class="input-label-sm mr-1" style="width: 20px; height: 20px;" id="productionDateCheckBox"> -->
<!-- 							<label class="input-label-sm" for="productionDateCheckBox">생산일</label> -->
<!-- 							</div> -->
							<!-- 생산일 끝  -->
							
<!-- 							<label style="font-size: 16px;">&nbsp;&nbsp;/&nbsp;&nbsp;</label> -->
							
							<input class="input-label-sm ml-2" style="width: 20px; height: 20px;" type="checkbox" checked id="allDateGubun">
							<label for="allDateGubun">날짜 전체 적용</label>
							
							<input class="input-label-sm ml-2" style="width: 20px; height: 20px;" type="checkbox" checked id="workOrderGubun" value="ok"> 
							<label for="workOrderGubun" class="input-label-sm" id="workOrderGubunLabel">엣지불량수함 포함</label>
							
							<input class="input-label-sm ml-2 d-none" style="width: 20px; height: 20px;" type="checkbox" checked id="comprehensiveGubun" value="ok"> 
							<label for="comprehensiveGubun" class="input-label-sm d-none" id="comprehensiveGubunLabel">엣지불량수함 포함</label>

							<div class="row" id="preWorkChargerView">
								<label class="input-label-sm ml-2">검사자</label> 
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
							</div>
							
							&nbsp;
							<button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button>
							&nbsp;<button type="button" class="btn btn-primary ml-2" id="btnPackingNumberInquiry">포장번호 조회</button>
							<select class="custom-select ml-2 d-none" style="min-width: 70px; max-width: 120px;" id="exceptFaultyQty"></select>
							<select class="custom-select custom-select-sm ml-2" id="selectQutyCd" style="width:85px;"></select>
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
								<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab3">작업지시별</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab1">외관검사</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">엣지검사</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">생산비전불량(작업지시)</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab5">생산비전불량(작업자)</a></li>
								<li class="nav-item"><a class="nav-link d-none" data-toggle="tab" id="tab6">종합수량</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab7">작업지시별(재검포함)</a></li>
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
											<th rowspan="2" style="min-width: 160px" class="text-center">생산LotNo</th>
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
											<th colspan="2" style="min-width: 70px;" class="text-center"
												class="text-center" id="visonHd">비전부 불량</th>
											<th colspan="2" style="min-width: 70px;" class="text-center"
												class="text-center" id="fiveHd">5 부불량</th>
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
											<td>합계</td>
											<td></td>
											<!-- <td colspan="2" style="text-align: center">합계</td> -->
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
											<th rowspan="2" style="min-width: 160px" class="text-center">생산LotNo</th>
											<th rowspan="2" style="min-width: 130px" class="text-center">생산전표번호</th>
											<th rowspan="2" style="min-width: 40px" class="text-center">주야</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">생산<br>작업자
											</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">제품</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">재질</th>
											<th rowspan="2" style="min-width: 200px" class="text-center">규격</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">주자재</th>
											<th style="min-width: 70px;" class="text-center" class="text-center" id="edgeHd">★</th>
											<th style="min-width: 70px;" class="text-center" class="text-center" id="edgeHd2">★</th>
											<!-- <th colspan="19" style="min-width: 70px;" class="text-center" class="text-center">기타 불량</th> -->
										</tr>
										<tr id="edgeAppearHeader"></tr>
									<tfoot>
										<tr>
											<td>합계</td>
											<td></td>
											<!-- <td colspan="2" style="text-align: center">합계</td> -->
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
											
											<th rowspan="2" style="min-width: 160px" class="text-center">생산LotNo</th>
											<!-- <th rowspan="2"style="min-width: 130px"class="text-center">생산전표번호</th>
										<th rowspan="2"style="min-width: 40px" class="text-center">주야</th>
										<th rowspan="2"style="min-width: 50px" class="text-center">생산<br>작업자</th> -->
											<th rowspan="2" style="min-width: 50px" class="text-center">제품</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">재질</th>
											<!-- <th rowspan="2"style="min-width: 55px" class="text-center">검사자</th> -->
											<th rowspan="2" style="min-width: 50px" class="text-center">검사수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">양품수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">불량수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">생산<br>비전불량</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">불량률(%)</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">생산일</th>
											
											<th rowspan="2" style="min-width: 90px" class="text-center">생산 작업자</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">외관검사일</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">엣지 검사자</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">외관 검사자</th>
											
											<th rowspan="2" style="min-width: 50px" class="text-center">설비명</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">작지번호</th>
											<th rowspan="2" style="min-width: 200px" class="text-center">규격</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">주자재</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재1</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재2</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재3</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재4</th>
											
											<th style="min-width: 70px;" class="text-center" class="text-center" id="workOrderMetalHd">★</th>
											<th style="min-width: 70px;" class="text-center" class="text-center" id="workOrderFilmHd">★</th>
											<th style="min-width: 70px;" class="text-center" class="text-center" id="workOrderVisonHd">★</th>
											<th style="min-width: 70px;" class="text-center" class="text-center" id="workOrderFiveHd">★</th>
										</tr>
										<tr id="workOrderHeader"></tr>
									<tfoot>
										<tr>
											<td name="td1">합계</td>
											<td name="td2"></td>
											<td name="td3"></td>
											<td name="td4"></td>
<!-- 											<td colspan="4" style="text-align: center">합계</td> -->
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

						<!-- 생산비전불량(작업지시) 뷰 시작 -->
						<div class="d-none" id="visionWorkOrdView">
							<div class="table-responsive" style="padding-bottom: 10px;">
								<table id="visionWorkOrdTable" class="table table-bordered mt-0">
									<thead class="thead-light">
										<tr>
											<th rowspan="2" style="min-width:120px" class="text-center">제품명</th>
											<th rowspan="2" style="min-width:150px" class="text-center">작업지시</th>
											<th rowspan="2" style="min-width:150px" class="text-center">주자재</th>
											<th rowspan="2" style="min-width:80px" class="text-center">총 생산<br>비전수량</th>
											<th style="min-width:70px;" class="text-center" class="text-center" id="visionWorkOrdUp">상부</th> 
											<!-- <th style="min-width:70px;" class="text-center" class="text-center" id="visionWorkOrdDown">하부</th> -->
										</tr>
										<tr id="visionWorkOrdHeader">
										
										</tr>
									<tfoot>
										<tr>
											<td>합계</td>
											<td></td>
											<td></td>
											<!-- <td colspan="3" style="text-align: center">합계</td> -->
											<td colspan="" id="sumVisionWorkOrd" style="text-align: right">0</td>
											<td colspan="" id="visionWorkOrdfaulty1" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty2" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty3" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty4" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty5" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty6" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty7" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty8" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty9" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty10" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty11" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty12" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty13" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty14" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty15" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty16" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty17" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty18" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty19" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty20" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty21" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty22" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty23" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty24" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty25" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty26" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty27" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty28" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty29" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty30" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty31" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty32" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty33" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty34" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty35" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty36" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty37" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty38" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty39" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty40" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty41" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty42" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty43" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty44" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty45" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty46" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty47" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty48" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty49" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionWorkOrdfaulty50" style="text-align:right; min-width:50px;">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
						<!-- 생산비전불량(작업지시) 뷰 끝 -->
						
						<!-- 생산비전불량(작업자) 뷰 시작 -->
						<div class="d-none" id="visionChargerView">
							<div class="table-responsive" style="padding-bottom: 10px;">
								<table id="visionChargerTable" class="table table-bordered mt-0">
									<thead class="thead-light">
										<tr>
											<th rowspan="2" style="min-width:120px" class="text-center">제품명</th>
											<th rowspan="2" style="min-width:120px" class="text-center">작업자</th>
											<th rowspan="2" style="min-width:120px" class="text-center">작업자ID</th>
											<th rowspan="2" style="min-width:100px" class="text-center">총 생산<br>비전수량</th>
											<th style="min-width:70px;" class="text-center" class="text-center" id="visionChargerUp">상부</th> 
											<!-- <th style="min-width:70px;" class="text-center" class="text-center" id="visionChargerDown">하부</th> -->
										</tr>
										<tr id="visionChargerHeader">
										
										</tr>
									<tfoot>
										<tr>
											<td>합계</td>
											<td></td>
											<td></td>
											<!-- <td colspan="3" style="text-align: center">합계</td> -->
											<td colspan="" id="sumVisionCharger" style="text-align: right">0</td>
											<td colspan="" id="visionChargerfaulty1" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty2" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty3" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty4" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty5" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty6" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty7" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty8" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty9" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty10" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty11" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty12" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty13" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty14" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty15" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty16" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty17" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty18" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty19" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty20" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty21" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty22" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty23" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty24" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty25" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty26" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty27" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty28" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty29" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty30" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty31" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty32" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty33" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty34" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty35" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty36" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty37" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty38" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty39" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty40" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty41" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty42" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty43" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty44" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty45" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty46" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty47" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty48" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty49" style="text-align:right; min-width:50px;">0</td>
											<td colspan="" id="visionChargerfaulty50" style="text-align:right; min-width:50px;">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
						<!-- 생산비전불량(작업자) 뷰 끝 -->
						
						
						<!-- 종합수량 뷰 시작 -->
						<div class="d-none" id="comprehensiveQtyView">
							<div class="table-responsive" style="padding-bottom: 10px;">
								<table id="comprehensiveQtyTable" class="table table-bordered">
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
											
											<th rowspan="2" style="min-width: 90px" class="text-center">생산 작업자</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">엣지 검사자</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">외관 검사자</th>
											
											<th rowspan="2" style="min-width: 50px" class="text-center">설비명</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">작지번호</th>
											<th rowspan="2" style="min-width: 160px" class="text-center">생산LotNo</th>
											<!-- <th rowspan="2"style="min-width: 130px"class="text-center">생산전표번호</th>
										<th rowspan="2"style="min-width: 40px" class="text-center">주야</th>
										<th rowspan="2"style="min-width: 50px" class="text-center">생산<br>작업자</th> -->
											<th rowspan="2" style="min-width: 70px" class="text-center">제품</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">재질</th>
											<th rowspan="2" style="min-width: 200px" class="text-center">규격</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">주자재</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재1</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재2</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재3</th>
											<th rowspan="2" style="min-width: 90px" class="text-center" id="behindSeatAdd">부자재4</th>
										</tr>
										<tr id="comprehensiveQtyHeader"></tr>
									<tfoot>
										<tr>
											<td colspan="1" style="text-align: center">합계</td>
											<td colspan="" id="comprehensiveQtySumOutputCnt" name="comprehensiveQtySumOutputCnt" style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtySumAppearOutputCnt" name="comprehensiveQtySumAppearOutputCnt" style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtySumFaulty" name="comprehensiveQtySumFaulty" style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtySumVisionFaulty" name="comprehensiveQtySumVisionFaulty" style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtySumFaultyPercent" name="comprehensiveQtySumFaultyPercent" style="text-align: right">0</td>
											<td colspan="15"></td>
											<td colspan="" id="comprehensiveQtyFaulty1"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty2"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty3"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty4"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty5"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty6"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty7"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty8"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty9"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty10"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty11"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty12"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty13"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty14"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty15"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty16"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty17"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty18"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty19"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty20"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty21"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty22"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty23"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty24"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty25"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty26"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty27"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty28"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty29"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty30"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty31"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty32"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty33"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty34"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty35"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty36"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty37"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty38"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty39"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty40"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty41"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty42"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty43"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty44"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty45"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty46"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty47"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty48"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty49"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty50"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty51"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty52"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty53"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty54"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty55"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty56"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty57"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty58"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty59"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty60"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty61"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty62"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty63"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty64"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty65"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty66"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty67"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty68"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty69"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty70"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty71"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty72"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty73"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty74"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty75"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty76"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty77"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty78"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty79"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty80"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty81"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty82"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty83"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty84"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty85"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty86"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty87"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty88"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty89"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty90"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty91"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty92"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty93"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty94"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty95"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty96"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty97"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty98"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty99"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty100"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty101"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty102"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty103"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty104"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty105"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty106"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty107"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty108"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty109"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty110"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty111"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty112"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty113"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty114"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty115"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty116"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty117"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty118"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty119"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty120"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty121"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty122"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty123"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty124"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty125"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty126"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty127"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty128"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty129"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty130"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty131"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty132"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty133"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty134"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty135"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty136"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty137"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty138"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty139"
												style="text-align: right">0</td>
											<td colspan="" id="comprehensiveQtyFaulty140"
												style="text-align: right">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<!-- /.table-responsive -->
						</div>
						<!-- 종합수량 뷰 끝 -->
						<!-- 작지재검 뷰 시작 -->
						<div class="d-none" id="workOrderReInspView">
							<div class="table-responsive" style="padding-bottom: 10px;">
								<table id="workOrderReInspTable" class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th rowspan="2" style="min-width: 70px ;" class="text-center">작업지시일</th>
											<th rowspan="2" style="min-width: 120px;" class="text-center">작지번호</th>
											<th rowspan="2" style="min-width: 120px;" class="text-center">트레이번호</th>
											<th rowspan="2" style="min-width: 50px; " class="text-center">차수</th>
											<th rowspan="2" style="min-width: 70px; " class="text-center">주야구분</th>
											
											<!-- <th rowspan="2"style="min-width: 130px"class="text-center">생산전표번호</th>
										<th rowspan="2"style="min-width: 40px" class="text-center">주야</th>
										<th rowspan="2"style="min-width: 50px" class="text-center">생산<br>작업자</th> -->
										
											<!-- <th rowspan="2"style="min-width: 55px" class="text-center">검사자</th> -->
											<th rowspan="2" style="min-width: 50px" class="text-center">검사수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">양품수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">불량수량</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">생산<br>비전불량</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">불량률(%)</th>
											<th rowspan="2" style="min-width: 70px" class="text-center">생산일</th>
											
											<th rowspan="2" style="min-width: 90px" class="text-center">생산 작업자</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">외관검사일</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">엣지 검사자</th>
											<th rowspan="2" style="min-width: 90px" class="text-center">외관 검사자</th>
											
											<th rowspan="2" style="min-width: 50px" class="text-center">설비명</th>
											<th rowspan="2" style="min-width: 160px" class="text-center">생산LotNo</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">제품</th>
											<th rowspan="2" style="min-width: 50px" class="text-center">재질</th>											
											<th rowspan="2" style="min-width: 200px" class="text-center">규격</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">주자재</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재1</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재2</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재3</th>
											<th rowspan="2" style="min-width: 120px" class="text-center">부자재4</th>
											
											<th style="min-width: 70px;" class="text-center" class="text-center" id="workOrderReInspMetalHd">★</th>
											<th style="min-width: 70px;" class="text-center" class="text-center" id="workOrderReInspFilmHd">★</th>
											<th style="min-width: 70px;" class="text-center" class="text-center" id="workOrderReInspVisonHd">★</th>
											<th style="min-width: 70px;" class="text-center" class="text-center" id="workOrderReInspFiveHd">★</th>
										</tr>
										<tr id="workOrderReInspHeader"></tr>
									<tfoot>
										<tr style="background-color:#edacb1; color:red">
											<td name="tdRe1">합계</td>
											<td name="tdRe2"></td>
											<td name="tdRe3"></td>
											<td name="tdRe4"></td>
											<td></td>
<!-- 											<td colspan="4" style="text-align: center">합계</td> -->
											<td colspan="" id="workOrderReInspSumOutputCnt"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspSumAppearOutputCnt"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspSumFaulty"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspSumVisionFaulty"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspSumFaultyPercent"
												style="text-align: right">0</td>
											<td colspan="15"></td>
											<td colspan="" id="workOrderReInspFaulty1"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty2"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty3"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty4"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty5"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty6"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty7"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty8"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty9"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty10"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty11"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty12"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty13"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty14"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty15"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty16"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty17"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty18"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty19"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty20"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty21"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty22"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty23"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty24"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty25"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty26"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty27"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty28"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty29"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty30"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty31"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty32"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty33"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty34"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty35"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty36"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty37"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty38"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty39"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty40"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty41"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty42"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty43"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty44"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty45"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty46"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty47"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty48"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty49"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty50"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty51"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty52"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty53"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty54"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty55"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty56"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty57"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty58"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty59"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty60"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty61"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty62"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty63"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty64"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty65"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty66"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty67"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty68"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty69"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty70"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty71"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty72"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty73"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty74"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty75"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty76"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty77"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty78"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty79"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty80"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty81"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty82"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty83"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty84"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty85"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty86"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty87"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty88"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty89"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty90"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty91"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty92"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty93"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty94"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty95"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty96"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty97"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty98"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty99"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty100"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty101"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty102"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty103"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty104"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty105"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty106"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty107"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty108"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty109"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty110"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty111"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty112"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty113"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty114"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty115"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty116"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty117"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty118"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty119"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty120"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty121"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty122"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty123"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty124"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty125"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty126"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty127"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty128"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty129"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty130"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty131"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty132"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty133"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty134"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty135"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty136"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty137"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty138"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty139"
												style="text-align: right">0</td>
											<td colspan="" id="workOrderReInspFaulty140"
												style="text-align: right">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<!-- /.table-responsive -->
						</div>
						<!-- 작지재검 뷰 끝 -->
						
						
						
						
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

	let menuAuth = 'qmsc2080';
	let currentHref = 'qmsc2080';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","생산검사현황");

	let factoryCode = "<%=factoryCode%>";

	//공통코드 처리 시작
    var goodsFaultyType=new Array();	//제품불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>

	var goodsFaultyBigNameCd=new Array();	//엣지검사 대분류
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
    
    var visionFaultyBigNameCd=new Array();	//생산 비전불량 대분류
    <c:forEach items="${visionFaultyBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";		
		visionFaultyBigNameCd.push(json);
    </c:forEach>
    
    var visionFaultyCode=new Array();	//생산 비전불량 소분류
    <c:forEach items="${visionFaultyCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";		
		visionFaultyCode.push(json);
    </c:forEach>

    var exceptFaultyCode=new Array();	//최종검사현황(종합수량) 제외 값
    <c:forEach items="${exceptFaultyCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		exceptFaultyCode.push(json);
    </c:forEach>

    var qutyCode=new Array();	//재질
    <c:forEach items="${qutyCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		qutyCode.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    
    selectBoxAppend_NameAdd(exceptFaultyCode, "exceptFaultyQty", "", "1", "제외시킬 값");
    selectBoxAppend_NameAdd(qutyCode, "selectQutyCd", "", "1", "재질");
    
    //외관대분류명
   	$('#metalHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmHd').text(goodsFaultyBigNameCd[1].baseCdNm);


	//3공장 안씀
	if( factoryCode == "001" || factoryCode == "002" ) {
		$('#visonHd').text(goodsFaultyBigNameCd[2].baseCdNm);
		$('#fiveHd').text(goodsFaultyBigNameCd[3].baseCdNm);
		//$('#sixHd').text(goodsFaultyBigNameCd[5].baseCdNm);
	}
	
    //엣지대분류명
   	$('#edgeHd').text(edgeBigNameCd[0].baseCdNm);
	$('#edgeHd2').text(edgeBigNameCd[1].baseCdNm);
	
	//작지번호별 대분류명
   	$('#workOrderMetalHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#workOrderFilmHd').text(goodsFaultyBigNameCd[1].baseCdNm);

   	$('#workOrderReInspMetalHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#workOrderReInspFilmHd').text(goodsFaultyBigNameCd[1].baseCdNm);

	//3공장 안씀
	if( factoryCode == "001" || factoryCode == "002" ) {
		$('#workOrderVisonHd').text(goodsFaultyBigNameCd[2].baseCdNm);
		$('#workOrderFiveHd').text(goodsFaultyBigNameCd[3].baseCdNm);
		$('#workOrderReInspVisonHd').text(goodsFaultyBigNameCd[2].baseCdNm);
		$('#workOrderReInspFiveHd').text(goodsFaultyBigNameCd[3].baseCdNm);
	}

	$('#visionWorkOrdUp').text(visionFaultyBigNameCd[0].baseCdNm);
	//$('#visionWorkOrdDown').text(visionFaultyBigNameCd[1].baseCdNm);

	$('#visionChargerUp').text(visionFaultyBigNameCd[0].baseCdNm);
	//$('#visionChargerDown').text(visionFaultyBigNameCd[1].baseCdNm);

	let tabView = 'tabView3';

	//탭 별 날짜
	let tabDate = new Array();
	tabDate[0] = '${serverDateFrom}|${serverDate}|showDate001';	//외관
	tabDate[1] = '${serverDateFrom}|${serverDate}|showDate001';	//엣지
	tabDate[2] = '${serverDateFrom}|${serverDate}|showDate001';	//작지
	tabDate[3] = '${serverDateFrom}|${serverDate}|showDate001';	//생산비전불량(작업지시)
	tabDate[4] = '${serverDateFrom}|${serverDate}|showDate001';	//생산비전불량(작업자)
	tabDate[5] = '${serverDateFrom}|${serverDate}|showDate001';	//종합수량
	tabDate[6] = '${serverDateFrom}|${serverDate}|showDate001';	//작지재검
	
	if( factoryCode == "001" || factoryCode == "002" ) {
		$('#tab6').removeClass('d-none');
	}
	
	if( factoryCode == "003" ) {
		$('#tab6').addClass('d-none');
	}
	
    //탭 1클릭 시
   	$('#tab1').click(function() {
   	   	//화면 
		$('#goodsFaultyView').removeClass("d-none");
		$('#goodsFaultyDateLookup').removeClass("d-none");
		$('#workOrderDateLokkup').addClass("d-none");
		$('#workOrderView').addClass("d-none");
		$('#edgeGoodsFaultyDateLookup').addClass("d-none");
		$('#edgeGoodsFaultyView').addClass("d-none");
		$('#visionWorkOrdView').addClass("d-none");
		$("#visionChargerView").addClass("d-none");
		$('#comprehensiveQtyView').addClass("d-none");
		$('#workOrderReInspView').addClass("d-none");

		// 버튼
		$('#btnPackingNumberInquiry').removeClass("d-none");
		$('#workOrderGubun').addClass("d-none");
		$('#workOrderGubunLabel').addClass("d-none");
		$('#comprehensiveGubun').addClass("d-none");
		$('#comprehensiveGubunLabel').addClass("d-none");
		$('#preWorkChargerView').removeClass("d-none");		//사용자 모달
		
		// 검색기
		$("#faultyStatsDay_filter").removeClass("d-none");
		$("#edgeGoodsFaultyTable_filter").addClass("d-none");
		$("#workOrderTable_filter").addClass("d-none");
		$("#workOrderReInspTable_filter").addClass("d-none");
		$("#visionWorkOrdTable_filter").addClass("d-none");
		$("#visionChargerTable_filter").addClass("d-none");		//생산비전불량(작업자)
		$("#comprehensiveQtyTable_filter").addClass("d-none");

		$('#exceptFaultyQty').addClass('d-none');
		$('#selectQutyCd').removeClass('d-none');

		$("#selectQutyCd").val("").prop("selected", true);
		//검사자 값 초기화
		$("#preWorkChargerNm").val("");
		$('#preWorkCharger').val("");
		$('#preWorkCharger').val('');

		userNumber = "";
		//검사자 값 초기화
		$("#preWorkChargerNm").val("");
		$('#preWorkCharger').val("");
		$('#preWorkCharger').val('');

		userNumber = "";
		qutyCd = null;

		tabDate[0];
		
		// 리로드
// 		if( $('#showDate').val() == 'showDate001' ) {
//   			chooseDate1 = $('#chooseDateFrom').val();
//   	  		chooseDate2 = $('#chooseDateTo').val();
//   	  		production1 = '';
// 			production2 = '';
// 		} else {
// 			chooseDate1 = '';
// 			chooseDate2 = '';
// 			production1 = $('#productionFrom').val();
// 			production2 = $('#productionTo').val();
// 		}
  		userNumber	= $('#preWorkCharger').val();
//  		$('#faultyStatsDay').DataTable().ajax.reload();
 		
 		tabView = 'tabView1';
 		//faultyStatsDay.data().length == 0 ? faultyStatsDay.draw() : "";
 		faultyStatsDay.draw();
 		tabDateFunction(0, 'faultyStatsDay');
 		$('#showDate option').eq(0).text('(외관)검사일');
	});

	//탭 2클릭 시
	$('#tab2').click(function() {
		$('#edgeGoodsFaultyView').removeClass("d-none");
		$('#edgeGoodsFaultyDateLookup').removeClass("d-none");
		$('#workOrderDateLokkup').addClass("d-none");
		$('#workOrderView').addClass("d-none");
		$('#goodsFaultyDateLookup').addClass("d-none");
		$('#goodsFaultyView').addClass("d-none");
		$('#visionWorkOrdView').addClass("d-none");
		$("#visionChargerView").addClass("d-none");
		$('#comprehensiveQtyView').addClass("d-none");
		$('#workOrderReInspView').addClass("d-none");
		
		$('#btnPackingNumberInquiry').addClass("d-none");
		$('#workOrderGubun').addClass("d-none");
		$('#workOrderGubunLabel').addClass("d-none");
		$('#comprehensiveGubun').addClass("d-none");
		$('#comprehensiveGubunLabel').addClass("d-none");
		$('#preWorkChargerView').removeClass("d-none");		//사용자 모달
		
		$("#faultyStatsDay_filter").addClass("d-none");
		$("#edgeGoodsFaultyTable_filter").removeClass("d-none");
		$("#workOrderTable_filter").addClass("d-none");
		$("#workOrderReInspTable_filter").addClass("d-none");
		$("#visionWorkOrdTable_filter").addClass("d-none");
		$("#visionChargerTable_filter").addClass("d-none");		//생산비전불량(작업자)
		$("#comprehensiveQtyTable_filter").addClass("d-none");

		$('#exceptFaultyQty').addClass('d-none');
		$('#selectQutyCd').removeClass('d-none');

		$("#selectQutyCd").val("").prop("selected", true);
		//검사자 값 초기화
		$("#preWorkChargerNm").val("");
		$('#preWorkCharger').val("");
		$('#preWorkCharger').val('');

		userNumber = "";
		qutyCd = null;

// 		if( $('#showDate').val() == 'showDate001' ) {
//   			chooseDate1 = $('#chooseDateFrom').val();
//   	  		chooseDate2 = $('#chooseDateTo').val();
//   	  		production1 = '';
// 			production2 = '';
// 		} else {
// 			chooseDate1 = '';
// 			chooseDate2 = '';
// 			production1 = $('#productionFrom').val();
// 			production2 = $('#productionTo').val();
// 		}
  		userNumber	= $('#preWorkCharger').val();
//  		$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
 		
 		tabView = 'tabView2';
 		//edgeGoodsFaultyTable.data().length == 0 ? edgeGoodsFaultyTable.draw() : "";
 		edgeGoodsFaultyTable.draw();
 		
 		tabDateFunction(1, 'edgeGoodsFaultyTable');

 		$('#showDate option').eq(0).text('(엣지)검사일');
	});
	
	//탭 3클릭 시
	$('#tab3').click(function() {
		$('#workOrderView').removeClass("d-none");
		$('#workOrderDateLokkup').removeClass("d-none");		
		$('#goodsFaultyDateLookup').addClass("d-none");
		$('#goodsFaultyView').addClass("d-none");
		$('#edgeGoodsFaultyDateLookup').addClass("d-none");
		$('#edgeGoodsFaultyView').addClass("d-none");
		$('#visionWorkOrdView').addClass("d-none");
		$("#visionChargerView").addClass("d-none");
		$('#comprehensiveQtyView').addClass("d-none");
		$('#workOrderReInspView').addClass("d-none");
		
		$('#btnPackingNumberInquiry').removeClass("d-none");
		$('#workOrderGubun').removeClass("d-none");
		$('#workOrderGubunLabel').removeClass("d-none");
		$('#comprehensiveGubun').addClass("d-none");
		$('#comprehensiveGubunLabel').addClass("d-none");
		$('#preWorkChargerView').removeClass("d-none");		//사용자 모달
		$("#visionWorkOrdTable_filter").addClass("d-none");
		$("#visionChargerTableTable_filter").addClass("d-none");
		
		$("#faultyStatsDay_filter").addClass("d-none");
		$("#edgeGoodsFaultyTable_filter").addClass("d-none");
		$("#workOrderTable_filter").removeClass("d-none");
		$("#workOrderReInspTable_filter").addClass("d-none");
		$("#visionChargerTable_filter").addClass("d-none");		//생산비전불량(작업자)
		$("#comprehensiveQtyTable_filter").addClass("d-none");

		$('#exceptFaultyQty').addClass('d-none');
		$('#selectQutyCd').removeClass('d-none');

		$("#selectQutyCd").val("").prop("selected", true);
		//검사자 값 초기화
		$("#preWorkChargerNm").val("");
		$('#preWorkCharger').val("");
		$('#preWorkCharger').val('');

		userNumber = "";
		qutyCd = null;
		
// 		if( $('#showDate').val() == 'showDate001' ) {
//   			chooseDate1 = $('#chooseDateFrom').val();
//   	  		chooseDate2 = $('#chooseDateTo').val();
//   	  		production1 = '';
// 			production2 = '';
// 		} else {
// 			chooseDate1 = '';
// 			chooseDate2 = '';
// 			production1 = $('#productionFrom').val();
// 			production2 = $('#productionTo').val();
// 		}
  		userNumber	= $('#preWorkCharger').val();
// 		$('#workOrderTable').DataTable().ajax.reload();
		tabView = 'tabView3';
		//workOrderTable.data().length == 0 ? workOrderTable.draw() : "";
		workOrderTable.draw();
		
		tabDateFunction(2, 'workOrderTable');
		$('#showDate option').eq(0).text('(외관)검사일');
	});

	$('#tab4').click(function() {
		$('#workOrderView').addClass("d-none");
		$('#workOrderDateLokkup').addClass("d-none");		
		$('#goodsFaultyDateLookup').addClass("d-none");
		$('#goodsFaultyView').addClass("d-none");
		$('#edgeGoodsFaultyDateLookup').addClass("d-none");
		$('#edgeGoodsFaultyView').addClass("d-none");
		$('#visionWorkOrdView').removeClass("d-none");
		$('#comprehensiveQtyView').addClass("d-none");
		$('#workOrderReInspView').addClass("d-none");
		
		$('#btnPackingNumberInquiry').addClass("d-none");
		$('#workOrderGubun').addClass("d-none");
		$('#workOrderGubunLabel').addClass("d-none");
		$('#comprehensiveGubun').addClass("d-none");
		$('#comprehensiveGubunLabel').addClass("d-none");
		$('#preWorkChargerView').addClass("d-none");		//사용자 모달
		
		$("#faultyStatsDay_filter").addClass("d-none");
		$("#edgeGoodsFaultyTable_filter").addClass("d-none");
		$("#workOrderTable_filter").addClass("d-none");
		$("#workOrderReInspTable_filter").addClass("d-none");
		$("#visionWorkOrdTable_filter").removeClass("d-none");
		$("#visionChargerTable_filter").addClass("d-none");		//생산비전불량(작업자)
		$("#comprehensiveQtyTable_filter").addClass("d-none");

		$('#exceptFaultyQty').addClass('d-none');
		$('#selectQutyCd').addClass('d-none');
		
		$("#visionWorkOrdView").removeClass("d-none");
		$("#visionChargerView").addClass("d-none");

		$("#selectQutyCd").val("").prop("selected", true);
		//검사자 값 초기화
		$("#preWorkChargerNm").val("");
		$('#preWorkCharger').val("");
		$('#preWorkCharger').val('');

		userNumber = "";
		qutyCd = null;

// 		if( $('#showDate').val() == 'showDate001' ) {
//   			chooseDate1 = $('#chooseDateFrom').val();
//   	  		chooseDate2 = $('#chooseDateTo').val();
//   	  		production1 = '';
// 			production2 = '';
// 		} else {
// 			chooseDate1 = '';
// 			chooseDate2 = '';
// 			production1 = $('#productionFrom').val();
// 			production2 = $('#productionTo').val();
// 		}
// 		$('#visionWorkOrdTable').DataTable().ajax.reload();
		
		tabView = 'tabView4';
		//visionWorkOrdTable.data().length == 0 ? visionWorkOrdTable.draw() : "";
		visionWorkOrdTable.draw();
		tabDateFunction(3, 'visionWorkOrdTable');
		$('#showDate option').eq(0).text('(외관)검사일');
	});

	$('#tab5').click(function() {
		$('#workOrderView').addClass("d-none");
		$('#workOrderDateLokkup').addClass("d-none");		
		$('#goodsFaultyDateLookup').addClass("d-none");
		$('#goodsFaultyView').addClass("d-none");
		$('#edgeGoodsFaultyDateLookup').addClass("d-none");
		$('#edgeGoodsFaultyView').addClass("d-none");
		$('#visionWorkOrdView').addClass("d-none");
		$("#visionChargerView").removeClass("d-none");
		$('#comprehensiveQtyView').addClass("d-none");
		$('#workOrderReInspView').addClass("d-none");
		
		$('#btnPackingNumberInquiry').addClass("d-none");
		$('#workOrderGubun').addClass("d-none");
		$('#workOrderGubunLabel').addClass("d-none");
		$('#comprehensiveGubun').addClass("d-none");
		$('#comprehensiveGubunLabel').addClass("d-none");
		$('#preWorkChargerView').addClass("d-none");		//사용자 모달
		
		$("#faultyStatsDay_filter").addClass("d-none");
		$("#edgeGoodsFaultyTable_filter").addClass("d-none");
		$("#workOrderTable_filter").addClass("d-none");
		$("#workOrderReInspTable_filter").addClass("d-none");
		$("#visionWorkOrdTable_filter").addClass("d-none");
		$("#visionChargerTable_filter").removeClass("d-none");		//생산비전불량(작업자)
		
		$("#comprehensiveQtyTable_filter").addClass("d-none");

		$('#exceptFaultyQty').addClass('d-none');
		$('#selectQutyCd').addClass('d-none');

		$("#selectQutyCd").val("").prop("selected", true);
		//검사자 값 초기화
		$("#preWorkChargerNm").val("");
		$('#preWorkCharger').val("");
		$('#preWorkCharger').val('');

		userNumber = "";
		qutyCd = null;

// 		if( $('#showDate').val() == 'showDate001' ) {
//   			chooseDate1 = $('#chooseDateFrom').val();
//   	  		chooseDate2 = $('#chooseDateTo').val();
//   	  		production1 = '';
// 			production2 = '';
// 		} else {
// 			chooseDate1 = '';
// 			chooseDate2 = '';
// 			production1 = $('#productionFrom').val();
// 			production2 = $('#productionTo').val();
// 		}
// 		$('#visionChargerTable').DataTable().ajax.reload();
		tabView = 'tabView5';
		//visionChargerTable.data().length == 0 ? visionChargerTable.draw() : "";
		visionChargerTable.draw();
		
		tabDateFunction(4, 'visionChargerTable');
		$('#showDate option').eq(0).text('(외관)검사일');
	});

	$('#tab6').click(function() {
		$('#workOrderView').addClass("d-none");
		$('#workOrderDateLokkup').addClass("d-none");		
		$('#goodsFaultyDateLookup').addClass("d-none");
		$('#goodsFaultyView').addClass("d-none");
		$('#edgeGoodsFaultyDateLookup').addClass("d-none");
		$('#edgeGoodsFaultyView').addClass("d-none");
		$('#visionWorkOrdView').addClass("d-none");
		$("#visionChargerView").addClass("d-none");
		$('#comprehensiveQtyView').removeClass("d-none");
		$('#workOrderReInspView').addClass("d-none");
		
		$('#btnPackingNumberInquiry').addClass("d-none");
		$('#workOrderGubun').addClass("d-none");
		$('#workOrderGubunLabel').addClass("d-none");
		$('#comprehensiveGubun').removeClass("d-none");
		$('#comprehensiveGubunLabel').removeClass("d-none");
		$('#preWorkChargerView').removeClass("d-none");		//사용자 모달
		
		$("#faultyStatsDay_filter").addClass("d-none");
		$("#edgeGoodsFaultyTable_filter").addClass("d-none");
		$("#workOrderTable_filter").addClass("d-none");
		$("#workOrderReInspTable_filter").addClass("d-none");
		$("#visionWorkOrdTable_filter").addClass("d-none");
		$("#visionChargerTable_filter").addClass("d-none");		//생산비전불량(작업자)
		$("#comprehensiveQtyTable_filter").removeClass("d-none");

		$('#exceptFaultyQty').removeClass('d-none');
		$('#selectQutyCd').removeClass('d-none');

		$("#selectQutyCd").val("").prop("selected", true);
		//검사자 값 초기화
		$("#preWorkChargerNm").val("");
		$('#preWorkCharger').val("");
		$('#preWorkCharger').val('');

		userNumber = "";
		qutyCd = null;

// 		if( $('#showDate').val() == 'showDate001' ) {
//   			chooseDate1 = $('#chooseDateFrom').val();
//   	  		chooseDate2 = $('#chooseDateTo').val();
//   	  		production1 = '';
// 			production2 = '';
// 		} else {
// 			chooseDate1 = '';
// 			chooseDate2 = '';
// 			production1 = $('#productionFrom').val();
// 			production2 = $('#productionTo').val();
// 		}

// 		$('#comprehensiveQtyTable').DataTable().ajax.reload();
		tabView = 'tabView6';
		//comprehensiveQtyTable.data().length == 0 ? comprehensiveQtyTable.draw() : "";
		comprehensiveQtyTable.draw();
		
		tabDateFunction(5, 'comprehensiveQtyTable');
		$('#showDate option').eq(0).text('(외관)검사일');
	});


	//탭 3클릭 시
	$('#tab7').click(function() {
		$('#workOrderView').addClass("d-none");
		$('#workOrderDateLokkup').addClass("d-none");		
		$('#goodsFaultyDateLookup').addClass("d-none");
		$('#goodsFaultyView').addClass("d-none");
		$('#edgeGoodsFaultyDateLookup').addClass("d-none");
		$('#edgeGoodsFaultyView').addClass("d-none");
		$('#visionWorkOrdView').addClass("d-none");
		$("#visionChargerView").addClass("d-none");
		$('#comprehensiveQtyView').addClass("d-none");
		$('#workOrderReInspView').removeClass("d-none");
		
		
		$('#btnPackingNumberInquiry').removeClass("d-none");
		$('#workOrderGubun').removeClass("d-none");
		$('#workOrderGubunLabel').removeClass("d-none");
		$('#comprehensiveGubun').addClass("d-none");
		$('#comprehensiveGubunLabel').addClass("d-none");
		$('#preWorkChargerView').removeClass("d-none");		//사용자 모달
		$("#visionWorkOrdTable_filter").addClass("d-none");
		$("#visionChargerTableTable_filter").addClass("d-none");
		
		$("#faultyStatsDay_filter").addClass("d-none");
		$("#edgeGoodsFaultyTable_filter").addClass("d-none");
		$("#workOrderTable_filter").addClass("d-none");
		$("#workOrderReInspTable_filter").removeClass("d-none");
		$("#visionChargerTable_filter").addClass("d-none");		//생산비전불량(작업자)
		$("#comprehensiveQtyTable_filter").addClass("d-none");

		$('#exceptFaultyQty').addClass('d-none');
		$('#selectQutyCd').removeClass('d-none');

		$("#selectQutyCd").val("").prop("selected", true);
		//검사자 값 초기화
		$("#preWorkChargerNm").val("");
		$('#preWorkCharger').val("");
		$('#preWorkCharger').val('');

		userNumber = "";
		qutyCd = null;
		
// 		if( $('#showDate').val() == 'showDate001' ) {
//   			chooseDate1 = $('#chooseDateFrom').val();
//   	  		chooseDate2 = $('#chooseDateTo').val();
//   	  		production1 = '';
// 			production2 = '';
// 		} else {
// 			chooseDate1 = '';
// 			chooseDate2 = '';
// 			production1 = $('#productionFrom').val();
// 			production2 = $('#productionTo').val();
// 		}
  		userNumber	= $('#preWorkCharger').val();
// 		$('#workOrderTable').DataTable().ajax.reload();
		tabView = 'tabView7';
		//workOrderTable.data().length == 0 ? workOrderTable.draw() : "";
		workOrderReInspTable.draw();
		
		tabDateFunction(6, 'workOrderReInspTable');
		$('#showDate option').eq(0).text('(외관)검사일');
	});
	
	function tabDateFunction(num, tableName ){
		if( $('#allDateGubun').prop('checked') ) {//날짜 전체 적용 체크 유구
			if( $('#showDate').val() == 'showDate001' ) {
				if( chooseDate1 != tabDate[num].split("|")[0] || chooseDate2 != tabDate[num].split("|")[1] || $('#showDate').val() != tabDate[num].split("|")[2] ){
					//tabDate[num] = $('#chooseDateFrom').val() + "|" + $('#chooseDateTo').val();
					//$('#'+tableName).DataTable().ajax.reload();
					$('#btnRetv').click();
				} else {
					chooseDate1 = tabDate[num].split("|")[0];
			  		chooseDate2 = tabDate[num].split("|")[1];
			  		$('#chooseDateFrom').val( tabDate[num].split("|")[0] );
			  		$('#chooseDateTo').val( tabDate[num].split("|")[1] );
				}
			} else {
				if( production1 != tabDate[num].split("|")[0] || production2 != tabDate[num].split("|")[1] || $('#showDate').val() != tabDate[num].split("|")[2] ){
					//tabDate[num] = $('#productionFrom').val() + "|" + $('#productionTo').val();
					//$('#'+tableName).DataTable().ajax.reload();
					$('#btnRetv').click();
				} else {
					production1 = tabDate[num].split("|")[0];
					production2 = tabDate[num].split("|")[1];
			  		$('#productionFrom').val( tabDate[num].split("|")[0] );
			  		$('#productionTo').val( tabDate[num].split("|")[1] );
				}
			}
		} else {
			if( $('#showDate').val() == 'showDate001' ) {
		  		chooseDate1 = tabDate[num].split("|")[0];
			  	chooseDate2 = tabDate[num].split("|")[1];
			  	$('#chooseDateFrom').val( tabDate[num].split("|")[0] );
			  	$('#chooseDateTo').val( tabDate[num].split("|")[1] );
		  		if( $('#showDate').val() != tabDate[num].split("|")[2] ){
					$('#btnRetv').click();
				} 
			} else {
				production1 = tabDate[num].split("|")[0];
				production2 = tabDate[num].split("|")[1];
		  		$('#productionFrom').val( tabDate[num].split("|")[0] );
		  		$('#productionTo').val( tabDate[num].split("|")[1] );
		  		if( $('#showDate').val() != tabDate[num].split("|")[2] ){
					$('#btnRetv').click();
				}
			}
			
		}
	}
	
	//let chooseDate1 = "${serverDateFrom}";
	let chooseDate1 = "${serverDateFrom}";
	let chooseDate2 = "${serverDate}";
	let production1 = "";
	let production2 = "";

	var showType 			= "showType001";
	//var sumOutputCnt		= 0;
	//var sumAppearOutputCnt	= 0;
	//var sumFaulty 			= 0;
	var userNumber 			= null;
	var workOrdNo 			= "empty";
	var workOrdLotNo		= "empty";
	let qutyCd 				= null;
	let endArrayCount		= null;
	
	appearHeaderCreate();					//외관검사
	edgeAppearHeaderCreate();				//엣지검사
	workOrderAppearHeaderCreate();			//작지번호별
	visionWorkOrdHeaderCreate();			//비전불량(작업지시)
	visionChargerHeaderCreate();			//비전불량(작업지시)
	comprehensiveQtyAppearHeaderCreate();	//종합 수량
	workOrderReInspHeaderCreate();			//작지재검

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
        scrollX : true,
        fixedColumns: {
			leftColumns: 6
       	},
        //scrollY : "56vh",
        scrollCollapse: true,
        
        lengthChange: false,
        pageLength: 16,
        ajax: {
            url: '<c:url value="/qm/faultyTotalDataList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
				'productionFrom'	:		function() { return production1.replace(/-/g, ''); },
				'productionTo'		:		function() { return production2.replace(/-/g, ''); },
				'qutyCd'    		:       function() { return qutyCd;},
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
                title: '생산검사현황-외관검사',
            },
            {
				extend: 'excel',
				title: '생산검사현황-외관검사',
				exportOptions: {
					columns: ':visible',
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
                title: '생산검사현황-외관검사',
            },
        ],
		columnDefs: [
			{ targets: [2,3,4,5,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [2,3,4,5,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132], className: 'text-right' },
		],
		drawCallback: function () {
			$('#faultyStatsDay tfoot').remove();
			$('#faultyStatsDay').attr('style', 'margin-top: -1px !important;');
			
			/*$.each($('#faultyStatsDay tbody tr'),function(index,item) {
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
	
			});*/
			
			//전역변수들
 			let sumOutputCnt		= $('#faultyStatsDay').DataTable().column(2,{ page: 'all'} ).data().sum();
			let sumAppearOutputCnt	= $('#faultyStatsDay').DataTable().column(3,{ page: 'all'} ).data().sum();
			let sumFaulty			= $('#faultyStatsDay').DataTable().column(4,{ page: 'all'} ).data().sum();
			let sumFaultyPercent	= 100 * sumFaulty / sumOutputCnt;

			$('#sumOutputCnt').html(addCommas(sumOutputCnt));
			$('#sumAppearOutputCnt').html(addCommas(sumAppearOutputCnt));
			$('#sumFaulty').html(addCommas(sumFaulty));
			$('#sumFaultyPercent').html(sumFaultyPercent.toFixed(2) + "%");

			//틀 고저 tfooter
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(1).text('');
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(2).text(addCommas(sumOutputCnt));
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(3).text(addCommas(sumAppearOutputCnt));
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(4).text(addCommas(sumFaulty));
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(5).text(sumFaultyPercent.toFixed(2) + "%");
			
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
	$('#productionFrom').val(production1);
	$('#productionTo').val(production2);

	//외관검사 검색
	$('#faultyStatsDay_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#faultyStatsDay_filter').find('label').eq(0).addClass('row ml-3');
	$('#faultyStatsDay_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#faultyStatsDay_filter").insertAfter("#showType");
	$("#faultyStatsDay_filter").addClass("d-none");

	//외관검사
	columnVisibleFun('faultyStatsDay', systemCommonCode.length, faultyStatsDay);
	
	//외관검사 테이블 클릭 시
  	$('#faultyStatsDay_wrapper table').eq(1).find('tbody').on('click', 'tr', function () {
  		if( $(this.parentNode.parentNode).attr('class') == 'table table-bordered mt-0 dataTable' ) {
			if ($(this).hasClass('selected')) {
	// 			$(this).removeClass('selected');
			} else {
				$('#faultyStatsDay').DataTable().$('tr.selected').removeClass('selected');
				$(this).addClass('selected');
			}
			workOrdLotNo = faultyStatsDay.row(this).data().workOrdLotNo;
  		}
  		$('#faultyStatsDay_wrapper table').eq(4).find('tbody tr').removeClass('selected');
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
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : true,
        fixedColumns: {
			leftColumns: 6
       	},
        scrollY : "56vh",
        scrollCollapse: true,
        lengthChange: false,
//         pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/edgeFaultyTotalDataList_F2"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
				'productionFrom'	:		function() { return production1.replace(/-/g, ''); },
				'productionTo'		:		function() { return production2.replace(/-/g, ''); },
				'qutyCd'    		:       function() { return qutyCd;},
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
                title: '생산검사현황-엣지검사',
            },
            {
				extend: 'excel',
				title: '생산검사현황-엣지검사',
				exportOptions: {
					columns: ':visible',
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
                title: '생산검사현황-엣지검사',
            },
        ],
		columnDefs: [
			{ targets: [2,3,4,5,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [2,3,4,5,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96], className: 'text-right' },
		],
		drawCallback: function () {
			$('#edgeGoodsFaultyTable tfoot').remove();
			$('#edgeGoodsFaultyTable').attr('style', 'margin-top: -1px !important;');
			$('#edgeGoodsFaultyTable_wrapper table').eq(0).attr('style', 'margin-top: -1px !important;');

			/*$.each($('#edgeGoodsFaultyTable tbody tr'),function(index,item){
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
			});*/
			
			//전역변수들
 			let edgeSumOutputCnt		= $('#edgeGoodsFaultyTable').DataTable().column(2,{ page: 'all'} ).data().sum();
			let edgeSumAppearOutputCnt	= $('#edgeGoodsFaultyTable').DataTable().column(3,{ page: 'all'} ).data().sum();
			let edgeSumFaulty			= $('#edgeGoodsFaultyTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			let edgeSumFaultyPercent = 100 * edgeSumFaulty / edgeSumOutputCnt;

			$('#edgeSumOutputCnt').html(addCommas(edgeSumOutputCnt));
			$('#edgeSumAppearOutputCnt').html(addCommas(edgeSumAppearOutputCnt));
			$('#edgeSumFaulty').html(addCommas(edgeSumFaulty));
			$('#edgeSumFaultyPercent').html(edgeSumFaultyPercent.toFixed(2) + "%");

			$('#edgeGoodsFaultyTable_wrapper table').eq(5).find('tfoot tr td').eq(2).text(addCommas(edgeSumOutputCnt));
			$('#edgeGoodsFaultyTable_wrapper table').eq(5).find('tfoot tr td').eq(3).text(addCommas(edgeSumAppearOutputCnt));
			$('#edgeGoodsFaultyTable_wrapper table').eq(5).find('tfoot tr td').eq(4).text(addCommas(edgeSumFaulty));
			$('#edgeGoodsFaultyTable_wrapper table').eq(5).find('tfoot tr td').eq(5).text(edgeSumFaultyPercent.toFixed(2) + "%");
			
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
	$('#productionFrom').val(production1);
	$('#productionTo').val(production2);

	//엣지검사
	columnVisibleFun('edgeGoodsFaultyTable', edgeGoodsFaultyCode.length, edgeGoodsFaultyTable);	
	
	//엣지검사 검색
	$('#edgeGoodsFaultyTable_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#edgeGoodsFaultyTable_filter').find('label').eq(0).addClass('row ml-3');
	$('#edgeGoodsFaultyTable_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#edgeGoodsFaultyTable_filter").insertAfter("#showType");
	$("#edgeGoodsFaultyTable_filter").addClass("d-none");
	
	//엣지검사 테이블 클릭 시
  	$('#edgeGoodsFaultyTable_wrapper table').eq(1).find('tbody').on('click', 'tr', function () {
  		if( $(this.parentNode.parentNode).attr('class') == 'table table-bordered dataTable' ) {
			if ($(this).hasClass('selected')) {
				//$(this).removeClass('selected');
			} else {
				$('#edgeGoodsFaultyTable').DataTable().$('tr.selected').removeClass('selected');
				$(this).addClass('selected');
			}
  		}
  		$('#edgeGoodsFaultyTable_wrapper table').eq(4).find('tbody tr').removeClass('selected');
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
//         scrollY : "56vh",
        lengthChange: false,

        scrollX: true,
        fixedColumns: {
        	 leftColumns: 4
        },
        
		scrollCollapse: true,
        pageLength: 16,
        ajax: {
            url: '<c:url value="/qm/workOrderTotalDataList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
				'productionFrom'	:		function() { return production1.replace(/-/g, ''); },
				'productionTo'		:		function() { return production2.replace(/-/g, ''); },
				'workOrderGubun'    :       function() { return workOrderGubunVal;},
				'qutyCd'    		:       function() { return qutyCd;},
            },
        },
		//rowId: 'workOrdNo',
        columns: [
        	{
				render: function(data, type, row) {
					return moment(row['workOrdDate']).format('YYYY-MM-DD');
				}
			},//작업지시일
			{data:'workOrdLotNo'},//생산lotNo
        	{data:'goodsNm'},//제품
        	
        	{data:'qutyNm'},//재질
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

			{data:'mainWorkChargrNm'		}, //생산 작업자

			{data:'appearInspctDate',
				render: function(data, type, row) {
					if(data == null || data==''){
						return '-';
					} else {
						return moment(data).format('YYYY-MM-DD');
					}
        		}
			}, //외관검사일
			
        	{data:'edgeInspctChargerNm'		}, //엣지 검사자
        	{data:'appearInspctChargerNm'	}, //외관 검사자
			
        	{data:'equipNm'},//설비명
        	{data:'workOrdNo'},//작지번호
        	
        	{data:'model'},//규격
        	
        	{data:'lotNo'},//주자재
        	{data:'subFilm1'},
        	{data:'subFilm2'},
        	{data:'subFilm3'},
        	{data:'subFilm4'},
        	{ data: 'faulty1',
        		render: function(data, type, row) {/*
            		if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {						
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
                title: '생산검사현황-작업지시별',
            },
            {
				extend: 'excel',
				title: '생산검사현황-작업지시별',
				exportOptions: {
					columns: ':visible',
					format: {
						body: function(data, column, row, node) {
							if (row == 10 || row == 11) {
								data = data.replace('<p style="color:red; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('<p style="color:blue; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('</p>', '');
								return data;
							}
							if (showType == 'showType001') {
								if (row == 9) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 9) { return data.replace(" %", ""); }
// 								else if (row == 17) { return data.replace(" %", ""); }
// 								else if (row == 18) { return data.replace(" %", ""); }
// 								else if (row == 19) { return data.replace(" %", ""); }
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
								else if (row == 157) { return data.replace(" %", ""); }
								else if (row == 158) { return data.replace(" %", ""); }
								else if (row == 159) { return data.replace(" %", ""); }
								else { return data; }
							}
						}
				    }
				}
            },
            {
                extend: 'print',
                title: '생산검사현황-작업지시별',
            },
        ],
		columnDefs: [
			{ targets: [4,5,14,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], render: $.fn.dataTable.render.number( ',' ) },

// 			{ targets: [1,2,3,4,5,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
// 				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], className: 'text-right' },
			{ targets: [0,1,2,3,9,10,11,12,13,14,15,16,17,18,19,20, 21], className: 'text-center' },
        	{ targets: "_all", className: 'text-right' },
        	//{ targets: [0,1,2,3,4,5,6,7,8], "width": "90%" }
		],
		drawCallback: function () {
			$('#workOrderTable tfoot').remove();
			$('#workOrderTable').attr('style', 'margin-top: -1px !important;');

			//컬럼 추가될떄 for문 값 늘려주기
			/*$.each($('#workOrderTable tbody tr'),function(index,item){
				for(var i=0; i<=155; i++){
					if ($('#workOrderTable .'+i).text() == "") {
						$('#workOrderTable .'+i).addClass('d-none');
						$('#workOrderTable tbody tr').eq(index).find('td').eq( (21+i) ).addClass('d-none'); //컬럼 앞에 추가 시 추가한 만큼 eqSize늘려주기
						$('#workOrderTable tfoot tr').eq(0).find('td').eq( (7+i) ).addClass('d-none');
					}
				}
			});*/

			//전역변수들
 			let workOrderSumOutputCnt		= $('#workOrderTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			let workOrderSumAppearOutputCnt	= $('#workOrderTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let workOrderSumFaulty			= $('#workOrderTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			let workOrderSumVisionFaulty	= $('#workOrderTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			let workOrderSumFaultyPercent	= 100 * workOrderSumFaulty / workOrderSumOutputCnt;

			$('#workOrderSumOutputCnt').html(addCommas(workOrderSumOutputCnt));
			$('#workOrderSumAppearOutputCnt').html(addCommas(workOrderSumAppearOutputCnt));
			$('#workOrderSumFaulty').html(addCommas(workOrderSumFaulty));
            $('#workOrderSumVisionFaulty').html(addCommas(workOrderSumVisionFaulty));
			$('#workOrderSumFaultyPercent').html(workOrderSumFaultyPercent.toFixed(2) + "%");

			//컬럼 추가 시 for문 도 수정
			let workOrderFaultyArray = new Array();
			
            for(var i=0; i<140; i++){
            	workOrderFaultyArray[i] = showTypeChange($('#workOrderTable').DataTable().column( (21+i) ,{ page: 'all'} ).data().sum(), workOrderSumOutputCnt);	//컬럼 추가될떄 column값도 늘려주기
            } 

			for(var i=0; i<140; i++){
				$('#workOrderFaulty'+ (i+1) ).html(addCommas(workOrderFaultyArray[i]));
			}
        },
    });

	//작업지시별
	columnVisibleFun('workOrderTable', systemCommonCode.length, workOrderTable);	
	
	workOrderTable.on('draw.dt', function(){
		$("td[name=td2]").remove();
		$("td[name=td3]").remove();
		$("td[name=td4]").remove();
		$("td[name=td1]").attr('colspan', '4');
	});

	//작업지시 테이블 클릭 시
  	$('#workOrderTable_wrapper table').eq(1).find('tbody').on('click', 'tr', function () {
  		if( $(this.parentNode.parentNode).attr('class') == 'table table-bordered dataTable' ) {
			if ($(this).hasClass('selected')) {
				//$(this).removeClass('selected');
			} else {
				$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
				$(this).addClass('selected');
			}
			workOrdLotNo = workOrderTable.row(this).data().workOrdLotNo;
  		}
  		$('#workOrderTable_wrapper table').eq(4).find('tbody tr').removeClass('selected');
  	});
  	
	//작업지시 테이블 더블클릭 시
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
	$('#productionFrom').val(production1);
	$('#productionTo').val(production2);
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


	//생산비전불량(작업지시)
	$.fn.dataTable.ext.errMode = 'none';
	let visionWorkOrdTable = $('#visionWorkOrdTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
    	language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        
        scrollX : true,
        fixedColumns: {
			leftColumns: 4
       	},
        scrollY : "56vh",
        scrollCollapse: true,
        
        lengthChange: false,
//         pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/visionWorkOrdTotalList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				//'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
				'productionFrom'	:		function() { return production1.replace(/-/g, ''); },
				'productionTo'		:		function() { return production2.replace(/-/g, ''); },
				//'workOrderGubun'    :       function() { return workOrderGubunVal;},
            },
        },
		//rowId: 'workOrdNo',
        columns: [
        	{data:'goodsNm'},			//제품명
        	{data:'workOrdNo'},			//작업지시
        	{data:'lotNo'},				//주재료
        	{data:'faultyCntSum'},		//총 비전불량수량
        	{ data: 'faulty1',
        		render: function(data, type, row) {/*
            		if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty2',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty3',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty4',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty5',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty6',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty7',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty8',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty9',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty10',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty11',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty12',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty13',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty14',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty15',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty16',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty17',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty18',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty19',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty20',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty21',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty22',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty23',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty24',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty25',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty26',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty27',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty28',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty29',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty30',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty31',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty32',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty33',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty34',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty35',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty36',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty37',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty38',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty39',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty40',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty41',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty42',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty43',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty44',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty45',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty46',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty47',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty48',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty49',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty50',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
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
                title: '생산검사현황-생산비전불량(작업지시)',
            },
            {
				extend: 'excel',
				title: '생산검사현황-생산비전불량(작업지시)',
				exportOptions: {
					columns: ':visible',
					format: {
						body: function(data, column, row, node) {
							if (showType == 'showType001') {
								if (row == 6) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 6) { return data.replace(" %", ""); }
								else if (row == 4) { return data.replace(" %", ""); }
								else if (row == 5) { return data.replace(" %", ""); }
								else if (row == 6) { return data.replace(" %", ""); }
								else if (row == 7) { return data.replace(" %", ""); }
								else if (row == 8) { return data.replace(" %", ""); }
								else if (row == 9) { return data.replace(" %", ""); }
								else if (row == 10) { return data.replace(" %", ""); }
								else if (row == 11) { return data.replace(" %", ""); }
								else if (row == 12) { return data.replace(" %", ""); }
								else if (row == 13) { return data.replace(" %", ""); }
								else if (row == 14) { return data.replace(" %", ""); }
								else if (row == 15) { return data.replace(" %", ""); }
								else if (row == 16) { return data.replace(" %", ""); }
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
								else { return data; }
							}
						}
				    }
				}
            },
            {
                extend: 'print',
                title: '생산검사현황-생산비전불량(작업지시)',
            },
        ],
		columnDefs: [
			{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53], className: 'text-right' },
		],
		drawCallback: function () {
			$('#visionWorkOrdTable tfoot').remove();
			$('#visionWorkOrdTable').attr('style', 'margin-top: -1px !important;');
			$('#visionWorkOrdTable_wrapper table').eq(0).attr('style', 'margin-top: -1px !important;');
			$('#visionWorkOrdTable_wrapper div').find('.dataTables_scrollHeadInner').attr('style', 'box-sizing: content-box;padding-right: 10px;');
			
			/*$.each($('#visionWorkOrdTable tbody tr'),function(index,item){
				if ($('#visionWorkOrdTable .0').text()==""){            	
					$('#visionWorkOrdTable .0').addClass('d-none');
					$(this).find('td').eq(4).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(2).addClass('d-none');
				}
				if ($('#visionWorkOrdTable .1').text() == "") {
					$('#visionWorkOrdTable .1').addClass('d-none');
					$(this).find('td').eq(5).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(3).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .2').text() == "") {
					$('#visionWorkOrdTable .2').addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(4).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .3').text() == "") {
					$('#visionWorkOrdTable .3').addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(5).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .4').text() == "") {
					$('#visionWorkOrdTable .4').addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(6).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .5').text() == "") {
					$('#visionWorkOrdTable .5').addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(7).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .6').text() == "") {
					$('#visionWorkOrdTable .6').addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(8).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .7').text() == "") {
					$('#visionWorkOrdTable .7').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(9).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .8').text() == "") {
					$('#visionWorkOrdTable .8').addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(10).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .9').text() == "") {
					$('#visionWorkOrdTable .9').addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(11).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .10').text() == "") {
					$('#visionWorkOrdTable .10').addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(12).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .11').text() == "") {
					$('#visionWorkOrdTable .11').addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(13).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .12').text() == "") {
					$('#visionWorkOrdTable .12').addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(14).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .13').text() == "") {
					$('#visionWorkOrdTable .13').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(15).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .14').text() == "") {
					$('#visionWorkOrdTable .14').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(16).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .15').text() == "") {
					$('#visionWorkOrdTable .15').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(17).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .16').text() == "") {
					$('#visionWorkOrdTable .16').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(18).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .17').text() == "") {
					$('#visionWorkOrdTable .17').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(19).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .18').text() == "") {
					$('#visionWorkOrdTable .18').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(20).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .19').text() == "") {
					$('#visionWorkOrdTable .19').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(21).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .20').text() == "") {
					$('#visionWorkOrdTable .20').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(22).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .21').text() == "") {
					$('#visionWorkOrdTable .21').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(23).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .22').text() == "") {
					$('#visionWorkOrdTable .22').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(24).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .23').text() == "") {
					$('#visionWorkOrdTable .23').addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(25).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .24').text() == "") {
					$('#visionWorkOrdTable .24').addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(26).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .25').text() == "") {
					$('#visionWorkOrdTable .25').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(27).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .26').text() == "") {
					$('#visionWorkOrdTable .26').addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(28).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .27').text() == "") {
					$('#visionWorkOrdTable .27').addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(29).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .28').text() == "") {
					$('#visionWorkOrdTable .28').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(30).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .29').text() == "") {
					$('#visionWorkOrdTable .29').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(31).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .30').text() == "") {
					$('#visionWorkOrdTable .30').addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(32).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .31').text() == "") {
					$('#visionWorkOrdTable .31').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(33).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .32').text() == "") {
					$('#visionWorkOrdTable .32').addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(34).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .33').text() == "") {
					$('#visionWorkOrdTable .33').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(35).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .34').text() == "") {
					$('#visionWorkOrdTable .34').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(36).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .35').text() == "") {
					$('#visionWorkOrdTable .35').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(37).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .36').text() == "") {
					$('#visionWorkOrdTable .36').addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(38).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .37').text() == "") {
					$('#visionWorkOrdTable .37').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(39).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .38').text() == "") {
					$('#visionWorkOrdTable .38').addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(40).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .39').text() == "") {
					$('#visionWorkOrdTable .39').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(41).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .40').text() == "") {
					$('#visionWorkOrdTable .40').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(42).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .41').text() == "") {
					$('#visionWorkOrdTable .41').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(43).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .42').text() == "") {
					$('#visionWorkOrdTable .42').addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(44).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .43').text() == "") {
					$('#visionWorkOrdTable .43').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(45).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .44').text() == "") {
					$('#visionWorkOrdTable .44').addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(46).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .45').text() == "") {
					$('#visionWorkOrdTable .45').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(47).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .46').text() == "") {
					$('#visionWorkOrdTable .46').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(48).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .47').text() == "") {
					$('#visionWorkOrdTable .47').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(49).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .48').text() == "") {
					$('#visionWorkOrdTable .48').addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(50).addClass('d-none');
					
				}
				if ($('#visionWorkOrdTable .49').text() == "") {
					$('#visionWorkOrdTable .49').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$('#visionWorkOrdTable tfoot tr').eq(0).find('td').eq(51).addClass('d-none');
					
				}
			});*/
			
			//전역변수들
			let sumVisionWorkOrd			= $('#visionWorkOrdTable').DataTable().column(3,{ page: 'all'} ).data().sum();
			$('#sumVisionWorkOrd').html(addCommas(sumVisionWorkOrd));

			$('#visionWorkOrdTable_wrapper table').eq(5).find('tfoot tr td').eq(3).text(addCommas(sumVisionWorkOrd));
			
			//지역변수들
			let visionWorkOrdfaulty1	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(4,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty2	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(5,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty3	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(6,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty4	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(7,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty5	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(8,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty6	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(9,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty7	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(10,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty8	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(11,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty9	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(12,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty10	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(13,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty11	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(14,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty12	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(15,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty13	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(16,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty14	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(17,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty15	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(18,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty16	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(19,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty17	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(20,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty18	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(21,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty19	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(22,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty20	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(23,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty21	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(24,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty22	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(25,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty23	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(26,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty24	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(27,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty25	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(28,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty26	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(29,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty27	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(30,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty28	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(31,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty29	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(32,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty30	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(33,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty31	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(34,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty32	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(35,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty33	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(36,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty34	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(37,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty35	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(38,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty36	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(39,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty37	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(40,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty38	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(41,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty39	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(42,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty40	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(43,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty41	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(44,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty42	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(45,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty43	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(46,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty44	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(47,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty45	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(48,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty46	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(49,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
			let visionWorkOrdfaulty47	=	showTypeChange($('#visionWorkOrdTable').DataTable().column(50,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
            let visionWorkOrdfaulty48   =   showTypeChange($('#visionWorkOrdTable').DataTable().column(51,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
            let visionWorkOrdfaulty49   =   showTypeChange($('#visionWorkOrdTable').DataTable().column(52,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);
            let visionWorkOrdfaulty50   =   showTypeChange($('#visionWorkOrdTable').DataTable().column(53,{ page: 'all'} ).data().sum(), sumVisionWorkOrd);

			$('#visionWorkOrdfaulty1').html(addCommas(visionWorkOrdfaulty1));
			$('#visionWorkOrdfaulty2').html(addCommas(visionWorkOrdfaulty2));
			$('#visionWorkOrdfaulty3').html(addCommas(visionWorkOrdfaulty3));
			$('#visionWorkOrdfaulty4').html(addCommas(visionWorkOrdfaulty4));
			$('#visionWorkOrdfaulty5').html(addCommas(visionWorkOrdfaulty5));
			$('#visionWorkOrdfaulty6').html(addCommas(visionWorkOrdfaulty6));
			$('#visionWorkOrdfaulty7').html(addCommas(visionWorkOrdfaulty7));
			$('#visionWorkOrdfaulty8').html(addCommas(visionWorkOrdfaulty8));
			$('#visionWorkOrdfaulty9').html(addCommas(visionWorkOrdfaulty9));
			$('#visionWorkOrdfaulty10').html(addCommas(visionWorkOrdfaulty10));
			$('#visionWorkOrdfaulty11').html(addCommas(visionWorkOrdfaulty11));
			$('#visionWorkOrdfaulty12').html(addCommas(visionWorkOrdfaulty12));
			$('#visionWorkOrdfaulty13').html(addCommas(visionWorkOrdfaulty13));
			$('#visionWorkOrdfaulty14').html(addCommas(visionWorkOrdfaulty14));
			$('#visionWorkOrdfaulty15').html(addCommas(visionWorkOrdfaulty15));
			$('#visionWorkOrdfaulty16').html(addCommas(visionWorkOrdfaulty16));
			$('#visionWorkOrdfaulty17').html(addCommas(visionWorkOrdfaulty17));
			$('#visionWorkOrdfaulty18').html(addCommas(visionWorkOrdfaulty18));
			$('#visionWorkOrdfaulty19').html(addCommas(visionWorkOrdfaulty19));
			$('#visionWorkOrdfaulty20').html(addCommas(visionWorkOrdfaulty20));
			$('#visionWorkOrdfaulty21').html(addCommas(visionWorkOrdfaulty21));
			$('#visionWorkOrdfaulty22').html(addCommas(visionWorkOrdfaulty22));
			$('#visionWorkOrdfaulty23').html(addCommas(visionWorkOrdfaulty23));
			$('#visionWorkOrdfaulty24').html(addCommas(visionWorkOrdfaulty24));
			$('#visionWorkOrdfaulty25').html(addCommas(visionWorkOrdfaulty25));
			$('#visionWorkOrdfaulty26').html(addCommas(visionWorkOrdfaulty26));
			$('#visionWorkOrdfaulty27').html(addCommas(visionWorkOrdfaulty27));
			$('#visionWorkOrdfaulty28').html(addCommas(visionWorkOrdfaulty28));
			$('#visionWorkOrdfaulty29').html(addCommas(visionWorkOrdfaulty29));
			$('#visionWorkOrdfaulty30').html(addCommas(visionWorkOrdfaulty30));
			$('#visionWorkOrdfaulty31').html(addCommas(visionWorkOrdfaulty31));
			$('#visionWorkOrdfaulty32').html(addCommas(visionWorkOrdfaulty32));
			$('#visionWorkOrdfaulty33').html(addCommas(visionWorkOrdfaulty33));
			$('#visionWorkOrdfaulty34').html(addCommas(visionWorkOrdfaulty34));
			$('#visionWorkOrdfaulty35').html(addCommas(visionWorkOrdfaulty35));
			$('#visionWorkOrdfaulty36').html(addCommas(visionWorkOrdfaulty36));
			$('#visionWorkOrdfaulty37').html(addCommas(visionWorkOrdfaulty37));
			$('#visionWorkOrdfaulty38').html(addCommas(visionWorkOrdfaulty38));
			$('#visionWorkOrdfaulty39').html(addCommas(visionWorkOrdfaulty39));
			$('#visionWorkOrdfaulty40').html(addCommas(visionWorkOrdfaulty40));
			$('#visionWorkOrdfaulty41').html(addCommas(visionWorkOrdfaulty41));
			$('#visionWorkOrdfaulty42').html(addCommas(visionWorkOrdfaulty42));
			$('#visionWorkOrdfaulty43').html(addCommas(visionWorkOrdfaulty43));
			$('#visionWorkOrdfaulty44').html(addCommas(visionWorkOrdfaulty44));
			$('#visionWorkOrdfaulty45').html(addCommas(visionWorkOrdfaulty45));
			$('#visionWorkOrdfaulty46').html(addCommas(visionWorkOrdfaulty46));
			$('#visionWorkOrdfaulty47').html(addCommas(visionWorkOrdfaulty47));
			$('#visionWorkOrdfaulty48').html(addCommas(visionWorkOrdfaulty48));
			$('#visionWorkOrdfaulty49').html(addCommas(visionWorkOrdfaulty49));
			$('#visionWorkOrdfaulty50').html(addCommas(visionWorkOrdfaulty50));
        },
    });

	//작지번호별 검색
	$('#visionWorkOrdTable_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#visionWorkOrdTable_filter').find('label').eq(0).addClass('row ml-3');
	$('#visionWorkOrdTable_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#visionWorkOrdTable_filter").insertAfter("#showType");
	$('#visionWorkOrdTable_filter').addClass('d-none');

	//생산비전불량(작업지시)
	columnVisibleFun('visionWorkOrdTable', visionFaultyCode.length, visionWorkOrdTable);

	//생산비전불량(작업자)
	$.fn.dataTable.ext.errMode = 'none';
	let visionChargerTable = $('#visionChargerTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
    	language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX: true,

        fixedColumns: {
			leftColumns: 4
		},
       scrollY : "56vh",
       scrollCollapse: true,
        
		lengthChange: false,
//         pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/visionChargerTotalList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
				'productionFrom'	:		function() { return production1.replace(/-/g, ''); },
				'productionTo'		:		function() { return production2.replace(/-/g, ''); },
				//'workOrderGubun'    :       function() { return workOrderGubunVal;},
            },
        },
		//rowId: 'workOrdNo',
        columns: [
        	{data:'goodsNm'},			//제품명
        	{data:'userNm'},			//작업지시
        	{data:'userId'},				//주재료
        	{data:'faultyCntSum'},		//총 비전불량수량
        	{ data: 'faulty1',
        		render: function(data, type, row) {/*
            		if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty2',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty3',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty4',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty5',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty6',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty7',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty8',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty9',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty10',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty11',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty12',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty13',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty14',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty15',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty16',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty17',
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty18',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty19',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty20',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty21',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty22',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty23',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty24',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty25',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty26',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty27',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty28',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty29',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty30',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty31',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty32',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty33',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty34',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty35',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty36',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty37',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty38',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty39',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty40',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty41',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty42',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty43',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty44',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty45',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{ data: 'faulty46',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty47',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty48',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty49',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
						if (Number.isInteger(temp)){
							return temp  + ' %';
						} else {
							return temp.toFixed(2) + ' %';
						}
					}
        		}
        	},
        	{data:'faulty50',
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['faultyCntSum']) * 100;
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
                title: '생산검사현황-생산비전불량(작업자)',
            },
            {
				extend: 'excel',
				title: '생산검사현황-생산비전불량(작업자)',
				exportOptions: {
					columns: ':visible',
					format: {
						body: function(data, column, row, node) {
							if (showType == 'showType001') {
								if (row == 6) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 6) { return data.replace(" %", ""); }
								else if (row == 4) { return data.replace(" %", ""); }
								else if (row == 5) { return data.replace(" %", ""); }
								else if (row == 6) { return data.replace(" %", ""); }
								else if (row == 7) { return data.replace(" %", ""); }
								else if (row == 8) { return data.replace(" %", ""); }
								else if (row == 9) { return data.replace(" %", ""); }
								else if (row == 10) { return data.replace(" %", ""); }
								else if (row == 11) { return data.replace(" %", ""); }
								else if (row == 12) { return data.replace(" %", ""); }
								else if (row == 13) { return data.replace(" %", ""); }
								else if (row == 14) { return data.replace(" %", ""); }
								else if (row == 15) { return data.replace(" %", ""); }
								else if (row == 16) { return data.replace(" %", ""); }
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
								else { return data; }
							}
						}
				    }
				}
            },
            {
                extend: 'print',
                title: '생산비전불량(작업자)',
            },
        ],
		columnDefs: [
			{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53], className: 'text-right' },
		],
		order: [
            [ 1, 'asc' ]
        ],
		drawCallback: function () {
			$('#visionChargerTable tfoot').remove();
			$('#visionChargerTable').attr('style', 'margin-top: -1px !important;');

			/*$.each($('#visionChargerTable tbody tr'),function(index,item){
				if ($('#visionChargerTable .0').text()==""){            	
					$('#visionChargerTable .0').addClass('d-none');
					$(this).find('td').eq(4).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(2).addClass('d-none');
				}
				if ($('#visionChargerTable .1').text() == "") {
					$('#visionChargerTable .1').addClass('d-none');
					$(this).find('td').eq(5).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(3).addClass('d-none');
					
				}
				if ($('#visionChargerTable .2').text() == "") {
					$('#visionChargerTable .2').addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(4).addClass('d-none');
					
				}
				if ($('#visionChargerTable .3').text() == "") {
					$('#visionChargerTable .3').addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(5).addClass('d-none');
					
				}
				if ($('#visionChargerTable .4').text() == "") {
					$('#visionChargerTable .4').addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(6).addClass('d-none');
					
				}
				if ($('#visionChargerTable .5').text() == "") {
					$('#visionChargerTable .5').addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(7).addClass('d-none');
					
				}
				if ($('#visionChargerTable .6').text() == "") {
					$('#visionChargerTable .6').addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(8).addClass('d-none');
					
				}
				if ($('#visionChargerTable .7').text() == "") {
					$('#visionChargerTable .7').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(9).addClass('d-none');
					
				}
				if ($('#visionChargerTable .8').text() == "") {
					$('#visionChargerTable .8').addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(10).addClass('d-none');
					
				}
				if ($('#visionChargerTable .9').text() == "") {
					$('#visionChargerTable .9').addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(11).addClass('d-none');
					
				}
				if ($('#visionChargerTable .10').text() == "") {
					$('#visionChargerTable .10').addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(12).addClass('d-none');
					
				}
				if ($('#visionChargerTable .11').text() == "") {
					$('#visionChargerTable .11').addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(13).addClass('d-none');
					
				}
				if ($('#visionChargerTable .12').text() == "") {
					$('#visionChargerTable .12').addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(14).addClass('d-none');
					
				}
				if ($('#visionChargerTable .13').text() == "") {
					$('#visionChargerTable .13').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(15).addClass('d-none');
					
				}
				if ($('#visionChargerTable .14').text() == "") {
					$('#visionChargerTable .14').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(16).addClass('d-none');
					
				}
				if ($('#visionChargerTable .15').text() == "") {
					$('#visionChargerTable .15').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(17).addClass('d-none');
					
				}
				if ($('#visionChargerTable .16').text() == "") {
					$('#visionChargerTable .16').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(18).addClass('d-none');
					
				}
				if ($('#visionChargerTable .17').text() == "") {
					$('#visionChargerTable .17').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(19).addClass('d-none');
					
				}
				if ($('#visionChargerTable .18').text() == "") {
					$('#visionChargerTable .18').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(20).addClass('d-none');
					
				}
				if ($('#visionChargerTable .19').text() == "") {
					$('#visionChargerTable .19').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(21).addClass('d-none');
					
				}
				if ($('#visionChargerTable .20').text() == "") {
					$('#visionChargerTable .20').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(22).addClass('d-none');
					
				}
				if ($('#visionChargerTable .21').text() == "") {
					$('#visionChargerTable .21').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(23).addClass('d-none');
					
				}
				if ($('#visionChargerTable .22').text() == "") {
					$('#visionChargerTable .22').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(24).addClass('d-none');
					
				}
				if ($('#visionChargerTable .23').text() == "") {
					$('#visionChargerTable .23').addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(25).addClass('d-none');
					
				}
				if ($('#visionChargerTable .24').text() == "") {
					$('#visionChargerTable .24').addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(26).addClass('d-none');
					
				}
				if ($('#visionChargerTable .25').text() == "") {
					$('#visionChargerTable .25').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(27).addClass('d-none');
					
				}
				if ($('#visionChargerTable .26').text() == "") {
					$('#visionChargerTable .26').addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(28).addClass('d-none');
					
				}
				if ($('#visionChargerTable .27').text() == "") {
					$('#visionChargerTable .27').addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(29).addClass('d-none');
					
				}
				if ($('#visionChargerTable .28').text() == "") {
					$('#visionChargerTable .28').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(30).addClass('d-none');
					
				}
				if ($('#visionChargerTable .29').text() == "") {
					$('#visionChargerTable .29').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(31).addClass('d-none');
					
				}
				if ($('#visionChargerTable .30').text() == "") {
					$('#visionChargerTable .30').addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(32).addClass('d-none');
					
				}
				if ($('#visionChargerTable .31').text() == "") {
					$('#visionChargerTable .31').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(33).addClass('d-none');
					
				}
				if ($('#visionChargerTable .32').text() == "") {
					$('#visionChargerTable .32').addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(34).addClass('d-none');
					
				}
				if ($('#visionChargerTable .33').text() == "") {
					$('#visionChargerTable .33').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(35).addClass('d-none');
					
				}
				if ($('#visionChargerTable .34').text() == "") {
					$('#visionChargerTable .34').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(36).addClass('d-none');
					
				}
				if ($('#visionChargerTable .35').text() == "") {
					$('#visionChargerTable .35').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(37).addClass('d-none');
					
				}
				if ($('#visionChargerTable .36').text() == "") {
					$('#visionChargerTable .36').addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(38).addClass('d-none');
					
				}
				if ($('#visionChargerTable .37').text() == "") {
					$('#visionChargerTable .37').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(39).addClass('d-none');
					
				}
				if ($('#visionChargerTable .38').text() == "") {
					$('#visionChargerTable .38').addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(40).addClass('d-none');
					
				}
				if ($('#visionChargerTable .39').text() == "") {
					$('#visionChargerTable .39').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(41).addClass('d-none');
					
				}
				if ($('#visionChargerTable .40').text() == "") {
					$('#visionChargerTable .40').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(42).addClass('d-none');
					
				}
				if ($('#visionChargerTable .41').text() == "") {
					$('#visionChargerTable .41').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(43).addClass('d-none');
					
				}
				if ($('#visionChargerTable .42').text() == "") {
					$('#visionChargerTable .42').addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(44).addClass('d-none');
					
				}
				if ($('#visionChargerTable .43').text() == "") {
					$('#visionChargerTable .43').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(45).addClass('d-none');
					
				}
				if ($('#visionChargerTable .44').text() == "") {
					$('#visionChargerTable .44').addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(46).addClass('d-none');
					
				}
				if ($('#visionChargerTable .45').text() == "") {
					$('#visionChargerTable .45').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(47).addClass('d-none');
					
				}
				if ($('#visionChargerTable .46').text() == "") {
					$('#visionChargerTable .46').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(48).addClass('d-none');
					
				}
				if ($('#visionChargerTable .47').text() == "") {
					$('#visionChargerTable .47').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(49).addClass('d-none');
					
				}
				if ($('#visionChargerTable .48').text() == "") {
					$('#visionChargerTable .48').addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(50).addClass('d-none');
					
				}
				if ($('#visionChargerTable .49').text() == "") {
					$('#visionChargerTable .49').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$('#visionChargerTable tfoot tr').eq(0).find('td').eq(51).addClass('d-none');
					
				}
			});*/
			
			//전역변수들
			let sumVisionCharger			= $('#visionChargerTable').DataTable().column(3,{ page: 'all'} ).data().sum();
			$('#sumVisionCharger').html(addCommas(sumVisionCharger));

			$('#visionChargerTable_wrapper table').eq(5).find('tfoot tr td').eq(3).text(addCommas(sumVisionCharger));
			
			//지역변수들
			let visionChargerfaulty1	=	showTypeChange($('#visionChargerTable').DataTable().column(4,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty2	=	showTypeChange($('#visionChargerTable').DataTable().column(5,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty3	=	showTypeChange($('#visionChargerTable').DataTable().column(6,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty4	=	showTypeChange($('#visionChargerTable').DataTable().column(7,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty5	=	showTypeChange($('#visionChargerTable').DataTable().column(8,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty6	=	showTypeChange($('#visionChargerTable').DataTable().column(9,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty7	=	showTypeChange($('#visionChargerTable').DataTable().column(10,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty8	=	showTypeChange($('#visionChargerTable').DataTable().column(11,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty9	=	showTypeChange($('#visionChargerTable').DataTable().column(12,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty10	=	showTypeChange($('#visionChargerTable').DataTable().column(13,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty11	=	showTypeChange($('#visionChargerTable').DataTable().column(14,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty12	=	showTypeChange($('#visionChargerTable').DataTable().column(15,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty13	=	showTypeChange($('#visionChargerTable').DataTable().column(16,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty14	=	showTypeChange($('#visionChargerTable').DataTable().column(17,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty15	=	showTypeChange($('#visionChargerTable').DataTable().column(18,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty16	=	showTypeChange($('#visionChargerTable').DataTable().column(19,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty17	=	showTypeChange($('#visionChargerTable').DataTable().column(20,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty18	=	showTypeChange($('#visionChargerTable').DataTable().column(21,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty19	=	showTypeChange($('#visionChargerTable').DataTable().column(22,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty20	=	showTypeChange($('#visionChargerTable').DataTable().column(23,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty21	=	showTypeChange($('#visionChargerTable').DataTable().column(24,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty22	=	showTypeChange($('#visionChargerTable').DataTable().column(25,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty23	=	showTypeChange($('#visionChargerTable').DataTable().column(26,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty24	=	showTypeChange($('#visionChargerTable').DataTable().column(27,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty25	=	showTypeChange($('#visionChargerTable').DataTable().column(28,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty26	=	showTypeChange($('#visionChargerTable').DataTable().column(29,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty27	=	showTypeChange($('#visionChargerTable').DataTable().column(30,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty28	=	showTypeChange($('#visionChargerTable').DataTable().column(31,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty29	=	showTypeChange($('#visionChargerTable').DataTable().column(32,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty30	=	showTypeChange($('#visionChargerTable').DataTable().column(33,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty31	=	showTypeChange($('#visionChargerTable').DataTable().column(34,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty32	=	showTypeChange($('#visionChargerTable').DataTable().column(35,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty33	=	showTypeChange($('#visionChargerTable').DataTable().column(36,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty34	=	showTypeChange($('#visionChargerTable').DataTable().column(37,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty35	=	showTypeChange($('#visionChargerTable').DataTable().column(38,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty36	=	showTypeChange($('#visionChargerTable').DataTable().column(39,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty37	=	showTypeChange($('#visionChargerTable').DataTable().column(40,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty38	=	showTypeChange($('#visionChargerTable').DataTable().column(41,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty39	=	showTypeChange($('#visionChargerTable').DataTable().column(42,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty40	=	showTypeChange($('#visionChargerTable').DataTable().column(43,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty41	=	showTypeChange($('#visionChargerTable').DataTable().column(44,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty42	=	showTypeChange($('#visionChargerTable').DataTable().column(45,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty43	=	showTypeChange($('#visionChargerTable').DataTable().column(46,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty44	=	showTypeChange($('#visionChargerTable').DataTable().column(47,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty45	=	showTypeChange($('#visionChargerTable').DataTable().column(48,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty46	=	showTypeChange($('#visionChargerTable').DataTable().column(49,{ page: 'all'} ).data().sum(), sumVisionCharger);
			let visionChargerfaulty47	=	showTypeChange($('#visionChargerTable').DataTable().column(50,{ page: 'all'} ).data().sum(), sumVisionCharger);
            let visionChargerfaulty48   =   showTypeChange($('#visionChargerTable').DataTable().column(51,{ page: 'all'} ).data().sum(), sumVisionCharger);
            let visionChargerfaulty49   =   showTypeChange($('#visionChargerTable').DataTable().column(52,{ page: 'all'} ).data().sum(), sumVisionCharger);
            let visionChargerfaulty50   =   showTypeChange($('#visionChargerTable').DataTable().column(53,{ page: 'all'} ).data().sum(), sumVisionCharger);

			$('#visionChargerfaulty1').html(addCommas(visionChargerfaulty1));
			$('#visionChargerfaulty2').html(addCommas(visionChargerfaulty2));
			$('#visionChargerfaulty3').html(addCommas(visionChargerfaulty3));
			$('#visionChargerfaulty4').html(addCommas(visionChargerfaulty4));
			$('#visionChargerfaulty5').html(addCommas(visionChargerfaulty5));
			$('#visionChargerfaulty6').html(addCommas(visionChargerfaulty6));
			$('#visionChargerfaulty7').html(addCommas(visionChargerfaulty7));
			$('#visionChargerfaulty8').html(addCommas(visionChargerfaulty8));
			$('#visionChargerfaulty9').html(addCommas(visionChargerfaulty9));
			$('#visionChargerfaulty10').html(addCommas(visionChargerfaulty10));
			$('#visionChargerfaulty11').html(addCommas(visionChargerfaulty11));
			$('#visionChargerfaulty12').html(addCommas(visionChargerfaulty12));
			$('#visionChargerfaulty13').html(addCommas(visionChargerfaulty13));
			$('#visionChargerfaulty14').html(addCommas(visionChargerfaulty14));
			$('#visionChargerfaulty15').html(addCommas(visionChargerfaulty15));
			$('#visionChargerfaulty16').html(addCommas(visionChargerfaulty16));
			$('#visionChargerfaulty17').html(addCommas(visionChargerfaulty17));
			$('#visionChargerfaulty18').html(addCommas(visionChargerfaulty18));
			$('#visionChargerfaulty19').html(addCommas(visionChargerfaulty19));
			$('#visionChargerfaulty20').html(addCommas(visionChargerfaulty20));
			$('#visionChargerfaulty21').html(addCommas(visionChargerfaulty21));
			$('#visionChargerfaulty22').html(addCommas(visionChargerfaulty22));
			$('#visionChargerfaulty23').html(addCommas(visionChargerfaulty23));
			$('#visionChargerfaulty24').html(addCommas(visionChargerfaulty24));
			$('#visionChargerfaulty25').html(addCommas(visionChargerfaulty25));
			$('#visionChargerfaulty26').html(addCommas(visionChargerfaulty26));
			$('#visionChargerfaulty27').html(addCommas(visionChargerfaulty27));
			$('#visionChargerfaulty28').html(addCommas(visionChargerfaulty28));
			$('#visionChargerfaulty29').html(addCommas(visionChargerfaulty29));
			$('#visionChargerfaulty30').html(addCommas(visionChargerfaulty30));
			$('#visionChargerfaulty31').html(addCommas(visionChargerfaulty31));
			$('#visionChargerfaulty32').html(addCommas(visionChargerfaulty32));
			$('#visionChargerfaulty33').html(addCommas(visionChargerfaulty33));
			$('#visionChargerfaulty34').html(addCommas(visionChargerfaulty34));
			$('#visionChargerfaulty35').html(addCommas(visionChargerfaulty35));
			$('#visionChargerfaulty36').html(addCommas(visionChargerfaulty36));
			$('#visionChargerfaulty37').html(addCommas(visionChargerfaulty37));
			$('#visionChargerfaulty38').html(addCommas(visionChargerfaulty38));
			$('#visionChargerfaulty39').html(addCommas(visionChargerfaulty39));
			$('#visionChargerfaulty40').html(addCommas(visionChargerfaulty40));
			$('#visionChargerfaulty41').html(addCommas(visionChargerfaulty41));
			$('#visionChargerfaulty42').html(addCommas(visionChargerfaulty42));
			$('#visionChargerfaulty43').html(addCommas(visionChargerfaulty43));
			$('#visionChargerfaulty44').html(addCommas(visionChargerfaulty44));
			$('#visionChargerfaulty45').html(addCommas(visionChargerfaulty45));
			$('#visionChargerfaulty46').html(addCommas(visionChargerfaulty46));
			$('#visionChargerfaulty47').html(addCommas(visionChargerfaulty47));
			$('#visionChargerfaulty48').html(addCommas(visionChargerfaulty48));
			$('#visionChargerfaulty49').html(addCommas(visionChargerfaulty49));
			$('#visionChargerfaulty50').html(addCommas(visionChargerfaulty50));
        },
    });

	//작업자별 검색
	$('#visionChargerTable_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#visionChargerTable_filter').find('label').eq(0).addClass('row ml-3');
	$('#visionChargerTable_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#visionChargerTable_filter").insertAfter("#showType");
	$('#visionChargerTable_filter').addClass('d-none');

	//생산비전불량(작업자)
	columnVisibleFun('visionChargerTable', visionFaultyCode.length, visionChargerTable);

  	//---------------------------------------------------------------------작업지시 별 -----------------------------------------------------//

	//작지번호별 목록
	$.fn.dataTable.ext.errMode = 'none';
	let workOrderReInspTable = $('#workOrderReInspTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: false,
        processing: true,
        autoWidth: false,
//         scrollY : "56vh",
        lengthChange: false,

        scrollX: true,
        fixedColumns: {
        	 leftColumns: 4
        },
        
		scrollCollapse: true,
        pageLength: 16,
        ajax: {
            url: '<c:url value="/qm/faultyWorkOrdNoReInspListFa"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },				
				'workOrderGubun'    :       function() { return workOrderGubunVal;},
				'qutyCd'    		:       function() { return qutyCd;},
            },
        },
		//rowId: 'workOrdNo',
        columns: [
        	{
				render: function(data, type, row) {
					if(row['trayNo'] == '소계'){
						return '소계';
					} else {
						return moment(row['workOrdDate']).format('YYYY-MM-DD');
					}
					
				}
			},//작업지시일
			{data:'workOrdNo'},//작지번호
        	{data:'trayNo',
        		render: function(data, type, row) {
					if(data == '소계'){
						return '';
					} else {
						return data;
					}
					
				}
			},//트레이번호
        	{data:'seq'},//차수        	
        	{data:'gubun',//생산비전불량수량
        		render: function(data, type, row) {
            		let temp;            		
					if(data == 'D'){
						temp = '주간';
                	} else if(data == 'N') {
                		temp = '야간';
                    } else{
						temp = '';
                       }

					return temp;		
        		}
    		},//주야        	
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
        	{data: 'ordDate',
        		render: function(data, type, row) {
        			if(row['trayNo'] == '소계'){
						return '';
					} else {
						return moment(row['ordDate']).format('YYYY-MM-DD');
					}

        		}
			},//생산일

			{data:'mainWorkChargrNm'		}, //생산 작업자

			{data:'appearInspctDate',
				render: function(data, type, row) {
					if(data == null || data==''){
						return '-';
					} else {
						return moment(data).format('YYYY-MM-DD');
					}
        		}
			}, //외관검사일
			
        	{data:'edgeInspctChargerNm'		}, //엣지 검사자
        	{data:'appearInspctChargerNm'	}, //외관 검사자
			
        	{data:'equipNm'},//설비명
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
        		render: function(data, type, row) {/*
            		if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if(data == 'null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {						
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/*
        			if( data =='null'){
                		data = 0;
                	}*/
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
        		render: function(data, type, row) {/* 
        			if( data =='null'){
                		data = 0;
                	} */
					if (showType == 'showType001') {
						return data;
					} else if (showType == 'showType002') {
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
                title: '생산검사현황-작업지시별(재검포함)',
            },
            {
				extend: 'excel',
				title: '생산검사현황-작업지시별(재검포함)',
				exportOptions: {
					columns: ':visible',
					format: {
						body: function(data, column, row, node) {
							if (row == 10 || row == 11) {
								data = data.replace('<p style="color:red; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('<p style="color:blue; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('</p>', '');
								return data;
							}
							if (showType == 'showType001') {
								if (row == 9) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 9) { return data.replace(" %", ""); }
// 								else if (row == 17) { return data.replace(" %", ""); }
// 								else if (row == 18) { return data.replace(" %", ""); }
// 								else if (row == 19) { return data.replace(" %", ""); }
//								else if (row == 20) { return data.replace(" %", ""); }
//								else if (row == 21) { return data.replace(" %", ""); }
//								else if (row == 22) { return data.replace(" %", ""); }
//								else if (row == 23) { return data.replace(" %", ""); }
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
								else if (row == 157) { return data.replace(" %", ""); }
								else if (row == 158) { return data.replace(" %", ""); }
								else if (row == 159) { return data.replace(" %", ""); }
								else if (row == 160) { return data.replace(" %", ""); }
								else if (row == 161) { return data.replace(" %", ""); }
								else if (row == 162) { return data.replace(" %", ""); }
			

								else { return data; }
							}
						}
				    }
				}
            },
            {
                extend: 'print',
                title: '생산검사현황-작업지시별',
            },
        ],
		columnDefs: [
			{ targets: [5,6,7,8,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,
				138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158], render: $.fn.dataTable.render.number( ',' ) },

// 			{ targets: [1,2,3,4,5,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
// 				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], className: 'text-right' },
			{ targets: [0,1,2,3,4,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24], className: 'text-center' },
        	{ targets: "_all", className: 'text-right' },
        	//{ targets: [0,1,2,3,4,5,6,7,8], "width": "90%" }
		],
		drawCallback: function () {
			$('#workOrderReInspTable tfoot').remove();
			$('#workOrderReInspTable').attr('style', 'margin-top: -1px !important;');


			//전역변수들
 			let workOrderReInspSumOutputCnt		= $('#workOrderReInspTable').DataTable().column(5,{ page: 'all'} ).data().sum()/2;
			let workOrderReInspSumAppearOutputCnt	= $('#workOrderReInspTable').DataTable().column(6,{ page: 'all'} ).data().sum()/2;
			let workOrderReInspSumFaulty			= $('#workOrderReInspTable').DataTable().column(7,{ page: 'all'} ).data().sum()/2;
			let workOrderReInspSumVisionFaulty	= $('#workOrderReInspTable').DataTable().column(8,{ page: 'all'} ).data().sum()/2;
			let workOrderReInspSumFaultyPercent	= 100 * workOrderReInspSumFaulty / workOrderReInspSumOutputCnt;

			$('#workOrderReInspSumOutputCnt').html(addCommas(workOrderReInspSumOutputCnt));
			$('#workOrderReInspSumAppearOutputCnt').html(addCommas(workOrderReInspSumAppearOutputCnt));
			$('#workOrderReInspSumFaulty').html(addCommas(workOrderReInspSumFaulty));
            $('#workOrderReInspSumVisionFaulty').html(addCommas(workOrderReInspSumVisionFaulty));
			$('#workOrderReInspSumFaultyPercent').html(workOrderReInspSumFaultyPercent.toFixed(2) + "%");

			//컬럼 추가 시 for문 도 수정
			let workOrderReInspFaultyArray = new Array();
			
            for(var i=0; i<140; i++){
            	workOrderReInspFaultyArray[i] = showTypeChange(($('#workOrderReInspTable').DataTable().column( (25+i) ,{ page: 'all'} ).data().sum()/2), workOrderReInspSumOutputCnt);	//컬럼 추가될떄 column값도 늘려주기
            } 

			for(var i=0; i<140; i++){
				$('#workOrderReInspFaulty'+ (i+1) ).html(addCommas(workOrderReInspFaultyArray[i]));
			}

			$('#workOrderReInspTable_wrapper thead th').css('vertical-align','middle');

			var api = this.api();
	         for(var i=0;i<api.data().count();i++) {
	             if(api.row(i).data().trayNo=='소계') {
	                let node = api.row(i).node();

	                $(node).css('background-color','rgb(174, 211, 236)');
	                $(node).css('color','blue');
	             }
	         }
	   
	       
        },
    });

	//작업지시별
	columnVisibleFun('workOrderReInspTable', systemCommonCode.length, workOrderReInspTable);	
	

	workOrderReInspTable.on('draw.dt', function(){
		$("td[name=tdRe2]").remove();
		$("td[name=tdRe3]").remove();
		$("td[name=tdRe4]").remove();
		$("td[name=tdRe1]").attr('colspan', '4');
	});


	//작지번호별 검색
	$('#workOrderReInspTable_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#workOrderReInspTable_filter').find('label').eq(0).addClass('row ml-3');
	$('#workOrderReInspTable_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#workOrderReInspTable_filter").insertAfter("#showType");

	$("#workOrderReInspTable_filter").addClass('d-none');

	
	//조회
  	$('#btnRetv').on('click', function() {
  		$('#my-spinner').show();
  		let dateFrom = '';
		let dateTo = '';
		if ( $('#showDate').val() == 'showDate001' ) {
			dateFrom = new Date($('#chooseDateFrom').val());
			dateTo = new Date($('#chooseDateTo').val());
		} else {
			dateFrom = new Date($('#productionFrom').val());
			dateTo = new Date($('#productionTo').val());
		}
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
		
  		userNumber	= $('#preWorkCharger').val();
  		showType = $("#showType option:selected").val();
  		
  		if( $('#showDate').val() == 'showDate001' ) {
  			chooseDate1 = $('#chooseDateFrom').val();
  	  		chooseDate2 = $('#chooseDateTo').val();
  	  		production1 = '';
			production2 = '';
			
			if( tabView == "tabView1" ){
  	  			tabDate[0] = $('#chooseDateFrom').val() + "|" + $('#chooseDateTo').val() + "|" + $('#showDate').val();
  	  			$('#faultyStatsDay').DataTable().ajax.reload();
  	  	  	} else if( tabView == "tabView2" ){
  	  			tabDate[1] = $('#chooseDateFrom').val() + "|" + $('#chooseDateTo').val() + "|" + $('#showDate').val();
  	  			$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
  	  	  	} else if( tabView == "tabView3" ){
  	  			tabDate[2] = $('#chooseDateFrom').val() + "|" + $('#chooseDateTo').val() + "|" + $('#showDate').val();
  	  			$('#workOrderTable').DataTable().ajax.reload();
  	  	  	} else if( tabView == "tabView4" ){
  	  			tabDate[3] = $('#chooseDateFrom').val() + "|" + $('#chooseDateTo').val() + "|" + $('#showDate').val();
  	  			$('#visionWorkOrdTable').DataTable().ajax.reload();
  	  	  	} else if( tabView == "tabView5" ){
  	  			tabDate[4] = $('#chooseDateFrom').val() + "|" + $('#chooseDateTo').val() + "|" + $('#showDate').val();
  	  			$('#visionChargerTable').DataTable().ajax.reload();
  	  	  	} else if( tabView == "tabView6" ){
  	  			tabDate[5] = $('#chooseDateFrom').val() + "|" + $('#chooseDateTo').val() + "|" + $('#showDate').val();
  	  			$('#comprehensiveQtyTable').DataTable().ajax.reload();
  	  	  	} else if( tabView == "tabView7" ){
  	  			tabDate[6] = $('#chooseDateFrom').val() + "|" + $('#chooseDateTo').val() + "|" + $('#showDate').val();
  	  			$('#workOrderReInspTable').DataTable().ajax.reload();
  	  	  	} else {
  	  	  		toastr.warning("탭 정보가 질못되었습니다.");
  			}
		} else {
			chooseDate1 = '';
			chooseDate2 = '';
			production1 = $('#productionFrom').val();
			production2 = $('#productionTo').val();
			
			if( tabView == "tabView1" ){
	  			tabDate[0] = $('#productionFrom').val() + "|" + $('#productionTo').val() + "|" + $('#showDate').val();
	  			$('#faultyStatsDay').DataTable().ajax.reload();
	  	  	} else if( tabView == "tabView2" ){
	  			tabDate[1] = $('#productionFrom').val() + "|" + $('#productionTo').val() + "|" + $('#showDate').val();
	  			$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
	  	  	} else if( tabView == "tabView3" ){
	  			tabDate[2] = $('#productionFrom').val() + "|" + $('#productionTo').val() + "|" + $('#showDate').val();
	  			$('#workOrderTable').DataTable().ajax.reload();
	  	  	} else if( tabView == "tabView4" ){
	  			tabDate[3] = $('#productionFrom').val() + "|" + $('#productionTo').val() + "|" + $('#showDate').val();
	  			$('#visionWorkOrdTable').DataTable().ajax.reload();
	  	  	} else if( tabView == "tabView5" ){
	  			tabDate[4] = $('#productionFrom').val() + "|" + $('#productionTo').val() + "|" + $('#showDate').val();
	  			$('#visionChargerTable').DataTable().ajax.reload();
	  	  	} else if( tabView == "tabView6" ){
	  			tabDate[5] = $('#productionFrom').val() + "|" + $('#productionTo').val() + "|" + $('#showDate').val();
	  			$('#comprehensiveQtyTable').DataTable().ajax.reload();
	  	  	} else if( tabView == "tabView7" ){
	  			tabDate[6] = $('#productionFrom').val() + "|" + $('#productionTo').val() + "|" + $('#showDate').val();
	  			$('#workOrderReInspTable').DataTable().ajax.reload();
	  	  	} else {
	  	  		toastr.warning("탭 정보가 질못되었습니다.");
			}
		}
  		
  		
  		$('#my-spinner').hide();
	});

	//재질검색
	$('#selectQutyCd').on('change', function(){
		qutyCd = $('#selectQutyCd option:selected').val();

		if (tabView == 'tabView3') {
  			$('#workOrderTable').DataTable().ajax.reload();
  	  	} else if (tabView == 'tabView1') {
  	  		$('#faultyStatsDay').DataTable().ajax.reload();
		} else if (tabView == 'tabView2') {
  		  	$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
		} else if (tabView == 'tabView4') {
//   		  	$('#visionWorkOrdTable').DataTable().ajax.reload();
		} else if (tabView == 'tabView5') {
//   		  	$('#visionChargerTable').DataTable().ajax.reload();
		} else if (tabView == 'tabView6') {
  		  	$('#comprehensiveQtyTable').DataTable().ajax.reload();
		} else if (tabView == 'tabView7') {
  		  	$('#workOrderReInspTable').DataTable().ajax.reload();
		} else {
  	  		toastr.warning("탭 정보가 질못되었습니다.");
		}
	});
	
    // 형식 변경시 테이블 리로드   
  	$('#showType').change(function() {
  		showType = $("#showType option:selected").val();
  		if (tabView == 'tabView3') {
  			$('#workOrderTable').DataTable().ajax.reload();
  	  	} else if (tabView == 'tabView1') {
  	  		$('#faultyStatsDay').DataTable().ajax.reload();
		} else if (tabView == 'tabView2') {
  		  	$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
		} else if (tabView == 'tabView4') {
	  		$('#visionWorkOrdTable').DataTable().ajax.reload();
		} else if (tabView == 'tabView5') {
	  		$('#visionChargerTable').DataTable().ajax.reload();
  	  	} else if (tabView == 'tabView6') {
  		  	$('#comprehensiveQtyTable').DataTable().ajax.reload();
		} else if (tabView == 'tabView7') {
  		  	$('#workOrderReInspTable').DataTable().ajax.reload();
		}else {
  	  		toastr.warning("탭 정보가 질못되었습니다.");
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
    		//3공장 안씀
    		if( factoryCode == "001" || factoryCode == "002" ) {
	    		if(item.etc1 == '004'){
	    			vision += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
	    			visionIdx++;  
	        	}
	    		if(item.etc1 == '005'){
	    			five += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
	    			fiveIdx++;  
	        	}
    		}
    		//if(item.etc1 == '006'){
    		//	six += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    		//	sixIdx++;  
        	//}
		});

    	var sudel = '';
    	
    	//1, 2공장은 22개 안씀.
    	//3공장은: 95개 안씀.
    	
    	//1, 2공장 기준
    	//외관 촐 길이는 157개임
    	//157 - (118 + 17) = 22
    	
    	//3공장 기준
    	//외관 촐 길이는 157개임
    	//157 - (44 + 17) = 96
    	
    	let starCount = 0;
    	/* if( factoryCode == "001" || factoryCode == "002" ) {
    		starCount = 22;
    	} else {
    		starCount = 96;
    	} */
    	
    	starCount = 157 - (systemCommonCode.length + 17);

    	for(var i=0; i<starCount; i++){
    		sudel += '<th>★</th>';
		}
		
    	metal = metal + film +vision + five + six;
        $('#metalHd').attr('colspan', metalIdx);   
        $('#filmHd').attr('colspan', filmIdx);
        
      	//3공장 안씀
        if( factoryCode == "001" || factoryCode == "002" ) {
	        $('#visonHd').attr('colspan', visionIdx);   
	        $('#fiveHd').attr('colspan', fiveIdx);
        } else {
        	$('#visonHd').remove();
        	$('#fiveHd').remove();
        }
        //$('#sixHd').attr('colspan', sixIdx);
        
		$('#appearHeader').html(metal);
		$('#appearHeader').append(sudel);
		
		//3공장 안씀
		if( factoryCode == "001" || factoryCode == "002" ) {
			$('#fiveHd').after(sudel);
		} else {
			$('#filmHd').after(sudel);
		}
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
    	
    	let starCount = 0;
    	starCount = 97 - (edgeGoodsFaultyCode.length + 17);

    	var sudel2 = '';
    	for(var i=0; i<starCount; i++){
        	sudel2 += '<th>★</th>';
    	}
    	
    	metal += film;
        $('#edgeHd').attr('colspan', metalIdx);   
        $('#edgeHd2').attr('colspan', filmIdx);        
		$('#edgeAppearHeader').html(metal);
		
		$('#edgeAppearHeader').append(sudel2);
		$('#edgeHd2').after(sudel2);
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
    		
    		//3공장 안씀
    		if( factoryCode == "001" || factoryCode == "002" ) {
	    		if(item.etc1 == '004'){
	    			vision += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
	    			visionIdx++;  
	        	}
	    		if(item.etc1 == '005'){
	    			five += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
	    			fiveIdx++;  
	        	}
    		}
    		//if(item.etc1 == '006'){
    		//	six += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    		//	sixIdx++;  
        	//}
		});

    	var sudel = '';

    	//161 - ( systemCommonCode.length+21) = 21;
    	//전체길이 - (공통코드로 들어간 값 + 앞  공통코드 적용 안된 앞 th 값) = 나머지 별 표시 해줘야 하는 부분
    	//1, 2공장은 22개 안씀.
    	//3공장은: 96개 안씀.
    	
    	//1, 2공장 기준
    	//작지 촐 길이는 162개임
    	//162 - (118 + 22) = 22
    	
    	//3공장 기준
    	//작지 촐 길이는 162개임
    	//162 - (44 + 22) = 96
    	
    	let starCount = 0;
    	/* if( factoryCode == "001" || factoryCode == "002" ) {
    		starCount = 22;
    	} else {
    		starCount = 96;
    	} */
    	
    	starCount = 162 - (systemCommonCode.length + 22);

    	for(var i=0; i<starCount; i++){
    		sudel += '<th>★</th>';
		}
		
    	metal = metal + film +vision + five + six;
        $('#workOrderMetalHd').attr('colspan', metalIdx);   
        $('#workOrderFilmHd').attr('colspan', filmIdx);    

      	//3공장 안씀
        if( factoryCode == "001" || factoryCode == "002" ) {
        	$('#workOrderVisonHd').attr('colspan', visionIdx);   
        	$('#workOrderFiveHd').attr('colspan', fiveIdx);
        } else {
        	$('#workOrderVisonHd').remove();
        	$('#workOrderFiveHd').remove();
        }
        //$('#sixHd').attr('colspan', sixIdx);
        
		$('#workOrderHeader').html(metal);
		$('#workOrderHeader').append(sudel);
		
		//3공장 안씀
		if( factoryCode == "001" || factoryCode == "002" ) {
			$('#workOrderFiveHd').after(sudel);
		} else {
			$('#workOrderFilmHd').after(sudel);
		}
	}
	
	
	
	

	//생산비전불량(작업지시)
	function visionWorkOrdHeaderCreate() {
		let uppearHtml = null;
    	var up = '';
    	var down = '';
    	var upIdx = '';
		var downIdx = 0;
		
    	$.each(visionFaultyCode, function(index,item){				
    		if(item.etc1 == '001'){
    			up += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			upIdx++;  
        	}
    		if(item.etc1 == '002'){
    			down += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			downIdx++;  
        	}
		});
    	uppearHtml = up + down;
        $('#visionWorkOrdUp').attr('colspan', upIdx);   
        //$('#visionWorkOrdDown').attr('colspan', downIdx);

        var sudel = '';
    	for(var i=0; i<32; i++){
        	sudel += '<th>★</th>';
    	}        
        
		$('#visionWorkOrdHeader').html(uppearHtml);

		$('#visionWorkOrdHeader').append(sudel);
		//$('#visionWorkOrdDown').after(sudel);

	}

	//생산비전불량(작업자)
	function visionChargerHeaderCreate() {
		let uppearHtml = null;
    	var up = '';
    	var down = '';
    	var upIdx = '';
		var downIdx = 0;
		
    	$.each(visionFaultyCode, function(index,item){				
    		if(item.etc1 == '001'){
    			up += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			upIdx++;  
        	}
    		if(item.etc1 == '002'){
    			down += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			downIdx++;  
        	}
		});

    	var sudel = '';
    	for(var i=0; i<32; i++){
        	sudel += '<th>★</th>';
    	}  
		
    	uppearHtml = up + down;
        $('#visionChargerUp').attr('colspan', upIdx);   
        //$('#visionChargerDown').attr('colspan', downIdx);        
        
		$('#visionChargerHeader').html(uppearHtml);

		$('#visionChargerHeader').append(sudel);
		//$('#visionChargerDown').after(sudel);
	}


	//종합 수량
	function comprehensiveQtyAppearHeaderCreate() {
    	var metal		= '';
    	var film		= '';
    	var vision		= '';
    	var five		= '';
    	var six			= '';
    	
		var metalIdx	= 0;
		var filmIdx		= 0;
		var visionIdx	= 0;
		var fiveIdx		= 0;
		var sixIdx		= 0;

		/* //이름 중복 제거
		var DeduplicationCode = systemCommonCode.filter(function(item1, idx1){
		    return systemCommonCode.findIndex(function(item2, idx2){
		        return item1.baseCdNm == item2.baseCdNm
		    }) == idx1;
		}); */

		var code = new Array();
		for(var i=0; i<systemCommonCode.length; i++) {
		     if( systemCommonCode[i].etc1 == '001' || systemCommonCode[i].etc1 == '004' ) {
		         code.push(systemCommonCode[i]);
		     }
		}

		var code2 = new Array();
		for(var i=0; i<systemCommonCode.length; i++) {
		     if( systemCommonCode[i].etc1 == '002' || systemCommonCode[i].etc1 == '005' ) {
		         code2.push(systemCommonCode[i]);
		     }
		}

		//이름 중복 제거
		var DeduplicationCode = code.filter(function(item1, idx1){
		    return code.findIndex(function(item2, idx2){
		        return item1.baseCdNm == item2.baseCdNm
		    }) == idx1;
		});

		//이름 중복 제거
		var DeduplicationCode2 = code2.filter(function(item1, idx1){
		    return code2.findIndex(function(item2, idx2){
		        return item1.baseCdNm == item2.baseCdNm
		    }) == idx1;
		});


		var endArray = new Array();
		for(var i=0; i<DeduplicationCode.length; i++) {
			endArray.push(DeduplicationCode[i]);
		}

		for(var i=0; i<DeduplicationCode2.length; i++) {
			endArray.push(DeduplicationCode2[i]);
		}

		endArrayCount = endArray.length;
		
    	$.each(endArray, function(index,item){				
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
        	}
    		//3공장 안씀
    		if( factoryCode == "001" || factoryCode == "002" ) {
	    		if(item.etc1 == '004'){
	    			vision += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
	    			visionIdx++;  
	        	}
	    		if(item.etc1 == '005'){
	    			five += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
	    			fiveIdx++;  
	        	}
    		}
		});
		
    	metal = metal + film +vision + five + six;

    	var html = '';
    	if( metalIdx != 0 ){
    		html += '<th colspan="'+metalIdx+'" style="min-width: 70px;" class="text-center" class="text-center" >메탈부 불량</th>';
        }
        if( filmIdx !=0 ){
        	html += '<th colspan="'+filmIdx+'" style="min-width: 70px;" class="text-center" class="text-center" >필름부 불량</th>';
		}
        
      	//3공장 안씀
		if( factoryCode == "001" || factoryCode == "002" ) {
			if( visionIdx != 0 ){
				html += '<th colspan="'+visionIdx+'" style="min-width: 70px;" class="text-center" class="text-center" >메탈부 불량</th>';
			}
			if( fiveIdx != 0 ){
				html += '<th colspan="'+fiveIdx+'" style="min-width: 70px;" class="text-center" class="text-center" >필름부 불량</th>';
			}
		}
      	
		var sudel = '';
    	for(var i=0; i<81; i++){
        	sudel += '<th>★</th>';
    	}
		
    	$('#behindSeatAdd').after(html);
		$('#comprehensiveQtyHeader').html(metal);

		$('#comprehensiveQtyHeader').append(sudel);
// 		setTimeout(function() {
			var countNum = $('#comprehensiveQtyTable_wrapper table').eq(0).find('thead tr').eq(0).find('th').length - 1;
			$('#comprehensiveQtyTable_wrapper table').eq(0).find('thead tr').eq(0).find('th').eq( countNum ).after(sudel);
// 		}, 100);
// 		$('#behindSeatAdd').after(sudel);
	}
	
	//작지재검
	function workOrderReInspHeaderCreate() {
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
    		
    		//3공장 안씀
    		if( factoryCode == "001" || factoryCode == "002" ) {
	    		if(item.etc1 == '004'){
	    			vision += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
	    			visionIdx++;  
	        	}
	    		if(item.etc1 == '005'){
	    			five += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
	    			fiveIdx++;  
	        	}
    		}
    		//if(item.etc1 == '006'){
    		//	six += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    		//	sixIdx++;  
        	//}
		});

    	var sudel = '';

    	//161 - ( systemCommonCode.length+21) = 21;
    	//전체길이 - (공통코드로 들어간 값 + 앞  공통코드 적용 안된 앞 th 값) = 나머지 별 표시 해줘야 하는 부분
    	//1, 2공장은 22개 안씀.
    	//3공장은: 96개 안씀.
    	
    	//1, 2공장 기준
    	//작지 촐 길이는 162개임
    	//162 - (118 + 22) = 22
    	
    	//3공장 기준
    	//작지 촐 길이는 162개임
    	//162 - (44 + 22) = 96
    	
    	let starCount = 0;
    	/* if( factoryCode == "001" || factoryCode == "002" ) {
    		starCount = 22;
    	} else {
    		starCount = 96;
    	} */
    	
    	starCount = 162 - (systemCommonCode.length + 22);

    	for(var i=0; i<starCount; i++){
    		sudel += '<th>★</th>';
		}
		
    	metal = metal + film +vision + five + six;
        $('#workOrderReInspMetalHd').attr('colspan', metalIdx);   
        $('#workOrderReInspFilmHd').attr('colspan', filmIdx);    

      	//3공장 안씀
        if( factoryCode == "001" || factoryCode == "002" ) {
        	$('#workOrderReInspVisonHd').attr('colspan', visionIdx);   
        	$('#workOrderReInspFiveHd').attr('colspan', fiveIdx);
        } else {
        	$('#workOrderReInspVisonHd').remove();
        	$('#workOrderReInspFiveHd').remove();
        }
        //$('#sixHd').attr('colspan', sixIdx);
        
		$('#workOrderReInspHeader').html(metal);
		$('#workOrderReInspHeader').append(sudel);
		
		//3공장 안씀
		if( factoryCode == "001" || factoryCode == "002" ) {
			$('#workOrderReInspFiveHd').after(sudel);
		} else {
			$('#workOrderReInspFilmHd').after(sudel);
		}
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
		        	url: '<c:url value="/qm/finalInspectionWorkerList"/>',
// 		            url: '<c:url value="/sm/matrlUserDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            	'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
						'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
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
		$('#workOrderReInspTable').DataTable().ajax.reload( function () {});
	});

  	$('#comprehensiveGubun').click(function() {
		if ($(this).prop('checked')) {
			workOrderGubunVal = 'check';
			
		} else {
			workOrderGubunVal = '';
		}
	  	$('#comprehensiveQtyTable').DataTable().ajax.reload();
	});


	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
  	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ종합수량ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
  	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
  	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	let exceptFaultyQty				= null;
	let comprehensiveQtyUserNumber	= null;
	let comprehensiveQtyGubunVal 	= 'check';

	$('#exceptFaultyQty').on('change', function(){
		if( $('#exceptFaultyQty option:selected').val() == '' || $('#exceptFaultyQty option:selected').val() == null){
			exceptFaultyQty = null;
		} else {
			exceptFaultyQty = $('#exceptFaultyQty option:selected').text().replaceAll('%', '').trim();
		}
		$('#comprehensiveQtyTable').DataTable().ajax.reload();
	});
	
	//작지번호별 목록
	$.fn.dataTable.ext.errMode = 'none';
	let comprehensiveQtyTable = $('#comprehensiveQtyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        scrollX: true,
        scrollX: true,
        fixedColumns: {
        	 leftColumns: 6
        },
//      scrollY : "56vh",
		scrollCollapse: true,
		async: false,
        lengthChange: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/comprehensiveQtyList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		: 		menuAuth,
				'userNumber'		:		function() { return userNumber;},
				'chooseDateFrom'	:		function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:		function() { return chooseDate2.replace(/-/g, ''); },
				'productionFrom'	:		function() { return production1.replace(/-/g, ''); },
				'productionTo'		:		function() { return production2.replace(/-/g, ''); },
				'workOrderGubun'    :       function() { return workOrderGubunVal;},
				'exceptFaultyQty'	:		function() { return exceptFaultyQty; },
				'qutyCd'    		:       function() { return qutyCd;},
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
                		temp = "-";
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
        	{data:'mainWorkChargrNm'		}, //생산 작업자
        	{data:'edgeInspctChargerNm'		}, //엣지 검사자
        	{data:'appearInspctChargerNm'	}, //외관 검사자
        	
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
                title: '생산검사현황-종합수량',
            },
            {
				extend: 'excel',
				title: '생산검사현황-종합수량',
				exportOptions: {
					columns: ':visible',
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
// 								else if (row == 17) { return data.replace(" %", ""); }
// 								else if (row == 18) { return data.replace(" %", ""); }
// 								else if (row == 19) { return data.replace(" %", ""); }
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
								else if (row == 157) { return data.replace(" %", ""); }
								else if (row == 158) { return data.replace(" %", ""); }
								else if (row == 159) { return data.replace(" %", ""); }
								else { return data; }
							}
						}
				    }
				}
            },
            {
                extend: 'print',
                title: '생산검사현황-종합수량',
            },
        ],
		columnDefs: [
			{ targets: [1,2,3,4,5,14,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], render: $.fn.dataTable.render.number( ',' ) },
// 			{ targets: [1,2,3,4,5,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85
// 				,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], className: 'text-right' },

// 				{ targets: [288,292,296,300,304,308,312,316,320,324,328,332,336,340,344,348,352,356,360,364], className: 'text-left' },
	        	{ targets: [0,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20], className: 'text-center' },
	        	{ targets: "_all", className: 'text-right' }
	        	
		],
		drawCallback: function () {
			$('#comprehensiveQtyTable tfoot').remove();
			$('#comprehensiveQtyTable').attr('style', 'margin-top: -1px !important;');
			$('#comprehensiveQtyTable_wrapper table').eq(0).attr('style', 'margin-top: -1px !important;');
			$('#comprehensiveQtyTable_wrapper div').find('.dataTables_scrollHeadInner').attr('style', 'box-sizing: content-box;padding-right: 10px;');

			//컬럼 추가될떄 for문 값 늘려주기
			/* $.each($('#comprehensiveQtyTable tbody tr'),function(index,item){
				for(var i=0; i<=155; i++){
					if ($('#comprehensiveQtyTable .'+i).text() == "") {
						$('#comprehensiveQtyTable .'+i).addClass('d-none');
						$('#comprehensiveQtyTable tbody tr').eq(index).find('td').eq( (21+i) ).addClass('d-none'); //컬럼 앞에 추가 시 추가한 만큼 eqSize늘려주기
						$('#comprehensiveQtyTable tfoot tr').eq(0).find('td').eq( (7+i) ).addClass('d-none');
					}
				}
			}); */
			
			//전역변수들
 			let comprehensiveQtySumOutputCnt		= $('#comprehensiveQtyTable').DataTable().column(1,{ page: 'all'} ).data().sum();
			let comprehensiveQtySumAppearOutputCnt	= $('#comprehensiveQtyTable').DataTable().column(2,{ page: 'all'} ).data().sum();
			let comprehensiveQtySumFaulty			= $('#comprehensiveQtyTable').DataTable().column(3,{ page: 'all'} ).data().sum();
			let comprehensiveQtySumVisionFaulty		= $('#comprehensiveQtyTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			let comprehensiveQtySumFaultyPercent 	= 100 * comprehensiveQtySumFaulty / comprehensiveQtySumOutputCnt;

// 			$('#comprehensiveQtySumOutputCnt').html(addCommas(comprehensiveQtySumOutputCnt));
// 			$('#comprehensiveQtySumAppearOutputCnt').html(addCommas(comprehensiveQtySumAppearOutputCnt));
// 			$('#comprehensiveQtySumFaulty').html(addCommas(comprehensiveQtySumFaulty));
//             $('#comprehensiveQtySumVisionFaulty').html(addCommas(comprehensiveQtySumVisionFaulty));
// 			$('#comprehensiveQtySumFaultyPercent').html(comprehensiveQtySumFaultyPercent.toFixed(2) + "%");

			$('td[name=comprehensiveQtySumOutputCnt]').html(addCommas(comprehensiveQtySumOutputCnt));
			$('td[name=comprehensiveQtySumAppearOutputCnt]').html(addCommas(comprehensiveQtySumAppearOutputCnt));
			$('td[name=comprehensiveQtySumFaulty]').html(addCommas(comprehensiveQtySumFaulty));
			$('td[name=comprehensiveQtySumVisionFaulty]').html(addCommas(comprehensiveQtySumVisionFaulty));
            $('td[name=comprehensiveQtySumFaultyPercent]').html(comprehensiveQtySumFaultyPercent.toFixed(2) + "%");

			//틀 고정 tfooter
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(1).text(addCommas(comprehensiveQtySumOutputCnt));
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(2).text(addCommas(comprehensiveQtySumAppearOutputCnt));
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(3).text(addCommas(comprehensiveQtySumFaulty));
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(4).text(addCommas(comprehensiveQtySumVisionFaulty));
			$('#faultyStatsDay_wrapper table').eq(5).find('tfoot tr td').eq(5).text(comprehensiveQtySumFaultyPercent.toFixed(2) + "%");


			//컬럼 추가 시 for문 도 수정
			let comprehensiveQtyFaultyArray = new Array();
			
            for(var i=0; i<140; i++){
            	comprehensiveQtyFaultyArray[i] = showTypeChange($('#comprehensiveQtyTable').DataTable().column( (21+i) ,{ page: 'all'} ).data().sum(), comprehensiveQtySumOutputCnt);	//컬럼 추가될떄 column값도 늘려주기
            } 

			for(var i=0; i<140; i++){
				$('#comprehensiveQtyFaulty'+ (i+1) ).html(addCommas(comprehensiveQtyFaultyArray[i]));
			}
        },
    }); 

	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	$('#productionFrom').val(production1);
	$('#productionTo').val(production2);

	//생산일
// 	$('#productionFrom').val(production1);
// 	$('#productionTo').val(production2);
	
	//종합수량 검색
	$('#comprehensiveQtyTable_filter').find('label').eq(0).attr('style', 'width: 120%;');
	$('#comprehensiveQtyTable_filter').find('label').eq(0).addClass('row ml-3');
	$('#comprehensiveQtyTable_filter').find('input[type=search]').eq(0).addClass('ml-2');
	$("#comprehensiveQtyTable_filter").insertAfter("#showType");
	$("#comprehensiveQtyTable_filter").addClass("d-none");


	/* var DeduplicationCode = systemCommonCode.filter(function(item1, idx1){
	    return systemCommonCode.findIndex(function(item2, idx2){
	        return item1.baseCdNm == item2.baseCdNm
	    }) == idx1;
	}); */
	
// 	setTimeout(function() {
		columnVisibleFun('comprehensiveQtyTable', endArrayCount, comprehensiveQtyTable);
// 	});

  	$('#comprehensiveQtyTable_wrapper table').eq(1).find('tbody').on('click', 'tr', function () {
  		if( $(this.parentNode.parentNode).attr('class') == 'table table-bordered dataTable' ) {
			if ($(this).hasClass('selected')) {
				//$(this).removeClass('selected');
			} else {
				$('#comprehensiveQtyTable').DataTable().$('tr.selected').removeClass('selected');
				$(this).addClass('selected');
			}
  		}
  		$('#comprehensiveQtyTable_wrapper table').eq(4).find('tbody tr').removeClass('selected');
  	});
  	

	// 컴럼 숨김 처리 함수
  	function columnVisibleFun(tableNm, codeLength, domTableId) {
		let frontTdNum = 0;	//전체 테이블 개수
		
		for( var i=0; i<$('#'+tableNm+' thead tr').eq(0).find('th').length; i++) {
	   		if( $('#'+tableNm+' thead tr').eq(0).find('th').eq(i).attr('rowspan') == 2) {
	   			frontTdNum++;
	   		}
		}
		
		frontTdNum += $('#'+tableNm+' thead tr').eq(1).find('th').length;

		let codeNum = $('#'+tableNm+' thead tr').eq(1).find('th').length - codeLength;

		codeNum = frontTdNum - codeNum;
		
		//★제거
		for( var i=0; i<frontTdNum; i++) {
		    if( i >= codeNum ) {
		    	domTableId.column( i ).visible( false );
		    }
		};
	}

	//틀 고정 시 thead, tbody 깨지는 현상 잡아주는 부분
  	workOrderTable.on('draw.dt', function(){
  		workOrderTable.columns.adjust();
	});

  	faultyStatsDay.on('draw.dt', function(){
  		faultyStatsDay.columns.adjust();
	});

  	edgeGoodsFaultyTable.on('draw.dt', function(){
  		edgeGoodsFaultyTable.columns.adjust();
	});

  	visionWorkOrdTable.on('draw.dt', function(){
  		visionWorkOrdTable.columns.adjust();
	});

  	visionChargerTable.on('draw.dt', function(){
  		visionChargerTable.columns.adjust();
	});

  	comprehensiveQtyTable.on('draw.dt', function(){
  		comprehensiveQtyTable.columns.adjust();
	});
  	workOrderReInspTable.on('draw.dt', function(){
  		workOrderReInspTable.columns.adjust();
	});
	

  	//생산일 클체크박스 클릭 시
// 	$('#productionDateCheckBox').on('click', function(){
// 		if( $(this).prop('checked') ) {
// 			production1 = $('#productionFrom').val();
// 			production2 = $('#productionTo').val();
// 			$('#hideDateDiv').fadeIn(300);
// 		} else {
// 			production1 = '';
// 			production2 = '';
// 			$('#hideDateDiv').fadeOut(300);
// 		}
// 		$(this).blur();

// 		if( tabView == "tabView1" ){
//   			$('#faultyStatsDay').DataTable().ajax.reload();
//   	  	} else if( tabView == "tabView2" ){
//   			$('#edgeGoodsFaultyTable').DataTable().ajax.reload();
//   	  	} else if( tabView == "tabView3" ){
//   			$('#workOrderTable').DataTable().ajax.reload();
//   	  	} else if( tabView == "tabView4" ){
//   			$('#visionWorkOrdTable').DataTable().ajax.reload();
//   	  	} else if( tabView == "tabView5" ){
//   			$('#visionChargerTable').DataTable().ajax.reload();
//   	  	} else if( tabView == "tabView6" ){
//   			$('#comprehensiveQtyTable').DataTable().ajax.reload();
//   	  	} else {
//   	  		toastr.warning("탭 정보가 질못되었습니다.");
// 		}
		
// 	});

  	//검사일 or 생산일 조회
  	function showDateChange() {
  		if ( $('#showDate').val() == 'showDate001' ) {
			$('#chooseDateFrom').val($('#productionFrom').val());
			$('#chooseDateTo').val($('#productionTo').val());
			$('#chooseDateDiv').removeClass('d-none');
			$('#productionDiv').addClass('d-none');
		} else {
			$('#productionFrom').val($('#chooseDateFrom').val());
			$('#productionTo').val($('#chooseDateTo').val());
			$('#chooseDateDiv').addClass('d-none');
			$('#productionDiv').removeClass('d-none');
		}
  	}
  	
</script>
</body>
</html>
