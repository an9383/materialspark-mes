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
				<li class="breadcrumb-item active">생산공정일일DATA조회</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 99%; padding-bottom: 0px;">
				<!--
				<div class="row">
					&nbsp;<label class="input-label-sm">기간</label>
					<div class="form-group input-sub m-0 row">
						<input class="form-control" style="width: 97px;" type="text" id="chooseDateFromCal1" />
						<button	onclick="fnPopUpCalendar(chooseDateFromCal1,chooseDateFromCal1,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateFromCal1endar" type="button">
							<span class="oi oi-calendar"></span>
						</button>
					</div>
					&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>
					<div class="form-group input-sub m-0 row">
						<input class="form-control" style="width: 97px;" type="text" id="chooseDateToCal1" />
						<button	onclick="fnPopUpCalendar(chooseDateToCal1,chooseDateToCal1,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateToCal1endar" type="button">
							<span class="oi oi-calendar"></span>
						</button>
					</div>
					&nbsp;
					<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
				</div>
				-->
				<div class="card-header card-tab" style="margin-bottom: 7px;">
					<ul class="nav nav-tabs card-header-tabs">
						<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">기종별</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">라인별</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">직원별</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">일자별</a></li>
						
						<!-- 
						<li class="nav-item"><a class="nav-link disabled" data-toggle="tab" id="tab4">자재코드별</a></li>
						 -->
					</ul>
					<!-- <div class="float-right row" style="vertical-align : middle">직원별</div> -->
				</div>
				<div class="table-responsive" style="padding-bottom:5px;">
					<div id="tabContent1">
						<table id="outputTable1" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th rowspan="2" style="min-width:100px;" class="text-center">제품</th>
									<th rowspan="2" style="min-width:50px;" class="text-center">재질</th>
									<th rowspan="2" style="min-width:200px;" class="text-center">규격</th>
									<!-- <th rowspan="2" style="min-width:60px;" class="text-center">목표<br>총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">목표 양품<br>생산량<br>달성률(%)</th> -->
									
									<th rowspan="2" style="min-width:60px;" class="text-center">총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">양품 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">SCRAP<br>발생률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">SCRAP<br>발생개수</th>
									<th colspan="5" style="min-width:80px;" class="text-center">외관불량</th>
									
									<%-- <th rowspan="2" style="min-width:60px;" class="text-center">${processFaultyNm}<br>불량률</th> --%>
									<th rowspan="2" style="min-width:60px;" class="text-center">${matrlFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${replaceFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${troubleFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm114}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm115}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm116}<br>불량률</th>
									
									<th colspan="0" style="min-width:80px;" class="text-center">${processFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${matrlFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${replaceFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${troubleFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm114}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm115}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm116}</th>
								</tr>
								
								<tr>
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">총합</th>
									<th style="min-width:60px" class="text-center">외관</th>
									<th style="min-width:60px" class="text-center">엣지</th>
									<th style="min-width:60px" class="text-center">출하</th>
									<th style="min-width:60px" class="text-center">재검</th>
																		
									<!-- <th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th> -->
									<th style="min-width:60px" class="text-center">EA</th>
									
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">EA</th>
									
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="3" style="text-align: center">총 합계</td>
									<!-- <td colspan="" id="sumTargetCnt1" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPercent1" style="text-align: right">0</td> -->									
									
									<td colspan="" id="sumTotalOutputCnt1" style="text-align: right">0</td>
									<td colspan="" id="sumOutputNomal1" style="text-align: right">0</td>
									<td colspan="" id="sumOutputCnt1" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyPercent1" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyCnt1" style="text-align: right">0</td>
									
									<td colspan="" id="outputFaultyCnt1" style="text-align: right">0</td>
									<td colspan="" id="appearFaultyCnt1" style="text-align: right">0</td>
									<td colspan="" id="edgeFaultyCnt1" style="text-align: right">0</td>
									<td colspan="" id="shipFaultyCnt1" style="text-align: right">0</td>
									<td colspan="" id="reShipFaultyCnt1" style="text-align: right">0</td>
									
									
									<!-- <td colspan="" id="sumProcessPercent1" style="text-align: right">0</td> -->
									<td colspan="" id="sumMatrlPercent1" style="text-align: right">0</td>
									<td colspan="" id="sumReplacePercent1" style="text-align: right">0</td>
									<td colspan="" id="sumTroublePercent1" style="text-align: right">0</td>
									
									<td colspan="" id="sum114Percent1" style="text-align: right">0</td>
									<td colspan="" id="sum115Percent1" style="text-align: right">0</td>
									<td colspan="" id="sum116Percent1" style="text-align: right">0</td>
									
									<!--  -->
									<!-- <td colspan="" id="sumProcessCount1" style="text-align: right">0</td> -->
									<td colspan="" id="sumProcessKg1" style="text-align: right">0</td>
									<!-- <td colspan="" id="sumProcessEa1" style="text-align: right">0</td> -->
									<td colspan="" id="sumMatrlCount1" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlKg1" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlEa1" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceCount1" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceKg1" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceEa1" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleCount1" style="text-align: right">0</td>
									<td colspan="" id="sumTrougleKg1" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleEa1" style="text-align: right">0</td>
									
									<td colspan="" id="sum114Count1" style="text-align: right">0</td>
									<td colspan="" id="sum114Kg1" style="text-align: right">0</td>
									<td colspan="" id="sum114Ea1" style="text-align: right">0</td>
									<td colspan="" id="sum115Count1" style="text-align: right">0</td>
									<td colspan="" id="sum115Kg1" style="text-align: right">0</td>
									<td colspan="" id="sum115Ea1" style="text-align: right">0</td>
									<td colspan="" id="sum116Count1" style="text-align: right">0</td>
									<td colspan="" id="sum116Kg1" style="text-align: right">0</td>
									<td colspan="" id="sum116Ea1" style="text-align: right">0</td>									
																		
								</tr>
							</tfoot>
						</table>
					</div>
					<div id="tabContent2" class="d-none">
						<table id="outputTable2" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th rowspan="2" style="min-width:50px;" class="text-center">설비명</th>
									<th rowspan="2" style="min-width:50px;" class="text-center">주야</th>
									<th rowspan="2" style="min-width:80px;" class="text-center">제품</th>
									<th rowspan="2" style="min-width:50px;" class="text-center">재질</th>
									<th rowspan="2" style="min-width:200px;" class="text-center">규격</th>
									<!-- <th rowspan="2" style="min-width:60px;" class="text-center">목표<br>총 생산량</th> -->
									<!-- <th rowspan="2" style="min-width:60px;" class="text-center">목표 양품<br>생산량<br>달성률(%)</th> -->
									
									<th rowspan="2" style="min-width:60px;" class="text-center">총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">양품 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">SCRAP<br>발생률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">SCRAP<br>발생개수</th>
									<th colspan="5" style="min-width:80px;" class="text-center">외관불량</th>
									
									<%-- <th rowspan="2" style="min-width:60px;" class="text-center">${processFaultyNm}<br>불량률</th> --%>
									<th rowspan="2" style="min-width:60px;" class="text-center">${matrlFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${replaceFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${troubleFaultyNm}<br>불량률</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm114}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm115}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm116}<br>불량률</th>
									
									
									<th colspan="0" style="min-width:80px;" class="text-center">${processFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${matrlFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${replaceFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${troubleFaultyNm}</th>
									
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm114}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm115}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm116}</th>
								</tr>
								<tr>
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">총합</th>
									<th style="min-width:60px" class="text-center">외관</th>
									<th style="min-width:60px" class="text-center">엣지</th>
									<th style="min-width:60px" class="text-center">출하</th>
									<th style="min-width:60px" class="text-center">재검</th>
											
									<!-- <th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th> -->
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">EA</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="5" style="text-align: center">총 합계</td>
									<!-- <td colspan="" id="sumTargetCnt2" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPercent2" style="text-align: right">0</td> -->
									
									<td colspan="" id="sumTotalOutputCnt2" style="text-align: right">0</td>
									<td colspan="" id="sumOutputNomal2" style="text-align: right">0</td>
									<td colspan="" id="sumOutputCnt2" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyPercent2" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyCnt2" style="text-align: right">0</td>
									
									<td colspan="" id="outputFaultyCnt2" style="text-align: right">0</td>
									<td colspan="" id="appearFaultyCnt2" style="text-align: right">0</td>
									<td colspan="" id="edgeFaultyCnt2" style="text-align: right">0</td>
									<td colspan="" id="shipFaultyCnt2" style="text-align: right">0</td>
									<td colspan="" id="reShipFaultyCnt2" style="text-align: right">0</td>
									
									<!-- <td colspan="" id="sumProcessPercent2" style="text-align: right">0</td> -->
									<td colspan="" id="sumMatrlPercent2" style="text-align: right">0</td>
									<td colspan="" id="sumReplacePercent2" style="text-align: right">0</td>
									<td colspan="" id="sumTroublePercent2" style="text-align: right">0</td>
									
									<td colspan="" id="sum114Percent2" style="text-align: right">0</td>
									<td colspan="" id="sum115Percent2" style="text-align: right">0</td>
									<td colspan="" id="sum116Percent2" style="text-align: right">0</td>
									
									<!-- <td colspan="" id="sumProcessCount2" style="text-align: right">0</td> -->
									<td colspan="" id="sumProcessKg2" style="text-align: right">0</td>
									<!-- <td colspan="" id="sumProcessEa2" style="text-align: right">0</td> -->
									<td colspan="" id="sumMatrlCount2" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlKg2" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlEa2" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceCount2" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceKg2" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceEa2" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleCount2" style="text-align: right">0</td>
									<td colspan="" id="sumTrougleKg2" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleEa2" style="text-align: right">0</td>
									
									<td colspan="" id="sum114Count2" style="text-align: right">0</td>
									<td colspan="" id="sum114Kg2" style="text-align: right">0</td>
									<td colspan="" id="sum114Ea2" style="text-align: right">0</td>
									<td colspan="" id="sum115Count2" style="text-align: right">0</td>
									<td colspan="" id="sum115Kg2" style="text-align: right">0</td>
									<td colspan="" id="sum115Ea2" style="text-align: right">0</td>
									<td colspan="" id="sum116Count2" style="text-align: right">0</td>
									<td colspan="" id="sum116Kg2" style="text-align: right">0</td>
									<td colspan="" id="sum116Ea2" style="text-align: right">0</td>
									
								</tr>
							</tfoot>
						</table>
					</div>
					<div id="tabContent3" class="d-none">
						<table id="outputTable3" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th rowspan="2" style="min-width:80px;" class="text-center">직원</th>
									<th rowspan="2" style="min-width:80px;" class="text-center">제품</th>
									<th rowspan="2" style="min-width:50px;" class="text-center">재질</th>
									<th rowspan="2" style="min-width:200px;" class="text-center">규격</th>
									<!-- <th rowspan="2" style="min-width:60px;" class="text-center">목표<br>총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">목표 양품<br>생산량<br>달성률(%)</th> -->
									
									<th rowspan="2" style="min-width:60px;" class="text-center">총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">양품 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">SCRAP<br>발생률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">SCRAP<br>발생개수</th>
									<th colspan="5" style="min-width:80px;" class="text-center">외관불량</th>
									
									<%-- <th rowspan="2" style="min-width:60px;" class="text-center">${processFaultyNm}<br>불량률</th> --%>
									<th rowspan="2" style="min-width:60px;" class="text-center">${matrlFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${replaceFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${troubleFaultyNm}<br>불량률</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm114}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm115}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm116}<br>불량률</th>
									
									
									<th colspan="0" style="min-width:80px;" class="text-center">${processFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${matrlFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${replaceFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${troubleFaultyNm}</th>
									
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm114}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm115}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm116}</th>								
								</tr>
								<tr>
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">총합</th>
									<th style="min-width:60px" class="text-center">외관</th>
									<th style="min-width:60px" class="text-center">엣지</th>
									<th style="min-width:60px" class="text-center">출하</th>
									<th style="min-width:60px" class="text-center">재검</th>
									
									<!-- <th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th> -->
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">EA</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="4" style="text-align: center">총 합계</td>
									<!-- <td colspan="" id="sumTargetCnt3" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPercent3" style="text-align: right">0</td> -->
									
									<td colspan="" id="sumTotalOutputCnt3" style="text-align: right">0</td>
									<td colspan="" id="sumOutputNomal3" style="text-align: right">0</td>
									<td colspan="" id="sumOutputCnt3" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyPercent3" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyCnt3" style="text-align: right">0</td>
									
									<td colspan="" id="outputFaultyCnt3" style="text-align: right">0</td>
									<td colspan="" id="appearFaultyCnt3" style="text-align: right">0</td>
									<td colspan="" id="edgeFaultyCnt3" style="text-align: right">0</td>
									<td colspan="" id="shipFaultyCnt3" style="text-align: right">0</td>
									<td colspan="" id="reShipFaultyCnt3" style="text-align: right">0</td>
									
									<!-- <td colspan="" id="sumProcessPercent3" style="text-align: right">0</td> -->
									<td colspan="" id="sumMatrlPercent3" style="text-align: right">0</td>
									<td colspan="" id="sumReplacePercent3" style="text-align: right">0</td>
									<td colspan="" id="sumTroublePercent3" style="text-align: right">0</td>
									
									<td colspan="" id="sum114Percent3" style="text-align: right">0</td>
									<td colspan="" id="sum115Percent3" style="text-align: right">0</td>
									<td colspan="" id="sum116Percent3" style="text-align: right">0</td>
									
									<!-- <td colspan="" id="sumProcessCount3" style="text-align: right">0</td> -->
									<td colspan="" id="sumProcessKg3" style="text-align: right">0</td>
									<!-- <td colspan="" id="sumProcessEa3" style="text-align: right">0</td> -->
									<td colspan="" id="sumMatrlCount3" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlKg3" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlEa3" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceCount3" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceKg3" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceEa3" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleCount3" style="text-align: right">0</td>
									<td colspan="" id="sumTrougleKg3" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleEa3" style="text-align: right">0</td>
									
									<td colspan="" id="sum114Count3" style="text-align: right">0</td>
									<td colspan="" id="sum114Kg3" style="text-align: right">0</td>
									<td colspan="" id="sum114Ea3" style="text-align: right">0</td>
									<td colspan="" id="sum115Count3" style="text-align: right">0</td>
									<td colspan="" id="sum115Kg3" style="text-align: right">0</td>
									<td colspan="" id="sum115Ea3" style="text-align: right">0</td>
									<td colspan="" id="sum116Count3" style="text-align: right">0</td>
									<td colspan="" id="sum116Kg3" style="text-align: right">0</td>
									<td colspan="" id="sum116Ea3" style="text-align: right">0</td>
								</tr>
							</tfoot>
						</table>
					</div>
					<div id="tabContent4" class="d-none">
						<table id="outputTable4" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th rowspan="2" style="min-width:80px;" class="text-center">일자</th>
																		
									<th rowspan="2" style="min-width:60px;" class="text-center">총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">양품 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">SCRAP<br>발생률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">SCRAP<br>발생개수</th>
									<th colspan="5" style="min-width:80px;" class="text-center">외관불량</th>									
						
									<th rowspan="2" style="min-width:60px;" class="text-center">${matrlFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${replaceFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${troubleFaultyNm}<br>불량률</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm114}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm115}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${faultyNm116}<br>불량률</th>
									
									
									<th colspan="0" style="min-width:80px;" class="text-center">${processFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${matrlFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${replaceFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${troubleFaultyNm}</th>
									
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm114}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm115}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${faultyNm116}</th>								
								</tr>
								<tr>
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">총합</th>
									<th style="min-width:60px" class="text-center">외관</th>
									<th style="min-width:60px" class="text-center">엣지</th>
									<th style="min-width:60px" class="text-center">출하</th>
									<th style="min-width:60px" class="text-center">재검</th>
									
								
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="min-width:60px" class="text-center">EA</th>
									<th style="min-width:60px" class="text-center">횟수</th>
									<th style="min-width:60px" class="text-center">KG</th>
									
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">EA</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="1" style="text-align: center">총 합계</td>
									<!-- <td colspan="" id="sumTargetCnt3" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPercent3" style="text-align: right">0</td> -->
									
									<td colspan="" id="sumTotalOutputCnt4" style="text-align: right">0</td>
									<td colspan="" id="sumOutputNomal4" style="text-align: right">0</td>
									<td colspan="" id="sumOutputCnt4" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyPercent4" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyCnt4" style="text-align: right">0</td>
									
									<td colspan="" id="outputFaultyCnt4" style="text-align: right">0</td>
									<td colspan="" id="appearFaultyCnt4" style="text-align: right">0</td>
									<td colspan="" id="edgeFaultyCnt4" style="text-align: right">0</td>
									<td colspan="" id="shipFaultyCnt4" style="text-align: right">0</td>
									<td colspan="" id="reShipFaultyCnt4" style="text-align: right">0</td>
									
									<!-- <td colspan="" id="sumProcessPercent3" style="text-align: right">0</td> -->
									<td colspan="" id="sumMatrlPercent4" style="text-align: right">0</td>
									<td colspan="" id="sumReplacePercent4" style="text-align: right">0</td>
									<td colspan="" id="sumTroublePercent4" style="text-align: right">0</td>
									
									<td colspan="" id="sum114Percent4" style="text-align: right">0</td>
									<td colspan="" id="sum115Percent4" style="text-align: right">0</td>
									<td colspan="" id="sum116Percent4" style="text-align: right">0</td>
									
									<!-- <td colspan="" id="sumProcessCount3" style="text-align: right">0</td> -->
									<td colspan="" id="sumProcessKg4" style="text-align: right">0</td>
									<!-- <td colspan="" id="sumProcessEa3" style="text-align: right">0</td> -->
									<td colspan="" id="sumMatrlCount4" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlKg4" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlEa4" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceCount4" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceKg4" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceEa4" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleCount4" style="text-align: right">0</td>
									<td colspan="" id="sumTrougleKg4" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleEa4" style="text-align: right">0</td>
									
									<td colspan="" id="sum114Count4" style="text-align: right">0</td>
									<td colspan="" id="sum114Kg4" style="text-align: right">0</td>
									<td colspan="" id="sum114Ea4" style="text-align: right">0</td>
									<td colspan="" id="sum115Count4" style="text-align: right">0</td>
									<td colspan="" id="sum115Kg4" style="text-align: right">0</td>
									<td colspan="" id="sum115Ea4" style="text-align: right">0</td>
									<td colspan="" id="sum116Count4" style="text-align: right">0</td>
									<td colspan="" id="sum116Kg4" style="text-align: right">0</td>
									<td colspan="" id="sum116Ea4" style="text-align: right">0</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 범례 모달 시작-->
<div class="modal fade bd-example-modal" id="bumlyeModal" tabindex="-1" role="dialog" aria-labelledby="bumlyeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bumlyeModalLabel">범례</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
						<span class="text-center" style="font-weight:bold;"><h5>총생산량 = 양품수량  + 교체loss + 외관불량	</h5> </span><br>
						<span class="text-center" style="font-weight:bold;"><h5>생산량 = 양품수량  + 외관불량 				</h5> </span><br>
						<span class="text-center" style="font-weight:bold;"><h5>양품수량 = 트레이수량 					</h5> </span><br>
						<span class="text-center" style="font-weight:bold;"><h5>교체loss = 불량중량						</h5> </span><br>
						<span class="text-center" style="font-weight:bold;"><h5>외관불량 (재검+외관+엣지+출하검사) 			</h5> </span><br>
						<span class="text-center" style="font-weight:bold;"><h5>양품수량 :(트레이 생산실적 일자) 			</h5> </span><br>
						<span class="text-center" style="font-weight:bold;"><h5>외관불량 = 검사일 기준 집계					</h5> </span><br>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 범례 모달 종료-->

<%@include file="../layout/bottom.jsp" %>

<script>
	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'wmsc3070';
	let currentHref = 'wmsc3070';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');	
	$(document).attr("title","생산공정일일DATA조회");

	var serverDateFrom = "${serverDateFrom}";
	var serverDate = "${serverDate}";
	var chooseDateFrom = serverDateFrom;
	var chooseDateTo = serverDate;
	//var chooseDateFrom2 = serverDateFrom;
	//var chooseDateTo2 = serverDate;
	//var chooseDateFrom3 = serverDateFrom;
	//var chooseDateTo3 = serverDate;
	//var chooseDateFrom4 = serverDateFrom;
	//var chooseDateTo4 = serverDate;

	var tabTemp = 1;
	var userNumber = '';
	
	var processFaultyNm	=  "${processFaultyNm}";
	var matrlFaultyNm	=  "${matrlFaultyNm}";
	var replaceFaultyNm =  "${replaceFaultyNm}";
	var troubleFaultyNm	=  "${troubleFaultyNm}";
	
	let faultyNm114		=  "${faultyNm114}";
	let faultyNm115		=  "${faultyNm115}";
	let faultyNm116		=  "${faultyNm116}";
	
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
    
    var basketWeightCode = new Array(); //바구니 무게 
	<c:forEach items="${basketWeight}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";
		basketWeightCode.push(json);
	</c:forEach>
    //공통코드 처리 종료
    
    let basketWeight = parseFloat(basketWeightCode[0].etc1); 
    	
	$.fn.dataTable.ext.errMode = 'none';
	let outputTable1 = $('#outputTable1').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        scrollX : true,
        fixedColumns: {
			leftColumns: 3
		},
        scrollY : "56vh",
        scrollCollapse: true,
        pageLength: -1,
        ajax: {
            url: '<c:url value="wm/readActualOutputGoodsList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
            	'chooseDate1'	:	function() { return chooseDateFrom.replace(/-/g, ''); },
            	'chooseDate2'	:	function() { return chooseDateTo.replace(/-/g, ''); },
            },
        },
		columns: [
			{ data: 'goodsNm' },
			{ data: 'qutyNm' },
			{ data: 'model' },
			{ data: '',	//총생산량
				render: function(data, type, row) {
					return addCommas((parseInt(row['sumOutputCnt']) + parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7']) + parseInt(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            { data: '',	//생산량
				render: function(data, type, row) {
					return addCommas((parseInt(row['sumOutputCnt']) + parseInt(row['outputFaultyCnt'])).toFixed(0));
				}
            },
			{ data: 'sumOutputCnt' },
			{ data: '',	//SCRAP발생률
				render: function(data, type, row) {
					//SCRAP발생수량
					let totalFaultyEa = parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7'])
					//let faultyPercent = (totalFaultyEa / (parseFloat(row['sumOutputCnt']) + totalFaultyEa) * 100).toFixed(1);
					let faultyPercent = (totalFaultyEa / parseInt(row['prcsTotal']) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//SCRAP발생수량
				render: function(data, type, row) {
					return addCommas((parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7']) ).toFixed(0)  );
				}
            },
            { data: 'outputFaultyCnt' },
        	{ data: 'appearFaultyCnt' },
			{ data: 'edgeFaultyCnt' },
			{ data: 'shipFaultyCnt' },
			{ data: 'reShipFaultyCnt' },
			{ data: '',	//Metal 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['matrlEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || parseFloat(row['matrlEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//Film 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['rpcEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || parseFloat(row['rpcEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//Teflon 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['trbEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['trbEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea5']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea6']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea7']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            { data: 'prcsTotal'},		//Cutting 수량 (EA)
            
			{ data: 'matrlCnt' },		//횟수
			{ data: 'matrlTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'matrlEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			{ data: 'rpcCnt' },		//횟수
			{ data: 'rpcTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'rpcEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			{ data: 'trbCnt' },	//횟수
			{ data: 'trbTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'trbEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			 
			 
			{ data: 'cnt5' },	//횟수
			{ data: 'total5',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
	        },
			{ data: 'ea5',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			},
			{ data: 'cnt6' },	//횟수
			{ data: 'total6',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
	        },
			{ data: 'ea6',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			},
			{ data: 'cnt7' },	//횟수
			{ data: 'total7',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
	        },
			{ data: 'ea7',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			},
		
		],
        columnDefs: [
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3,4,5,6,7,13,14,15,16,17,18], className: 'text-right' },
        	
        	{ targets: [8,9,10,11,12, 19,20, 22,23, 25,26, 28,29, 31,32, 34,35, 37], className: 'sudelSum text-right' },
        	{ targets: [21,24,27,30,33,36], className: 'sudelFloatSum text-right' },
        ],
		order: [
			//[ 0, 'asc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: '생산실적관리 - 기종별',
            },
            {
            	extend: 'excel',
                title: '생산실적관리 - 기종별',
                footer: true,
                //excelCss
			    customize: function ( xlsx ) {
			        var sheet = xlsx.xl.worksheets['sheet1.xml'];
			        
			        //Bold Header Row
			        $('row[r=3] c', sheet).attr( 's', '2' );
			        $('row[r=4] c', sheet).attr( 's', '2' );
			        $('row[r=5] c', sheet).attr( 's', '2' );
			        
			        //Make Cells Bold
			        $('c[r=A1]', sheet).attr( 's', '2' );
			        $('c[r=A3]', sheet).attr( 's', '2' );

			        //가운데
			        $('row[r=1] c', sheet).attr( 's', '51' );
			        $('row[r=3] c', sheet).attr( 's', '51' );

			        //배경 색
			        /*$('row[r=3] c', sheet).attr( 's', '30' );
			        $('row[r=4] c', sheet).attr( 's', '30' );
			        $('row[r=5] c', sheet).attr( 's', '30' );*/

			        $('row[r=2] c', sheet).remove();	//2번째 행 데이터 삭제

			      	//병합 하고자 하는 셀 지정 
			      	var mergeCells = $('mergeCells', sheet);

			      	//rowspan
					/* mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A3:A4'} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'B3:B4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'C3:C4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'D3:D4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'E3:E4'} } )
					);
					
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'F3:F4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'G3:G4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'H3:H4'} } )
					); */
					//rowspan
					//병합 하고자 하는 셀 지정 끝

	                mergeCells.attr( 'count', mergeCells.attr( 'count' )+1 );

	                function createNode( doc, nodeName, opts ) {
						var tempNode = doc.createElement( nodeName );
	                    if ( opts ) {
							if ( opts.attr ) {
	                        	$(tempNode).attr( opts.attr );
	                      	}
	   
	                      	if ( opts.children ) {
	                        	$.each( opts.children, function ( key, value ) {
	                          		tempNode.appendChild( value );
	                        	} );
	                      	}
	   
	                      	if ( opts.text !== null && opts.text !== undefined ) {
	                        	tempNode.appendChild( doc.createTextNode( opts.text ) );
	                      	}
	                    }
	                    return tempNode;
					}
			    },
			  	//excelCssEnd

			    //헤더 추가하는 부분
			    customizeData: function(data) {
				   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				 	//첫 번째 tr
				 	 let arrayTr1 = colspanGroupArray('outputTable1', 0, 'th', $('#outputTable1 thead tr').eq(0).find('th').length, 8, 'Y', '');
				 	//두 번째 tr
				 	 let arrayTr2 = colspanGroupArray('outputTable1', 1, 'th', $('#outputTable1 thead tr').eq(1).find('th').length, 8, 'N', arrayTr1);
					
					//첫 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow1 = alignToTableSize( data.header.length, arrayTr1  );
					//두 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow2 = alignToTableSize( data.header.length, arrayTr2  );
					//세 번째 행에 헤더 부분 이미 header 개수만큼되어있음.
					   
				    //거꾸로 감, 제일 위에가 제일 밑으로 감
			        let desc = [
			        	arrayRow2	//두 번째 행
				        , arrayRow1	//첫 번째 행
					];

			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }
            },
            {
                extend: 'print',
                title: '생산실적관리 - 기종별',
            },
        ],
		drawCallback: function () {
			$('#outputTable1 tfoot').remove();
			
			//총 생산량
			let sumTotalOutputCnt1	=	parseInt($('#outputTable1').DataTable().column(5,{ page: 'all'} ).data().sum())
									 	+ parseInt($('#outputTable1').DataTable().column(8,{ page: 'all'} ).data().sum())
									 	
										+ parseInt($('#outputTable1').DataTable().column(22,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(25,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(28,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(31,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(34,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(37,{ page: 'all'} ).data().sum());
			
			// 생산량
			let sumOutputNomal1		=	$('#outputTable1').DataTable().column(5,{ page: 'all'} ).data().sum()
										+ $('#outputTable1').DataTable().column(8,{ page: 'all'} ).data().sum();
			
			//양품 생산량
			let sumOutputCnt1		=	$('#outputTable1').DataTable().column(5,{ page: 'all'} ).data().sum();
			
			//SCRAP발생수량
			let sumFaultyCnt1 		=	parseInt($('#outputTable1').DataTable().column(22,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(25,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(28,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(31,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(34,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable1').DataTable().column(37,{ page: 'all'} ).data().sum());
			//SCRAP발생률(%)
			let sumFaultyPercent1	=	( sumFaultyCnt1 / parseFloat($('#outputTable1').DataTable().column(19,{ page: 'all'} ).data().sum())  * 100 ).toFixed(1) + ' %';
			
			//불량률
			let sumMatrlPercent1	= (parseInt($('#outputTable1').DataTable().column(22,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable1').DataTable().column(19,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sumReplacePercent1	= (parseInt($('#outputTable1').DataTable().column(25,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable1').DataTable().column(19,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sumTroublePercent1	= (parseInt($('#outputTable1').DataTable().column(28,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable1').DataTable().column(19,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum114Percent1		= (parseInt($('#outputTable1').DataTable().column(31,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable1').DataTable().column(19,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum115Percent1		= (parseInt($('#outputTable1').DataTable().column(34,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable1').DataTable().column(19,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum116Percent1		= (parseInt($('#outputTable1').DataTable().column(37,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable1').DataTable().column(19,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			//불량률
		
			$('#sumOutputNomal1').text(addCommas(sumOutputNomal1));
			$('#sumTotalOutputCnt1').text(addCommas(parseFloat(sumTotalOutputCnt1).toFixed(0)));
			$('#sumOutputCnt1').text(addCommas(sumOutputCnt1));
			$('#sumFaultyPercent1').text(addCommas(sumFaultyPercent1 == "NaN %" ? "0.0 %" : sumFaultyPercent1));
			$('#sumFaultyCnt1').text(addCommas(parseFloat(sumFaultyCnt1).toFixed(0)));
			
			//불량률
			$('#sumMatrlPercent1').text(addCommas(sumMatrlPercent1 == "NaN %" ? "0.0 %" : sumMatrlPercent1));
			$('#sumReplacePercent1').text(addCommas(sumReplacePercent1 == "NaN %" ? "0.0 %" : sumReplacePercent1));
			$('#sumTroublePercent1').text(addCommas(sumTroublePercent1 == "NaN %" ? "0.0 %" : sumTroublePercent1));
			$('#sum114Percent1').text(addCommas(sum114Percent1 == "NaN %" ? "0.0 %" : sum114Percent1));
			$('#sum115Percent1').text(addCommas(sum115Percent1 == "NaN %" ? "0.0 %" : sum115Percent1));
			$('#sum116Percent1').text(addCommas(sum116Percent1 == "NaN %" ? "0.0 %" : sum116Percent1));
			//불량률

			//불량(횟수, kG, EA)
			var api = this.api();
			
            api.columns('.sudelSum', { page: 'current' }).every(function() {
                var sum = this.data().reduce(function(a, b) {
                    var x = String(a);
                        x = parseFloat( x.replace(/,/g,'') );
                        //x = Math.round(x * 100) / 100;
                    
                    var y = String(b);
                        y = parseFloat( y.replace(/,/g,'') );
                        //y = Math.round(y * 100) / 100;

                    theSum = (x + y).toFixed(0);

                	return theSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
				}, 0);
            	//console.log(sum);
            	$(this.footer()).html(sum);
            });
            
            
            api.columns('.sudelFloatSum', { page: 'current' }).every(function() {
                var sum = this.data().reduce(function(a, b) {
                    var x = String(a);
                        x = parseFloat( x.replace(/,/g,'') );
                        //x = Math.round(x * 100) / 100;
                    
                    var y = String(b);
                        y = parseFloat( y.replace(/,/g,'') );
                        //y = Math.round(y * 100) / 100;

                    theSum = (x + y).toFixed(3);

                	return theSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
				}, 0);
            	$(this.footer()).html(sum);
            });
          	//불량(횟수, kG, EA)
		},
	});

	var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
		html1 += '&nbsp;<label class="input-label-sm">생산일</label><input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal1"/>';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateFromCal1,chooseDateFromCal1,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar1" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
		html1 += '<div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal1"/>';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateToCal1,chooseDateToCal1,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar1" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
		html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm1">기간선택</button>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv1">조회</button>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary float-right bumlye">범례</button>';
		html1 += '&nbsp;&nbsp;<h6 class="mb-0 p-1" id="basketWeight">...</h6></div>';

	$('#outputTable1_length').html(html1);
	$('#chooseDateFromCal1').val(chooseDateFrom);
	$('#chooseDateToCal1').val(chooseDateTo);
	$('#basketWeight').text("바구니 무게 : " + basketWeight + "KG (Strip Loss는 제외됩니다.)");
	
	
	$.fn.dataTable.ext.errMode = 'none';
	let outputTable2 = $('#outputTable2').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: true,
        scrollX : true,
        fixedColumns: {
			leftColumns: 5
		},
        scrollY : "56vh",
        scrollCollapse: true,
        pageLength: -1,
        ajax: {
            url: '<c:url value="wm/readActualOutputEquipsList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
            	'chooseDate1'	:	function() { return chooseDateFrom.replace(/-/g, ''); },
            	'chooseDate2'	:	function() { return chooseDateTo.replace(/-/g, ''); },
            },
        },
		columns: [
			{ data: 'equipNm' },
			{ data: 'dayNightNm' },
			{ data: 'goodsNm' },
			{ data: 'qutyNm' },
			{ data: 'model' },
			
		/* 	{ data: 'sumTargetCnt' },
			{ data: '',	//목표 양품생산량 %
				render: function(data, type, row) {
					let temp = (row['sumOutputCnt'] / row['sumTargetCnt'] * 100).toFixed(1);
					if (temp == 'NaN') {
						return '0.0 %';
					} else {
						return addCommas(temp) + ' %';		
					}
				}
            }, */
            
			{ data: '',	//총생산량
				render: function(data, type, row) {
					//return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
					return addCommas((parseInt(row['sumOutputCnt']) + parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7']) + parseInt(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            { data: '',	//생산량
				render: function(data, type, row) {
					//return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
					return addCommas((parseInt(row['sumOutputCnt']) + parseInt(row['outputFaultyCnt'])).toFixed(0));
				}
            },
			{ data: 'sumOutputCnt' },
			/*{ data: '',	//불량률
				render: function(data, type, row) {
					//불량수량
					let totalFaultyEa = parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])
					let faultyPercent = (totalFaultyEa / (parseFloat(row['sumOutputCnt']) + totalFaultyEa) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//불량수량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])).toFixed(0));
				}
            },*/
            
            { data: '',	//SCRAP발생률
				render: function(data, type, row) {
					//SCRAP발생수량
					let totalFaultyEa = parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7'])
					//let faultyPercent = (totalFaultyEa / (parseFloat(row['sumOutputCnt']) + totalFaultyEa) * 100).toFixed(1);
					let faultyPercent = (totalFaultyEa / parseInt(row['prcsTotal']) * 100 ).toFixed(1);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//SCRAP발생수량
				render: function(data, type, row) {
					return addCommas((parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7']) ).toFixed(0)  );
				}
            },
			
            { data: 'outputFaultyCnt' },
        	{ data: 'appearFaultyCnt' },
			{ data: 'edgeFaultyCnt' },
			{ data: 'shipFaultyCnt' },
			{ data: 'reShipFaultyCnt' },
			/* { data: '',	//processFaultyNm 불량률(%)
				render: function(data, type, row) {
					let totalOutput = parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']);
					let faultyPercent = (parseFloat(row['prcsEa']) / totalOutput * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['prcsEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            }, */
			/* { data: '',	//matrlFaultyNm 불량률(%)
				render: function(data, type, row) {
					let totalOutput = parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']);
					let faultyPercent = (parseFloat(row['matrlEa']) / totalOutput * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['matrlEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//replaceFaultyNm 불량률(%)
				render: function(data, type, row) {
					let totalOutput = parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']);
					let faultyPercent = (parseFloat(row['rpcEa']) / totalOutput * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['rpcEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//troubleFaultyNm 불량률(%)
				render: function(data, type, row) {
					let totalOutput = parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']);
					let faultyPercent = (parseFloat(row['trbEa']) / totalOutput * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['trbEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            }, */
            
            
            { data: '',	//Metal 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['matrlEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || parseFloat(row['matrlEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//Film 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['rpcEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || parseFloat(row['rpcEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//Teflon 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['trbEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['trbEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea5']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea6']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea7']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            
            { data: 'prcsTotal'},		//Cutting 수량 (EA)
            
            /* { data: 'prcsCnt'},		//횟수
			{ data: 'prcsTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'prcsEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 }, */
			{ data: 'matrlCnt' },		//횟수
			{ data: 'matrlTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'matrlEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			{ data: 'rpcCnt' },		//횟수
			{ data: 'rpcTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'rpcEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			{ data: 'trbCnt' },	//횟수
			{ data: 'trbTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'trbEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			},
			
			
			{ data: 'cnt5' },	//횟수
			{ data: 'total5',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
	        },
			{ data: 'ea5',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			},
			{ data: 'cnt6' },	//횟수
			{ data: 'total6',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
	        },
			{ data: 'ea6',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			},
			{ data: 'cnt7' },	//횟수
			{ data: 'total7',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
	        },
			{ data: 'ea7',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			},
			
			 
		],
        columnDefs: [
        	{ targets: [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [5,6,7,8,9, 15,16,17,18,19,20], className: 'text-right' },
        	
        	{ targets: [10,11,12,13,14, 21, 22,24, 25,27, 28,30, 31,33, 34,36, 37,39], className: 'sudelSum2 text-right' },
        	{ targets: [23,26,29,32,35,38], className: 'sudelFloatSum2 text-right' },
        ],
		order: [
			//[ 0, 'asc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: '생산실적관리 - 라인별',
            },
            {
            	extend: 'excel',
                title: '생산실적관리 - 라인별',
                footer: true,
                //excelCss
			    customize: function ( xlsx ) {
			        var sheet = xlsx.xl.worksheets['sheet1.xml'];
			        
			        //Bold Header Row
			        $('row[r=3] c', sheet).attr( 's', '2' );
			        $('row[r=4] c', sheet).attr( 's', '2' );
			        $('row[r=5] c', sheet).attr( 's', '2' );
			        
			        //Make Cells Bold
			        $('c[r=A1]', sheet).attr( 's', '2' );
			        $('c[r=A3]', sheet).attr( 's', '2' );

			        //가운데
			        $('row[r=1] c', sheet).attr( 's', '51' );
			        $('row[r=3] c', sheet).attr( 's', '51' );

			        //배경 색
			        /*$('row[r=3] c', sheet).attr( 's', '30' );
			        $('row[r=4] c', sheet).attr( 's', '30' );
			        $('row[r=5] c', sheet).attr( 's', '30' );*/

			        $('row[r=2] c', sheet).remove();	//2번째 행 데이터 삭제

			      	//병합 하고자 하는 셀 지정 
			      	var mergeCells = $('mergeCells', sheet);

			      	//rowspan
					/* mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A3:A4'} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'B3:B4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'C3:C4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'D3:D4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'E3:E4'} } )
					);
					
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'F3:F4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'G3:G4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'H3:H4'} } )
					); */
					//rowspan
					//병합 하고자 하는 셀 지정 끝

	                mergeCells.attr( 'count', mergeCells.attr( 'count' )+1 );

	                function createNode( doc, nodeName, opts ) {
						var tempNode = doc.createElement( nodeName );
	                    if ( opts ) {
							if ( opts.attr ) {
	                        	$(tempNode).attr( opts.attr );
	                      	}
	   
	                      	if ( opts.children ) {
	                        	$.each( opts.children, function ( key, value ) {
	                          		tempNode.appendChild( value );
	                        	} );
	                      	}
	   
	                      	if ( opts.text !== null && opts.text !== undefined ) {
	                        	tempNode.appendChild( doc.createTextNode( opts.text ) );
	                      	}
	                    }
	                    return tempNode;
					}
			    },
			  	//excelCssEnd

			    //헤더 추가하는 부분
			    customizeData: function(data) {
				   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				 	//첫 번째 tr
				 	 let arrayTr1 = colspanGroupArray('outputTable2', 0, 'th', $('#outputTable2 thead tr').eq(0).find('th').length, 10, 'Y', '');
				 	//두 번째 tr
				 	 let arrayTr2 = colspanGroupArray('outputTable2', 1, 'th', $('#outputTable2 thead tr').eq(1).find('th').length, 10, 'N', arrayTr1);
					
					//첫 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow1 = alignToTableSize( data.header.length, arrayTr1  );
					//두 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow2 = alignToTableSize( data.header.length, arrayTr2  );
					//세 번째 행에 헤더 부분 이미 header 개수만큼되어있음.
					   
				    //거꾸로 감, 제일 위에가 제일 밑으로 감
			        let desc = [
			        	arrayRow2	//두 번째 행
				        , arrayRow1	//첫 번째 행
					];

			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }
            },
            {
                extend: 'print',
                title: '생산실적관리 - 라인별',
            },
        ],
		drawCallback: function () {
			$('#outputTable2 tfoot').remove();
			
			//총 생산량
			let sumTotalOutputCnt2	=	parseInt($('#outputTable2').DataTable().column(7,{ page: 'all'} ).data().sum())
									 	+ parseInt($('#outputTable2').DataTable().column(10,{ page: 'all'} ).data().sum())
									 	
										+ parseInt($('#outputTable2').DataTable().column(24,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(27,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(30,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(33,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(36,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(39,{ page: 'all'} ).data().sum());
			
			// 생산량
			let sumOutputNomal2		=	$('#outputTable2').DataTable().column(7,{ page: 'all'} ).data().sum()
										+ $('#outputTable2').DataTable().column(10,{ page: 'all'} ).data().sum();
			
			//양품 생산량
			let sumOutputCnt2		=	$('#outputTable2').DataTable().column(7,{ page: 'all'} ).data().sum();
			
			//SCRAP발생수량
			let sumFaultyCnt2 		=	parseInt($('#outputTable2').DataTable().column(24,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(27,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(30,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(33,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(36,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable2').DataTable().column(39,{ page: 'all'} ).data().sum());
			//SCRAP발생률(%)
			let sumFaultyPercent2	=	( sumFaultyCnt2 / parseFloat($('#outputTable2').DataTable().column(21,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			
			//불량률
			let sumMatrlPercent2	= (parseInt($('#outputTable2').DataTable().column(24,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable2').DataTable().column(21,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sumReplacePercent2	= (parseInt($('#outputTable2').DataTable().column(27,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable2').DataTable().column(21,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sumTroublePercent2	= (parseInt($('#outputTable2').DataTable().column(30,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable2').DataTable().column(21,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum114Percent2		= (parseInt($('#outputTable2').DataTable().column(33,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable2').DataTable().column(21,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum115Percent2		= (parseInt($('#outputTable2').DataTable().column(36,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable2').DataTable().column(21,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum116Percent2		= (parseInt($('#outputTable2').DataTable().column(39,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable2').DataTable().column(21,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			//불량률
		
			$('#sumOutputNomal2').text(addCommas(sumOutputNomal2));
			$('#sumTotalOutputCnt2').text(addCommas(parseFloat(sumTotalOutputCnt2).toFixed(0)));
			$('#sumOutputCnt2').text(addCommas(sumOutputCnt2));
			$('#sumFaultyPercent2').text(addCommas(sumFaultyPercent2 == "NaN %" ? "0.0 %" : sumFaultyPercent2));
			$('#sumFaultyCnt2').text(addCommas(parseFloat(sumFaultyCnt2).toFixed(0)));
			
			//불량률
			/* $('#sumMatrlPercent2').text(addCommas(sumMatrlPercent2));
			$('#sumReplacePercent2').text(addCommas(sumReplacePercent2));
			$('#sumTroublePercent2').text(addCommas(sumTroublePercent2));
			$('#sum114Percent2').text(addCommas(sum114Percent2));
			$('#sum115Percent2').text(addCommas(sum115Percent2));
			$('#sum116Percent2').text(addCommas(sum116Percent2)); */
			
			$('#sumMatrlPercent2').text(addCommas(sumMatrlPercent2 == "NaN %" ? "0.0 %" : sumMatrlPercent2));
			$('#sumReplacePercent2').text(addCommas(sumReplacePercent2 == "NaN %" ? "0.0 %" : sumReplacePercent2));
			$('#sumTroublePercent2').text(addCommas(sumTroublePercent2 == "NaN %" ? "0.0 %" : sumTroublePercent2));
			$('#sum114Percent2').text(addCommas(sum114Percent2 == "NaN %" ? "0.0 %" : sum114Percent2));
			$('#sum115Percent2').text(addCommas(sum115Percent2 == "NaN %" ? "0.0 %" : sum115Percent2));
			$('#sum116Percent2').text(addCommas(sum116Percent2 == "NaN %" ? "0.0 %" : sum116Percent2));
			
			//불량률

			//불량(횟수, kG, EA)
			var api = this.api();
			
            api.columns('.sudelSum2', { page: 'current' }).every(function() {
                var sum = this.data().reduce(function(a, b) {
                    var x = String(a);
                        x = parseFloat( x.replace(/,/g,'') );
                        //x = Math.round(x * 100) / 100;
                    
                    var y = String(b);
                        y = parseFloat( y.replace(/,/g,'') );
                        //y = Math.round(y * 100) / 100;

                    theSum = (x + y).toFixed(0);

                	return theSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
				}, 0);
            	$(this.footer()).html(sum);
            });
            
            api.columns('.sudelFloatSum2', { page: 'current' }).every(function() {
                var sum = this.data().reduce(function(a, b) {
                    var x = String(a);
                        x = parseFloat( x.replace(/,/g,'') );
                        //x = Math.round(x * 100) / 100;
                    
                    var y = String(b);
                        y = parseFloat( y.replace(/,/g,'') );
                        //y = Math.round(y * 100) / 100;

                    theSum = (x + y).toFixed(3);

                	return theSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
				}, 0);
            	$(this.footer()).html(sum);
            });
          	//불량(횟수, kG, EA)
			
		},
	});

	var html2 = '<div class="row"><div class="form-group input-sub m-0 row">';
		html2 += '&nbsp;<label class="input-label-sm">생산일</label><input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal2"/>';
		html2 += '<button onclick="fnPopUpCalendar(chooseDateFromCal2,chooseDateFromCal2,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar2" type="button">';
		html2 += '<span class="oi oi-calendar"></span>';
		html2 += '</button>';
		html2 += '</div>';
		html2 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
		html2 += '<div class="form-group input-sub m-0 row">';
		html2 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal2"/>';
		html2 += '<button onclick="fnPopUpCalendar(chooseDateToCal2,chooseDateToCal2,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar2" type="button">';
		html2 += '<span class="oi oi-calendar"></span>';
		html2 += '</button>';
		html2 += '</div>';
		html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm2">기간선택</button>';
		html2 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv2">조회</button></div>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary float-right bumlye">범례</button></div>';
	$('#outputTable2_length').html(html2);
	$('#chooseDateFromCal2').val(chooseDateFrom);
	$('#chooseDateToCal2').val(chooseDateTo);
	
	$.fn.dataTable.ext.errMode = 'none';
	let outputTable3 = $('#outputTable3').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: true,
        pageLength: -1,
        scrollX : true,
        fixedColumns: {
			leftColumns: 4
		},
        scrollY : "56vh",
        scrollCollapse: true,
        ajax: {
            url: '<c:url value="wm/readActualOutputPeopolesList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
            	'chooseDate1'	:	function() { return chooseDateFrom.replace(/-/g, ''); },
            	'chooseDate2'	:	function() { return chooseDateTo.replace(/-/g, ''); },
            	'userNumber'	:	function() { return userNumber;},
            },
        },
		columns: [
			{ data: 'userNm' },
			{ data: 'goodsNm' },
			{ data: 'qutyNm' },
			{ data: 'model' },
			
			/* { data: 'sumTargetCnt' },
			{ data: '',	//목표 양품생산량 %
				render: function(data, type, row) {
					let temp = (row['sumOutputCnt'] / row['sumTargetCnt'] * 100).toFixed(1);
					if (temp == 'NaN') {
						return '0.0 %';
					} else {
						return addCommas(temp) + ' %';		
					}
				}
            }, */
            /* { data: '',	//총생산량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            { data: '',	//생산량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
				}
            }, */
            
            { data: '',	//총생산량
				render: function(data, type, row) {
					return addCommas((parseInt(row['sumOutputCnt']) + parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7']) + parseInt(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            { data: '',	//생산량
				render: function(data, type, row) {
					return addCommas((parseInt(row['sumOutputCnt']) + parseInt(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            
			{ data: 'sumOutputCnt' },
			
			/*{ data: '',	//불량률
				render: function(data, type, row) {
					//불량수량
					let totalFaultyEa = parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])
					let faultyPercent = (totalFaultyEa / (parseFloat(row['sumOutputCnt']) + totalFaultyEa) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//불량수량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])).toFixed(0));
				}
            },*/
            
            { data: '',	//SCRAP발생률
				render: function(data, type, row) {
					//SCRAP발생수량
					let totalFaultyEa = parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7'])
					//let faultyPercent = (totalFaultyEa / (parseFloat(row['sumOutputCnt']) + totalFaultyEa) * 100).toFixed(1);
					let faultyPercent = (totalFaultyEa / parseInt(row['prcsTotal']) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//SCRAP발생수량
				render: function(data, type, row) {
					return addCommas((parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7']) ).toFixed(0)  );
				}
            },
            
            { data: 'outputFaultyCnt' },
        	{ data: 'appearFaultyCnt' },
			{ data: 'edgeFaultyCnt' },
			{ data: 'shipFaultyCnt' },
			{ data: 'reShipFaultyCnt' },
		/* 	{ data: '',	//processFaultyNm 불량률(%)
				render: function(data, type, row) {
					let totalOutput = parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']);
					let faultyPercent = (parseFloat(row['prcsEa']) / totalOutput * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['prcsEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//matrlFaultyNm 불량률(%)
				render: function(data, type, row) {
					let totalOutput = parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']);
					let faultyPercent = (parseFloat(row['matrlEa']) / totalOutput * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['matrlEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//replaceFaultyNm 불량률(%)
				render: function(data, type, row) {
					let totalOutput = parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']);
					let faultyPercent = (parseFloat(row['rpcEa']) / totalOutput * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['rpcEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//troubleFaultyNm 불량률(%)
				render: function(data, type, row) {
					let totalOutput = parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']);
					let faultyPercent = (parseFloat(row['trbEa']) / totalOutput * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['trbEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            }, */
            
            
            { data: '',	//Metal 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['matrlEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || parseFloat(row['matrlEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//Film 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['rpcEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || parseFloat(row['rpcEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//Teflon 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['trbEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['trbEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea5']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea6']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea7']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            
           /*  { data: 'prcsCnt'},		//횟수
			{ data: 'prcsTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'prcsEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 }, */
			 
			{ data: 'prcsTotal'},		//Cutting 수량 (EA)
			
			{ data: 'matrlCnt' },		//횟수
			{ data: 'matrlTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'matrlEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			{ data: 'rpcCnt' },		//횟수
			{ data: 'rpcTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'rpcEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			{ data: 'trbCnt' },	//횟수
			{ data: 'trbTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'trbEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			 
			 { data: 'cnt5' },	//횟수
				{ data: 'total5',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return parseFloat(data).toFixed(3);
						}
					}
		        },
				{ data: 'ea5',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return addCommas(parseFloat(data).toFixed(0));
						}
					}
				},
				{ data: 'cnt6' },	//횟수
				{ data: 'total6',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return parseFloat(data).toFixed(3);
						}
					}
		        },
				{ data: 'ea6',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return addCommas(parseFloat(data).toFixed(0));
						}
					}
				},
				{ data: 'cnt7' },	//횟수
				{ data: 'total7',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return parseFloat(data).toFixed(3);
						}
					}
		        },
				{ data: 'ea7',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return addCommas(parseFloat(data).toFixed(0));
						}
					}
				},
		],
        columnDefs: [
        	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4,5,6,7,8, 14,15,16,17,18,19], className: 'text-right' },
        	
        	{ targets: [9,10,11,12,13, 20, 21,23, 24,26, 27,29, 30,32, 33,35, 36,38], className: 'sudelSum3 text-right' },
        	{ targets: [22,25,28,31,34,37], className: 'sudelFloatSum3 text-right' },
        ],
		order: [
			//[ 0, 'asc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: '생산실적관리 - 직원별',
            },
            {
            	extend: 'excel',
                title: '생산실적관리 - 직원별',
                footer: true,
                //excelCss
			    customize: function ( xlsx ) {
			        var sheet = xlsx.xl.worksheets['sheet1.xml'];
			        
			        //Bold Header Row
			        $('row[r=3] c', sheet).attr( 's', '2' );
			        $('row[r=4] c', sheet).attr( 's', '2' );
			        $('row[r=5] c', sheet).attr( 's', '2' );
			        
			        //Make Cells Bold
			        $('c[r=A1]', sheet).attr( 's', '2' );
			        $('c[r=A3]', sheet).attr( 's', '2' );

			        //가운데
			        $('row[r=1] c', sheet).attr( 's', '51' );
			        $('row[r=3] c', sheet).attr( 's', '51' );

			        //배경 색
			        /*$('row[r=3] c', sheet).attr( 's', '30' );
			        $('row[r=4] c', sheet).attr( 's', '30' );
			        $('row[r=5] c', sheet).attr( 's', '30' );*/

			        $('row[r=2] c', sheet).remove();	//2번째 행 데이터 삭제

			      	//병합 하고자 하는 셀 지정 
			      	var mergeCells = $('mergeCells', sheet);

			      	//rowspan
					/* mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A3:A4'} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'B3:B4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'C3:C4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'D3:D4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'E3:E4'} } )
					);
					
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'F3:F4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'G3:G4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'H3:H4'} } )
					); */
					//rowspan
					//병합 하고자 하는 셀 지정 끝

	                mergeCells.attr( 'count', mergeCells.attr( 'count' )+1 );

	                function createNode( doc, nodeName, opts ) {
						var tempNode = doc.createElement( nodeName );
	                    if ( opts ) {
							if ( opts.attr ) {
	                        	$(tempNode).attr( opts.attr );
	                      	}
	   
	                      	if ( opts.children ) {
	                        	$.each( opts.children, function ( key, value ) {
	                          		tempNode.appendChild( value );
	                        	} );
	                      	}
	   
	                      	if ( opts.text !== null && opts.text !== undefined ) {
	                        	tempNode.appendChild( doc.createTextNode( opts.text ) );
	                      	}
	                    }
	                    return tempNode;
					}
			    },
			  	//excelCssEnd

			    //헤더 추가하는 부분
			    customizeData: function(data) {
				   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				 	//첫 번째 tr
				 	 let arrayTr1 = colspanGroupArray('outputTable3', 0, 'th', $('#outputTable3 thead tr').eq(0).find('th').length, 9, 'Y', '');
				 	//두 번째 tr
				 	 let arrayTr2 = colspanGroupArray('outputTable3', 1, 'th', $('#outputTable3 thead tr').eq(1).find('th').length, 9, 'N', arrayTr1);
					
					//첫 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow1 = alignToTableSize( data.header.length, arrayTr1  );
					//두 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow2 = alignToTableSize( data.header.length, arrayTr2  );
					//세 번째 행에 헤더 부분 이미 header 개수만큼되어있음.
					   
				    //거꾸로 감, 제일 위에가 제일 밑으로 감
			        let desc = [
			        	arrayRow2	//두 번째 행
				        , arrayRow1	//첫 번째 행
					];

			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }
            },
            {
                extend: 'print',
                title: '생산실적관리 - 직원별',
            },
        ],
		drawCallback: function () {

			$('#outputTable3 tfoot').remove();
			
			//총 생산량
			let sumTotalOutputCnt3	=	parseInt($('#outputTable3').DataTable().column(6,{ page: 'all'} ).data().sum())
									 	+ parseInt($('#outputTable3').DataTable().column(9,{ page: 'all'} ).data().sum())
									 	
										+ parseInt($('#outputTable3').DataTable().column(23,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(26,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(29,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(32,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(35,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(38,{ page: 'all'} ).data().sum());
			
			// 생산량
			let sumOutputNomal3		=	$('#outputTable3').DataTable().column(6,{ page: 'all'} ).data().sum()
										+ $('#outputTable3').DataTable().column(9,{ page: 'all'} ).data().sum();
			
			//양품 생산량
			let sumOutputCnt3		=	$('#outputTable3').DataTable().column(6,{ page: 'all'} ).data().sum();
			
			//SCRAP발생수량
			let sumFaultyCnt3 		=	parseInt($('#outputTable3').DataTable().column(23,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(26,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(29,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(32,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(35,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable3').DataTable().column(38,{ page: 'all'} ).data().sum());
			//SCRAP발생률(%)
			let sumFaultyPercent3	=	( sumFaultyCnt3 / parseFloat($('#outputTable3').DataTable().column(20,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			
			//불량률
			let sumMatrlPercent3	= (parseInt($('#outputTable3').DataTable().column(23,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable3').DataTable().column(20,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sumReplacePercent3	= (parseInt($('#outputTable3').DataTable().column(26,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable3').DataTable().column(20,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sumTroublePercent3	= (parseInt($('#outputTable3').DataTable().column(29,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable3').DataTable().column(20,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum114Percent3		= (parseInt($('#outputTable3').DataTable().column(32,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable3').DataTable().column(20,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum115Percent3		= (parseInt($('#outputTable3').DataTable().column(35,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable3').DataTable().column(20,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum116Percent3		= (parseInt($('#outputTable3').DataTable().column(38,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable3').DataTable().column(20,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			//불량률
		
			$('#sumOutputNomal3').text(addCommas(sumOutputNomal3));
			$('#sumTotalOutputCnt3').text(addCommas(parseFloat(sumTotalOutputCnt3).toFixed(0)));
			$('#sumOutputCnt3').text(addCommas(sumOutputCnt3));
			$('#sumFaultyPercent3').text(addCommas(sumFaultyPercent3 == "NaN %" ? "0.0 %" : sumFaultyPercent3));
			$('#sumFaultyCnt3').text(addCommas(parseFloat(sumFaultyCnt3).toFixed(0)));
			
			//불량률
			$('#sumMatrlPercent3').text(addCommas(sumMatrlPercent3 == "NaN %" ? "0.0 %" : sumMatrlPercent3));
			$('#sumReplacePercent3').text(addCommas(sumReplacePercent3 == "NaN %" ? "0.0 %" : sumReplacePercent3));
			$('#sumTroublePercent3').text(addCommas(sumTroublePercent3 == "NaN %" ? "0.0 %" : sumTroublePercent3));
			$('#sum114Percent3').text(addCommas(sum114Percent3 == "NaN %" ? "0.0 %" : sum114Percent3));
			$('#sum115Percent3').text(addCommas(sum115Percent3 == "NaN %" ? "0.0 %" : sum115Percent3));
			$('#sum116Percent3').text(addCommas(sum116Percent3 == "NaN %" ? "0.0 %" : sum116Percent3));
			//불량률

			//불량(횟수, kG, EA)
			var api = this.api();
			
            api.columns('.sudelSum3', { page: 'current' }).every(function() {
                var sum = this.data().reduce(function(a, b) {
                    var x = String(a);
                        x = parseFloat( x.replace(/,/g,'') );
                        //x = Math.round(x * 100) / 100;
                    
                    var y = String(b);
                        y = parseFloat( y.replace(/,/g,'') );
                        //y = Math.round(y * 100) / 100;

                    theSum = (x + y).toFixed(0);

                	return theSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
				}, 0);
            	$(this.footer()).html(sum);
            });
            
            api.columns('.sudelFloatSum3', { page: 'current' }).every(function() {
                var sum = this.data().reduce(function(a, b) {
                    var x = String(a);
                        x = parseFloat( x.replace(/,/g,'') );
                        //x = Math.round(x * 100) / 100;
                    
                    var y = String(b);
                        y = parseFloat( y.replace(/,/g,'') );
                        //y = Math.round(y * 100) / 100;

                    theSum = (x + y).toFixed(3);

                	return theSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
				}, 0);
            	$(this.footer()).html(sum);
            });
          	//불량(횟수, kG, EA)
		},
	});

	var html3 = '<div class="row"><div class="form-group input-sub m-0 row">';
		html3 += '&nbsp;<label class="input-label-sm">생산일</label><input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal3"/>';
		html3 += '<button onclick="fnPopUpCalendar(chooseDateFromCal3,chooseDateFromCal3,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar3" type="button">';
		html3 += '<span class="oi oi-calendar"></span>';
		html3 += '</button>';
		html3 += '</div>';
		html3 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
		html3 += '<div class="form-group input-sub m-0 row">';
		html3 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal3"/>';
		html3 += '<button onclick="fnPopUpCalendar(chooseDateToCal3,chooseDateToCal3,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar3" type="button">';
		html3 += '<span class="oi oi-calendar"></span>';
		html3 += '</button>';
		html3 += '</div>';
		html3 += '<label class="input-label-sm ml-3">생산자</label>';
		html3 += '<input type="hidden" class="form-control" id="preWorkCharger"  name="preWorkCharger">';
		html3 += '	<div class="input-sub m-0 row">';
	    html3 += '	<input type="text" class="form-control" id="preWorkChargerNm"  name="preWorkChargerNm" disabled>';
	    html3 += '	<button type="button" class="btn btn-primary input-sub-search" id="btnSelPreWorkCharger" onClick="selectPreWorkCharger()">';
		html3 += '	<span class="oi oi-magnifying-glass"></span>';
	    html3 += '</button>';
	    html3 += '</div>';
	    html3 += '<div>';
	    html3 += '<a href="javascript:void(0)" id="cancelSearchUser" class="closebtn"><i class="mdi mdi-close"></i></a>';
	    html3 += '</div>';
	    html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm3">기간선택</button>';
		html3 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv3">조회</button></div>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary float-right bumlye">범례</button></div>';
	$('#outputTable3_length').html(html3);
	$('#chooseDateFromCal3').val(chooseDateFrom);
	$('#chooseDateToCal3').val(chooseDateTo);

	//생산자 선택 취소
	$('#cancelSearchUser').on('click', function() {
		$('#preWorkChargerNm').val('');
		$('#preWorkCharger').val('');
	});

	$.fn.dataTable.ext.errMode = 'none';
	let outputTable4 = $('#outputTable4').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: true,
        pageLength: -1,
        scrollX : true,
        fixedColumns: {
			leftColumns: 1
		},
        scrollY : "56vh",
        scrollCollapse: true,
        ajax: {
            url: '<c:url value="wm/readActualOutputDateList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
            	'chooseDate1'	:	function() { return chooseDateFrom.replace(/-/g, ''); },
            	'chooseDate2'	:	function() { return chooseDateTo.replace(/-/g, ''); },            
            },
        },
		columns: [
			{ data: 'ordDate' ,
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
			
            
            { data: '',	//총생산량
				render: function(data, type, row) {
					return addCommas((parseInt(row['sumOutputCnt']) + parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7']) + parseInt(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            { data: '',	//생산량
				render: function(data, type, row) {
					return addCommas((parseInt(row['sumOutputCnt']) + parseInt(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            
			{ data: 'sumOutputCnt' },
			
		
            
            { data: '',	//SCRAP발생률
				render: function(data, type, row) {
					//SCRAP발생수량
					let totalFaultyEa = parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7'])
					//let faultyPercent = (totalFaultyEa / (parseFloat(row['sumOutputCnt']) + totalFaultyEa) * 100).toFixed(1);
					let faultyPercent = (totalFaultyEa / parseInt(row['prcsTotal']) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//SCRAP발생수량
				render: function(data, type, row) {
					return addCommas((parseInt(row['matrlEa']) + parseInt(row['rpcEa']) + parseInt(row['trbEa']) + parseInt(row['ea5']) + parseInt(row['ea6']) + parseInt(row['ea7']) ).toFixed(0)  );
				}
            },
            
            { data: 'outputFaultyCnt' },
        	{ data: 'appearFaultyCnt' },
			{ data: 'edgeFaultyCnt' },
			{ data: 'shipFaultyCnt' },
			{ data: 'reShipFaultyCnt' },
		
            
            { data: '',	//Metal 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['matrlEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || parseFloat(row['matrlEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//Film 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['rpcEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || parseFloat(row['rpcEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
			{ data: '',	//Teflon 교체 Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['trbEa']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					if (faultyPercent == 'NaN' || parseFloat(row['trbEa']) == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea5']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea6']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//Strip Loss 불량률(%)
				render: function(data, type, row) {
					let faultyPercent = (parseInt(row['ea7']) / parseInt(row['prcsTotal']) * 100).toFixed(1);
					
					if (faultyPercent == 'NaN' || faultyPercent == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
        
			 
			{ data: 'prcsTotal'},		//Cutting 수량 (EA)
			
			{ data: 'matrlCnt' },		//횟수
			{ data: 'matrlTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'matrlEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			{ data: 'rpcCnt' },		//횟수
			{ data: 'rpcTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'rpcEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			{ data: 'trbCnt' },	//횟수
			{ data: 'trbTotal',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
				}
            },
			{ data: 'trbEa',
				render: function(data, type, row) {
					if (data % 1 == 0){
						return data;
					} else {
						return addCommas(parseFloat(data).toFixed(0));
					}
				}
			 },
			 
			 { data: 'cnt5' },	//횟수
				{ data: 'total5',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return parseFloat(data).toFixed(3);
						}
					}
		        },
				{ data: 'ea5',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return addCommas(parseFloat(data).toFixed(0));
						}
					}
				},
				{ data: 'cnt6' },	//횟수
				{ data: 'total6',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return parseFloat(data).toFixed(3);
						}
					}
		        },
				{ data: 'ea6',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return addCommas(parseFloat(data).toFixed(0));
						}
					}
				},
				{ data: 'cnt7' },	//횟수
				{ data: 'total7',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return parseFloat(data).toFixed(3);
						}
					}
		        },
				{ data: 'ea7',
					render: function(data, type, row) {
						if (data % 1 == 0){
							return data;
						} else {
							return addCommas(parseFloat(data).toFixed(0));
						}
					}
				},
		],
        columnDefs: [
        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1,2,3,4,5, 11,12,13,14,15,16], className: 'text-right' },
        	
        	{ targets: [6,7,8,9,10, 17, 18,20, 21,23, 24,26, 27,29, 30,32, 33,35], className: 'sudelSum4 text-right' },
        	{ targets: [19,22,25,28,31,34], className: 'sudelFloatSum4 text-right' },
        ],
		order: [
			//[ 0, 'asc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: '생산실적관리 - 일자별',
            },
            {
            	extend: 'excel',
                title: '생산실적관리 - 일자별',
                footer: true,
                //excelCss
			    customize: function ( xlsx ) {
			        var sheet = xlsx.xl.worksheets['sheet1.xml'];
			        
			        //Bold Header Row
			        $('row[r=3] c', sheet).attr( 's', '2' );
			        $('row[r=4] c', sheet).attr( 's', '2' );
			        $('row[r=5] c', sheet).attr( 's', '2' );
			        
			        //Make Cells Bold
			        $('c[r=A1]', sheet).attr( 's', '2' );
			        $('c[r=A3]', sheet).attr( 's', '2' );

			        //가운데
			        $('row[r=1] c', sheet).attr( 's', '51' );
			        $('row[r=3] c', sheet).attr( 's', '51' );

			        //배경 색
			        /*$('row[r=3] c', sheet).attr( 's', '30' );
			        $('row[r=4] c', sheet).attr( 's', '30' );
			        $('row[r=5] c', sheet).attr( 's', '30' );*/

			        $('row[r=2] c', sheet).remove();	//2번째 행 데이터 삭제

			      	//병합 하고자 하는 셀 지정 
			      	var mergeCells = $('mergeCells', sheet);

			      	//rowspan
					/* mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A3:A4'} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'B3:B4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'C3:C4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'D3:D4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'E3:E4'} } )
					);
					
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'F3:F4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'G3:G4'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'H3:H4'} } )
					); */
					//rowspan
					//병합 하고자 하는 셀 지정 끝

	                mergeCells.attr( 'count', mergeCells.attr( 'count' )+1 );

	                function createNode( doc, nodeName, opts ) {
						var tempNode = doc.createElement( nodeName );
	                    if ( opts ) {
							if ( opts.attr ) {
	                        	$(tempNode).attr( opts.attr );
	                      	}
	   
	                      	if ( opts.children ) {
	                        	$.each( opts.children, function ( key, value ) {
	                          		tempNode.appendChild( value );
	                        	} );
	                      	}
	   
	                      	if ( opts.text !== null && opts.text !== undefined ) {
	                        	tempNode.appendChild( doc.createTextNode( opts.text ) );
	                      	}
	                    }
	                    return tempNode;
					}
			    },
			  	//excelCssEnd

			    //헤더 추가하는 부분
			    customizeData: function(data) {
				   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				 	//첫 번째 tr
				 	 let arrayTr1 = colspanGroupArray('outputTable4', 0, 'th', $('#outputTable4 thead tr').eq(0).find('th').length, 6, 'Y', '');
				 	//두 번째 tr
				 	 let arrayTr2 = colspanGroupArray('outputTable4', 1, 'th', $('#outputTable4 thead tr').eq(1).find('th').length, 6, 'N', arrayTr1);
					
					//첫 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow1 = alignToTableSize( data.header.length, arrayTr1  );
					//두 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow2 = alignToTableSize( data.header.length, arrayTr2  );
					//세 번째 행에 헤더 부분 이미 header 개수만큼되어있음.
					   
				    //거꾸로 감, 제일 위에가 제일 밑으로 감
			        let desc = [
			        	arrayRow2	//두 번째 행
				        , arrayRow1	//첫 번째 행
					];

			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }
            },
            {
                extend: 'print',
                title: '생산실적관리 - 일자별',
            },
        ],
		drawCallback: function () {

			$('#outputTable4 tfoot').remove();
			
			//총 생산량
			let sumTotalOutputCnt4	=	parseInt($('#outputTable4').DataTable().column(3,{ page: 'all'} ).data().sum())
									 	+ parseInt($('#outputTable4').DataTable().column(6,{ page: 'all'} ).data().sum())									 	
										+ parseInt($('#outputTable4').DataTable().column(20,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(23,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(26,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(29,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(32,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(35,{ page: 'all'} ).data().sum());
			
			// 생산량
			let sumOutputNomal4		=	$('#outputTable4').DataTable().column(3,{ page: 'all'} ).data().sum()
										+ $('#outputTable4').DataTable().column(6,{ page: 'all'} ).data().sum();
			
			//양품 생산량
			let sumOutputCnt4		=	$('#outputTable4').DataTable().column(3,{ page: 'all'} ).data().sum();
			
			//SCRAP발생수량
			let sumFaultyCnt4 		=	parseInt($('#outputTable4').DataTable().column(20,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(23,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(26,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(29,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(32,{ page: 'all'} ).data().sum())
										+ parseInt($('#outputTable4').DataTable().column(35,{ page: 'all'} ).data().sum());
			//SCRAP발생률(%)
			let sumFaultyPercent4	=	( sumFaultyCnt4 / parseFloat($('#outputTable4').DataTable().column(17,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			
			//불량률
			let sumMatrlPercent4	= (parseInt($('#outputTable4').DataTable().column(20,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable4').DataTable().column(17,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sumReplacePercent4	= (parseInt($('#outputTable4').DataTable().column(23,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable4').DataTable().column(17,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sumTroublePercent4	= (parseInt($('#outputTable4').DataTable().column(26,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable4').DataTable().column(17,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum114Percent4		= (parseInt($('#outputTable4').DataTable().column(29,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable4').DataTable().column(17,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum115Percent4		= (parseInt($('#outputTable4').DataTable().column(32,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable4').DataTable().column(17,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			let sum116Percent4		= (parseInt($('#outputTable4').DataTable().column(35,{ page: 'all'} ).data().sum()).toFixed(0) / parseFloat($('#outputTable4').DataTable().column(17,{ page: 'all'} ).data().sum()) * 100 ).toFixed(1) + ' %';
			//불량률
		
			$('#sumOutputNomal4').text(addCommas(sumOutputNomal4));
			$('#sumTotalOutputCnt4').text(addCommas(parseFloat(sumTotalOutputCnt4).toFixed(0)));
			$('#sumOutputCnt4').text(addCommas(sumOutputCnt4));
			$('#sumFaultyPercent4').text(addCommas(sumFaultyPercent4 == "NaN %" ? "0.0 %" : sumFaultyPercent4));
			$('#sumFaultyCnt4').text(addCommas(parseFloat(sumFaultyCnt4).toFixed(0)));
			
			//불량률
			$('#sumMatrlPercent4').text(addCommas(sumMatrlPercent4 == "NaN %" ? "0.0 %" : sumMatrlPercent4));
			$('#sumReplacePercent4').text(addCommas(sumReplacePercent4 == "NaN %" ? "0.0 %" : sumReplacePercent4));
			$('#sumTroublePercent4').text(addCommas(sumTroublePercent4 == "NaN %" ? "0.0 %" : sumTroublePercent4));
			$('#sum114Percent4').text(addCommas(sum114Percent4 == "NaN %" ? "0.0 %" : sum114Percent4));
			$('#sum115Percent4').text(addCommas(sum115Percent4 == "NaN %" ? "0.0 %" : sum115Percent4));
			$('#sum116Percent4').text(addCommas(sum116Percent4 == "NaN %" ? "0.0 %" : sum116Percent4));
			//불량률

			//불량(횟수, kG, EA)
			var api = this.api();
			
            api.columns('.sudelSum4', { page: 'current' }).every(function() {
                var sum = this.data().reduce(function(a, b) {
                    var x = String(a);
                        x = parseFloat( x.replace(/,/g,'') );
                        //x = Math.round(x * 100) / 100;
                    
                    var y = String(b);
                        y = parseFloat( y.replace(/,/g,'') );
                        //y = Math.round(y * 100) / 100;

                    theSum = (x + y).toFixed(0);

                	return theSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
				}, 0);
            	$(this.footer()).html(sum);
            });
            
            api.columns('.sudelFloatSum4', { page: 'current' }).every(function() {
                var sum = this.data().reduce(function(a, b) {
                    var x = String(a);
                        x = parseFloat( x.replace(/,/g,'') );
                        //x = Math.round(x * 100) / 100;
                    
                    var y = String(b);
                        y = parseFloat( y.replace(/,/g,'') );
                        //y = Math.round(y * 100) / 100;

                    theSum = (x + y).toFixed(3);

                	return theSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    
				}, 0);
            	$(this.footer()).html(sum);
            });
          	//불량(횟수, kG, EA)
		},
	});

	var html4 = '<div class="row"><div class="form-group input-sub m-0 row">';
		html4 += '&nbsp;<label class="input-label-sm">생산일</label><input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal4"/>';
		html4 += '<button onclick="fnPopUpCalendar(chooseDateFromCal4,chooseDateFromCal4,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar3" type="button">';
		html4 += '<span class="oi oi-calendar"></span>';
		html4 += '</button>';
		html4 += '</div>';
		html4 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
		html4 += '<div class="form-group input-sub m-0 row">';
		html4 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal4"/>';
		html4 += '<button onclick="fnPopUpCalendar(chooseDateToCal4,chooseDateToCal4,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar4" type="button">';
		html4 += '<span class="oi oi-calendar"></span>';
		html4 += '</button>';
		html4 += '</div>';	 
	  
	    html4 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm4">기간선택</button>';
		html4 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv4">조회</button></div>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary float-right bumlye">범례</button></div>';
	$('#outputTable4_length').html(html4);
	$('#chooseDateFromCal4').val(chooseDateFrom);
	$('#chooseDateToCal4').val(chooseDateTo);
	
	$('#tab1, #tab2, #tab3, #tab4').on('click', function() {
		let dateFrom = '';
		let dateTo = '';
		if (tabTemp == 1) {
			dateFrom = new Date($('#chooseDateFromCal1').val());
			dateTo = new Date($('#chooseDateToCal1').val());
		} else if (tabTemp == 2) {
			dateFrom = new Date($('#chooseDateFromCal2').val());
			dateTo = new Date($('#chooseDateToCal2').val());
		} else if (tabTemp == 3) {
			dateFrom = new Date($('#chooseDateFromCal3').val());
			dateTo = new Date($('#chooseDateToCal3').val());
		} else if (tabTemp == 4) {
			dateFrom = new Date($('#chooseDateFromCal4').val());
			dateTo = new Date($('#chooseDateToCal4').val());
		}
		
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			} else if (tabTemp == 3) {
				$('#chooseDateFromCal3').focus();
			} else if (tabTemp == 4) {
				$('#chooseDateFromCal4').focus();
			}
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			} else if (tabTemp == 3) {
				$('#chooseDateFromCal3').focus();
			} else if (tabTemp == 4) {
				$('#chooseDateFromCal4').focus();
			}
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			} else if (tabTemp == 3) {
				$('#chooseDateFromCal3').focus();
			} else if (tabTemp == 4) {
				$('#chooseDateFromCal4').focus();
			}
			return false;
		}
		
		if ( 1 == right($(this).attr('id'), 1)) {
			chooseDateFrom = $('#chooseDateFromCal' + tabTemp).val();
			chooseDateTo = $('#chooseDateToCal' + tabTemp).val();
			tabTemp = 1;
			$('#chooseDateFromCal' + tabTemp).val(chooseDateFrom);
			$('#chooseDateToCal' + tabTemp).val(chooseDateTo);
			$("#btnRetv1").trigger("click");
			$('#tabContent1').removeClass('d-none');
			$('#tabContent2').addClass('d-none');
			$('#tabContent3').addClass('d-none');
			$('#tabContent4').addClass('d-none');
		} else if ( 2 == right($(this).attr('id'), 1)) {
			chooseDateFrom = $('#chooseDateFromCal' + tabTemp).val();
			chooseDateTo = $('#chooseDateToCal' + tabTemp).val();
			tabTemp = 2;
			$('#chooseDateFromCal' + tabTemp).val(chooseDateFrom);
			$('#chooseDateToCal' + tabTemp).val(chooseDateTo);
			$("#btnRetv2").trigger("click");
			$('#tabContent1').addClass('d-none');
			$('#tabContent2').removeClass('d-none');
			$('#tabContent3').addClass('d-none');
			$('#tabContent4').addClass('d-none');
		} else if ( 3 == right($(this).attr('id'), 1)) {
			chooseDateFrom = $('#chooseDateFromCal' + tabTemp).val();
			chooseDateTo = $('#chooseDateToCal' + tabTemp).val();
			tabTemp = 3;
			$('#chooseDateFromCal' + tabTemp).val(chooseDateFrom);
			$('#chooseDateToCal' + tabTemp).val(chooseDateTo);
			$("#btnRetv3").trigger("click");
			$('#tabContent1').addClass('d-none');
			$('#tabContent2').addClass('d-none');
			$('#tabContent3').removeClass('d-none');
			$('#tabContent4').addClass('d-none');
		} else if ( 4 == right($(this).attr('id'), 1)) {
			chooseDateFrom = $('#chooseDateFromCal' + tabTemp).val();
			chooseDateTo = $('#chooseDateToCal' + tabTemp).val();
			tabTemp = 4;
			$('#chooseDateFromCal' + tabTemp).val(chooseDateFrom);
			$('#chooseDateToCal' + tabTemp).val(chooseDateTo);
			$("#btnRetv4").trigger("click");
			$('#tabContent1').addClass('d-none');
			$('#tabContent2').addClass('d-none');
			$('#tabContent3').addClass('d-none');
			$('#tabContent4').removeClass('d-none');
		}
		
    });

	$('#btnRetv1, #btnRetv2, #btnRetv3, #btnRetv4').on('click', function() {
		let dateFrom = '';
		let dateTo = '';
		if (tabTemp == 1) {
			dateFrom = new Date($('#chooseDateFromCal1').val());
			dateTo = new Date($('#chooseDateToCal1').val());
		} else if (tabTemp == 2) {
			dateFrom = new Date($('#chooseDateFromCal2').val());
			dateTo = new Date($('#chooseDateToCal2').val());
		} else if (tabTemp == 3) {
			dateFrom = new Date($('#chooseDateFromCal3').val());
			dateTo = new Date($('#chooseDateToCal3').val());
		} else if (tabTemp == 4) {
			dateFrom = new Date($('#chooseDateFromCal4').val());
			dateTo = new Date($('#chooseDateToCal4').val());
		}
		
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			} else if (tabTemp == 3) {
				$('#chooseDateFromCal3').focus();
			} else if (tabTemp == 4) {
				$('#chooseDateFromCal4').focus();
			}
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			} else if (tabTemp == 3) {
				$('#chooseDateFromCal3').focus();
			} else if (tabTemp == 4) {
				$('#chooseDateFromCal4').focus();
			}
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			} else if (tabTemp == 3) {
				$('#chooseDateFromCal3').focus();
			} else if (tabTemp == 4) {
				$('#chooseDateFromCal4').focus();
			}
			return false;
		}

		chooseDateFrom = $('#chooseDateFromCal' + tabTemp).val();
		chooseDateTo = $('#chooseDateToCal' + tabTemp).val();

		//생산자 선택
		if (tabTemp == '3') {
			userNumber = $('#preWorkCharger').val();
		}
		
		$('#outputTable' + tabTemp).DataTable().ajax.reload();
	});

	
    $('#outputTable1 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#outputTable1').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#outputTable2 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#outputTable2').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#outputTable3 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#outputTable3').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#outputTable4 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#outputTable4').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

   	//담당자조회 팝업 시작
   	var userPopUpTable;
   	function selectPreWorkCharger()
   	{
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
		        	{ "targets": [0,1,2,3,4,5],  "className": "text-center"}
		        ],		      
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#userPopUpTable tbody').on('click', 'tr', function () {
		    	var data = userPopUpTable.row( this ).data();
                $('#preWorkCharger').val(data.userNumber);
                $('#preWorkChargerNm').val(data.userNm);
                $('#userPopUpModal').modal('hide');
		    });
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		    
		$('#userPopUpModal').modal('show');	
   	}
  	//담당자조회 팝업 종료
    
    	//기간조회~
	$('#btnTerm1').on('click',function() {
		datePickFun();
	});

	//기간조회~
	$('#btnTerm2').on('click',function() {
		datePickFun();
	});

	//기간조회~
	$('#btnTerm3').on('click',function() {
		datePickFun();
	});

	
	$('#datePick').on('click',function() {
		var id ='';
		
		$.each($('.calender ul li'), function(){
			if( $(this).hasClass('clicked') ){
				id = $(this).attr('id');
			}
		});			
		datePick(id, 'chooseDateFromCal1', 'chooseDateToCal1',  $('#select-year').val());
		datePick(id, 'chooseDateFromCal2', 'chooseDateToCal2',  $('#select-year').val());
		datePick(id, 'chooseDateFromCal3', 'chooseDateToCal3',  $('#select-year').val());
	});


	outputTable1.on('draw.dt', function(){
		outputTable1.columns.adjust();
	});
	
	outputTable2.on('draw.dt', function(){
		outputTable2.columns.adjust();
	});

	outputTable3.on('draw.dt', function(){
		outputTable3.columns.adjust();
	});

	$('.bumlye').on('click',function(){
		$('#bumlyeModal').modal('show');
	});
	
	
	
	let triggerVal;//1행(위에서부터 2번째줄)에서 다음칸으로 넘어갈 때 사용되는 변수
	let gubunVal;//1행에서 FOR문을 실행하면서 upperHead(0행의 헤더)의 rowspan이 3인경우(꽉채운경우) 올라가는 보정치만큼 뺴주기위한 변수
	let lastRowCorrection;
	function colspanGroupArray( tableName, row, tDivision, trSize, notExistColspanValue, ghostYn, rowData){
	 	//tableName: 테이블 명
	 	//row: 계산하고자 하는  행(0번 부터)
	 	//tDivision: th or td 선택자
	 	//trSize: 계산하고자하는 행 크기
	 	//notExistColspanValue: 계산하고자 하는 행에 calspan이 존재하지 않는 컬럼 개수(앞에서 값으로만 판단, 중간 값은 사용 못함)
	 	//ghostYn: rowspan으로 합쳐진 값이 존재하는지 여부( Y, N ) / 추가로 empty는 colspan, rowspan없이 쭉 이어진 값 
		//berowData : 이전행 데이터 
		let berowData = rowData;
	 	let dt;
	 	let temporaryArray = new Array();
	 	let exceptionArray = new Array();	//empty에서만 사용
  		let temporaryObj = new Object();
    	let temporaryColspanSum = 0; 
    	triggerVal = notExistColspanValue;
    	gubunVal = 0;
    	lastRowCorrection = 0;
    	let thirdIdx = 0;
	 	if( ghostYn == 'Y'){
	 		for(var i = 0; i < trSize; i++) {
	 			dt = $('#'+tableName+' thead tr').eq(row).find( tDivision ).eq(i);
		   	    temporaryObj = new Object();
		   	    if( i < notExistColspanValue ){
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = i;
		   	     temporaryObj.rowspan = dt.attr('rowspan');
		   	        colspanSum = i;
		   	    } else {	
		   	        if( i == notExistColspanValue ) {
		   	            colspanSum += 1;
		   	        }
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = colspanSum;
					//if(dt.attr('rowspan') != '' && dt.attr('rowspan') != undefined){
						temporaryObj.rowspan = dt.attr('rowspan');
					//}
		   	     	temporaryObj.colspan = colspanSum;
		   	        
		   	        colspanSum += parseInt(  dt.attr('colspan') );
		   	    }
		   	 temporaryArray.push(temporaryObj);
		   	}
	 		return temporaryArray;
		} else if( ghostYn == 'N' ) {
			//console.log("for문 반복 횟수 : "+ ( trSize + notExistColspanValue ));
			for(var i=0; i <= ( trSize + notExistColspanValue ) + gubunVal ; i++) {
				
				if( triggerVal == berowData.length){
					triggerVal--;
				}
				//console.log("트리거값:"+triggerVal);
	 			dt = $('#'+tableName+' thead tr').eq(row).find( tDivision ).eq( (i-notExistColspanValue - gubunVal )  );
		   	    temporaryObj = new Object();
		   	    if(!dt.hasClass('d-none')){			   	    
			   	    if( dt.find('colspan') != 1 ) {

			   	    	if( i < notExistColspanValue ){
				   	        temporaryObj.name = '';
				   	        temporaryObj.colspan = i;

				   	        temporaryObj.realColspan = dt.attr('colspan');
				   	   	 	temporaryObj.realRowspan = dt.attr('rowspan');
				   	        colspanSum = i;
				   	    } else {
				   	        if( i == notExistColspanValue ) {
				   	            colspanSum += 1;
				   	        }
							var colVal;
							if ( triggerVal+1 < berowData.length){
								colVal = berowData[triggerVal+1].colspan-1;
							} else if ( triggerVal+1 == berowData.length ) {
								colVal = berowData[triggerVal].colspan-1;
				   	    	} else {
								toast.error("시스템 오류가 발생하였습니다. 에러코드 : ExcelGost-002")
					   	    }
							if( colVal > colspanSum){ //현재 열과 다음 열의 차이가 현재 그리고있는 열보다 작은 경우 -> 이전행의 헤더의 소분류를 그리고 있는중  									
							   	    temporaryObj.name = dt.text();
						   	        temporaryObj.colspan = colspanSum;	
						   	     	temporaryObj.upperHead = berowData[triggerVal].name;
						   	        temporaryObj.realColspan = dt.attr('colspan');
						   	   	 	temporaryObj.realRowspan = dt.attr('rowspan');
						   	    	colspanSum += parseInt(  dt.attr('colspan') );
							} else{ 
								if( berowData[triggerVal].rowspan < $('#'+tableName+' thead tr').length){									
									temporaryObj.name = dt.text();
							   	    temporaryObj.colspan = colspanSum;	
						   	     	temporaryObj.upperHead = berowData[triggerVal].name;
						   	        temporaryObj.realColspan = dt.attr('colspan');
						   	   	 	temporaryObj.realRowspan = dt.attr('rowspan');
							   		colspanSum += parseInt(  dt.attr('colspan') );
							   		triggerVal++;
							   		if( colspanSum == colVal){
							   			triggerVal++;
								   	}
								} else {
									temporaryObj.name = '';
									temporaryObj.rowspan = 3;
								    temporaryObj.colspan = colspanSum;
						   	     	temporaryObj.upperHead = berowData[triggerVal].name;
						   	        temporaryObj.realColspan = dt.attr('colspan');
						   	   	 	temporaryObj.realRowspan = dt.attr('rowspan');
									gubunVal++;
									triggerVal++;
									colspanSum++;
								}
		  
							}
				   	    }
					} else {
						temporaryObj.name = dt.text();
			   	        temporaryObj.colspan = colspanSum;
			   	        colspanSum += parseInt(  dt.attr('colspan') );
			   	        
					}
					//console.log(temporaryObj.name);
					temporaryArray.push(temporaryObj);
		   	    }
		   	}
		   	// console.log("구분값 : "+gubunVal);
			return temporaryArray;
		} else if( ghostYn == 'empty' ) {
			for(var i=0; i < /*( trSize + notExistColspanValue ) */berowData.length; i++) {
				dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( /* (i-notExistColspanValue) */thirdIdx  );
				if( i < notExistColspanValue ){
					exceptionArray[i+lastRowCorrection] = '';
			    } else if ( berowData[i].realRowspan == 1 && berowData[i].realColspan != 1 && berowData[i].rowspan != 3) {
					for( var q=0; q<berowData[i].realColspan;q++){
						dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( thirdIdx );
						exceptionArray[i+q+lastRowCorrection] = dt.text();
						//console.log("추가된 문구 : "+dt.text()+" 추가된 I+Q+보정치 : "+(i+q+lastRowCorrection));
						thirdIdx++;
					}	
					lastRowCorrection+=berowData[i].realColspan-1;		
			    	
			    } else{
			    	exceptionArray[i+lastRowCorrection] = '';
				}
			}
			return exceptionArray;
		} else {
			toastr.error("시스템 오류가 발생했습니다. - excelGhostError-A001");
			return false;
		}
	}


	//가공하고자 하는 행에 헤더 부분 header개수만큼 늘리기 끝
	function alignToTableSize( allDatalength, receivedArray ){
		//colspan된 배열을 가지고, 만들고자하는 길이 만클 데이터를 가공하는 곳
		//allDatalength: 전체 데이터 길이(이 개수만큼 배열이 생성됨)
		//receivedArray: 가공하고자하는 배열 값
		
		let temporaryIsCheck = true;	// brek 역할
		let temporaryArrayRow = new Array();
		
		for(var i=0; i<allDatalength; i++){
			temporaryIsCheck = true;
			
		    for(var j=0; j<receivedArray.length; j++){
		        switch (i){
		        case receivedArray[j].colspan:
		        	temporaryArrayRow.push(receivedArray[j].name);
		        temporaryIsCheck = false;
		            break;
		        default:
		            break;
		        }
		        
		    }
		    if(temporaryIsCheck){
		    	temporaryArrayRow.push(' ');
		    }
		}
		return temporaryArrayRow;
	}
    
</script>
</body>
</html>
