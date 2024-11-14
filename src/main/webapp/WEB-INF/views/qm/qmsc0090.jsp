<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%	pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">최종검사집계</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width:99%; padding-bottom:0px;">
				<div class="card"  style="margin-bottom: 10px;">
					<div class="row" style="margin-bottom: 10px;">
						&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">외관검사일</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="chooseDateFrom" />
							<button	onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="chooseDateTo" />
							<button	onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">형식</label>
						<select class="custom-select" style="width:70px;" id="showType">
						<option value="showType001">개수</option>
						<option value="showType002">%</option>
						</select>
					</div>
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">기간별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">제품별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">유형별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">설비별</a></li>
						</ul>
					</div>
					
					<!-- 기간별 -->
					<div id="faultyWeekView">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="faultyStatsWeek" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" style="min-width: 70px;" class="text-center">검사일자</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 검사수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 양품수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 불량수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">불량률(%)</th>
										<th rowspan="2 " style="min-width: 70px;" class="text-center">엣지 불량수량</th>
										<!-- <th colspan="47" style="min-width: 70px;" class="text-center" id="appearFaultyWeek">외관 불량수량</th> -->
										<th colspan="13" style="min-width: 70px;" class="text-center" class="text-center" id="metalHd">메탈부 불량</th>
										<th colspan="15" style="min-width: 70px;" class="text-center" class="text-center" id="filmHd">필름부 불량</th>
										<!-- <th colspan="2" style="min-width: 70px;" class="text-center" class="text-center" id="visonHd">비전부 불량</th>
										<th colspan="2" style="min-width: 70px;" class="text-center" class="text-center" id="fiveHd">5 부불량</th> -->
									</tr>
									<tr id="appearFaultyWeekHd">
										<th style="min-width: 50px" class="text-center">MMB</th>
										<th style="min-width: 50px" class="text-center">MMS</th>
										<th style="min-width: 50px" class="text-center">PMS</th>
										<th style="min-width: 50px" class="text-center">M찍힘</th>
										<th style="min-width: 50px" class="text-center">P찍힘</th>
										<th style="min-width: 50px" class="text-center">M이물</th>
										<th style="min-width: 50px" class="text-center">M꺽임</th>
										<th style="min-width: 50px" class="text-center">M오염</th>
										<th style="min-width: 50px" class="text-center">M갈변</th>
										<th style="min-width: 50px" class="text-center">P오염</th>
										<th style="min-width: 50px" class="text-center">도금박리</th>
										<th style="min-width: 50px" class="text-center">총두께</th>
										<th style="min-width: 50px" class="text-center">메탈-기타</th>
										<th style="min-width: 50px" class="text-center">PFS</th>
										<th style="min-width: 50px" class="text-center">F꺽임</th>
										<th style="min-width: 50px" class="text-center">뜯김</th>
										<th style="min-width: 50px" class="text-center">표면기포</th>
										<th style="min-width: 50px" class="text-center">엣지기포</th>
										<th style="min-width: 50px" class="text-center">테프론</th>
										<th style="min-width: 50px" class="text-center">P이물</th>
										<th style="min-width: 50px" class="text-center">P오염</th>
										<th style="min-width: 50px" class="text-center">F뭉침</th>
										<th style="min-width: 50px" class="text-center">필름겹침</th>
										<th style="min-width: 50px" class="text-center">미진접</th>
										<th style="min-width: 50px" class="text-center">미부착</th>
										<th style="min-width: 50px" class="text-center">MF</th>
										<th style="min-width: 50px" class="text-center">날개꺽임</th>
										<th style="min-width: 50px" class="text-center">필름-기타</th>
										<th style="min-width: 50px" class="text-center">치수</th>
										<th style="min-width: 50px" class="text-center">컷팅</th>
										<th style="min-width: 50px" class="text-center">필름눌림</th>
										<th style="min-width: 50px" class="text-center">필름폭</th>
										<th style="min-width: 50px" class="text-center">레이어</th>
										<th style="min-width: 50px" class="text-center">빨래판</th>
										<th style="min-width: 60px" class="text-center">백색테이프</th>
										<th style="min-width: 50px" class="text-center">결무늬</th>
										<th style="min-width: 50px" class="text-center">F찍힘</th>
										<th style="min-width: 50px" class="text-center">아지랑이</th>
										<th style="min-width: 50px" class="text-center">표면처리</th>
										<th style="min-width: 50px" class="text-center">돌기</th>
										<th style="min-width: 50px" class="text-center">피딩</th>
										<th style="min-width: 50px" class="text-center">필름농</th>
										<th style="min-width: 50px" class="text-center">F사선</th>
										<th style="min-width: 50px" class="text-center">진접터짐</th>
										<th style="min-width: 50px" class="text-center">들뜸</th>
										<th style="min-width: 50px" class="text-center">P.P주름</th>
										<th style="min-width: 50px" class="text-center">기타-기타</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="" style="text-align: center">합계</td>
										<td colspan="" id="sumOutputCnt1" style="text-align: right">0</td>
										<td colspan="" id="sumAppearOutputCnt1" style="text-align: right">0</td>
										<td colspan="" id="sumFaulty1" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyPercent1" style="text-align: right">0</td>
										<td colspan="" id="sumEdgeFaulty1" style="text-align: right">0</td>									
										<td colspan="" id="weekFaulty1" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty2" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty3" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty4" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty5" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty6" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty7" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty8" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty9" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty10" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty11" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty12" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty13" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty14" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty15" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty16" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty17" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty18" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty19" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty20" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty21" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty22" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty23" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty24" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty25" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty26" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty27" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty28" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty29" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty30" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty31" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty32" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty33" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty34" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty35" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty36" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty37" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty38" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty39" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty40" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty41" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty42" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty43" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty44" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty45" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty46" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty47" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty48" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty49" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty50" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty51" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty52" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty53" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty54" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty55" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty56" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty57" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty58" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty59" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty60" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty61" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty62" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty63" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty64" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty65" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty66" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty67" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty68" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty69" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty70" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty71" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty72" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty73" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty74" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty75" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty76" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty77" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty78" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty79" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty80" style="text-align: right">0</td> 
										<td colspan="" id="weekFaulty81" style="text-align: right">0</td> 
										<td colspan="" id="weekFaulty82" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty83" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty84" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty85" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty86" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty87" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty88" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty89" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty90" style="text-align: right">0</td> 
										<td colspan="" id="weekFaulty91" style="text-align: right">0</td> 
										<td colspan="" id="weekFaulty92" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty93" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty94" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty95" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty96" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty97" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty98" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty99" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty100" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty101" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty102" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty103" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty104" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty105" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty106" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty107" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty108" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty109" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty110" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty111" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty112" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty113" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty114" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty115" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty116" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty117" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty118" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty119" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty120" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty121" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty122" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty123" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty124" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty125" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty126" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty127" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty128" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty129" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty130" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty131" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty132" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty133" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty134" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty135" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty136" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty137" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty138" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty139" style="text-align: right">0</td>
										<td colspan="" id="weekFaulty140" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>

					<!-- 제품별 -->
					<div id="faultyGoodsView" class="d-none">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="faultyStatsGoods" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" style="min-width: 70px;" class="text-center">제품명</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 검사수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 양품수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 불량수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">불량률(%)</th>
										<th rowspan="2 " style="min-width: 70px;" class="text-center">엣지불량수량</th>
										<!-- <th colspan="47" style="min-width: 70px;" class="text-center" id="appearFaultyGoods">외관불량수량</th> -->
										<th colspan="13" style="min-width: 70px;" class="text-center" class="text-center" id="metalHd2">메탈부 불량</th>
										<th colspan="15" style="min-width: 70px;" class="text-center" class="text-center" id="filmHd2">필름부 불량</th>
										<!-- <th colspan="2" style="min-width: 70px;" class="text-center" class="text-center" id="visonHd2">비전부 불량</th>
										<th colspan="2" style="min-width: 70px;" class="text-center" class="text-center" id="fiveHd2">5 부불량</th> -->
								</tr>
									<tr id="appearFaultyGoodsHd">
										<th style="min-width: 50px" class="text-center">MMB</th>
										<th style="min-width: 50px" class="text-center">MMS</th>
										<th style="min-width: 50px" class="text-center">PMS</th>
										<th style="min-width: 50px" class="text-center">M찍힘</th>
										<th style="min-width: 50px" class="text-center">P찍힘</th>
										<th style="min-width: 50px" class="text-center">M이물</th>
										<th style="min-width: 50px" class="text-center">M꺽임</th>
										<th style="min-width: 50px" class="text-center">M오염</th>
										<th style="min-width: 50px" class="text-center">M갈변</th>
										<th style="min-width: 50px" class="text-center">P오염</th>
										<th style="min-width: 50px" class="text-center">도금박리</th>
										<th style="min-width: 50px" class="text-center">총두께</th>
										<th style="min-width: 50px" class="text-center">메탈-기타</th>
										<th style="min-width: 50px" class="text-center">PFS</th>
										<th style="min-width: 50px" class="text-center">F꺽임</th>
										<th style="min-width: 50px" class="text-center">뜯김</th>
										<th style="min-width: 50px" class="text-center">표면기포</th>
										<th style="min-width: 50px" class="text-center">엣지기포</th>
										<th style="min-width: 50px" class="text-center">테프론</th>
										<th style="min-width: 50px" class="text-center">P이물</th>
										<th style="min-width: 50px" class="text-center">P오염</th>
										<th style="min-width: 50px" class="text-center">F뭉침</th>
										<th style="min-width: 50px" class="text-center">필름겹침</th>
										<th style="min-width: 50px" class="text-center">미진접</th>
										<th style="min-width: 50px" class="text-center">미부착</th>
										<th style="min-width: 50px" class="text-center">MF</th>
										<th style="min-width: 50px" class="text-center">날개꺽임</th>
										<th style="min-width: 50px" class="text-center">필름-기타</th>
										<th style="min-width: 50px" class="text-center">치수</th>
										<th style="min-width: 50px" class="text-center">컷팅</th>
										<th style="min-width: 50px" class="text-center">필름눌림</th>
										<th style="min-width: 50px" class="text-center">필름폭</th>
										<th style="min-width: 50px" class="text-center">레이어</th>
										<th style="min-width: 50px" class="text-center">빨래판</th>
										<th style="min-width: 60px" class="text-center">백색테이프</th>
										<th style="min-width: 50px" class="text-center">결무늬</th>
										<th style="min-width: 50px" class="text-center">F찍힘</th>
										<th style="min-width: 50px" class="text-center">아지랑이</th>
										<th style="min-width: 50px" class="text-center">표면처리</th>
										<th style="min-width: 50px" class="text-center">돌기</th>
										<th style="min-width: 50px" class="text-center">피딩</th>
										<th style="min-width: 50px" class="text-center">필름농</th>
										<th style="min-width: 50px" class="text-center">F사선</th>
										<th style="min-width: 50px" class="text-center">진접터짐</th>
										<th style="min-width: 50px" class="text-center">들뜸</th>
										<th style="min-width: 50px" class="text-center">P.P주름</th>
										<th style="min-width: 50px" class="text-center">기타-기타</th>
								</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="" style="min-width:130px;text-align:center">합계</td>
										<td colspan="" id="sumOutputCnt2" style="text-align: right">0</td>
										<td colspan="" id="sumAppearOutputCnt2" style="text-align: right">0</td>
										<td colspan="" id="sumFaulty2" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyPercent2" style="text-align: right">0</td>
										<td colspan="" id="sumEdgeFaulty2" style="text-align: right">0</td>
										
										<td colspan="" id="goodsFaulty1" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty2" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty3" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty4" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty5" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty6" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty7" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty8" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty9" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty10" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty11" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty12" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty13" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty14" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty15" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty16" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty17" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty18" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty19" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty20" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty21" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty22" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty23" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty24" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty25" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty26" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty27" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty28" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty29" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty30" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty31" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty32" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty33" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty34" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty35" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty36" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty37" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty38" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty39" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty40" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty41" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty42" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty43" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty44" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty45" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty46" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty47" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty48" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty49" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty50" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty51" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty52" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty53" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty54" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty55" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty56" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty57" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty58" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty59" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty60" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty61" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty62" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty63" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty64" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty65" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty66" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty67" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty68" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty69" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty70" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty71" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty72" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty73" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty74" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty75" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty76" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty77" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty78" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty79" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty80" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty81" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty82" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty83" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty84" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty85" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty86" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty87" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty88" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty89" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty90" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty91" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty92" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty93" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty94" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty95" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty96" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty97" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty98" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty99" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty100" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty101" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty102" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty103" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty104" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty105" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty106" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty107" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty108" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty109" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty110" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty111" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty112" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty113" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty114" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty115" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty116" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty117" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty118" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty119" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty120" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty121" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty122" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty123" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty124" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty125" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty126" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty127" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty128" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty129" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty130" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty131" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty132" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty133" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty134" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty135" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty136" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty137" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty138" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty139" style="text-align: right">0</td>
										<td colspan="" id="goodsFaulty140" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>

					<!-- 유형별 -->
					<div id="faultyTypeView" class="d-none">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="faultyStatsType" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th style="min-width: 70px;" class="text-center">총 검사 수량</th>
										<th style="min-width: 70px;" class="text-center">총 엣지 불량 수량</th>
										<th style="min-width: 70px;" class="text-center">총 엣지 불량(%)</th>
										<th style="min-width: 70px;" class="text-center">총 외관 불량 수량</th>
										<th style="min-width: 70px;" class="text-center">총 외관 불량(%)</th>
										<th style="min-width: 70px;" class="text-center">외관-Metal 불량합계</th>
										<th style="min-width: 70px;" class="text-center">외관-M불량(%)</th>
										<th style="min-width: 70px;" class="text-center">외관-Film 불량합계</th>
										<th style="min-width: 70px;" class="text-center">외관-F불량(%)</th>
										<!-- <th style="min-width: 70px;" class="text-center">외관-Etc 불량합계</th>
										<th style="min-width: 70px;" class="text-center">외관-E불량(%)</th> -->
								</tr>
								</thead>
							</table>
						</div>
					</div>
					
					<!-- 설비별 -->
					<div id="faultyEquipTypeView" class="d-none">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="faultyEquipType" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" style="min-width: 70px;" class="text-center">설비명</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 검사수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 양품수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">총 불량수량</th>
										<th rowspan="2" style="min-width: 70px;" class="text-center">불량률(%)</th>
										<th rowspan="2 " style="min-width: 70px;" class="text-center">엣지불량수량</th>
										<!-- <th colspan="47" style="min-width: 70px;" class="text-center" id="appearFaultyEquip">외관불량수량</th> -->
										
										<th colspan="13" style="min-width: 70px;" class="text-center" class="text-center" id="metalHd3">메탈부 불량</th>
										<th colspan="15" style="min-width: 70px;" class="text-center" class="text-center" id="filmHd3">필름부 불량</th>
										<!-- <th colspan="2" style="min-width: 70px;" class="text-center" class="text-center" id="visonHd3">비전부 불량</th>
										<th colspan="2" style="min-width: 70px;" class="text-center" class="text-center" id="fiveHd3">5 부불량</th> -->
									</tr>
									<tr id="appearFaultyEquipHd">
										<th style="min-width: 50px" class="text-center">MMB</th>
										<th style="min-width: 50px" class="text-center">MMS</th>
										<th style="min-width: 50px" class="text-center">PMS</th>
										<th style="min-width: 50px" class="text-center">M찍힘</th>
										<th style="min-width: 50px" class="text-center">P찍힘</th>
										<th style="min-width: 50px" class="text-center">M이물</th>
										<th style="min-width: 50px" class="text-center">M꺽임</th>
										<th style="min-width: 50px" class="text-center">M오염</th>
										<th style="min-width: 50px" class="text-center">M갈변</th>
										<th style="min-width: 50px" class="text-center">P오염</th>
										<th style="min-width: 50px" class="text-center">도금박리</th>
										<th style="min-width: 50px" class="text-center">총두께</th>
										<th style="min-width: 50px" class="text-center">메탈-기타</th>
										<th style="min-width: 50px" class="text-center">PFS</th>
										<th style="min-width: 50px" class="text-center">F꺽임</th>
										<th style="min-width: 50px" class="text-center">뜯김</th>
										<th style="min-width: 50px" class="text-center">표면기포</th>
										<th style="min-width: 50px" class="text-center">엣지기포</th>
										<th style="min-width: 50px" class="text-center">테프론</th>
										<th style="min-width: 50px" class="text-center">P이물</th>
										<th style="min-width: 50px" class="text-center">P오염</th>
										<th style="min-width: 50px" class="text-center">F뭉침</th>
										<th style="min-width: 50px" class="text-center">필름겹침</th>
										<th style="min-width: 50px" class="text-center">미진접</th>
										<th style="min-width: 50px" class="text-center">미부착</th>
										<th style="min-width: 50px" class="text-center">MF</th>
										<th style="min-width: 50px" class="text-center">날개꺽임</th>
										<th style="min-width: 50px" class="text-center">필름-기타</th>
										<th style="min-width: 50px" class="text-center">치수</th>
										<th style="min-width: 50px" class="text-center">컷팅</th>
										<th style="min-width: 50px" class="text-center">필름눌림</th>
										<th style="min-width: 50px" class="text-center">필름폭</th>
										<th style="min-width: 50px" class="text-center">레이어</th>
										<th style="min-width: 50px" class="text-center">빨래판</th>
										<th style="min-width: 60px" class="text-center">백색테이프</th>
										<th style="min-width: 50px" class="text-center">결무늬</th>
										<th style="min-width: 50px" class="text-center">F찍힘</th>
										<th style="min-width: 50px" class="text-center">아지랑이</th>
										<th style="min-width: 50px" class="text-center">표면처리</th>
										<th style="min-width: 50px" class="text-center">돌기</th>
										<th style="min-width: 50px" class="text-center">피딩</th>
										<th style="min-width: 50px" class="text-center">필름농</th>
										<th style="min-width: 50px" class="text-center">F사선</th>
										<th style="min-width: 50px" class="text-center">진접터짐</th>
										<th style="min-width: 50px" class="text-center">들뜸</th>
										<th style="min-width: 50px" class="text-center">P.P주름</th>
										<th style="min-width: 50px" class="text-center">기타-기타</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="" style="text-align: center">합계</td>
										<td colspan="" id="sumOutputCnt3" style="text-align: right">0</td>
										<td colspan="" id="sumAppearOutputCnt3" style="text-align: right">0</td>
										<td colspan="" id="sumFaulty3" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyPercent3" style="text-align: right">0</td>
										<td colspan="" id="sumEdgeFaulty3" style="text-align: right">0</td>
										
										<td colspan="" id="equipFaulty1" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty2" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty3" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty4" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty5" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty6" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty7" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty8" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty9" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty10" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty11" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty12" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty13" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty14" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty15" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty16" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty17" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty18" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty19" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty20" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty21" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty22" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty23" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty24" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty25" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty26" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty27" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty28" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty29" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty30" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty31" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty32" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty33" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty34" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty35" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty36" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty37" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty38" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty39" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty40" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty41" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty42" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty43" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty44" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty45" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty46" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty47" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty48" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty49" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty50" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty51" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty52" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty53" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty54" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty55" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty56" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty57" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty58" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty59" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty60" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty61" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty62" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty63" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty64" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty65" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty66" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty67" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty68" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty69" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty70" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty71" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty72" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty73" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty74" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty75" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty76" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty77" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty78" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty79" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty80" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty81" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty82" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty83" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty84" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty85" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty86" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty87" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty88" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty89" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty90" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty91" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty92" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty93" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty94" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty95" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty96" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty97" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty98" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty99" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty100" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty101" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty102" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty103" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty104" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty105" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty106" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty107" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty108" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty109" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty110" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty111" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty112" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty113" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty114" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty115" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty116" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty117" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty118" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty119" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty120" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty121" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty122" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty123" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty124" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty125" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty126" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty127" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty128" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty129" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty130" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty131" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty132" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty133" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty134" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty135" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty136" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty137" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty138" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty139" style="text-align: right">0</td>
										<td colspan="" id="equipFaulty140" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- /.left-list -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>
	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'qmsc0090';
	let currentHref = 'qmsc0090';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","최종검사집계");
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
   //외관대분류명,기간별
   	$('#metalHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmHd').text(goodsFaultyBigNameCd[1].baseCdNm);
	//$('#visonHd').text(goodsFaultyBigNameCd[3].baseCdNm);
	//$('#fiveHd').text(goodsFaultyBigNameCd[4].baseCdNm);
	//외관대분류명, 제품별
	$('#metalHd2').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmHd2').text(goodsFaultyBigNameCd[1].baseCdNm);
	//$('#visonHd2').text(goodsFaultyBigNameCd[3].baseCdNm);
	//$('#fiveHd2').text(goodsFaultyBigNameCd[4].baseCdNm);
	//외관대분류명, 설비별
	$('#metalHd3').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmHd3').text(goodsFaultyBigNameCd[1].baseCdNm);
	//$('#visonHd3').text(goodsFaultyBigNameCd[3].baseCdNm);
	//$('#fiveHd3').text(goodsFaultyBigNameCd[4].baseCdNm);
	//$('#sixHd').text(goodsFaultyBigNameCd[5].baseCdNm);

	var serverDateFrom = "${serverDateFrom}";
	var serverDate = "${serverDate}";
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDate);
	var tapTemp = 0;
	var showType = "showType001";
	
	var sumOutputCnt1 = 0;
	var sumAppearOutputCnt1 = 0;
	var sumFaulty1 = 0;
	var sumFaultyPercent1 = 0;

	var sumOutputCnt2 = 0;
	var sumAppearOutputCnt2 = 0;
	var sumFaulty2 = 0;
	var sumFaultyPercent2 = 0;

	var sumOutputCnt3 = 0;
	var sumAppearOutputCnt3 = 0;
	var sumFaulty3 = 0;
	var sumFaultyPercent3 = 0;
	//var chooseDateFromWeek = serverDateFrom;
	//var chooseDateWeek = serverDate;
	//var chooseDateFromGoods = serverDateFrom;
	//var chooseDateGoods = serverDate;
	//var chooseDateFromType = serverDateFrom;
	//var chooseDateType = serverDate;
	//var chooseDateFromEquip = serverDateFrom;
	//var chooseDateEquip = serverDate;
	appearWeekHeaderCreate();
	appearGoodsHeaderCreate();
	appearEquipHeaderCreate();
	// 기간별
	$.fn.dataTable.ext.errMode = 'none';
	let faultyStatsWeek = $('#faultyStatsWeek').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: true,
        searching: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/faultyWeekTotalDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
	           	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val().replace(/-/g, ''); },
	           	'chooseDate'		: 		function() { return $('#chooseDateTo').val().replace(/-/g, ''); },
            },
        },
        columns: [
			{
				render: function(data, type, row) {
					return moment(row['appearInspctDate']).format('YYYY-MM-DD');
				}
			},
        	{ data: 'userInputInspctCnt' },
        	{ data: 'appearOutputCnt' },
        	{ data: 'faultSum' },
			{ data: 'faultPercent',
				render: function(data, type, row) {
					return addCommas(data.toFixed(1)) + " %";
				}
			},
        	{ data: 'edgeFaultyCnt' },//엣지 불량수량
        	{ data: 'faulty1',
        		render: function(data, type, row) {
            		if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
						}
					}
        		}
        	},
        	
        ],
        columnDefs: [
        	{ targets: [0], className: 'text-center' },
        	{ targets: [1,2,3,  5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '최종검사집계(기간)',
            },
            {
				extend: 'excel',
				title: '최종검사집계(기간)',
				exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (showType == 'showType001') {
								if (row == 4) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 4) { return data.replace(" %", ""); }
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
                title: '최종검사집계(기간)',
            },
        ],
        drawCallback: function () {

			$.each($('#faultyStatsWeek tbody tr'),function(index,item){	
				
				if($('#faultyStatsWeek .0').text()==""){            	
					$('#faultyStatsWeek .0').addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(6).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .1').text()==""){	
					$('#faultyStatsWeek .1').addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(7).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .2').text()==""){	
					$('#faultyStatsWeek .2').addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(8).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .3').text()==""){	
					$('#faultyStatsWeek .3').addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(9).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .4').text()==""){	
					$('#faultyStatsWeek .4').addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(10).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .5').text()==""){	
					$('#faultyStatsWeek .5').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(11).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .6').text()==""){	
					$('#faultyStatsWeek .6').addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(12).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .7').text()==""){	
					$('#faultyStatsWeek .7').addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(13).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .8').text()==""){	
					$('#faultyStatsWeek .8').addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(14).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .9').text()==""){	
					$('#faultyStatsWeek .9').addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(15).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .10').text()==""){	
					$('#faultyStatsWeek .10').addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(16).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .11').text()==""){	
					$('#faultyStatsWeek .11').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(17).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .12').text()==""){	
					$('#faultyStatsWeek .12').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(18).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .13').text()==""){	
					$('#faultyStatsWeek .13').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(19).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .14').text()==""){	
					$('#faultyStatsWeek .14').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(20).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .15').text()==""){	
					$('#faultyStatsWeek .15').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(21).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .16').text()==""){	
					$('#faultyStatsWeek .16').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(22).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .17').text()==""){	
					$('#faultyStatsWeek .17').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(23).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .18').text()==""){	
					$('#faultyStatsWeek .18').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(24).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .19').text()==""){	
					$('#faultyStatsWeek .19').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(25).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .20').text()==""){	
					$('#faultyStatsWeek .20').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(26).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .21').text()==""){	
					$('#faultyStatsWeek .21').addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(27).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .22').text()==""){	
					$('#faultyStatsWeek .22').addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(28).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .23').text()==""){	
					$('#faultyStatsWeek .23').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(29).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .24').text()==""){	
					$('#faultyStatsWeek .24').addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(30).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .25').text()==""){	
					$('#faultyStatsWeek .25').addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(31).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .26').text()==""){	
					$('#faultyStatsWeek .26').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(32).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .27').text()==""){	
					$('#faultyStatsWeek .27').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(33).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .28').text()==""){	
					$('#faultyStatsWeek .28').addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(34).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .29').text()==""){	
					$('#faultyStatsWeek .29').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(35).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .30').text()==""){	
					$('#faultyStatsWeek .30').addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(36).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .31').text()==""){	
					$('#faultyStatsWeek .31').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(37).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .32').text()==""){	
					$('#faultyStatsWeek .32').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(38).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .33').text()==""){	
					$('#faultyStatsWeek .33').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(39).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .34').text()==""){	
					$('#faultyStatsWeek .34').addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(40).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .35').text()==""){	
					$('#faultyStatsWeek .35').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(41).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .36').text()==""){	
					$('#faultyStatsWeek .36').addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(42).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .37').text()==""){	
					$('#faultyStatsWeek .37').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(43).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .38').text()==""){	
					$('#faultyStatsWeek .38').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(44).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .39').text()==""){	
					$('#faultyStatsWeek .39').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(45).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .40').text()==""){	
					$('#faultyStatsWeek .40').addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(46).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .41').text()==""){	
					$('#faultyStatsWeek .41').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(47).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .42').text()==""){	
					$('#faultyStatsWeek .42').addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(48).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .43').text()==""){	
					$('#faultyStatsWeek .43').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(49).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .44').text()==""){	
					$('#faultyStatsWeek .44').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(50).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .45').text()==""){	
					$('#faultyStatsWeek .45').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(51).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .46').text()==""){	
					$('#faultyStatsWeek .46').addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(52).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .47').text()==""){	
					$('#faultyStatsWeek .47').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(53).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .48').text()==""){	
					$('#faultyStatsWeek .48').addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(54).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .49').text()==""){	
					$('#faultyStatsWeek .49').addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(55).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .50').text()==""){	
					$('#faultyStatsWeek .50').addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(56).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .51').text()==""){	
					$('#faultyStatsWeek .51').addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(57).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .52').text()==""){	
					$('#faultyStatsWeek .52').addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(58).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .53').text()==""){	
					$('#faultyStatsWeek .53').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(59).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .54').text()==""){	
					$('#faultyStatsWeek .54').addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(60).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .55').text()==""){	
					$('#faultyStatsWeek .55').addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(61).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .56').text()==""){	
					$('#faultyStatsWeek .56').addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(62).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .57').text()==""){	
					$('#faultyStatsWeek .57').addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(63).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .58').text()==""){	
					$('#faultyStatsWeek .58').addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(64).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .59').text()==""){	
					$('#faultyStatsWeek .59').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(65).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .60').text()==""){	
					$('#faultyStatsWeek .60').addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(66).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .61').text()==""){	
					$('#faultyStatsWeek .61').addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(67).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .62').text()==""){	
					$('#faultyStatsWeek .62').addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(68).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .63').text()==""){	
					$('#faultyStatsWeek .63').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(69).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .64').text()==""){	
					$('#faultyStatsWeek .64').addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(70).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .65').text()==""){	
					$('#faultyStatsWeek .65').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(71).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .66').text()==""){	
					$('#faultyStatsWeek .66').addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(72).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .67').text()==""){	
					$('#faultyStatsWeek .67').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(73).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .68').text()==""){	
					$('#faultyStatsWeek .68').addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(74).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .69').text()==""){	
					$('#faultyStatsWeek .69').addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(75).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .70').text()==""){	
					$('#faultyStatsWeek .70').addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(76).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .71').text()==""){	
					$('#faultyStatsWeek .71').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(77).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .72').text()==""){	
					$('#faultyStatsWeek .72').addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(78).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .73').text()==""){	
					$('#faultyStatsWeek .73').addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(79).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .74').text()==""){	
					$('#faultyStatsWeek .74').addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(80).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .75').text()==""){	
					$('#faultyStatsWeek .75').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(81).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .76').text()==""){	
					$('#faultyStatsWeek .76').addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(82).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .77').text()==""){	
					$('#faultyStatsWeek .77').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(83).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .78').text()==""){	
					$('#faultyStatsWeek .78').addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(84).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .79').text()==""){	
					$('#faultyStatsWeek .79').addClass('d-none');
					$(this).find('td').eq(85).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(85).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .80').text()==""){	
					$('#faultyStatsWeek .80').addClass('d-none');
					$(this).find('td').eq(86).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(86).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .81').text()==""){	
					$('#faultyStatsWeek .81').addClass('d-none');
					$(this).find('td').eq(87).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(87).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .82').text()==""){	
					$('#faultyStatsWeek .82').addClass('d-none');
					$(this).find('td').eq(88).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(88).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .83').text()==""){	
					$('#faultyStatsWeek .83').addClass('d-none');
					$(this).find('td').eq(89).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(89).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .84').text()==""){	
					$('#faultyStatsWeek .84').addClass('d-none');
					$(this).find('td').eq(90).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(90).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .85').text()==""){	
					$('#faultyStatsWeek .85').addClass('d-none');
					$(this).find('td').eq(91).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(91).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .86').text()==""){	
					$('#faultyStatsWeek .86').addClass('d-none');
					$(this).find('td').eq(92).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(92).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .87').text()==""){	
					$('#faultyStatsWeek .87').addClass('d-none');
					$(this).find('td').eq(93).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(93).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .88').text()==""){	
					$('#faultyStatsWeek .88').addClass('d-none');
					$(this).find('td').eq(94).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(94).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .89').text()==""){	
					$('#faultyStatsWeek .89').addClass('d-none');
					$(this).find('td').eq(95).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(95).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .90').text()==""){	
					$('#faultyStatsWeek .90').addClass('d-none');
					$(this).find('td').eq(96).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(96).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .91').text()==""){	
					$('#faultyStatsWeek .91').addClass('d-none');
					$(this).find('td').eq(97).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(97).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .92').text()==""){	
					$('#faultyStatsWeek .92').addClass('d-none');
					$(this).find('td').eq(98).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(98).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .93').text()==""){	
					$('#faultyStatsWeek .93').addClass('d-none');
					$(this).find('td').eq(99).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(99).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .94').text()==""){	
					$('#faultyStatsWeek .94').addClass('d-none');
					$(this).find('td').eq(100).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(100).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .95').text()==""){	
					$('#faultyStatsWeek .95').addClass('d-none');
					$(this).find('td').eq(101).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(101).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .96').text()==""){	
					$('#faultyStatsWeek .96').addClass('d-none');
					$(this).find('td').eq(102).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(102).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .97').text()==""){	
					$('#faultyStatsWeek .97').addClass('d-none');
					$(this).find('td').eq(103).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(103).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .98').text()==""){	
					$('#faultyStatsWeek .98').addClass('d-none');
					$(this).find('td').eq(104).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(104).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .99').text()==""){	
					$('#faultyStatsWeek .99').addClass('d-none');
					$(this).find('td').eq(105).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(105).addClass('d-none');
					
				 }		
				if($('#faultyStatsWeek .100').text()==""){	
					$('#faultyStatsWeek .100').addClass('d-none');
					$(this).find('td').eq(106).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(106).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .101').text()==""){	
					$('#faultyStatsWeek .101').addClass('d-none');
					$(this).find('td').eq(107).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(107).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .102').text()==""){	
					$('#faultyStatsWeek .102').addClass('d-none');
					$(this).find('td').eq(108).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(108).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .103').text()==""){	
					$('#faultyStatsWeek .103').addClass('d-none');
					$(this).find('td').eq(109).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(109).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .104').text()==""){	
					$('#faultyStatsWeek .104').addClass('d-none');
					$(this).find('td').eq(110).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(110).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .105').text()==""){	
					$('#faultyStatsWeek .105').addClass('d-none');
					$(this).find('td').eq(111).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(111).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .106').text()==""){	
					$('#faultyStatsWeek .106').addClass('d-none');
					$(this).find('td').eq(112).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(112).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .107').text()==""){	
					$('#faultyStatsWeek .107').addClass('d-none');
					$(this).find('td').eq(113).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(113).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .108').text()==""){	
					$('#faultyStatsWeek .108').addClass('d-none');
					$(this).find('td').eq(114).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(114).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .109').text()==""){	
					$('#faultyStatsWeek .109').addClass('d-none');
					$(this).find('td').eq(115).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(115).addClass('d-none');
					
				 }
				if($('#faultyStatsWeek .110').text()==""){	
					$('#faultyStatsWeek .110').addClass('d-none');
					$(this).find('td').eq(116).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(116).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .111').text()==""){	
					$('#faultyStatsWeek .111').addClass('d-none');
					$(this).find('td').eq(117).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(117).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .112').text()==""){	
					$('#faultyStatsWeek .112').addClass('d-none');
					$(this).find('td').eq(118).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(118).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .113').text()==""){	
					$('#faultyStatsWeek .113').addClass('d-none');
					$(this).find('td').eq(119).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(119).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .114').text()==""){	
					$('#faultyStatsWeek .114').addClass('d-none');
					$(this).find('td').eq(120).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(120).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .115').text()==""){	
					$('#faultyStatsWeek .115').addClass('d-none');
					$(this).find('td').eq(121).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(121).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .116').text()==""){	
					$('#faultyStatsWeek .116').addClass('d-none');
					$(this).find('td').eq(122).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(122).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .117').text()==""){	
					$('#faultyStatsWeek .117').addClass('d-none');
					$(this).find('td').eq(123).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(123).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .118').text()==""){	
					$('#faultyStatsWeek .118').addClass('d-none');
					$(this).find('td').eq(124).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(124).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .119').text()==""){	
					$('#faultyStatsWeek .119').addClass('d-none');
					$(this).find('td').eq(125).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(125).addClass('d-none');
					
				 }		
				if($('#faultyStatsWeek .120').text()==""){	
					$('#faultyStatsWeek .120').addClass('d-none');
					$(this).find('td').eq(126).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(126).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .121').text()==""){	
					$('#faultyStatsWeek .121').addClass('d-none');
					$(this).find('td').eq(127).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(127).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .122').text()==""){	
					$('#faultyStatsWeek .122').addClass('d-none');
					$(this).find('td').eq(128).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(128).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .123').text()==""){	
					$('#faultyStatsWeek .123').addClass('d-none');
					$(this).find('td').eq(129).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(129).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .124').text()==""){	
					$('#faultyStatsWeek .124').addClass('d-none');
					$(this).find('td').eq(130).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(130).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .125').text()==""){	
					$('#faultyStatsWeek .125').addClass('d-none');
					$(this).find('td').eq(131).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(131).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .126').text()==""){	
					$('#faultyStatsWeek .126').addClass('d-none');
					$(this).find('td').eq(132).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(132).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .127').text()==""){	
					$('#faultyStatsWeek .127').addClass('d-none');
					$(this).find('td').eq(133).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(133).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .128').text()==""){	
					$('#faultyStatsWeek .128').addClass('d-none');
					$(this).find('td').eq(134).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(134).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .129').text()==""){	
					$('#faultyStatsWeek .129').addClass('d-none');
					$(this).find('td').eq(135).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(135).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .130').text()==""){	
					$('#faultyStatsWeek .130').addClass('d-none');
					$(this).find('td').eq(136).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(136).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .131').text()==""){	
					$('#faultyStatsWeek .131').addClass('d-none');
					$(this).find('td').eq(137).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(137).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .132').text()==""){	
					$('#faultyStatsWeek .132').addClass('d-none');
					$(this).find('td').eq(138).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(138).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .133').text()==""){	
					$('#faultyStatsWeek .133').addClass('d-none');
					$(this).find('td').eq(139).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(139).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .134').text()==""){	
					$('#faultyStatsWeek .134').addClass('d-none');
					$(this).find('td').eq(140).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(140).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .135').text()==""){	
					$('#faultyStatsWeek .135').addClass('d-none');
					$(this).find('td').eq(141).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(141).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .136').text()==""){	
					$('#faultyStatsWeek .136').addClass('d-none');
					$(this).find('td').eq(142).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(142).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .137').text()==""){	
					$('#faultyStatsWeek .137').addClass('d-none');
					$(this).find('td').eq(143).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(143).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .138').text()==""){	
					$('#faultyStatsWeek .138').addClass('d-none');
					$(this).find('td').eq(144).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(144).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .139').text()==""){	
					$('#faultyStatsWeek .139').addClass('d-none');
					$(this).find('td').eq(145).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(145).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .140').text()==""){	
					$('#faultyStatsWeek .140').addClass('d-none');
					$(this).find('td').eq(146).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(146).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .141').text()==""){	
					$('#faultyStatsWeek .141').addClass('d-none');
					$(this).find('td').eq(147).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(147).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .142').text()==""){	
					$('#faultyStatsWeek .142').addClass('d-none');
					$(this).find('td').eq(148).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(148).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .143').text()==""){	
					$('#faultyStatsWeek .143').addClass('d-none');
					$(this).find('td').eq(149).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(149).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .144').text()==""){	
					$('#faultyStatsWeek .144').addClass('d-none');
					$(this).find('td').eq(150).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(150).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .145').text()==""){	
					$('#faultyStatsWeek .145').addClass('d-none');
					$(this).find('td').eq(151).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(151).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .146').text()==""){	
					$('#faultyStatsWeek .146').addClass('d-none');
					$(this).find('td').eq(152).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(152).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .147').text()==""){	
					$('#faultyStatsWeek .147').addClass('d-none');
					$(this).find('td').eq(153).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(153).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .148').text()==""){	
					$('#faultyStatsWeek .148').addClass('d-none');
					$(this).find('td').eq(154).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(154).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .149').text()==""){	
					$('#faultyStatsWeek .149').addClass('d-none');
					$(this).find('td').eq(155).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(155).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .150').text()==""){	
					$('#faultyStatsWeek .150').addClass('d-none');
					$(this).find('td').eq(156).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(156).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .151').text()==""){	
					$('#faultyStatsWeek .151').addClass('d-none');
					$(this).find('td').eq(157).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(157).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .152').text()==""){	
					$('#faultyStatsWeek .152').addClass('d-none');
					$(this).find('td').eq(158).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(158).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .153').text()==""){	
					$('#faultyStatsWeek .153').addClass('d-none');
					$(this).find('td').eq(159).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(159).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .154').text()==""){	
					$('#faultyStatsWeek .154').addClass('d-none');
					$(this).find('td').eq(160).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(160).addClass('d-none');
					
				 }	
				if($('#faultyStatsWeek .155').text()==""){	
					$('#faultyStatsWeek .155').addClass('d-none');
					$(this).find('td').eq(161).addClass('d-none');
					$('#faultyStatsWeek tfoot tr').eq(0).find('td').eq(161).addClass('d-none');
					
				 }	
			 });


			 sumOutputCnt1 = $('#faultyStatsWeek').DataTable().column(1,{ page: 'all'} ).data().sum();
			 sumAppearOutputCnt1 = $('#faultyStatsWeek').DataTable().column(2,{ page: 'all'} ).data().sum();
			 sumFaulty1 = sumOutputCnt1 - sumAppearOutputCnt1;
			 sumFaultyPercent1 = 100 * sumFaulty1 / sumOutputCnt1;
			
			//let sumEdgeFaulty1 = showTypeChange($('#faultyStatsWeek').DataTable().column(5,{ page: 'all'} ).data().sum());
			let sumEdgeFaulty1		 = $('#faultyStatsWeek').DataTable().column(5,{ page: 'all'} ).data().sum();
			
			//$('#faultyStatsWeek').DataTable().column(5,{ page: 'all'} ).data().sum();
			let faulty1	 = showTypeChange($('#faultyStatsWeek').DataTable().column(6,{ page: 'all'} ).data().sum());
			let faulty2	 = showTypeChange($('#faultyStatsWeek').DataTable().column(7,{ page: 'all'} ).data().sum());
			let faulty3	 = showTypeChange($('#faultyStatsWeek').DataTable().column(8,{ page: 'all'} ).data().sum());
			let faulty4	 = showTypeChange($('#faultyStatsWeek').DataTable().column(9,{ page: 'all'} ).data().sum());
			let faulty5	 = showTypeChange($('#faultyStatsWeek').DataTable().column(10,{ page: 'all'} ).data().sum());
			let faulty6	 = showTypeChange($('#faultyStatsWeek').DataTable().column(11,{ page: 'all'} ).data().sum());
			let faulty7	 = showTypeChange($('#faultyStatsWeek').DataTable().column(12,{ page: 'all'} ).data().sum());
			let faulty8	 = showTypeChange($('#faultyStatsWeek').DataTable().column(13,{ page: 'all'} ).data().sum());
			let faulty9	 = showTypeChange($('#faultyStatsWeek').DataTable().column(14,{ page: 'all'} ).data().sum());
			let faulty10 = showTypeChange($('#faultyStatsWeek').DataTable().column(15,{ page: 'all'} ).data().sum());
			let faulty11 = showTypeChange($('#faultyStatsWeek').DataTable().column(16,{ page: 'all'} ).data().sum());
			let faulty12 = showTypeChange($('#faultyStatsWeek').DataTable().column(17,{ page: 'all'} ).data().sum());
			let faulty13 = showTypeChange($('#faultyStatsWeek').DataTable().column(18,{ page: 'all'} ).data().sum());
			let faulty14 = showTypeChange($('#faultyStatsWeek').DataTable().column(19,{ page: 'all'} ).data().sum());
			let faulty15 = showTypeChange($('#faultyStatsWeek').DataTable().column(20,{ page: 'all'} ).data().sum());
			let faulty16 = showTypeChange($('#faultyStatsWeek').DataTable().column(21,{ page: 'all'} ).data().sum());
			let faulty17 = showTypeChange($('#faultyStatsWeek').DataTable().column(22,{ page: 'all'} ).data().sum());
			let faulty18 = showTypeChange($('#faultyStatsWeek').DataTable().column(23,{ page: 'all'} ).data().sum());
			let faulty19 = showTypeChange($('#faultyStatsWeek').DataTable().column(24,{ page: 'all'} ).data().sum());
			let faulty20 = showTypeChange($('#faultyStatsWeek').DataTable().column(25,{ page: 'all'} ).data().sum());
			let faulty21 = showTypeChange($('#faultyStatsWeek').DataTable().column(26,{ page: 'all'} ).data().sum());
			let faulty22 = showTypeChange($('#faultyStatsWeek').DataTable().column(27,{ page: 'all'} ).data().sum());
			let faulty23 = showTypeChange($('#faultyStatsWeek').DataTable().column(28,{ page: 'all'} ).data().sum());
			let faulty24 = showTypeChange($('#faultyStatsWeek').DataTable().column(29,{ page: 'all'} ).data().sum());
			let faulty25 = showTypeChange($('#faultyStatsWeek').DataTable().column(30,{ page: 'all'} ).data().sum());
			let faulty26 = showTypeChange($('#faultyStatsWeek').DataTable().column(31,{ page: 'all'} ).data().sum());
			let faulty27 = showTypeChange($('#faultyStatsWeek').DataTable().column(32,{ page: 'all'} ).data().sum());
			let faulty28 = showTypeChange($('#faultyStatsWeek').DataTable().column(33,{ page: 'all'} ).data().sum());
			let faulty29 = showTypeChange($('#faultyStatsWeek').DataTable().column(34,{ page: 'all'} ).data().sum());
			let faulty30 = showTypeChange($('#faultyStatsWeek').DataTable().column(35,{ page: 'all'} ).data().sum());
			let faulty31 = showTypeChange($('#faultyStatsWeek').DataTable().column(36,{ page: 'all'} ).data().sum());
			let faulty32 = showTypeChange($('#faultyStatsWeek').DataTable().column(37,{ page: 'all'} ).data().sum());
			let faulty33 = showTypeChange($('#faultyStatsWeek').DataTable().column(38,{ page: 'all'} ).data().sum());
			let faulty34 = showTypeChange($('#faultyStatsWeek').DataTable().column(39,{ page: 'all'} ).data().sum());
			let faulty35 = showTypeChange($('#faultyStatsWeek').DataTable().column(40,{ page: 'all'} ).data().sum());
			let faulty36 = showTypeChange($('#faultyStatsWeek').DataTable().column(41,{ page: 'all'} ).data().sum());
			let faulty37 = showTypeChange($('#faultyStatsWeek').DataTable().column(42,{ page: 'all'} ).data().sum());
			let faulty38 = showTypeChange($('#faultyStatsWeek').DataTable().column(43,{ page: 'all'} ).data().sum());
			let faulty39 = showTypeChange($('#faultyStatsWeek').DataTable().column(44,{ page: 'all'} ).data().sum());
			let faulty40 = showTypeChange($('#faultyStatsWeek').DataTable().column(45,{ page: 'all'} ).data().sum());
			let faulty41 = showTypeChange($('#faultyStatsWeek').DataTable().column(46,{ page: 'all'} ).data().sum());
			let faulty42 = showTypeChange($('#faultyStatsWeek').DataTable().column(47,{ page: 'all'} ).data().sum());
			let faulty43 = showTypeChange($('#faultyStatsWeek').DataTable().column(48,{ page: 'all'} ).data().sum());
			let faulty44 = showTypeChange($('#faultyStatsWeek').DataTable().column(49,{ page: 'all'} ).data().sum());
			let faulty45 = showTypeChange($('#faultyStatsWeek').DataTable().column(50,{ page: 'all'} ).data().sum());
			let faulty46 = showTypeChange($('#faultyStatsWeek').DataTable().column(51,{ page: 'all'} ).data().sum());
			let faulty47 = showTypeChange($('#faultyStatsWeek').DataTable().column(52,{ page: 'all'} ).data().sum());
			let faulty48 = showTypeChange($('#faultyStatsWeek').DataTable().column(53,{ page: 'all'} ).data().sum());
			let faulty49 = showTypeChange($('#faultyStatsWeek').DataTable().column(54,{ page: 'all'} ).data().sum());
			let faulty50 = showTypeChange($('#faultyStatsWeek').DataTable().column(55,{ page: 'all'} ).data().sum());
			let faulty51 = showTypeChange($('#faultyStatsWeek').DataTable().column(56,{ page: 'all'} ).data().sum());
			let faulty52 = showTypeChange($('#faultyStatsWeek').DataTable().column(57,{ page: 'all'} ).data().sum());
			let faulty53 = showTypeChange($('#faultyStatsWeek').DataTable().column(58,{ page: 'all'} ).data().sum());
			let faulty54 = showTypeChange($('#faultyStatsWeek').DataTable().column(59,{ page: 'all'} ).data().sum());
			let faulty55 = showTypeChange($('#faultyStatsWeek').DataTable().column(60,{ page: 'all'} ).data().sum());
			let faulty56 = showTypeChange($('#faultyStatsWeek').DataTable().column(61,{ page: 'all'} ).data().sum());
			let faulty57 = showTypeChange($('#faultyStatsWeek').DataTable().column(62,{ page: 'all'} ).data().sum());
			let faulty58 = showTypeChange($('#faultyStatsWeek').DataTable().column(63,{ page: 'all'} ).data().sum());
			let faulty59 = showTypeChange($('#faultyStatsWeek').DataTable().column(64,{ page: 'all'} ).data().sum());
			let faulty60 = showTypeChange($('#faultyStatsWeek').DataTable().column(65,{ page: 'all'} ).data().sum());
			let faulty61 = showTypeChange($('#faultyStatsWeek').DataTable().column(66,{ page: 'all'} ).data().sum());
			let faulty62 = showTypeChange($('#faultyStatsWeek').DataTable().column(67,{ page: 'all'} ).data().sum());
			let faulty63 = showTypeChange($('#faultyStatsWeek').DataTable().column(68,{ page: 'all'} ).data().sum());
			let faulty64 = showTypeChange($('#faultyStatsWeek').DataTable().column(69,{ page: 'all'} ).data().sum());
			let faulty65 = showTypeChange($('#faultyStatsWeek').DataTable().column(70,{ page: 'all'} ).data().sum());
			let faulty66 = showTypeChange($('#faultyStatsWeek').DataTable().column(71,{ page: 'all'} ).data().sum());
			let faulty67 = showTypeChange($('#faultyStatsWeek').DataTable().column(72,{ page: 'all'} ).data().sum());
			let faulty68 = showTypeChange($('#faultyStatsWeek').DataTable().column(73,{ page: 'all'} ).data().sum());
			let faulty69 = showTypeChange($('#faultyStatsWeek').DataTable().column(74,{ page: 'all'} ).data().sum());
			let faulty70 = showTypeChange($('#faultyStatsWeek').DataTable().column(75,{ page: 'all'} ).data().sum());
			let faulty71 = showTypeChange($('#faultyStatsWeek').DataTable().column(76,{ page: 'all'} ).data().sum());
			let faulty72 = showTypeChange($('#faultyStatsWeek').DataTable().column(77,{ page: 'all'} ).data().sum());
			let faulty73 = showTypeChange($('#faultyStatsWeek').DataTable().column(78,{ page: 'all'} ).data().sum());
			let faulty74 = showTypeChange($('#faultyStatsWeek').DataTable().column(79,{ page: 'all'} ).data().sum());
			let faulty75 = showTypeChange($('#faultyStatsWeek').DataTable().column(80,{ page: 'all'} ).data().sum());
			let faulty76 = showTypeChange($('#faultyStatsWeek').DataTable().column(81,{ page: 'all'} ).data().sum());
			let faulty77 = showTypeChange($('#faultyStatsWeek').DataTable().column(82,{ page: 'all'} ).data().sum());
			let faulty78 = showTypeChange($('#faultyStatsWeek').DataTable().column(83,{ page: 'all'} ).data().sum());
			let faulty79 = showTypeChange($('#faultyStatsWeek').DataTable().column(84,{ page: 'all'} ).data().sum());
			let faulty80 = showTypeChange($('#faultyStatsWeek').DataTable().column(85,{ page: 'all'} ).data().sum());
			let faulty81 = showTypeChange($('#faultyStatsWeek').DataTable().column(86,{ page: 'all'} ).data().sum());
			let faulty82 = showTypeChange($('#faultyStatsWeek').DataTable().column(87,{ page: 'all'} ).data().sum());
			let faulty83 = showTypeChange($('#faultyStatsWeek').DataTable().column(88,{ page: 'all'} ).data().sum());
			let faulty84 = showTypeChange($('#faultyStatsWeek').DataTable().column(89,{ page: 'all'} ).data().sum());
			let faulty85 = showTypeChange($('#faultyStatsWeek').DataTable().column(90,{ page: 'all'} ).data().sum());
			let faulty86 = showTypeChange($('#faultyStatsWeek').DataTable().column(91,{ page: 'all'} ).data().sum());
			let faulty87 = showTypeChange($('#faultyStatsWeek').DataTable().column(92,{ page: 'all'} ).data().sum());
			let faulty88 = showTypeChange($('#faultyStatsWeek').DataTable().column(93,{ page: 'all'} ).data().sum());
			let faulty89 = showTypeChange($('#faultyStatsWeek').DataTable().column(94,{ page: 'all'} ).data().sum());
			let faulty90 = showTypeChange($('#faultyStatsWeek').DataTable().column(95,{ page: 'all'} ).data().sum());
			let faulty91 = showTypeChange($('#faultyStatsWeek').DataTable().column(96,{ page: 'all'} ).data().sum());
			let faulty92 = showTypeChange($('#faultyStatsWeek').DataTable().column(97,{ page: 'all'} ).data().sum());
			let faulty93 = showTypeChange($('#faultyStatsWeek').DataTable().column(98,{ page: 'all'} ).data().sum());
			let faulty94 = showTypeChange($('#faultyStatsWeek').DataTable().column(99,{ page: 'all'} ).data().sum());
			let faulty95 = showTypeChange($('#faultyStatsWeek').DataTable().column(100,{ page: 'all'} ).data().sum());
			let faulty96 = showTypeChange($('#faultyStatsWeek').DataTable().column(101,{ page: 'all'} ).data().sum());
			let faulty97 = showTypeChange($('#faultyStatsWeek').DataTable().column(102,{ page: 'all'} ).data().sum());
			let faulty98 = showTypeChange($('#faultyStatsWeek').DataTable().column(103,{ page: 'all'} ).data().sum());
			let faulty99 = showTypeChange($('#faultyStatsWeek').DataTable().column(104,{ page: 'all'} ).data().sum());
			let faulty100 = showTypeChange($('#faultyStatsWeek').DataTable().column(105,{ page: 'all'} ).data().sum());
			let faulty101 = showTypeChange($('#faultyStatsWeek').DataTable().column(106,{ page: 'all'} ).data().sum());
			let faulty102 = showTypeChange($('#faultyStatsWeek').DataTable().column(107,{ page: 'all'} ).data().sum());
			let faulty103 = showTypeChange($('#faultyStatsWeek').DataTable().column(108,{ page: 'all'} ).data().sum());
			let faulty104 = showTypeChange($('#faultyStatsWeek').DataTable().column(109,{ page: 'all'} ).data().sum());
			let faulty105 = showTypeChange($('#faultyStatsWeek').DataTable().column(110,{ page: 'all'} ).data().sum());
			let faulty106 = showTypeChange($('#faultyStatsWeek').DataTable().column(111,{ page: 'all'} ).data().sum());
			let faulty107 = showTypeChange($('#faultyStatsWeek').DataTable().column(112,{ page: 'all'} ).data().sum());
			let faulty108 = showTypeChange($('#faultyStatsWeek').DataTable().column(113,{ page: 'all'} ).data().sum());
			let faulty109 = showTypeChange($('#faultyStatsWeek').DataTable().column(114,{ page: 'all'} ).data().sum());
			let faulty110 = showTypeChange($('#faultyStatsWeek').DataTable().column(115,{ page: 'all'} ).data().sum());
			let faulty111 = showTypeChange($('#faultyStatsWeek').DataTable().column(116,{ page: 'all'} ).data().sum());
			let faulty112 = showTypeChange($('#faultyStatsWeek').DataTable().column(117,{ page: 'all'} ).data().sum());
			let faulty113 = showTypeChange($('#faultyStatsWeek').DataTable().column(118,{ page: 'all'} ).data().sum());
			let faulty114 = showTypeChange($('#faultyStatsWeek').DataTable().column(119,{ page: 'all'} ).data().sum());
			let faulty115 = showTypeChange($('#faultyStatsWeek').DataTable().column(120,{ page: 'all'} ).data().sum());
			let faulty116 = showTypeChange($('#faultyStatsWeek').DataTable().column(121,{ page: 'all'} ).data().sum());
			let faulty117 = showTypeChange($('#faultyStatsWeek').DataTable().column(122,{ page: 'all'} ).data().sum());
			let faulty118 = showTypeChange($('#faultyStatsWeek').DataTable().column(123,{ page: 'all'} ).data().sum());
			let faulty119 = showTypeChange($('#faultyStatsWeek').DataTable().column(124,{ page: 'all'} ).data().sum());
			let faulty120 = showTypeChange($('#faultyStatsWeek').DataTable().column(125,{ page: 'all'} ).data().sum());
			let faulty121 = showTypeChange($('#faultyStatsWeek').DataTable().column(126,{ page: 'all'} ).data().sum());
			let faulty122 = showTypeChange($('#faultyStatsWeek').DataTable().column(127,{ page: 'all'} ).data().sum());
			let faulty123 = showTypeChange($('#faultyStatsWeek').DataTable().column(128,{ page: 'all'} ).data().sum());
			let faulty124 = showTypeChange($('#faultyStatsWeek').DataTable().column(129,{ page: 'all'} ).data().sum());
			let faulty125 = showTypeChange($('#faultyStatsWeek').DataTable().column(130,{ page: 'all'} ).data().sum());
			let faulty126 = showTypeChange($('#faultyStatsWeek').DataTable().column(131,{ page: 'all'} ).data().sum());
			let faulty127 = showTypeChange($('#faultyStatsWeek').DataTable().column(132,{ page: 'all'} ).data().sum());
			let faulty128 = showTypeChange($('#faultyStatsWeek').DataTable().column(133,{ page: 'all'} ).data().sum());
			let faulty129 = showTypeChange($('#faultyStatsWeek').DataTable().column(134,{ page: 'all'} ).data().sum());
			let faulty130 = showTypeChange($('#faultyStatsWeek').DataTable().column(135,{ page: 'all'} ).data().sum());
			let faulty131 = showTypeChange($('#faultyStatsWeek').DataTable().column(136,{ page: 'all'} ).data().sum());
			let faulty132 = showTypeChange($('#faultyStatsWeek').DataTable().column(137,{ page: 'all'} ).data().sum());
			let faulty133 = showTypeChange($('#faultyStatsWeek').DataTable().column(138,{ page: 'all'} ).data().sum());
			let faulty134 = showTypeChange($('#faultyStatsWeek').DataTable().column(139,{ page: 'all'} ).data().sum());
			let faulty135 = showTypeChange($('#faultyStatsWeek').DataTable().column(140,{ page: 'all'} ).data().sum());
			let faulty136 = showTypeChange($('#faultyStatsWeek').DataTable().column(141,{ page: 'all'} ).data().sum());
			let faulty137 = showTypeChange($('#faultyStatsWeek').DataTable().column(142,{ page: 'all'} ).data().sum());
			let faulty138 = showTypeChange($('#faultyStatsWeek').DataTable().column(143,{ page: 'all'} ).data().sum());
			let faulty139 = showTypeChange($('#faultyStatsWeek').DataTable().column(144,{ page: 'all'} ).data().sum());
			let faulty140 = showTypeChange($('#faultyStatsWeek').DataTable().column(145,{ page: 'all'} ).data().sum());
            $('#sumOutputCnt1').html(addCommas(sumOutputCnt1));
            $('#sumAppearOutputCnt1').html(addCommas(sumAppearOutputCnt1));
            $('#sumFaulty1').html(addCommas(sumFaulty1));
            $('#sumFaultyPercent1').html(sumFaultyPercent1.toFixed(1) + "%");
            
            $('#sumEdgeFaulty1').html(addCommas(sumEdgeFaulty1));
            
            $('#weekFaulty1').html(addCommas(faulty1));
            $('#weekFaulty2').html(addCommas(faulty2));
            $('#weekFaulty3').html(addCommas(faulty3));
            $('#weekFaulty4').html(addCommas(faulty4));
            $('#weekFaulty5').html(addCommas(faulty5));
            $('#weekFaulty6').html(addCommas(faulty6));
            $('#weekFaulty7').html(addCommas(faulty7));
            $('#weekFaulty8').html(addCommas(faulty8));
            $('#weekFaulty9').html(addCommas(faulty9));
            $('#weekFaulty10').html(addCommas(faulty10));
            $('#weekFaulty11').html(addCommas(faulty11));
            $('#weekFaulty12').html(addCommas(faulty12));
            $('#weekFaulty13').html(addCommas(faulty13));
            $('#weekFaulty14').html(addCommas(faulty14));
            $('#weekFaulty15').html(addCommas(faulty15));
            $('#weekFaulty16').html(addCommas(faulty16));
            $('#weekFaulty17').html(addCommas(faulty17));
            $('#weekFaulty18').html(addCommas(faulty18));
            $('#weekFaulty19').html(addCommas(faulty19));
            $('#weekFaulty20').html(addCommas(faulty20));
            $('#weekFaulty21').html(addCommas(faulty21));
            $('#weekFaulty22').html(addCommas(faulty22));
            $('#weekFaulty23').html(addCommas(faulty23));
            $('#weekFaulty24').html(addCommas(faulty24));
            $('#weekFaulty25').html(addCommas(faulty25));
            $('#weekFaulty26').html(addCommas(faulty26));
            $('#weekFaulty27').html(addCommas(faulty27));
            $('#weekFaulty28').html(addCommas(faulty28));
            $('#weekFaulty29').html(addCommas(faulty29));
            $('#weekFaulty30').html(addCommas(faulty30));
            $('#weekFaulty31').html(addCommas(faulty31));
            $('#weekFaulty32').html(addCommas(faulty32));
            $('#weekFaulty33').html(addCommas(faulty33));
            $('#weekFaulty34').html(addCommas(faulty34));
            $('#weekFaulty35').html(addCommas(faulty35));
            $('#weekFaulty36').html(addCommas(faulty36));
            $('#weekFaulty37').html(addCommas(faulty37));
            $('#weekFaulty38').html(addCommas(faulty38));
            $('#weekFaulty39').html(addCommas(faulty39));
            $('#weekFaulty40').html(addCommas(faulty40));
            $('#weekFaulty41').html(addCommas(faulty41));
            $('#weekFaulty42').html(addCommas(faulty42));
            $('#weekFaulty43').html(addCommas(faulty43));
            $('#weekFaulty44').html(addCommas(faulty44));
            $('#weekFaulty45').html(addCommas(faulty45));
            $('#weekFaulty46').html(addCommas(faulty46));
            $('#weekFaulty47').html(addCommas(faulty47));
            $('#weekFaulty48').html(addCommas(faulty48));
            $('#weekFaulty49').html(addCommas(faulty49));
            $('#weekFaulty50').html(addCommas(faulty50));
            $('#weekFaulty51').html(addCommas(faulty51));
            $('#weekFaulty52').html(addCommas(faulty52));
            $('#weekFaulty53').html(addCommas(faulty53));
            $('#weekFaulty54').html(addCommas(faulty54));
            $('#weekFaulty55').html(addCommas(faulty55));
            $('#weekFaulty56').html(addCommas(faulty56));
            $('#weekFaulty57').html(addCommas(faulty57));
            $('#weekFaulty58').html(addCommas(faulty58));
            $('#weekFaulty59').html(addCommas(faulty59));
            $('#weekFaulty60').html(addCommas(faulty60));
            $('#weekFaulty61').html(addCommas(faulty61));
            $('#weekFaulty62').html(addCommas(faulty62));
            $('#weekFaulty63').html(addCommas(faulty63));
            $('#weekFaulty64').html(addCommas(faulty64));
            $('#weekFaulty65').html(addCommas(faulty65));
            $('#weekFaulty66').html(addCommas(faulty66));
            $('#weekFaulty67').html(addCommas(faulty67));
            $('#weekFaulty68').html(addCommas(faulty68));
            $('#weekFaulty69').html(addCommas(faulty69));
            $('#weekFaulty70').html(addCommas(faulty70));
            $('#weekFaulty71').html(addCommas(faulty71));
            $('#weekFaulty72').html(addCommas(faulty72));
            $('#weekFaulty73').html(addCommas(faulty73));
            $('#weekFaulty74').html(addCommas(faulty74));
            $('#weekFaulty75').html(addCommas(faulty75));
            $('#weekFaulty76').html(addCommas(faulty76));
            $('#weekFaulty77').html(addCommas(faulty77));
            $('#weekFaulty78').html(addCommas(faulty78));
            $('#weekFaulty79').html(addCommas(faulty79));
            $('#weekFaulty80').html(addCommas(faulty80));
            $('#weekFaulty81').html(addCommas(faulty81));
            $('#weekFaulty82').html(addCommas(faulty82));
            $('#weekFaulty83').html(addCommas(faulty83));
            $('#weekFaulty84').html(addCommas(faulty84));
            $('#weekFaulty85').html(addCommas(faulty85));
            $('#weekFaulty86').html(addCommas(faulty86));
            $('#weekFaulty87').html(addCommas(faulty87));
            $('#weekFaulty88').html(addCommas(faulty88));
            $('#weekFaulty89').html(addCommas(faulty89));
            $('#weekFaulty90').html(addCommas(faulty90));
            $('#weekFaulty91').html(addCommas(faulty91));
            $('#weekFaulty92').html(addCommas(faulty92));
            $('#weekFaulty93').html(addCommas(faulty93));
            $('#weekFaulty94').html(addCommas(faulty94));
            $('#weekFaulty95').html(addCommas(faulty95));
            $('#weekFaulty96').html(addCommas(faulty96));
            $('#weekFaulty97').html(addCommas(faulty97));
            $('#weekFaulty98').html(addCommas(faulty98));
            $('#weekFaulty99').html(addCommas(faulty99));
            $('#weekFaulty100').html(addCommas(faulty100));
            $('#weekFaulty101').html(addCommas(faulty101));
            $('#weekFaulty102').html(addCommas(faulty102));
            $('#weekFaulty103').html(addCommas(faulty103));
            $('#weekFaulty104').html(addCommas(faulty104));
            $('#weekFaulty105').html(addCommas(faulty105));
            $('#weekFaulty106').html(addCommas(faulty106));
            $('#weekFaulty107').html(addCommas(faulty107));
            $('#weekFaulty108').html(addCommas(faulty108));
            $('#weekFaulty109').html(addCommas(faulty109));
            $('#weekFaulty110').html(addCommas(faulty110));
            $('#weekFaulty111').html(addCommas(faulty111));
            $('#weekFaulty112').html(addCommas(faulty112));
            $('#weekFaulty113').html(addCommas(faulty113));
            $('#weekFaulty114').html(addCommas(faulty114));
            $('#weekFaulty115').html(addCommas(faulty115));
            $('#weekFaulty116').html(addCommas(faulty116));
            $('#weekFaulty117').html(addCommas(faulty117));
            $('#weekFaulty118').html(addCommas(faulty118));
            $('#weekFaulty119').html(addCommas(faulty119));
            $('#weekFaulty120').html(addCommas(faulty120));
            $('#weekFaulty121').html(addCommas(faulty121));
            $('#weekFaulty122').html(addCommas(faulty122));
            $('#weekFaulty123').html(addCommas(faulty123));
            $('#weekFaulty124').html(addCommas(faulty124));
            $('#weekFaulty125').html(addCommas(faulty125));
            $('#weekFaulty126').html(addCommas(faulty126));
            $('#weekFaulty127').html(addCommas(faulty127));
            $('#weekFaulty128').html(addCommas(faulty128));
            $('#weekFaulty129').html(addCommas(faulty129));
            $('#weekFaulty130').html(addCommas(faulty130));
            $('#weekFaulty131').html(addCommas(faulty131));
            $('#weekFaulty132').html(addCommas(faulty132));
            $('#weekFaulty133').html(addCommas(faulty133));
            $('#weekFaulty134').html(addCommas(faulty134));
            $('#weekFaulty135').html(addCommas(faulty135));
            $('#weekFaulty136').html(addCommas(faulty136));
            $('#weekFaulty137').html(addCommas(faulty137));
            $('#weekFaulty138').html(addCommas(faulty138));
            $('#weekFaulty139').html(addCommas(faulty139));
            $('#weekFaulty140').html(addCommas(faulty140));
        },
    });

    //var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
	//html1 += '<label class="input-label-sm">&nbsp;검사일</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarFromWeek" name="chooseCalendarFromWeek" />';
	//html1 += '<button onclick="fnPopUpCalendar(chooseCalendarFromWeek,chooseCalendarFromWeek,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarFromWeek" type="button">';
	//html1 += '<span class="oi oi-calendar"></span>';
	//html1 += '</button>'; 
	//html1 += '</div>';
	//html1 += '<div class="form-group input-sub m-0 row">';
	//html1 += '<label class="input-label-sm">&nbsp;&nbsp&nbsp~</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarWeek" name="chooseCalendarWeek" />';
	//html1 += '<button onclick="fnPopUpCalendar(chooseCalendarWeek,chooseCalendarWeek,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarWeek" type="button">';
	//html1 += '<span class="oi oi-calendar"></span>';
	//html1 += '</button>'; 
	//html1 += '</div>';
	//html1 += '&nbsp<button type="button" class="btn btn-primary" id="btnRetvWeek">조회</button></div>';

	$('#faultyStatsWeek_length').html("");
	//$('#faultyStatsWeek_length').html(html1);
	//$('#chooseCalendarFromWeek').val(serverDateFrom);
	//$('#chooseCalendarWeek').val(serverDate);

	// 제품별
	$.fn.dataTable.ext.errMode = 'none';
	let faultyStatsGoods = $('#faultyStatsGoods').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: true,
        searching: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/faultyGoodsTotalDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val().replace(/-/g, ''); },
	           	'chooseDate'		: 		function() { return $('#chooseDateTo').val().replace(/-/g, ''); },
            },
        },
        columns: [
        	{ data: 'goodsNm' },
        	{ data: 'userInputInspctCnt' },
        	{ data: 'appearOutputCnt' },
        	{ data: 'faultSum' },
			{ data: 'faultPercent',
				render: function(data, type, row) {
					return addCommas(data.toFixed(1)) + " %";
				}
			},
        	{ data: 'edgeFaultyCnt' },
        	{ data: 'faulty1',
        		render: function(data, type, row) {
            		if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
						}
					}
        		}
        	},
        ],
        columnDefs: [
        	{ targets: [0], className: 'text-center' }, 
        	{ targets: [1,2,3,  5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '최종검사집계(제품)',
            },
            {
				extend: 'excel',
				title: '불량집계현황(제품)',
				exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (showType == 'showType001') {
								if (row == 4) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 4) { return data.replace(" %", ""); }
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
                title: '최종검사집계(제품)',
            },
        ],
        drawCallback: function () {


			$.each($('#faultyStatsGoods tbody tr'),function(index,item){	
				
				if($('#faultyStatsGoods .0').text()==""){            	
					$('#faultyStatsGoods .0').addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(6).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .1').text()==""){	
					$('#faultyStatsGoods .1').addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(7).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .2').text()==""){	
					$('#faultyStatsGoods .2').addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(8).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .3').text()==""){	
					$('#faultyStatsGoods .3').addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(9).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .4').text()==""){	
					$('#faultyStatsGoods .4').addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(10).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .5').text()==""){	
					$('#faultyStatsGoods .5').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(11).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .6').text()==""){	
					$('#faultyStatsGoods .6').addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(12).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .7').text()==""){	
					$('#faultyStatsGoods .7').addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(13).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .8').text()==""){	
					$('#faultyStatsGoods .8').addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(14).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .9').text()==""){	
					$('#faultyStatsGoods .9').addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(15).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .10').text()==""){	
					$('#faultyStatsGoods .10').addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(16).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .11').text()==""){	
					$('#faultyStatsGoods .11').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(17).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .12').text()==""){	
					$('#faultyStatsGoods .12').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(18).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .13').text()==""){	
					$('#faultyStatsGoods .13').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(19).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .14').text()==""){	
					$('#faultyStatsGoods .14').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(20).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .15').text()==""){	
					$('#faultyStatsGoods .15').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(21).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .16').text()==""){	
					$('#faultyStatsGoods .16').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(22).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .17').text()==""){	
					$('#faultyStatsGoods .17').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(23).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .18').text()==""){	
					$('#faultyStatsGoods .18').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(24).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .19').text()==""){	
					$('#faultyStatsGoods .19').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(25).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .20').text()==""){	
					$('#faultyStatsGoods .20').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(26).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .21').text()==""){	
					$('#faultyStatsGoods .21').addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(27).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .22').text()==""){	
					$('#faultyStatsGoods .22').addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(28).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .23').text()==""){	
					$('#faultyStatsGoods .23').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(29).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .24').text()==""){	
					$('#faultyStatsGoods .24').addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(30).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .25').text()==""){	
					$('#faultyStatsGoods .25').addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(31).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .26').text()==""){	
					$('#faultyStatsGoods .26').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(32).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .27').text()==""){	
					$('#faultyStatsGoods .27').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(33).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .28').text()==""){	
					$('#faultyStatsGoods .28').addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(34).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .29').text()==""){	
					$('#faultyStatsGoods .29').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(35).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .30').text()==""){	
					$('#faultyStatsGoods .30').addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(36).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .31').text()==""){	
					$('#faultyStatsGoods .31').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(37).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .32').text()==""){	
					$('#faultyStatsGoods .32').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(38).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .33').text()==""){	
					$('#faultyStatsGoods .33').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(39).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .34').text()==""){	
					$('#faultyStatsGoods .34').addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(40).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .35').text()==""){	
					$('#faultyStatsGoods .35').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(41).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .36').text()==""){	
					$('#faultyStatsGoods .36').addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(42).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .37').text()==""){	
					$('#faultyStatsGoods .37').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(43).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .38').text()==""){	
					$('#faultyStatsGoods .38').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(44).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .39').text()==""){	
					$('#faultyStatsGoods .39').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(45).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .40').text()==""){	
					$('#faultyStatsGoods .40').addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(46).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .41').text()==""){	
					$('#faultyStatsGoods .41').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(47).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .42').text()==""){	
					$('#faultyStatsGoods .42').addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(48).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .43').text()==""){	
					$('#faultyStatsGoods .43').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(49).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .44').text()==""){	
					$('#faultyStatsGoods .44').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(50).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .45').text()==""){	
					$('#faultyStatsGoods .45').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(51).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .46').text()==""){	
					$('#faultyStatsGoods .46').addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(52).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .47').text()==""){	
					$('#faultyStatsGoods .47').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(53).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .48').text()==""){	
					$('#faultyStatsGoods .48').addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(54).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .49').text()==""){	
					$('#faultyStatsGoods .49').addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(55).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .50').text()==""){	
					$('#faultyStatsGoods .50').addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(56).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .51').text()==""){	
					$('#faultyStatsGoods .51').addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(57).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .52').text()==""){	
					$('#faultyStatsGoods .52').addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(58).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .53').text()==""){	
					$('#faultyStatsGoods .53').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(59).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .54').text()==""){	
					$('#faultyStatsGoods .54').addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(60).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .55').text()==""){	
					$('#faultyStatsGoods .55').addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(61).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .56').text()==""){	
					$('#faultyStatsGoods .56').addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(62).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .57').text()==""){	
					$('#faultyStatsGoods .57').addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(63).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .58').text()==""){	
					$('#faultyStatsGoods .58').addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(64).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .59').text()==""){	
					$('#faultyStatsGoods .59').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(65).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .60').text()==""){	
					$('#faultyStatsGoods .60').addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(66).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .61').text()==""){	
					$('#faultyStatsGoods .61').addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(67).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .62').text()==""){	
					$('#faultyStatsGoods .62').addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(68).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .63').text()==""){	
					$('#faultyStatsGoods .63').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(69).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .64').text()==""){	
					$('#faultyStatsGoods .64').addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(70).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .65').text()==""){	
					$('#faultyStatsGoods .65').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(71).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .66').text()==""){	
					$('#faultyStatsGoods .66').addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(72).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .67').text()==""){	
					$('#faultyStatsGoods .67').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(73).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .68').text()==""){	
					$('#faultyStatsGoods .68').addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(74).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .69').text()==""){	
					$('#faultyStatsGoods .69').addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(75).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .70').text()==""){	
					$('#faultyStatsGoods .70').addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(76).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .71').text()==""){	
					$('#faultyStatsGoods .71').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(77).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .72').text()==""){	
					$('#faultyStatsGoods .72').addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(78).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .73').text()==""){	
					$('#faultyStatsGoods .73').addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(79).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .74').text()==""){	
					$('#faultyStatsGoods .74').addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(80).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .75').text()==""){	
					$('#faultyStatsGoods .75').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(81).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .76').text()==""){	
					$('#faultyStatsGoods .76').addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(82).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .77').text()==""){	
					$('#faultyStatsGoods .77').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(83).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .78').text()==""){	
					$('#faultyStatsGoods .78').addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(84).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .79').text()==""){	
					$('#faultyStatsGoods .79').addClass('d-none');
					$(this).find('td').eq(85).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(85).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .80').text()==""){	
					$('#faultyStatsGoods .80').addClass('d-none');
					$(this).find('td').eq(86).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(86).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .81').text()==""){	
					$('#faultyStatsGoods .81').addClass('d-none');
					$(this).find('td').eq(87).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(87).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .82').text()==""){	
					$('#faultyStatsGoods .82').addClass('d-none');
					$(this).find('td').eq(88).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(88).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .83').text()==""){	
					$('#faultyStatsGoods .83').addClass('d-none');
					$(this).find('td').eq(89).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(89).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .84').text()==""){	
					$('#faultyStatsGoods .84').addClass('d-none');
					$(this).find('td').eq(90).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(90).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .85').text()==""){	
					$('#faultyStatsGoods .85').addClass('d-none');
					$(this).find('td').eq(91).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(91).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .86').text()==""){	
					$('#faultyStatsGoods .86').addClass('d-none');
					$(this).find('td').eq(92).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(92).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .87').text()==""){	
					$('#faultyStatsGoods .87').addClass('d-none');
					$(this).find('td').eq(93).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(93).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .88').text()==""){	
					$('#faultyStatsGoods .88').addClass('d-none');
					$(this).find('td').eq(94).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(94).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .89').text()==""){	
					$('#faultyStatsGoods .89').addClass('d-none');
					$(this).find('td').eq(95).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(95).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .90').text()==""){	
					$('#faultyStatsGoods .90').addClass('d-none');
					$(this).find('td').eq(96).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(96).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .91').text()==""){	
					$('#faultyStatsGoods .91').addClass('d-none');
					$(this).find('td').eq(97).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(97).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .92').text()==""){	
					$('#faultyStatsGoods .92').addClass('d-none');
					$(this).find('td').eq(98).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(98).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .93').text()==""){	
					$('#faultyStatsGoods .93').addClass('d-none');
					$(this).find('td').eq(99).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(99).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .94').text()==""){	
					$('#faultyStatsGoods .94').addClass('d-none');
					$(this).find('td').eq(100).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(100).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .95').text()==""){	
					$('#faultyStatsGoods .95').addClass('d-none');
					$(this).find('td').eq(101).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(101).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .96').text()==""){	
					$('#faultyStatsGoods .96').addClass('d-none');
					$(this).find('td').eq(102).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(102).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .97').text()==""){	
					$('#faultyStatsGoods .97').addClass('d-none');
					$(this).find('td').eq(103).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(103).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .98').text()==""){	
					$('#faultyStatsGoods .98').addClass('d-none');
					$(this).find('td').eq(104).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(104).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .99').text()==""){	
					$('#faultyStatsGoods .99').addClass('d-none');
					$(this).find('td').eq(105).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(105).addClass('d-none');
					
				 }		
				if($('#faultyStatsGoods .100').text()==""){	
					$('#faultyStatsGoods .100').addClass('d-none');
					$(this).find('td').eq(106).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(106).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .101').text()==""){	
					$('#faultyStatsGoods .101').addClass('d-none');
					$(this).find('td').eq(107).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(107).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .102').text()==""){	
					$('#faultyStatsGoods .102').addClass('d-none');
					$(this).find('td').eq(108).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(108).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .103').text()==""){	
					$('#faultyStatsGoods .103').addClass('d-none');
					$(this).find('td').eq(109).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(109).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .104').text()==""){	
					$('#faultyStatsGoods .104').addClass('d-none');
					$(this).find('td').eq(110).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(110).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .105').text()==""){	
					$('#faultyStatsGoods .105').addClass('d-none');
					$(this).find('td').eq(111).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(111).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .106').text()==""){	
					$('#faultyStatsGoods .106').addClass('d-none');
					$(this).find('td').eq(112).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(112).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .107').text()==""){	
					$('#faultyStatsGoods .107').addClass('d-none');
					$(this).find('td').eq(113).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(113).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .108').text()==""){	
					$('#faultyStatsGoods .108').addClass('d-none');
					$(this).find('td').eq(114).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(114).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .109').text()==""){	
					$('#faultyStatsGoods .109').addClass('d-none');
					$(this).find('td').eq(115).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(115).addClass('d-none');
					
				 }
				if($('#faultyStatsGoods .110').text()==""){	
					$('#faultyStatsGoods .110').addClass('d-none');
					$(this).find('td').eq(116).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(116).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .111').text()==""){	
					$('#faultyStatsGoods .111').addClass('d-none');
					$(this).find('td').eq(117).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(117).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .112').text()==""){	
					$('#faultyStatsGoods .112').addClass('d-none');
					$(this).find('td').eq(118).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(118).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .113').text()==""){	
					$('#faultyStatsGoods .113').addClass('d-none');
					$(this).find('td').eq(119).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(119).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .114').text()==""){	
					$('#faultyStatsGoods .114').addClass('d-none');
					$(this).find('td').eq(120).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(120).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .115').text()==""){	
					$('#faultyStatsGoods .115').addClass('d-none');
					$(this).find('td').eq(121).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(121).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .116').text()==""){	
					$('#faultyStatsGoods .116').addClass('d-none');
					$(this).find('td').eq(122).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(122).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .117').text()==""){	
					$('#faultyStatsGoods .117').addClass('d-none');
					$(this).find('td').eq(123).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(123).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .118').text()==""){	
					$('#faultyStatsGoods .118').addClass('d-none');
					$(this).find('td').eq(124).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(124).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .119').text()==""){	
					$('#faultyStatsGoods .119').addClass('d-none');
					$(this).find('td').eq(125).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(125).addClass('d-none');
					
				 }		
				if($('#faultyStatsGoods .120').text()==""){	
					$('#faultyStatsGoods .120').addClass('d-none');
					$(this).find('td').eq(126).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(126).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .121').text()==""){	
					$('#faultyStatsGoods .121').addClass('d-none');
					$(this).find('td').eq(127).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(127).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .122').text()==""){	
					$('#faultyStatsGoods .122').addClass('d-none');
					$(this).find('td').eq(128).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(128).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .123').text()==""){	
					$('#faultyStatsGoods .123').addClass('d-none');
					$(this).find('td').eq(129).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(129).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .124').text()==""){	
					$('#faultyStatsGoods .124').addClass('d-none');
					$(this).find('td').eq(130).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(130).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .125').text()==""){	
					$('#faultyStatsGoods .125').addClass('d-none');
					$(this).find('td').eq(131).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(131).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .126').text()==""){	
					$('#faultyStatsGoods .126').addClass('d-none');
					$(this).find('td').eq(132).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(132).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .127').text()==""){	
					$('#faultyStatsGoods .127').addClass('d-none');
					$(this).find('td').eq(133).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(133).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .128').text()==""){	
					$('#faultyStatsGoods .128').addClass('d-none');
					$(this).find('td').eq(134).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(134).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .129').text()==""){	
					$('#faultyStatsGoods .129').addClass('d-none');
					$(this).find('td').eq(135).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(135).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .130').text()==""){	
					$('#faultyStatsGoods .130').addClass('d-none');
					$(this).find('td').eq(136).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(136).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .131').text()==""){	
					$('#faultyStatsGoods .131').addClass('d-none');
					$(this).find('td').eq(137).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(137).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .132').text()==""){	
					$('#faultyStatsGoods .132').addClass('d-none');
					$(this).find('td').eq(138).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(138).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .133').text()==""){	
					$('#faultyStatsGoods .133').addClass('d-none');
					$(this).find('td').eq(139).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(139).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .134').text()==""){	
					$('#faultyStatsGoods .134').addClass('d-none');
					$(this).find('td').eq(140).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(140).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .135').text()==""){	
					$('#faultyStatsGoods .135').addClass('d-none');
					$(this).find('td').eq(141).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(141).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .136').text()==""){	
					$('#faultyStatsGoods .136').addClass('d-none');
					$(this).find('td').eq(142).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(142).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .137').text()==""){	
					$('#faultyStatsGoods .137').addClass('d-none');
					$(this).find('td').eq(143).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(143).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .138').text()==""){	
					$('#faultyStatsGoods .138').addClass('d-none');
					$(this).find('td').eq(144).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(144).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .139').text()==""){	
					$('#faultyStatsGoods .139').addClass('d-none');
					$(this).find('td').eq(145).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(145).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .140').text()==""){	
					$('#faultyStatsGoods .140').addClass('d-none');
					$(this).find('td').eq(146).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(146).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .141').text()==""){	
					$('#faultyStatsGoods .141').addClass('d-none');
					$(this).find('td').eq(147).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(147).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .142').text()==""){	
					$('#faultyStatsGoods .142').addClass('d-none');
					$(this).find('td').eq(148).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(148).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .143').text()==""){	
					$('#faultyStatsGoods .143').addClass('d-none');
					$(this).find('td').eq(149).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(149).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .144').text()==""){	
					$('#faultyStatsGoods .144').addClass('d-none');
					$(this).find('td').eq(150).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(150).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .145').text()==""){	
					$('#faultyStatsGoods .145').addClass('d-none');
					$(this).find('td').eq(151).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(151).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .146').text()==""){	
					$('#faultyStatsGoods .146').addClass('d-none');
					$(this).find('td').eq(152).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(152).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .147').text()==""){	
					$('#faultyStatsGoods .147').addClass('d-none');
					$(this).find('td').eq(153).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(153).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .148').text()==""){	
					$('#faultyStatsGoods .148').addClass('d-none');
					$(this).find('td').eq(154).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(154).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .149').text()==""){	
					$('#faultyStatsGoods .149').addClass('d-none');
					$(this).find('td').eq(155).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(155).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .150').text()==""){	
					$('#faultyStatsGoods .150').addClass('d-none');
					$(this).find('td').eq(156).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(156).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .151').text()==""){	
					$('#faultyStatsGoods .151').addClass('d-none');
					$(this).find('td').eq(157).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(157).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .152').text()==""){	
					$('#faultyStatsGoods .152').addClass('d-none');
					$(this).find('td').eq(158).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(158).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .153').text()==""){	
					$('#faultyStatsGoods .153').addClass('d-none');
					$(this).find('td').eq(159).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(159).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .154').text()==""){	
					$('#faultyStatsGoods .154').addClass('d-none');
					$(this).find('td').eq(160).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(160).addClass('d-none');
					
				 }	
				if($('#faultyStatsGoods .155').text()==""){	
					$('#faultyStatsGoods .155').addClass('d-none');
					$(this).find('td').eq(161).addClass('d-none');
					$('#faultyStatsGoods tfoot tr').eq(0).find('td').eq(161).addClass('d-none');
					
				 }
		

			 });

		
            
			 sumOutputCnt2 = $('#faultyStatsGoods').DataTable().column(1,{ page: 'all'} ).data().sum();
			 sumAppearOutputCnt2 = $('#faultyStatsGoods').DataTable().column(2,{ page: 'all'} ).data().sum();
			 sumFaulty2 = sumOutputCnt2 - sumAppearOutputCnt2;
			 sumFaultyPercent2 = 100 * sumFaulty2 / sumOutputCnt2;			
			let sumEdgeFaulty2 = $('#faultyStatsGoods').DataTable().column(5,{ page: 'all'} ).data().sum();
			
			let faulty1	 = showTypeChange($('#faultyStatsGoods').DataTable().column(6,{ page: 'all'} ).data().sum());
			let faulty2	 = showTypeChange($('#faultyStatsGoods').DataTable().column(7,{ page: 'all'} ).data().sum());
			let faulty3	 = showTypeChange($('#faultyStatsGoods').DataTable().column(8,{ page: 'all'} ).data().sum());
			let faulty4	 = showTypeChange($('#faultyStatsGoods').DataTable().column(9,{ page: 'all'} ).data().sum());
			let faulty5	 = showTypeChange($('#faultyStatsGoods').DataTable().column(10,{ page: 'all'} ).data().sum());
			let faulty6	 = showTypeChange($('#faultyStatsGoods').DataTable().column(11,{ page: 'all'} ).data().sum());
			let faulty7	 = showTypeChange($('#faultyStatsGoods').DataTable().column(12,{ page: 'all'} ).data().sum());
			let faulty8	 = showTypeChange($('#faultyStatsGoods').DataTable().column(13,{ page: 'all'} ).data().sum());
			let faulty9	 = showTypeChange($('#faultyStatsGoods').DataTable().column(14,{ page: 'all'} ).data().sum());
			let faulty10 = showTypeChange($('#faultyStatsGoods').DataTable().column(15,{ page: 'all'} ).data().sum());
			let faulty11 = showTypeChange($('#faultyStatsGoods').DataTable().column(16,{ page: 'all'} ).data().sum());
			let faulty12 = showTypeChange($('#faultyStatsGoods').DataTable().column(17,{ page: 'all'} ).data().sum());
			let faulty13 = showTypeChange($('#faultyStatsGoods').DataTable().column(18,{ page: 'all'} ).data().sum());
			let faulty14 = showTypeChange($('#faultyStatsGoods').DataTable().column(19,{ page: 'all'} ).data().sum());
			let faulty15 = showTypeChange($('#faultyStatsGoods').DataTable().column(20,{ page: 'all'} ).data().sum());
			let faulty16 = showTypeChange($('#faultyStatsGoods').DataTable().column(21,{ page: 'all'} ).data().sum());
			let faulty17 = showTypeChange($('#faultyStatsGoods').DataTable().column(22,{ page: 'all'} ).data().sum());
			let faulty18 = showTypeChange($('#faultyStatsGoods').DataTable().column(23,{ page: 'all'} ).data().sum());
			let faulty19 = showTypeChange($('#faultyStatsGoods').DataTable().column(24,{ page: 'all'} ).data().sum());
			let faulty20 = showTypeChange($('#faultyStatsGoods').DataTable().column(25,{ page: 'all'} ).data().sum());
			let faulty21 = showTypeChange($('#faultyStatsGoods').DataTable().column(26,{ page: 'all'} ).data().sum());
			let faulty22 = showTypeChange($('#faultyStatsGoods').DataTable().column(27,{ page: 'all'} ).data().sum());
			let faulty23 = showTypeChange($('#faultyStatsGoods').DataTable().column(28,{ page: 'all'} ).data().sum());
			let faulty24 = showTypeChange($('#faultyStatsGoods').DataTable().column(29,{ page: 'all'} ).data().sum());
			let faulty25 = showTypeChange($('#faultyStatsGoods').DataTable().column(30,{ page: 'all'} ).data().sum());
			let faulty26 = showTypeChange($('#faultyStatsGoods').DataTable().column(31,{ page: 'all'} ).data().sum());
			let faulty27 = showTypeChange($('#faultyStatsGoods').DataTable().column(32,{ page: 'all'} ).data().sum());
			let faulty28 = showTypeChange($('#faultyStatsGoods').DataTable().column(33,{ page: 'all'} ).data().sum());
			let faulty29 = showTypeChange($('#faultyStatsGoods').DataTable().column(34,{ page: 'all'} ).data().sum());
			let faulty30 = showTypeChange($('#faultyStatsGoods').DataTable().column(35,{ page: 'all'} ).data().sum());
			let faulty31 = showTypeChange($('#faultyStatsGoods').DataTable().column(36,{ page: 'all'} ).data().sum());
			let faulty32 = showTypeChange($('#faultyStatsGoods').DataTable().column(37,{ page: 'all'} ).data().sum());
			let faulty33 = showTypeChange($('#faultyStatsGoods').DataTable().column(38,{ page: 'all'} ).data().sum());
			let faulty34 = showTypeChange($('#faultyStatsGoods').DataTable().column(39,{ page: 'all'} ).data().sum());
			let faulty35 = showTypeChange($('#faultyStatsGoods').DataTable().column(40,{ page: 'all'} ).data().sum());
			let faulty36 = showTypeChange($('#faultyStatsGoods').DataTable().column(41,{ page: 'all'} ).data().sum());
			let faulty37 = showTypeChange($('#faultyStatsGoods').DataTable().column(42,{ page: 'all'} ).data().sum());
			let faulty38 = showTypeChange($('#faultyStatsGoods').DataTable().column(43,{ page: 'all'} ).data().sum());
			let faulty39 = showTypeChange($('#faultyStatsGoods').DataTable().column(44,{ page: 'all'} ).data().sum());
			let faulty40 = showTypeChange($('#faultyStatsGoods').DataTable().column(45,{ page: 'all'} ).data().sum());
			let faulty41 = showTypeChange($('#faultyStatsGoods').DataTable().column(46,{ page: 'all'} ).data().sum());
			let faulty42 = showTypeChange($('#faultyStatsGoods').DataTable().column(47,{ page: 'all'} ).data().sum());
			let faulty43 = showTypeChange($('#faultyStatsGoods').DataTable().column(48,{ page: 'all'} ).data().sum());
			let faulty44 = showTypeChange($('#faultyStatsGoods').DataTable().column(49,{ page: 'all'} ).data().sum());
			let faulty45 = showTypeChange($('#faultyStatsGoods').DataTable().column(50,{ page: 'all'} ).data().sum());
			let faulty46 = showTypeChange($('#faultyStatsGoods').DataTable().column(51,{ page: 'all'} ).data().sum());
			let faulty47 = showTypeChange($('#faultyStatsGoods').DataTable().column(52,{ page: 'all'} ).data().sum());
			let faulty48 = showTypeChange($('#faultyStatsGoods').DataTable().column(53,{ page: 'all'} ).data().sum());
			let faulty49 = showTypeChange($('#faultyStatsGoods').DataTable().column(54,{ page: 'all'} ).data().sum());
			let faulty50 = showTypeChange($('#faultyStatsGoods').DataTable().column(55,{ page: 'all'} ).data().sum());
			let faulty51 = showTypeChange($('#faultyStatsGoods').DataTable().column(56,{ page: 'all'} ).data().sum());
			let faulty52 = showTypeChange($('#faultyStatsGoods').DataTable().column(57,{ page: 'all'} ).data().sum());
			let faulty53 = showTypeChange($('#faultyStatsGoods').DataTable().column(58,{ page: 'all'} ).data().sum());
			let faulty54 = showTypeChange($('#faultyStatsGoods').DataTable().column(59,{ page: 'all'} ).data().sum());
			let faulty55 = showTypeChange($('#faultyStatsGoods').DataTable().column(60,{ page: 'all'} ).data().sum());
			let faulty56 = showTypeChange($('#faultyStatsGoods').DataTable().column(61,{ page: 'all'} ).data().sum());
			let faulty57 = showTypeChange($('#faultyStatsGoods').DataTable().column(62,{ page: 'all'} ).data().sum());
			let faulty58 = showTypeChange($('#faultyStatsGoods').DataTable().column(63,{ page: 'all'} ).data().sum());
			let faulty59 = showTypeChange($('#faultyStatsGoods').DataTable().column(64,{ page: 'all'} ).data().sum());
			let faulty60 = showTypeChange($('#faultyStatsGoods').DataTable().column(65,{ page: 'all'} ).data().sum());
			let faulty61 = showTypeChange($('#faultyStatsGoods').DataTable().column(66,{ page: 'all'} ).data().sum());
			let faulty62 = showTypeChange($('#faultyStatsGoods').DataTable().column(67,{ page: 'all'} ).data().sum());
			let faulty63 = showTypeChange($('#faultyStatsGoods').DataTable().column(68,{ page: 'all'} ).data().sum());
			let faulty64 = showTypeChange($('#faultyStatsGoods').DataTable().column(69,{ page: 'all'} ).data().sum());
			let faulty65 = showTypeChange($('#faultyStatsGoods').DataTable().column(70,{ page: 'all'} ).data().sum());
			let faulty66 = showTypeChange($('#faultyStatsGoods').DataTable().column(71,{ page: 'all'} ).data().sum());
			let faulty67 = showTypeChange($('#faultyStatsGoods').DataTable().column(72,{ page: 'all'} ).data().sum());
			let faulty68 = showTypeChange($('#faultyStatsGoods').DataTable().column(73,{ page: 'all'} ).data().sum());
			let faulty69 = showTypeChange($('#faultyStatsGoods').DataTable().column(74,{ page: 'all'} ).data().sum());
			let faulty70 = showTypeChange($('#faultyStatsGoods').DataTable().column(75,{ page: 'all'} ).data().sum());
			let faulty71 = showTypeChange($('#faultyStatsGoods').DataTable().column(76,{ page: 'all'} ).data().sum());
			let faulty72 = showTypeChange($('#faultyStatsGoods').DataTable().column(77,{ page: 'all'} ).data().sum());
			let faulty73 = showTypeChange($('#faultyStatsGoods').DataTable().column(78,{ page: 'all'} ).data().sum());
			let faulty74 = showTypeChange($('#faultyStatsGoods').DataTable().column(79,{ page: 'all'} ).data().sum());
			let faulty75 = showTypeChange($('#faultyStatsGoods').DataTable().column(80,{ page: 'all'} ).data().sum());
			let faulty76 = showTypeChange($('#faultyStatsGoods').DataTable().column(81,{ page: 'all'} ).data().sum());
			let faulty77 = showTypeChange($('#faultyStatsGoods').DataTable().column(82,{ page: 'all'} ).data().sum());
			let faulty78 = showTypeChange($('#faultyStatsGoods').DataTable().column(83,{ page: 'all'} ).data().sum());
			let faulty79 = showTypeChange($('#faultyStatsGoods').DataTable().column(84,{ page: 'all'} ).data().sum());
			let faulty80 = showTypeChange($('#faultyStatsGoods').DataTable().column(85,{ page: 'all'} ).data().sum());
			let faulty81 = showTypeChange($('#faultyStatsGoods').DataTable().column(86,{ page: 'all'} ).data().sum());
			let faulty82 = showTypeChange($('#faultyStatsGoods').DataTable().column(87,{ page: 'all'} ).data().sum());
			let faulty83 = showTypeChange($('#faultyStatsGoods').DataTable().column(88,{ page: 'all'} ).data().sum());
			let faulty84 = showTypeChange($('#faultyStatsGoods').DataTable().column(89,{ page: 'all'} ).data().sum());
			let faulty85 = showTypeChange($('#faultyStatsGoods').DataTable().column(90,{ page: 'all'} ).data().sum());
			let faulty86 = showTypeChange($('#faultyStatsGoods').DataTable().column(91,{ page: 'all'} ).data().sum());
			let faulty87 = showTypeChange($('#faultyStatsGoods').DataTable().column(92,{ page: 'all'} ).data().sum());
			let faulty88 = showTypeChange($('#faultyStatsGoods').DataTable().column(93,{ page: 'all'} ).data().sum());
			let faulty89 = showTypeChange($('#faultyStatsGoods').DataTable().column(94,{ page: 'all'} ).data().sum());
			let faulty90 = showTypeChange($('#faultyStatsGoods').DataTable().column(95,{ page: 'all'} ).data().sum());
			let faulty91 = showTypeChange($('#faultyStatsGoods').DataTable().column(96,{ page: 'all'} ).data().sum());
			let faulty92 = showTypeChange($('#faultyStatsGoods').DataTable().column(97,{ page: 'all'} ).data().sum());
			let faulty93 = showTypeChange($('#faultyStatsGoods').DataTable().column(98,{ page: 'all'} ).data().sum());
			let faulty94 = showTypeChange($('#faultyStatsGoods').DataTable().column(99,{ page: 'all'} ).data().sum());
			let faulty95 = showTypeChange($('#faultyStatsGoods').DataTable().column(100,{ page: 'all'} ).data().sum());
			let faulty96 = showTypeChange($('#faultyStatsGoods').DataTable().column(101,{ page: 'all'} ).data().sum());
			let faulty97 = showTypeChange($('#faultyStatsGoods').DataTable().column(102,{ page: 'all'} ).data().sum());
			let faulty98 = showTypeChange($('#faultyStatsGoods').DataTable().column(103,{ page: 'all'} ).data().sum());
			let faulty99 = showTypeChange($('#faultyStatsGoods').DataTable().column(104,{ page: 'all'} ).data().sum());
			let faulty100 = showTypeChange($('#faultyStatsGoods').DataTable().column(105,{ page: 'all'} ).data().sum());
			let faulty101 = showTypeChange($('#faultyStatsGoods').DataTable().column(106,{ page: 'all'} ).data().sum());
			let faulty102 = showTypeChange($('#faultyStatsGoods').DataTable().column(107,{ page: 'all'} ).data().sum());
			let faulty103 = showTypeChange($('#faultyStatsGoods').DataTable().column(108,{ page: 'all'} ).data().sum());
			let faulty104 = showTypeChange($('#faultyStatsGoods').DataTable().column(109,{ page: 'all'} ).data().sum());
			let faulty105 = showTypeChange($('#faultyStatsGoods').DataTable().column(110,{ page: 'all'} ).data().sum());
			let faulty106 = showTypeChange($('#faultyStatsGoods').DataTable().column(111,{ page: 'all'} ).data().sum());
			let faulty107 = showTypeChange($('#faultyStatsGoods').DataTable().column(112,{ page: 'all'} ).data().sum());
			let faulty108 = showTypeChange($('#faultyStatsGoods').DataTable().column(113,{ page: 'all'} ).data().sum());
			let faulty109 = showTypeChange($('#faultyStatsGoods').DataTable().column(114,{ page: 'all'} ).data().sum());
			let faulty110 = showTypeChange($('#faultyStatsGoods').DataTable().column(115,{ page: 'all'} ).data().sum());
			let faulty111 = showTypeChange($('#faultyStatsGoods').DataTable().column(116,{ page: 'all'} ).data().sum());
			let faulty112 = showTypeChange($('#faultyStatsGoods').DataTable().column(117,{ page: 'all'} ).data().sum());
			let faulty113 = showTypeChange($('#faultyStatsGoods').DataTable().column(118,{ page: 'all'} ).data().sum());
			let faulty114 = showTypeChange($('#faultyStatsGoods').DataTable().column(119,{ page: 'all'} ).data().sum());
			let faulty115 = showTypeChange($('#faultyStatsGoods').DataTable().column(120,{ page: 'all'} ).data().sum());
			let faulty116 = showTypeChange($('#faultyStatsGoods').DataTable().column(121,{ page: 'all'} ).data().sum());
			let faulty117 = showTypeChange($('#faultyStatsGoods').DataTable().column(122,{ page: 'all'} ).data().sum());
			let faulty118 = showTypeChange($('#faultyStatsGoods').DataTable().column(123,{ page: 'all'} ).data().sum());
			let faulty119 = showTypeChange($('#faultyStatsGoods').DataTable().column(124,{ page: 'all'} ).data().sum());
			let faulty120 = showTypeChange($('#faultyStatsGoods').DataTable().column(125,{ page: 'all'} ).data().sum());
			let faulty121 = showTypeChange($('#faultyStatsGoods').DataTable().column(126,{ page: 'all'} ).data().sum());
			let faulty122 = showTypeChange($('#faultyStatsGoods').DataTable().column(127,{ page: 'all'} ).data().sum());
			let faulty123 = showTypeChange($('#faultyStatsGoods').DataTable().column(128,{ page: 'all'} ).data().sum());
			let faulty124 = showTypeChange($('#faultyStatsGoods').DataTable().column(129,{ page: 'all'} ).data().sum());
			let faulty125 = showTypeChange($('#faultyStatsGoods').DataTable().column(130,{ page: 'all'} ).data().sum());
			let faulty126 = showTypeChange($('#faultyStatsGoods').DataTable().column(131,{ page: 'all'} ).data().sum());
			let faulty127 = showTypeChange($('#faultyStatsGoods').DataTable().column(132,{ page: 'all'} ).data().sum());
			let faulty128 = showTypeChange($('#faultyStatsGoods').DataTable().column(133,{ page: 'all'} ).data().sum());
			let faulty129 = showTypeChange($('#faultyStatsGoods').DataTable().column(134,{ page: 'all'} ).data().sum());
			let faulty130 = showTypeChange($('#faultyStatsGoods').DataTable().column(135,{ page: 'all'} ).data().sum());
			let faulty131 = showTypeChange($('#faultyStatsGoods').DataTable().column(136,{ page: 'all'} ).data().sum());
			let faulty132 = showTypeChange($('#faultyStatsGoods').DataTable().column(137,{ page: 'all'} ).data().sum());
			let faulty133 = showTypeChange($('#faultyStatsGoods').DataTable().column(138,{ page: 'all'} ).data().sum());
			let faulty134 = showTypeChange($('#faultyStatsGoods').DataTable().column(139,{ page: 'all'} ).data().sum());
			let faulty135 = showTypeChange($('#faultyStatsGoods').DataTable().column(140,{ page: 'all'} ).data().sum());
			let faulty136 = showTypeChange($('#faultyStatsGoods').DataTable().column(141,{ page: 'all'} ).data().sum());
			let faulty137 = showTypeChange($('#faultyStatsGoods').DataTable().column(142,{ page: 'all'} ).data().sum());
			let faulty138 = showTypeChange($('#faultyStatsGoods').DataTable().column(143,{ page: 'all'} ).data().sum());
			let faulty139 = showTypeChange($('#faultyStatsGoods').DataTable().column(144,{ page: 'all'} ).data().sum());
			let faulty140 = showTypeChange($('#faultyStatsGoods').DataTable().column(145,{ page: 'all'} ).data().sum());
            $('#sumOutputCnt2').html(addCommas(sumOutputCnt2));
            $('#sumAppearOutputCnt2').html(addCommas(sumAppearOutputCnt2));
            $('#sumFaulty2').html(addCommas(sumFaulty2));
            $('#sumFaultyPercent2').html(sumFaultyPercent2.toFixed(1) + "%");
            $('#sumEdgeFaulty2').html(addCommas(sumEdgeFaulty2));
            $('#goodsFaulty1').html(addCommas(faulty1));
            $('#goodsFaulty2').html(addCommas(faulty2));
            $('#goodsFaulty3').html(addCommas(faulty3));
            $('#goodsFaulty4').html(addCommas(faulty4));
            $('#goodsFaulty5').html(addCommas(faulty5));
            $('#goodsFaulty6').html(addCommas(faulty6));
            $('#goodsFaulty7').html(addCommas(faulty7));
            $('#goodsFaulty8').html(addCommas(faulty8));
            $('#goodsFaulty9').html(addCommas(faulty9));
            $('#goodsFaulty10').html(addCommas(faulty10));
            $('#goodsFaulty11').html(addCommas(faulty11));
            $('#goodsFaulty12').html(addCommas(faulty12));
            $('#goodsFaulty13').html(addCommas(faulty13));
            $('#goodsFaulty14').html(addCommas(faulty14));
            $('#goodsFaulty15').html(addCommas(faulty15));
            $('#goodsFaulty16').html(addCommas(faulty16));
            $('#goodsFaulty17').html(addCommas(faulty17));
            $('#goodsFaulty18').html(addCommas(faulty18));
            $('#goodsFaulty19').html(addCommas(faulty19));
            $('#goodsFaulty20').html(addCommas(faulty20));
            $('#goodsFaulty21').html(addCommas(faulty21));
            $('#goodsFaulty22').html(addCommas(faulty22));
            $('#goodsFaulty23').html(addCommas(faulty23));
            $('#goodsFaulty24').html(addCommas(faulty24));
            $('#goodsFaulty25').html(addCommas(faulty25));
            $('#goodsFaulty26').html(addCommas(faulty26));
            $('#goodsFaulty27').html(addCommas(faulty27));
            $('#goodsFaulty28').html(addCommas(faulty28));
            $('#goodsFaulty29').html(addCommas(faulty29));
            $('#goodsFaulty30').html(addCommas(faulty30));
            $('#goodsFaulty31').html(addCommas(faulty31));
            $('#goodsFaulty32').html(addCommas(faulty32));
            $('#goodsFaulty33').html(addCommas(faulty33));
            $('#goodsFaulty34').html(addCommas(faulty34));
            $('#goodsFaulty35').html(addCommas(faulty35));
            $('#goodsFaulty36').html(addCommas(faulty36));
            $('#goodsFaulty37').html(addCommas(faulty37));
            $('#goodsFaulty38').html(addCommas(faulty38));
            $('#goodsFaulty39').html(addCommas(faulty39));
            $('#goodsFaulty40').html(addCommas(faulty40));
            $('#goodsFaulty41').html(addCommas(faulty41));
            $('#goodsFaulty42').html(addCommas(faulty42));
            $('#goodsFaulty43').html(addCommas(faulty43));
            $('#goodsFaulty44').html(addCommas(faulty44));
            $('#goodsFaulty45').html(addCommas(faulty45));
            $('#goodsFaulty46').html(addCommas(faulty46));
            $('#goodsFaulty47').html(addCommas(faulty47));
            $('#goodsFaulty48').html(addCommas(faulty48));
            $('#goodsFaulty49').html(addCommas(faulty49));
            $('#goodsFaulty50').html(addCommas(faulty50));
            $('#goodsFaulty51').html(addCommas(faulty51));
            $('#goodsFaulty52').html(addCommas(faulty52));
            $('#goodsFaulty53').html(addCommas(faulty53));
            $('#goodsFaulty54').html(addCommas(faulty54));
            $('#goodsFaulty55').html(addCommas(faulty55));
            $('#goodsFaulty56').html(addCommas(faulty56));
            $('#goodsFaulty57').html(addCommas(faulty57));
            $('#goodsFaulty58').html(addCommas(faulty58));
            $('#goodsFaulty59').html(addCommas(faulty59));
            $('#goodsFaulty60').html(addCommas(faulty60));
            $('#goodsFaulty61').html(addCommas(faulty61));
            $('#goodsFaulty62').html(addCommas(faulty62));
            $('#goodsFaulty63').html(addCommas(faulty63));
            $('#goodsFaulty64').html(addCommas(faulty64));
            $('#goodsFaulty65').html(addCommas(faulty65));
            $('#goodsFaulty66').html(addCommas(faulty66));
            $('#goodsFaulty67').html(addCommas(faulty67));
            $('#goodsFaulty68').html(addCommas(faulty68));
            $('#goodsFaulty69').html(addCommas(faulty69));
            $('#goodsFaulty70').html(addCommas(faulty70));
            $('#goodsFaulty71').html(addCommas(faulty71));
            $('#goodsFaulty72').html(addCommas(faulty72));
            $('#goodsFaulty73').html(addCommas(faulty73));
            $('#goodsFaulty74').html(addCommas(faulty74));
            $('#goodsFaulty75').html(addCommas(faulty75));
            $('#goodsFaulty76').html(addCommas(faulty76));
            $('#goodsFaulty77').html(addCommas(faulty77));
            $('#goodsFaulty78').html(addCommas(faulty78));
            $('#goodsFaulty79').html(addCommas(faulty79));
            $('#goodsFaulty80').html(addCommas(faulty80));
            $('#goodsFaulty81').html(addCommas(faulty81));
            $('#goodsFaulty82').html(addCommas(faulty82));
            $('#goodsFaulty83').html(addCommas(faulty83));
            $('#goodsFaulty84').html(addCommas(faulty84));
            $('#goodsFaulty85').html(addCommas(faulty85));
            $('#goodsFaulty86').html(addCommas(faulty86));
            $('#goodsFaulty87').html(addCommas(faulty87));
            $('#goodsFaulty88').html(addCommas(faulty88));
            $('#goodsFaulty89').html(addCommas(faulty89));
            $('#goodsFaulty90').html(addCommas(faulty90));
            $('#goodsFaulty91').html(addCommas(faulty91));
            $('#goodsFaulty92').html(addCommas(faulty92));
            $('#goodsFaulty93').html(addCommas(faulty93));
            $('#goodsFaulty94').html(addCommas(faulty94));
            $('#goodsFaulty95').html(addCommas(faulty95));
            $('#goodsFaulty96').html(addCommas(faulty96));
            $('#goodsFaulty97').html(addCommas(faulty97));
            $('#goodsFaulty98').html(addCommas(faulty98));
            $('#goodsFaulty99').html(addCommas(faulty99));
            $('#goodsFaulty100').html(addCommas(faulty100));
            $('#goodsFaulty101').html(addCommas(faulty101));
            $('#goodsFaulty102').html(addCommas(faulty102));
            $('#goodsFaulty103').html(addCommas(faulty103));
            $('#goodsFaulty104').html(addCommas(faulty104));
            $('#goodsFaulty105').html(addCommas(faulty105));
            $('#goodsFaulty106').html(addCommas(faulty106));
            $('#goodsFaulty107').html(addCommas(faulty107));
            $('#goodsFaulty108').html(addCommas(faulty108));
            $('#goodsFaulty109').html(addCommas(faulty109));
            $('#goodsFaulty110').html(addCommas(faulty110));
            $('#goodsFaulty111').html(addCommas(faulty111));
            $('#goodsFaulty112').html(addCommas(faulty112));
            $('#goodsFaulty113').html(addCommas(faulty113));
            $('#goodsFaulty114').html(addCommas(faulty114));
            $('#goodsFaulty115').html(addCommas(faulty115));
            $('#goodsFaulty116').html(addCommas(faulty116));
            $('#goodsFaulty117').html(addCommas(faulty117));
            $('#goodsFaulty118').html(addCommas(faulty118));
            $('#goodsFaulty119').html(addCommas(faulty119));
            $('#goodsFaulty120').html(addCommas(faulty120));
            $('#goodsFaulty121').html(addCommas(faulty121));
            $('#goodsFaulty122').html(addCommas(faulty122));
            $('#goodsFaulty123').html(addCommas(faulty123));
            $('#goodsFaulty124').html(addCommas(faulty124));
            $('#goodsFaulty125').html(addCommas(faulty125));
            $('#goodsFaulty126').html(addCommas(faulty126));
            $('#goodsFaulty127').html(addCommas(faulty127));
            $('#goodsFaulty128').html(addCommas(faulty128));
            $('#goodsFaulty129').html(addCommas(faulty129));
            $('#goodsFaulty130').html(addCommas(faulty130));
            $('#goodsFaulty131').html(addCommas(faulty131));
            $('#goodsFaulty132').html(addCommas(faulty132));
            $('#goodsFaulty133').html(addCommas(faulty133));
            $('#goodsFaulty134').html(addCommas(faulty134));
            $('#goodsFaulty135').html(addCommas(faulty135));
            $('#goodsFaulty136').html(addCommas(faulty136));
            $('#goodsFaulty137').html(addCommas(faulty137));
            $('#goodsFaulty138').html(addCommas(faulty138));
            $('#goodsFaulty139').html(addCommas(faulty139));
            $('#goodsFaulty140').html(addCommas(faulty140));
        },
    });

    //var html2 = '<div class="row"><div class="form-group input-sub m-0 row">';
	//html2 += '<label class="input-label-sm">&nbsp;검사일</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarFromGoods" name="chooseCalendarFromGoods" />';
	//html2 += '<button onclick="fnPopUpCalendar(chooseCalendarFromGoods,chooseCalendarFromGoods,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarFromGoods" type="button">';
	//html2 += '<span class="oi oi-calendar"></span>';
	//html2 += '</button>'; 
	//html2 += '</div>';
	//html2 += '<div class="form-group input-sub m-0 row">';
	//html2 += '<label class="input-label-sm">&nbsp;&nbsp&nbsp~</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarGoods" name="chooseCalendarGoods" />';
	//html2 += '<button onclick="fnPopUpCalendar(chooseCalendarGoods,chooseCalendarGoods,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarGoods" type="button">';
	//html2 += '<span class="oi oi-calendar"></span>';
	//html2 += '</button>'; 
	//html2 += '</div>';
	//html2 += '&nbsp<button type="button" class="btn btn-primary" id="btnRetvGoods">조회</button></div>';
    
	$('#faultyStatsGoods_length').html("");
	//$('#faultyStatsGoods_length').html(html2);
	//$('#chooseCalendarFromGoods').val(serverDateFrom);
	//$('#chooseCalendarGoods').val(serverDate);

	// 유형별
	$.fn.dataTable.ext.errMode = 'none';
	let faultyStatsType = $('#faultyStatsType').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: true,
        searching: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/qm/faultyTypeTotalDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val().replace(/-/g, ''); },
	           	'chooseDate'		: 		function() { return $('#chooseDateTo').val().replace(/-/g, ''); },
            },
        },
        columns: [
        	{ data: 'userInputInspctCnt' },
        	{ data: 'totalEdgeFaultyCnt' },
        	{ data: 'edgeFaultyPercent',
				render: function(data, type, row) {
					return addCommas(data.toFixed(1)) + " %";
				}
			},
        	{ data: 'sumSurfaceFaulty' },
			{ data: 'surfaceFaultyPercent',
				render: function(data, type, row) {
					return addCommas(data.toFixed(1)) + " %";
				}
			},
			{ data: 'sumMetal' },
			{ data: 'metalPercent',
				render: function(data, type, row) {
					return addCommas(data.toFixed(1)) + " %";
				}
			},
			{ data: 'sumFillm' },
			{ data: 'filmPercent',
				render: function(data, type, row) {
					return addCommas(data.toFixed(1)) + " %";
				}
			},
		/* 	{ data: 'sumEtc' },
			{ data: 'etcPercent',
				render: function(data, type, row) {
					return data + " %";
				}
			}, */
        ],
        columnDefs: [
        	{ targets: [0,1,2,3,4,5,6,7,8], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [0,1,2,3,4,5,6,7,8], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '최종검사집계(유형)',
            },
            {
                extend: 'excel',
                title: '최종검사집계(유형)',
            },
            {
                extend: 'print',
                title: '최종검사집계(유형)',
            },
        ],
    });

    //var html3 = '<div class="row"><div class="form-group input-sub m-0 row">';
	//html3 += '<label class="input-label-sm">&nbsp;검사일</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarFromType" name="chooseCalendarFromType" />';
	//html3 += '<button onclick="fnPopUpCalendar(chooseCalendarFromType,chooseCalendarFromType,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarFromType" type="button">';
	//html3 += '<span class="oi oi-calendar"></span>';
	//html3 += '</button>'; 
	//html3 += '</div>';
	//html3 += '<div class="form-group input-sub m-0 row">';
	//html3 += '<label class="input-label-sm">&nbsp;&nbsp&nbsp~</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarType" name="chooseCalendarType" />';
	//html3 += '<button onclick="fnPopUpCalendar(chooseCalendarType,chooseCalendarType,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarType" type="button">';
	//html3 += '<span class="oi oi-calendar"></span>';
	//html3 += '</button>'; 
	//html3 += '</div>';
	//html3 += '&nbsp<button type="button" class="btn btn-primary" id="btnRetvType">조회</button></div>';
    
    $('#faultyStatsType_length').html("");
	//$('#faultyStatsType_length').html(html3);
	//$('#chooseCalendarFromType').val(serverDateFrom);
	//$('#chooseCalendarType').val(serverDate);

	// 설비별
	$.fn.dataTable.ext.errMode = 'none';
	let faultyEquipType = $('#faultyEquipType').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: true,
        searching: false,
        pageLength: 17,
        ajax: {
        	url: '<c:url value="/qm/faultyEquipTotalDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val().replace(/-/g, ''); },
	           	'chooseDate'		: 		function() { return $('#chooseDateTo').val().replace(/-/g, ''); },
            },
        },
        columns: [
        	{ data: 'equipNm' },
        	{ data: 'userInputInspctCnt' },
        	{ data: 'appearOutputCnt' },
        	{ data: 'faultSum' },
			{ data: 'faultPercent',
				render: function(data, type, row) {
					return addCommas(data.toFixed(1)) + " %";
				}
			},
        	{ data: 'edgeFaultyCnt' },
        	{ data: 'faulty1',
        		render: function(data, type, row) {
            		if(data == 'null'){
                		data = 0;
                	}
					if (showType == 'showType001') {
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
						return addCommas(data);
					} else if (showType == 'showType002') {
						let temp = parseFloat(data/row['userInputInspctCnt']) * 100;
						if (Number.isInteger(temp)){
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
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
							return addCommas(temp.toFixed(1))  + ' %';
						} else {
							return addCommas(temp.toFixed(1)) + ' %';
						}
					}
        		}
        	},
        ],
        columnDefs: [
        	{ targets: [0], className: 'text-center' }, 
        	{ targets: [1,2,3,  5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '최종검사집계(설비)',
            },
            {
				extend: 'excel',
				title: '불량집계현황(설비)',
				exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (showType == 'showType001') {
								if (row == 4) { return data.replace(" %", ""); }
								else { return data; }
							} else if (showType == 'showType002') {
								if (row == 4) { return data.replace(" %", ""); }
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
                title: '최종검사집계(설비)',
            },
        ],
        drawCallback: function () {
			$.each($('#faultyEquipType tbody tr'),function(index,item){	
				
				if($('#faultyEquipType .0').text()==""){            	
					$('#faultyEquipType .0').addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(6).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .1').text()==""){	
					$('#faultyEquipType .1').addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(7).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .2').text()==""){	
					$('#faultyEquipType .2').addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(8).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .3').text()==""){	
					$('#faultyEquipType .3').addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(9).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .4').text()==""){	
					$('#faultyEquipType .4').addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(10).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .5').text()==""){	
					$('#faultyEquipType .5').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(11).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .6').text()==""){	
					$('#faultyEquipType .6').addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(12).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .7').text()==""){	
					$('#faultyEquipType .7').addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(13).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .8').text()==""){	
					$('#faultyEquipType .8').addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(14).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .9').text()==""){	
					$('#faultyEquipType .9').addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(15).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .10').text()==""){	
					$('#faultyEquipType .10').addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(16).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .11').text()==""){	
					$('#faultyEquipType .11').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(17).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .12').text()==""){	
					$('#faultyEquipType .12').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(18).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .13').text()==""){	
					$('#faultyEquipType .13').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(19).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .14').text()==""){	
					$('#faultyEquipType .14').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(20).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .15').text()==""){	
					$('#faultyEquipType .15').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(21).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .16').text()==""){	
					$('#faultyEquipType .16').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(22).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .17').text()==""){	
					$('#faultyEquipType .17').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(23).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .18').text()==""){	
					$('#faultyEquipType .18').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(24).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .19').text()==""){	
					$('#faultyEquipType .19').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(25).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .20').text()==""){	
					$('#faultyEquipType .20').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(26).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .21').text()==""){	
					$('#faultyEquipType .21').addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(27).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .22').text()==""){	
					$('#faultyEquipType .22').addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(28).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .23').text()==""){	
					$('#faultyEquipType .23').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(29).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .24').text()==""){	
					$('#faultyEquipType .24').addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(30).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .25').text()==""){	
					$('#faultyEquipType .25').addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(31).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .26').text()==""){	
					$('#faultyEquipType .26').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(32).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .27').text()==""){	
					$('#faultyEquipType .27').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(33).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .28').text()==""){	
					$('#faultyEquipType .28').addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(34).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .29').text()==""){	
					$('#faultyEquipType .29').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(35).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .30').text()==""){	
					$('#faultyEquipType .30').addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(36).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .31').text()==""){	
					$('#faultyEquipType .31').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(37).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .32').text()==""){	
					$('#faultyEquipType .32').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(38).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .33').text()==""){	
					$('#faultyEquipType .33').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(39).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .34').text()==""){	
					$('#faultyEquipType .34').addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(40).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .35').text()==""){	
					$('#faultyEquipType .35').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(41).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .36').text()==""){	
					$('#faultyEquipType .36').addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(42).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .37').text()==""){	
					$('#faultyEquipType .37').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(43).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .38').text()==""){	
					$('#faultyEquipType .38').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(44).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .39').text()==""){	
					$('#faultyEquipType .39').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(45).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .40').text()==""){	
					$('#faultyEquipType .40').addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(46).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .41').text()==""){	
					$('#faultyEquipType .41').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(47).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .42').text()==""){	
					$('#faultyEquipType .42').addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(48).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .43').text()==""){	
					$('#faultyEquipType .43').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(49).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .44').text()==""){	
					$('#faultyEquipType .44').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(50).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .45').text()==""){	
					$('#faultyEquipType .45').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(51).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .46').text()==""){	
					$('#faultyEquipType .46').addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(52).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .47').text()==""){	
					$('#faultyEquipType .47').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(53).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .48').text()==""){	
					$('#faultyEquipType .48').addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(54).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .49').text()==""){	
					$('#faultyEquipType .49').addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(55).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .50').text()==""){	
					$('#faultyEquipType .50').addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(56).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .51').text()==""){	
					$('#faultyEquipType .51').addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(57).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .52').text()==""){	
					$('#faultyEquipType .52').addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(58).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .53').text()==""){	
					$('#faultyEquipType .53').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(59).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .54').text()==""){	
					$('#faultyEquipType .54').addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(60).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .55').text()==""){	
					$('#faultyEquipType .55').addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(61).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .56').text()==""){	
					$('#faultyEquipType .56').addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(62).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .57').text()==""){	
					$('#faultyEquipType .57').addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(63).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .58').text()==""){	
					$('#faultyEquipType .58').addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(64).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .59').text()==""){	
					$('#faultyEquipType .59').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(65).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .60').text()==""){	
					$('#faultyEquipType .60').addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(66).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .61').text()==""){	
					$('#faultyEquipType .61').addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(67).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .62').text()==""){	
					$('#faultyEquipType .62').addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(68).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .63').text()==""){	
					$('#faultyEquipType .63').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(69).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .64').text()==""){	
					$('#faultyEquipType .64').addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(70).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .65').text()==""){	
					$('#faultyEquipType .65').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(71).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .66').text()==""){	
					$('#faultyEquipType .66').addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(72).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .67').text()==""){	
					$('#faultyEquipType .67').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(73).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .68').text()==""){	
					$('#faultyEquipType .68').addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(74).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .69').text()==""){	
					$('#faultyEquipType .69').addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(75).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .70').text()==""){	
					$('#faultyEquipType .70').addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(76).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .71').text()==""){	
					$('#faultyEquipType .71').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(77).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .72').text()==""){	
					$('#faultyEquipType .72').addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(78).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .73').text()==""){	
					$('#faultyEquipType .73').addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(79).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .74').text()==""){	
					$('#faultyEquipType .74').addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(80).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .75').text()==""){	
					$('#faultyEquipType .75').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(81).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .76').text()==""){	
					$('#faultyEquipType .76').addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(82).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .77').text()==""){	
					$('#faultyEquipType .77').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(83).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .78').text()==""){	
					$('#faultyEquipType .78').addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(84).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .79').text()==""){	
					$('#faultyEquipType .79').addClass('d-none');
					$(this).find('td').eq(85).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(85).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .80').text()==""){	
					$('#faultyEquipType .80').addClass('d-none');
					$(this).find('td').eq(86).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(86).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .81').text()==""){	
					$('#faultyEquipType .81').addClass('d-none');
					$(this).find('td').eq(87).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(87).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .82').text()==""){	
					$('#faultyEquipType .82').addClass('d-none');
					$(this).find('td').eq(88).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(88).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .83').text()==""){	
					$('#faultyEquipType .83').addClass('d-none');
					$(this).find('td').eq(89).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(89).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .84').text()==""){	
					$('#faultyEquipType .84').addClass('d-none');
					$(this).find('td').eq(90).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(90).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .85').text()==""){	
					$('#faultyEquipType .85').addClass('d-none');
					$(this).find('td').eq(91).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(91).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .86').text()==""){	
					$('#faultyEquipType .86').addClass('d-none');
					$(this).find('td').eq(92).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(92).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .87').text()==""){	
					$('#faultyEquipType .87').addClass('d-none');
					$(this).find('td').eq(93).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(93).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .88').text()==""){	
					$('#faultyEquipType .88').addClass('d-none');
					$(this).find('td').eq(94).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(94).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .89').text()==""){	
					$('#faultyEquipType .89').addClass('d-none');
					$(this).find('td').eq(95).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(95).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .90').text()==""){	
					$('#faultyEquipType .90').addClass('d-none');
					$(this).find('td').eq(96).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(96).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .91').text()==""){	
					$('#faultyEquipType .91').addClass('d-none');
					$(this).find('td').eq(97).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(97).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .92').text()==""){	
					$('#faultyEquipType .92').addClass('d-none');
					$(this).find('td').eq(98).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(98).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .93').text()==""){	
					$('#faultyEquipType .93').addClass('d-none');
					$(this).find('td').eq(99).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(99).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .94').text()==""){	
					$('#faultyEquipType .94').addClass('d-none');
					$(this).find('td').eq(100).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(100).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .95').text()==""){	
					$('#faultyEquipType .95').addClass('d-none');
					$(this).find('td').eq(101).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(101).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .96').text()==""){	
					$('#faultyEquipType .96').addClass('d-none');
					$(this).find('td').eq(102).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(102).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .97').text()==""){	
					$('#faultyEquipType .97').addClass('d-none');
					$(this).find('td').eq(103).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(103).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .98').text()==""){	
					$('#faultyEquipType .98').addClass('d-none');
					$(this).find('td').eq(104).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(104).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .99').text()==""){	
					$('#faultyEquipType .99').addClass('d-none');
					$(this).find('td').eq(105).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(105).addClass('d-none');
					
				 }		
				if($('#faultyEquipType .100').text()==""){	
					$('#faultyEquipType .100').addClass('d-none');
					$(this).find('td').eq(106).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(106).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .101').text()==""){	
					$('#faultyEquipType .101').addClass('d-none');
					$(this).find('td').eq(107).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(107).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .102').text()==""){	
					$('#faultyEquipType .102').addClass('d-none');
					$(this).find('td').eq(108).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(108).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .103').text()==""){	
					$('#faultyEquipType .103').addClass('d-none');
					$(this).find('td').eq(109).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(109).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .104').text()==""){	
					$('#faultyEquipType .104').addClass('d-none');
					$(this).find('td').eq(110).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(110).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .105').text()==""){	
					$('#faultyEquipType .105').addClass('d-none');
					$(this).find('td').eq(111).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(111).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .106').text()==""){	
					$('#faultyEquipType .106').addClass('d-none');
					$(this).find('td').eq(112).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(112).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .107').text()==""){	
					$('#faultyEquipType .107').addClass('d-none');
					$(this).find('td').eq(113).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(113).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .108').text()==""){	
					$('#faultyEquipType .108').addClass('d-none');
					$(this).find('td').eq(114).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(114).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .109').text()==""){	
					$('#faultyEquipType .109').addClass('d-none');
					$(this).find('td').eq(115).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(115).addClass('d-none');
					
				 }
				if($('#faultyEquipType .110').text()==""){	
					$('#faultyEquipType .110').addClass('d-none');
					$(this).find('td').eq(116).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(116).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .111').text()==""){	
					$('#faultyEquipType .111').addClass('d-none');
					$(this).find('td').eq(117).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(117).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .112').text()==""){	
					$('#faultyEquipType .112').addClass('d-none');
					$(this).find('td').eq(118).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(118).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .113').text()==""){	
					$('#faultyEquipType .113').addClass('d-none');
					$(this).find('td').eq(119).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(119).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .114').text()==""){	
					$('#faultyEquipType .114').addClass('d-none');
					$(this).find('td').eq(120).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(120).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .115').text()==""){	
					$('#faultyEquipType .115').addClass('d-none');
					$(this).find('td').eq(121).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(121).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .116').text()==""){	
					$('#faultyEquipType .116').addClass('d-none');
					$(this).find('td').eq(122).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(122).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .117').text()==""){	
					$('#faultyEquipType .117').addClass('d-none');
					$(this).find('td').eq(123).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(123).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .118').text()==""){	
					$('#faultyEquipType .118').addClass('d-none');
					$(this).find('td').eq(124).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(124).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .119').text()==""){	
					$('#faultyEquipType .119').addClass('d-none');
					$(this).find('td').eq(125).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(125).addClass('d-none');
					
				 }		
				if($('#faultyEquipType .120').text()==""){	
					$('#faultyEquipType .120').addClass('d-none');
					$(this).find('td').eq(126).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(126).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .121').text()==""){	
					$('#faultyEquipType .121').addClass('d-none');
					$(this).find('td').eq(127).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(127).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .122').text()==""){	
					$('#faultyEquipType .122').addClass('d-none');
					$(this).find('td').eq(128).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(128).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .123').text()==""){	
					$('#faultyEquipType .123').addClass('d-none');
					$(this).find('td').eq(129).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(129).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .124').text()==""){	
					$('#faultyEquipType .124').addClass('d-none');
					$(this).find('td').eq(130).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(130).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .125').text()==""){	
					$('#faultyEquipType .125').addClass('d-none');
					$(this).find('td').eq(131).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(131).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .126').text()==""){	
					$('#faultyEquipType .126').addClass('d-none');
					$(this).find('td').eq(132).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(132).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .127').text()==""){	
					$('#faultyEquipType .127').addClass('d-none');
					$(this).find('td').eq(133).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(133).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .128').text()==""){	
					$('#faultyEquipType .128').addClass('d-none');
					$(this).find('td').eq(134).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(134).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .129').text()==""){	
					$('#faultyEquipType .129').addClass('d-none');
					$(this).find('td').eq(135).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(135).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .130').text()==""){	
					$('#faultyEquipType .130').addClass('d-none');
					$(this).find('td').eq(136).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(136).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .131').text()==""){	
					$('#faultyEquipType .131').addClass('d-none');
					$(this).find('td').eq(137).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(137).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .132').text()==""){	
					$('#faultyEquipType .132').addClass('d-none');
					$(this).find('td').eq(138).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(138).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .133').text()==""){	
					$('#faultyEquipType .133').addClass('d-none');
					$(this).find('td').eq(139).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(139).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .134').text()==""){	
					$('#faultyEquipType .134').addClass('d-none');
					$(this).find('td').eq(140).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(140).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .135').text()==""){	
					$('#faultyEquipType .135').addClass('d-none');
					$(this).find('td').eq(141).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(141).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .136').text()==""){	
					$('#faultyEquipType .136').addClass('d-none');
					$(this).find('td').eq(142).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(142).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .137').text()==""){	
					$('#faultyEquipType .137').addClass('d-none');
					$(this).find('td').eq(143).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(143).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .138').text()==""){	
					$('#faultyEquipType .138').addClass('d-none');
					$(this).find('td').eq(144).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(144).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .139').text()==""){	
					$('#faultyEquipType .139').addClass('d-none');
					$(this).find('td').eq(145).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(145).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .140').text()==""){	
					$('#faultyEquipType .140').addClass('d-none');
					$(this).find('td').eq(146).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(146).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .141').text()==""){	
					$('#faultyEquipType .141').addClass('d-none');
					$(this).find('td').eq(147).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(147).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .142').text()==""){	
					$('#faultyEquipType .142').addClass('d-none');
					$(this).find('td').eq(148).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(148).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .143').text()==""){	
					$('#faultyEquipType .143').addClass('d-none');
					$(this).find('td').eq(149).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(149).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .144').text()==""){	
					$('#faultyEquipType .144').addClass('d-none');
					$(this).find('td').eq(150).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(150).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .145').text()==""){	
					$('#faultyEquipType .145').addClass('d-none');
					$(this).find('td').eq(151).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(151).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .146').text()==""){	
					$('#faultyEquipType .146').addClass('d-none');
					$(this).find('td').eq(152).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(152).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .147').text()==""){	
					$('#faultyEquipType .147').addClass('d-none');
					$(this).find('td').eq(153).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(153).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .148').text()==""){	
					$('#faultyEquipType .148').addClass('d-none');
					$(this).find('td').eq(154).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(154).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .149').text()==""){	
					$('#faultyEquipType .149').addClass('d-none');
					$(this).find('td').eq(155).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(155).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .150').text()==""){	
					$('#faultyEquipType .150').addClass('d-none');
					$(this).find('td').eq(156).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(156).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .151').text()==""){	
					$('#faultyEquipType .151').addClass('d-none');
					$(this).find('td').eq(157).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(157).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .152').text()==""){	
					$('#faultyEquipType .152').addClass('d-none');
					$(this).find('td').eq(158).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(158).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .153').text()==""){	
					$('#faultyEquipType .153').addClass('d-none');
					$(this).find('td').eq(159).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(159).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .154').text()==""){	
					$('#faultyEquipType .154').addClass('d-none');
					$(this).find('td').eq(160).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(160).addClass('d-none');
					
				 }	
				if($('#faultyEquipType .155').text()==""){	
					$('#faultyEquipType .155').addClass('d-none');
					$(this).find('td').eq(161).addClass('d-none');
					$('#faultyEquipType tfoot tr').eq(0).find('td').eq(161).addClass('d-none');
					
				 }

			 });

			
	


            
			 sumOutputCnt3 = $('#faultyEquipType').DataTable().column(1,{ page: 'all'} ).data().sum();
			 sumAppearOutputCnt3 = $('#faultyEquipType').DataTable().column(2,{ page: 'all'} ).data().sum();
			 sumFaulty3 = sumOutputCnt3 - sumAppearOutputCnt3;
			 sumFaultyPercent3 = 100 * sumFaulty3 / sumOutputCnt3;
			
			let sumEdgeFaulty3 =     $('#faultyEquipType').DataTable().column(5,{ page: 'all'} ).data().sum();
			let faulty1	 = showTypeChange($('#faultyEquipType').DataTable().column(6,{ page: 'all'} ).data().sum());
			let faulty2	 = showTypeChange($('#faultyEquipType').DataTable().column(7,{ page: 'all'} ).data().sum());
			let faulty3	 = showTypeChange($('#faultyEquipType').DataTable().column(8,{ page: 'all'} ).data().sum());
			let faulty4	 = showTypeChange($('#faultyEquipType').DataTable().column(9,{ page: 'all'} ).data().sum());
			let faulty5	 = showTypeChange($('#faultyEquipType').DataTable().column(10,{ page: 'all'} ).data().sum());
			let faulty6	 = showTypeChange($('#faultyEquipType').DataTable().column(11,{ page: 'all'} ).data().sum());
			let faulty7	 = showTypeChange($('#faultyEquipType').DataTable().column(12,{ page: 'all'} ).data().sum());
			let faulty8	 = showTypeChange($('#faultyEquipType').DataTable().column(13,{ page: 'all'} ).data().sum());
			let faulty9	 = showTypeChange($('#faultyEquipType').DataTable().column(14,{ page: 'all'} ).data().sum());
			let faulty10 = showTypeChange($('#faultyEquipType').DataTable().column(15,{ page: 'all'} ).data().sum());
			let faulty11 = showTypeChange($('#faultyEquipType').DataTable().column(16,{ page: 'all'} ).data().sum());
			let faulty12 = showTypeChange($('#faultyEquipType').DataTable().column(17,{ page: 'all'} ).data().sum());
			let faulty13 = showTypeChange($('#faultyEquipType').DataTable().column(18,{ page: 'all'} ).data().sum());
			let faulty14 = showTypeChange($('#faultyEquipType').DataTable().column(19,{ page: 'all'} ).data().sum());
			let faulty15 = showTypeChange($('#faultyEquipType').DataTable().column(20,{ page: 'all'} ).data().sum());
			let faulty16 = showTypeChange($('#faultyEquipType').DataTable().column(21,{ page: 'all'} ).data().sum());
			let faulty17 = showTypeChange($('#faultyEquipType').DataTable().column(22,{ page: 'all'} ).data().sum());
			let faulty18 = showTypeChange($('#faultyEquipType').DataTable().column(23,{ page: 'all'} ).data().sum());
			let faulty19 = showTypeChange($('#faultyEquipType').DataTable().column(24,{ page: 'all'} ).data().sum());
			let faulty20 = showTypeChange($('#faultyEquipType').DataTable().column(25,{ page: 'all'} ).data().sum());
			let faulty21 = showTypeChange($('#faultyEquipType').DataTable().column(26,{ page: 'all'} ).data().sum());
			let faulty22 = showTypeChange($('#faultyEquipType').DataTable().column(27,{ page: 'all'} ).data().sum());
			let faulty23 = showTypeChange($('#faultyEquipType').DataTable().column(28,{ page: 'all'} ).data().sum());
			let faulty24 = showTypeChange($('#faultyEquipType').DataTable().column(29,{ page: 'all'} ).data().sum());
			let faulty25 = showTypeChange($('#faultyEquipType').DataTable().column(30,{ page: 'all'} ).data().sum());
			let faulty26 = showTypeChange($('#faultyEquipType').DataTable().column(31,{ page: 'all'} ).data().sum());
			let faulty27 = showTypeChange($('#faultyEquipType').DataTable().column(32,{ page: 'all'} ).data().sum());
			let faulty28 = showTypeChange($('#faultyEquipType').DataTable().column(33,{ page: 'all'} ).data().sum());
			let faulty29 = showTypeChange($('#faultyEquipType').DataTable().column(34,{ page: 'all'} ).data().sum());
			let faulty30 = showTypeChange($('#faultyEquipType').DataTable().column(35,{ page: 'all'} ).data().sum());
			let faulty31 = showTypeChange($('#faultyEquipType').DataTable().column(36,{ page: 'all'} ).data().sum());
			let faulty32 = showTypeChange($('#faultyEquipType').DataTable().column(37,{ page: 'all'} ).data().sum());
			let faulty33 = showTypeChange($('#faultyEquipType').DataTable().column(38,{ page: 'all'} ).data().sum());
			let faulty34 = showTypeChange($('#faultyEquipType').DataTable().column(39,{ page: 'all'} ).data().sum());
			let faulty35 = showTypeChange($('#faultyEquipType').DataTable().column(40,{ page: 'all'} ).data().sum());
			let faulty36 = showTypeChange($('#faultyEquipType').DataTable().column(41,{ page: 'all'} ).data().sum());
			let faulty37 = showTypeChange($('#faultyEquipType').DataTable().column(42,{ page: 'all'} ).data().sum());
			let faulty38 = showTypeChange($('#faultyEquipType').DataTable().column(43,{ page: 'all'} ).data().sum());
			let faulty39 = showTypeChange($('#faultyEquipType').DataTable().column(44,{ page: 'all'} ).data().sum());
			let faulty40 = showTypeChange($('#faultyEquipType').DataTable().column(45,{ page: 'all'} ).data().sum());
			let faulty41 = showTypeChange($('#faultyEquipType').DataTable().column(46,{ page: 'all'} ).data().sum());
			let faulty42 = showTypeChange($('#faultyEquipType').DataTable().column(47,{ page: 'all'} ).data().sum());
			let faulty43 = showTypeChange($('#faultyEquipType').DataTable().column(48,{ page: 'all'} ).data().sum());
			let faulty44 = showTypeChange($('#faultyEquipType').DataTable().column(49,{ page: 'all'} ).data().sum());
			let faulty45 = showTypeChange($('#faultyEquipType').DataTable().column(50,{ page: 'all'} ).data().sum());
			let faulty46 = showTypeChange($('#faultyEquipType').DataTable().column(51,{ page: 'all'} ).data().sum());
			let faulty47 = showTypeChange($('#faultyEquipType').DataTable().column(52,{ page: 'all'} ).data().sum());
			let faulty48 = showTypeChange($('#faultyEquipType').DataTable().column(53,{ page: 'all'} ).data().sum());
			let faulty49 = showTypeChange($('#faultyEquipType').DataTable().column(54,{ page: 'all'} ).data().sum());
			let faulty50 = showTypeChange($('#faultyEquipType').DataTable().column(55,{ page: 'all'} ).data().sum());
			let faulty51 = showTypeChange($('#faultyEquipType').DataTable().column(56,{ page: 'all'} ).data().sum());
			let faulty52 = showTypeChange($('#faultyEquipType').DataTable().column(57,{ page: 'all'} ).data().sum());
			let faulty53 = showTypeChange($('#faultyEquipType').DataTable().column(58,{ page: 'all'} ).data().sum());
			let faulty54 = showTypeChange($('#faultyEquipType').DataTable().column(59,{ page: 'all'} ).data().sum());
			let faulty55 = showTypeChange($('#faultyEquipType').DataTable().column(60,{ page: 'all'} ).data().sum());
			let faulty56 = showTypeChange($('#faultyEquipType').DataTable().column(61,{ page: 'all'} ).data().sum());
			let faulty57 = showTypeChange($('#faultyEquipType').DataTable().column(62,{ page: 'all'} ).data().sum());
			let faulty58 = showTypeChange($('#faultyEquipType').DataTable().column(63,{ page: 'all'} ).data().sum());
			let faulty59 = showTypeChange($('#faultyEquipType').DataTable().column(64,{ page: 'all'} ).data().sum());
			let faulty60 = showTypeChange($('#faultyEquipType').DataTable().column(65,{ page: 'all'} ).data().sum());
			let faulty61 = showTypeChange($('#faultyEquipType').DataTable().column(66,{ page: 'all'} ).data().sum());
			let faulty62 = showTypeChange($('#faultyEquipType').DataTable().column(67,{ page: 'all'} ).data().sum());
			let faulty63 = showTypeChange($('#faultyEquipType').DataTable().column(68,{ page: 'all'} ).data().sum());
			let faulty64 = showTypeChange($('#faultyEquipType').DataTable().column(69,{ page: 'all'} ).data().sum());
			let faulty65 = showTypeChange($('#faultyEquipType').DataTable().column(70,{ page: 'all'} ).data().sum());
			let faulty66 = showTypeChange($('#faultyEquipType').DataTable().column(71,{ page: 'all'} ).data().sum());
			let faulty67 = showTypeChange($('#faultyEquipType').DataTable().column(72,{ page: 'all'} ).data().sum());
			let faulty68 = showTypeChange($('#faultyEquipType').DataTable().column(73,{ page: 'all'} ).data().sum());
			let faulty69 = showTypeChange($('#faultyEquipType').DataTable().column(74,{ page: 'all'} ).data().sum());
			let faulty70 = showTypeChange($('#faultyEquipType').DataTable().column(75,{ page: 'all'} ).data().sum());
			let faulty71 = showTypeChange($('#faultyEquipType').DataTable().column(76,{ page: 'all'} ).data().sum());
			let faulty72 = showTypeChange($('#faultyEquipType').DataTable().column(77,{ page: 'all'} ).data().sum());
			let faulty73 = showTypeChange($('#faultyEquipType').DataTable().column(78,{ page: 'all'} ).data().sum());
			let faulty74 = showTypeChange($('#faultyEquipType').DataTable().column(79,{ page: 'all'} ).data().sum());
			let faulty75 = showTypeChange($('#faultyEquipType').DataTable().column(80,{ page: 'all'} ).data().sum());
			let faulty76 = showTypeChange($('#faultyEquipType').DataTable().column(81,{ page: 'all'} ).data().sum());
			let faulty77 = showTypeChange($('#faultyEquipType').DataTable().column(82,{ page: 'all'} ).data().sum());
			let faulty78 = showTypeChange($('#faultyEquipType').DataTable().column(83,{ page: 'all'} ).data().sum());
			let faulty79 = showTypeChange($('#faultyEquipType').DataTable().column(84,{ page: 'all'} ).data().sum());
			let faulty80 = showTypeChange($('#faultyEquipType').DataTable().column(85,{ page: 'all'} ).data().sum());
			let faulty81 = showTypeChange($('#faultyEquipType').DataTable().column(86,{ page: 'all'} ).data().sum());
			let faulty82 = showTypeChange($('#faultyEquipType').DataTable().column(87,{ page: 'all'} ).data().sum());
			let faulty83 = showTypeChange($('#faultyEquipType').DataTable().column(88,{ page: 'all'} ).data().sum());
			let faulty84 = showTypeChange($('#faultyEquipType').DataTable().column(89,{ page: 'all'} ).data().sum());
			let faulty85 = showTypeChange($('#faultyEquipType').DataTable().column(90,{ page: 'all'} ).data().sum());
			let faulty86 = showTypeChange($('#faultyEquipType').DataTable().column(91,{ page: 'all'} ).data().sum());
			let faulty87 = showTypeChange($('#faultyEquipType').DataTable().column(92,{ page: 'all'} ).data().sum());
			let faulty88 = showTypeChange($('#faultyEquipType').DataTable().column(93,{ page: 'all'} ).data().sum());
			let faulty89 = showTypeChange($('#faultyEquipType').DataTable().column(94,{ page: 'all'} ).data().sum());
			let faulty90 = showTypeChange($('#faultyEquipType').DataTable().column(95,{ page: 'all'} ).data().sum());
			let faulty91 = showTypeChange($('#faultyEquipType').DataTable().column(96,{ page: 'all'} ).data().sum());
			let faulty92 = showTypeChange($('#faultyEquipType').DataTable().column(97,{ page: 'all'} ).data().sum());
			let faulty93 = showTypeChange($('#faultyEquipType').DataTable().column(98,{ page: 'all'} ).data().sum());
			let faulty94 = showTypeChange($('#faultyEquipType').DataTable().column(99,{ page: 'all'} ).data().sum());
			let faulty95 = showTypeChange($('#faultyEquipType').DataTable().column(100,{ page: 'all'} ).data().sum());
			let faulty96 = showTypeChange($('#faultyEquipType').DataTable().column(101,{ page: 'all'} ).data().sum());
			let faulty97 = showTypeChange($('#faultyEquipType').DataTable().column(102,{ page: 'all'} ).data().sum());
			let faulty98 = showTypeChange($('#faultyEquipType').DataTable().column(103,{ page: 'all'} ).data().sum());
			let faulty99 = showTypeChange($('#faultyEquipType').DataTable().column(104,{ page: 'all'} ).data().sum());
			let faulty100 = showTypeChange($('#faultyEquipType').DataTable().column(105,{ page: 'all'} ).data().sum());
			let faulty101 = showTypeChange($('#faultyEquipType').DataTable().column(106,{ page: 'all'} ).data().sum());
			let faulty102 = showTypeChange($('#faultyEquipType').DataTable().column(107,{ page: 'all'} ).data().sum());
			let faulty103 = showTypeChange($('#faultyEquipType').DataTable().column(108,{ page: 'all'} ).data().sum());
			let faulty104 = showTypeChange($('#faultyEquipType').DataTable().column(109,{ page: 'all'} ).data().sum());
			let faulty105 = showTypeChange($('#faultyEquipType').DataTable().column(110,{ page: 'all'} ).data().sum());
			let faulty106 = showTypeChange($('#faultyEquipType').DataTable().column(111,{ page: 'all'} ).data().sum());
			let faulty107 = showTypeChange($('#faultyEquipType').DataTable().column(112,{ page: 'all'} ).data().sum());
			let faulty108 = showTypeChange($('#faultyEquipType').DataTable().column(113,{ page: 'all'} ).data().sum());
			let faulty109 = showTypeChange($('#faultyEquipType').DataTable().column(114,{ page: 'all'} ).data().sum());
			let faulty110 = showTypeChange($('#faultyEquipType').DataTable().column(115,{ page: 'all'} ).data().sum());
			let faulty111 = showTypeChange($('#faultyEquipType').DataTable().column(116,{ page: 'all'} ).data().sum());
			let faulty112 = showTypeChange($('#faultyEquipType').DataTable().column(117,{ page: 'all'} ).data().sum());
			let faulty113 = showTypeChange($('#faultyEquipType').DataTable().column(118,{ page: 'all'} ).data().sum());
			let faulty114 = showTypeChange($('#faultyEquipType').DataTable().column(119,{ page: 'all'} ).data().sum());
			let faulty115 = showTypeChange($('#faultyEquipType').DataTable().column(120,{ page: 'all'} ).data().sum());
			let faulty116 = showTypeChange($('#faultyEquipType').DataTable().column(121,{ page: 'all'} ).data().sum());
			let faulty117 = showTypeChange($('#faultyEquipType').DataTable().column(122,{ page: 'all'} ).data().sum());
			let faulty118 = showTypeChange($('#faultyEquipType').DataTable().column(123,{ page: 'all'} ).data().sum());
			let faulty119 = showTypeChange($('#faultyEquipType').DataTable().column(124,{ page: 'all'} ).data().sum());
			let faulty120 = showTypeChange($('#faultyEquipType').DataTable().column(125,{ page: 'all'} ).data().sum());
			let faulty121 = showTypeChange($('#faultyEquipType').DataTable().column(126,{ page: 'all'} ).data().sum());
			let faulty122 = showTypeChange($('#faultyEquipType').DataTable().column(127,{ page: 'all'} ).data().sum());
			let faulty123 = showTypeChange($('#faultyEquipType').DataTable().column(128,{ page: 'all'} ).data().sum());
			let faulty124 = showTypeChange($('#faultyEquipType').DataTable().column(129,{ page: 'all'} ).data().sum());
			let faulty125 = showTypeChange($('#faultyEquipType').DataTable().column(130,{ page: 'all'} ).data().sum());
			let faulty126 = showTypeChange($('#faultyEquipType').DataTable().column(131,{ page: 'all'} ).data().sum());
			let faulty127 = showTypeChange($('#faultyEquipType').DataTable().column(132,{ page: 'all'} ).data().sum());
			let faulty128 = showTypeChange($('#faultyEquipType').DataTable().column(133,{ page: 'all'} ).data().sum());
			let faulty129 = showTypeChange($('#faultyEquipType').DataTable().column(134,{ page: 'all'} ).data().sum());
			let faulty130 = showTypeChange($('#faultyEquipType').DataTable().column(135,{ page: 'all'} ).data().sum());
			let faulty131 = showTypeChange($('#faultyEquipType').DataTable().column(136,{ page: 'all'} ).data().sum());
			let faulty132 = showTypeChange($('#faultyEquipType').DataTable().column(137,{ page: 'all'} ).data().sum());
			let faulty133 = showTypeChange($('#faultyEquipType').DataTable().column(138,{ page: 'all'} ).data().sum());
			let faulty134 = showTypeChange($('#faultyEquipType').DataTable().column(139,{ page: 'all'} ).data().sum());
			let faulty135 = showTypeChange($('#faultyEquipType').DataTable().column(140,{ page: 'all'} ).data().sum());
			let faulty136 = showTypeChange($('#faultyEquipType').DataTable().column(141,{ page: 'all'} ).data().sum());
			let faulty137 = showTypeChange($('#faultyEquipType').DataTable().column(142,{ page: 'all'} ).data().sum());
			let faulty138 = showTypeChange($('#faultyEquipType').DataTable().column(143,{ page: 'all'} ).data().sum());
			let faulty139 = showTypeChange($('#faultyEquipType').DataTable().column(144,{ page: 'all'} ).data().sum());
			let faulty140 = showTypeChange($('#faultyEquipType').DataTable().column(145,{ page: 'all'} ).data().sum());
           
            $('#sumOutputCnt3').html(addCommas(sumOutputCnt3));
            $('#sumAppearOutputCnt3').html(addCommas(sumAppearOutputCnt3));
            $('#sumFaulty3').html(addCommas(sumFaulty3));
            $('#sumFaultyPercent3').html(sumFaultyPercent3.toFixed(1) + "%");            
            $('#sumEdgeFaulty3').html(addCommas(sumEdgeFaulty3));
            
            $('#equipFaulty1').html(addCommas(faulty1));
            $('#equipFaulty2').html(addCommas(faulty2));
            $('#equipFaulty3').html(addCommas(faulty3));
            $('#equipFaulty4').html(addCommas(faulty4));
            $('#equipFaulty5').html(addCommas(faulty5));
            $('#equipFaulty6').html(addCommas(faulty6));
            $('#equipFaulty7').html(addCommas(faulty7));
            $('#equipFaulty8').html(addCommas(faulty8));
            $('#equipFaulty9').html(addCommas(faulty9));
            $('#equipFaulty10').html(addCommas(faulty10));
            $('#equipFaulty11').html(addCommas(faulty11));
            $('#equipFaulty12').html(addCommas(faulty12));
            $('#equipFaulty13').html(addCommas(faulty13));
            $('#equipFaulty14').html(addCommas(faulty14));
            $('#equipFaulty15').html(addCommas(faulty15));
            $('#equipFaulty16').html(addCommas(faulty16));
            $('#equipFaulty17').html(addCommas(faulty17));
            $('#equipFaulty18').html(addCommas(faulty18));
            $('#equipFaulty19').html(addCommas(faulty19));
            $('#equipFaulty20').html(addCommas(faulty20));
            $('#equipFaulty21').html(addCommas(faulty21));
            $('#equipFaulty22').html(addCommas(faulty22));
            $('#equipFaulty23').html(addCommas(faulty23));
            $('#equipFaulty24').html(addCommas(faulty24));
            $('#equipFaulty25').html(addCommas(faulty25));
            $('#equipFaulty26').html(addCommas(faulty26));
            $('#equipFaulty27').html(addCommas(faulty27));
            $('#equipFaulty28').html(addCommas(faulty28));
            $('#equipFaulty29').html(addCommas(faulty29));
            $('#equipFaulty30').html(addCommas(faulty30));
            $('#equipFaulty31').html(addCommas(faulty31));
            $('#equipFaulty32').html(addCommas(faulty32));
            $('#equipFaulty33').html(addCommas(faulty33));
            $('#equipFaulty34').html(addCommas(faulty34));
            $('#equipFaulty35').html(addCommas(faulty35));
            $('#equipFaulty36').html(addCommas(faulty36));
            $('#equipFaulty37').html(addCommas(faulty37));
            $('#equipFaulty38').html(addCommas(faulty38));
            $('#equipFaulty39').html(addCommas(faulty39));
            $('#equipFaulty40').html(addCommas(faulty40));
            $('#equipFaulty41').html(addCommas(faulty41));
            $('#equipFaulty42').html(addCommas(faulty42));
            $('#equipFaulty43').html(addCommas(faulty43));
            $('#equipFaulty44').html(addCommas(faulty44));
            $('#equipFaulty45').html(addCommas(faulty45));
            $('#equipFaulty46').html(addCommas(faulty46));
            $('#equipFaulty47').html(addCommas(faulty47));
            $('#equipFaulty48').html(addCommas(faulty48));
            $('#equipFaulty49').html(addCommas(faulty49));
            $('#equipFaulty50').html(addCommas(faulty50));
            $('#equipFaulty51').html(addCommas(faulty51));
            $('#equipFaulty52').html(addCommas(faulty52));
            $('#equipFaulty53').html(addCommas(faulty53));
            $('#equipFaulty54').html(addCommas(faulty54));
            $('#equipFaulty55').html(addCommas(faulty55));
            $('#equipFaulty56').html(addCommas(faulty56));
            $('#equipFaulty57').html(addCommas(faulty57));
            $('#equipFaulty58').html(addCommas(faulty58));
            $('#equipFaulty59').html(addCommas(faulty59));
            $('#equipFaulty60').html(addCommas(faulty60));
            $('#equipFaulty61').html(addCommas(faulty61));
            $('#equipFaulty62').html(addCommas(faulty62));
            $('#equipFaulty63').html(addCommas(faulty63));
            $('#equipFaulty64').html(addCommas(faulty64));
            $('#equipFaulty65').html(addCommas(faulty65));
            $('#equipFaulty66').html(addCommas(faulty66));
            $('#equipFaulty67').html(addCommas(faulty67));
            $('#equipFaulty68').html(addCommas(faulty68));
            $('#equipFaulty69').html(addCommas(faulty69));
            $('#equipFaulty70').html(addCommas(faulty70));
            $('#equipFaulty71').html(addCommas(faulty71));
            $('#equipFaulty72').html(addCommas(faulty72));
            $('#equipFaulty73').html(addCommas(faulty73));
            $('#equipFaulty74').html(addCommas(faulty74));
            $('#equipFaulty75').html(addCommas(faulty75));
            $('#equipFaulty76').html(addCommas(faulty76));
            $('#equipFaulty77').html(addCommas(faulty77));
            $('#equipFaulty78').html(addCommas(faulty78));
            $('#equipFaulty79').html(addCommas(faulty79));
            $('#equipFaulty80').html(addCommas(faulty80));
            $('#equipFaulty81').html(addCommas(faulty81));
            $('#equipFaulty82').html(addCommas(faulty82));
            $('#equipFaulty83').html(addCommas(faulty83));
            $('#equipFaulty84').html(addCommas(faulty84));
            $('#equipFaulty85').html(addCommas(faulty85));
            $('#equipFaulty86').html(addCommas(faulty86));
            $('#equipFaulty87').html(addCommas(faulty87));
            $('#equipFaulty88').html(addCommas(faulty88));
            $('#equipFaulty89').html(addCommas(faulty89));
            $('#equipFaulty90').html(addCommas(faulty90));
            $('#equipFaulty91').html(addCommas(faulty91));
            $('#equipFaulty92').html(addCommas(faulty92));
            $('#equipFaulty93').html(addCommas(faulty93));
            $('#equipFaulty94').html(addCommas(faulty94));
            $('#equipFaulty95').html(addCommas(faulty95));
            $('#equipFaulty96').html(addCommas(faulty96));
            $('#equipFaulty97').html(addCommas(faulty97));
            $('#equipFaulty98').html(addCommas(faulty98));
            $('#equipFaulty99').html(addCommas(faulty99));
            $('#equipFaulty100').html(addCommas(faulty100));
            $('#equipFaulty101').html(addCommas(faulty101));
            $('#equipFaulty102').html(addCommas(faulty102));
            $('#equipFaulty103').html(addCommas(faulty103));
            $('#equipFaulty104').html(addCommas(faulty104));
            $('#equipFaulty105').html(addCommas(faulty105));
            $('#equipFaulty106').html(addCommas(faulty106));
            $('#equipFaulty107').html(addCommas(faulty107));
            $('#equipFaulty108').html(addCommas(faulty108));
            $('#equipFaulty109').html(addCommas(faulty109));
            $('#equipFaulty110').html(addCommas(faulty110));
            $('#equipFaulty111').html(addCommas(faulty111));
            $('#equipFaulty112').html(addCommas(faulty112));
            $('#equipFaulty113').html(addCommas(faulty113));
            $('#equipFaulty114').html(addCommas(faulty114));
            $('#equipFaulty115').html(addCommas(faulty115));
            $('#equipFaulty116').html(addCommas(faulty116));
            $('#equipFaulty117').html(addCommas(faulty117));
            $('#equipFaulty118').html(addCommas(faulty118));
            $('#equipFaulty119').html(addCommas(faulty119));
            $('#equipFaulty120').html(addCommas(faulty120));
            $('#equipFaulty121').html(addCommas(faulty121));
            $('#equipFaulty122').html(addCommas(faulty122));
            $('#equipFaulty123').html(addCommas(faulty123));
            $('#equipFaulty124').html(addCommas(faulty124));
            $('#equipFaulty125').html(addCommas(faulty125));
            $('#equipFaulty126').html(addCommas(faulty126));
            $('#equipFaulty127').html(addCommas(faulty127));
            $('#equipFaulty128').html(addCommas(faulty128));
            $('#equipFaulty129').html(addCommas(faulty129));
            $('#equipFaulty130').html(addCommas(faulty130));
            $('#equipFaulty131').html(addCommas(faulty131));
            $('#equipFaulty132').html(addCommas(faulty132));
            $('#equipFaulty133').html(addCommas(faulty133));
            $('#equipFaulty134').html(addCommas(faulty134));
            $('#equipFaulty135').html(addCommas(faulty135));
            $('#equipFaulty136').html(addCommas(faulty136));
            $('#equipFaulty137').html(addCommas(faulty137));
            $('#equipFaulty138').html(addCommas(faulty138));
            $('#equipFaulty139').html(addCommas(faulty139));
            $('#equipFaulty140').html(addCommas(faulty140));

            
        }
    });

    //var html3 = '<div class="row"><div class="form-group input-sub m-0 row">';
	//html3 += '<label class="input-label-sm">&nbsp;검사일</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarFromEquip" name="chooseCalendarFromEquip" />';
	//html3 += '<button onclick="fnPopUpCalendar(chooseCalendarFromEquip,chooseCalendarFromEquip,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarFromEquip" type="button">';
	//html3 += '<span class="oi oi-calendar"></span>';
	//html3 += '</button>'; 
	//html3 += '</div>';
	//html3 += '<div class="form-group input-sub m-0 row">';
	//html3 += '<label class="input-label-sm">&nbsp;&nbsp&nbsp~</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarEquip" name="chooseCalendarEquip" />';
	//html3 += '<button onclick="fnPopUpCalendar(chooseCalendarEquip,chooseCalendarEquip,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarEquip" type="button">';
	//html3 += '<span class="oi oi-calendar"></span>';
	//html3 += '</button>'; 
	//html3 += '</div>';
	//html3 += '&nbsp<button type="button" class="btn btn-primary" id="btnRetvEquip">조회</button></div>';
    
	$('#faultyEquipType_length').html("");
	//$('#faultyEquipType_length').html(html3);
	//$('#chooseCalendarFromEquip').val(serverDateFrom);
	//$('#chooseCalendarEquip').val(serverDate);

	//기간별 조회버튼	
  	//$('#btnRetvWeek').on('click', function() {
  	//	chooseDateFromWeek = $('#chooseCalendarFromWeek').val();
  	//	chooseDateWeek = $('#chooseCalendarWeek').val();
  	//	$('#faultyStatsWeek').DataTable().ajax.reload();
	//});

	//제품별 조회버튼
  	//$('#btnRetvGoods').on('click', function() {
  	//	chooseDateFromGoods = $('#chooseCalendarFromGoods').val();
  	//	chooseDateGoods = $('#chooseCalendarGoods').val();
  	//	$('#faultyStatsGoods').DataTable().ajax.reload();
	//});

	//유형별 조회버튼
  	//$('#btnRetvType').on('click', function() {
  	//	chooseDateFromType = $('#chooseCalendarFromType').val();
  	//	chooseDateType = $('#chooseCalendarType').val();
  	//	$('#faultyStatsType').DataTable().ajax.reload();
	//});

	//설비별 조회버튼
  	//$('#btnRetvEquip').on('click', function() {
  	//	chooseDateFromEquip = $('#chooseCalendarFromEquip').val();
  	//	chooseDateEquip = $('#chooseCalendarEquip').val();
  	//	$('#faultyEquipType').DataTable().ajax.reload();
	//});

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
		
		if (tapTemp == 0){
			$("#tab1").trigger("click");
		} else if (tapTemp == 1) {
			$("#tab2").trigger("click");
		} else if (tapTemp == 2) {
			$("#tab3").trigger("click");
		} else if (tapTemp == 3) {
			$("#tab4").trigger("click");
		}
	});
	
	$('#tab1').click(function() {
		$('#faultyWeekView').removeClass("d-none");
		$('#faultyGoodsView').addClass("d-none");
		$('#faultyTypeView').addClass("d-none");
		$('#faultyEquipTypeView').addClass("d-none");
		$('#faultyStatsWeek').DataTable().ajax.reload();
		tapTemp = 0;
	});
	
	$('#tab2').click(function() {
		$('#faultyWeekView').addClass("d-none");
		$('#faultyGoodsView').removeClass("d-none");
		$('#faultyTypeView').addClass("d-none");
		$('#faultyEquipTypeView').addClass("d-none");
		$('#faultyStatsGoods').DataTable().ajax.reload();
		tapTemp = 1;
	});
	
	$('#tab3').click(function() {
		$('#faultyWeekView').addClass("d-none");
		$('#faultyGoodsView').addClass("d-none");
		$('#faultyTypeView').removeClass("d-none");
		$('#faultyEquipTypeView').addClass("d-none");
		$('#faultyStatsType').DataTable().ajax.reload();
		tapTemp = 2;
	});

	$('#tab4').click(function() {
		$('#faultyWeekView').addClass("d-none");
		$('#faultyGoodsView').addClass("d-none");
		$('#faultyTypeView').addClass("d-none");
		$('#faultyEquipTypeView').removeClass("d-none");
		$('#faultyEquipType').DataTable().ajax.reload();
		tapTemp = 3;
	});

	$('#faultyStatsWeek tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#faultyStatsWeek').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});

	$('#faultyStatsGoods tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#faultyStatsGoods').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});

	$('#faultyStatsType tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#faultyStatsType').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});

	$('#faultyEquipType tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#faultyEquipType').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});

	$('#showType').change(function() {
  		showType = $("#showType option:selected").val();
		if (tapTemp == 0){
			$('#faultyStatsWeek').DataTable().ajax.reload();
		} else if (tapTemp == 1) {
			$('#faultyStatsGoods').DataTable().ajax.reload();
		} else if (tapTemp == 2) {
			//$('#faultyStatsType').DataTable().ajax.reload();
		} else if (tapTemp == 3) {
			$('#faultyEquipType').DataTable().ajax.reload();
		}
    });

	function showTypeChange(data) {
		if (showType == 'showType001') {
			return data;
		} else if (showType == 'showType002'){
			let temp = parseFloat(data/sumOutputCnt1) * 100;
			if (Number.isInteger(temp)) {
				return addCommas(temp.toFixed(1))  + ' %';
			} else {
				return addCommas(temp.toFixed(1)) + ' %';
			}
		}
	}

	function appearWeekHeaderCreate(){   			
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
        /* $('#visonHd').attr('colspan', visionIdx);   
        $('#fiveHd').attr('colspan', fiveIdx); */
        //$('#sixHd').attr('colspan', sixIdx);
        
		$('#appearFaultyWeekHd').html(metal);  
	}

	function appearGoodsHeaderCreate(){   			
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
        $('#metalHd2').attr('colspan', metalIdx);   
        $('#filmHd2').attr('colspan', filmIdx);        
        /* $('#visonHd2').attr('colspan', visionIdx);   
        $('#fiveHd2').attr('colspan', fiveIdx); */
		$('#appearFaultyGoodsHd').html(metal); 	
	}

	function appearEquipHeaderCreate(){   			
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
    		//if(item.etc1 == '004'){
    		//	vision += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    		//	visionIdx++;  
        	//}
    		//if(item.etc1 == '005'){
    		//	five += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    		//	fiveIdx++;  
        	//}
    		//if(item.etc1 == '006'){
    		//	six += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    		//	sixIdx++;  
        	//}
		});
    	metal = metal + film +vision + five + six;
        $('#metalHd3').attr('colspan', metalIdx);   
        $('#filmHd3').attr('colspan', filmIdx);        
        //$('#visonHd3').attr('colspan', visionIdx);   
        //$('#fiveHd3').attr('colspan', fiveIdx);      
		$('#appearFaultyEquipHd').html(metal); 	
	}
</script>

</body>
</html>