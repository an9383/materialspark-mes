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
				<li class="breadcrumb-item active">불량내역조회(상세)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 99%; padding-bottom:0px;">
				<div class="card" style="margin-bottom: 10px;">
					<div class="row" style="margin-bottom: 10px;">
						&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">불량일자</label>
						
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="faultyDateFromCal" />
							<button	onclick="fnPopUpCalendar(faultyDateFromCal,faultyDateFromCal,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="faultyDateFromCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>
						
						 
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="faultyDateToCal" />
							<button	onclick="fnPopUpCalendar(faultyDateToCal,faultyDateToCal,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="faultyDateToCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
						
						<div style="margin-right: 5%; display: flex; flex-direction: column;">
							<!-- <label class="ml-2" style="line-height: 10px;">*선택한 날짜의 07:00 ~ 다음날 06:59 까지 조회됩니다.</label> -->
							<label class="ml-2" style="line-height: 14px;">*가로 스크롤: Shift+마우스 스크롤</label>
						</div>
						
						<div style="margin-right: 40%;">
							<button type='button' class='btn btn-success' id='btnFakeExcel' disabled>엑셀 다운</button>
						</div>
						
						<div style="display: flex; flex-wrap: nowrap;width: 265px;flex-direction: row;">
							<label style="width: 45px; line-height: 24px;" id="searchLabel">검색 :</label>
						</div>
					</div>
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="allFaulQty">전체 조회</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="prcssFaulty">${processFaultyNm}</a></li> 
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="matrlFaulty">${matrlFaultyNm}</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="replaceFaulty">${replaceFaultyNm}</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="troubleFaulty">${troubleFaultyNm}</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="faultyQty">권취잔량</a></li>
						</ul>
					</div>
				</div>
				
				<div class="table-responsive" style="padding-bottom: 5px;">
				
					<!-- 전체 값 합치기 -->
					<div id="allFaultView">
						<table id="allFaultTable" class="table table-bordered" >
							<thead class="thead-light">
								<tr id="gubunHeader"></tr>
								<tr id="allFaultHeader"> </tr>
								<tr id="allFaultHeader2"> </tr>
							</thead>
							<tfoot>
								<tr>
									<!-- 생산-교체 Loss 교체(1) -->
									<td colspan="5" style="text-align: center">합계</td>
									<td colspan="" id="allFaultSumReplaceCount1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount21" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg21" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa21" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount22" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg22" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa22" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount23" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg23" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa23" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount24" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg24" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa24" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount25" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg25" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa25" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount26" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg26" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa26" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount27" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg27" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa27" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount28" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg28" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa28" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount29" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg29" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa29" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount30" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg30" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa30" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount31" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg31" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa31" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount32" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg32" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa32" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount33" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg33" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa33" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount34" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg34" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa34" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount35" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg35" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa35" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount36" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg36" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa36" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount37" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg37" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa37" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount38" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg38" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa38" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount39" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg39" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa39" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceCount40" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceKg40" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumReplaceEa40" style="text-align:right">0</td>
									
									<!-- 생산-공정 조정(2) -->
<!-- 									<td colspan="5" style="text-align: center">합계</td> -->
									<td colspan="" id="allFaultSumPrcssKg1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg21" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa21" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg22" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa22" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg23" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa23" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg24" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa24" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg25" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa25" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg26" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa26" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg27" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa27" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg28" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa28" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg29" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa29" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg30" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa30" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg31" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa31" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg32" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa32" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg33" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa33" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg34" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa34" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg35" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa35" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg36" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa36" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg37" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa37" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg38" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa38" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg39" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa39" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssKg40" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumPrcssEa40" style="text-align:right">0</td>
									
									<!-- 생산-원자재불량 교체(3) -->
<!-- 									<td colspan="5" style="text-align: center">합계</td> -->
									<td colspan="" id="allFaultSumMatrlKg1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg21" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa21" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg22" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa22" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg23" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa23" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg24" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa24" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg25" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa25" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg26" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa26" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg27" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa27" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg28" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa28" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg29" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa29" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg30" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa30" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg31" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa31" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg32" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa32" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg33" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa33" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg34" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa34" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg35" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa35" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg36" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa36" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg37" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa37" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg38" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa38" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg39" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa39" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlKg40" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumMatrlEa40" style="text-align:right">0</td>
									
									<!-- 생산-설비 부품 교체(4) -->
<!-- 									<td colspan="5" style="text-align: center">합계</td> -->
									<td colspan="" id="allFaultSumTroubleCount1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa1" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent1"></td>
									<td colspan="" id="allFaultSumTroubleCount2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa2" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent2"></td>
									<td colspan="" id="allFaultSumTroubleCount3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa3" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent3"></td>
									<td colspan="" id="allFaultSumTroubleCount4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa4" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent4"></td>
									<td colspan="" id="allFaultSumTroubleCount5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa5" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent5"></td>
									<td colspan="" id="allFaultSumTroubleCount6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa6" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent6"></td>
									<td colspan="" id="allFaultSumTroubleCount7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa7" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent7"></td>
									<td colspan="" id="allFaultSumTroubleCount8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa8" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent8"></td>
									<td colspan="" id="allFaultSumTroubleCount9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa9" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent9"></td>
									<td colspan="" id="allFaultSumTroubleCount10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa10" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent10"></td>
									<td colspan="" id="allFaultSumTroubleCount11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa11" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent11"></td>
									<td colspan="" id="allFaultSumTroubleCount12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa12" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent12"></td>
									<td colspan="" id="allFaultSumTroubleCount13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa13" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent13"></td>
									<td colspan="" id="allFaultSumTroubleCount14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa14" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent14"></td>
									<td colspan="" id="allFaultSumTroubleCount15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa15" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent15"></td>
									<td colspan="" id="allFaultSumTroubleCount16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa16" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent16"></td>
									<td colspan="" id="allFaultSumTroubleCount17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa17" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent17"></td>
									<td colspan="" id="allFaultSumTroubleCount18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa18" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent18"></td>
									<td colspan="" id="allFaultSumTroubleCount19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa19" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent19"></td>
									<td colspan="" id="allFaultSumTroubleCount20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleKg20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleEa20" style="text-align:right">0</td>
									<td colspan="" id="allFaultSumTroubleContent20"></td>	
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- 전체 값 합치기 -->
				
					<!-- 생산-공정 조정 교체 -->
					<div class="d-none" id="prcssFaultyView" >
						<table id="prcssFaultyTable" class="table table-bordered">
							<thead class="thead-light" >
								<tr id="prcssHeader"> </tr>
								<tr id="prcssHeader2"> </tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="5" style="text-align: center">합계</td>
									<td colspan="" id="sumPrcssKg1" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa1" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg2" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa2" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg3" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa3" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg4" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa4" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg5" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa5" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg6" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa6" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg7" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa7" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg8" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa8" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg9" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa9" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg10" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa10" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg11" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa11" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg12" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa12" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg13" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa13" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg14" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa14" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg15" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa15" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg16" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa16" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg17" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa17" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg18" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa18" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg19" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa19" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg20" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa20" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg21" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa21" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg22" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa22" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg23" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa23" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg24" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa24" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg25" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa25" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg26" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa26" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg27" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa27" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg28" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa28" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg29" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa29" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg30" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa30" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg31" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa31" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg32" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa32" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg33" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa33" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg34" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa34" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg35" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa35" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg36" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa36" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg37" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa37" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg38" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa38" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg39" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa39" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssKg40" style="text-align:right">0</td>
									<td colspan="" id="sumPrcssEa40" style="text-align:right">0</td>
								</tr>
							</tfoot>
						</table>
					</div>
					
					<!-- 생산-원자재불량 교체 -->
					<div id="matrlFaultyView" class="d-none">
						<table id="matrlFaultyTable" class="table table-bordered">
							<thead class="thead-light">
								<tr id="matrlHeader"> </tr>
								<tr id="matrlHeader2"> </tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="5" style="text-align: center">합계</td>
									<td colspan="" id="sumMatrlKg1" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa1" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg2" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa2" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg3" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa3" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg4" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa4" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg5" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa5" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg6" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa6" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg7" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa7" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg8" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa8" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg9" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa9" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg10" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa10" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg11" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa11" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg12" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa12" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg13" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa13" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg14" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa14" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg15" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa15" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg16" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa16" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg17" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa17" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg18" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa18" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg19" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa19" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg20" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa20" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg21" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa21" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg22" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa22" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg23" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa23" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg24" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa24" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg25" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa25" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg26" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa26" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg27" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa27" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg28" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa28" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg29" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa29" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg30" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa30" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg31" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa31" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg32" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa32" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg33" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa33" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg34" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa34" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg35" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa35" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg36" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa36" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg37" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa37" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg38" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa38" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg39" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa39" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlKg40" style="text-align:right">0</td>
									<td colspan="" id="sumMatrlEa40" style="text-align:right">0</td>
								</tr>
							</tfoot>
						</table>
					</div>
					
					<!-- 생산-교체 Loss 교체 -->
					<div id="replaceFaultyView" class="d-none">
						<table id="replaceFaultyTable" class="table table-bordered">
							<thead class="thead-light">
								<tr id="replaceHeader"> </tr>
								<tr id="replaceHeader2"> </tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="5" style="text-align: center">합계</td>
									<td colspan="" id="sumReplaceCount1" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg1" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa1" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount2" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg2" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa2" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount3" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg3" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa3" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount4" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg4" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa4" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount5" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg5" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa5" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount6" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg6" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa6" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount7" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg7" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa7" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount8" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg8" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa8" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount9" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg9" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa9" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount10" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg10" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa10" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount11" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg11" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa11" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount12" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg12" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa12" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount13" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg13" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa13" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount14" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg14" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa14" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount15" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg15" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa15" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount16" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg16" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa16" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount17" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg17" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa17" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount18" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg18" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa18" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount19" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg19" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa19" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount20" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg20" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa20" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount21" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg21" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa21" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount22" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg22" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa22" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount23" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg23" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa23" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount24" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg24" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa24" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount25" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg25" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa25" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount26" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg26" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa26" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount27" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg27" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa27" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount28" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg28" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa28" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount29" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg29" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa29" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount30" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg30" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa30" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount31" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg31" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa31" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount32" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg32" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa32" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount33" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg33" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa33" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount34" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg34" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa34" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount35" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg35" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa35" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount36" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg36" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa36" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount37" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg37" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa37" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount38" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg38" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa38" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount39" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg39" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa39" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceCount40" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceKg40" style="text-align:right">0</td>
									<td colspan="" id="sumReplaceEa40" style="text-align:right">0</td>
								</tr>
							</tfoot>
						</table>
					</div>
					
					<!-- 생산-설비 부품 교체 -->
					<div id="troubleFaultyView" class="d-none">
						<table id="troubleFaultyTable" class="table table-bordered" >
							<thead class="thead-light">
								<tr id="troubleHeader"> </tr>
								<tr id="troubleHeader2"> </tr>								
							</thead>
							<tfoot>
								<tr>
									<td colspan="5" style="text-align: center">합계</td>
									<td colspan="" id="sumTroubleCount1" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg1" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa1" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent1"></td>
									<td colspan="" id="sumTroubleCount2" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg2" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa2" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent2"></td>
									<td colspan="" id="sumTroubleCount3" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg3" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa3" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent3"></td>
									<td colspan="" id="sumTroubleCount4" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg4" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa4" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent4"></td>
									<td colspan="" id="sumTroubleCount5" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg5" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa5" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent5"></td>
									<td colspan="" id="sumTroubleCount6" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg6" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa6" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent6"></td>
									<td colspan="" id="sumTroubleCount7" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg7" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa7" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent7"></td>
									<td colspan="" id="sumTroubleCount8" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg8" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa8" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent8"></td>
									<td colspan="" id="sumTroubleCount9" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg9" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa9" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent9"></td>
									<td colspan="" id="sumTroubleCount10" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg10" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa10" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent10"></td>
									<td colspan="" id="sumTroubleCount11" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg11" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa11" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent11"></td>
									<td colspan="" id="sumTroubleCount12" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg12" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa12" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent12"></td>
									<td colspan="" id="sumTroubleCount13" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg13" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa13" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent13"></td>
									<td colspan="" id="sumTroubleCount14" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg14" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa14" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent14"></td>
									<td colspan="" id="sumTroubleCount15" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg15" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa15" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent15"></td>
									<td colspan="" id="sumTroubleCount16" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg16" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa16" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent16"></td>
									<td colspan="" id="sumTroubleCount17" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg17" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa17" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent17"></td>
									<td colspan="" id="sumTroubleCount18" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg18" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa18" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent18"></td>
									<td colspan="" id="sumTroubleCount19" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg19" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa19" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent19"></td>
									<td colspan="" id="sumTroubleCount20" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleKg20" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleEa20" style="text-align:right">0</td>
									<td colspan="" id="sumTroubleContent20"></td>
								</tr>
							</tfoot>
						</table>
					</div>
					
					<!-- 권취잔량 교체 -->
					<div id="faultyQtyView" class="d-none">
						<table id="faultyQtyTable" class="table table-bordered" >
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th style="min-width:25px" class="text-center">일자</th>
									<th style="min-width:25px" class="text-center">주야</th>
									<th style="min-width:25px" class="text-center">설비명</th>
									<th style="min-width:25px" class="text-center">제품</th>
									<th style="min-width:25px" class="text-center">재질</th>
									<th style="min-width:25px" class="text-center">주자재 귄취잔량 합</th>
									<th style="min-width:25px" class="text-center">부자재 귄취잔량 합</th>
									<th style="min-width:25px" class="text-center">작업조</th>
									<th style="min-width:25px" class="text-center">작업자</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="5" style="text-align: center">합계</td>
									<td colspan="" id="mainFaultyQtySum" style="text-align:right">0</td>
									<td colspan="" id="subFaultyQtySum" style="text-align:right">0</td>
									<td colspan="2" style="text-align: center"></td>
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

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'wmsc0080';
	let currentHref = 'wmsc0080';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","불량내역조회(상세)");

	
	let notHiddenArray = '';	//columns 값 지정 Array
	let factoryCode = "<%=factoryCode%>";
	
// 	$(document).ready(function(){
// 		$('#btnFakeExcel').attr('disabled', false);
// 	});

	var faultyDateFrom = "${serverDateFrom}";
	$('#faultyDateFromCal').val(faultyDateFrom);
	var faultyDateTo = "${serverDate}";
	$('#faultyDateToCal').val(faultyDateTo);
	var matrlTemp 		= 0;
	var replaceTemp 	= 0;
	var troubleTemp 	= 0;
	var tapTemp 		= 5;
	var prcssFaultyCnt 	= 0;

	var processFaultyNm =  "${processFaultyNm}";
	var matrlFaultyNm 	=  "${matrlFaultyNm}";
	var replaceFaultyNm =  "${replaceFaultyNm}";
	var troubleFaultyNm =  "${troubleFaultyNm}";

	
// 	$(document).ready(function(){
		$('#my-spinner').show();
// 	});
	
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
    
	var processFaulty = new Array(); //공정불량
    <c:forEach items="${processFaulty}" var="info">
		var json=new Object();
		json.id="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		processFaulty.push(json);
	</c:forEach>    

    var matrlFaulty = new Array(); //원자재불량
    <c:forEach items="${matrlFaulty}" var="info">
		var json=new Object();
		json.id="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaulty.push(json);
	</c:forEach>

    var changeFaulty = new Array(); //교체불량
    <c:forEach items="${changeFaulty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		changeFaulty.push(json);
	</c:forEach>
	
    var equipTroubleFaulty = new Array(); //설비트러블 
	<c:forEach items="${equipTroubleFaulty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipTroubleFaulty.push(json);
	</c:forEach>
	
    //조회
	$('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#faultyDateFromCal').val());
		let dateTo = new Date($('#faultyDateToCal').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#faultyDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#faultyDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#faultyDateFromCalendar').focus();
			return false;
		}
		
		faultyDateFrom = $('#faultyDateFromCal').val();
		faultyDateTo = $('#faultyDateToCal').val();
		if (tapTemp == 0) {
			$("#prcssFaulty").trigger("click");
		} else if (tapTemp == 1) {
			$("#matrlFaulty").trigger("click");
		} else if (tapTemp == 2) {
			$("#replaceFaulty").trigger("click");
		} else if (tapTemp == 3) {
			$("#troubleFaulty").trigger("click");
		} else if (tapTemp == 4) {
			$("#faultyQty").trigger("click");
		} else if (tapTemp == 5) {
			$("#allFaulQty").trigger("click");
		}
		
	});
	
	$('#prcssFaulty').on('click', function() {
		$('#prcssFaultyView').removeClass('d-none');
		$('#matrlFaultyView').addClass('d-none');
		$('#replaceFaultyView').addClass('d-none');
		$('#troubleFaultyView').addClass('d-none');
		$('#faultyQtyView').addClass('d-none');
		$('#allFaultView').addClass('d-none');
		$('#prcssFaultyTable').DataTable().ajax.reload();

		$('#pageSerch1').addClass('d-none');
		$('#pageSerch2').removeClass('d-none');
		$('#pageSerch3').addClass('d-none');
		$('#pageSerch4').addClass('d-none');
		$('#pageSerch5').addClass('d-none');
		$('#pageSerch6').addClass('d-none');

		$('#btnFakeExcel').addClass('d-none');
		
		$('#my-spinner').show();
		tapTemp = 0;
	});
	
	$('#matrlFaulty').on('click', function() {
		$('#prcssFaultyView').addClass('d-none');
		$('#matrlFaultyView').removeClass('d-none');
		$('#replaceFaultyView').addClass('d-none');
		$('#troubleFaultyView').addClass('d-none');
		$('#faultyQtyView').addClass('d-none');
		$('#faultyQtyView').addClass('d-none');
		$('#allFaultView').addClass('d-none');
		$('#matrlFaultyTable').DataTable().ajax.reload();

		$('#pageSerch1').addClass('d-none');
		$('#pageSerch2').addClass('d-none');
		$('#pageSerch3').removeClass('d-none');
		$('#pageSerch4').addClass('d-none');
		$('#pageSerch5').addClass('d-none');
		$('#pageSerch6').addClass('d-none');

		$('#btnFakeExcel').addClass('d-none');
		
		$('#my-spinner').show();
		tapTemp = 1;
	});
	
	$('#replaceFaulty').on('click', function() {
		$('#prcssFaultyView').addClass('d-none');
		$('#matrlFaultyView').addClass('d-none');
		$('#replaceFaultyView').removeClass('d-none');
		$('#troubleFaultyView').addClass('d-none');
		$('#faultyQtyView').addClass('d-none');
		$('#faultyQtyView').addClass('d-none');
		$('#allFaultView').addClass('d-none');
		$('#replaceFaultyTable').DataTable().ajax.reload();

		$('#pageSerch1').addClass('d-none');
		$('#pageSerch2').addClass('d-none');
		$('#pageSerch3').addClass('d-none');
		$('#pageSerch4').removeClass('d-none');
		$('#pageSerch5').addClass('d-none');
		$('#pageSerch6').addClass('d-none');

		$('#btnFakeExcel').addClass('d-none');
		
		$('#my-spinner').show();
		tapTemp = 2;
	});
	
	$('#troubleFaulty').on('click', function() {
		$('#prcssFaultyView').addClass('d-none');
		$('#matrlFaultyView').addClass('d-none');
		$('#replaceFaultyView').addClass('d-none');
		$('#troubleFaultyView').removeClass('d-none');
		$('#faultyQtyView').addClass('d-none');
		$('#allFaultView').addClass('d-none');
		$('#troubleFaultyTable').DataTable().ajax.reload();

		$('#pageSerch1').addClass('d-none');
		$('#pageSerch2').addClass('d-none');
		$('#pageSerch3').addClass('d-none');
		$('#pageSerch4').addClass('d-none');
		$('#pageSerch5').removeClass('d-none');
		$('#pageSerch6').addClass('d-none');

		$('#btnFakeExcel').addClass('d-none');
		
		$('#my-spinner').show();
		tapTemp = 3;
	});

	$('#faultyQty').on('click', function() {
		$('#prcssFaultyView').addClass('d-none');
		$('#matrlFaultyView').addClass('d-none');
		$('#replaceFaultyView').addClass('d-none');
		$('#troubleFaultyView').addClass('d-none');
		$('#faultyQtyView').removeClass('d-none');
		$('#allFaultView').addClass('d-none');
		$('#faultyQtyTable').DataTable().ajax.reload();

		$('#pageSerch1').addClass('d-none');
		$('#pageSerch2').addClass('d-none');
		$('#pageSerch3').addClass('d-none');
		$('#pageSerch4').addClass('d-none');
		$('#pageSerch5').addClass('d-none');
		$('#pageSerch6').removeClass('d-none');

		$('#btnFakeExcel').addClass('d-none');
		
		$('#my-spinner').show();
		tapTemp = 4;
	});

	//전체 조회 - 5
	$('#allFaulQty').on('click', function() {
		$('#prcssFaultyView').addClass('d-none');
		$('#matrlFaultyView').addClass('d-none');
		$('#replaceFaultyView').addClass('d-none');
		$('#troubleFaultyView').addClass('d-none');
		$('#faultyQtyView').addClass('d-none');
		$('#allFaultView').removeClass('d-none');
		$('#allFaultTable').DataTable().ajax.reload();

		$('#pageSerch1').removeClass('d-none');
		$('#pageSerch2').addClass('d-none');
		$('#pageSerch3').addClass('d-none');
		$('#pageSerch4').addClass('d-none');
		$('#pageSerch5').addClass('d-none');
		$('#pageSerch6').addClass('d-none');

		$('#btnFakeExcel').removeClass('d-none');
		
		$('#my-spinner').show();
		tapTemp = 5;
	});

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ전체 값 합치는 코드시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	allFaultHderCreate1(); // - paymentHderCreate3();	//--(1)--//
	allFaultHderCreate2(); // - paymentHderCreate();	//--(2)--//
	allFaultHderCreate3(); // - paymentHderCreate2();	//--(3)--//
	allFaultHderCreate4(); // - paymentHderCreate4();	//--(4)--//
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	$.fn.dataTable.ext.errMode = 'none';
	let allFaultTable = $('#allFaultTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        pageLength: 20,
        buttons: true,
        ajax: {
            url: '<c:url value="wm/allFaultList"/>',
            type: 'GET',
            data: {
            	'menuAuth'		:	menuAuth,
            	'faultyDateTo'	:	function() { return faultyDateTo.replace(/-/g, ''); },
            	'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
            },
        },
		columns: [
			{
				render: function(data, type, row) {
					if(row['faultyRegDate'] == null || row['faultyRegDate'] == ''){
						return '';
					} else{
						return moment(row['faultyRegDate']).format('YYYY-MM-DD');
					}
					
				}
			},
			{ data: 'dayNightNm'	},
			{ data: 'equipNm' 		},
			{ data: 'goodsNm' 		},
			{ data: 'alnicuMatrlNm' },
			{ data: 'count1'		},
			{ data: 'kg1',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea1',
		   		render: function(data, type) {		   			 
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count2'},
			{ data: 'kg2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count3'},
			{ data: 'kg3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count4'},
			{ data: 'kg4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count5'},
			{ data: 'kg5',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea5',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count6'},
			{ data: 'kg6',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea6',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count7'},
			{ data: 'kg7',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea7',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count8'},
			{ data: 'kg8',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea8',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count9'},
			{ data: 'kg9',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea9',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count10'},
			{ data: 'kg10',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea10',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count11'},
			{ data: 'kg11',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea11',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count12'},
			{ data: 'kg12',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea12',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count13'},
			{ data: 'kg13',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea13',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count14'},
			{ data: 'kg14',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea14',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count15'},
			{ data: 'kg15',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea15',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count16'},
			{ data: 'kg16',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea16',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count17'},
			{ data: 'kg17',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea17',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count18'},
			{ data: 'kg18',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea18',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count19'},
			{ data: 'kg19',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea19',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count20'},
			{ data: 'kg20',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea20',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count21'},
			{ data: 'kg21',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea21',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count22'},
			{ data: 'kg22',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea22',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count23'},
			{ data: 'kg23',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea23',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count24'},
			{ data: 'kg24',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea24',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count25'},
			{ data: 'kg25',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea25',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count26'},
			{ data: 'kg26',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea26',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count27'},
			{ data: 'kg27',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea27',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count28'},
			{ data: 'kg28',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea28',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count29'},
			{ data: 'kg29',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea29',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count30'},
			{ data: 'kg30',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea30',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count31'},
			{ data: 'kg31',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea31',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count32'},
			{ data: 'kg32',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea32',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count33'},
			{ data: 'kg33',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea33',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count34'},
			{ data: 'kg34',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea34',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count35'},
			{ data: 'kg35',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea35',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count36'},
			{ data: 'kg36',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea36',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count37'},
			{ data: 'kg37',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea37',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count38'},
			{ data: 'kg38',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea38',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count39'},
			{ data: 'kg39',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea39',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count40'},
			{ data: 'kg40',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
	   		 },
			{ data: 'ea40',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },

            //생산-공정 조정(2)
            /*{
				render: function(data, type, row) {
					return moment(row['faultyRegDate']).format('YYYY-MM-DD');
				}
			},
			{ data: 'dayNightNm' 	},
			{ data: 'equipNm' 		},
			{ data: 'goodsNm' 		},
			{ data: 'alnicuMatrlNm' },*/
			{ data: 'kg1_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea1_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg2_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea2_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg3_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea3_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg4_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea4_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg5_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea5_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg6_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea6_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg7_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea7_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg8_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea8_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg9_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea9_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg10_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea10_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg11_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea11_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg12_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea12_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg13_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea13_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg14_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea14_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg15_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea15_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg16_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea16_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg17_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea17_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg18_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea18_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg19_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea19_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg20_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea20_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg21_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea21_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg22_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea22_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg23_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea23_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg24_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea24_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg25_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea25_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg26_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea26_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg27_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea27_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg28_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea28_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg29_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea29_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg30_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea30_2' ,
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg31_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea31_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg32_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea32_2' ,
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg33_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea33_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg34_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea34_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg35_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea35_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg36_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea36_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg37_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea37_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg38_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea38_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg39_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea39_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg40_2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea40_2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },

			//생산-원자재불량 교체(3)
	   		/*{
				render: function(data, type, row) {
					return moment(row['faultyRegDate']).format('YYYY-MM-DD');
				}
			},
			{ data: 'dayNightNm' 	},
			{ data: 'equipNm' 		},
			{ data: 'goodsNm' 		},
			{ data: 'alnicuMatrlNm' },*/
			{ data: 'kg1_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea1_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg2_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea2_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg3_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea3_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg4_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea4_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg5_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea5_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg6_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea6_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg7_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea7_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg8_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea8_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg9_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea9_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg10_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea10_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg11_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea11_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg12_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea12_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg13_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea13_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg14_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea14_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg15_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea15_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg16_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea16_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg17_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea17_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg18_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea18_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg19_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea19_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg20_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea20_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg21_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea21_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg22_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea22_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg23_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea23_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg24_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea24_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg25_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea25_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg26_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea26_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg27_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea27_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg28_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea28_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg29_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea29_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg30_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea30_3' ,
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg31_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea31_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg32_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea32_3' ,
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg33_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea33_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg34_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea34_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg35_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea35_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg36_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea36_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg37_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea37_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg38_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea38_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg39_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea39_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg40_3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}
		   		}
            },
			{ data: 'ea40_3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
			},

			//생산-설비 부품 교체(4)
			/*{
				render: function(data, type, row) {
					return moment(row['faultyRegDate']).format('YYYY-MM-DD');
				}
			},
			{ data: 'dayNightNm' 	},
			{ data: 'equipNm' 		},
			{ data: 'goodsNm' 		},
			{ data: 'alnicuMatrlNm' },*/
			{ data: 'count1_4'		},
			{ data: 'kg1_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea1_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content1_4'},
			{ data: 'count2_4'},
			{ data: 'kg2_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea2_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content2_4'},
			{ data: 'count3_4'},
			{ data: 'kg3_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea3_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content3_4'},
			{ data: 'count4_4'},
			{ data: 'kg4_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea4_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content4_4'},
			{ data: 'count5_4'},
			{ data: 'kg5_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea5_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content5_4'},
			{ data: 'count6_4'},
			{ data: 'kg6_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea6_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content6_4'},
			{ data: 'count7_4'},
			{ data: 'kg7_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea7_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content7_4'},
			{ data: 'count8_4'},
			{ data: 'kg8_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea8_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content8_4'},
			{ data: 'count9_4'},
			{ data: 'kg9_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea9_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content9_4'},
			{ data: 'count10_4'},
			{ data: 'kg10_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea10_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content10_4'},
			{ data: 'count11_4'},
			{ data: 'kg11_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea11_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content11_4'},
			{ data: 'count12_4'},
			{ data: 'kg12_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea12_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content12_4'},
			{ data: 'count13_4'},
			{ data: 'kg13_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea13_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content13_4'},
			{ data: 'count14_4'},
			{ data: 'kg14_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea14_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content14_4'},
			{ data: 'count15_4'},
			{ data: 'kg15_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea15_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content15_4'},
			{ data: 'count16_4'},
			{ data: 'kg16_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea16_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content16_4'},
			{ data: 'count17_4'},
			{ data: 'kg17_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea17_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content17_4'},
			{ data: 'count18_4'},
			{ data: 'kg18_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea18_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content18_4'},
			{ data: 'count19_4'},
			{ data: 'kg19_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea19_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content19_4'},
			{ data: 'count20_4'},
			{ data: 'kg20_4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea20_4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content20_4'}
		],
        columnDefs: [
        	{ targets: [288,292,296,300,304,308,312,316,320,324,328,332,336,340,344,348,352,356,360,364], className: 'text-left' },
        	{ targets: [0,1,2,3,4], className: 'text-center' },
        	{ targets: "_all", className: 'text-right' }
        ],
		order: [
			[ 0, 'asc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: replaceFaultyNm,
            },
            {
                extend: 'excel',
                title: replaceFaultyNm,
                exportOptions: {
                 	columns: notHiddenArray	//원하는 값 지정
                },
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
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A3:A5'} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'B3:B5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'C3:C5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'D3:D5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'E3:E5'} } )
					);
					//rowspan

					//colspan
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'F3:AC3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'AD3:AY3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'AZ3:BS3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'BT3:DO3'} } )
					);
					//colspan
					
// 					mergeCells[0].appendChild(
// 						createNode( sheet, 'mergeCell', { attr: {ref: 'F4:H4'} } )
// 					);
					
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
			    customizeData: function(data){
				   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				 	//첫 번째 tr
				 	let arrayTr1 = colspanGroupArray('allFaultTable', 0, 'th', $('#allFaultTable thead tr').eq(0).find('th').length, 5, 'Y');
				 	//두 번째 tr
				 	let arrayTr2 = colspanGroupArray('allFaultTable', 1, 'th', $('#allFaultTable thead tr').eq(1).find('th').length, 5, 'N');
				 	//세 번째 tr
				   	let arrayTr3 = colspanGroupArray('allFaultTable', 2, 'th', $('#allFaultTable thead tr').eq(2).find('th').length, 5, 'empty');
					
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

			        //data.body.unshift(data.header);	//헤더 맨 아래 부분
			        data.body.unshift(arrayTr3);		//헤더 맨 아래 부분 (세 번째 행)
			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }
            },
            {
                extend: 'print',
                title: replaceFaultyNm,
            }
        ],
		drawCallback:function() {

			$('#allFaultTable tbody tr td').attr("style","min-width:60px; white-space: pre-wrap;");
			
			let allFaultSumReplaceCount1	=	$('#allFaultTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg1		=	$('#allFaultTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa1		=	$('#allFaultTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount2	=	$('#allFaultTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg2		=	$('#allFaultTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa2		=	$('#allFaultTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount3	=	$('#allFaultTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg3		=	$('#allFaultTable').DataTable().column(12,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa3		=	$('#allFaultTable').DataTable().column(13,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount4	=	$('#allFaultTable').DataTable().column(14,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg4		=	$('#allFaultTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa4		=	$('#allFaultTable').DataTable().column(16,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount5	=	$('#allFaultTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg5		=	$('#allFaultTable').DataTable().column(18,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa5		=	$('#allFaultTable').DataTable().column(19,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount6	=	$('#allFaultTable').DataTable().column(20,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg6		=	$('#allFaultTable').DataTable().column(21,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa6		=	$('#allFaultTable').DataTable().column(22,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount7	=	$('#allFaultTable').DataTable().column(23,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg7		=	$('#allFaultTable').DataTable().column(24,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa7		=	$('#allFaultTable').DataTable().column(25,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount8	=	$('#allFaultTable').DataTable().column(26,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg8		=	$('#allFaultTable').DataTable().column(27,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa8		=	$('#allFaultTable').DataTable().column(28,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount9	=	$('#allFaultTable').DataTable().column(29,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg9		=	$('#allFaultTable').DataTable().column(30,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa9		=	$('#allFaultTable').DataTable().column(31,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount10	=	$('#allFaultTable').DataTable().column(32,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg10		=	$('#allFaultTable').DataTable().column(33,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa10		=	$('#allFaultTable').DataTable().column(34,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount11	=	$('#allFaultTable').DataTable().column(35,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg11		=	$('#allFaultTable').DataTable().column(36,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa11		=	$('#allFaultTable').DataTable().column(37,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount12	=	$('#allFaultTable').DataTable().column(38,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg12		=	$('#allFaultTable').DataTable().column(39,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa12		=	$('#allFaultTable').DataTable().column(40,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount13	=	$('#allFaultTable').DataTable().column(41,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg13		=	$('#allFaultTable').DataTable().column(42,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa13		=	$('#allFaultTable').DataTable().column(43,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount14	=	$('#allFaultTable').DataTable().column(44,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg14		=	$('#allFaultTable').DataTable().column(45,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa14		=	$('#allFaultTable').DataTable().column(46,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount15	=	$('#allFaultTable').DataTable().column(47,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg15		=	$('#allFaultTable').DataTable().column(48,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa15		=	$('#allFaultTable').DataTable().column(49,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount16	=	$('#allFaultTable').DataTable().column(50,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg16		=	$('#allFaultTable').DataTable().column(51,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa16		=	$('#allFaultTable').DataTable().column(52,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount17	=	$('#allFaultTable').DataTable().column(53,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg17		=	$('#allFaultTable').DataTable().column(54,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa17		=	$('#allFaultTable').DataTable().column(55,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount18	=	$('#allFaultTable').DataTable().column(56,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg18		=	$('#allFaultTable').DataTable().column(57,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa18		=	$('#allFaultTable').DataTable().column(58,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount19	=	$('#allFaultTable').DataTable().column(59,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg19		=	$('#allFaultTable').DataTable().column(60,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa19		=	$('#allFaultTable').DataTable().column(61,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount20	=	$('#allFaultTable').DataTable().column(62,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg20		=	$('#allFaultTable').DataTable().column(63,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa20		=	$('#allFaultTable').DataTable().column(64,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount21	=	$('#allFaultTable').DataTable().column(65,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg21		=	$('#allFaultTable').DataTable().column(66,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa21		=	$('#allFaultTable').DataTable().column(67,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount22	=	$('#allFaultTable').DataTable().column(68,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg22		=	$('#allFaultTable').DataTable().column(69,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa22		=	$('#allFaultTable').DataTable().column(70,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount23	=	$('#allFaultTable').DataTable().column(71,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg23		=	$('#allFaultTable').DataTable().column(72,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa23		=	$('#allFaultTable').DataTable().column(73,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount24	=	$('#allFaultTable').DataTable().column(74,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg24		=	$('#allFaultTable').DataTable().column(75,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa24		=	$('#allFaultTable').DataTable().column(76,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount25	=	$('#allFaultTable').DataTable().column(77,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg25		=	$('#allFaultTable').DataTable().column(78,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa25		=	$('#allFaultTable').DataTable().column(79,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount26	=	$('#allFaultTable').DataTable().column(80,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg26		=	$('#allFaultTable').DataTable().column(81,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa26		=	$('#allFaultTable').DataTable().column(82,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount27	=	$('#allFaultTable').DataTable().column(83,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg27		=	$('#allFaultTable').DataTable().column(84,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa27		=	$('#allFaultTable').DataTable().column(85,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount28	=	$('#allFaultTable').DataTable().column(86,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg28		=	$('#allFaultTable').DataTable().column(87,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa28		=	$('#allFaultTable').DataTable().column(88,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount29	=	$('#allFaultTable').DataTable().column(89,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg29		=	$('#allFaultTable').DataTable().column(90,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa29		=	$('#allFaultTable').DataTable().column(91,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount30	=	$('#allFaultTable').DataTable().column(92,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg30		=	$('#allFaultTable').DataTable().column(93,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa30		=	$('#allFaultTable').DataTable().column(94,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount31	=	$('#allFaultTable').DataTable().column(95,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg31		=	$('#allFaultTable').DataTable().column(96,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa31		=	$('#allFaultTable').DataTable().column(97,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount32	=	$('#allFaultTable').DataTable().column(98,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg32		=	$('#allFaultTable').DataTable().column(99,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa32		=	$('#allFaultTable').DataTable().column(100,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount33	=	$('#allFaultTable').DataTable().column(101,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg33		=	$('#allFaultTable').DataTable().column(102,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa33		=	$('#allFaultTable').DataTable().column(103,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount34	=	$('#allFaultTable').DataTable().column(104,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg34		=	$('#allFaultTable').DataTable().column(105,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa34		=	$('#allFaultTable').DataTable().column(106,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount35	=	$('#allFaultTable').DataTable().column(107,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg35		=	$('#allFaultTable').DataTable().column(108,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa35		=	$('#allFaultTable').DataTable().column(109,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount36	=	$('#allFaultTable').DataTable().column(110,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg36		=	$('#allFaultTable').DataTable().column(111,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa36		=	$('#allFaultTable').DataTable().column(112,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount37	=	$('#allFaultTable').DataTable().column(113,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg37		=	$('#allFaultTable').DataTable().column(114,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa37		=	$('#allFaultTable').DataTable().column(115,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount38	=	$('#allFaultTable').DataTable().column(116,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg38		=	$('#allFaultTable').DataTable().column(117,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa38		=	$('#allFaultTable').DataTable().column(118,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount39	=	$('#allFaultTable').DataTable().column(119,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg39		=	$('#allFaultTable').DataTable().column(120,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa39		=	$('#allFaultTable').DataTable().column(121,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceCount40	=	$('#allFaultTable').DataTable().column(122,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceKg40		=	$('#allFaultTable').DataTable().column(123,{ page: 'all'} ).data().sum();
			let allFaultSumReplaceEa40		=	$('#allFaultTable').DataTable().column(124,{ page: 'all'} ).data().sum();
			
			$('#allFaultSumReplaceKg1').text(allFaultSumReplaceKg1.toFixed(3));
			$('#allFaultSumReplaceKg2').text(allFaultSumReplaceKg2.toFixed(3));
			$('#allFaultSumReplaceKg3').text(allFaultSumReplaceKg3.toFixed(3));
			$('#allFaultSumReplaceKg4').text(allFaultSumReplaceKg4.toFixed(3));
			$('#allFaultSumReplaceKg5').text(allFaultSumReplaceKg5.toFixed(3));
			$('#allFaultSumReplaceKg6').text(allFaultSumReplaceKg6.toFixed(3));
			$('#allFaultSumReplaceKg7').text(allFaultSumReplaceKg7.toFixed(3));
			$('#allFaultSumReplaceKg8').text(allFaultSumReplaceKg8.toFixed(3));
			$('#allFaultSumReplaceKg9').text(allFaultSumReplaceKg9.toFixed(3));
			$('#allFaultSumReplaceKg10').text(allFaultSumReplaceKg10.toFixed(3));
			$('#allFaultSumReplaceKg11').text(allFaultSumReplaceKg11.toFixed(3));
			$('#allFaultSumReplaceKg12').text(allFaultSumReplaceKg12.toFixed(3));
			$('#allFaultSumReplaceKg13').text(allFaultSumReplaceKg13.toFixed(3));
			$('#allFaultSumReplaceKg14').text(allFaultSumReplaceKg14.toFixed(3));
			$('#allFaultSumReplaceKg15').text(allFaultSumReplaceKg15.toFixed(3));
			$('#allFaultSumReplaceKg16').text(allFaultSumReplaceKg16.toFixed(3));
			$('#allFaultSumReplaceKg17').text(allFaultSumReplaceKg17.toFixed(3));
			$('#allFaultSumReplaceKg18').text(allFaultSumReplaceKg18.toFixed(3));
			$('#allFaultSumReplaceKg19').text(allFaultSumReplaceKg19.toFixed(3));
			$('#allFaultSumReplaceKg20').text(allFaultSumReplaceKg20.toFixed(3));
			$('#allFaultSumReplaceKg21').text(allFaultSumReplaceKg21.toFixed(3));
			$('#allFaultSumReplaceKg22').text(allFaultSumReplaceKg22.toFixed(3));
			$('#allFaultSumReplaceKg23').text(allFaultSumReplaceKg23.toFixed(3));
			$('#allFaultSumReplaceKg24').text(allFaultSumReplaceKg24.toFixed(3));
			$('#allFaultSumReplaceKg25').text(allFaultSumReplaceKg25.toFixed(3));
			$('#allFaultSumReplaceKg26').text(allFaultSumReplaceKg26.toFixed(3));
			$('#allFaultSumReplaceKg27').text(allFaultSumReplaceKg27.toFixed(3));
			$('#allFaultSumReplaceKg28').text(allFaultSumReplaceKg28.toFixed(3));
			$('#allFaultSumReplaceKg29').text(allFaultSumReplaceKg29.toFixed(3));
			$('#allFaultSumReplaceKg30').text(allFaultSumReplaceKg30.toFixed(3));
			$('#allFaultSumReplaceKg31').text(allFaultSumReplaceKg31.toFixed(3));
			$('#allFaultSumReplaceKg32').text(allFaultSumReplaceKg32.toFixed(3));
			$('#allFaultSumReplaceKg33').text(allFaultSumReplaceKg33.toFixed(3));
			$('#allFaultSumReplaceKg34').text(allFaultSumReplaceKg34.toFixed(3));
			$('#allFaultSumReplaceKg35').text(allFaultSumReplaceKg35.toFixed(3));
			$('#allFaultSumReplaceKg36').text(allFaultSumReplaceKg36.toFixed(3));
			$('#allFaultSumReplaceKg37').text(allFaultSumReplaceKg37.toFixed(3));
			$('#allFaultSumReplaceKg38').text(allFaultSumReplaceKg38.toFixed(3));
			$('#allFaultSumReplaceKg39').text(allFaultSumReplaceKg39.toFixed(3));
			$('#allFaultSumReplaceKg40').text(allFaultSumReplaceKg40.toFixed(3));

			$('#allFaultSumReplaceEa1').text(addCommas(Math.round(allFaultSumReplaceEa1)));
			$('#allFaultSumReplaceEa2').text(addCommas(Math.round(allFaultSumReplaceEa2)));
			$('#allFaultSumReplaceEa3').text(addCommas(Math.round(allFaultSumReplaceEa3)));
			$('#allFaultSumReplaceEa4').text(addCommas(Math.round(allFaultSumReplaceEa4)));
			$('#allFaultSumReplaceEa5').text(addCommas(Math.round(allFaultSumReplaceEa5)));
			$('#allFaultSumReplaceEa6').text(addCommas(Math.round(allFaultSumReplaceEa6)));
			$('#allFaultSumReplaceEa7').text(addCommas(Math.round(allFaultSumReplaceEa7)));
			$('#allFaultSumReplaceEa8').text(addCommas(Math.round(allFaultSumReplaceEa8)));
			$('#allFaultSumReplaceEa9').text(addCommas(Math.round(allFaultSumReplaceEa9)));
			$('#allFaultSumReplaceEa10').text(addCommas(Math.round(allFaultSumReplaceEa10)));
			$('#allFaultSumReplaceEa11').text(addCommas(Math.round(allFaultSumReplaceEa11)));
			$('#allFaultSumReplaceEa12').text(addCommas(Math.round(allFaultSumReplaceEa12)));
			$('#allFaultSumReplaceEa13').text(addCommas(Math.round(allFaultSumReplaceEa13)));
			$('#allFaultSumReplaceEa14').text(addCommas(Math.round(allFaultSumReplaceEa14)));
			$('#allFaultSumReplaceEa15').text(addCommas(Math.round(allFaultSumReplaceEa15)));
			$('#allFaultSumReplaceEa16').text(addCommas(Math.round(allFaultSumReplaceEa16)));
			$('#allFaultSumReplaceEa17').text(addCommas(Math.round(allFaultSumReplaceEa17)));
			$('#allFaultSumReplaceEa18').text(addCommas(Math.round(allFaultSumReplaceEa18)));
			$('#allFaultSumReplaceEa19').text(addCommas(Math.round(allFaultSumReplaceEa19)));
			$('#allFaultSumReplaceEa20').text(addCommas(Math.round(allFaultSumReplaceEa20)));
			$('#allFaultSumReplaceEa21').text(addCommas(Math.round(allFaultSumReplaceEa21)));
			$('#allFaultSumReplaceEa22').text(addCommas(Math.round(allFaultSumReplaceEa22)));
			$('#allFaultSumReplaceEa23').text(addCommas(Math.round(allFaultSumReplaceEa23)));
			$('#allFaultSumReplaceEa24').text(addCommas(Math.round(allFaultSumReplaceEa24)));
			$('#allFaultSumReplaceEa25').text(addCommas(Math.round(allFaultSumReplaceEa25)));
			$('#allFaultSumReplaceEa26').text(addCommas(Math.round(allFaultSumReplaceEa26)));
			$('#allFaultSumReplaceEa27').text(addCommas(Math.round(allFaultSumReplaceEa27)));
			$('#allFaultSumReplaceEa28').text(addCommas(Math.round(allFaultSumReplaceEa28)));
			$('#allFaultSumReplaceEa29').text(addCommas(Math.round(allFaultSumReplaceKg29)));
			$('#allFaultSumReplaceEa30').text(addCommas(Math.round(allFaultSumReplaceKg30)));
			$('#allFaultSumReplaceEa31').text(addCommas(Math.round(allFaultSumReplaceKg31)));
			$('#allFaultSumReplaceEa32').text(addCommas(Math.round(allFaultSumReplaceKg32)));
			$('#allFaultSumReplaceEa33').text(addCommas(Math.round(allFaultSumReplaceKg33)));
			$('#allFaultSumReplaceEa34').text(addCommas(Math.round(allFaultSumReplaceKg34)));
			$('#allFaultSumReplaceEa35').text(addCommas(Math.round(allFaultSumReplaceKg35)));
			$('#allFaultSumReplaceEa36').text(addCommas(Math.round(allFaultSumReplaceKg36)));
			$('#allFaultSumReplaceEa37').text(addCommas(Math.round(allFaultSumReplaceKg37)));
			$('#allFaultSumReplaceEa38').text(addCommas(Math.round(allFaultSumReplaceKg38)));
			$('#allFaultSumReplaceEa39').text(addCommas(Math.round(allFaultSumReplaceKg39)));
			$('#allFaultSumReplaceEa40').text(addCommas(Math.round(allFaultSumReplaceKg40)));

			$('#allFaultSumReplaceCount1').text(allFaultSumReplaceCount1);
			$('#allFaultSumReplaceCount2').text(allFaultSumReplaceCount2);
			$('#allFaultSumReplaceCount3').text(allFaultSumReplaceCount3);
			$('#allFaultSumReplaceCount4').text(allFaultSumReplaceCount4);
			$('#allFaultSumReplaceCount5').text(allFaultSumReplaceCount5);
			$('#allFaultSumReplaceCount6').text(allFaultSumReplaceCount6);
			$('#allFaultSumReplaceCount7').text(allFaultSumReplaceCount7);
			$('#allFaultSumReplaceCount8').text(allFaultSumReplaceCount8);
			$('#allFaultSumReplaceCount9').text(allFaultSumReplaceCount9);
			$('#allFaultSumReplaceCount10').text(allFaultSumReplaceCount10);
			$('#allFaultSumReplaceCount11').text(allFaultSumReplaceCount11);
			$('#allFaultSumReplaceCount12').text(allFaultSumReplaceCount12);
			$('#allFaultSumReplaceCount13').text(allFaultSumReplaceCount13);
			$('#allFaultSumReplaceCount14').text(allFaultSumReplaceCount14);
			$('#allFaultSumReplaceCount15').text(allFaultSumReplaceCount15);
			$('#allFaultSumReplaceCount16').text(allFaultSumReplaceCount16);
			$('#allFaultSumReplaceCount17').text(allFaultSumReplaceCount17);
			$('#allFaultSumReplaceCount18').text(allFaultSumReplaceCount18);
			$('#allFaultSumReplaceCount19').text(allFaultSumReplaceCount19);
			$('#allFaultSumReplaceCount20').text(allFaultSumReplaceCount20);
			$('#allFaultSumReplaceCount21').text(allFaultSumReplaceCount21);
			$('#allFaultSumReplaceCount22').text(allFaultSumReplaceCount22);
			$('#allFaultSumReplaceCount23').text(allFaultSumReplaceCount23);
			$('#allFaultSumReplaceCount24').text(allFaultSumReplaceCount24);
			$('#allFaultSumReplaceCount25').text(allFaultSumReplaceCount25);
			$('#allFaultSumReplaceCount26').text(allFaultSumReplaceCount26);
			$('#allFaultSumReplaceCount27').text(allFaultSumReplaceCount27);
			$('#allFaultSumReplaceCount28').text(allFaultSumReplaceCount28);
			$('#allFaultSumReplaceCount29').text(allFaultSumReplaceCount29);
			$('#allFaultSumReplaceCount30').text(allFaultSumReplaceCount30);
			$('#allFaultSumReplaceCount31').text(allFaultSumReplaceCount31);
			$('#allFaultSumReplaceCount32').text(allFaultSumReplaceCount32);
			$('#allFaultSumReplaceCount33').text(allFaultSumReplaceCount33);
			$('#allFaultSumReplaceCount34').text(allFaultSumReplaceCount34);
			$('#allFaultSumReplaceCount35').text(allFaultSumReplaceCount35);
			$('#allFaultSumReplaceCount36').text(allFaultSumReplaceCount36);
			$('#allFaultSumReplaceCount37').text(allFaultSumReplaceCount37);
			$('#allFaultSumReplaceCount38').text(allFaultSumReplaceCount38);
			$('#allFaultSumReplaceCount39').text(allFaultSumReplaceCount39);
			$('#allFaultSumReplaceCount40').text(allFaultSumReplaceCount40);

// 			$('#allFaultTable tbody tr td').attr("style","min-width:60px;");
		 	$.each($('#allFaultTable tbody tr'),function(index,item) {
				if ($('#allFaultTable .0').text()=="") {
					$('#allFaultTable .0').addClass('d-none');
					$(this).find('td').eq(5).addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$('#allFaultSumReplaceCount1').addClass('d-none');
					$('#allFaultSumReplaceKg1').addClass('d-none');
					$('#allFaultSumReplaceEa1').addClass('d-none');
				}						
				if ($('#allFaultTable .1').text()=="") {
					$('#allFaultTable .1').addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#allFaultSumReplaceCount2').addClass('d-none');
					$('#allFaultSumReplaceKg2').addClass('d-none');
					$('#allFaultSumReplaceEa2').addClass('d-none');
				}
				if ($('#allFaultTable .2').text()=="") {
					$('#allFaultTable .2').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$('#allFaultSumReplaceCount3').addClass('d-none');
					$('#allFaultSumReplaceKg3').addClass('d-none');
					$('#allFaultSumReplaceEa3').addClass('d-none');
				}
				if ($('#allFaultTable .3').text()=="") {
					$('#allFaultTable .3').addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#allFaultSumReplaceCount4').addClass('d-none');
					$('#allFaultSumReplaceKg4').addClass('d-none');
					$('#allFaultSumReplaceEa4').addClass('d-none');
				}
				if ($('#allFaultTable .4').text()=="") {
					$('#allFaultTable .4').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#allFaultSumReplaceCount5').addClass('d-none');
					$('#allFaultSumReplaceKg5').addClass('d-none');
					$('#allFaultSumReplaceEa5').addClass('d-none');
				}
				if ($('#allFaultTable .5').text()=="") {
					$('#allFaultTable .5').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#allFaultSumReplaceCount6').addClass('d-none');
					$('#allFaultSumReplaceKg6').addClass('d-none');
					$('#allFaultSumReplaceEa6').addClass('d-none');
				}
				if ($('#allFaultTable .6').text()=="") {
					$('#allFaultTable .6').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#allFaultSumReplaceCount7').addClass('d-none');
					$('#allFaultSumReplaceKg7').addClass('d-none');
					$('#allFaultSumReplaceEa7').addClass('d-none');
				}
				if ($('#allFaultTable .7').text()=="") {
					$('#allFaultTable .7').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#allFaultSumReplaceCount8').addClass('d-none');
					$('#allFaultSumReplaceKg8').addClass('d-none');
					$('#allFaultSumReplaceEa8').addClass('d-none');
				}
				if ($('#allFaultTable .8').text()=="") {
					$('#allFaultTable .8').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#allFaultSumReplaceCount9').addClass('d-none');
					$('#allFaultSumReplaceKg9').addClass('d-none');
					$('#allFaultSumReplaceEa9').addClass('d-none');
				}
				if ($('#allFaultTable .9').text()=="") {
					$('#allFaultTable .9').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#allFaultSumReplaceCount10').addClass('d-none');
					$('#allFaultSumReplaceKg10').addClass('d-none');
					$('#allFaultSumReplaceEa10').addClass('d-none');
				}
				if ($('#allFaultTable .10').text()=="") {
					$('#allFaultTable .10').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#allFaultSumReplaceCount11').addClass('d-none');
					$('#allFaultSumReplaceKg11').addClass('d-none');
					$('#allFaultSumReplaceEa11').addClass('d-none');
				}
				if ($('#allFaultTable .11').text()=="") {
					$('#allFaultTable .11').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#allFaultSumReplaceCount12').addClass('d-none');
					$('#allFaultSumReplaceKg12').addClass('d-none');
					$('#allFaultSumReplaceEa12').addClass('d-none');
				}
				if ($('#allFaultTable .12').text()=="") {
					$('#allFaultTable .12').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#allFaultSumReplaceCount13').addClass('d-none');
					$('#allFaultSumReplaceKg13').addClass('d-none');
					$('#allFaultSumReplaceEa13').addClass('d-none');
				}
				if ($('#allFaultTable .13').text()=="") {
					$('#allFaultTable .13').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#allFaultSumReplaceCount14').addClass('d-none');
					$('#allFaultSumReplaceKg14').addClass('d-none');
					$('#allFaultSumReplaceEa14').addClass('d-none');
				}
				if ($('#allFaultTable .14').text()=="") {
					$('#allFaultTable .14').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#allFaultSumReplaceCount15').addClass('d-none');
					$('#allFaultSumReplaceKg15').addClass('d-none');
					$('#allFaultSumReplaceEa15').addClass('d-none');
				}
				if ($('#allFaultTable .15').text()=="") {
					$('#allFaultTable .15').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#allFaultSumReplaceCount16').addClass('d-none');
					$('#allFaultSumReplaceKg16').addClass('d-none');
					$('#allFaultSumReplaceEa16').addClass('d-none');
				}
				if ($('#allFaultTable .16').text()=="") {
					$('#allFaultTable .16').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$('#allFaultSumReplaceCount17').addClass('d-none');
					$('#allFaultSumReplaceKg17').addClass('d-none');
					$('#allFaultSumReplaceEa17').addClass('d-none');
				}
				if ($('#allFaultTable .17').text()=="") {
					$('#allFaultTable .17').addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#allFaultSumReplaceCount18').addClass('d-none');
					$('#allFaultSumReplaceKg18').addClass('d-none');
					$('#allFaultSumReplaceEa18').addClass('d-none');
				}
				if ($('#allFaultTable .18').text()=="") {
					$('#allFaultTable .18').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$('#allFaultSumReplaceCount19').addClass('d-none');
					$('#allFaultSumReplaceKg19').addClass('d-none');
					$('#allFaultSumReplaceEa19').addClass('d-none');
				}
				if ($('#allFaultTable .19').text()=="") {
					$('#allFaultTable .19').addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#allFaultSumReplaceCount20').addClass('d-none');
					$('#allFaultSumReplaceKg20').addClass('d-none');
					$('#allFaultSumReplaceEa20').addClass('d-none');
				}
				if ($('#allFaultTable .20').text()=="") {
					$('#allFaultTable .20').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$('#allFaultSumReplaceCount21').addClass('d-none');
					$('#allFaultSumReplaceKg21').addClass('d-none');
					$('#allFaultSumReplaceEa21').addClass('d-none');
				}
				if ($('#allFaultTable .21').text()=="") {
					$('#allFaultTable .21').addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#allFaultSumReplaceCount22').addClass('d-none');
					$('#allFaultSumReplaceKg22').addClass('d-none');
					$('#allFaultSumReplaceEa22').addClass('d-none');
				}
				if ($('#allFaultTable .22').text()=="") {
					$('#allFaultTable .22').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$('#allFaultSumReplaceCount23').addClass('d-none');
					$('#allFaultSumReplaceKg23').addClass('d-none');
					$('#allFaultSumReplaceEa23').addClass('d-none');
				}
				if ($('#allFaultTable .23').text()=="") {
					$('#allFaultTable .23').addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#allFaultSumReplaceCount24').addClass('d-none');
					$('#allFaultSumReplaceKg24').addClass('d-none');
					$('#allFaultSumReplaceEa24').addClass('d-none');
				}
				if ($('#allFaultTable .24').text()=="") {
					$('#allFaultTable .24').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$('#allFaultSumReplaceCount25').addClass('d-none');
					$('#allFaultSumReplaceKg25').addClass('d-none');
					$('#allFaultSumReplaceEa25').addClass('d-none');
				}
				if ($('#allFaultTable .25').text()=="") {
					$('#allFaultTable .25').addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#allFaultSumReplaceCount26').addClass('d-none');
					$('#allFaultSumReplaceKg26').addClass('d-none');
					$('#allFaultSumReplaceEa26').addClass('d-none');
				}
				if ($('#allFaultTable .26').text()=="") {
					$('#allFaultTable .26').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$(this).find('td').eq(85).addClass('d-none');
					$('#allFaultSumReplaceCount27').addClass('d-none');
					$('#allFaultSumReplaceKg27').addClass('d-none');
					$('#allFaultSumReplaceEa27').addClass('d-none');
				}
				if ($('#allFaultTable .27').text()=="") {
					$('#allFaultTable .27').addClass('d-none');
					$(this).find('td').eq(86).addClass('d-none');
					$(this).find('td').eq(87).addClass('d-none');
					$(this).find('td').eq(88).addClass('d-none');
					$('#allFaultSumReplaceCount28').addClass('d-none');
					$('#allFaultSumReplaceKg28').addClass('d-none');
					$('#allFaultSumReplaceEa28').addClass('d-none');
				}
				if ($('#allFaultTable .28').text()=="") {
					$('#allFaultTable .28').addClass('d-none');
					$(this).find('td').eq(89).addClass('d-none');
					$(this).find('td').eq(90).addClass('d-none');
					$(this).find('td').eq(91).addClass('d-none');
					$('#allFaultSumReplaceCount29').addClass('d-none');
					$('#allFaultSumReplaceKg29').addClass('d-none');
					$('#allFaultSumReplaceEa29').addClass('d-none');
				}
				if ($('#allFaultTable .29').text()=="") {
					$('#allFaultTable .29').addClass('d-none');
					$(this).find('td').eq(92).addClass('d-none');
					$(this).find('td').eq(93).addClass('d-none');
					$(this).find('td').eq(94).addClass('d-none');
					$('#allFaultSumReplaceCount30').addClass('d-none');
					$('#allFaultSumReplaceKg30').addClass('d-none');
					$('#allFaultSumReplaceEa30').addClass('d-none');
				}
				if ($('#allFaultTable .30').text()=="") {
					$('#allFaultTable .30').addClass('d-none');
					$(this).find('td').eq(95).addClass('d-none');
					$(this).find('td').eq(96).addClass('d-none');
					$(this).find('td').eq(97).addClass('d-none');
					$('#allFaultSumReplaceCount31').addClass('d-none');
					$('#allFaultSumReplaceKg31').addClass('d-none');
					$('#allFaultSumReplaceEa31').addClass('d-none');
				}
				if ($('#allFaultTable .31').text()=="") {
					$('#allFaultTable .31').addClass('d-none');
					$(this).find('td').eq(98).addClass('d-none');
					$(this).find('td').eq(99).addClass('d-none');
					$(this).find('td').eq(100).addClass('d-none');
					$('#allFaultSumReplaceCount32').addClass('d-none');
					$('#allFaultSumReplaceKg32').addClass('d-none');
					$('#allFaultSumReplaceEa32').addClass('d-none');
				}
				if ($('#allFaultTable .32').text()=="") {
					$('#allFaultTable .32').addClass('d-none');
					$(this).find('td').eq(101).addClass('d-none');
					$(this).find('td').eq(102).addClass('d-none');
					$(this).find('td').eq(103).addClass('d-none');
					$('#allFaultSumReplaceCount33').addClass('d-none');
					$('#allFaultSumReplaceKg33').addClass('d-none');
					$('#allFaultSumReplaceEa33').addClass('d-none');
				}
				if ($('#allFaultTable .33').text()=="") {
					$('#allFaultTable .33').addClass('d-none');
					$(this).find('td').eq(104).addClass('d-none');
					$(this).find('td').eq(105).addClass('d-none');
					$(this).find('td').eq(106).addClass('d-none');
					$('#allFaultSumReplaceCount34').addClass('d-none');
					$('#allFaultSumReplaceKg34').addClass('d-none');
					$('#allFaultSumReplaceEa34').addClass('d-none');
				}
				if ($('#allFaultTable .34').text()=="") {
					$('#allFaultTable .34').addClass('d-none');
					$(this).find('td').eq(107).addClass('d-none');
					$(this).find('td').eq(108).addClass('d-none');
					$(this).find('td').eq(109).addClass('d-none');
					$('#allFaultSumReplaceCount35').addClass('d-none');
					$('#allFaultSumReplaceKg35').addClass('d-none');
					$('#allFaultSumReplaceEa35').addClass('d-none');
				}
				if ($('#allFaultTable .35').text()=="") {
					$('#allFaultTable .35').addClass('d-none');
					$(this).find('td').eq(110).addClass('d-none');
					$(this).find('td').eq(111).addClass('d-none');
					$(this).find('td').eq(112).addClass('d-none');
					$('#allFaultSumReplaceCount36').addClass('d-none');
					$('#allFaultSumReplaceKg36').addClass('d-none');
					$('#allFaultSumReplaceEa36').addClass('d-none');
				}
				if ($('#allFaultTable .36').text()=="") {
					$('#allFaultTable .36').addClass('d-none');
					$(this).find('td').eq(113).addClass('d-none');
					$(this).find('td').eq(114).addClass('d-none');
					$(this).find('td').eq(115).addClass('d-none');
					$('#allFaultSumReplaceCount37').addClass('d-none');
					$('#allFaultSumReplaceKg37').addClass('d-none');
					$('#allFaultSumReplaceEa37').addClass('d-none');
				}
				if ($('#allFaultTable .37').text()=="") {
					$('#allFaultTable .37').addClass('d-none');
					$(this).find('td').eq(116).addClass('d-none');
					$(this).find('td').eq(117).addClass('d-none');
					$(this).find('td').eq(118).addClass('d-none');
					$('#allFaultSumReplaceCount38').addClass('d-none');
					$('#allFaultSumReplaceKg38').addClass('d-none');
					$('#allFaultSumReplaceEa38').addClass('d-none');
				}
				if ($('#allFaultTable .38').text()=="") {
					$('#allFaultTable .38').addClass('d-none');
					$(this).find('td').eq(119).addClass('d-none');
					$(this).find('td').eq(120).addClass('d-none');
					$(this).find('td').eq(121).addClass('d-none');
					$('#allFaultSumReplaceCount39').addClass('d-none');
					$('#allFaultSumReplaceKg39').addClass('d-none');
					$('#allFaultSumReplaceEa39').addClass('d-none');
				}
				if ($('#allFaultTable .39').text()=="") {
					$('#allFaultTable .39').addClass('d-none');
					$(this).find('td').eq(122).addClass('d-none');
					$(this).find('td').eq(123).addClass('d-none');
					$(this).find('td').eq(124).addClass('d-none');
					$('#allFaultSumReplaceCount40').addClass('d-none');
					$('#allFaultSumReplaceKg40').addClass('d-none');
					$('#allFaultSumReplaceEa40').addClass('d-none');
				}
		 	});
		 	
			//생산-공정 조정(2)
			let allFaultSumPrcssKg1		=	$('#allFaultTable').DataTable().column(125,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa1		=	$('#allFaultTable').DataTable().column(126,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg2		=	$('#allFaultTable').DataTable().column(127,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa2		=	$('#allFaultTable').DataTable().column(128,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg3		=	$('#allFaultTable').DataTable().column(129,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa3		=	$('#allFaultTable').DataTable().column(130,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg4		=	$('#allFaultTable').DataTable().column(131,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa4		=	$('#allFaultTable').DataTable().column(132,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg5		=	$('#allFaultTable').DataTable().column(133,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa5		=	$('#allFaultTable').DataTable().column(134,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg6		=	$('#allFaultTable').DataTable().column(135,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa6		=	$('#allFaultTable').DataTable().column(136,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg7		=	$('#allFaultTable').DataTable().column(137,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa7		=	$('#allFaultTable').DataTable().column(138,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg8		=	$('#allFaultTable').DataTable().column(139,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa8		=	$('#allFaultTable').DataTable().column(140,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg9		=	$('#allFaultTable').DataTable().column(141,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa9		=	$('#allFaultTable').DataTable().column(142,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg10	=	$('#allFaultTable').DataTable().column(143,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa10	=	$('#allFaultTable').DataTable().column(144,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg11	=	$('#allFaultTable').DataTable().column(145,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa11	=	$('#allFaultTable').DataTable().column(146,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg12	=	$('#allFaultTable').DataTable().column(147,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa12	=	$('#allFaultTable').DataTable().column(148,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg13	=	$('#allFaultTable').DataTable().column(149,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa13	=	$('#allFaultTable').DataTable().column(150,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg14	=	$('#allFaultTable').DataTable().column(151,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa14	=	$('#allFaultTable').DataTable().column(152,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg15	=	$('#allFaultTable').DataTable().column(153,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa15	=	$('#allFaultTable').DataTable().column(154,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg16	=	$('#allFaultTable').DataTable().column(155,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa16	=	$('#allFaultTable').DataTable().column(156,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg17	=	$('#allFaultTable').DataTable().column(157,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa17	=	$('#allFaultTable').DataTable().column(158,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg18	=	$('#allFaultTable').DataTable().column(159,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa18	=	$('#allFaultTable').DataTable().column(160,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg19	=	$('#allFaultTable').DataTable().column(161,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa19	=	$('#allFaultTable').DataTable().column(162,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg20	=	$('#allFaultTable').DataTable().column(163,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa20	=	$('#allFaultTable').DataTable().column(164,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg21	=	$('#allFaultTable').DataTable().column(165,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa21	=	$('#allFaultTable').DataTable().column(166,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg22	=	$('#allFaultTable').DataTable().column(167,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa22	=	$('#allFaultTable').DataTable().column(168,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg23	=	$('#allFaultTable').DataTable().column(169,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa23	=	$('#allFaultTable').DataTable().column(170,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg24	=	$('#allFaultTable').DataTable().column(171,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa24	=	$('#allFaultTable').DataTable().column(172,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg25	=	$('#allFaultTable').DataTable().column(173,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa25	=	$('#allFaultTable').DataTable().column(174,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg26	=	$('#allFaultTable').DataTable().column(175,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa26	=	$('#allFaultTable').DataTable().column(176,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg27	=	$('#allFaultTable').DataTable().column(177,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa27	=	$('#allFaultTable').DataTable().column(178,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg28	=	$('#allFaultTable').DataTable().column(179,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa28	=	$('#allFaultTable').DataTable().column(180,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg29	=	$('#allFaultTable').DataTable().column(181,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa29	=	$('#allFaultTable').DataTable().column(182,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg30	=	$('#allFaultTable').DataTable().column(183,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa30	=	$('#allFaultTable').DataTable().column(184,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg31	=	$('#allFaultTable').DataTable().column(185,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa31	=	$('#allFaultTable').DataTable().column(186,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg32	=	$('#allFaultTable').DataTable().column(187,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa32	=	$('#allFaultTable').DataTable().column(188,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg33	=	$('#allFaultTable').DataTable().column(189,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa33	=	$('#allFaultTable').DataTable().column(190,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg34	=	$('#allFaultTable').DataTable().column(191,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa34	=	$('#allFaultTable').DataTable().column(192,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg35	=	$('#allFaultTable').DataTable().column(193,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa35	=	$('#allFaultTable').DataTable().column(194,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg36	=	$('#allFaultTable').DataTable().column(195,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa36	=	$('#allFaultTable').DataTable().column(196,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg37	=	$('#allFaultTable').DataTable().column(197,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa37	=	$('#allFaultTable').DataTable().column(198,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg38	=	$('#allFaultTable').DataTable().column(199,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa38	=	$('#allFaultTable').DataTable().column(200,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg39	=	$('#allFaultTable').DataTable().column(201,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa39	=	$('#allFaultTable').DataTable().column(202,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssKg40	=	$('#allFaultTable').DataTable().column(203,{ page: 'all'} ).data().sum();
			let allFaultSumPrcssEa40	=	$('#allFaultTable').DataTable().column(204,{ page: 'all'} ).data().sum();
			
			$('#allFaultSumPrcssKg1').text(allFaultSumPrcssKg1.toFixed(3));
			$('#allFaultSumPrcssKg2').text(allFaultSumPrcssKg2.toFixed(3));
			$('#allFaultSumPrcssKg3').text(allFaultSumPrcssKg3.toFixed(3));
			$('#allFaultSumPrcssKg4').text(allFaultSumPrcssKg4.toFixed(3));
			$('#allFaultSumPrcssKg5').text(allFaultSumPrcssKg5.toFixed(3));
			$('#allFaultSumPrcssKg6').text(allFaultSumPrcssKg6.toFixed(3));
			$('#allFaultSumPrcssKg7').text(allFaultSumPrcssKg7.toFixed(3));
			$('#allFaultSumPrcssKg8').text(allFaultSumPrcssKg8.toFixed(3));
			$('#allFaultSumPrcssKg9').text(allFaultSumPrcssKg9.toFixed(3));
			$('#allFaultSumPrcssKg10').text(allFaultSumPrcssKg10.toFixed(3));
			$('#allFaultSumPrcssKg11').text(allFaultSumPrcssKg11.toFixed(3));
			$('#allFaultSumPrcssKg12').text(allFaultSumPrcssKg12.toFixed(3));
			$('#allFaultSumPrcssKg13').text(allFaultSumPrcssKg13.toFixed(3));
			$('#allFaultSumPrcssKg14').text(allFaultSumPrcssKg14.toFixed(3));
			$('#allFaultSumPrcssKg15').text(allFaultSumPrcssKg15.toFixed(3));
			$('#allFaultSumPrcssKg16').text(allFaultSumPrcssKg16.toFixed(3));
			$('#allFaultSumPrcssKg17').text(allFaultSumPrcssKg17.toFixed(3));
			$('#allFaultSumPrcssKg18').text(allFaultSumPrcssKg18.toFixed(3));
			$('#allFaultSumPrcssKg19').text(allFaultSumPrcssKg19.toFixed(3));
			$('#allFaultSumPrcssKg20').text(allFaultSumPrcssKg20.toFixed(3));
			$('#allFaultSumPrcssKg21').text(allFaultSumPrcssKg21.toFixed(3));
			$('#allFaultSumPrcssKg22').text(allFaultSumPrcssKg22.toFixed(3));
			$('#allFaultSumPrcssKg23').text(allFaultSumPrcssKg23.toFixed(3));
			$('#allFaultSumPrcssKg24').text(allFaultSumPrcssKg24.toFixed(3));
			$('#allFaultSumPrcssKg25').text(allFaultSumPrcssKg25.toFixed(3));
			$('#allFaultSumPrcssKg26').text(allFaultSumPrcssKg26.toFixed(3));
			$('#allFaultSumPrcssKg27').text(allFaultSumPrcssKg27.toFixed(3));
			$('#allFaultSumPrcssKg28').text(allFaultSumPrcssKg28.toFixed(3));
			$('#allFaultSumPrcssKg29').text(allFaultSumPrcssKg29.toFixed(3));
			$('#allFaultSumPrcssKg30').text(allFaultSumPrcssKg30.toFixed(3));
			$('#allFaultSumPrcssKg31').text(allFaultSumPrcssKg31.toFixed(3));
			$('#allFaultSumPrcssKg32').text(allFaultSumPrcssKg32.toFixed(3));
			$('#allFaultSumPrcssKg33').text(allFaultSumPrcssKg33.toFixed(3));
			$('#allFaultSumPrcssKg34').text(allFaultSumPrcssKg34.toFixed(3));
			$('#allFaultSumPrcssKg35').text(allFaultSumPrcssKg35.toFixed(3));
			$('#allFaultSumPrcssKg36').text(allFaultSumPrcssKg36.toFixed(3));
			$('#allFaultSumPrcssKg37').text(allFaultSumPrcssKg37.toFixed(3));
			$('#allFaultSumPrcssKg38').text(allFaultSumPrcssKg38.toFixed(3));
			$('#allFaultSumPrcssKg39').text(allFaultSumPrcssKg39.toFixed(3));
			$('#allFaultSumPrcssKg40').text(allFaultSumPrcssKg40.toFixed(3));

			$('#allFaultSumPrcssEa1').text(addCommas(Math.round(allFaultSumPrcssEa1)));
			$('#allFaultSumPrcssEa2').text(addCommas(Math.round(allFaultSumPrcssEa2)));
			$('#allFaultSumPrcssEa3').text(addCommas(Math.round(allFaultSumPrcssEa3)));
			$('#allFaultSumPrcssEa4').text(addCommas(Math.round(allFaultSumPrcssEa4)));
			$('#allFaultSumPrcssEa5').text(addCommas(Math.round(allFaultSumPrcssEa5)));
			$('#allFaultSumPrcssEa6').text(addCommas(Math.round(allFaultSumPrcssEa6)));
			$('#allFaultSumPrcssEa7').text(addCommas(Math.round(allFaultSumPrcssEa7)));
			$('#allFaultSumPrcssEa8').text(addCommas(Math.round(allFaultSumPrcssEa8)));
			$('#allFaultSumPrcssEa9').text(addCommas(Math.round(allFaultSumPrcssEa9)));
			$('#allFaultSumPrcssEa10').text(addCommas(Math.round(allFaultSumPrcssEa10)));
			$('#allFaultSumPrcssEa11').text(addCommas(Math.round(allFaultSumPrcssEa11)));
			$('#allFaultSumPrcssEa12').text(addCommas(Math.round(allFaultSumPrcssEa12)));
			$('#allFaultSumPrcssEa13').text(addCommas(Math.round(allFaultSumPrcssEa13)));
			$('#allFaultSumPrcssEa14').text(addCommas(Math.round(allFaultSumPrcssEa14)));
			$('#allFaultSumPrcssEa15').text(addCommas(Math.round(allFaultSumPrcssEa15)));
			$('#allFaultSumPrcssEa16').text(addCommas(Math.round(allFaultSumPrcssEa16)));
			$('#allFaultSumPrcssEa17').text(addCommas(Math.round(allFaultSumPrcssEa17)));
			$('#allFaultSumPrcssEa18').text(addCommas(Math.round(allFaultSumPrcssEa18)));
			$('#allFaultSumPrcssEa19').text(addCommas(Math.round(allFaultSumPrcssEa19)));
			$('#allFaultSumPrcssEa20').text(addCommas(Math.round(allFaultSumPrcssEa20)));
			$('#allFaultSumPrcssEa21').text(addCommas(Math.round(allFaultSumPrcssEa21)));
			$('#allFaultSumPrcssEa22').text(addCommas(Math.round(allFaultSumPrcssEa22)));
			$('#allFaultSumPrcssEa23').text(addCommas(Math.round(allFaultSumPrcssEa23)));
			$('#allFaultSumPrcssEa24').text(addCommas(Math.round(allFaultSumPrcssEa24)));
			$('#allFaultSumPrcssEa25').text(addCommas(Math.round(allFaultSumPrcssEa25)));
			$('#allFaultSumPrcssEa26').text(addCommas(Math.round(allFaultSumPrcssEa26)));
			$('#allFaultSumPrcssEa27').text(addCommas(Math.round(allFaultSumPrcssEa27)));
			$('#allFaultSumPrcssEa28').text(addCommas(Math.round(allFaultSumPrcssEa28)));
			$('#allFaultSumPrcssEa29').text(addCommas(Math.round(allFaultSumPrcssKg29)));
			$('#allFaultSumPrcssEa30').text(addCommas(Math.round(allFaultSumPrcssKg30)));
			$('#allFaultSumPrcssEa31').text(addCommas(Math.round(allFaultSumPrcssKg31)));
			$('#allFaultSumPrcssEa32').text(addCommas(Math.round(allFaultSumPrcssKg32)));
			$('#allFaultSumPrcssEa33').text(addCommas(Math.round(allFaultSumPrcssKg33)));
			$('#allFaultSumPrcssEa34').text(addCommas(Math.round(allFaultSumPrcssKg34)));
			$('#allFaultSumPrcssEa35').text(addCommas(Math.round(allFaultSumPrcssKg35)));
			$('#allFaultSumPrcssEa36').text(addCommas(Math.round(allFaultSumPrcssKg36)));
			$('#allFaultSumPrcssEa37').text(addCommas(Math.round(allFaultSumPrcssKg37)));
			$('#allFaultSumPrcssEa38').text(addCommas(Math.round(allFaultSumPrcssKg38)));
			$('#allFaultSumPrcssEa39').text(addCommas(Math.round(allFaultSumPrcssKg39)));
			$('#allFaultSumPrcssEa40').text(addCommas(Math.round(allFaultSumPrcssKg40)));

// 			$('#allFaultTable tbody tr td').attr("style","min-width:60px;");
		 	$.each($('#allFaultTable tbody tr'),function(index,item) {
				if ($('#allFaultTable .50').text()=="") {
					$('#allFaultTable .50').addClass('d-none');
					$(this).find('td').eq(125).addClass('d-none');
					$(this).find('td').eq(126).addClass('d-none');
					$('#allFaultSumPrcssKg1').addClass('d-none');
					$('#allFaultSumPrcssEa1').addClass('d-none');
				}
				if ($('#allFaultTable .51').text()=="") {
					$('#allFaultTable .51').addClass('d-none');
					$(this).find('td').eq(127).addClass('d-none');
					$(this).find('td').eq(128).addClass('d-none');
					$('#allFaultSumPrcssKg2').addClass('d-none');
					$('#allFaultSumPrcssEa2').addClass('d-none');
				 }
				if ($('#allFaultTable .52').text()=="") {
					$('#allFaultTable .52').addClass('d-none');
					$(this).find('td').eq(129).addClass('d-none');
					$(this).find('td').eq(130).addClass('d-none');
					$('#allFaultSumPrcssKg3').addClass('d-none');
					$('#allFaultSumPrcssEa3').addClass('d-none');
				}
				if ($('#allFaultTable .53').text()=="") {
					$('#allFaultTable .53').addClass('d-none');
					$(this).find('td').eq(131).addClass('d-none');
					$(this).find('td').eq(132).addClass('d-none');
					$('#allFaultSumPrcssKg4').addClass('d-none');
					$('#allFaultSumPrcssEa4').addClass('d-none');
				}
				if ($('#allFaultTable .54').text()=="") {
					$('#allFaultTable .54').addClass('d-none');
					$(this).find('td').eq(133).addClass('d-none');
					$(this).find('td').eq(134).addClass('d-none');
					$('#allFaultSumPrcssKg5').addClass('d-none');
					$('#allFaultSumPrcssEa5').addClass('d-none');
				}
				if ($('#allFaultTable .55').text()=="") {
					$('#allFaultTable .55').addClass('d-none');
					$(this).find('td').eq(135).addClass('d-none');
					$(this).find('td').eq(136).addClass('d-none');
					$('#allFaultSumPrcssKg6').addClass('d-none');
					$('#allFaultSumPrcssEa6').addClass('d-none');
				}
				if ($('#allFaultTable .56').text()=="") {
					$('#allFaultTable .56').addClass('d-none');
					$(this).find('td').eq(137).addClass('d-none');
					$(this).find('td').eq(138).addClass('d-none');
					$('#allFaultSumPrcssKg7').addClass('d-none');
					$('#allFaultSumPrcssEa7').addClass('d-none');
				}
				if ($('#allFaultTable .57').text()=="") {
					$('#allFaultTable .57').addClass('d-none');
					$(this).find('td').eq(139).addClass('d-none');
					$(this).find('td').eq(140).addClass('d-none');
					$('#allFaultSumPrcssKg8').addClass('d-none');
					$('#allFaultSumPrcssEa8').addClass('d-none');
				}
				if ($('#allFaultTable .58').text()=="") {
					$('#allFaultTable .58').addClass('d-none');
					$(this).find('td').eq(141).addClass('d-none');
					$(this).find('td').eq(142).addClass('d-none');
					$('#allFaultSumPrcssKg9').addClass('d-none');
					$('#allFaultSumPrcssEa9').addClass('d-none');
				}
				if ($('#allFaultTable .59').text()=="") {
					$('#allFaultTable .59').addClass('d-none');
					$(this).find('td').eq(143).addClass('d-none');
					$(this).find('td').eq(144).addClass('d-none');
					$('#allFaultSumPrcssKg10').addClass('d-none');
					$('#allFaultSumPrcssEa10').addClass('d-none');
				}
				if ($('#allFaultTable .60').text()=="") {
					$('#allFaultTable .60').addClass('d-none');
					$(this).find('td').eq(145).addClass('d-none');
					$(this).find('td').eq(146).addClass('d-none');
					$('#allFaultSumPrcssKg11').addClass('d-none');
					$('#allFaultSumPrcssEa11').addClass('d-none');
				}
				if ($('#allFaultTable .61').text()=="") {
					$('#allFaultTable .61').addClass('d-none')
					$(this).find('td').eq(147).addClass('d-none');
					$(this).find('td').eq(148).addClass('d-none');
					$('#allFaultSumPrcssKg12').addClass('d-none');
					$('#allFaultSumPrcssEa12').addClass('d-none');
				}
				if ($('#allFaultTable .62').text()=="") {
					$('#allFaultTable .62').addClass('d-none');
					$(this).find('td').eq(149).addClass('d-none');
					$(this).find('td').eq(150).addClass('d-none');
					$('#allFaultSumPrcssKg13').addClass('d-none');
					$('#allFaultSumPrcssEa13').addClass('d-none');
				}
				if ($('#allFaultTable .63').text()=="") {
					$('#allFaultTable .63').addClass('d-none')
					$(this).find('td').eq(151).addClass('d-none');
					$(this).find('td').eq(152).addClass('d-none');
					$('#allFaultSumPrcssKg14').addClass('d-none');
					$('#allFaultSumPrcssEa14').addClass('d-none');
				}
				if ($('#allFaultTable .64').text()=="") {
					$('#allFaultTable .64').addClass('d-none')
					$(this).find('td').eq(153).addClass('d-none');
					$(this).find('td').eq(154).addClass('d-none');
					$('#allFaultSumPrcssKg15').addClass('d-none');
					$('#allFaultSumPrcssEa15').addClass('d-none');
				}
				if ($('#allFaultTable .65').text()=="") {
					$('#allFaultTable .65').addClass('d-none')
					$(this).find('td').eq(155).addClass('d-none');
					$(this).find('td').eq(156).addClass('d-none');
					$('#allFaultSumPrcssKg16').addClass('d-none');
					$('#allFaultSumPrcssEa16').addClass('d-none');
				}
				if ($('#allFaultTable .66').text()=="") {
					$('#allFaultTable .66').addClass('d-none');
					$(this).find('td').eq(157).addClass('d-none');
					$(this).find('td').eq(158).addClass('d-none');
					$('#allFaultSumPrcssKg17').addClass('d-none');
					$('#allFaultSumPrcssEa17').addClass('d-none');
				}
				if ($('#allFaultTable .67').text()=="") {
					$('#allFaultTable .67').addClass('d-none');
					$(this).find('td').eq(159).addClass('d-none');
					$(this).find('td').eq(160).addClass('d-none');
					$('#allFaultSumPrcssKg18').addClass('d-none');
					$('#allFaultSumPrcssEa18').addClass('d-none');
				}
				if ($('#allFaultTable .68').text()=="") {
					$('#allFaultTable .68').addClass('d-none');
					$(this).find('td').eq(161).addClass('d-none');
					$(this).find('td').eq(162).addClass('d-none');
					$('#allFaultSumPrcssKg19').addClass('d-none');
					$('#allFaultSumPrcssEa19').addClass('d-none');
				}
				if ($('#allFaultTable .69').text()=="") {
					$('#allFaultTable .69').addClass('d-none');
					$(this).find('td').eq(163).addClass('d-none');
					$(this).find('td').eq(164).addClass('d-none');
					$('#allFaultSumPrcssKg20').addClass('d-none');
					$('#allFaultSumPrcssEa20').addClass('d-none');
				}
				if ($('#allFaultTable .70').text()=="") {
					$('#allFaultTable .70').addClass('d-none');
					$(this).find('td').eq(165).addClass('d-none');
					$(this).find('td').eq(166).addClass('d-none');
					$('#allFaultSumPrcssKg21').addClass('d-none');
					$('#allFaultSumPrcssEa21').addClass('d-none');
				}
				if ($('#allFaultTable .71').text()=="") {
					$('#allFaultTable .71').addClass('d-none');
					$(this).find('td').eq(167).addClass('d-none');
					$(this).find('td').eq(168).addClass('d-none');
					$('#allFaultSumPrcssKg22').addClass('d-none');
					$('#allFaultSumPrcssEa22').addClass('d-none');
				}
				if ($('#allFaultTable .72').text()=="") {
					$('#allFaultTable .72').addClass('d-none');
					$(this).find('td').eq(169).addClass('d-none');
					$(this).find('td').eq(170).addClass('d-none');
					$('#allFaultSumPrcssKg23').addClass('d-none');
					$('#allFaultSumPrcssEa23').addClass('d-none');
				}
				if ($('#allFaultTable .73').text()=="") {
					$('#allFaultTable .73').addClass('d-none');
					$(this).find('td').eq(171).addClass('d-none');
					$(this).find('td').eq(172).addClass('d-none');
					$('#allFaultSumPrcssKg24').addClass('d-none');
					$('#allFaultSumPrcssEa24').addClass('d-none');
				}
				if ($('#allFaultTable .74').text()=="") {
					$('#allFaultTable .74').addClass('d-none');
					$(this).find('td').eq(173).addClass('d-none');
					$(this).find('td').eq(174).addClass('d-none');
					$('#allFaultSumPrcssKg25').addClass('d-none');
					$('#allFaultSumPrcssEa25').addClass('d-none');
				}
				if ($('#allFaultTable .75').text()=="") {
					$('#allFaultTable .75').addClass('d-none');
					$(this).find('td').eq(175).addClass('d-none');
					$(this).find('td').eq(176).addClass('d-none');
					$('#allFaultSumPrcssKg26').addClass('d-none');
					$('#allFaultSumPrcssEa26').addClass('d-none');
				}
				if ($('#allFaultTable .76').text()=="") {
					$('#allFaultTable .76').addClass('d-none');
					$(this).find('td').eq(177).addClass('d-none');
					$(this).find('td').eq(178).addClass('d-none');
					$('#allFaultSumPrcssKg27').addClass('d-none');
					$('#allFaultSumPrcssEa27').addClass('d-none');
				}
				if ($('#allFaultTable .77').text()=="") {
					$('#allFaultTable .77').addClass('d-none');
					$(this).find('td').eq(179).addClass('d-none');
					$(this).find('td').eq(180).addClass('d-none');
					$('#allFaultSumPrcssKg28').addClass('d-none');
					$('#allFaultSumPrcssEa28').addClass('d-none');
				}
				if ($('#allFaultTable .78').text()=="") {
					$('#allFaultTable .78').addClass('d-none');
					$(this).find('td').eq(181).addClass('d-none');
					$(this).find('td').eq(182).addClass('d-none');
					$('#allFaultSumPrcssKg29').addClass('d-none');
					$('#allFaultSumPrcssEa29').addClass('d-none');
				}
				if ($('#allFaultTable .79').text()=="") {
					$('#allFaultTable .79').addClass('d-none');
					$(this).find('td').eq(183).addClass('d-none');
					$(this).find('td').eq(184).addClass('d-none');
					$('#allFaultSumPrcssKg30').addClass('d-none');
					$('#allFaultSumPrcssEa30').addClass('d-none');
				}
				if ($('#allFaultTable .80').text()=="") {
					$('#allFaultTable .80').addClass('d-none');
					$(this).find('td').eq(185).addClass('d-none');
					$(this).find('td').eq(186).addClass('d-none');
					$('#allFaultSumPrcssKg31').addClass('d-none');
					$('#allFaultSumPrcssEa31').addClass('d-none');
				}
				if ($('#allFaultTable .81').text()=="") {
					$('#allFaultTable .81').addClass('d-none');
					$(this).find('td').eq(187).addClass('d-none');
					$(this).find('td').eq(188).addClass('d-none');
					$('#allFaultSumPrcssKg32').addClass('d-none');
					$('#allFaultSumPrcssEa32').addClass('d-none');
				}
				if ($('#allFaultTable .82').text()=="") {
					$('#allFaultTable .82').addClass('d-none');
					$(this).find('td').eq(189).addClass('d-none');
					$(this).find('td').eq(190).addClass('d-none');
					$('#allFaultSumPrcssKg33').addClass('d-none');
					$('#allFaultSumPrcssEa33').addClass('d-none');
				}
				if ($('#allFaultTable .83').text()=="") {
					$('#allFaultTable .83').addClass('d-none');
					$(this).find('td').eq(191).addClass('d-none');
					$(this).find('td').eq(192).addClass('d-none');
					$('#allFaultSumPrcssKg34').addClass('d-none');
					$('#allFaultSumPrcssEa34').addClass('d-none');
				}
				if ($('#allFaultTable .84').text()=="") {
					$('#allFaultTable .84').addClass('d-none');
					$(this).find('td').eq(193).addClass('d-none');
					$(this).find('td').eq(194).addClass('d-none');
					$('#allFaultSumPrcssKg35').addClass('d-none');
					$('#allFaultSumPrcssEa35').addClass('d-none');
				}
				if ($('#allFaultTable .85').text()=="") {
					$('#allFaultTable .85').addClass('d-none');
					$(this).find('td').eq(195).addClass('d-none');
					$(this).find('td').eq(196).addClass('d-none');
					$('#allFaultSumPrcssKg36').addClass('d-none');
					$('#allFaultSumPrcssEa36').addClass('d-none');
				}
				if ($('#allFaultTable .86').text()=="") {
					$('#allFaultTable .86').addClass('d-none');
					$(this).find('td').eq(197).addClass('d-none');
					$(this).find('td').eq(198).addClass('d-none');
					$('#allFaultSumPrcssKg37').addClass('d-none');
					$('#allFaultSumPrcssEa37').addClass('d-none');
				}
				if ($('#allFaultTable .87').text()=="") {
					$('#allFaultTable .87').addClass('d-none');
					$(this).find('td').eq(199).addClass('d-none');
					$(this).find('td').eq(200).addClass('d-none');
					$('#allFaultSumPrcssKg38').addClass('d-none');
					$('#allFaultSumPrcssEa38').addClass('d-none');
				}
				if ($('#allFaultTable .88').text()=="") {
					$('#allFaultTable .88').addClass('d-none');
					$(this).find('td').eq(201).addClass('d-none');
					$(this).find('td').eq(202).addClass('d-none');
					$('#allFaultSumPrcssKg39').addClass('d-none');
					$('#allFaultSumPrcssEa39').addClass('d-none');
				}
				if ($('#allFaultTable .89').text()=="") {
					$('#allFaultTable .89').addClass('d-none');
					$(this).find('td').eq(203).addClass('d-none');
					$(this).find('td').eq(204).addClass('d-none');
					$('#allFaultSumPrcssKg40').addClass('d-none');
					$('#allFaultSumPrcssEa40').addClass('d-none');
				}
			});
			//생산-공정 조정(2) 끝

			//생산-원자재불량 교체(3)
			let allFaultSumMatrlKg1		=	$('#allFaultTable').DataTable().column(205,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa1		=	$('#allFaultTable').DataTable().column(206,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg2		=	$('#allFaultTable').DataTable().column(207,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa2		=	$('#allFaultTable').DataTable().column(208,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg3		=	$('#allFaultTable').DataTable().column(209,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa3		=	$('#allFaultTable').DataTable().column(210,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg4		=	$('#allFaultTable').DataTable().column(211,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa4		=	$('#allFaultTable').DataTable().column(212,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg5		=	$('#allFaultTable').DataTable().column(213,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa5		=	$('#allFaultTable').DataTable().column(214,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg6		=	$('#allFaultTable').DataTable().column(215,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa6		=	$('#allFaultTable').DataTable().column(216,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg7		=	$('#allFaultTable').DataTable().column(217,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa7		=	$('#allFaultTable').DataTable().column(218,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg8		=	$('#allFaultTable').DataTable().column(219,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa8		=	$('#allFaultTable').DataTable().column(220,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg9		=	$('#allFaultTable').DataTable().column(221,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa9		=	$('#allFaultTable').DataTable().column(222,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg10	=	$('#allFaultTable').DataTable().column(223,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa10	=	$('#allFaultTable').DataTable().column(224,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg11	=	$('#allFaultTable').DataTable().column(225,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa11	=	$('#allFaultTable').DataTable().column(226,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg12	=	$('#allFaultTable').DataTable().column(227,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa12	=	$('#allFaultTable').DataTable().column(228,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg13	=	$('#allFaultTable').DataTable().column(229,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa13	=	$('#allFaultTable').DataTable().column(230,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg14	=	$('#allFaultTable').DataTable().column(231,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa14	=	$('#allFaultTable').DataTable().column(232,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg15	=	$('#allFaultTable').DataTable().column(233,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa15	=	$('#allFaultTable').DataTable().column(234,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg16	=	$('#allFaultTable').DataTable().column(235,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa16	=	$('#allFaultTable').DataTable().column(236,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg17	=	$('#allFaultTable').DataTable().column(237,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa17	=	$('#allFaultTable').DataTable().column(238,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg18	=	$('#allFaultTable').DataTable().column(239,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa18	=	$('#allFaultTable').DataTable().column(240,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg19	=	$('#allFaultTable').DataTable().column(241,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa19	=	$('#allFaultTable').DataTable().column(242,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg20	=	$('#allFaultTable').DataTable().column(243,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa20	=	$('#allFaultTable').DataTable().column(244,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg21	=	$('#allFaultTable').DataTable().column(245,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa21	=	$('#allFaultTable').DataTable().column(246,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg22	=	$('#allFaultTable').DataTable().column(247,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa22	=	$('#allFaultTable').DataTable().column(248,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg23	=	$('#allFaultTable').DataTable().column(249,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa23	=	$('#allFaultTable').DataTable().column(250,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg24	=	$('#allFaultTable').DataTable().column(251,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa24	=	$('#allFaultTable').DataTable().column(252,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg25	=	$('#allFaultTable').DataTable().column(253,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa25	=	$('#allFaultTable').DataTable().column(254,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg26	=	$('#allFaultTable').DataTable().column(255,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa26	=	$('#allFaultTable').DataTable().column(256,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg27	=	$('#allFaultTable').DataTable().column(257,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa27	=	$('#allFaultTable').DataTable().column(258,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg28	=	$('#allFaultTable').DataTable().column(259,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa28	=	$('#allFaultTable').DataTable().column(260,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg29	=	$('#allFaultTable').DataTable().column(261,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa29	=	$('#allFaultTable').DataTable().column(262,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg30	=	$('#allFaultTable').DataTable().column(263,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa30	=	$('#allFaultTable').DataTable().column(264,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg31	=	$('#allFaultTable').DataTable().column(265,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa31	=	$('#allFaultTable').DataTable().column(266,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg32	=	$('#allFaultTable').DataTable().column(267,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa32	=	$('#allFaultTable').DataTable().column(268,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg33	=	$('#allFaultTable').DataTable().column(269,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa33	=	$('#allFaultTable').DataTable().column(270,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg34	=	$('#allFaultTable').DataTable().column(271,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa34	=	$('#allFaultTable').DataTable().column(272,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg35	=	$('#allFaultTable').DataTable().column(273,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa35	=	$('#allFaultTable').DataTable().column(274,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg36	=	$('#allFaultTable').DataTable().column(275,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa36	=	$('#allFaultTable').DataTable().column(276,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg37	=	$('#allFaultTable').DataTable().column(277,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa37	=	$('#allFaultTable').DataTable().column(278,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg38	=	$('#allFaultTable').DataTable().column(279,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa38	=	$('#allFaultTable').DataTable().column(280,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg39	=	$('#allFaultTable').DataTable().column(281,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa39	=	$('#allFaultTable').DataTable().column(282,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlKg40	=	$('#allFaultTable').DataTable().column(283,{ page: 'all'} ).data().sum();
			let allFaultSumMatrlEa40	=	$('#allFaultTable').DataTable().column(284,{ page: 'all'} ).data().sum();
			
			$('#allFaultSumMatrlKg1').text(allFaultSumMatrlKg1.toFixed(3));
			$('#allFaultSumMatrlKg2').text(allFaultSumMatrlKg2.toFixed(3));
			$('#allFaultSumMatrlKg3').text(allFaultSumMatrlKg3.toFixed(3));
			$('#allFaultSumMatrlKg4').text(allFaultSumMatrlKg4.toFixed(3));
			$('#allFaultSumMatrlKg5').text(allFaultSumMatrlKg5.toFixed(3));
			$('#allFaultSumMatrlKg6').text(allFaultSumMatrlKg6.toFixed(3));
			$('#allFaultSumMatrlKg7').text(allFaultSumMatrlKg7.toFixed(3));
			$('#allFaultSumMatrlKg8').text(allFaultSumMatrlKg8.toFixed(3));
			$('#allFaultSumMatrlKg9').text(allFaultSumMatrlKg9.toFixed(3));
			$('#allFaultSumMatrlKg10').text(allFaultSumMatrlKg10.toFixed(3));
			$('#allFaultSumMatrlKg11').text(allFaultSumMatrlKg11.toFixed(3));
			$('#allFaultSumMatrlKg12').text(allFaultSumMatrlKg12.toFixed(3));
			$('#allFaultSumMatrlKg13').text(allFaultSumMatrlKg13.toFixed(3));
			$('#allFaultSumMatrlKg14').text(allFaultSumMatrlKg14.toFixed(3));
			$('#allFaultSumMatrlKg15').text(allFaultSumMatrlKg15.toFixed(3));
			$('#allFaultSumMatrlKg16').text(allFaultSumMatrlKg16.toFixed(3));
			$('#allFaultSumMatrlKg17').text(allFaultSumMatrlKg17.toFixed(3));
			$('#allFaultSumMatrlKg18').text(allFaultSumMatrlKg18.toFixed(3));
			$('#allFaultSumMatrlKg19').text(allFaultSumMatrlKg19.toFixed(3));
			$('#allFaultSumMatrlKg20').text(allFaultSumMatrlKg20.toFixed(3));
			$('#allFaultSumMatrlKg21').text(allFaultSumMatrlKg21.toFixed(3));
			$('#allFaultSumMatrlKg22').text(allFaultSumMatrlKg22.toFixed(3));
			$('#allFaultSumMatrlKg23').text(allFaultSumMatrlKg23.toFixed(3));
			$('#allFaultSumMatrlKg24').text(allFaultSumMatrlKg24.toFixed(3));
			$('#allFaultSumMatrlKg25').text(allFaultSumMatrlKg25.toFixed(3));
			$('#allFaultSumMatrlKg26').text(allFaultSumMatrlKg26.toFixed(3));
			$('#allFaultSumMatrlKg27').text(allFaultSumMatrlKg27.toFixed(3));
			$('#allFaultSumMatrlKg28').text(allFaultSumMatrlKg28.toFixed(3));
			$('#allFaultSumMatrlKg29').text(allFaultSumMatrlKg29.toFixed(3));
			$('#allFaultSumMatrlKg30').text(allFaultSumMatrlKg30.toFixed(3));
			$('#allFaultSumMatrlKg31').text(allFaultSumMatrlKg31.toFixed(3));
			$('#allFaultSumMatrlKg32').text(allFaultSumMatrlKg32.toFixed(3));
			$('#allFaultSumMatrlKg33').text(allFaultSumMatrlKg33.toFixed(3));
			$('#allFaultSumMatrlKg34').text(allFaultSumMatrlKg34.toFixed(3));
			$('#allFaultSumMatrlKg35').text(allFaultSumMatrlKg35.toFixed(3));
			$('#allFaultSumMatrlKg36').text(allFaultSumMatrlKg36.toFixed(3));
			$('#allFaultSumMatrlKg37').text(allFaultSumMatrlKg37.toFixed(3));
			$('#allFaultSumMatrlKg38').text(allFaultSumMatrlKg38.toFixed(3));
			$('#allFaultSumMatrlKg39').text(allFaultSumMatrlKg39.toFixed(3));
			$('#allFaultSumMatrlKg40').text(allFaultSumMatrlKg40.toFixed(3));
                
			$('#allFaultSumMatrlEa1').text(addCommas(Math.round(allFaultSumMatrlEa1)));
			$('#allFaultSumMatrlEa2').text(addCommas(Math.round(allFaultSumMatrlEa2)));
			$('#allFaultSumMatrlEa3').text(addCommas(Math.round(allFaultSumMatrlEa3)));
			$('#allFaultSumMatrlEa4').text(addCommas(Math.round(allFaultSumMatrlEa4)));
			$('#allFaultSumMatrlEa5').text(addCommas(Math.round(allFaultSumMatrlEa5)));
			$('#allFaultSumMatrlEa6').text(addCommas(Math.round(allFaultSumMatrlEa6)));
			$('#allFaultSumMatrlEa7').text(addCommas(Math.round(allFaultSumMatrlEa7)));
			$('#allFaultSumMatrlEa8').text(addCommas(Math.round(allFaultSumMatrlEa8)));
			$('#allFaultSumMatrlEa9').text(addCommas(Math.round(allFaultSumMatrlEa9)));
			$('#allFaultSumMatrlEa10').text(addCommas(Math.round(allFaultSumMatrlEa10)));
			$('#allFaultSumMatrlEa11').text(addCommas(Math.round(allFaultSumMatrlEa11)));
			$('#allFaultSumMatrlEa12').text(addCommas(Math.round(allFaultSumMatrlEa12)));
			$('#allFaultSumMatrlEa13').text(addCommas(Math.round(allFaultSumMatrlEa13)));
			$('#allFaultSumMatrlEa14').text(addCommas(Math.round(allFaultSumMatrlEa14)));
			$('#allFaultSumMatrlEa15').text(addCommas(Math.round(allFaultSumMatrlEa15)));
			$('#allFaultSumMatrlEa16').text(addCommas(Math.round(allFaultSumMatrlEa16)));
			$('#allFaultSumMatrlEa17').text(addCommas(Math.round(allFaultSumMatrlEa17)));
			$('#allFaultSumMatrlEa18').text(addCommas(Math.round(allFaultSumMatrlEa18)));
			$('#allFaultSumMatrlEa19').text(addCommas(Math.round(allFaultSumMatrlEa19)));
			$('#allFaultSumMatrlEa20').text(addCommas(Math.round(allFaultSumMatrlEa20)));
			$('#allFaultSumMatrlEa21').text(addCommas(Math.round(allFaultSumMatrlEa21)));
			$('#allFaultSumMatrlEa22').text(addCommas(Math.round(allFaultSumMatrlEa22)));
			$('#allFaultSumMatrlEa23').text(addCommas(Math.round(allFaultSumMatrlEa23)));
			$('#allFaultSumMatrlEa24').text(addCommas(Math.round(allFaultSumMatrlEa24)));
			$('#allFaultSumMatrlEa25').text(addCommas(Math.round(allFaultSumMatrlEa25)));
			$('#allFaultSumMatrlEa26').text(addCommas(Math.round(allFaultSumMatrlEa26)));
			$('#allFaultSumMatrlEa27').text(addCommas(Math.round(allFaultSumMatrlEa27)));
			$('#allFaultSumMatrlEa28').text(addCommas(Math.round(allFaultSumMatrlEa28)));
			$('#allFaultSumMatrlEa29').text(addCommas(Math.round(allFaultSumMatrlKg29)));
			$('#allFaultSumMatrlEa30').text(addCommas(Math.round(allFaultSumMatrlKg30)));
			$('#allFaultSumMatrlEa31').text(addCommas(Math.round(allFaultSumMatrlKg31)));
			$('#allFaultSumMatrlEa32').text(addCommas(Math.round(allFaultSumMatrlKg32)));
			$('#allFaultSumMatrlEa33').text(addCommas(Math.round(allFaultSumMatrlKg33)));
			$('#allFaultSumMatrlEa34').text(addCommas(Math.round(allFaultSumMatrlKg34)));
			$('#allFaultSumMatrlEa35').text(addCommas(Math.round(allFaultSumMatrlKg35)));
			$('#allFaultSumMatrlEa36').text(addCommas(Math.round(allFaultSumMatrlKg36)));
			$('#allFaultSumMatrlEa37').text(addCommas(Math.round(allFaultSumMatrlKg37)));
			$('#allFaultSumMatrlEa38').text(addCommas(Math.round(allFaultSumMatrlKg38)));
			$('#allFaultSumMatrlEa39').text(addCommas(Math.round(allFaultSumMatrlKg39)));
			$('#allFaultSumMatrlEa40').text(addCommas(Math.round(allFaultSumMatrlKg40)));
			
// 			$('#allFaultTable tbody tr td').attr("style","min-width:60px;");
			$.each($('#allFaultTable tbody tr'),function(index,item) {
				if ($('#allFaultTable .100').text()=="") {
					$('#allFaultTable .100').addClass('d-none');
					$(this).find('td').eq(205).addClass('d-none');
					$(this).find('td').eq(206).addClass('d-none');
					$('#allFaultSumMatrlKg1').addClass('d-none');
					$('#allFaultSumMatrlEa1').addClass('d-none');
				}
				if ($('#allFaultTable .101').text()=="") {
					$('#allFaultTable .101').addClass('d-none');
					$(this).find('td').eq(207).addClass('d-none');
					$(this).find('td').eq(208).addClass('d-none');
					$('#allFaultSumMatrlKg2').addClass('d-none');
					$('#allFaultSumMatrlEa2').addClass('d-none');
				 }
				if ($('#allFaultTable .102').text()=="") {
					$('#allFaultTable .102').addClass('d-none');
					$(this).find('td').eq(209).addClass('d-none');
					$(this).find('td').eq(210).addClass('d-none');
					$('#allFaultSumMatrlKg3').addClass('d-none');
					$('#allFaultSumMatrlEa3').addClass('d-none');
				}
				if ($('#allFaultTable .103').text()=="") {
					$('#allFaultTable .103').addClass('d-none');
					$(this).find('td').eq(211).addClass('d-none');
					$(this).find('td').eq(212).addClass('d-none');
					$('#allFaultSumMatrlKg4').addClass('d-none');
					$('#allFaultSumMatrlEa4').addClass('d-none');
				}
				if ($('#allFaultTable .104').text()=="") {
					$('#allFaultTable .104').addClass('d-none');
					$(this).find('td').eq(213).addClass('d-none');
					$(this).find('td').eq(214).addClass('d-none');
					$('#allFaultSumMatrlKg5').addClass('d-none');
					$('#allFaultSumMatrlEa5').addClass('d-none');
				}
				if ($('#allFaultTable .105').text()=="") {
					$('#allFaultTable .105').addClass('d-none');
					$(this).find('td').eq(215).addClass('d-none');
					$(this).find('td').eq(216).addClass('d-none');
					$('#allFaultSumMatrlKg6').addClass('d-none');
					$('#allFaultSumMatrlEa6').addClass('d-none');
				}
				if ($('#allFaultTable .106').text()=="") {
					$('#allFaultTable .106').addClass('d-none');
					$(this).find('td').eq(217).addClass('d-none');
					$(this).find('td').eq(218).addClass('d-none');
					$('#allFaultSumMatrlKg7').addClass('d-none');
					$('#allFaultSumMatrlEa7').addClass('d-none');
				}
				if ($('#allFaultTable .107').text()=="") {
					$('#allFaultTable .107').addClass('d-none');
					$(this).find('td').eq(219).addClass('d-none');
					$(this).find('td').eq(220).addClass('d-none');
					$('#allFaultSumMatrlKg8').addClass('d-none');
					$('#allFaultSumMatrlEa8').addClass('d-none');
				}
				if ($('#allFaultTable .108').text()=="") {
					$('#allFaultTable .108').addClass('d-none');
					$(this).find('td').eq(221).addClass('d-none');
					$(this).find('td').eq(222).addClass('d-none');
					$('#allFaultSumMatrlKg9').addClass('d-none');
					$('#allFaultSumMatrlEa9').addClass('d-none');
				}
				if ($('#allFaultTable .109').text()=="") {
					$('#allFaultTable .109').addClass('d-none');
					$(this).find('td').eq(223).addClass('d-none');
					$(this).find('td').eq(224).addClass('d-none');
					$('#allFaultSumMatrlKg10').addClass('d-none');
					$('#allFaultSumMatrlEa10').addClass('d-none');
				}
				if ($('#allFaultTable .110').text()=="") {
					$('#allFaultTable .110').addClass('d-none');
					$(this).find('td').eq(225).addClass('d-none');
					$(this).find('td').eq(226).addClass('d-none');
					$('#allFaultSumMatrlKg11').addClass('d-none');
					$('#allFaultSumMatrlEa11').addClass('d-none');
				}
				if ($('#allFaultTable .111').text()=="") {
					$('#allFaultTable .111').addClass('d-none')
					$(this).find('td').eq(227).addClass('d-none');
					$(this).find('td').eq(228).addClass('d-none');
					$('#allFaultSumMatrlKg12').addClass('d-none');
					$('#allFaultSumMatrlEa12').addClass('d-none');
				}
				if ($('#allFaultTable .112').text()=="") {
					$('#allFaultTable .112').addClass('d-none');
					$(this).find('td').eq(229).addClass('d-none');
					$(this).find('td').eq(230).addClass('d-none');
					$('#allFaultSumMatrlKg13').addClass('d-none');
					$('#allFaultSumMatrlEa13').addClass('d-none');
				}
				if ($('#allFaultTable .113').text()=="") {
					$('#allFaultTable .113').addClass('d-none')
					$(this).find('td').eq(231).addClass('d-none');
					$(this).find('td').eq(232).addClass('d-none');
					$('#allFaultSumMatrlKg14').addClass('d-none');
					$('#allFaultSumMatrlEa14').addClass('d-none');
				}
				if ($('#allFaultTable .114').text()=="") {
					$('#allFaultTable .114').addClass('d-none')
					$(this).find('td').eq(233).addClass('d-none');
					$(this).find('td').eq(234).addClass('d-none');
					$('#allFaultSumMatrlKg15').addClass('d-none');
					$('#allFaultSumMatrlEa15').addClass('d-none');
				}
				if ($('#allFaultTable .115').text()=="") {
					$('#allFaultTable .115').addClass('d-none')
					$(this).find('td').eq(235).addClass('d-none');
					$(this).find('td').eq(236).addClass('d-none');
					$('#allFaultSumMatrlKg16').addClass('d-none');
					$('#allFaultSumMatrlEa16').addClass('d-none');
				}
				if ($('#allFaultTable .116').text()=="") {
					$('#allFaultTable .116').addClass('d-none');
					$(this).find('td').eq(237).addClass('d-none');
					$(this).find('td').eq(238).addClass('d-none');
					$('#allFaultSumMatrlKg17').addClass('d-none');
					$('#allFaultSumMatrlEa17').addClass('d-none');
				}
				if ($('#allFaultTable .117').text()=="") {
					$('#allFaultTable .117').addClass('d-none');
					$(this).find('td').eq(239).addClass('d-none');
					$(this).find('td').eq(240).addClass('d-none');
					$('#allFaultSumMatrlKg18').addClass('d-none');
					$('#allFaultSumMatrlEa18').addClass('d-none');
				}
				if ($('#allFaultTable .118').text()=="") {
					$('#allFaultTable .118').addClass('d-none');
					$(this).find('td').eq(241).addClass('d-none');
					$(this).find('td').eq(242).addClass('d-none');
					$('#allFaultSumMatrlKg19').addClass('d-none');
					$('#allFaultSumMatrlEa19').addClass('d-none');
				}
				if ($('#allFaultTable .119').text()=="") {
					$('#allFaultTable .119').addClass('d-none');
					$(this).find('td').eq(243).addClass('d-none');
					$(this).find('td').eq(244).addClass('d-none');
					$('#allFaultSumMatrlKg20').addClass('d-none');
					$('#allFaultSumMatrlEa20').addClass('d-none');
				}
				if ($('#allFaultTable .120').text()=="") {
					$('#allFaultTable .120').addClass('d-none');
					$(this).find('td').eq(245).addClass('d-none');
					$(this).find('td').eq(246).addClass('d-none');
					$('#allFaultSumMatrlKg21').addClass('d-none');
					$('#allFaultSumMatrlEa21').addClass('d-none');
				}
				if ($('#allFaultTable .121').text()=="") {
					$('#allFaultTable .121').addClass('d-none');
					$(this).find('td').eq(247).addClass('d-none');
					$(this).find('td').eq(248).addClass('d-none');
					$('#allFaultSumMatrlKg22').addClass('d-none');
					$('#allFaultSumMatrlEa22').addClass('d-none');
				}
				if ($('#allFaultTable .122').text()=="") {
					$('#allFaultTable .122').addClass('d-none');
					$(this).find('td').eq(249).addClass('d-none');
					$(this).find('td').eq(250).addClass('d-none');
					$('#allFaultSumMatrlKg23').addClass('d-none');
					$('#allFaultSumMatrlEa23').addClass('d-none');
				}
				if ($('#allFaultTable .123').text()=="") {
					$('#allFaultTable .123').addClass('d-none');
					$(this).find('td').eq(251).addClass('d-none');
					$(this).find('td').eq(252).addClass('d-none');
					$('#allFaultSumMatrlKg24').addClass('d-none');
					$('#allFaultSumMatrlEa24').addClass('d-none');
				}
				if ($('#allFaultTable .124').text()=="") {
					$('#allFaultTable .124').addClass('d-none');
					$(this).find('td').eq(253).addClass('d-none');
					$(this).find('td').eq(254).addClass('d-none');
					$('#allFaultSumMatrlKg25').addClass('d-none');
					$('#allFaultSumMatrlEa25').addClass('d-none');
				}
				if ($('#allFaultTable .125').text()=="") {
					$('#allFaultTable .125').addClass('d-none');
					$(this).find('td').eq(255).addClass('d-none');
					$(this).find('td').eq(256).addClass('d-none');
					$('#allFaultSumMatrlKg26').addClass('d-none');
					$('#allFaultSumMatrlEa26').addClass('d-none');
				}
				if ($('#allFaultTable .126').text()=="") {
					$('#allFaultTable .126').addClass('d-none');
					$(this).find('td').eq(257).addClass('d-none');
					$(this).find('td').eq(258).addClass('d-none');
					$('#allFaultSumMatrlKg27').addClass('d-none');
					$('#allFaultSumMatrlEa27').addClass('d-none');
				}
				if ($('#allFaultTable .127').text()=="") {
					$('#allFaultTable .127').addClass('d-none');
					$(this).find('td').eq(259).addClass('d-none');
					$(this).find('td').eq(260).addClass('d-none');
					$('#allFaultSumMatrlKg28').addClass('d-none');
					$('#allFaultSumMatrlEa28').addClass('d-none');
				}
				if ($('#allFaultTable .128').text()=="") {
					$('#allFaultTable .128').addClass('d-none');
					$(this).find('td').eq(261).addClass('d-none');
					$(this).find('td').eq(262).addClass('d-none');
					$('#allFaultSumMatrlKg29').addClass('d-none');
					$('#allFaultSumMatrlEa29').addClass('d-none');
				}
				if ($('#allFaultTable .129').text()=="") {
					$('#allFaultTable .129').addClass('d-none');
					$(this).find('td').eq(263).addClass('d-none');
					$(this).find('td').eq(264).addClass('d-none');
					$('#allFaultSumMatrlKg30').addClass('d-none');
					$('#allFaultSumMatrlEa30').addClass('d-none');
				}
				if ($('#allFaultTable .130').text()=="") {
					$('#allFaultTable .130').addClass('d-none');
					$(this).find('td').eq(265).addClass('d-none');
					$(this).find('td').eq(266).addClass('d-none');
					$('#allFaultSumMatrlKg31').addClass('d-none');
					$('#allFaultSumMatrlEa31').addClass('d-none');
				}
				if ($('#allFaultTable .131').text()=="") {
					$('#allFaultTable .131').addClass('d-none');
					$(this).find('td').eq(267).addClass('d-none');
					$(this).find('td').eq(268).addClass('d-none');
					$('#allFaultSumMatrlKg32').addClass('d-none');
					$('#allFaultSumMatrlEa32').addClass('d-none');
				}
				if ($('#allFaultTable .132').text()=="") {
					$('#allFaultTable .132').addClass('d-none');
					$(this).find('td').eq(269).addClass('d-none');
					$(this).find('td').eq(270).addClass('d-none');
					$('#allFaultSumMatrlKg33').addClass('d-none');
					$('#allFaultSumMatrlEa33').addClass('d-none');
				}
				if ($('#allFaultTable .133').text()=="") {
					$('#allFaultTable .133').addClass('d-none');
					$(this).find('td').eq(271).addClass('d-none');
					$(this).find('td').eq(272).addClass('d-none');
					$('#allFaultSumMatrlKg34').addClass('d-none');
					$('#allFaultSumMatrlEa34').addClass('d-none');
				}
				if ($('#allFaultTable .134').text()=="") {
					$('#allFaultTable .134').addClass('d-none');
					$(this).find('td').eq(273).addClass('d-none');
					$(this).find('td').eq(274).addClass('d-none');
					$('#allFaultSumMatrlKg35').addClass('d-none');
					$('#allFaultSumMatrlEa35').addClass('d-none');
				}
				if ($('#allFaultTable .135').text()=="") {
					$('#allFaultTable .135').addClass('d-none');
					$(this).find('td').eq(275).addClass('d-none');
					$(this).find('td').eq(276).addClass('d-none');
					$('#allFaultSumMatrlKg36').addClass('d-none');
					$('#allFaultSumMatrlEa36').addClass('d-none');
				}
				if ($('#allFaultTable .136').text()=="") {
					$('#allFaultTable .136').addClass('d-none');
					$(this).find('td').eq(277).addClass('d-none');
					$(this).find('td').eq(278).addClass('d-none');
					$('#allFaultSumMatrlKg37').addClass('d-none');
					$('#allFaultSumMatrlEa37').addClass('d-none');
				}
				if ($('#allFaultTable .137').text()=="") {
					$('#allFaultTable .137').addClass('d-none');
					$(this).find('td').eq(279).addClass('d-none');
					$(this).find('td').eq(280).addClass('d-none');
					$('#allFaultSumMatrlKg38').addClass('d-none');
					$('#allFaultSumMatrlEa38').addClass('d-none');
				}
				if ($('#allFaultTable .138').text()=="") {
					$('#allFaultTable .138').addClass('d-none');
					$(this).find('td').eq(281).addClass('d-none');
					$(this).find('td').eq(282).addClass('d-none');
					$('#allFaultSumMatrlKg39').addClass('d-none');
					$('#allFaultSumMatrlEa39').addClass('d-none');
				}
				if ($('#allFaultTable .139').text()=="") {
					$('#allFaultTable .139').addClass('d-none');
					$(this).find('td').eq(283).addClass('d-none');
					$(this).find('td').eq(284).addClass('d-none');
					$('#allFaultSumMatrlKg40').addClass('d-none');
					$('#allFaultSumMatrlEa40').addClass('d-none');
				}
			});
			//생산-원자재불량 교체(3) 끝

			//생산-설비 부품 교체(4)
			let allFaultSumTroubleCount1	=	$('#allFaultTable').DataTable().column(285,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg1		=	$('#allFaultTable').DataTable().column(286,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa1		=	$('#allFaultTable').DataTable().column(287,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount2	=	$('#allFaultTable').DataTable().column(289,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg2		=	$('#allFaultTable').DataTable().column(290,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa2		=	$('#allFaultTable').DataTable().column(291,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount3	=	$('#allFaultTable').DataTable().column(293,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg3		=	$('#allFaultTable').DataTable().column(294,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa3		=	$('#allFaultTable').DataTable().column(295,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount4	=	$('#allFaultTable').DataTable().column(297,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg4		=	$('#allFaultTable').DataTable().column(298,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa4		=	$('#allFaultTable').DataTable().column(299,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount5	=	$('#allFaultTable').DataTable().column(301,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg5		=	$('#allFaultTable').DataTable().column(302,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa5		=	$('#allFaultTable').DataTable().column(303,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount6	=	$('#allFaultTable').DataTable().column(305,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg6		=	$('#allFaultTable').DataTable().column(306,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa6		=	$('#allFaultTable').DataTable().column(307,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount7	=	$('#allFaultTable').DataTable().column(309,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg7		=	$('#allFaultTable').DataTable().column(310,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa7		=	$('#allFaultTable').DataTable().column(311,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount8	=	$('#allFaultTable').DataTable().column(313,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg8		=	$('#allFaultTable').DataTable().column(314,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa8		=	$('#allFaultTable').DataTable().column(315,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount9	=	$('#allFaultTable').DataTable().column(317,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg9		=	$('#allFaultTable').DataTable().column(318,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa9		=	$('#allFaultTable').DataTable().column(319,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount10	=	$('#allFaultTable').DataTable().column(321,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg10		=	$('#allFaultTable').DataTable().column(322,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa10		=	$('#allFaultTable').DataTable().column(323,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount11	=	$('#allFaultTable').DataTable().column(325,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg11		=	$('#allFaultTable').DataTable().column(326,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa11		=	$('#allFaultTable').DataTable().column(327,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount12	=	$('#allFaultTable').DataTable().column(329,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg12		=	$('#allFaultTable').DataTable().column(330,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa12		=	$('#allFaultTable').DataTable().column(331,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount13	=	$('#allFaultTable').DataTable().column(333,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg13		=	$('#allFaultTable').DataTable().column(334,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa13		=	$('#allFaultTable').DataTable().column(335,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount14	=	$('#allFaultTable').DataTable().column(337,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg14		=	$('#allFaultTable').DataTable().column(338,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa14		=	$('#allFaultTable').DataTable().column(339,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount15	=	$('#allFaultTable').DataTable().column(341,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg15		=	$('#allFaultTable').DataTable().column(342,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa15		=	$('#allFaultTable').DataTable().column(343,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount16	=	$('#allFaultTable').DataTable().column(345,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg16		=	$('#allFaultTable').DataTable().column(346,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa16		=	$('#allFaultTable').DataTable().column(347,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount17	=	$('#allFaultTable').DataTable().column(349,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg17		=	$('#allFaultTable').DataTable().column(350,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa17		=	$('#allFaultTable').DataTable().column(351,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount18	=	$('#allFaultTable').DataTable().column(353,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg18		=	$('#allFaultTable').DataTable().column(354,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa18		=	$('#allFaultTable').DataTable().column(355,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount19	=	$('#allFaultTable').DataTable().column(357,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg19		=	$('#allFaultTable').DataTable().column(358,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa19		=	$('#allFaultTable').DataTable().column(359,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleCount20	=	$('#allFaultTable').DataTable().column(361,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleKg20		=	$('#allFaultTable').DataTable().column(362,{ page: 'all'} ).data().sum();
			let allFaultSumTroubleEa20		=	$('#allFaultTable').DataTable().column(363,{ page: 'all'} ).data().sum();
			                                                                   
			$('#allFaultSumTroubleKg1').text(allFaultSumTroubleKg1.toFixed(3));
			$('#allFaultSumTroubleKg2').text(allFaultSumTroubleKg2.toFixed(3));
			$('#allFaultSumTroubleKg3').text(allFaultSumTroubleKg3.toFixed(3));
			$('#allFaultSumTroubleKg4').text(allFaultSumTroubleKg4.toFixed(3));
			$('#allFaultSumTroubleKg5').text(allFaultSumTroubleKg5.toFixed(3));
			$('#allFaultSumTroubleKg6').text(allFaultSumTroubleKg6.toFixed(3));
			$('#allFaultSumTroubleKg7').text(allFaultSumTroubleKg7.toFixed(3));
			$('#allFaultSumTroubleKg8').text(allFaultSumTroubleKg8.toFixed(3));
			$('#allFaultSumTroubleKg9').text(allFaultSumTroubleKg9.toFixed(3));
			$('#allFaultSumTroubleKg10').text(allFaultSumTroubleKg10.toFixed(3));
			$('#allFaultSumTroubleKg11').text(allFaultSumTroubleKg11.toFixed(3));
			$('#allFaultSumTroubleKg12').text(allFaultSumTroubleKg12.toFixed(3));
			$('#allFaultSumTroubleKg13').text(allFaultSumTroubleKg13.toFixed(3));
			$('#allFaultSumTroubleKg14').text(allFaultSumTroubleKg14.toFixed(3));
			$('#allFaultSumTroubleKg15').text(allFaultSumTroubleKg15.toFixed(3));
			$('#allFaultSumTroubleKg16').text(allFaultSumTroubleKg16.toFixed(3));
			$('#allFaultSumTroubleKg17').text(allFaultSumTroubleKg17.toFixed(3));
			$('#allFaultSumTroubleKg18').text(allFaultSumTroubleKg18.toFixed(3));
			$('#allFaultSumTroubleKg19').text(allFaultSumTroubleKg19.toFixed(3));
			$('#allFaultSumTroubleKg20').text(allFaultSumTroubleKg20.toFixed(3));
                
			$('#allFaultSumTroubleEa1').text(addCommas(Math.round(allFaultSumTroubleEa1)));
			$('#allFaultSumTroubleEa2').text(addCommas(Math.round(allFaultSumTroubleEa2)));
			$('#allFaultSumTroubleEa3').text(addCommas(Math.round(allFaultSumTroubleEa3)));
			$('#allFaultSumTroubleEa4').text(addCommas(Math.round(allFaultSumTroubleEa4)));
			$('#allFaultSumTroubleEa5').text(addCommas(Math.round(allFaultSumTroubleEa5)));
			$('#allFaultSumTroubleEa6').text(addCommas(Math.round(allFaultSumTroubleEa6)));
			$('#allFaultSumTroubleEa7').text(addCommas(Math.round(allFaultSumTroubleEa7)));
			$('#allFaultSumTroubleEa8').text(addCommas(Math.round(allFaultSumTroubleEa8)));
			$('#allFaultSumTroubleEa9').text(addCommas(Math.round(allFaultSumTroubleEa9)));
			$('#allFaultSumTroubleEa10').text(addCommas(Math.round(allFaultSumTroubleEa10)));
			$('#allFaultSumTroubleEa11').text(addCommas(Math.round(allFaultSumTroubleEa11)));
			$('#allFaultSumTroubleEa12').text(addCommas(Math.round(allFaultSumTroubleEa12)));
			$('#allFaultSumTroubleEa13').text(addCommas(Math.round(allFaultSumTroubleEa13)));
			$('#allFaultSumTroubleEa14').text(addCommas(Math.round(allFaultSumTroubleEa14)));
			$('#allFaultSumTroubleEa15').text(addCommas(Math.round(allFaultSumTroubleEa15)));
			$('#allFaultSumTroubleEa16').text(addCommas(Math.round(allFaultSumTroubleEa16)));
			$('#allFaultSumTroubleEa17').text(addCommas(Math.round(allFaultSumTroubleEa17)));
			$('#allFaultSumTroubleEa18').text(addCommas(Math.round(allFaultSumTroubleEa18)));
			$('#allFaultSumTroubleEa19').text(addCommas(Math.round(allFaultSumTroubleEa19)));
			$('#allFaultSumTroubleEa20').text(addCommas(Math.round(allFaultSumTroubleEa20)));
			    
			$('#allFaultSumTroubleCount1').text(allFaultSumTroubleCount1);
			$('#allFaultSumTroubleCount2').text(allFaultSumTroubleCount2);
			$('#allFaultSumTroubleCount3').text(allFaultSumTroubleCount3);
			$('#allFaultSumTroubleCount4').text(allFaultSumTroubleCount4);
			$('#allFaultSumTroubleCount5').text(allFaultSumTroubleCount5);
			$('#allFaultSumTroubleCount6').text(allFaultSumTroubleCount6);
			$('#allFaultSumTroubleCount7').text(allFaultSumTroubleCount7);
			$('#allFaultSumTroubleCount8').text(allFaultSumTroubleCount8);
			$('#allFaultSumTroubleCount9').text(allFaultSumTroubleCount9);
			$('#allFaultSumTroubleCount10').text(allFaultSumTroubleCount10);
			$('#allFaultSumTroubleCount11').text(allFaultSumTroubleCount11);
			$('#allFaultSumTroubleCount12').text(allFaultSumTroubleCount12);
			$('#allFaultSumTroubleCount13').text(allFaultSumTroubleCount13);
			$('#allFaultSumTroubleCount14').text(allFaultSumTroubleCount14);
			$('#allFaultSumTroubleCount15').text(allFaultSumTroubleCount15);
			$('#allFaultSumTroubleCount16').text(allFaultSumTroubleCount16);
			$('#allFaultSumTroubleCount17').text(allFaultSumTroubleCount17);
			$('#allFaultSumTroubleCount18').text(allFaultSumTroubleCount18);
			$('#allFaultSumTroubleCount19').text(allFaultSumTroubleCount19);
			$('#allFaultSumTroubleCount20').text(allFaultSumTroubleCount20);
			
// 			$('#allFaultTable tbody tr td').attr("style","min-width:60px;");

// 			$('#allFaultTable tbody tr td').attr("style","min-width:60px; white-space: pre-wrap;");

		 	$.each($('#allFaultTable tbody tr'),function(index,item) {
				if ($('#allFaultTable .150').text()=="") {
					$('#allFaultTable .150').addClass('d-none');
					$(this).find('td').eq(285).addClass('d-none');
					$(this).find('td').eq(286).addClass('d-none');
					$(this).find('td').eq(287).addClass('d-none');
					$(this).find('td').eq(288).addClass('d-none');
					$('#allFaultSumTroubleCount1').addClass('d-none');
					$('#allFaultSumTroubleKg1').addClass('d-none');
					$('#allFaultSumTroubleEa1').addClass('d-none');
					$('#allFaultSumTroubleContent1').addClass('d-none');
				}						
				if ($('#allFaultTable .151').text()=="") {
					$('#allFaultTable .151').addClass('d-none');
					$(this).find('td').eq(289).addClass('d-none');
					$(this).find('td').eq(290).addClass('d-none');
					$(this).find('td').eq(291).addClass('d-none');
					$(this).find('td').eq(292).addClass('d-none');
					$('#allFaultSumTroubleCount2').addClass('d-none');
					$('#allFaultSumTroubleKg2').addClass('d-none');
					$('#allFaultSumTroubleEa2').addClass('d-none');
					$('#allFaultSumTroubleContent2').addClass('d-none');
				}
				if ($('#allFaultTable .152').text()=="") {
					$('#allFaultTable .152').addClass('d-none');
					$(this).find('td').eq(293).addClass('d-none');
					$(this).find('td').eq(294).addClass('d-none');
					$(this).find('td').eq(295).addClass('d-none');
					$(this).find('td').eq(296).addClass('d-none');
					$('#allFaultSumTroubleCount3').addClass('d-none');
					$('#allFaultSumTroubleKg3').addClass('d-none');
					$('#allFaultSumTroubleEa3').addClass('d-none');
					$('#allFaultSumTroubleContent3').addClass('d-none');
				}
				if ($('#allFaultTable .153').text()=="") {
					$('#allFaultTable .153').addClass('d-none');
					$(this).find('td').eq(297).addClass('d-none');
					$(this).find('td').eq(298).addClass('d-none');
					$(this).find('td').eq(299).addClass('d-none');
					$(this).find('td').eq(300).addClass('d-none');
					$('#allFaultSumTroubleCount4').addClass('d-none');
					$('#allFaultSumTroubleKg4').addClass('d-none');
					$('#allFaultSumTroubleEa4').addClass('d-none');
					$('#allFaultSumTroubleContent4').addClass('d-none');
				}
				if ($('#allFaultTable .154').text()=="") {
					$('#allFaultTable .154').addClass('d-none');
					$(this).find('td').eq(301).addClass('d-none');
					$(this).find('td').eq(302).addClass('d-none');
					$(this).find('td').eq(303).addClass('d-none');
					$(this).find('td').eq(304).addClass('d-none');
					$('#allFaultSumTroubleCount5').addClass('d-none');
					$('#allFaultSumTroubleKg5').addClass('d-none');
					$('#allFaultSumTroubleEa5').addClass('d-none');
					$('#allFaultSumTroubleContent5').addClass('d-none');
				}
				if ($('#allFaultTable .155').text()=="") {
					$('#allFaultTable .155').addClass('d-none');
					$(this).find('td').eq(305).addClass('d-none');
					$(this).find('td').eq(306).addClass('d-none');
					$(this).find('td').eq(307).addClass('d-none');
					$(this).find('td').eq(308).addClass('d-none');
					$('#allFaultSumTroubleCount6').addClass('d-none');
					$('#allFaultSumTroubleKg6').addClass('d-none');
					$('#allFaultSumTroubleEa6').addClass('d-none');
					$('#allFaultSumTroubleContent6').addClass('d-none');
				}
				if ($('#allFaultTable .156').text()=="") {
					$('#allFaultTable .156').addClass('d-none');
					$(this).find('td').eq(309).addClass('d-none');
					$(this).find('td').eq(310).addClass('d-none');
					$(this).find('td').eq(311).addClass('d-none');
					$(this).find('td').eq(312).addClass('d-none');
					$('#allFaultSumTroubleCount7').addClass('d-none');
					$('#allFaultSumTroubleKg7').addClass('d-none');
					$('#allFaultSumTroubleEa7').addClass('d-none');
					$('#allFaultSumTroubleContent7').addClass('d-none');
				}
				if ($('#allFaultTable .157').text()=="") {
					$('#allFaultTable .157').addClass('d-none');
					$(this).find('td').eq(313).addClass('d-none');
					$(this).find('td').eq(314).addClass('d-none');
					$(this).find('td').eq(315).addClass('d-none');
					$(this).find('td').eq(316).addClass('d-none');
					$('#allFaultSumTroubleCount8').addClass('d-none');
					$('#allFaultSumTroubleKg8').addClass('d-none');
					$('#allFaultSumTroubleEa8').addClass('d-none');
					$('#allFaultSumTroubleContent8').addClass('d-none');
				}
				if ($('#allFaultTable .158').text()=="") {
					$('#allFaultTable .158').addClass('d-none');
					$(this).find('td').eq(317).addClass('d-none');
					$(this).find('td').eq(318).addClass('d-none');
					$(this).find('td').eq(319).addClass('d-none');
					$(this).find('td').eq(320).addClass('d-none');
					$('#allFaultSumTroubleCount9').addClass('d-none');
					$('#allFaultSumTroubleKg9').addClass('d-none');
					$('#allFaultSumTroubleEa9').addClass('d-none');
					$('#allFaultSumTroubleContent9').addClass('d-none');
				}
				if ($('#allFaultTable .159').text()=="") {
					$('#allFaultTable .159').addClass('d-none');
					$(this).find('td').eq(321).addClass('d-none');
					$(this).find('td').eq(322).addClass('d-none');
					$(this).find('td').eq(323).addClass('d-none');
					$(this).find('td').eq(324).addClass('d-none');
					$('#allFaultSumTroubleCount10').addClass('d-none');
					$('#allFaultSumTroubleKg10').addClass('d-none');
					$('#allFaultSumTroubleEa10').addClass('d-none');
					$('#allFaultSumTroubleContent10').addClass('d-none');
				}
				if ($('#allFaultTable .160').text()=="") {
					$('#allFaultTable .160').addClass('d-none');	
					$(this).find('td').eq(325).addClass('d-none');
					$(this).find('td').eq(326).addClass('d-none');
					$(this).find('td').eq(327).addClass('d-none');
					$(this).find('td').eq(328).addClass('d-none');
					$('#allFaultSumTroubleCount11').addClass('d-none');
					$('#allFaultSumTroubleKg11').addClass('d-none');
					$('#allFaultSumTroubleEa11').addClass('d-none');
					$('#allFaultSumTroubleContent11').addClass('d-none');
				}
				if ($('#allFaultTable .161').text()=="") {
					$('#allFaultTable .161').addClass('d-none');	
					$(this).find('td').eq(329).addClass('d-none');
					$(this).find('td').eq(330).addClass('d-none');	
					$(this).find('td').eq(331).addClass('d-none');
					$(this).find('td').eq(332).addClass('d-none');
					$('#allFaultSumTroubleCount12').addClass('d-none');
					$('#allFaultSumTroubleKg12').addClass('d-none');
					$('#allFaultSumTroubleEa12').addClass('d-none');
					$('#allFaultSumTroubleContent12').addClass('d-none');
				}
				if ($('#allFaultTable .162').text()=="") {
					$('#allFaultTable .162').addClass('d-none');	
					$(this).find('td').eq(333).addClass('d-none');
					$(this).find('td').eq(334).addClass('d-none');	
					$(this).find('td').eq(335).addClass('d-none');
					$(this).find('td').eq(336).addClass('d-none');
					$('#allFaultSumTroubleCount13').addClass('d-none');
					$('#allFaultSumTroubleKg13').addClass('d-none');
					$('#allFaultSumTroubleEa13').addClass('d-none');
					$('#allFaultSumTroubleContent13').addClass('d-none');
				}
				if ($('#allFaultTable .163').text()=="") {
					$('#allFaultTable .163').addClass('d-none');	
					$(this).find('td').eq(337).addClass('d-none');
					$(this).find('td').eq(338).addClass('d-none');	
					$(this).find('td').eq(339).addClass('d-none');
					$(this).find('td').eq(340).addClass('d-none');
					$('#allFaultSumTroubleCount14').addClass('d-none');
					$('#allFaultSumTroubleKg14').addClass('d-none');
					$('#allFaultSumTroubleEa14').addClass('d-none');
					$('#allFaultSumTroubleContent14').addClass('d-none');
				}
				if ($('#allFaultTable .164').text()=="") {
					$('#allFaultTable .164').addClass('d-none');	
					$(this).find('td').eq(341).addClass('d-none');
					$(this).find('td').eq(342).addClass('d-none');
					$(this).find('td').eq(343).addClass('d-none');
					$(this).find('td').eq(344).addClass('d-none');
					$('#allFaultSumTroubleCount15').addClass('d-none');
					$('#allFaultSumTroubleKg15').addClass('d-none');
					$('#allFaultSumTroubleEa15').addClass('d-none');
					$('#allFaultSumTroubleContent15').addClass('d-none');
				}
				if ($('#allFaultTable .165').text()=="") {
					$('#allFaultTable .165').addClass('d-none');
					$(this).find('td').eq(345).addClass('d-none');
					$(this).find('td').eq(346).addClass('d-none');	
					$(this).find('td').eq(347).addClass('d-none');
					$(this).find('td').eq(348).addClass('d-none');
					$('#allFaultSumTroubleCount16').addClass('d-none');
					$('#allFaultSumTroubleKg16').addClass('d-none');
					$('#allFaultSumTroubleEa16').addClass('d-none');
					$('#allFaultSumTroubleContent16').addClass('d-none');
				}
				if ($('#allFaultTable .166').text()=="") {
					$('#allFaultTable .166').addClass('d-none');
					$(this).find('td').eq(349).addClass('d-none');
					$(this).find('td').eq(350).addClass('d-none');
					$(this).find('td').eq(351).addClass('d-none');
					$(this).find('td').eq(352).addClass('d-none');
					$('#allFaultSumTroubleCount17').addClass('d-none');
					$('#allFaultSumTroubleKg17').addClass('d-none');
					$('#allFaultSumTroubleEa17').addClass('d-none');
					$('#allFaultSumTroubleContent17').addClass('d-none');
				}
				if ($('#allFaultTable .167').text()=="") {
					$('#allFaultTable .167').addClass('d-none');
					$(this).find('td').eq(353).addClass('d-none');
					$(this).find('td').eq(354).addClass('d-none');
					$(this).find('td').eq(355).addClass('d-none');
					$(this).find('td').eq(356).addClass('d-none');
					$('#allFaultSumTroubleCount18').addClass('d-none');
					$('#allFaultSumTroubleKg18').addClass('d-none');
					$('#allFaultSumTroubleEa18').addClass('d-none');
					$('#allFaultSumTroubleContent18').addClass('d-none');
				}
				if ($('#allFaultTable .168').text()=="") {
					$('#allFaultTable .168').addClass('d-none');
					$(this).find('td').eq(357).addClass('d-none');
					$(this).find('td').eq(358).addClass('d-none');
					$(this).find('td').eq(359).addClass('d-none');
					$(this).find('td').eq(360).addClass('d-none');
					$('#allFaultSumTroubleCount19').addClass('d-none');
					$('#allFaultSumTroubleKg19').addClass('d-none');
					$('#allFaultSumTroubleEa19').addClass('d-none');
					$('#allFaultSumTroubleContent19').addClass('d-none');
				}
				if ($('#allFaultTable .169').text()=="") {
					$('#allFaultTable .169').addClass('d-none');
					$(this).find('td').eq(361).addClass('d-none');
					$(this).find('td').eq(362).addClass('d-none');
					$(this).find('td').eq(363).addClass('d-none');
					$(this).find('td').eq(364).addClass('d-none');
					$('#allFaultSumTroubleCount20').addClass('d-none');
					$('#allFaultSumTroubleKg20').addClass('d-none');
					$('#allFaultSumTroubleEa20').addClass('d-none');
					$('#allFaultSumTroubleContent20').addClass('d-none');
					
				}
			});
			//생산-설비 부품 교체(4)끝
		 	$('#my-spinner').hide();
		}
	});
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	allFaultTable.on('draw.dt', function(){
		$('#btnFakeExcel').attr('disabled', false);
	});
	
	let rowSudel = new Array();
	
	$('#allFaultTable_length').html('');
	$('#allFaultTable_paginate').addClass("float-left");

	$('#allFaultTable_filter').eq(0).find('input[type=search]').attr('id', 'pageSerch1');
	$("#pageSerch1").insertAfter("#searchLabel");
	$('#allFaultTable_filter').eq(0).find('label').remove();

	$('#allFaultTable_wrapper').find('.buttons-excel').attr('id','btnRealExcel');
	$('#btnRealExcel').attr('style', 'display: none;');


	//가짜 엑셀 버튼 클릭 시
	$('#btnFakeExcel').on('click', function(){
// 		console.log("excelButton Click Check");
		allFaultTable.buttons(1)[0].inst.c.buttons[1].exportOptions.columns = '';	//c 초기화
		$('#my-spinner').show();
		notHiddenArray = new Array();
		
		for( var i=0; i<$('#allFaultTable tbody tr').eq(0).find('td').length; i++){
    	    if(!$('#allFaultTable tbody tr').eq(0).find('td').eq(i).hasClass('d-none')){
    	        notHiddenArray.push(i);
    	    }
    	}

		//c, s 값 columns를  notHiddenArray에 있는 배열로 교체
		allFaultTable.buttons(1)[0].inst.c.buttons[1].exportOptions.columns = notHiddenArray;
// 		allFaultTable.buttons(1)[0].inst.s.buttons[1].conf.exportOptions.columns = notHiddenArray;

		$('#btnRealExcel').click();
		$('#my-spinner').hide();
	});

	
    $('#allFaultTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#allFaultTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');

            

            /*let max = (changeFaulty.length * 3) + (processFaultyNm.length * 2) + (matrlFaultyNm.length * 2) + (troubleFaultyNm.length *4);

           /* 124 - (changeFaulty.length * 3);
            79 - (processFaultyNm.length * 2)
            79 - (matrlFaultyNm.length * 2)
			79 - (troubleFaultyNm.length *4);*/

			//5~124번까지, 125~204, 205~284
            
           /* let count1 		= changeFaulty.length * 3 + 5 //29
            let count2 		= processFaultyNm.length * 2
            let count3		= matrlFaultyNm.length * 2

            for(var i=5; i<max; i++){
            	 
				//생산-교체 Loss 교체(1)
				if(i < count1){
                	$(this).find('td').eq(i).attr('style', 'background-color: #0000ff4a;');
				}

				//생산-공정 조정(2)
				if(i > count1){ //29
					if(i < (count1 + count2)){
						$(this).find('td').eq( countEq2 ).attr('style', 'background-color: blueviolet;');
					}
				}

			}*/
        }
    });
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ전체 값 합치는 코드끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	paymentHderCreate();
	$.fn.dataTable.ext.errMode = 'none';
	let prcssFaultyTable = $('#prcssFaultyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-6 col-md-10'l><'col-sm-6 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-10'i><'col-sm-12 col-md-2'>B>",
    	language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
//         lengthChange: true,
//         scrollX : false,
//         pageLength: 100,

        scrollX: true,
        fixedColumns: {
        	 leftColumns: 5
        },
        scrollY : "58vh",
		scrollCollapse: true,
        lengthChange: false,
        
        ajax: {
            url: '<c:url value="wm/readPrcssFaultyList"/>',
            type: 'GET',
            data: {
            	'menuAuth'			: 		menuAuth,
            	//'faultyDateFrom'	:		function() { return faultyDateFrom.replace(/-/g, ''); },
            	'faultyDateTo'		:		function() { return faultyDateTo.replace(/-/g, ''); },
            	'faultyDateFrom'	:		function() { return faultyDateFrom.replace(/-/g, ''); },
            },
        },
		columns: [
			{
				render: function(data, type, row) {
					if(row['faultyRegDate'] == null || row['faultyRegDate'] == ''){
						return '';
					} else{
						return moment(row['faultyRegDate']).format('YYYY-MM-DD');
					}
				}
			},
			{ data: 'dayNightNm' },
			{ data: 'equipNm' },
			{ data: 'goodsNm' },
			{ data: 'alnicuMatrlNm' },
			{ data: 'kg1',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea1',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg5',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea5',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg6',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea6',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg7',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea7',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg8',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea8',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg9',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea9',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg10',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea10',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg11',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea11',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg12',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea12',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg13',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea13',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg14',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea14',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg15',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea15',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg16',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea16',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg17',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea17',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg18',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea18',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg19',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea19',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg20',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea20',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg21',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea21',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg22',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea22',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg23',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea23',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg24',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea24',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg25',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea25',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg26',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea26',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg27',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea27',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg28',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea28',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg29',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea29',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg30',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea30' ,
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg31',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea31',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg32',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea32' ,
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg33',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea33',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg34',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea34',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg35',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea35',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg36',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea36',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg37',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea37',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg38',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea38',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg39',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea39',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg40',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea40',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			//{ data: 'workTeamNm' },
			//{ data: 'userNm' },
		],
        columnDefs: [
        	{ targets: [5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73,75,77,79,81,83], className: 'text-right' },
        	{ targets: [6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84], className: 'text-right' },
        ],
		order: [
			[ 0, 'asc' ],
		],
        buttons: [
            {
                extend: 'copy',
                title: processFaultyNm,
            },
            {
                extend: 'excel',
                exportOptions: {
					columns: ':visible',
                },
                title: processFaultyNm,
            },
            {
                extend: 'print',
                title: processFaultyNm,
            }
        ],
		drawCallback:function() {
			$('#prcssFaultyTable tfoot').remove();
			
			let sumPrcssKg1		=	$('#prcssFaultyTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let sumPrcssEa1		=	$('#prcssFaultyTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			let sumPrcssKg2		=	$('#prcssFaultyTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			let sumPrcssEa2		=	$('#prcssFaultyTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			let sumPrcssKg3		=	$('#prcssFaultyTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			let sumPrcssEa3		=	$('#prcssFaultyTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			let sumPrcssKg4		=	$('#prcssFaultyTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			let sumPrcssEa4		=	$('#prcssFaultyTable').DataTable().column(12,{ page: 'all'} ).data().sum();
			let sumPrcssKg5		=	$('#prcssFaultyTable').DataTable().column(13,{ page: 'all'} ).data().sum();
			let sumPrcssEa5		=	$('#prcssFaultyTable').DataTable().column(14,{ page: 'all'} ).data().sum();
			let sumPrcssKg6		=	$('#prcssFaultyTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			let sumPrcssEa6		=	$('#prcssFaultyTable').DataTable().column(16,{ page: 'all'} ).data().sum();
			let sumPrcssKg7		=	$('#prcssFaultyTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			let sumPrcssEa7		=	$('#prcssFaultyTable').DataTable().column(18,{ page: 'all'} ).data().sum();
			let sumPrcssKg8		=	$('#prcssFaultyTable').DataTable().column(19,{ page: 'all'} ).data().sum();
			let sumPrcssEa8		=	$('#prcssFaultyTable').DataTable().column(20,{ page: 'all'} ).data().sum();
			let sumPrcssKg9		=	$('#prcssFaultyTable').DataTable().column(21,{ page: 'all'} ).data().sum();
			let sumPrcssEa9		=	$('#prcssFaultyTable').DataTable().column(22,{ page: 'all'} ).data().sum();
			let sumPrcssKg10	=	$('#prcssFaultyTable').DataTable().column(23,{ page: 'all'} ).data().sum();
			let sumPrcssEa10	=	$('#prcssFaultyTable').DataTable().column(24,{ page: 'all'} ).data().sum();
			let sumPrcssKg11	=	$('#prcssFaultyTable').DataTable().column(25,{ page: 'all'} ).data().sum();
			let sumPrcssEa11	=	$('#prcssFaultyTable').DataTable().column(26,{ page: 'all'} ).data().sum();
			let sumPrcssKg12	=	$('#prcssFaultyTable').DataTable().column(27,{ page: 'all'} ).data().sum();
			let sumPrcssEa12	=	$('#prcssFaultyTable').DataTable().column(28,{ page: 'all'} ).data().sum();
			let sumPrcssKg13	=	$('#prcssFaultyTable').DataTable().column(29,{ page: 'all'} ).data().sum();
			let sumPrcssEa13	=	$('#prcssFaultyTable').DataTable().column(30,{ page: 'all'} ).data().sum();
			let sumPrcssKg14	=	$('#prcssFaultyTable').DataTable().column(31,{ page: 'all'} ).data().sum();
			let sumPrcssEa14	=	$('#prcssFaultyTable').DataTable().column(32,{ page: 'all'} ).data().sum();
			let sumPrcssKg15	=	$('#prcssFaultyTable').DataTable().column(33,{ page: 'all'} ).data().sum();
			let sumPrcssEa15	=	$('#prcssFaultyTable').DataTable().column(34,{ page: 'all'} ).data().sum();
			let sumPrcssKg16	=	$('#prcssFaultyTable').DataTable().column(35,{ page: 'all'} ).data().sum();
			let sumPrcssEa16	=	$('#prcssFaultyTable').DataTable().column(36,{ page: 'all'} ).data().sum();
			let sumPrcssKg17	=	$('#prcssFaultyTable').DataTable().column(37,{ page: 'all'} ).data().sum();
			let sumPrcssEa17	=	$('#prcssFaultyTable').DataTable().column(38,{ page: 'all'} ).data().sum();
			let sumPrcssKg18	=	$('#prcssFaultyTable').DataTable().column(39,{ page: 'all'} ).data().sum();
			let sumPrcssEa18	=	$('#prcssFaultyTable').DataTable().column(40,{ page: 'all'} ).data().sum();
			let sumPrcssKg19	=	$('#prcssFaultyTable').DataTable().column(41,{ page: 'all'} ).data().sum();
			let sumPrcssEa19	=	$('#prcssFaultyTable').DataTable().column(42,{ page: 'all'} ).data().sum();
			let sumPrcssKg20	=	$('#prcssFaultyTable').DataTable().column(43,{ page: 'all'} ).data().sum();
			let sumPrcssEa20	=	$('#prcssFaultyTable').DataTable().column(44,{ page: 'all'} ).data().sum();
			let sumPrcssKg21	=	$('#prcssFaultyTable').DataTable().column(45,{ page: 'all'} ).data().sum();
			let sumPrcssEa21	=	$('#prcssFaultyTable').DataTable().column(46,{ page: 'all'} ).data().sum();
			let sumPrcssKg22	=	$('#prcssFaultyTable').DataTable().column(47,{ page: 'all'} ).data().sum();
			let sumPrcssEa22	=	$('#prcssFaultyTable').DataTable().column(48,{ page: 'all'} ).data().sum();
			let sumPrcssKg23	=	$('#prcssFaultyTable').DataTable().column(49,{ page: 'all'} ).data().sum();
			let sumPrcssEa23	=	$('#prcssFaultyTable').DataTable().column(50,{ page: 'all'} ).data().sum();
			let sumPrcssKg24	=	$('#prcssFaultyTable').DataTable().column(51,{ page: 'all'} ).data().sum();
			let sumPrcssEa24	=	$('#prcssFaultyTable').DataTable().column(52,{ page: 'all'} ).data().sum();
			let sumPrcssKg25	=	$('#prcssFaultyTable').DataTable().column(53,{ page: 'all'} ).data().sum();
			let sumPrcssEa25	=	$('#prcssFaultyTable').DataTable().column(54,{ page: 'all'} ).data().sum();
			let sumPrcssKg26	=	$('#prcssFaultyTable').DataTable().column(55,{ page: 'all'} ).data().sum();
			let sumPrcssEa26	=	$('#prcssFaultyTable').DataTable().column(56,{ page: 'all'} ).data().sum();
			let sumPrcssKg27	=	$('#prcssFaultyTable').DataTable().column(57,{ page: 'all'} ).data().sum();
			let sumPrcssEa27	=	$('#prcssFaultyTable').DataTable().column(58,{ page: 'all'} ).data().sum();
			let sumPrcssKg28	=	$('#prcssFaultyTable').DataTable().column(59,{ page: 'all'} ).data().sum();
			let sumPrcssEa28	=	$('#prcssFaultyTable').DataTable().column(60,{ page: 'all'} ).data().sum();
			let sumPrcssKg29	=	$('#prcssFaultyTable').DataTable().column(61,{ page: 'all'} ).data().sum();
			let sumPrcssEa29	=	$('#prcssFaultyTable').DataTable().column(62,{ page: 'all'} ).data().sum();
			let sumPrcssKg30	=	$('#prcssFaultyTable').DataTable().column(63,{ page: 'all'} ).data().sum();
			let sumPrcssEa30	=	$('#prcssFaultyTable').DataTable().column(64,{ page: 'all'} ).data().sum();
			let sumPrcssKg31	=	$('#prcssFaultyTable').DataTable().column(65,{ page: 'all'} ).data().sum();
			let sumPrcssEa31	=	$('#prcssFaultyTable').DataTable().column(66,{ page: 'all'} ).data().sum();
			let sumPrcssKg32	=	$('#prcssFaultyTable').DataTable().column(67,{ page: 'all'} ).data().sum();
			let sumPrcssEa32	=	$('#prcssFaultyTable').DataTable().column(68,{ page: 'all'} ).data().sum();
			let sumPrcssKg33	=	$('#prcssFaultyTable').DataTable().column(69,{ page: 'all'} ).data().sum();
			let sumPrcssEa33	=	$('#prcssFaultyTable').DataTable().column(70,{ page: 'all'} ).data().sum();
			let sumPrcssKg34	=	$('#prcssFaultyTable').DataTable().column(71,{ page: 'all'} ).data().sum();
			let sumPrcssEa34	=	$('#prcssFaultyTable').DataTable().column(72,{ page: 'all'} ).data().sum();
			let sumPrcssKg35	=	$('#prcssFaultyTable').DataTable().column(73,{ page: 'all'} ).data().sum();
			let sumPrcssEa35	=	$('#prcssFaultyTable').DataTable().column(74,{ page: 'all'} ).data().sum();
			let sumPrcssKg36	=	$('#prcssFaultyTable').DataTable().column(75,{ page: 'all'} ).data().sum();
			let sumPrcssEa36	=	$('#prcssFaultyTable').DataTable().column(76,{ page: 'all'} ).data().sum();
			let sumPrcssKg37	=	$('#prcssFaultyTable').DataTable().column(77,{ page: 'all'} ).data().sum();
			let sumPrcssEa37	=	$('#prcssFaultyTable').DataTable().column(78,{ page: 'all'} ).data().sum();
			let sumPrcssKg38	=	$('#prcssFaultyTable').DataTable().column(79,{ page: 'all'} ).data().sum();
			let sumPrcssEa38	=	$('#prcssFaultyTable').DataTable().column(80,{ page: 'all'} ).data().sum();
			let sumPrcssKg39	=	$('#prcssFaultyTable').DataTable().column(81,{ page: 'all'} ).data().sum();
			let sumPrcssEa39	=	$('#prcssFaultyTable').DataTable().column(82,{ page: 'all'} ).data().sum();
			let sumPrcssKg40	=	$('#prcssFaultyTable').DataTable().column(83,{ page: 'all'} ).data().sum();
			let sumPrcssEa40	=	$('#prcssFaultyTable').DataTable().column(84,{ page: 'all'} ).data().sum();
			
			$('#sumPrcssKg1').text(sumPrcssKg1.toFixed(3));
			$('#sumPrcssKg2').text(sumPrcssKg2.toFixed(3));
			$('#sumPrcssKg3').text(sumPrcssKg3.toFixed(3));
			$('#sumPrcssKg4').text(sumPrcssKg4.toFixed(3));
			$('#sumPrcssKg5').text(sumPrcssKg5.toFixed(3));
			$('#sumPrcssKg6').text(sumPrcssKg6.toFixed(3));
			$('#sumPrcssKg7').text(sumPrcssKg7.toFixed(3));
			$('#sumPrcssKg8').text(sumPrcssKg8.toFixed(3));
			$('#sumPrcssKg9').text(sumPrcssKg9.toFixed(3));
			$('#sumPrcssKg10').text(sumPrcssKg10.toFixed(3));
			$('#sumPrcssKg11').text(sumPrcssKg11.toFixed(3));
			$('#sumPrcssKg12').text(sumPrcssKg12.toFixed(3));
			$('#sumPrcssKg13').text(sumPrcssKg13.toFixed(3));
			$('#sumPrcssKg14').text(sumPrcssKg14.toFixed(3));
			$('#sumPrcssKg15').text(sumPrcssKg15.toFixed(3));
			$('#sumPrcssKg16').text(sumPrcssKg16.toFixed(3));
			$('#sumPrcssKg17').text(sumPrcssKg17.toFixed(3));
			$('#sumPrcssKg18').text(sumPrcssKg18.toFixed(3));
			$('#sumPrcssKg19').text(sumPrcssKg19.toFixed(3));
			$('#sumPrcssKg20').text(sumPrcssKg20.toFixed(3));
			$('#sumPrcssKg21').text(sumPrcssKg21.toFixed(3));
			$('#sumPrcssKg22').text(sumPrcssKg22.toFixed(3));
			$('#sumPrcssKg23').text(sumPrcssKg23.toFixed(3));
			$('#sumPrcssKg24').text(sumPrcssKg24.toFixed(3));
			$('#sumPrcssKg25').text(sumPrcssKg25.toFixed(3));
			$('#sumPrcssKg26').text(sumPrcssKg26.toFixed(3));
			$('#sumPrcssKg27').text(sumPrcssKg27.toFixed(3));
			$('#sumPrcssKg28').text(sumPrcssKg28.toFixed(3));
			$('#sumPrcssKg29').text(sumPrcssKg29.toFixed(3));
			$('#sumPrcssKg30').text(sumPrcssKg30.toFixed(3));
			$('#sumPrcssKg31').text(sumPrcssKg31.toFixed(3));
			$('#sumPrcssKg32').text(sumPrcssKg32.toFixed(3));
			$('#sumPrcssKg33').text(sumPrcssKg33.toFixed(3));
			$('#sumPrcssKg34').text(sumPrcssKg34.toFixed(3));
			$('#sumPrcssKg35').text(sumPrcssKg35.toFixed(3));
			$('#sumPrcssKg36').text(sumPrcssKg36.toFixed(3));
			$('#sumPrcssKg37').text(sumPrcssKg37.toFixed(3));
			$('#sumPrcssKg38').text(sumPrcssKg38.toFixed(3));
			$('#sumPrcssKg39').text(sumPrcssKg39.toFixed(3));
			$('#sumPrcssKg40').text(sumPrcssKg40.toFixed(3));

			$('#sumPrcssEa1').text(addCommas(Math.round(sumPrcssEa1)));
			$('#sumPrcssEa2').text(addCommas(Math.round(sumPrcssEa2)));
			$('#sumPrcssEa3').text(addCommas(Math.round(sumPrcssEa3)));
			$('#sumPrcssEa4').text(addCommas(Math.round(sumPrcssEa4)));
			$('#sumPrcssEa5').text(addCommas(Math.round(sumPrcssEa5)));
			$('#sumPrcssEa6').text(addCommas(Math.round(sumPrcssEa6)));
			$('#sumPrcssEa7').text(addCommas(Math.round(sumPrcssEa7)));
			$('#sumPrcssEa8').text(addCommas(Math.round(sumPrcssEa8)));
			$('#sumPrcssEa9').text(addCommas(Math.round(sumPrcssEa9)));
			$('#sumPrcssEa10').text(addCommas(Math.round(sumPrcssEa10)));
			$('#sumPrcssEa11').text(addCommas(Math.round(sumPrcssEa11)));
			$('#sumPrcssEa12').text(addCommas(Math.round(sumPrcssEa12)));
			$('#sumPrcssEa13').text(addCommas(Math.round(sumPrcssEa13)));
			$('#sumPrcssEa14').text(addCommas(Math.round(sumPrcssEa14)));
			$('#sumPrcssEa15').text(addCommas(Math.round(sumPrcssEa15)));
			$('#sumPrcssEa16').text(addCommas(Math.round(sumPrcssEa16)));
			$('#sumPrcssEa17').text(addCommas(Math.round(sumPrcssEa17)));
			$('#sumPrcssEa18').text(addCommas(Math.round(sumPrcssEa18)));
			$('#sumPrcssEa19').text(addCommas(Math.round(sumPrcssEa19)));
			$('#sumPrcssEa20').text(addCommas(Math.round(sumPrcssEa20)));
			$('#sumPrcssEa21').text(addCommas(Math.round(sumPrcssEa21)));
			$('#sumPrcssEa22').text(addCommas(Math.round(sumPrcssEa22)));
			$('#sumPrcssEa23').text(addCommas(Math.round(sumPrcssEa23)));
			$('#sumPrcssEa24').text(addCommas(Math.round(sumPrcssEa24)));
			$('#sumPrcssEa25').text(addCommas(Math.round(sumPrcssEa25)));
			$('#sumPrcssEa26').text(addCommas(Math.round(sumPrcssEa26)));
			$('#sumPrcssEa27').text(addCommas(Math.round(sumPrcssEa27)));
			$('#sumPrcssEa28').text(addCommas(Math.round(sumPrcssEa28)));
			$('#sumPrcssEa29').text(addCommas(Math.round(sumPrcssKg29)));
			$('#sumPrcssEa30').text(addCommas(Math.round(sumPrcssKg30)));
			$('#sumPrcssEa31').text(addCommas(Math.round(sumPrcssKg31)));
			$('#sumPrcssEa32').text(addCommas(Math.round(sumPrcssKg32)));
			$('#sumPrcssEa33').text(addCommas(Math.round(sumPrcssKg33)));
			$('#sumPrcssEa34').text(addCommas(Math.round(sumPrcssKg34)));
			$('#sumPrcssEa35').text(addCommas(Math.round(sumPrcssKg35)));
			$('#sumPrcssEa36').text(addCommas(Math.round(sumPrcssKg36)));
			$('#sumPrcssEa37').text(addCommas(Math.round(sumPrcssKg37)));
			$('#sumPrcssEa38').text(addCommas(Math.round(sumPrcssKg38)));
			$('#sumPrcssEa39').text(addCommas(Math.round(sumPrcssKg39)));
			$('#sumPrcssEa40').text(addCommas(Math.round(sumPrcssKg40)));

			$('#prcssFaultyTable tbody tr td').attr("style","min-width:60px;");
			
		 	/*$.each($('#prcssFaultyTable tbody tr'),function(index,item) {
				if ($('#prcssFaultyTable .0').text()=="") {
					$('#prcssFaultyTable .0').addClass('d-none');
					$(this).find('td').eq(5).addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$('#sumPrcssKg1').addClass('d-none');
					$('#sumPrcssEa1').addClass('d-none');
				}
				if ($('#prcssFaultyTable .1').text()=="") {
					$('#prcssFaultyTable .1').addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$('#sumPrcssKg2').addClass('d-none');
					$('#sumPrcssEa2').addClass('d-none');
				 }
				if ($('#prcssFaultyTable .2').text()=="") {
					$('#prcssFaultyTable .2').addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#sumPrcssKg3').addClass('d-none');
					$('#sumPrcssEa3').addClass('d-none');
				}
				if ($('#prcssFaultyTable .3').text()=="") {
					$('#prcssFaultyTable .3').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$('#sumPrcssKg4').addClass('d-none');
					$('#sumPrcssEa4').addClass('d-none');
				}
				if ($('#prcssFaultyTable .4').text()=="") {
					$('#prcssFaultyTable .4').addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$('#sumPrcssKg5').addClass('d-none');
					$('#sumPrcssEa5').addClass('d-none');
				}
				if ($('#prcssFaultyTable .5').text()=="") {
					$('#prcssFaultyTable .5').addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#sumPrcssKg6').addClass('d-none');
					$('#sumPrcssEa6').addClass('d-none');
				}
				if ($('#prcssFaultyTable .6').text()=="") {
					$('#prcssFaultyTable .6').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#sumPrcssKg7').addClass('d-none');
					$('#sumPrcssEa7').addClass('d-none');
				}
				if ($('#prcssFaultyTable .7').text()=="") {
					$('#prcssFaultyTable .7').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#sumPrcssKg8').addClass('d-none');
					$('#sumPrcssEa8').addClass('d-none');
				}
				if ($('#prcssFaultyTable .8').text()=="") {
					$('#prcssFaultyTable .8').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#sumPrcssKg9').addClass('d-none');
					$('#sumPrcssEa9').addClass('d-none');
				}
				if ($('#prcssFaultyTable .9').text()=="") {
					$('#prcssFaultyTable .9').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#sumPrcssKg10').addClass('d-none');
					$('#sumPrcssEa10').addClass('d-none');
				}
				if ($('#prcssFaultyTable .10').text()=="") {
					$('#prcssFaultyTable .10').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#sumPrcssKg11').addClass('d-none');
					$('#sumPrcssEa11').addClass('d-none');
				}
				if ($('#prcssFaultyTable .11').text()=="") {
					$('#prcssFaultyTable .11').addClass('d-none')
					$(this).find('td').eq(27).addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#sumPrcssKg12').addClass('d-none');
					$('#sumPrcssEa12').addClass('d-none');
				}
				if ($('#prcssFaultyTable .12').text()=="") {
					$('#prcssFaultyTable .12').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#sumPrcssKg13').addClass('d-none');
					$('#sumPrcssEa13').addClass('d-none');
				}
				if ($('#prcssFaultyTable .13').text()=="") {
					$('#prcssFaultyTable .13').addClass('d-none')
					$(this).find('td').eq(31).addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#sumPrcssKg14').addClass('d-none');
					$('#sumPrcssEa14').addClass('d-none');
				}
				if ($('#prcssFaultyTable .14').text()=="") {
					$('#prcssFaultyTable .14').addClass('d-none')
					$(this).find('td').eq(33).addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#sumPrcssKg15').addClass('d-none');
					$('#sumPrcssEa15').addClass('d-none');
				}
				if ($('#prcssFaultyTable .15').text()=="") {
					$('#prcssFaultyTable .15').addClass('d-none')
					$(this).find('td').eq(35).addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#sumPrcssKg16').addClass('d-none');
					$('#sumPrcssEa16').addClass('d-none');
				}
				if ($('#prcssFaultyTable .16').text()=="") {
					$('#prcssFaultyTable .16').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#sumPrcssKg17').addClass('d-none');
					$('#sumPrcssEa17').addClass('d-none');
				}
				if ($('#prcssFaultyTable .17').text()=="") {
					$('#prcssFaultyTable .17').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#sumPrcssKg18').addClass('d-none');
					$('#sumPrcssEa18').addClass('d-none');
				}
				if ($('#prcssFaultyTable .18').text()=="") {
					$('#prcssFaultyTable .18').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#sumPrcssKg19').addClass('d-none');
					$('#sumPrcssEa19').addClass('d-none');
				}
				if ($('#prcssFaultyTable .19').text()=="") {
					$('#prcssFaultyTable .19').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#sumPrcssKg20').addClass('d-none');
					$('#sumPrcssEa20').addClass('d-none');
				}
				if ($('#prcssFaultyTable .20').text()=="") {
					$('#prcssFaultyTable .20').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#sumPrcssKg21').addClass('d-none');
					$('#sumPrcssEa21').addClass('d-none');
				}
				if ($('#prcssFaultyTable .21').text()=="") {
					$('#prcssFaultyTable .21').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#sumPrcssKg22').addClass('d-none');
					$('#sumPrcssEa22').addClass('d-none');
				}
				if ($('#prcssFaultyTable .22').text()=="") {
					$('#prcssFaultyTable .22').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#sumPrcssKg23').addClass('d-none');
					$('#sumPrcssEa23').addClass('d-none');
				}
				if ($('#prcssFaultyTable .23').text()=="") {
					$('#prcssFaultyTable .23').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#sumPrcssKg24').addClass('d-none');
					$('#sumPrcssEa24').addClass('d-none');
				}
				if ($('#prcssFaultyTable .24').text()=="") {
					$('#prcssFaultyTable .24').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$('#sumPrcssKg25').addClass('d-none');
					$('#sumPrcssEa25').addClass('d-none');
				}
				if ($('#prcssFaultyTable .25').text()=="") {
					$('#prcssFaultyTable .25').addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#sumPrcssKg26').addClass('d-none');
					$('#sumPrcssEa26').addClass('d-none');
				}
				if ($('#prcssFaultyTable .26').text()=="") {
					$('#prcssFaultyTable .26').addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#sumPrcssKg27').addClass('d-none');
					$('#sumPrcssEa27').addClass('d-none');
				}
				if ($('#prcssFaultyTable .27').text()=="") {
					$('#prcssFaultyTable .27').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#sumPrcssKg28').addClass('d-none');
					$('#sumPrcssEa28').addClass('d-none');
				}
				if ($('#prcssFaultyTable .28').text()=="") {
					$('#prcssFaultyTable .28').addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$('#sumPrcssKg29').addClass('d-none');
					$('#sumPrcssEa29').addClass('d-none');
				}
				if ($('#prcssFaultyTable .29').text()=="") {
					$('#prcssFaultyTable .29').addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#sumPrcssKg30').addClass('d-none');
					$('#sumPrcssEa30').addClass('d-none');
				}
				if ($('#prcssFaultyTable .30').text()=="") {
					$('#prcssFaultyTable .30').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$('#sumPrcssKg31').addClass('d-none');
					$('#sumPrcssEa31').addClass('d-none');
				}
				if ($('#prcssFaultyTable .31').text()=="") {
					$('#prcssFaultyTable .31').addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#sumPrcssKg32').addClass('d-none');
					$('#sumPrcssEa32').addClass('d-none');
				}
				if ($('#prcssFaultyTable .32').text()=="") {
					$('#prcssFaultyTable .32').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#sumPrcssKg33').addClass('d-none');
					$('#sumPrcssEa33').addClass('d-none');
				}
				if ($('#prcssFaultyTable .33').text()=="") {
					$('#prcssFaultyTable .33').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#sumPrcssKg34').addClass('d-none');
					$('#sumPrcssEa34').addClass('d-none');
				}
				if ($('#prcssFaultyTable .34').text()=="") {
					$('#prcssFaultyTable .34').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$('#sumPrcssKg35').addClass('d-none');
					$('#sumPrcssEa35').addClass('d-none');
				}
				if ($('#prcssFaultyTable .35').text()=="") {
					$('#prcssFaultyTable .35').addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#sumPrcssKg36').addClass('d-none');
					$('#sumPrcssEa36').addClass('d-none');
				}
				if ($('#prcssFaultyTable .36').text()=="") {
					$('#prcssFaultyTable .36').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$('#sumPrcssKg37').addClass('d-none');
					$('#sumPrcssEa37').addClass('d-none');
				}
				if ($('#prcssFaultyTable .37').text()=="") {
					$('#prcssFaultyTable .37').addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#sumPrcssKg38').addClass('d-none');
					$('#sumPrcssEa38').addClass('d-none');
				}
				if ($('#prcssFaultyTable .38').text()=="") {
					$('#prcssFaultyTable .38').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#sumPrcssKg39').addClass('d-none');
					$('#sumPrcssEa39').addClass('d-none');
				}
				if ($('#prcssFaultyTable .39').text()=="") {
					$('#prcssFaultyTable .39').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#sumPrcssKg40').addClass('d-none');
					$('#sumPrcssEa40').addClass('d-none');
				}
			});*/
		  },
    });

	//생산-공정 품질 조정
	columnVisibleFun('prcssFaultyTable', (processFaulty.length *2), prcssFaultyTable);

	$('#prcssFaultyTable_length').html('');
	$('#prcssFaultyTable_paginate').addClass("float-left");
	
    $('#prcssFaultyTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#prcssFaultyTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
    
    paymentHderCreate2();
	$.fn.dataTable.ext.errMode = 'none';
	let matrlFaultyTable = $('#matrlFaultyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-6 col-md-10'l><'col-sm-6 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-10'i><'col-sm-12 col-md-2'>B>",
    	language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: false,
//         pageLength: 100,

        scrollX: true,
        fixedColumns: {
        	 leftColumns: 5
        },
        scrollY : "58vh",
		scrollCollapse: true,
        lengthChange: false,
        
        ajax: {
            url: '<c:url value="wm/readMatrlFaultyList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	//'faultyDateFrom' : function() { return faultyDateFrom.replace(/-/g, ''); },
            	'faultyDateTo' : function() { return faultyDateTo.replace(/-/g, ''); },
            	'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
            },
        },
		columns: [
			{
				render: function(data, type, row) {
					if(row['faultyRegDate'] == null || row['faultyRegDate'] == ''){
						return '';
					} else{
						return moment(row['faultyRegDate']).format('YYYY-MM-DD');
					}
				}
			},
			{ data: 'dayNightNm' },
			{ data: 'equipNm' },
			{ data: 'goodsNm' },
			{ data: 'alnicuMatrlNm' },
			{ data: 'kg1',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea1',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg5',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea5',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg6',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea6',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg7',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea7',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg8',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea8',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg9',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea9',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg10',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea10',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg11',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea11',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg12',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea12',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg13',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea13',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg14',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea14',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg15',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea15',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg16',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea16',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg17',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea17',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg18',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea18',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg19',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea19',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg20',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea20',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg21',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea21',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg22',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea22',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg23',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea23',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg24',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea24',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg25',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea25',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg26',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea26',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg27',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea27',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg28',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea28',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg29',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea29',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg30',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea30' ,
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg31',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea31',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg32',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea32' ,
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		},
			{ data: 'kg33',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea33',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg34',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea34',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg35',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea35',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg36',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea36',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg37',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea37',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg38',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea38',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg39',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea39',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			{ data: 'kg40',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
			{ data: 'ea40',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
	   		 },
			
			
			//{ data: 'workTeamNm' },
			//{ data: 'userNm' },
		],
        columnDefs: [
        	/* { targets: [6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86], render: $.fn.dataTable.render.number( ',' ) }, */
        	{ targets: [5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73,75,77,79,81,83], className: 'text-right' },
        	{ targets: [6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84], className: 'text-right' },
        ],
		order: [
			[ 0, 'asc' ],
		],
        buttons: [
            {
                extend: 'copy',
                title: matrlFaultyNm,
            },
            {
                extend: 'excel',
                exportOptions: {
					columns: ':visible',
                },
                title: matrlFaultyNm,
            },
            {
                extend: 'print',
                title: matrlFaultyNm,
            }
        ],
		drawCallback:function() {
			$('#matrlFaultyTable tfoot').remove();
			
			let sumMatrlKg1		=	$('#matrlFaultyTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let sumMatrlEa1		=	$('#matrlFaultyTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			let sumMatrlKg2		=	$('#matrlFaultyTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			let sumMatrlEa2		=	$('#matrlFaultyTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			let sumMatrlKg3		=	$('#matrlFaultyTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			let sumMatrlEa3		=	$('#matrlFaultyTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			let sumMatrlKg4		=	$('#matrlFaultyTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			let sumMatrlEa4		=	$('#matrlFaultyTable').DataTable().column(12,{ page: 'all'} ).data().sum();
			let sumMatrlKg5		=	$('#matrlFaultyTable').DataTable().column(13,{ page: 'all'} ).data().sum();
			let sumMatrlEa5		=	$('#matrlFaultyTable').DataTable().column(14,{ page: 'all'} ).data().sum();
			let sumMatrlKg6		=	$('#matrlFaultyTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			let sumMatrlEa6		=	$('#matrlFaultyTable').DataTable().column(16,{ page: 'all'} ).data().sum();
			let sumMatrlKg7		=	$('#matrlFaultyTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			let sumMatrlEa7		=	$('#matrlFaultyTable').DataTable().column(18,{ page: 'all'} ).data().sum();
			let sumMatrlKg8		=	$('#matrlFaultyTable').DataTable().column(19,{ page: 'all'} ).data().sum();
			let sumMatrlEa8		=	$('#matrlFaultyTable').DataTable().column(20,{ page: 'all'} ).data().sum();
			let sumMatrlKg9		=	$('#matrlFaultyTable').DataTable().column(21,{ page: 'all'} ).data().sum();
			let sumMatrlEa9		=	$('#matrlFaultyTable').DataTable().column(22,{ page: 'all'} ).data().sum();
			let sumMatrlKg10	=	$('#matrlFaultyTable').DataTable().column(23,{ page: 'all'} ).data().sum();
			let sumMatrlEa10	=	$('#matrlFaultyTable').DataTable().column(24,{ page: 'all'} ).data().sum();
			let sumMatrlKg11	=	$('#matrlFaultyTable').DataTable().column(25,{ page: 'all'} ).data().sum();
			let sumMatrlEa11	=	$('#matrlFaultyTable').DataTable().column(26,{ page: 'all'} ).data().sum();
			let sumMatrlKg12	=	$('#matrlFaultyTable').DataTable().column(27,{ page: 'all'} ).data().sum();
			let sumMatrlEa12	=	$('#matrlFaultyTable').DataTable().column(28,{ page: 'all'} ).data().sum();
			let sumMatrlKg13	=	$('#matrlFaultyTable').DataTable().column(29,{ page: 'all'} ).data().sum();
			let sumMatrlEa13	=	$('#matrlFaultyTable').DataTable().column(30,{ page: 'all'} ).data().sum();
			let sumMatrlKg14	=	$('#matrlFaultyTable').DataTable().column(31,{ page: 'all'} ).data().sum();
			let sumMatrlEa14	=	$('#matrlFaultyTable').DataTable().column(32,{ page: 'all'} ).data().sum();
			let sumMatrlKg15	=	$('#matrlFaultyTable').DataTable().column(33,{ page: 'all'} ).data().sum();
			let sumMatrlEa15	=	$('#matrlFaultyTable').DataTable().column(34,{ page: 'all'} ).data().sum();
			let sumMatrlKg16	=	$('#matrlFaultyTable').DataTable().column(35,{ page: 'all'} ).data().sum();
			let sumMatrlEa16	=	$('#matrlFaultyTable').DataTable().column(36,{ page: 'all'} ).data().sum();
			let sumMatrlKg17	=	$('#matrlFaultyTable').DataTable().column(37,{ page: 'all'} ).data().sum();
			let sumMatrlEa17	=	$('#matrlFaultyTable').DataTable().column(38,{ page: 'all'} ).data().sum();
			let sumMatrlKg18	=	$('#matrlFaultyTable').DataTable().column(39,{ page: 'all'} ).data().sum();
			let sumMatrlEa18	=	$('#matrlFaultyTable').DataTable().column(40,{ page: 'all'} ).data().sum();
			let sumMatrlKg19	=	$('#matrlFaultyTable').DataTable().column(41,{ page: 'all'} ).data().sum();
			let sumMatrlEa19	=	$('#matrlFaultyTable').DataTable().column(42,{ page: 'all'} ).data().sum();
			let sumMatrlKg20	=	$('#matrlFaultyTable').DataTable().column(43,{ page: 'all'} ).data().sum();
			let sumMatrlEa20	=	$('#matrlFaultyTable').DataTable().column(44,{ page: 'all'} ).data().sum();
			let sumMatrlKg21	=	$('#matrlFaultyTable').DataTable().column(45,{ page: 'all'} ).data().sum();
			let sumMatrlEa21	=	$('#matrlFaultyTable').DataTable().column(46,{ page: 'all'} ).data().sum();
			let sumMatrlKg22	=	$('#matrlFaultyTable').DataTable().column(47,{ page: 'all'} ).data().sum();
			let sumMatrlEa22	=	$('#matrlFaultyTable').DataTable().column(48,{ page: 'all'} ).data().sum();
			let sumMatrlKg23	=	$('#matrlFaultyTable').DataTable().column(49,{ page: 'all'} ).data().sum();
			let sumMatrlEa23	=	$('#matrlFaultyTable').DataTable().column(50,{ page: 'all'} ).data().sum();
			let sumMatrlKg24	=	$('#matrlFaultyTable').DataTable().column(51,{ page: 'all'} ).data().sum();
			let sumMatrlEa24	=	$('#matrlFaultyTable').DataTable().column(52,{ page: 'all'} ).data().sum();
			let sumMatrlKg25	=	$('#matrlFaultyTable').DataTable().column(53,{ page: 'all'} ).data().sum();
			let sumMatrlEa25	=	$('#matrlFaultyTable').DataTable().column(54,{ page: 'all'} ).data().sum();
			let sumMatrlKg26	=	$('#matrlFaultyTable').DataTable().column(55,{ page: 'all'} ).data().sum();
			let sumMatrlEa26	=	$('#matrlFaultyTable').DataTable().column(56,{ page: 'all'} ).data().sum();
			let sumMatrlKg27	=	$('#matrlFaultyTable').DataTable().column(57,{ page: 'all'} ).data().sum();
			let sumMatrlEa27	=	$('#matrlFaultyTable').DataTable().column(58,{ page: 'all'} ).data().sum();
			let sumMatrlKg28	=	$('#matrlFaultyTable').DataTable().column(59,{ page: 'all'} ).data().sum();
			let sumMatrlEa28	=	$('#matrlFaultyTable').DataTable().column(60,{ page: 'all'} ).data().sum();
			let sumMatrlKg29	=	$('#matrlFaultyTable').DataTable().column(61,{ page: 'all'} ).data().sum();
			let sumMatrlEa29	=	$('#matrlFaultyTable').DataTable().column(62,{ page: 'all'} ).data().sum();
			let sumMatrlKg30	=	$('#matrlFaultyTable').DataTable().column(63,{ page: 'all'} ).data().sum();
			let sumMatrlEa30	=	$('#matrlFaultyTable').DataTable().column(64,{ page: 'all'} ).data().sum();
			let sumMatrlKg31	=	$('#matrlFaultyTable').DataTable().column(65,{ page: 'all'} ).data().sum();
			let sumMatrlEa31	=	$('#matrlFaultyTable').DataTable().column(66,{ page: 'all'} ).data().sum();
			let sumMatrlKg32	=	$('#matrlFaultyTable').DataTable().column(67,{ page: 'all'} ).data().sum();
			let sumMatrlEa32	=	$('#matrlFaultyTable').DataTable().column(68,{ page: 'all'} ).data().sum();
			let sumMatrlKg33	=	$('#matrlFaultyTable').DataTable().column(69,{ page: 'all'} ).data().sum();
			let sumMatrlEa33	=	$('#matrlFaultyTable').DataTable().column(70,{ page: 'all'} ).data().sum();
			let sumMatrlKg34	=	$('#matrlFaultyTable').DataTable().column(71,{ page: 'all'} ).data().sum();
			let sumMatrlEa34	=	$('#matrlFaultyTable').DataTable().column(72,{ page: 'all'} ).data().sum();
			let sumMatrlKg35	=	$('#matrlFaultyTable').DataTable().column(73,{ page: 'all'} ).data().sum();
			let sumMatrlEa35	=	$('#matrlFaultyTable').DataTable().column(74,{ page: 'all'} ).data().sum();
			let sumMatrlKg36	=	$('#matrlFaultyTable').DataTable().column(75,{ page: 'all'} ).data().sum();
			let sumMatrlEa36	=	$('#matrlFaultyTable').DataTable().column(76,{ page: 'all'} ).data().sum();
			let sumMatrlKg37	=	$('#matrlFaultyTable').DataTable().column(77,{ page: 'all'} ).data().sum();
			let sumMatrlEa37	=	$('#matrlFaultyTable').DataTable().column(78,{ page: 'all'} ).data().sum();
			let sumMatrlKg38	=	$('#matrlFaultyTable').DataTable().column(79,{ page: 'all'} ).data().sum();
			let sumMatrlEa38	=	$('#matrlFaultyTable').DataTable().column(80,{ page: 'all'} ).data().sum();
			let sumMatrlKg39	=	$('#matrlFaultyTable').DataTable().column(81,{ page: 'all'} ).data().sum();
			let sumMatrlEa39	=	$('#matrlFaultyTable').DataTable().column(82,{ page: 'all'} ).data().sum();
			let sumMatrlKg40	=	$('#matrlFaultyTable').DataTable().column(83,{ page: 'all'} ).data().sum();
			let sumMatrlEa40	=	$('#matrlFaultyTable').DataTable().column(84,{ page: 'all'} ).data().sum();
			
			$('#sumMatrlKg1').text(sumMatrlKg1.toFixed(3));
			$('#sumMatrlKg2').text(sumMatrlKg2.toFixed(3));
			$('#sumMatrlKg3').text(sumMatrlKg3.toFixed(3));
			$('#sumMatrlKg4').text(sumMatrlKg4.toFixed(3));
			$('#sumMatrlKg5').text(sumMatrlKg5.toFixed(3));
			$('#sumMatrlKg6').text(sumMatrlKg6.toFixed(3));
			$('#sumMatrlKg7').text(sumMatrlKg7.toFixed(3));
			$('#sumMatrlKg8').text(sumMatrlKg8.toFixed(3));
			$('#sumMatrlKg9').text(sumMatrlKg9.toFixed(3));
			$('#sumMatrlKg10').text(sumMatrlKg10.toFixed(3));
			$('#sumMatrlKg11').text(sumMatrlKg11.toFixed(3));
			$('#sumMatrlKg12').text(sumMatrlKg12.toFixed(3));
			$('#sumMatrlKg13').text(sumMatrlKg13.toFixed(3));
			$('#sumMatrlKg14').text(sumMatrlKg14.toFixed(3));
			$('#sumMatrlKg15').text(sumMatrlKg15.toFixed(3));
			$('#sumMatrlKg16').text(sumMatrlKg16.toFixed(3));
			$('#sumMatrlKg17').text(sumMatrlKg17.toFixed(3));
			$('#sumMatrlKg18').text(sumMatrlKg18.toFixed(3));
			$('#sumMatrlKg19').text(sumMatrlKg19.toFixed(3));
			$('#sumMatrlKg20').text(sumMatrlKg20.toFixed(3));
			$('#sumMatrlKg21').text(sumMatrlKg21.toFixed(3));
			$('#sumMatrlKg22').text(sumMatrlKg22.toFixed(3));
			$('#sumMatrlKg23').text(sumMatrlKg23.toFixed(3));
			$('#sumMatrlKg24').text(sumMatrlKg24.toFixed(3));
			$('#sumMatrlKg25').text(sumMatrlKg25.toFixed(3));
			$('#sumMatrlKg26').text(sumMatrlKg26.toFixed(3));
			$('#sumMatrlKg27').text(sumMatrlKg27.toFixed(3));
			$('#sumMatrlKg28').text(sumMatrlKg28.toFixed(3));
			$('#sumMatrlKg29').text(sumMatrlKg29.toFixed(3));
			$('#sumMatrlKg30').text(sumMatrlKg30.toFixed(3));
			$('#sumMatrlKg31').text(sumMatrlKg31.toFixed(3));
			$('#sumMatrlKg32').text(sumMatrlKg32.toFixed(3));
			$('#sumMatrlKg33').text(sumMatrlKg33.toFixed(3));
			$('#sumMatrlKg34').text(sumMatrlKg34.toFixed(3));
			$('#sumMatrlKg35').text(sumMatrlKg35.toFixed(3));
			$('#sumMatrlKg36').text(sumMatrlKg36.toFixed(3));
			$('#sumMatrlKg37').text(sumMatrlKg37.toFixed(3));
			$('#sumMatrlKg38').text(sumMatrlKg38.toFixed(3));
			$('#sumMatrlKg39').text(sumMatrlKg39.toFixed(3));
			$('#sumMatrlKg40').text(sumMatrlKg40.toFixed(3));

			$('#sumMatrlEa1').text(addCommas(Math.round(sumMatrlEa1)));
			$('#sumMatrlEa2').text(addCommas(Math.round(sumMatrlEa2)));
			$('#sumMatrlEa3').text(addCommas(Math.round(sumMatrlEa3)));
			$('#sumMatrlEa4').text(addCommas(Math.round(sumMatrlEa4)));
			$('#sumMatrlEa5').text(addCommas(Math.round(sumMatrlEa5)));
			$('#sumMatrlEa6').text(addCommas(Math.round(sumMatrlEa6)));
			$('#sumMatrlEa7').text(addCommas(Math.round(sumMatrlEa7)));
			$('#sumMatrlEa8').text(addCommas(Math.round(sumMatrlEa8)));
			$('#sumMatrlEa9').text(addCommas(Math.round(sumMatrlEa9)));
			$('#sumMatrlEa10').text(addCommas(Math.round(sumMatrlEa10)));
			$('#sumMatrlEa11').text(addCommas(Math.round(sumMatrlEa11)));
			$('#sumMatrlEa12').text(addCommas(Math.round(sumMatrlEa12)));
			$('#sumMatrlEa13').text(addCommas(Math.round(sumMatrlEa13)));
			$('#sumMatrlEa14').text(addCommas(Math.round(sumMatrlEa14)));
			$('#sumMatrlEa15').text(addCommas(Math.round(sumMatrlEa15)));
			$('#sumMatrlEa16').text(addCommas(Math.round(sumMatrlEa16)));
			$('#sumMatrlEa17').text(addCommas(Math.round(sumMatrlEa17)));
			$('#sumMatrlEa18').text(addCommas(Math.round(sumMatrlEa18)));
			$('#sumMatrlEa19').text(addCommas(Math.round(sumMatrlEa19)));
			$('#sumMatrlEa20').text(addCommas(Math.round(sumMatrlEa20)));
			$('#sumMatrlEa21').text(addCommas(Math.round(sumMatrlEa21)));
			$('#sumMatrlEa22').text(addCommas(Math.round(sumMatrlEa22)));
			$('#sumMatrlEa23').text(addCommas(Math.round(sumMatrlEa23)));
			$('#sumMatrlEa24').text(addCommas(Math.round(sumMatrlEa24)));
			$('#sumMatrlEa25').text(addCommas(Math.round(sumMatrlEa25)));
			$('#sumMatrlEa26').text(addCommas(Math.round(sumMatrlEa26)));
			$('#sumMatrlEa27').text(addCommas(Math.round(sumMatrlEa27)));
			$('#sumMatrlEa28').text(addCommas(Math.round(sumMatrlEa28)));
			$('#sumMatrlEa29').text(addCommas(Math.round(sumMatrlKg29)));
			$('#sumMatrlEa30').text(addCommas(Math.round(sumMatrlKg30)));
			$('#sumMatrlEa31').text(addCommas(Math.round(sumMatrlKg31)));
			$('#sumMatrlEa32').text(addCommas(Math.round(sumMatrlKg32)));
			$('#sumMatrlEa33').text(addCommas(Math.round(sumMatrlKg33)));
			$('#sumMatrlEa34').text(addCommas(Math.round(sumMatrlKg34)));
			$('#sumMatrlEa35').text(addCommas(Math.round(sumMatrlKg35)));
			$('#sumMatrlEa36').text(addCommas(Math.round(sumMatrlKg36)));
			$('#sumMatrlEa37').text(addCommas(Math.round(sumMatrlKg37)));
			$('#sumMatrlEa38').text(addCommas(Math.round(sumMatrlKg38)));
			$('#sumMatrlEa39').text(addCommas(Math.round(sumMatrlKg39)));
			$('#sumMatrlEa40').text(addCommas(Math.round(sumMatrlKg40)));
			
			$('#matrlFaultyTable tbody tr td').attr("style","min-width:60px;");

			/*$.each($('#matrlFaultyTable tbody tr'),function(index,item) {
				if ($('#matrlFaultyTable .0').text()=="") {
					$('#matrlFaultyTable .0').addClass('d-none');
					$(this).find('td').eq(5).addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$('#sumMatrlKg1').addClass('d-none');
					$('#sumMatrlEa1').addClass('d-none');
				}
				if ($('#matrlFaultyTable .1').text()=="") {
					$('#matrlFaultyTable .1').addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$('#sumMatrlKg2').addClass('d-none');
					$('#sumMatrlEa2').addClass('d-none');
				 }
				if ($('#matrlFaultyTable .2').text()=="") {
					$('#matrlFaultyTable .2').addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#sumMatrlKg3').addClass('d-none');
					$('#sumMatrlEa3').addClass('d-none');
				}
				if ($('#matrlFaultyTable .3').text()=="") {
					$('#matrlFaultyTable .3').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$('#sumMatrlKg4').addClass('d-none');
					$('#sumMatrlEa4').addClass('d-none');
				}
				if ($('#matrlFaultyTable .4').text()=="") {
					$('#matrlFaultyTable .4').addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$('#sumMatrlKg5').addClass('d-none');
					$('#sumMatrlEa5').addClass('d-none');
				}
				if ($('#matrlFaultyTable .5').text()=="") {
					$('#matrlFaultyTable .5').addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#sumMatrlKg6').addClass('d-none');
					$('#sumMatrlEa6').addClass('d-none');
				}
				if ($('#matrlFaultyTable .6').text()=="") {
					$('#matrlFaultyTable .6').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$('#sumMatrlKg7').addClass('d-none');
					$('#sumMatrlEa7').addClass('d-none');
				}
				if ($('#matrlFaultyTable .7').text()=="") {
					$('#matrlFaultyTable .7').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#sumMatrlKg8').addClass('d-none');
					$('#sumMatrlEa8').addClass('d-none');
				}
				if ($('#matrlFaultyTable .8').text()=="") {
					$('#matrlFaultyTable .8').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#sumMatrlKg9').addClass('d-none');
					$('#sumMatrlEa9').addClass('d-none');
				}
				if ($('#matrlFaultyTable .9').text()=="") {
					$('#matrlFaultyTable .9').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#sumMatrlKg10').addClass('d-none');
					$('#sumMatrlEa10').addClass('d-none');
				}
				if ($('#matrlFaultyTable .10').text()=="") {
					$('#matrlFaultyTable .10').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$('#sumMatrlKg11').addClass('d-none');
					$('#sumMatrlEa11').addClass('d-none');
				}
				if ($('#matrlFaultyTable .11').text()=="") {
					$('#matrlFaultyTable .11').addClass('d-none')
					$(this).find('td').eq(27).addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#sumMatrlKg12').addClass('d-none');
					$('#sumMatrlEa12').addClass('d-none');
				}
				if ($('#matrlFaultyTable .12').text()=="") {
					$('#matrlFaultyTable .12').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$('#sumMatrlKg13').addClass('d-none');
					$('#sumMatrlEa13').addClass('d-none');
				}
				if ($('#matrlFaultyTable .13').text()=="") {
					$('#matrlFaultyTable .13').addClass('d-none')
					$(this).find('td').eq(31).addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#sumMatrlKg14').addClass('d-none');
					$('#sumMatrlEa14').addClass('d-none');
				}
				if ($('#matrlFaultyTable .14').text()=="") {
					$('#matrlFaultyTable .14').addClass('d-none')
					$(this).find('td').eq(33).addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#sumMatrlKg15').addClass('d-none');
					$('#sumMatrlEa15').addClass('d-none');
				}
				if ($('#matrlFaultyTable .15').text()=="") {
					$('#matrlFaultyTable .15').addClass('d-none')
					$(this).find('td').eq(35).addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#sumMatrlKg16').addClass('d-none');
					$('#sumMatrlEa16').addClass('d-none');
				}
				if ($('#matrlFaultyTable .16').text()=="") {
					$('#matrlFaultyTable .16').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$('#sumMatrlKg17').addClass('d-none');
					$('#sumMatrlEa17').addClass('d-none');
				}
				if ($('#matrlFaultyTable .17').text()=="") {
					$('#matrlFaultyTable .17').addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#sumMatrlKg18').addClass('d-none');
					$('#sumMatrlEa18').addClass('d-none');
				}
				if ($('#matrlFaultyTable .18').text()=="") {
					$('#matrlFaultyTable .18').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$('#sumMatrlKg19').addClass('d-none');
					$('#sumMatrlEa19').addClass('d-none');
				}
				if ($('#matrlFaultyTable .19').text()=="") {
					$('#matrlFaultyTable .19').addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#sumMatrlKg20').addClass('d-none');
					$('#sumMatrlEa20').addClass('d-none');
				}
				if ($('#matrlFaultyTable .20').text()=="") {
					$('#matrlFaultyTable .20').addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#sumMatrlKg21').addClass('d-none');
					$('#sumMatrlEa21').addClass('d-none');
				}
				if ($('#matrlFaultyTable .21').text()=="") {
					$('#matrlFaultyTable .21').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#sumMatrlKg22').addClass('d-none');
					$('#sumMatrlEa22').addClass('d-none');
				}
				if ($('#matrlFaultyTable .22').text()=="") {
					$('#matrlFaultyTable .22').addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$('#sumMatrlKg23').addClass('d-none');
					$('#sumMatrlEa23').addClass('d-none');
				}
				if ($('#matrlFaultyTable .23').text()=="") {
					$('#matrlFaultyTable .23').addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#sumMatrlKg24').addClass('d-none');
					$('#sumMatrlEa24').addClass('d-none');
				}
				if ($('#matrlFaultyTable .24').text()=="") {
					$('#matrlFaultyTable .24').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$('#sumMatrlKg25').addClass('d-none');
					$('#sumMatrlEa25').addClass('d-none');
				}
				if ($('#matrlFaultyTable .25').text()=="") {
					$('#matrlFaultyTable .25').addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#sumMatrlKg26').addClass('d-none');
					$('#sumMatrlEa26').addClass('d-none');
				}
				if ($('#matrlFaultyTable .26').text()=="") {
					$('#matrlFaultyTable .26').addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#sumMatrlKg27').addClass('d-none');
					$('#sumMatrlEa27').addClass('d-none');
				}
				if ($('#matrlFaultyTable .27').text()=="") {
					$('#matrlFaultyTable .27').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#sumMatrlKg28').addClass('d-none');
					$('#sumMatrlEa28').addClass('d-none');
				}
				if ($('#matrlFaultyTable .28').text()=="") {
					$('#matrlFaultyTable .28').addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$('#sumMatrlKg29').addClass('d-none');
					$('#sumMatrlEa29').addClass('d-none');
				}
				if ($('#matrlFaultyTable .29').text()=="") {
					$('#matrlFaultyTable .29').addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#sumMatrlKg30').addClass('d-none');
					$('#sumMatrlEa30').addClass('d-none');
				}
				if ($('#matrlFaultyTable .30').text()=="") {
					$('#matrlFaultyTable .30').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$('#sumMatrlKg31').addClass('d-none');
					$('#sumMatrlEa31').addClass('d-none');
				}
				if ($('#matrlFaultyTable .31').text()=="") {
					$('#matrlFaultyTable .31').addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#sumMatrlKg32').addClass('d-none');
					$('#sumMatrlEa32').addClass('d-none');
				}
				if ($('#matrlFaultyTable .32').text()=="") {
					$('#matrlFaultyTable .32').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#sumMatrlKg33').addClass('d-none');
					$('#sumMatrlEa33').addClass('d-none');
				}
				if ($('#matrlFaultyTable .33').text()=="") {
					$('#matrlFaultyTable .33').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#sumMatrlKg34').addClass('d-none');
					$('#sumMatrlEa34').addClass('d-none');
				}
				if ($('#matrlFaultyTable .34').text()=="") {
					$('#matrlFaultyTable .34').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$('#sumMatrlKg35').addClass('d-none');
					$('#sumMatrlEa35').addClass('d-none');
				}
				if ($('#matrlFaultyTable .35').text()=="") {
					$('#matrlFaultyTable .35').addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#sumMatrlKg36').addClass('d-none');
					$('#sumMatrlEa36').addClass('d-none');
				}
				if ($('#matrlFaultyTable .36').text()=="") {
					$('#matrlFaultyTable .36').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$('#sumMatrlKg37').addClass('d-none');
					$('#sumMatrlEa37').addClass('d-none');
				}
				if ($('#matrlFaultyTable .37').text()=="") {
					$('#matrlFaultyTable .37').addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#sumMatrlKg38').addClass('d-none');
					$('#sumMatrlEa38').addClass('d-none');
				}
				if ($('#matrlFaultyTable .38').text()=="") {
					$('#matrlFaultyTable .38').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#sumMatrlKg39').addClass('d-none');
					$('#sumMatrlEa39').addClass('d-none');
				}
				if ($('#matrlFaultyTable .39').text()=="") {
					$('#matrlFaultyTable .39').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#sumMatrlKg40').addClass('d-none');
					$('#sumMatrlEa40').addClass('d-none');
				}
			});*/
		}
	});

    $('#matrlFaultyTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#matrlFaultyTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

	$('#matrlFaultyTable_length').html('');

	//생산-원자재불량 교체
	columnVisibleFun('matrlFaultyTable', (matrlFaulty.length *2), matrlFaultyTable);

	
	paymentHderCreate3();
	$.fn.dataTable.ext.errMode = 'none';
	let replaceFaultyTable = $('#replaceFaultyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-6 col-md-10'l><'col-sm-6 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-10'i><'col-sm-12 col-md-2'>B>",
    	language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: false,
//         pageLength: 100,
		
		scrollX: true,
        fixedColumns: {
        	 leftColumns: 5
        },
        scrollY : "58vh",
		scrollCollapse: true,
        lengthChange: false,
        
        ajax: {
            url: '<c:url value="wm/readReplaceFaultyList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	//'faultyDateFrom' : function() { return faultyDateFrom.replace(/-/g, ''); },
            	'faultyDateTo' : function() { return faultyDateTo.replace(/-/g, ''); },
            	'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
            },
        },
		columns: [
			{
				render: function(data, type, row) {
					if(row['faultyRegDate'] == null || row['faultyRegDate'] == ''){
						return '';
					} else{
						return moment(row['faultyRegDate']).format('YYYY-MM-DD');
					}
				}
			},
			{ data: 'dayNightNm' },
			{ data: 'equipNm' },
			{ data: 'goodsNm' },
			{ data: 'alnicuMatrlNm' },
			{ data: 'count1'},
			{ data: 'kg1',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea1',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count2'},
			{ data: 'kg2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count3'},
			{ data: 'kg3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count4'},
			{ data: 'kg4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count5'},
			{ data: 'kg5',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea5',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count6'},
			{ data: 'kg6',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea6',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count7'},
			{ data: 'kg7',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea7',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count8'},
			{ data: 'kg8',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea8',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count9'},
			{ data: 'kg9',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea9',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count10'},
			{ data: 'kg10',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea10',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count11'},
			{ data: 'kg11',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea11',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count12'},
			{ data: 'kg12',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea12',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count13'},
			{ data: 'kg13',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea13',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count14'},
			{ data: 'kg14',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea14',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			{ data: 'count15'},
			{ data: 'kg15',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea15',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count16'},
			{ data: 'kg16',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea16',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count17'},
			{ data: 'kg17',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea17',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count18'},
			{ data: 'kg18',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea18',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count19'},
			{ data: 'kg19',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea19',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count20'},
			{ data: 'kg20',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea20',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count21'},
			{ data: 'kg21',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea21',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count22'},
			{ data: 'kg22',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea22',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count23'},
			{ data: 'kg23',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea23',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count24'},
			{ data: 'kg24',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea24',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count25'},
			{ data: 'kg25',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea25',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count26'},
			{ data: 'kg26',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea26',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count27'},
			{ data: 'kg27',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea27',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count28'},
			{ data: 'kg28',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea28',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count29'},
			{ data: 'kg29',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea29',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count30'},
			{ data: 'kg30',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea30',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count31'},
			{ data: 'kg31',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea31',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count32'},
			{ data: 'kg32',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea32',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count33'},
			{ data: 'kg33',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea33',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count34'},
			{ data: 'kg34',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea34',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count35'},
			{ data: 'kg35',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea35',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count36'},
			{ data: 'kg36',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea36',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count37'},
			{ data: 'kg37',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea37',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count38'},
			{ data: 'kg38',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea38',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count39'},
			{ data: 'kg39',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea39',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'count40'},
			{ data: 'kg40',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea40',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
			//{ data: 'workTeamNm' },
			//{ data: 'userNm' },
		],
        columnDefs: [
        	{ targets: [5,8,11,14,17,20,23,26,29,32,35,38,41,44,47,50,53,56,59,62,65,68,71,74,77,80,83,86,89,92,95,98,101,104,107,110,113,116,119,122], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46], className: 'text-right' },
        	{ targets: [47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90], className: 'text-right' },
        	{ targets: [91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124], className: 'text-right' },
        ],
		order: [
			[ 0, 'asc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: replaceFaultyNm,
            },
            {
                extend: 'excel',
                exportOptions: {
					columns: ':visible',
                },
                title: replaceFaultyNm,
            },
            {
                extend: 'print',
                title: replaceFaultyNm,
            }
        ],
		drawCallback:function() {
			$('#replaceFaultyTable tfoot').remove();
			let sumReplaceCount1	=	$('#replaceFaultyTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let sumReplaceKg1		=	$('#replaceFaultyTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			let sumReplaceEa1		=	$('#replaceFaultyTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			let sumReplaceCount2	=	$('#replaceFaultyTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			let sumReplaceKg2		=	$('#replaceFaultyTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			let sumReplaceEa2		=	$('#replaceFaultyTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			let sumReplaceCount3	=	$('#replaceFaultyTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			let sumReplaceKg3		=	$('#replaceFaultyTable').DataTable().column(12,{ page: 'all'} ).data().sum();
			let sumReplaceEa3		=	$('#replaceFaultyTable').DataTable().column(13,{ page: 'all'} ).data().sum();
			let sumReplaceCount4	=	$('#replaceFaultyTable').DataTable().column(14,{ page: 'all'} ).data().sum();
			let sumReplaceKg4		=	$('#replaceFaultyTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			let sumReplaceEa4		=	$('#replaceFaultyTable').DataTable().column(16,{ page: 'all'} ).data().sum();
			let sumReplaceCount5	=	$('#replaceFaultyTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			let sumReplaceKg5		=	$('#replaceFaultyTable').DataTable().column(18,{ page: 'all'} ).data().sum();
			let sumReplaceEa5		=	$('#replaceFaultyTable').DataTable().column(19,{ page: 'all'} ).data().sum();
			let sumReplaceCount6	=	$('#replaceFaultyTable').DataTable().column(20,{ page: 'all'} ).data().sum();
			let sumReplaceKg6		=	$('#replaceFaultyTable').DataTable().column(21,{ page: 'all'} ).data().sum();
			let sumReplaceEa6		=	$('#replaceFaultyTable').DataTable().column(22,{ page: 'all'} ).data().sum();
			let sumReplaceCount7	=	$('#replaceFaultyTable').DataTable().column(23,{ page: 'all'} ).data().sum();
			let sumReplaceKg7		=	$('#replaceFaultyTable').DataTable().column(24,{ page: 'all'} ).data().sum();
			let sumReplaceEa7		=	$('#replaceFaultyTable').DataTable().column(25,{ page: 'all'} ).data().sum();
			let sumReplaceCount8	=	$('#replaceFaultyTable').DataTable().column(26,{ page: 'all'} ).data().sum();
			let sumReplaceKg8		=	$('#replaceFaultyTable').DataTable().column(27,{ page: 'all'} ).data().sum();
			let sumReplaceEa8		=	$('#replaceFaultyTable').DataTable().column(28,{ page: 'all'} ).data().sum();
			let sumReplaceCount9	=	$('#replaceFaultyTable').DataTable().column(29,{ page: 'all'} ).data().sum();
			let sumReplaceKg9		=	$('#replaceFaultyTable').DataTable().column(30,{ page: 'all'} ).data().sum();
			let sumReplaceEa9		=	$('#replaceFaultyTable').DataTable().column(31,{ page: 'all'} ).data().sum();
			let sumReplaceCount10	=	$('#replaceFaultyTable').DataTable().column(32,{ page: 'all'} ).data().sum();
			let sumReplaceKg10		=	$('#replaceFaultyTable').DataTable().column(33,{ page: 'all'} ).data().sum();
			let sumReplaceEa10		=	$('#replaceFaultyTable').DataTable().column(34,{ page: 'all'} ).data().sum();
			let sumReplaceCount11	=	$('#replaceFaultyTable').DataTable().column(35,{ page: 'all'} ).data().sum();
			let sumReplaceKg11		=	$('#replaceFaultyTable').DataTable().column(36,{ page: 'all'} ).data().sum();
			let sumReplaceEa11		=	$('#replaceFaultyTable').DataTable().column(37,{ page: 'all'} ).data().sum();
			let sumReplaceCount12	=	$('#replaceFaultyTable').DataTable().column(38,{ page: 'all'} ).data().sum();
			let sumReplaceKg12		=	$('#replaceFaultyTable').DataTable().column(39,{ page: 'all'} ).data().sum();
			let sumReplaceEa12		=	$('#replaceFaultyTable').DataTable().column(40,{ page: 'all'} ).data().sum();
			let sumReplaceCount13	=	$('#replaceFaultyTable').DataTable().column(41,{ page: 'all'} ).data().sum();
			let sumReplaceKg13		=	$('#replaceFaultyTable').DataTable().column(42,{ page: 'all'} ).data().sum();
			let sumReplaceEa13		=	$('#replaceFaultyTable').DataTable().column(43,{ page: 'all'} ).data().sum();
			let sumReplaceCount14	=	$('#replaceFaultyTable').DataTable().column(44,{ page: 'all'} ).data().sum();
			let sumReplaceKg14		=	$('#replaceFaultyTable').DataTable().column(45,{ page: 'all'} ).data().sum();
			let sumReplaceEa14		=	$('#replaceFaultyTable').DataTable().column(46,{ page: 'all'} ).data().sum();
			let sumReplaceCount15	=	$('#replaceFaultyTable').DataTable().column(47,{ page: 'all'} ).data().sum();
			let sumReplaceKg15		=	$('#replaceFaultyTable').DataTable().column(48,{ page: 'all'} ).data().sum();
			let sumReplaceEa15		=	$('#replaceFaultyTable').DataTable().column(49,{ page: 'all'} ).data().sum();
			let sumReplaceCount16	=	$('#replaceFaultyTable').DataTable().column(50,{ page: 'all'} ).data().sum();
			let sumReplaceKg16		=	$('#replaceFaultyTable').DataTable().column(51,{ page: 'all'} ).data().sum();
			let sumReplaceEa16		=	$('#replaceFaultyTable').DataTable().column(52,{ page: 'all'} ).data().sum();
			let sumReplaceCount17	=	$('#replaceFaultyTable').DataTable().column(53,{ page: 'all'} ).data().sum();
			let sumReplaceKg17		=	$('#replaceFaultyTable').DataTable().column(54,{ page: 'all'} ).data().sum();
			let sumReplaceEa17		=	$('#replaceFaultyTable').DataTable().column(55,{ page: 'all'} ).data().sum();
			let sumReplaceCount18	=	$('#replaceFaultyTable').DataTable().column(56,{ page: 'all'} ).data().sum();
			let sumReplaceKg18		=	$('#replaceFaultyTable').DataTable().column(57,{ page: 'all'} ).data().sum();
			let sumReplaceEa18		=	$('#replaceFaultyTable').DataTable().column(58,{ page: 'all'} ).data().sum();
			let sumReplaceCount19	=	$('#replaceFaultyTable').DataTable().column(59,{ page: 'all'} ).data().sum();
			let sumReplaceKg19		=	$('#replaceFaultyTable').DataTable().column(60,{ page: 'all'} ).data().sum();
			let sumReplaceEa19		=	$('#replaceFaultyTable').DataTable().column(61,{ page: 'all'} ).data().sum();
			let sumReplaceCount20	=	$('#replaceFaultyTable').DataTable().column(62,{ page: 'all'} ).data().sum();
			let sumReplaceKg20		=	$('#replaceFaultyTable').DataTable().column(63,{ page: 'all'} ).data().sum();
			let sumReplaceEa20		=	$('#replaceFaultyTable').DataTable().column(64,{ page: 'all'} ).data().sum();
			let sumReplaceCount21	=	$('#replaceFaultyTable').DataTable().column(65,{ page: 'all'} ).data().sum();
			let sumReplaceKg21		=	$('#replaceFaultyTable').DataTable().column(66,{ page: 'all'} ).data().sum();
			let sumReplaceEa21		=	$('#replaceFaultyTable').DataTable().column(67,{ page: 'all'} ).data().sum();
			let sumReplaceCount22	=	$('#replaceFaultyTable').DataTable().column(68,{ page: 'all'} ).data().sum();
			let sumReplaceKg22		=	$('#replaceFaultyTable').DataTable().column(69,{ page: 'all'} ).data().sum();
			let sumReplaceEa22		=	$('#replaceFaultyTable').DataTable().column(70,{ page: 'all'} ).data().sum();
			let sumReplaceCount23	=	$('#replaceFaultyTable').DataTable().column(71,{ page: 'all'} ).data().sum();
			let sumReplaceKg23		=	$('#replaceFaultyTable').DataTable().column(72,{ page: 'all'} ).data().sum();
			let sumReplaceEa23		=	$('#replaceFaultyTable').DataTable().column(73,{ page: 'all'} ).data().sum();
			let sumReplaceCount24	=	$('#replaceFaultyTable').DataTable().column(74,{ page: 'all'} ).data().sum();
			let sumReplaceKg24		=	$('#replaceFaultyTable').DataTable().column(75,{ page: 'all'} ).data().sum();
			let sumReplaceEa24		=	$('#replaceFaultyTable').DataTable().column(76,{ page: 'all'} ).data().sum();
			let sumReplaceCount25	=	$('#replaceFaultyTable').DataTable().column(77,{ page: 'all'} ).data().sum();
			let sumReplaceKg25		=	$('#replaceFaultyTable').DataTable().column(78,{ page: 'all'} ).data().sum();
			let sumReplaceEa25		=	$('#replaceFaultyTable').DataTable().column(79,{ page: 'all'} ).data().sum();
			let sumReplaceCount26	=	$('#replaceFaultyTable').DataTable().column(80,{ page: 'all'} ).data().sum();
			let sumReplaceKg26		=	$('#replaceFaultyTable').DataTable().column(81,{ page: 'all'} ).data().sum();
			let sumReplaceEa26		=	$('#replaceFaultyTable').DataTable().column(82,{ page: 'all'} ).data().sum();
			let sumReplaceCount27	=	$('#replaceFaultyTable').DataTable().column(83,{ page: 'all'} ).data().sum();
			let sumReplaceKg27		=	$('#replaceFaultyTable').DataTable().column(84,{ page: 'all'} ).data().sum();
			let sumReplaceEa27		=	$('#replaceFaultyTable').DataTable().column(85,{ page: 'all'} ).data().sum();
			let sumReplaceCount28	=	$('#replaceFaultyTable').DataTable().column(86,{ page: 'all'} ).data().sum();
			let sumReplaceKg28		=	$('#replaceFaultyTable').DataTable().column(87,{ page: 'all'} ).data().sum();
			let sumReplaceEa28		=	$('#replaceFaultyTable').DataTable().column(88,{ page: 'all'} ).data().sum();
			let sumReplaceCount29	=	$('#replaceFaultyTable').DataTable().column(89,{ page: 'all'} ).data().sum();
			let sumReplaceKg29		=	$('#replaceFaultyTable').DataTable().column(90,{ page: 'all'} ).data().sum();
			let sumReplaceEa29		=	$('#replaceFaultyTable').DataTable().column(91,{ page: 'all'} ).data().sum();
			let sumReplaceCount30	=	$('#replaceFaultyTable').DataTable().column(92,{ page: 'all'} ).data().sum();
			let sumReplaceKg30		=	$('#replaceFaultyTable').DataTable().column(93,{ page: 'all'} ).data().sum();
			let sumReplaceEa30		=	$('#replaceFaultyTable').DataTable().column(94,{ page: 'all'} ).data().sum();
			let sumReplaceCount31	=	$('#replaceFaultyTable').DataTable().column(95,{ page: 'all'} ).data().sum();
			let sumReplaceKg31		=	$('#replaceFaultyTable').DataTable().column(96,{ page: 'all'} ).data().sum();
			let sumReplaceEa31		=	$('#replaceFaultyTable').DataTable().column(97,{ page: 'all'} ).data().sum();
			let sumReplaceCount32	=	$('#replaceFaultyTable').DataTable().column(98,{ page: 'all'} ).data().sum();
			let sumReplaceKg32		=	$('#replaceFaultyTable').DataTable().column(99,{ page: 'all'} ).data().sum();
			let sumReplaceEa32		=	$('#replaceFaultyTable').DataTable().column(100,{ page: 'all'} ).data().sum();
			let sumReplaceCount33	=	$('#replaceFaultyTable').DataTable().column(101,{ page: 'all'} ).data().sum();
			let sumReplaceKg33		=	$('#replaceFaultyTable').DataTable().column(102,{ page: 'all'} ).data().sum();
			let sumReplaceEa33		=	$('#replaceFaultyTable').DataTable().column(103,{ page: 'all'} ).data().sum();
			let sumReplaceCount34	=	$('#replaceFaultyTable').DataTable().column(104,{ page: 'all'} ).data().sum();
			let sumReplaceKg34		=	$('#replaceFaultyTable').DataTable().column(105,{ page: 'all'} ).data().sum();
			let sumReplaceEa34		=	$('#replaceFaultyTable').DataTable().column(106,{ page: 'all'} ).data().sum();
			let sumReplaceCount35	=	$('#replaceFaultyTable').DataTable().column(107,{ page: 'all'} ).data().sum();
			let sumReplaceKg35		=	$('#replaceFaultyTable').DataTable().column(108,{ page: 'all'} ).data().sum();
			let sumReplaceEa35		=	$('#replaceFaultyTable').DataTable().column(109,{ page: 'all'} ).data().sum();
			let sumReplaceCount36	=	$('#replaceFaultyTable').DataTable().column(110,{ page: 'all'} ).data().sum();
			let sumReplaceKg36		=	$('#replaceFaultyTable').DataTable().column(111,{ page: 'all'} ).data().sum();
			let sumReplaceEa36		=	$('#replaceFaultyTable').DataTable().column(112,{ page: 'all'} ).data().sum();
			let sumReplaceCount37	=	$('#replaceFaultyTable').DataTable().column(113,{ page: 'all'} ).data().sum();
			let sumReplaceKg37		=	$('#replaceFaultyTable').DataTable().column(114,{ page: 'all'} ).data().sum();
			let sumReplaceEa37		=	$('#replaceFaultyTable').DataTable().column(115,{ page: 'all'} ).data().sum();
			let sumReplaceCount38	=	$('#replaceFaultyTable').DataTable().column(116,{ page: 'all'} ).data().sum();
			let sumReplaceKg38		=	$('#replaceFaultyTable').DataTable().column(117,{ page: 'all'} ).data().sum();
			let sumReplaceEa38		=	$('#replaceFaultyTable').DataTable().column(118,{ page: 'all'} ).data().sum();
			let sumReplaceCount39	=	$('#replaceFaultyTable').DataTable().column(119,{ page: 'all'} ).data().sum();
			let sumReplaceKg39		=	$('#replaceFaultyTable').DataTable().column(120,{ page: 'all'} ).data().sum();
			let sumReplaceEa39		=	$('#replaceFaultyTable').DataTable().column(121,{ page: 'all'} ).data().sum();
			let sumReplaceCount40	=	$('#replaceFaultyTable').DataTable().column(122,{ page: 'all'} ).data().sum();
			let sumReplaceKg40		=	$('#replaceFaultyTable').DataTable().column(123,{ page: 'all'} ).data().sum();
			let sumReplaceEa40		=	$('#replaceFaultyTable').DataTable().column(124,{ page: 'all'} ).data().sum();
			
			$('#sumReplaceKg1').text(sumReplaceKg1.toFixed(3));
			$('#sumReplaceKg2').text(sumReplaceKg2.toFixed(3));
			$('#sumReplaceKg3').text(sumReplaceKg3.toFixed(3));
			$('#sumReplaceKg4').text(sumReplaceKg4.toFixed(3));
			$('#sumReplaceKg5').text(sumReplaceKg5.toFixed(3));
			$('#sumReplaceKg6').text(sumReplaceKg6.toFixed(3));
			$('#sumReplaceKg7').text(sumReplaceKg7.toFixed(3));
			$('#sumReplaceKg8').text(sumReplaceKg8.toFixed(3));
			$('#sumReplaceKg9').text(sumReplaceKg9.toFixed(3));
			$('#sumReplaceKg10').text(sumReplaceKg10.toFixed(3));
			$('#sumReplaceKg11').text(sumReplaceKg11.toFixed(3));
			$('#sumReplaceKg12').text(sumReplaceKg12.toFixed(3));
			$('#sumReplaceKg13').text(sumReplaceKg13.toFixed(3));
			$('#sumReplaceKg14').text(sumReplaceKg14.toFixed(3));
			$('#sumReplaceKg15').text(sumReplaceKg15.toFixed(3));
			$('#sumReplaceKg16').text(sumReplaceKg16.toFixed(3));
			$('#sumReplaceKg17').text(sumReplaceKg17.toFixed(3));
			$('#sumReplaceKg18').text(sumReplaceKg18.toFixed(3));
			$('#sumReplaceKg19').text(sumReplaceKg19.toFixed(3));
			$('#sumReplaceKg20').text(sumReplaceKg20.toFixed(3));
			$('#sumReplaceKg21').text(sumReplaceKg21.toFixed(3));
			$('#sumReplaceKg22').text(sumReplaceKg22.toFixed(3));
			$('#sumReplaceKg23').text(sumReplaceKg23.toFixed(3));
			$('#sumReplaceKg24').text(sumReplaceKg24.toFixed(3));
			$('#sumReplaceKg25').text(sumReplaceKg25.toFixed(3));
			$('#sumReplaceKg26').text(sumReplaceKg26.toFixed(3));
			$('#sumReplaceKg27').text(sumReplaceKg27.toFixed(3));
			$('#sumReplaceKg28').text(sumReplaceKg28.toFixed(3));
			$('#sumReplaceKg29').text(sumReplaceKg29.toFixed(3));
			$('#sumReplaceKg30').text(sumReplaceKg30.toFixed(3));
			$('#sumReplaceKg31').text(sumReplaceKg31.toFixed(3));
			$('#sumReplaceKg32').text(sumReplaceKg32.toFixed(3));
			$('#sumReplaceKg33').text(sumReplaceKg33.toFixed(3));
			$('#sumReplaceKg34').text(sumReplaceKg34.toFixed(3));
			$('#sumReplaceKg35').text(sumReplaceKg35.toFixed(3));
			$('#sumReplaceKg36').text(sumReplaceKg36.toFixed(3));
			$('#sumReplaceKg37').text(sumReplaceKg37.toFixed(3));
			$('#sumReplaceKg38').text(sumReplaceKg38.toFixed(3));
			$('#sumReplaceKg39').text(sumReplaceKg39.toFixed(3));
			$('#sumReplaceKg40').text(sumReplaceKg40.toFixed(3));

			$('#sumReplaceEa1').text(addCommas(Math.round(sumReplaceEa1)));
			$('#sumReplaceEa2').text(addCommas(Math.round(sumReplaceEa2)));
			$('#sumReplaceEa3').text(addCommas(Math.round(sumReplaceEa3)));
			$('#sumReplaceEa4').text(addCommas(Math.round(sumReplaceEa4)));
			$('#sumReplaceEa5').text(addCommas(Math.round(sumReplaceEa5)));
			$('#sumReplaceEa6').text(addCommas(Math.round(sumReplaceEa6)));
			$('#sumReplaceEa7').text(addCommas(Math.round(sumReplaceEa7)));
			$('#sumReplaceEa8').text(addCommas(Math.round(sumReplaceEa8)));
			$('#sumReplaceEa9').text(addCommas(Math.round(sumReplaceEa9)));
			$('#sumReplaceEa10').text(addCommas(Math.round(sumReplaceEa10)));
			$('#sumReplaceEa11').text(addCommas(Math.round(sumReplaceEa11)));
			$('#sumReplaceEa12').text(addCommas(Math.round(sumReplaceEa12)));
			$('#sumReplaceEa13').text(addCommas(Math.round(sumReplaceEa13)));
			$('#sumReplaceEa14').text(addCommas(Math.round(sumReplaceEa14)));
			$('#sumReplaceEa15').text(addCommas(Math.round(sumReplaceEa15)));
			$('#sumReplaceEa16').text(addCommas(Math.round(sumReplaceEa16)));
			$('#sumReplaceEa17').text(addCommas(Math.round(sumReplaceEa17)));
			$('#sumReplaceEa18').text(addCommas(Math.round(sumReplaceEa18)));
			$('#sumReplaceEa19').text(addCommas(Math.round(sumReplaceEa19)));
			$('#sumReplaceEa20').text(addCommas(Math.round(sumReplaceEa20)));
			$('#sumReplaceEa21').text(addCommas(Math.round(sumReplaceEa21)));
			$('#sumReplaceEa22').text(addCommas(Math.round(sumReplaceEa22)));
			$('#sumReplaceEa23').text(addCommas(Math.round(sumReplaceEa23)));
			$('#sumReplaceEa24').text(addCommas(Math.round(sumReplaceEa24)));
			$('#sumReplaceEa25').text(addCommas(Math.round(sumReplaceEa25)));
			$('#sumReplaceEa26').text(addCommas(Math.round(sumReplaceEa26)));
			$('#sumReplaceEa27').text(addCommas(Math.round(sumReplaceEa27)));
			$('#sumReplaceEa28').text(addCommas(Math.round(sumReplaceEa28)));
			$('#sumReplaceEa29').text(addCommas(Math.round(sumReplaceKg29)));
			$('#sumReplaceEa30').text(addCommas(Math.round(sumReplaceKg30)));
			$('#sumReplaceEa31').text(addCommas(Math.round(sumReplaceKg31)));
			$('#sumReplaceEa32').text(addCommas(Math.round(sumReplaceKg32)));
			$('#sumReplaceEa33').text(addCommas(Math.round(sumReplaceKg33)));
			$('#sumReplaceEa34').text(addCommas(Math.round(sumReplaceKg34)));
			$('#sumReplaceEa35').text(addCommas(Math.round(sumReplaceKg35)));
			$('#sumReplaceEa36').text(addCommas(Math.round(sumReplaceKg36)));
			$('#sumReplaceEa37').text(addCommas(Math.round(sumReplaceKg37)));
			$('#sumReplaceEa38').text(addCommas(Math.round(sumReplaceKg38)));
			$('#sumReplaceEa39').text(addCommas(Math.round(sumReplaceKg39)));
			$('#sumReplaceEa40').text(addCommas(Math.round(sumReplaceKg40)));

			$('#sumReplaceCount1').text(sumReplaceCount1);
			$('#sumReplaceCount2').text(sumReplaceCount2);
			$('#sumReplaceCount3').text(sumReplaceCount3);
			$('#sumReplaceCount4').text(sumReplaceCount4);
			$('#sumReplaceCount5').text(sumReplaceCount5);
			$('#sumReplaceCount6').text(sumReplaceCount6);
			$('#sumReplaceCount7').text(sumReplaceCount7);
			$('#sumReplaceCount8').text(sumReplaceCount8);
			$('#sumReplaceCount9').text(sumReplaceCount9);
			$('#sumReplaceCount10').text(sumReplaceCount10);
			$('#sumReplaceCount11').text(sumReplaceCount11);
			$('#sumReplaceCount12').text(sumReplaceCount12);
			$('#sumReplaceCount13').text(sumReplaceCount13);
			$('#sumReplaceCount14').text(sumReplaceCount14);
			$('#sumReplaceCount15').text(sumReplaceCount15);
			$('#sumReplaceCount16').text(sumReplaceCount16);
			$('#sumReplaceCount17').text(sumReplaceCount17);
			$('#sumReplaceCount18').text(sumReplaceCount18);
			$('#sumReplaceCount19').text(sumReplaceCount19);
			$('#sumReplaceCount20').text(sumReplaceCount20);
			$('#sumReplaceCount21').text(sumReplaceCount21);
			$('#sumReplaceCount22').text(sumReplaceCount22);
			$('#sumReplaceCount23').text(sumReplaceCount23);
			$('#sumReplaceCount24').text(sumReplaceCount24);
			$('#sumReplaceCount25').text(sumReplaceCount25);
			$('#sumReplaceCount26').text(sumReplaceCount26);
			$('#sumReplaceCount27').text(sumReplaceCount27);
			$('#sumReplaceCount28').text(sumReplaceCount28);
			$('#sumReplaceCount29').text(sumReplaceCount29);
			$('#sumReplaceCount30').text(sumReplaceCount30);
			$('#sumReplaceCount31').text(sumReplaceCount31);
			$('#sumReplaceCount32').text(sumReplaceCount32);
			$('#sumReplaceCount33').text(sumReplaceCount33);
			$('#sumReplaceCount34').text(sumReplaceCount34);
			$('#sumReplaceCount35').text(sumReplaceCount35);
			$('#sumReplaceCount36').text(sumReplaceCount36);
			$('#sumReplaceCount37').text(sumReplaceCount37);
			$('#sumReplaceCount38').text(sumReplaceCount38);
			$('#sumReplaceCount39').text(sumReplaceCount39);
			$('#sumReplaceCount40').text(sumReplaceCount40);

			$('#replaceFaultyTable tbody tr td').attr("style","min-width:60px;");
			
		 	$.each($('#replaceFaultyTable tbody tr'),function(index,item) {
				if ($('#replaceFaultyTable .0').text()=="") {
					$('#replaceFaultyTable .0').addClass('d-none');
					$(this).find('td').eq(5).addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$('#sumReplaceCount1').addClass('d-none');
					$('#sumReplaceKg1').addClass('d-none');
					$('#sumReplaceEa1').addClass('d-none');
				}						
				if ($('#replaceFaultyTable .1').text()=="") {
					$('#replaceFaultyTable .1').addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$('#sumReplaceCount2').addClass('d-none');
					$('#sumReplaceKg2').addClass('d-none');
					$('#sumReplaceEa2').addClass('d-none');
				}
				if ($('#replaceFaultyTable .2').text()=="") {
					$('#replaceFaultyTable .2').addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$('#sumReplaceCount3').addClass('d-none');
					$('#sumReplaceKg3').addClass('d-none');
					$('#sumReplaceEa3').addClass('d-none');
				}
				if ($('#replaceFaultyTable .3').text()=="") {
					$('#replaceFaultyTable .3').addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#sumReplaceCount4').addClass('d-none');
					$('#sumReplaceKg4').addClass('d-none');
					$('#sumReplaceEa4').addClass('d-none');
				}
				if ($('#replaceFaultyTable .4').text()=="") {
					$('#replaceFaultyTable .4').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$('#sumReplaceCount5').addClass('d-none');
					$('#sumReplaceKg5').addClass('d-none');
					$('#sumReplaceEa5').addClass('d-none');
				}
				if ($('#replaceFaultyTable .5').text()=="") {
					$('#replaceFaultyTable .5').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$('#sumReplaceCount6').addClass('d-none');
					$('#sumReplaceKg6').addClass('d-none');
					$('#sumReplaceEa6').addClass('d-none');
				}
				if ($('#replaceFaultyTable .6').text()=="") {
					$('#replaceFaultyTable .6').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$('#sumReplaceCount7').addClass('d-none');
					$('#sumReplaceKg7').addClass('d-none');
					$('#sumReplaceEa7').addClass('d-none');
				}
				if ($('#replaceFaultyTable .7').text()=="") {
					$('#replaceFaultyTable .7').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#sumReplaceCount8').addClass('d-none');
					$('#sumReplaceKg8').addClass('d-none');
					$('#sumReplaceEa8').addClass('d-none');
				}
				if ($('#replaceFaultyTable .8').text()=="") {
					$('#replaceFaultyTable .8').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$('#sumReplaceCount9').addClass('d-none');
					$('#sumReplaceKg9').addClass('d-none');
					$('#sumReplaceEa9').addClass('d-none');
				}
				if ($('#replaceFaultyTable .9').text()=="") {
					$('#replaceFaultyTable .9').addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$('#sumReplaceCount10').addClass('d-none');
					$('#sumReplaceKg10').addClass('d-none');
					$('#sumReplaceEa10').addClass('d-none');
				}
				if ($('#replaceFaultyTable .10').text()=="") {
					$('#replaceFaultyTable .10').addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$('#sumReplaceCount11').addClass('d-none');
					$('#sumReplaceKg11').addClass('d-none');
					$('#sumReplaceEa11').addClass('d-none');
				}
				if ($('#replaceFaultyTable .11').text()=="") {
					$('#replaceFaultyTable .11').addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#sumReplaceCount12').addClass('d-none');
					$('#sumReplaceKg12').addClass('d-none');
					$('#sumReplaceEa12').addClass('d-none');
				}
				if ($('#replaceFaultyTable .12').text()=="") {
					$('#replaceFaultyTable .12').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$('#sumReplaceCount13').addClass('d-none');
					$('#sumReplaceKg13').addClass('d-none');
					$('#sumReplaceEa13').addClass('d-none');
				}
				if ($('#replaceFaultyTable .13').text()=="") {
					$('#replaceFaultyTable .13').addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$(this).find('td').eq(45).addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$('#sumReplaceCount14').addClass('d-none');
					$('#sumReplaceKg14').addClass('d-none');
					$('#sumReplaceEa14').addClass('d-none');
				}
				if ($('#replaceFaultyTable .14').text()=="") {
					$('#replaceFaultyTable .14').addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$(this).find('td').eq(49).addClass('d-none');
					$('#sumReplaceCount15').addClass('d-none');
					$('#sumReplaceKg15').addClass('d-none');
					$('#sumReplaceEa15').addClass('d-none');
				}
				if ($('#replaceFaultyTable .15').text()=="") {
					$('#replaceFaultyTable .15').addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');
					$(this).find('td').eq(51).addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#sumReplaceCount16').addClass('d-none');
					$('#sumReplaceKg16').addClass('d-none');
					$('#sumReplaceEa16').addClass('d-none');
				}
				if ($('#replaceFaultyTable .16').text()=="") {
					$('#replaceFaultyTable .16').addClass('d-none');
					$(this).find('td').eq(53).addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');
					$(this).find('td').eq(55).addClass('d-none');
					$('#sumReplaceCount17').addClass('d-none');
					$('#sumReplaceKg17').addClass('d-none');
					$('#sumReplaceEa17').addClass('d-none');
				}
				if ($('#replaceFaultyTable .17').text()=="") {
					$('#replaceFaultyTable .17').addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$(this).find('td').eq(57).addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');
					$('#sumReplaceCount18').addClass('d-none');
					$('#sumReplaceKg18').addClass('d-none');
					$('#sumReplaceEa18').addClass('d-none');
				}
				if ($('#replaceFaultyTable .18').text()=="") {
					$('#replaceFaultyTable .18').addClass('d-none');
					$(this).find('td').eq(59).addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$(this).find('td').eq(61).addClass('d-none');
					$('#sumReplaceCount19').addClass('d-none');
					$('#sumReplaceKg19').addClass('d-none');
					$('#sumReplaceEa19').addClass('d-none');
				}
				if ($('#replaceFaultyTable .19').text()=="") {
					$('#replaceFaultyTable .19').addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#sumReplaceCount20').addClass('d-none');
					$('#sumReplaceKg20').addClass('d-none');
					$('#sumReplaceEa20').addClass('d-none');
				}
				if ($('#replaceFaultyTable .20').text()=="") {
					$('#replaceFaultyTable .20').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');
					$(this).find('td').eq(67).addClass('d-none');
					$('#sumReplaceCount21').addClass('d-none');
					$('#sumReplaceKg21').addClass('d-none');
					$('#sumReplaceEa21').addClass('d-none');
				}
				if ($('#replaceFaultyTable .21').text()=="") {
					$('#replaceFaultyTable .21').addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$('#sumReplaceCount22').addClass('d-none');
					$('#sumReplaceKg22').addClass('d-none');
					$('#sumReplaceEa22').addClass('d-none');
				}
				if ($('#replaceFaultyTable .22').text()=="") {
					$('#replaceFaultyTable .22').addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$('#sumReplaceCount23').addClass('d-none');
					$('#sumReplaceKg23').addClass('d-none');
					$('#sumReplaceEa23').addClass('d-none');
				}
				if ($('#replaceFaultyTable .23').text()=="") {
					$('#replaceFaultyTable .23').addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#sumReplaceCount24').addClass('d-none');
					$('#sumReplaceKg24').addClass('d-none');
					$('#sumReplaceEa24').addClass('d-none');
				}
				if ($('#replaceFaultyTable .24').text()=="") {
					$('#replaceFaultyTable .24').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$('#sumReplaceCount25').addClass('d-none');
					$('#sumReplaceKg25').addClass('d-none');
					$('#sumReplaceEa25').addClass('d-none');
				}
				if ($('#replaceFaultyTable .25').text()=="") {
					$('#replaceFaultyTable .25').addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$('#sumReplaceCount26').addClass('d-none');
					$('#sumReplaceKg26').addClass('d-none');
					$('#sumReplaceEa26').addClass('d-none');
				}
				if ($('#replaceFaultyTable .26').text()=="") {
					$('#replaceFaultyTable .26').addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$(this).find('td').eq(85).addClass('d-none');
					$('#sumReplaceCount27').addClass('d-none');
					$('#sumReplaceKg27').addClass('d-none');
					$('#sumReplaceEa27').addClass('d-none');
				}
				if ($('#replaceFaultyTable .27').text()=="") {
					$('#replaceFaultyTable .27').addClass('d-none');
					$(this).find('td').eq(86).addClass('d-none');
					$(this).find('td').eq(87).addClass('d-none');
					$(this).find('td').eq(88).addClass('d-none');
					$('#sumReplaceCount28').addClass('d-none');
					$('#sumReplaceKg28').addClass('d-none');
					$('#sumReplaceEa28').addClass('d-none');
				}
				if ($('#replaceFaultyTable .28').text()=="") {
					$('#replaceFaultyTable .28').addClass('d-none');
					$(this).find('td').eq(89).addClass('d-none');
					$(this).find('td').eq(90).addClass('d-none');
					$(this).find('td').eq(91).addClass('d-none');
					$('#sumReplaceCount29').addClass('d-none');
					$('#sumReplaceKg29').addClass('d-none');
					$('#sumReplaceEa29').addClass('d-none');
				}
				if ($('#replaceFaultyTable .29').text()=="") {
					$('#replaceFaultyTable .29').addClass('d-none');
					$(this).find('td').eq(92).addClass('d-none');
					$(this).find('td').eq(93).addClass('d-none');
					$(this).find('td').eq(94).addClass('d-none');
					$('#sumReplaceCount30').addClass('d-none');
					$('#sumReplaceKg30').addClass('d-none');
					$('#sumReplaceEa30').addClass('d-none');
				}
				if ($('#replaceFaultyTable .30').text()=="") {
					$('#replaceFaultyTable .30').addClass('d-none');
					$(this).find('td').eq(95).addClass('d-none');
					$(this).find('td').eq(96).addClass('d-none');
					$(this).find('td').eq(97).addClass('d-none');
					$('#sumReplaceCount31').addClass('d-none');
					$('#sumReplaceKg31').addClass('d-none');
					$('#sumReplaceEa31').addClass('d-none');
				}
				if ($('#replaceFaultyTable .31').text()=="") {
					$('#replaceFaultyTable .31').addClass('d-none');
					$(this).find('td').eq(98).addClass('d-none');
					$(this).find('td').eq(99).addClass('d-none');
					$(this).find('td').eq(100).addClass('d-none');
					$('#sumReplaceCount32').addClass('d-none');
					$('#sumReplaceKg32').addClass('d-none');
					$('#sumReplaceEa32').addClass('d-none');
				}
				if ($('#replaceFaultyTable .32').text()=="") {
					$('#replaceFaultyTable .32').addClass('d-none');
					$(this).find('td').eq(101).addClass('d-none');
					$(this).find('td').eq(102).addClass('d-none');
					$(this).find('td').eq(103).addClass('d-none');
					$('#sumReplaceCount33').addClass('d-none');
					$('#sumReplaceKg33').addClass('d-none');
					$('#sumReplaceEa33').addClass('d-none');
				}
				if ($('#replaceFaultyTable .33').text()=="") {
					$('#replaceFaultyTable .33').addClass('d-none');
					$(this).find('td').eq(104).addClass('d-none');
					$(this).find('td').eq(105).addClass('d-none');
					$(this).find('td').eq(106).addClass('d-none');
					$('#sumReplaceCount34').addClass('d-none');
					$('#sumReplaceKg34').addClass('d-none');
					$('#sumReplaceEa34').addClass('d-none');
				}
				if ($('#replaceFaultyTable .34').text()=="") {
					$('#replaceFaultyTable .34').addClass('d-none');
					$(this).find('td').eq(107).addClass('d-none');
					$(this).find('td').eq(108).addClass('d-none');
					$(this).find('td').eq(109).addClass('d-none');
					$('#sumReplaceCount35').addClass('d-none');
					$('#sumReplaceKg35').addClass('d-none');
					$('#sumReplaceEa35').addClass('d-none');
				}
				if ($('#replaceFaultyTable .35').text()=="") {
					$('#replaceFaultyTable .35').addClass('d-none');
					$(this).find('td').eq(110).addClass('d-none');
					$(this).find('td').eq(111).addClass('d-none');
					$(this).find('td').eq(112).addClass('d-none');
					$('#sumReplaceCount36').addClass('d-none');
					$('#sumReplaceKg36').addClass('d-none');
					$('#sumReplaceEa36').addClass('d-none');
				}
				if ($('#replaceFaultyTable .36').text()=="") {
					$('#replaceFaultyTable .36').addClass('d-none');
					$(this).find('td').eq(113).addClass('d-none');
					$(this).find('td').eq(114).addClass('d-none');
					$(this).find('td').eq(115).addClass('d-none');
					$('#sumReplaceCount37').addClass('d-none');
					$('#sumReplaceKg37').addClass('d-none');
					$('#sumReplaceEa37').addClass('d-none');
				}
				if ($('#replaceFaultyTable .37').text()=="") {
					$('#replaceFaultyTable .37').addClass('d-none');
					$(this).find('td').eq(116).addClass('d-none');
					$(this).find('td').eq(117).addClass('d-none');
					$(this).find('td').eq(118).addClass('d-none');
					$('#sumReplaceCount38').addClass('d-none');
					$('#sumReplaceKg38').addClass('d-none');
					$('#sumReplaceEa38').addClass('d-none');
				}
				if ($('#replaceFaultyTable .38').text()=="") {
					$('#replaceFaultyTable .38').addClass('d-none');
					$(this).find('td').eq(119).addClass('d-none');
					$(this).find('td').eq(120).addClass('d-none');
					$(this).find('td').eq(121).addClass('d-none');
					$('#sumReplaceCount39').addClass('d-none');
					$('#sumReplaceKg39').addClass('d-none');
					$('#sumReplaceEa39').addClass('d-none');
				}
				if ($('#replaceFaultyTable .39').text()=="") {
					$('#replaceFaultyTable .39').addClass('d-none');
					$(this).find('td').eq(122).addClass('d-none');
					$(this).find('td').eq(123).addClass('d-none');
					$(this).find('td').eq(124).addClass('d-none');
					$('#sumReplaceCount40').addClass('d-none');
					$('#sumReplaceKg40').addClass('d-none');
					$('#sumReplaceEa40').addClass('d-none');
				}
			});
		}
	});

	$('#replaceFaultyTable_length').html('');

	//생산-교체 Loss
	columnVisibleFun('replaceFaultyTable', (changeFaulty.length *3), replaceFaultyTable);
	
    $('#replaceFaultyTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#replaceFaultyTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    paymentHderCreate4();    
	$.fn.dataTable.ext.errMode = 'none';
	let troubleFaultyTable = $('#troubleFaultyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-6 col-md-7'f><'col-sm-6 col-md-5'l>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-7'i><'col-sm-12 col-md-5'>B>",
    	language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: false,
//         pageLength: 100,

		scrollX: true,
        fixedColumns: {
        	 leftColumns: 5
        },
        scrollY : "58vh",
		scrollCollapse: true,
        lengthChange: false,
        
        ajax: {
            url: '<c:url value="wm/readTroubleFaultyList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	//'faultyDateFrom' : function() { return faultyDateFrom.replace(/-/g, ''); },
            	'faultyDateTo' : function() { return faultyDateTo.replace(/-/g, ''); },
            	'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
            },
        },
		columns: [
			{
				render: function(data, type, row) {
					if(row['faultyRegDate'] == null || row['faultyRegDate'] == ''){
						return '';
					} else{
						return moment(row['faultyRegDate']).format('YYYY-MM-DD');
					}
				}
			},
			{ data: 'dayNightNm' },
			{ data: 'equipNm' },
			{ data: 'goodsNm' },
			{ data: 'alnicuMatrlNm' },
			{ data: 'count1'},
			{ data: 'kg1',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea1',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content1'},
			{ data: 'count2'},
			{ data: 'kg2',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea2',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content2'},
			{ data: 'count3'},
			{ data: 'kg3',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea3',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content3'},
			{ data: 'count4'},
			{ data: 'kg4',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea4',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content4'},
			{ data: 'count5'},
			{ data: 'kg5',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea5',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content5'},
			{ data: 'count6'},
			{ data: 'kg6',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea6',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content6'},
			{ data: 'count7'},
			{ data: 'kg7',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea7',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content7'},
			{ data: 'count8'},
			{ data: 'kg8',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea8',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content8'},
			{ data: 'count9'},
			{ data: 'kg9',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea9',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content9'},
			{ data: 'count10'},
			{ data: 'kg10',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea10',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content10'},
			{ data: 'count11'},
			{ data: 'kg11',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea11',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content11'},
			{ data: 'count12'},
			{ data: 'kg12',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea12',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content12'},
			{ data: 'count13'},
			{ data: 'kg13',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea13',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content13'},
			{ data: 'count14'},
			{ data: 'kg14',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea14',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content14'},
			{ data: 'count15'},
			{ data: 'kg15',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea15',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content15'},
			{ data: 'count16'},
			{ data: 'kg16',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea16',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content16'},
			{ data: 'count17'},
			{ data: 'kg17',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea17',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content17'},
			{ data: 'count18'},
			{ data: 'kg18',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea18',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content18'},
			{ data: 'count19'},
			{ data: 'kg19',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea19',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content19'},
			{ data: 'count20'},
			{ data: 'kg20',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
	   		 },
			{ data: 'ea20',
		   		render: function(data, type) {
		   			if(data == null || data == ''){return '';} else{ return addCommas(parseFloat(data).toFixed(0));}
		   		}
            },
            { data: 'content20'},
            
			//{ data: 'workTeamNm' },
			//{ data: 'userNm' },
		],
        columnDefs: [        	
        	{ targets: [5,6,7,9,10,11,13,14,15,17,18,19,21,22,23,25,26,27,29,30,31,33,34,35,37,38,39,41,42,43,45,46,47,49,50,51,54,55,56,58,59,60], className: 'text-right' },
        	{ targets: [62,63,64,66,67,68,70,71,72,74,75,76,78,79,80,82,83,84], className: 'text-right' },
        ],
		order: [
			[ 0, 'asc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: troubleFaultyNm,
            },
            {
                extend: 'excel',
                exportOptions: {
					columns: ':visible',
                },
                title: troubleFaultyNm,
            },
            {
                extend: 'print',
                title: troubleFaultyNm,
            }
        ],
		drawCallback:function() {
			$('#troubleFaultyTable tfoot').remove();
			
			let sumTroubleCount1	=	$('#troubleFaultyTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let sumTroubleKg1		=	$('#troubleFaultyTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			let sumTroubleEa1		=	$('#troubleFaultyTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			let sumTroubleCount2	=	$('#troubleFaultyTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			let sumTroubleKg2		=	$('#troubleFaultyTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			let sumTroubleEa2		=	$('#troubleFaultyTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			let sumTroubleCount3	=	$('#troubleFaultyTable').DataTable().column(13,{ page: 'all'} ).data().sum();
			let sumTroubleKg3		=	$('#troubleFaultyTable').DataTable().column(14,{ page: 'all'} ).data().sum();
			let sumTroubleEa3		=	$('#troubleFaultyTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			let sumTroubleCount4	=	$('#troubleFaultyTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			let sumTroubleKg4		=	$('#troubleFaultyTable').DataTable().column(18,{ page: 'all'} ).data().sum();
			let sumTroubleEa4		=	$('#troubleFaultyTable').DataTable().column(19,{ page: 'all'} ).data().sum();
			let sumTroubleCount5	=	$('#troubleFaultyTable').DataTable().column(21,{ page: 'all'} ).data().sum();
			let sumTroubleKg5		=	$('#troubleFaultyTable').DataTable().column(22,{ page: 'all'} ).data().sum();
			let sumTroubleEa5		=	$('#troubleFaultyTable').DataTable().column(23,{ page: 'all'} ).data().sum();
			let sumTroubleCount6	=	$('#troubleFaultyTable').DataTable().column(25,{ page: 'all'} ).data().sum();
			let sumTroubleKg6		=	$('#troubleFaultyTable').DataTable().column(26,{ page: 'all'} ).data().sum();
			let sumTroubleEa6		=	$('#troubleFaultyTable').DataTable().column(27,{ page: 'all'} ).data().sum();
			let sumTroubleCount7	=	$('#troubleFaultyTable').DataTable().column(29,{ page: 'all'} ).data().sum();
			let sumTroubleKg7		=	$('#troubleFaultyTable').DataTable().column(30,{ page: 'all'} ).data().sum();
			let sumTroubleEa7		=	$('#troubleFaultyTable').DataTable().column(31,{ page: 'all'} ).data().sum();
			let sumTroubleCount8	=	$('#troubleFaultyTable').DataTable().column(33,{ page: 'all'} ).data().sum();
			let sumTroubleKg8		=	$('#troubleFaultyTable').DataTable().column(34,{ page: 'all'} ).data().sum();
			let sumTroubleEa8		=	$('#troubleFaultyTable').DataTable().column(35,{ page: 'all'} ).data().sum();
			let sumTroubleCount9	=	$('#troubleFaultyTable').DataTable().column(37,{ page: 'all'} ).data().sum();
			let sumTroubleKg9		=	$('#troubleFaultyTable').DataTable().column(38,{ page: 'all'} ).data().sum();
			let sumTroubleEa9		=	$('#troubleFaultyTable').DataTable().column(39,{ page: 'all'} ).data().sum();
			let sumTroubleCount10	=	$('#troubleFaultyTable').DataTable().column(41,{ page: 'all'} ).data().sum();
			let sumTroubleKg10		=	$('#troubleFaultyTable').DataTable().column(42,{ page: 'all'} ).data().sum();
			let sumTroubleEa10		=	$('#troubleFaultyTable').DataTable().column(43,{ page: 'all'} ).data().sum();
			let sumTroubleCount11	=	$('#troubleFaultyTable').DataTable().column(45,{ page: 'all'} ).data().sum();
			let sumTroubleKg11		=	$('#troubleFaultyTable').DataTable().column(46,{ page: 'all'} ).data().sum();
			let sumTroubleEa11		=	$('#troubleFaultyTable').DataTable().column(47,{ page: 'all'} ).data().sum();
			let sumTroubleCount12	=	$('#troubleFaultyTable').DataTable().column(49,{ page: 'all'} ).data().sum();
			let sumTroubleKg12		=	$('#troubleFaultyTable').DataTable().column(50,{ page: 'all'} ).data().sum();
			let sumTroubleEa12		=	$('#troubleFaultyTable').DataTable().column(51,{ page: 'all'} ).data().sum();
			let sumTroubleCount13	=	$('#troubleFaultyTable').DataTable().column(53,{ page: 'all'} ).data().sum();
			let sumTroubleKg13		=	$('#troubleFaultyTable').DataTable().column(54,{ page: 'all'} ).data().sum();
			let sumTroubleEa13		=	$('#troubleFaultyTable').DataTable().column(55,{ page: 'all'} ).data().sum();
			let sumTroubleCount14	=	$('#troubleFaultyTable').DataTable().column(57,{ page: 'all'} ).data().sum();
			let sumTroubleKg14		=	$('#troubleFaultyTable').DataTable().column(58,{ page: 'all'} ).data().sum();
			let sumTroubleEa14		=	$('#troubleFaultyTable').DataTable().column(59,{ page: 'all'} ).data().sum();
			let sumTroubleCount15	=	$('#troubleFaultyTable').DataTable().column(61,{ page: 'all'} ).data().sum();
			let sumTroubleKg15		=	$('#troubleFaultyTable').DataTable().column(62,{ page: 'all'} ).data().sum();
			let sumTroubleEa15		=	$('#troubleFaultyTable').DataTable().column(63,{ page: 'all'} ).data().sum();
			let sumTroubleCount16	=	$('#troubleFaultyTable').DataTable().column(65,{ page: 'all'} ).data().sum();
			let sumTroubleKg16		=	$('#troubleFaultyTable').DataTable().column(66,{ page: 'all'} ).data().sum();
			let sumTroubleEa16		=	$('#troubleFaultyTable').DataTable().column(67,{ page: 'all'} ).data().sum();
			let sumTroubleCount17	=	$('#troubleFaultyTable').DataTable().column(69,{ page: 'all'} ).data().sum();
			let sumTroubleKg17		=	$('#troubleFaultyTable').DataTable().column(70,{ page: 'all'} ).data().sum();
			let sumTroubleEa17		=	$('#troubleFaultyTable').DataTable().column(71,{ page: 'all'} ).data().sum();
			let sumTroubleCount18	=	$('#troubleFaultyTable').DataTable().column(73,{ page: 'all'} ).data().sum();
			let sumTroubleKg18		=	$('#troubleFaultyTable').DataTable().column(74,{ page: 'all'} ).data().sum();
			let sumTroubleEa18		=	$('#troubleFaultyTable').DataTable().column(75,{ page: 'all'} ).data().sum();
			let sumTroubleCount19	=	$('#troubleFaultyTable').DataTable().column(77,{ page: 'all'} ).data().sum();
			let sumTroubleKg19		=	$('#troubleFaultyTable').DataTable().column(78,{ page: 'all'} ).data().sum();
			let sumTroubleEa19		=	$('#troubleFaultyTable').DataTable().column(79,{ page: 'all'} ).data().sum();
			let sumTroubleCount20	=	$('#troubleFaultyTable').DataTable().column(81,{ page: 'all'} ).data().sum();
			let sumTroubleKg20		=	$('#troubleFaultyTable').DataTable().column(82,{ page: 'all'} ).data().sum();
			let sumTroubleEa20		=	$('#troubleFaultyTable').DataTable().column(83,{ page: 'all'} ).data().sum();
			
			$('#sumTroubleKg1').text(sumTroubleKg1.toFixed(3));
			$('#sumTroubleKg2').text(sumTroubleKg2.toFixed(3));
			$('#sumTroubleKg3').text(sumTroubleKg3.toFixed(3));
			$('#sumTroubleKg4').text(sumTroubleKg4.toFixed(3));
			$('#sumTroubleKg5').text(sumTroubleKg5.toFixed(3));
			$('#sumTroubleKg6').text(sumTroubleKg6.toFixed(3));
			$('#sumTroubleKg7').text(sumTroubleKg7.toFixed(3));
			$('#sumTroubleKg8').text(sumTroubleKg8.toFixed(3));
			$('#sumTroubleKg9').text(sumTroubleKg9.toFixed(3));
			$('#sumTroubleKg10').text(sumTroubleKg10.toFixed(3));
			$('#sumTroubleKg11').text(sumTroubleKg11.toFixed(3));
			$('#sumTroubleKg12').text(sumTroubleKg12.toFixed(3));
			$('#sumTroubleKg13').text(sumTroubleKg13.toFixed(3));
			$('#sumTroubleKg14').text(sumTroubleKg14.toFixed(3));
			$('#sumTroubleKg15').text(sumTroubleKg15.toFixed(3));
			$('#sumTroubleKg16').text(sumTroubleKg16.toFixed(3));
			$('#sumTroubleKg17').text(sumTroubleKg17.toFixed(3));
			$('#sumTroubleKg18').text(sumTroubleKg18.toFixed(3));
			$('#sumTroubleKg19').text(sumTroubleKg19.toFixed(3));
			$('#sumTroubleKg20').text(sumTroubleKg20.toFixed(3));

			$('#sumTroubleEa1').text(addCommas(Math.round(sumTroubleEa1)));
			$('#sumTroubleEa2').text(addCommas(Math.round(sumTroubleEa2)));
			$('#sumTroubleEa3').text(addCommas(Math.round(sumTroubleEa3)));
			$('#sumTroubleEa4').text(addCommas(Math.round(sumTroubleEa4)));
			$('#sumTroubleEa5').text(addCommas(Math.round(sumTroubleEa5)));
			$('#sumTroubleEa6').text(addCommas(Math.round(sumTroubleEa6)));
			$('#sumTroubleEa7').text(addCommas(Math.round(sumTroubleEa7)));
			$('#sumTroubleEa8').text(addCommas(Math.round(sumTroubleEa8)));
			$('#sumTroubleEa9').text(addCommas(Math.round(sumTroubleEa9)));
			$('#sumTroubleEa10').text(addCommas(Math.round(sumTroubleEa10)));
			$('#sumTroubleEa11').text(addCommas(Math.round(sumTroubleEa11)));
			$('#sumTroubleEa12').text(addCommas(Math.round(sumTroubleEa12)));
			$('#sumTroubleEa13').text(addCommas(Math.round(sumTroubleEa13)));
			$('#sumTroubleEa14').text(addCommas(Math.round(sumTroubleEa14)));
			$('#sumTroubleEa15').text(addCommas(Math.round(sumTroubleEa15)));
			$('#sumTroubleEa16').text(addCommas(Math.round(sumTroubleEa16)));
			$('#sumTroubleEa17').text(addCommas(Math.round(sumTroubleEa17)));
			$('#sumTroubleEa18').text(addCommas(Math.round(sumTroubleEa18)));
			$('#sumTroubleEa19').text(addCommas(Math.round(sumTroubleEa19)));
			$('#sumTroubleEa20').text(addCommas(Math.round(sumTroubleEa20)));
			
			$('#sumTroubleCount1').text(sumTroubleCount1);
			$('#sumTroubleCount2').text(sumTroubleCount2);
			$('#sumTroubleCount3').text(sumTroubleCount3);
			$('#sumTroubleCount4').text(sumTroubleCount4);
			$('#sumTroubleCount5').text(sumTroubleCount5);
			$('#sumTroubleCount6').text(sumTroubleCount6);
			$('#sumTroubleCount7').text(sumTroubleCount7);
			$('#sumTroubleCount8').text(sumTroubleCount8);
			$('#sumTroubleCount9').text(sumTroubleCount9);
			$('#sumTroubleCount10').text(sumTroubleCount10);
			$('#sumTroubleCount11').text(sumTroubleCount11);
			$('#sumTroubleCount12').text(sumTroubleCount12);
			$('#sumTroubleCount13').text(sumTroubleCount13);
			$('#sumTroubleCount14').text(sumTroubleCount14);
			$('#sumTroubleCount15').text(sumTroubleCount15);
			$('#sumTroubleCount16').text(sumTroubleCount16);
			$('#sumTroubleCount17').text(sumTroubleCount17);
			$('#sumTroubleCount18').text(sumTroubleCount18);
			$('#sumTroubleCount19').text(sumTroubleCount19);
			$('#sumTroubleCount20').text(sumTroubleCount20);
			
			$('#troubleFaultyTable tbody tr td').attr("style","min-width:60px;");

		 	/*$.each($('#troubleFaultyTable tbody tr'),function(index,item) {
				if ($('#troubleFaultyTable .0').text()=="") {
					$('#troubleFaultyTable .0').addClass('d-none');
					$(this).find('td').eq(5).addClass('d-none');
					$(this).find('td').eq(6).addClass('d-none');
					$(this).find('td').eq(7).addClass('d-none');
					$(this).find('td').eq(8).addClass('d-none');
					$('#sumTroubleCount1').addClass('d-none');
					$('#sumTroubleKg1').addClass('d-none');
					$('#sumTroubleEa1').addClass('d-none');
					$('#sumTroubleContent1').addClass('d-none');
				}						
				if ($('#troubleFaultyTable .1').text()=="") {
					$('#troubleFaultyTable .1').addClass('d-none');
					$(this).find('td').eq(9).addClass('d-none');
					$(this).find('td').eq(10).addClass('d-none');
					$(this).find('td').eq(11).addClass('d-none');
					$(this).find('td').eq(12).addClass('d-none');
					$('#sumTroubleCount2').addClass('d-none');
					$('#sumTroubleKg2').addClass('d-none');
					$('#sumTroubleEa2').addClass('d-none');
					$('#sumTroubleContent2').addClass('d-none');
				}
				if ($('#troubleFaultyTable .2').text()=="") {
					$('#troubleFaultyTable .2').addClass('d-none');
					$(this).find('td').eq(13).addClass('d-none');
					$(this).find('td').eq(14).addClass('d-none');
					$(this).find('td').eq(15).addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
					$('#sumTroubleCount3').addClass('d-none');
					$('#sumTroubleKg3').addClass('d-none');
					$('#sumTroubleEa3').addClass('d-none');
					$('#sumTroubleContent3').addClass('d-none');
				}
				if ($('#troubleFaultyTable .3').text()=="") {
					$('#troubleFaultyTable .3').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
					$('#sumTroubleCount4').addClass('d-none');
					$('#sumTroubleKg4').addClass('d-none');
					$('#sumTroubleEa4').addClass('d-none');
					$('#sumTroubleContent4').addClass('d-none');
				}
				if ($('#troubleFaultyTable .4').text()=="") {
					$('#troubleFaultyTable .4').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
					$('#sumTroubleCount5').addClass('d-none');
					$('#sumTroubleKg5').addClass('d-none');
					$('#sumTroubleEa5').addClass('d-none');
					$('#sumTroubleContent5').addClass('d-none');
				}
				if ($('#troubleFaultyTable .5').text()=="") {
					$('#troubleFaultyTable .5').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
					$(this).find('td').eq(27).addClass('d-none');
					$(this).find('td').eq(28).addClass('d-none');
					$('#sumTroubleCount6').addClass('d-none');
					$('#sumTroubleKg6').addClass('d-none');
					$('#sumTroubleEa6').addClass('d-none');
					$('#sumTroubleContent6').addClass('d-none');
				}
				if ($('#troubleFaultyTable .6').text()=="") {
					$('#troubleFaultyTable .6').addClass('d-none');
					$(this).find('td').eq(29).addClass('d-none');
					$(this).find('td').eq(30).addClass('d-none');
					$(this).find('td').eq(31).addClass('d-none');
					$(this).find('td').eq(32).addClass('d-none');
					$('#sumTroubleCount7').addClass('d-none');
					$('#sumTroubleKg7').addClass('d-none');
					$('#sumTroubleEa7').addClass('d-none');
					$('#sumTroubleContent7').addClass('d-none');
				}
				if ($('#troubleFaultyTable .7').text()=="") {
					$('#troubleFaultyTable .7').addClass('d-none');
					$(this).find('td').eq(33).addClass('d-none');
					$(this).find('td').eq(34).addClass('d-none');
					$(this).find('td').eq(35).addClass('d-none');
					$(this).find('td').eq(36).addClass('d-none');
					$('#sumTroubleCount8').addClass('d-none');
					$('#sumTroubleKg8').addClass('d-none');
					$('#sumTroubleEa8').addClass('d-none');
					$('#sumTroubleContent8').addClass('d-none');
				}
				if ($('#troubleFaultyTable .8').text()=="") {
					$('#troubleFaultyTable .8').addClass('d-none');
					$(this).find('td').eq(37).addClass('d-none');
					$(this).find('td').eq(38).addClass('d-none');
					$(this).find('td').eq(39).addClass('d-none');
					$(this).find('td').eq(40).addClass('d-none');
					$('#sumTroubleCount9').addClass('d-none');
					$('#sumTroubleKg9').addClass('d-none');
					$('#sumTroubleEa9').addClass('d-none');
					$('#sumTroubleContent9').addClass('d-none');
				}
				if ($('#troubleFaultyTable .9').text()=="") {
					$('#troubleFaultyTable .9').addClass('d-none');
					$(this).find('td').eq(41).addClass('d-none');
					$(this).find('td').eq(42).addClass('d-none');
					$(this).find('td').eq(43).addClass('d-none');
					$(this).find('td').eq(44).addClass('d-none');
					$('#sumTroubleCount10').addClass('d-none');
					$('#sumTroubleKg10').addClass('d-none');
					$('#sumTroubleEa10').addClass('d-none');
					$('#sumTroubleContent10').addClass('d-none');
				}
				if ($('#troubleFaultyTable .10').text()=="") {
					$('#troubleFaultyTable .10').addClass('d-none');	
					$(this).find('td').eq(45).addClass('d-none');
					$(this).find('td').eq(46).addClass('d-none');
					$(this).find('td').eq(47).addClass('d-none');
					$(this).find('td').eq(48).addClass('d-none');
					$('#sumTroubleCount11').addClass('d-none');
					$('#sumTroubleKg11').addClass('d-none');
					$('#sumTroubleEa11').addClass('d-none');
					$('#sumTroubleContent11').addClass('d-none');
				}
				if ($('#troubleFaultyTable .11').text()=="") {
					$('#troubleFaultyTable .11').addClass('d-none');	
					$(this).find('td').eq(49).addClass('d-none');
					$(this).find('td').eq(50).addClass('d-none');	
					$(this).find('td').eq(51).addClass('d-none');
					$(this).find('td').eq(52).addClass('d-none');
					$('#sumTroubleCount12').addClass('d-none');
					$('#sumTroubleKg12').addClass('d-none');
					$('#sumTroubleEa12').addClass('d-none');
					$('#sumTroubleContent12').addClass('d-none');
				}
				if ($('#troubleFaultyTable .12').text()=="") {
					$('#troubleFaultyTable .12').addClass('d-none');	
					$(this).find('td').eq(53).addClass('d-none');
					$(this).find('td').eq(54).addClass('d-none');	
					$(this).find('td').eq(55).addClass('d-none');
					$(this).find('td').eq(56).addClass('d-none');
					$('#sumTroubleCount13').addClass('d-none');
					$('#sumTroubleKg13').addClass('d-none');
					$('#sumTroubleEa13').addClass('d-none');
					$('#sumTroubleContent13').addClass('d-none');
				}
				if ($('#troubleFaultyTable .13').text()=="") {
					$('#troubleFaultyTable .13').addClass('d-none');	
					$(this).find('td').eq(57).addClass('d-none');
					$(this).find('td').eq(58).addClass('d-none');	
					$(this).find('td').eq(59).addClass('d-none');
					$(this).find('td').eq(60).addClass('d-none');
					$('#sumTroubleCount14').addClass('d-none');
					$('#sumTroubleKg14').addClass('d-none');
					$('#sumTroubleEa14').addClass('d-none');
					$('#sumTroubleContent14').addClass('d-none');
				}
				if ($('#troubleFaultyTable .14').text()=="") {
					$('#troubleFaultyTable .14').addClass('d-none');	
					$(this).find('td').eq(61).addClass('d-none');
					$(this).find('td').eq(62).addClass('d-none');
					$(this).find('td').eq(63).addClass('d-none');
					$(this).find('td').eq(64).addClass('d-none');
					$('#sumTroubleCount15').addClass('d-none');
					$('#sumTroubleKg15').addClass('d-none');
					$('#sumTroubleEa15').addClass('d-none');
					$('#sumTroubleContent15').addClass('d-none');
				}
				if ($('#troubleFaultyTable .15').text()=="") {
					$('#troubleFaultyTable .15').addClass('d-none');
					$(this).find('td').eq(65).addClass('d-none');
					$(this).find('td').eq(66).addClass('d-none');	
					$(this).find('td').eq(67).addClass('d-none');
					$(this).find('td').eq(68).addClass('d-none');
					$('#sumTroubleCount16').addClass('d-none');
					$('#sumTroubleKg16').addClass('d-none');
					$('#sumTroubleEa16').addClass('d-none');
					$('#sumTroubleContent16').addClass('d-none');
				}
				if ($('#troubleFaultyTable .16').text()=="") {
					$('#troubleFaultyTable .16').addClass('d-none');
					$(this).find('td').eq(69).addClass('d-none');
					$(this).find('td').eq(70).addClass('d-none');
					$(this).find('td').eq(71).addClass('d-none');
					$(this).find('td').eq(72).addClass('d-none');
					$('#sumTroubleCount17').addClass('d-none');
					$('#sumTroubleKg17').addClass('d-none');
					$('#sumTroubleEa17').addClass('d-none');
					$('#sumTroubleContent17').addClass('d-none');
				}
				if ($('#troubleFaultyTable .17').text()=="") {
					$('#troubleFaultyTable .17').addClass('d-none');
					$(this).find('td').eq(73).addClass('d-none');
					$(this).find('td').eq(74).addClass('d-none');
					$(this).find('td').eq(75).addClass('d-none');
					$(this).find('td').eq(76).addClass('d-none');
					$('#sumTroubleCount18').addClass('d-none');
					$('#sumTroubleKg18').addClass('d-none');
					$('#sumTroubleEa18').addClass('d-none');
					$('#sumTroubleContent18').addClass('d-none');
				}
				if ($('#troubleFaultyTable .18').text()=="") {
					$('#troubleFaultyTable .18').addClass('d-none');
					$(this).find('td').eq(77).addClass('d-none');
					$(this).find('td').eq(78).addClass('d-none');
					$(this).find('td').eq(79).addClass('d-none');
					$(this).find('td').eq(80).addClass('d-none');
					$('#sumTroubleCount19').addClass('d-none');
					$('#sumTroubleKg19').addClass('d-none');
					$('#sumTroubleEa19').addClass('d-none');
					$('#sumTroubleContent19').addClass('d-none');
				}
				if ($('#troubleFaultyTable .19').text()=="") {
					$('#troubleFaultyTable .19').addClass('d-none');
					$(this).find('td').eq(81).addClass('d-none');
					$(this).find('td').eq(82).addClass('d-none');
					$(this).find('td').eq(83).addClass('d-none');
					$(this).find('td').eq(84).addClass('d-none');
					$('#sumTroubleCount20').addClass('d-none');
					$('#sumTroubleKg20').addClass('d-none');
					$('#sumTroubleEa20').addClass('d-none');
					$('#sumTroubleContent20').addClass('d-none');
				}
			});*/
		}
    });
	
	$('#troubleFaultyTable_length').html('');
	$('#troubleFaultyTable_paginate').addClass("float-left");

	//생산-설비 정비
	columnVisibleFun('troubleFaultyTable', (equipTroubleFaulty.length *4), troubleFaultyTable);
	
    $('#troubleFaultyTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#troubleFaultyTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
	
	function paymentHderCreate() {
	  
		var paymentHd = '<th rowspan="2" style="min-width: 100px" class="text-center">일자</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">주야</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">설비명</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 170px" class="text-center">제품</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 40px" class="text-center">재질</th>';		 
		
		$.each(processFaulty, function(index,item) {				
			paymentHd += ' <th colspan="2" style="min-width: 30px" class="text-center"><div class="'+index+'">'+item.baseCdNm+'</div></th>';			 
		});
		//paymentHd +=  '<th rowspan="2" style="min-width: 50px" class="text-center">작업조</th>';
		//paymentHd +=  '<th rowspan="2" style="min-width: 30px" class="text-center">작업자</th>';		
		var paymentHd2 ='';
		$.each(processFaulty, function(index,item) {		
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">KG</div></th>';			 
			paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+index+'">EA</div></th>';			 
		});
		 //paymentHd += '</tr>';	 	
		 $('#prcssHeader').html(paymentHd); 
		 $('#prcssHeader2').html(paymentHd2); 

		var starDecor = '';
		
		if( factoryCode == '001' || factoryCode == '002' ) {
			for(var i=0; i<56; i++){
	    		starDecor += '<th>★</th>';
			}
		} else if( factoryCode == '003' ) {
			for(var i=0; i<58; i++){
	    		starDecor += '<th>★</th>';
			}
		}
    	

    	$('#prcssHeader').append(starDecor);
		$('#prcssHeader2').append(starDecor);
	}

	function paymentHderCreate2() {
		  
		var paymentHd = '<th rowspan="2" style="min-width: 100px" class="text-center">일자</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">주야</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">설비명</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 170px" class="text-center">제품</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 40px" class="text-center">재질</th>';		 
		
		$.each(matrlFaulty, function(index,item) {				
			paymentHd += ' <th colspan="2" style="min-width: 30px" class="text-center"><div class="'+index+'">'+item.baseCdNm+'</div></th>';			 
		});
		//paymentHd +=  '<th rowspan="2" style="min-width: 50px" class="text-center">작업조</th>';
		//paymentHd +=  '<th rowspan="2" style="min-width: 30px" class="text-center">작업자</th>';		
		var paymentHd2 ='';
		$.each(matrlFaulty, function(index,item) {				
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">KG</div></th>';			 
			paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+index+'">EA</div></th>';			 
		});
		//paymentHd += '</tr>';	 	
		$('#matrlHeader').html(paymentHd); 
		$('#matrlHeader2').html(paymentHd2); 

		var starDecor = '';

    	for(var i=0; i<60; i++){
    		starDecor += '<th>★</th>';
		}

    	$('#matrlHeader').append(starDecor);
		$('#matrlHeader2').append(starDecor);
	}

	function paymentHderCreate3() {
		  
		var paymentHd = '<th rowspan="2" style="min-width: 100px" class="text-center">일자</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">주야</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">설비명</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 170px" class="text-center">제품</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 40px" class="text-center">재질</th>';		 
		
		 $.each(changeFaulty, function(index,item) {				
			 paymentHd += ' <th colspan="3" style="min-width: 30px" class="text-center"><div class="'+index+'">'+item.baseCdNm+'</div></th>';			 
		});		
		 //paymentHd +=  '<th rowspan="2" style="min-width: 50px" class="text-center">작업조</th>';
		 //paymentHd +=  '<th rowspan="2" style="min-width: 30px" class="text-center">작업자</th>';		
		 var paymentHd2 ='';
		 $.each(changeFaulty, function(index,item) {				
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">횟수</div></th>';
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">KG</div></th>';			 
			 paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+index+'">EA</div></th>';			 
		});
		 //paymentHd += '</tr>';	 	
		 $('#replaceHeader').html(paymentHd); 
		 $('#replaceHeader2').html(paymentHd2); 

		var starDecor = '';

    	if( factoryCode == '001' || factoryCode == '002' ) {
			for(var i=0; i<96; i++){
	    		starDecor += '<th>★</th>';
			}
		} else if( factoryCode == '003' ) {
			for(var i=0; i<96; i++){
	    		starDecor += '<th>★</th>';
			}
		}

    	$('#replaceHeader').append(starDecor);
		$('#replaceHeader2').append(starDecor);
	}
	
	function paymentHderCreate4() {
		  
		var paymentHd = '<th rowspan="2" style="min-width: 100px" class="text-center">일자</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">주야</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">설비명</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 170px" class="text-center">제품</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 40px" class="text-center">재질</th>';		 
		
		$.each(equipTroubleFaulty, function(index,item) {				
			paymentHd += ' <th colspan="4" style="min-width: 30px" class="text-center"><div class="'+index+'">'+item.baseCdNm+'</div></th>';			 
		});		
		//paymentHd +=  '<th rowspan="2" style="min-width: 50px" class="text-center">작업조</th>';
		//paymentHd +=  '<th rowspan="2" style="min-width: 30px" class="text-center">작업자</th>';		
		var paymentHd2 ='';
		$.each(equipTroubleFaulty, function(index,item) {				
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">횟수</div></th>';
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">KG</div></th>';			 
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">EA</div></th>';	
			paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; min-width: 100px" class="text-center"><div class="'+index+'">내용</div></th>';			 
		});
		//paymentHd += '</tr>';	 	
		$('#troubleHeader').html(paymentHd); 
		$('#troubleHeader2').html(paymentHd2); 

		var starDecor = '';
		 
		for(var i=0; i<32; i++){
    		starDecor += '<th>★</th>';
		}

    	$('#troubleHeader').append(starDecor);
		$('#troubleHeader2').append(starDecor);
	}


	
	//전체 값 합치는 코드 hder만드는 곳
	function allFaultHderCreate1() {

		let gubunRowspan = parseInt(changeFaulty.length * 3);
		
		let gubunHd = '<th rowspan="3" style="min-width: 100px" class="text-center">일자</th>';
			gubunHd +=  '<th rowspan="3" style="min-width: 90px" class="text-center">주야</th>';
			gubunHd +=  '<th rowspan="3" style="min-width: 90px" class="text-center">설비명</th>';
			gubunHd +=  '<th rowspan="3" style="min-width: 170px" class="text-center">제품</th>';
			gubunHd +=  '<th rowspan="3" style="min-width: 40px" class="text-center">재질</th>';
			gubunHd += '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+replaceFaultyNm+'</th>';

		var paymentHd ='';		 
		
		$.each(changeFaulty, function(index,item) {				
			 paymentHd += ' <th colspan="3" style="min-width: 30px" class="text-center"><div class="'+index+'">'+item.baseCdNm+'</div></th>';
		});
			
		//paymentHd +=  '<th rowspan="2" style="min-width: 50px" class="text-center">작업조</th>';
		//paymentHd +=  '<th rowspan="2" style="min-width: 30px" class="text-center">작업자</th>';		
		var paymentHd2 ='';
		$.each(changeFaulty, function(index,item) {				
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">횟수</div></th>';
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">KG</div></th>';			 
			paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+index+'">EA</div></th>';			 
		});
		//paymentHd += '</tr>';
		$('#gubunHeader').append(gubunHd);
		$('#allFaultHeader').append(paymentHd); 
		$('#allFaultHeader2').append(paymentHd2); 
	}
	
	function allFaultHderCreate2() {

		let gubunRowspan = parseInt(processFaulty.length * 2);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+processFaultyNm+'</th>';
		/*var paymentHd = '<th rowspan="2" style="min-width: 100px" class="text-center">일자</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">주야</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">설비명</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 170px" class="text-center">제품</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 40px" class="text-center">재질</th>';*/
		var paymentHd ='';
		
		 $.each(processFaulty, function(index,item) {				
			 paymentHd += ' <th colspan="2" style="min-width: 30px" class="text-center"><div class="'+parseInt(50 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});
		 //paymentHd +=  '<th rowspan="2" style="min-width: 50px" class="text-center">작업조</th>';
		 //paymentHd +=  '<th rowspan="2" style="min-width: 30px" class="text-center">작업자</th>';		
		 var paymentHd2 ='';
		 $.each(processFaulty, function(index,item) {		
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(50 + index)+'">KG</div></th>';			 
			 paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+parseInt(50 + index)+'">EA</div></th>';			 
		});
		 //paymentHd += '</tr>';
		 $('#gubunHeader').append(gubunHd); 	
		 $('#allFaultHeader').append(paymentHd); 
		 $('#allFaultHeader2').append(paymentHd2); 
	}

	function allFaultHderCreate3() {
		
		let gubunRowspan = parseInt(matrlFaulty.length * 2);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+matrlFaultyNm+'</th>';  
		/*var paymentHd = '<th rowspan="2" style="min-width: 100px" class="text-center">일자</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">주야</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">설비명</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 170px" class="text-center">제품</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 40px" class="text-center">재질</th>'; */
			
		var paymentHd ='';
		
		 $.each(matrlFaulty, function(index,item) {				
			 paymentHd += ' <th colspan="2" style="min-width: 30px" class="text-center"><div class="'+parseInt(100 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});
		 //paymentHd +=  '<th rowspan="2" style="min-width: 50px" class="text-center">작업조</th>';
		 //paymentHd +=  '<th rowspan="2" style="min-width: 30px" class="text-center">작업자</th>';		
		 var paymentHd2 ='';
		 $.each(matrlFaulty, function(index,item) {				
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(100 + index)+'">KG</div></th>';			 
			 paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+parseInt(100 + index)+'">EA</div></th>';			 
		});
		 //paymentHd += '</tr>';
		  $('#gubunHeader').append(gubunHd);
		 $('#allFaultHeader').append(paymentHd); 
		 $('#allFaultHeader2').append(paymentHd2); 
	}

	function allFaultHderCreate4() {

		let gubunRowspan = parseInt(equipTroubleFaulty.length * 4);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+troubleFaultyNm+'</th>';
		
		/*var paymentHd = '<th rowspan="2" style="min-width: 100px" class="text-center">일자</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">주야</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 90px" class="text-center">설비명</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 170px" class="text-center">제품</th>';
			paymentHd +=  '<th rowspan="2" style="min-width: 40px" class="text-center">재질</th>';*/

		var paymentHd =''; 
		
		 $.each(equipTroubleFaulty, function(index,item) {				
			 paymentHd += ' <th colspan="4" style="min-width: 30px" class="text-center"><div class="'+parseInt(150 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});		
		 //paymentHd +=  '<th rowspan="2" style="min-width: 50px" class="text-center">작업조</th>';
		 //paymentHd +=  '<th rowspan="2" style="min-width: 30px" class="text-center">작업자</th>';		
		 var paymentHd2 ='';
		 $.each(equipTroubleFaulty, function(index,item) {				
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(150 + index)+'">횟수</div></th>';
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(150 + index)+'">KG</div></th>';			 
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(150 + index)+'">EA</div></th>';	
			 paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; min-width: 250px;" class="text-center"><div class="'+parseInt(150 + index)+'">내용</div></th>';			 
		});
		 //paymentHd += '</tr>';
		 $('#gubunHeader').append(gubunHd);
		 $('#allFaultHeader').append(paymentHd); 
		 $('#allFaultHeader2').append(paymentHd2); 
	}
	
	//전체 값 합치는 코드 hder만드는 끝

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let faultyQtyTable = $('#faultyQtyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>B",  
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        scrollY : "60vh",
        scrollCollapse: true,
        lengthChange: false,
        pageLength: -1,
        ajax: {
            url: '<c:url value="/wm/readFaultyQty"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
            	'faultyDateTo'	:	function() { return faultyDateTo.replace(/-/g, ''); },
            	'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
            },
        },
        //rowId: 'workOrdNo',
        columns: [
        	{ data: 'ordDate',
				render: function(data, type, row) {
					if(data == null || data == ''){
						return '';
					} else{
						return moment(data).format('YYYY-MM-DD');
					}
					
				}
			},
			{ data: 'ordGubun',
	    		render: function(data, type, row, meta) {	
	    			if(data == "D") {
	    				return "주간";
	    			} else if(data == "N") {
						return "야간";
	    			} else {
	    				return "주야 통합";
		    		}
	    		}
	    	},
        	{ data: 'equipNm' },		//설비명
        	{ data: 'goodsNm' },		//제품명
        	{ data: 'qutyNm' },			//재질
        	{ data: 'mainFaultyQty' },
        	{ data: 'subFaultyQty' },
        	{ data: 'workTeamNm' },
        	{ data: 'userNm' },
        ],
        columnDefs: [
        	//{ targets: [5,6], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [5,6], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '권취중량',
            },
            {
                extend: 'excel',
                title: '권취중량',
            },
            {
                extend: 'print',
                title: '권취중량',
            },
        ],
        drawCallback:function() {
        	$('#faultyQtyTable tfoot').remove();
			let mainFaultyQtySum	=	$('#faultyQtyTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let subFaultyQtySum		=	$('#faultyQtyTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			$('#mainFaultyQtySum').text(mainFaultyQtySum.toFixed(3));
			$('#subFaultyQtySum').text(subFaultyQtySum.toFixed(3));
// 			$('#faultyQtyTable_wrapper table thead tr th').eq(0).click();
		}
    });

    $('#faultyQtyTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#faultyQtyTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

	$('#prcssFaultyTable_filter').eq(0).find('input[type=search]').attr('id', 'pageSerch2');
	$("#pageSerch2").insertAfter("#searchLabel");
	$('#prcssFaultyTable_filter').eq(0).find('label').remove();

	$('#matrlFaultyTable_filter').eq(0).find('input[type=search]').attr('id', 'pageSerch3');
	$("#pageSerch3").insertAfter("#searchLabel");
	$('#matrlFaultyTable_filter').eq(0).find('label').remove();
	
	$('#replaceFaultyTable_filter').eq(0).find('input[type=search]').attr('id', 'pageSerch4');
	$("#pageSerch4").insertAfter("#searchLabel");
	$('#replaceFaultyTable_filter').eq(0).find('label').remove();
	
	$('#troubleFaultyTable_filter').eq(0).find('input[type=search]').attr('id', 'pageSerch5');
	$("#pageSerch5").insertAfter("#searchLabel");
	$('#troubleFaultyTable_filter').eq(0).find('label').remove();
    
    $('#faultyQtyTable_filter').eq(0).find('input[type=search]').attr('id', 'pageSerch6');
	$("#pageSerch6").insertAfter("#searchLabel");
	$('#faultyQtyTable_filter').eq(0).find('label').remove();

	$('#pageSerch2').addClass('d-none');
	$('#pageSerch3').addClass('d-none');
	$('#pageSerch4').addClass('d-none');
	$('#pageSerch5').addClass('d-none');
	$('#pageSerch6').addClass('d-none');
	
	/*allFaultTable.on('draw.dt', function(){
		$('#my-spinner').hide();
	});*/

	prcssFaultyTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		prcssFaultyTable.columns.adjust();
	});

	matrlFaultyTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		matrlFaultyTable.columns.adjust();
	});

	replaceFaultyTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		replaceFaultyTable.columns.adjust();
	});
	
	troubleFaultyTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		troubleFaultyTable.columns.adjust();
	});

	faultyQtyTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		faultyQtyTable.columns.adjust();
	});


	//colspan 배열에 담기
	function colspanGroupArray( tableName, row, tDivision, trSize, notExistColspanValue, ghostYn){
	 	//tableName: 테이블 명
	 	//row: 계산하고자 하는  행(0번 부터)
	 	//tDivision: th or td 선택자
	 	//trSize: 계산하고자하는 행 크기
	 	//notExistColspanValue: 계산하고자 하는 행에 calspan이 존재하지 않는 컬럼 개수(앞에서 값으로만 판단, 중간 값은 사용 못함)
	 	//ghostYn: rowspan으로 합쳐진 값이 존재하는지 여부( Y, N ) / 추가로 empty는 colspan, rowspan없이 쭉 이어진 값 

	 	let dt;
	 	let temporaryArray = new Array();
	 	let exceptionArray = new Array();	//empty에서만 사용
  		let temporaryObj = new Object();
    	let temporaryColspanSum = 0; 
	 	
	 	if( ghostYn == 'Y'){
	 		for(var i = 0; i < trSize; i++) {
	 			dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq(i);
		   	    temporaryObj = new Object();
		   	    if( i < notExistColspanValue ){
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = i;
		   	        colspanSum = i;
		   	    } else {
		   	        if( i == notExistColspanValue ) {
		   	            colspanSum += 1;
		   	        }
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = colspanSum;
		   	        colspanSum += parseInt(  dt.attr('colspan') );
		   	    }
		   	 temporaryArray.push(temporaryObj);
		   	}
	 		return temporaryArray;
		} else if( ghostYn == 'N' ) {
			for(var i=0; i < ( trSize + notExistColspanValue ); i++) {
	 			dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( (i-notExistColspanValue)  );
		   	    temporaryObj = new Object();
		   	    if( i < notExistColspanValue ){
		   	        temporaryObj.name = '';
		   	        temporaryObj.colspan = i;
		   	        colspanSum = i;
		   	    } else {
		   	        if( i == notExistColspanValue ) {
		   	            colspanSum += 1;
		   	        }
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = colspanSum;
		   	        colspanSum += parseInt(  dt.attr('colspan') );
		   	    }
		   	 temporaryArray.push(temporaryObj);
		   	}
			return temporaryArray;
		} else if( ghostYn == 'empty' ) {
			for(var i=0; i < ( trSize + notExistColspanValue ); i++) {
				dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( (i-notExistColspanValue)  );
				if( i < notExistColspanValue ){
					exceptionArray[i] = '';
			    } else {
			    	exceptionArray[i] = dt.text();
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
    
</script>
</body>
</html>
