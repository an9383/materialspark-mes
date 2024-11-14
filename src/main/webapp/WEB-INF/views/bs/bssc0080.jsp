<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%pageContext.setAttribute("newLineChar", "\n");%>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">판매계획 등록</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<div class="card"  style="margin-bottom:0px;">
					
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">판매계획등록</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">분기별 판매계획대비 실적</a></li>			
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">월별 판매계획대비 실적</a></li>	
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">년도별 판매계획대비 실적 (수량)</a></li>	
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab5">년도별 판매계획대비 실적 (금액)</a></li>		
						</ul>
					</div>
					<br>
				<!-- .table-responsive -->
				<div id="View1">
					<div class="table-responsive">
					   <div class="row">
						  <div class="row col-sm-6" style="margin-bottom:5px;">
								&nbsp;<label class="input-label-sm">계획 년</label>
								<select class="custom-select" id="planYear" style="width:105px;"></select>
								&nbsp;<label class="input-label-sm">거래처</label>
								<div class="input-sub m-0">
	                            	<input type="text" class="form-control" id="dealCorpNm"  name="dealCorpNm" disabled>
	                            	<button type="button" class="btn btn-primary input-sub-search" id="btnSelDeal" onClick="selectDealCorp()">
								          <span class="oi oi-magnifying-glass"></span>
							        </button>
						        </div> 
						        <input type="hidden" class="form-control" id="dealCorpCd"  name="dealCorpCd">						
								&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv">조회</button>
							</div>
							<div class="col-sm-6" style="margin-bottom:5px;">
								<button type="button" class="btn btn-primary mr-1 float-right" id="btnSave" disabled>저장</button>
								<button type="button" class="btn btn-primary mr-1 float-right" id="btnEdit">수정</button>
							</div>
						</div>
						<table id="salesPlanInfoTable" class="table table-bordered">			
						<thead class="thead-light">
							<tr>
								<th rowspan="2" style="min-width:100px; vertical-align:middle;">고객사코드</th>
								<th rowspan="2" style="min-width:100px; vertical-align:middle;">고객사</th>
								<th rowspan="2" style="min-width:100px; vertical-align:middle;">기종코드</th>
								<th rowspan="2" style="min-width:100px; vertical-align:middle;">기종</th>
								<th colspan="2">총계</th>
								<th colspan="2">1월</th>
								<th colspan="2">2월</th>
								<th colspan="2">3월</th>
								<th colspan="2">4월</th>
								<th colspan="2">5월</th>
								<th colspan="2">6월</th>
								<th colspan="2">7월</th>
								<th colspan="2">8월</th>
								<th colspan="2">9월</th>
								<th colspan="2">10월</th>
								<th colspan="2">11월</th>
								<th colspan="2">12월</th>								
							</tr>
							<tr>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>		
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>		
								<th style="min-width:100px;">수량</th>
								<th style="min-width:100px;">금액</th>						
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="4" style="text-align: center">합계</td>
								<td colspan="" id="sumTotalCnt" style="text-align: right">0</td>
								<td colspan="" id="sumTotalCost" style="text-align: right">0</td>
								<td colspan="" id="sumJanCnt" style="text-align: right">0</td>
								<td colspan="" id="sumJanCost" style="text-align: right">0</td>
								<td colspan="" id="sumFebCnt" style="text-align: right">0</td>
								<td colspan="" id="sumFebCost" style="text-align: right">0</td>
								<td colspan="" id="sumMarCnt" style="text-align: right">0</td>
								<td colspan="" id="sumMarCost" style="text-align: right">0</td>
								<td colspan="" id="sumAprCnt" style="text-align: right">0</td>
								<td colspan="" id="sumAprCost" style="text-align: right">0</td>
								<td colspan="" id="sumMayCnt" style="text-align: right">0</td>
								<td colspan="" id="sumMayCost" style="text-align: right">0</td>
								<td colspan="" id="sumJunCnt" style="text-align: right">0</td>
								<td colspan="" id="sumJunCost" style="text-align: right">0</td>
								<td colspan="" id="sumJulCnt" style="text-align: right">0</td>
								<td colspan="" id="sumJulCost" style="text-align: right">0</td>
								<td colspan="" id="sumAugCnt" style="text-align: right">0</td>
								<td colspan="" id="sumAugCost" style="text-align: right">0</td>
								<td colspan="" id="sumSepCnt" style="text-align: right">0</td>
								<td colspan="" id="sumSepCost" style="text-align: right">0</td>
								<td colspan="" id="sumOctCnt" style="text-align: right">0</td>
								<td colspan="" id="sumOctCost" style="text-align: right">0</td>
								<td colspan="" id="sumNovCnt" style="text-align: right">0</td>
								<td colspan="" id="sumNovCost" style="text-align: right">0</td>
								<td colspan="" id="sumDecCnt" style="text-align: right">0</td>
								<td colspan="" id="sumDecCost" style="text-align: right">0</td>
								
								
							</tr>
						</tfoot>
					</table>
					</div>
				</div>
				<div id="View2" class="d-none">
					<div class="table-responsive">
					 <div class="row">
						  <div class="row col-sm-6" style="margin-bottom:5px;">
								&nbsp;<label class="input-label-sm">계획 년</label>
								<select class="custom-select" id="planYear2" style="width:105px;"></select>	
								&nbsp; &nbsp;<label class="input-label-sm">분기선택</label>		
								 &nbsp;<select class="custom-select" id="quarter" style="width:105px;">
									<option value="0">전체</option>
									<option value = "1">1분기</option>
									<option value = "2">2분기</option>
									<option value = "3">3분기</option>
									<option value = "4">4분기</option>
								</select>			
								&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv2">조회</button>					
						        </div> 						       				
								
							</div>						
						</div>
						<table id="salesPlanInfoTable2" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th rowspan="3" style="min-width:100px; vertical-align:middle;" >고객사</th>
									<th rowspan="3" style="min-width:100px; vertical-align:middle;">기종</th>
									<th colspan="6">1분기</th>
									<th colspan="6">2분기</th>
									<th colspan="6">3분기</th>									
									<th colspan="6">4분기</th>									
								</tr>
								<tr>									
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>	
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>	
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>		
								</tr>
								<tr>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="2" style="text-align: center">합계</td>
									<td colspan="" id="sum1" style="text-align: right">0</td>									
									<td colspan="" id="sum2" style="text-align: right">0</td>
									<td colspan="" id="sum3" style="text-align: right">0</td>
									<td colspan="" id="sum4" style="text-align: right">0</td>
									<td colspan="" id="sum5" style="text-align: right">0</td>
									<td colspan="" id="sum6" style="text-align: right">0</td>
									<td colspan="" id="sum7" style="text-align: right">0</td>
									<td colspan="" id="sum8" style="text-align: right">0</td>
									<td colspan="" id="sum9" style="text-align: right">0</td>
									<td colspan="" id="sum10" style="text-align: right">0</td>
									<td colspan="" id="sum11" style="text-align: right">0</td>
									<td colspan="" id="sum12" style="text-align: right">0</td>
									<td colspan="" id="sum13" style="text-align: right">0</td>
									<td colspan="" id="sum14" style="text-align: right">0</td>
									<td colspan="" id="sum15" style="text-align: right">0</td>
									<td colspan="" id="sum16" style="text-align: right">0</td>
									<td colspan="" id="sum17" style="text-align: right">0</td>
									<td colspan="" id="sum18" style="text-align: right">0</td>
									<td colspan="" id="sum19" style="text-align: right">0</td>
									<td colspan="" id="sum20" style="text-align: right">0</td>
									<td colspan="" id="sum21" style="text-align: right">0</td>
									<td colspan="" id="sum22" style="text-align: right">0</td>
									<td colspan="" id="sum23" style="text-align: right">0</td>
									<td colspan="" id="sum24" style="text-align: right">0</td>
									
								</tr>
							</tfoot>
						</table>
					</div>
					<div id="View3" class="d-none">
					<div class="table-responsive">
					 <div class="row">
						  <div class="row col-sm-6" style="margin-bottom:5px;">
								&nbsp;<label class="input-label-sm">계획 년</label>
								<select class="custom-select" id="planYear3" style="width:105px;"></select>									
								&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv3">조회</button>					
						        </div> 						       				
								
							</div>						
						</div>
						<table id="salesPlanInfoTable3" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th rowspan="3" style="min-width:100px; vertical-align:middle;" >고객사</th>
									<th rowspan="3" style="min-width:100px; vertical-align:middle;">기종</th>
									<th colspan="6">1월</th>
									<th colspan="6">2월</th>
									<th colspan="6">3월</th>									
									<th colspan="6">4월</th>		
									<th colspan="6">5월</th>
									<th colspan="6">6월</th>
									<th colspan="6">7월</th>									
									<th colspan="6">8월</th>
									<th colspan="6">9월</th>
									<th colspan="6">10월</th>
									<th colspan="6">11월</th>									
									<th colspan="6">12월</th>							
								</tr>
								<tr>									
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>	
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>	
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>	
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>	
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>		
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>	
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>	
									<th colspan="2">계획</th>
									<th colspan="2">실적</th>
									<th colspan="2">달성율(%)</th>				
								</tr>
								<tr>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
									<th style="min-width:100px;">수량</th>
									<th style="min-width:100px;">금액</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="2" style="text-align: center">합계</td>
									<td colspan="" id="monthSum1" style="text-align: right">0</td>									
									<td colspan="" id="monthSum2" style="text-align: right">0</td>
									<td colspan="" id="monthSum3" style="text-align: right">0</td>
									<td colspan="" id="monthSum4" style="text-align: right">0</td>
									<td colspan="" id="monthSum5" style="text-align: right">0</td>
									<td colspan="" id="monthSum6" style="text-align: right">0</td>
									<td colspan="" id="monthSum7" style="text-align: right">0</td>
									<td colspan="" id="monthSum8" style="text-align: right">0</td>
									<td colspan="" id="monthSum9" style="text-align: right">0</td>
									<td colspan="" id="monthSum10" style="text-align: right">0</td>
									<td colspan="" id="monthSum11" style="text-align: right">0</td>
									<td colspan="" id="monthSum12" style="text-align: right">0</td>
									<td colspan="" id="monthSum13" style="text-align: right">0</td>
									<td colspan="" id="monthSum14" style="text-align: right">0</td>
									<td colspan="" id="monthSum15" style="text-align: right">0</td>
									<td colspan="" id="monthSum16" style="text-align: right">0</td>
									<td colspan="" id="monthSum17" style="text-align: right">0</td>
									<td colspan="" id="monthSum18" style="text-align: right">0</td>
									<td colspan="" id="monthSum19" style="text-align: right">0</td>
									<td colspan="" id="monthSum20" style="text-align: right">0</td>
									<td colspan="" id="monthSum21" style="text-align: right">0</td>
									<td colspan="" id="monthSum22" style="text-align: right">0</td>
									<td colspan="" id="monthSum23" style="text-align: right">0</td>
									<td colspan="" id="monthSum24" style="text-align: right">0</td>
									<td colspan="" id="monthSum25" style="text-align: right">0</td>									
									<td colspan="" id="monthSum26" style="text-align: right">0</td>
									<td colspan="" id="monthSum27" style="text-align: right">0</td>
									<td colspan="" id="monthSum28" style="text-align: right">0</td>
									<td colspan="" id="monthSum29" style="text-align: right">0</td>
									<td colspan="" id="monthSum30" style="text-align: right">0</td>
									<td colspan="" id="monthSum31" style="text-align: right">0</td>
									<td colspan="" id="monthSum32" style="text-align: right">0</td>
									<td colspan="" id="monthSum33" style="text-align: right">0</td>
									<td colspan="" id="monthSum34" style="text-align: right">0</td>
									<td colspan="" id="monthSum35" style="text-align: right">0</td>
									<td colspan="" id="monthSum36" style="text-align: right">0</td>
									<td colspan="" id="monthSum37" style="text-align: right">0</td>
									<td colspan="" id="monthSum38" style="text-align: right">0</td>
									<td colspan="" id="monthSum39" style="text-align: right">0</td>
									<td colspan="" id="monthSum40" style="text-align: right">0</td>
									<td colspan="" id="monthSum41" style="text-align: right">0</td>
									<td colspan="" id="monthSum42" style="text-align: right">0</td>
									<td colspan="" id="monthSum43" style="text-align: right">0</td>
									<td colspan="" id="monthSum44" style="text-align: right">0</td>
									<td colspan="" id="monthSum45" style="text-align: right">0</td>
									<td colspan="" id="monthSum46" style="text-align: right">0</td>
									<td colspan="" id="monthSum47" style="text-align: right">0</td>
									<td colspan="" id="monthSum48" style="text-align: right">0</td>
									<td colspan="" id="monthSum49" style="text-align: right">0</td>									
									<td colspan="" id="monthSum50" style="text-align: right">0</td>
									<td colspan="" id="monthSum51" style="text-align: right">0</td>
									<td colspan="" id="monthSum52" style="text-align: right">0</td>
									<td colspan="" id="monthSum53" style="text-align: right">0</td>
									<td colspan="" id="monthSum54" style="text-align: right">0</td>
									<td colspan="" id="monthSum55" style="text-align: right">0</td>
									<td colspan="" id="monthSum56" style="text-align: right">0</td>
									<td colspan="" id="monthSum57" style="text-align: right">0</td>
									<td colspan="" id="monthSum58" style="text-align: right">0</td>
									<td colspan="" id="monthSum59" style="text-align: right">0</td>
									<td colspan="" id="monthSum60" style="text-align: right">0</td>
									<td colspan="" id="monthSum61" style="text-align: right">0</td>
									<td colspan="" id="monthSum62" style="text-align: right">0</td>
									<td colspan="" id="monthSum63" style="text-align: right">0</td>
									<td colspan="" id="monthSum64" style="text-align: right">0</td>
									<td colspan="" id="monthSum65" style="text-align: right">0</td>
									<td colspan="" id="monthSum66" style="text-align: right">0</td>
									<td colspan="" id="monthSum67" style="text-align: right">0</td>
									<td colspan="" id="monthSum68" style="text-align: right">0</td>
									<td colspan="" id="monthSum69" style="text-align: right">0</td>
									<td colspan="" id="monthSum70" style="text-align: right">0</td>
									<td colspan="" id="monthSum71" style="text-align: right">0</td>
									<td colspan="" id="monthSum72" style="text-align: right">0</td>
									
								</tr>
							</tfoot>
						</table>
					</div>
					<div id="View4" class="d-none">
					<div class="table-responsive">
					 <div class="row">
						  <div class="row col-sm-6" style="margin-bottom:5px;">
								&nbsp;<label class="input-label-sm">계획 년</label>
								<select class="custom-select" id="planYear4" style="width:105px;"></select>	
										
								&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv4">조회</button>					
						        </div> 						       				
								
							</div>						
						</div>
						<table id="salesPlanInfoTable4" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th style="min-width:100px; vertical-align:middle;" >고객사</th>
									<th style="min-width:100px; vertical-align:middle;">기종</th>
									<th style="min-width:100px; vertical-align:middle;">구분</th>
									<th style="min-width:100px;" >1월</th>
									<th style="min-width:100px;" >2월</th>
									<th style="min-width:100px;" >3월</th>									
									<th style="min-width:100px;" >4월</th>		
									<th style="min-width:100px;" >5월</th>
									<th style="min-width:100px;" >6월</th>
									<th style="min-width:100px;" >7월</th>									
									<th style="min-width:100px;" >8월</th>
									<th style="min-width:100px;" >9월</th>
									<th style="min-width:100px;" >10월</th>
									<th style="min-width:100px;" >11월</th>									
									<th style="min-width:100px;" >12월</th>		
									<th style="min-width:100px;" >누적 합계</th>							
								</tr>								
								
							</thead>
							<tfoot>
								<tr>
									<td colspan="2" rowspan="3" style="text-align: center">합계</td>
									<td colspan="" style="text-align: center">사업 계획</td>
									
									<td colspan="" id="totalSum11" style="text-align: right">0</td>									
									<td colspan="" id="totalSum12" style="text-align: right">0</td>
									<td colspan="" id="totalSum13" style="text-align: right">0</td>
									<td colspan="" id="totalSum14" style="text-align: right">0</td>
									<td colspan="" id="totalSum15" style="text-align: right">0</td>
									<td colspan="" id="totalSum16" style="text-align: right">0</td>
									<td colspan="" id="totalSum17" style="text-align: right">0</td>
									<td colspan="" id="totalSum18" style="text-align: right">0</td>
									<td colspan="" id="totalSum19" style="text-align: right">0</td>
									<td colspan="" id="totalSum110" style="text-align: right">0</td>
									<td colspan="" id="totalSum111" style="text-align: right">0</td>
									<td colspan="" id="totalSum112" style="text-align: right">0</td>
									<td colspan="" id="totalSum113" style="text-align: right">0</td>						
									
								</tr>
								<tr>					
									<td colspan="" style="text-align: center">실적</td>				
									<td colspan="" id="totalSum21" style="text-align: right">0</td>									
									<td colspan="" id="totalSum22" style="text-align: right">0</td>
									<td colspan="" id="totalSum23" style="text-align: right">0</td>
									<td colspan="" id="totalSum24" style="text-align: right">0</td>
									<td colspan="" id="totalSum25" style="text-align: right">0</td>
									<td colspan="" id="totalSum26" style="text-align: right">0</td>
									<td colspan="" id="totalSum27" style="text-align: right">0</td>
									<td colspan="" id="totalSum28" style="text-align: right">0</td>
									<td colspan="" id="totalSum29" style="text-align: right">0</td>
									<td colspan="" id="totalSum210" style="text-align: right">0</td>
									<td colspan="" id="totalSum211" style="text-align: right">0</td>
									<td colspan="" id="totalSum212" style="text-align: right">0</td>
									<td colspan="" id="totalSum213" style="text-align: right">0</td>						
									
								</tr>
								<tr>		
									<td colspan="" style="text-align: center">달성율</td>							
									<td colspan="" id="totalSum31" style="text-align: right">0</td>									
									<td colspan="" id="totalSum32" style="text-align: right">0</td>
									<td colspan="" id="totalSum33" style="text-align: right">0</td>
									<td colspan="" id="totalSum34" style="text-align: right">0</td>
									<td colspan="" id="totalSum35" style="text-align: right">0</td>
									<td colspan="" id="totalSum36" style="text-align: right">0</td>
									<td colspan="" id="totalSum37" style="text-align: right">0</td>
									<td colspan="" id="totalSum38" style="text-align: right">0</td>
									<td colspan="" id="totalSum39" style="text-align: right">0</td>
									<td colspan="" id="totalSum310" style="text-align: right">0</td>
									<td colspan="" id="totalSum311" style="text-align: right">0</td>
									<td colspan="" id="totalSum312" style="text-align: right">0</td>
									<td colspan="" id="totalSum313" style="text-align: right">0</td>		
								</tr>
							</tfoot>
						</table>
					</div>
					<div id="View5" class="d-none">
					<div class="table-responsive">
					 <div class="row">
						  <div class="row col-sm-6" style="margin-bottom:5px;">
								&nbsp;<label class="input-label-sm">계획 년</label>
								<select class="custom-select" id="planYear5" style="width:105px;"></select>	
										
								&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv5">조회</button>					
						        </div> 						       				
								
							</div>						
						</div>
						<table id="salesPlanInfoTable5" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th style="min-width:100px; vertical-align:middle;" >고객사</th>
									<th style="min-width:100px; vertical-align:middle;">기종</th>
									<th style="min-width:100px; vertical-align:middle;">구분</th>
									<th style="min-width:100px;" >1월</th>
									<th style="min-width:100px;" >2월</th>
									<th style="min-width:100px;" >3월</th>									
									<th style="min-width:100px;" >4월</th>		
									<th style="min-width:100px;" >5월</th>
									<th style="min-width:100px;" >6월</th>
									<th style="min-width:100px;" >7월</th>									
									<th style="min-width:100px;" >8월</th>
									<th style="min-width:100px;" >9월</th>
									<th style="min-width:100px;" >10월</th>
									<th style="min-width:100px;" >11월</th>									
									<th style="min-width:100px;" >12월</th>		
									<th style="min-width:100px;" >누적 합계</th>							
								</tr>								
								
							</thead>
							<tfoot>
								<tr>
									<td colspan="2" rowspan="3" style="text-align: center">합계</td>
									<td colspan="" style="text-align: center">사업 계획</td>
									
									<td colspan="" id="totalCostSum11" style="text-align: right">0</td>									
									<td colspan="" id="totalCostSum12" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum13" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum14" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum15" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum16" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum17" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum18" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum19" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum110" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum111" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum112" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum113" style="text-align: right">0</td>						
									
								</tr>
								<tr>					
									<td colspan="" style="text-align: center">실적</td>				
									<td colspan="" id="totalCostSum21" style="text-align: right">0</td>									
									<td colspan="" id="totalCostSum22" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum23" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum24" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum25" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum26" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum27" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum28" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum29" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum210" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum211" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum212" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum213" style="text-align: right">0</td>						
									
								</tr>
								<tr>		
									<td colspan="" style="text-align: center">달성율</td>							
									<td colspan="" id="totalCostSum31" style="text-align: right">0</td>									
									<td colspan="" id="totalCostSum32" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum33" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum34" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum35" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum36" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum37" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum38" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum39" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum310" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum311" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum312" style="text-align: right">0</td>
									<td colspan="" id="totalCostSum313" style="text-align: right">0</td>		
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<!-- /.table-responsive -->
			</div>
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'bssc0080';
	let currentHref = 'bssc0080';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","판매계획 등록");
    let viewIdx;
    let sideView = 'add';

	var planYear = '';
	var planYear2 = '';
	var planYear3 = '';
	var planYear4 = '';
	var planYear5 = '';
	var dealCorpCd = '';

	var order1 = new Array();
	var order2 = new Array();
	var order3 = new Array();

	var orderCost1 = new Array();
	var orderCost2 = new Array();
	var orderCost3 = new Array();

	for (var i = 0; i < 13; i++) {
		order1[i] = 0;
		order2[i] = 0;
		order3[i] = 0;

		orderCost1[i] = 0;
		orderCost2[i] = 0;
		orderCost3[i] = 0;
	} 
	setDateBox();
	
	//공통코드 시작
    var poGubunCode=new Array();
    <c:forEach items="${poGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		poGubunCode.push(json);
    </c:forEach>
  	//공통코드 종료
	
    // 목록
	$.fn.dataTable.ext.errMode = 'none';
	let salesPlanInfoTable = $('#salesPlanInfoTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
	        ordering: false,
	        processing: true,
	        autoWidth: false,
	        scrollX : false,
	        pageLength: false,
	        searching: false,

        
		ajax: {
            url: '<c:url value="/bs/salesPlanAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'		:		menuAuth,
	           	'dealCorpCd'	:		function() { return $('#dealCorpCd').val(); },
	           	'dealCorpNm'	:		function() { return $('#dealCorpNm').val(); },
	           	'planYear'		:		function() { return planYear; },	         
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'rowId',
        columns: [
            { data: 'dealCorpCd' },
            { data: 'dealCorpNm' },
            { data: 'gijongCd' },
            { data: 'gijongNm' },
            { data: 'totalCnt',
                render: function(data, type, row) {
                	if( row['gubun'] == "001" ){
						return '0'
					} else {					
						return addCommas(data);
					}
				}
			},
            { data: 'totalCost',
				render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '0'
					} else {						
						return addCommas(data);
					}
				}
			
			},          
            { data: 'janCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "janCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "janCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
            },
            { data: 'janCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "janCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "janCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
            },
            { data: 'febCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "febCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "febCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
            },
            { data: 'febCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "febCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "febCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
            },
            { data: 'marCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "marCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "marCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
            },
            { data: 'marCost' ,
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "marCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "marCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
            { data: 'aprCnt' ,
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "aprCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "aprCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},                        
            { data: 'aprCost' ,
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "aprCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "aprCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
            { data: 'mayCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "mayCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "mayCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},      
			{ data: 'mayCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "mayCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "mayCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
			{ data: 'junCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "junCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "junCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},      
			{ data: 'junCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "junCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "junCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
		  	{ data: 'julCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "julCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "julCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},      
			{ data: 'julCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "julCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "julCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
			{ data: 'augCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "augCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "augCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},       
			{ data: 'augCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "augCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "augCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
			{ data: 'sepCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "sepCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "sepCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},      
			{ data: 'sepCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "sepCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "sepCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
			{ data: 'octCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "octCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "octCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},      
			{ data: 'octCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "octCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "octCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
			{ data: 'novCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "novCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "novCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},       
			{ data: 'novCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "novCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "novCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
			{ data: 'decCnt',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "decCnt" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "decCnt" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},       
			{ data: 'decCost',
            	render: function(data, type, row) {
					if( row['gubun'] == "001" ){
						return '<input type="text" class="form-control number-float2" id="' + "decCost" + row['gijongCd'] +'" name="count1" value="' + "0" + '" disabled/></input>';
					} else {
						return '<input type="text" class="form-control number-float2" id="' + "decCost" + row['gijongCd'] +  '" name="count1" value="' + addCommas(data) + '" disabled/></input>';
					}
				}
			},
		
        ],
        columnDefs: [        	
        	{ targets: [0,1,2,3], className: 'text-center-td' },
        	{ targets: [4,5], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ],
        ],        
        drawCallback: function () {
			//전역변수들
		
			var sumTotalCnt  =  $('#salesPlanInfoTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			var sumTotalCost =  $('#salesPlanInfoTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			var sumJanCnt    =  $('#salesPlanInfoTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			var sumJanCost   =  $('#salesPlanInfoTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sumFebCnt    =  $('#salesPlanInfoTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sumFebCost   =  $('#salesPlanInfoTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sumMarCnt    =  $('#salesPlanInfoTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			var sumMarCost   =  $('#salesPlanInfoTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			var sumAprCnt    =  $('#salesPlanInfoTable').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sumAprCost   =  $('#salesPlanInfoTable').DataTable().column(13,{ page: 'all'} ).data().sum();
			var sumMayCnt    =  $('#salesPlanInfoTable').DataTable().column(14,{ page: 'all'} ).data().sum();
			var sumMayCost   =  $('#salesPlanInfoTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			var sumJunCnt    =  $('#salesPlanInfoTable').DataTable().column(16,{ page: 'all'} ).data().sum();
			var sumJunCost   =  $('#salesPlanInfoTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			var sumJulCnt    =  $('#salesPlanInfoTable').DataTable().column(18,{ page: 'all'} ).data().sum();
			var sumJulCost   =  $('#salesPlanInfoTable').DataTable().column(19,{ page: 'all'} ).data().sum();
			var sumAugCnt    =  $('#salesPlanInfoTable').DataTable().column(20,{ page: 'all'} ).data().sum();
			var sumAugCost   =  $('#salesPlanInfoTable').DataTable().column(21,{ page: 'all'} ).data().sum();
			var sumSepCnt    =  $('#salesPlanInfoTable').DataTable().column(22,{ page: 'all'} ).data().sum();
			var sumSepCost   =  $('#salesPlanInfoTable').DataTable().column(23,{ page: 'all'} ).data().sum();
			var sumOctCnt    =  $('#salesPlanInfoTable').DataTable().column(24,{ page: 'all'} ).data().sum();
			var sumOctCost   =  $('#salesPlanInfoTable').DataTable().column(25,{ page: 'all'} ).data().sum();
			var sumNovCnt    =  $('#salesPlanInfoTable').DataTable().column(26,{ page: 'all'} ).data().sum();
			var sumNovCost   =  $('#salesPlanInfoTable').DataTable().column(27,{ page: 'all'} ).data().sum();
			var sumDecCnt    =  $('#salesPlanInfoTable').DataTable().column(28,{ page: 'all'} ).data().sum();
			var sumDecCost   =  $('#salesPlanInfoTable').DataTable().column(29,{ page: 'all'} ).data().sum();

			$('#sumTotalCnt').text(addCommas(sumTotalCnt.toFixed(0)));
			$('#sumTotalCost').text(addCommas(sumTotalCost.toFixed(0)));
			$('#sumJanCnt').text(addCommas(sumJanCnt.toFixed(0)));
			$('#sumJanCost').text(addCommas(sumJanCost.toFixed(0)));
			$('#sumFebCnt').text(addCommas(sumFebCnt.toFixed(0)));
			$('#sumFebCost').text(addCommas(sumFebCost.toFixed(0)));
			$('#sumMarCnt').text(addCommas(sumMarCnt.toFixed(0)));
			$('#sumMarCost').text(addCommas(sumMarCost.toFixed(0)));
			$('#sumAprCnt').text(addCommas(sumAprCnt.toFixed(0)));
			$('#sumAprCost').text(addCommas(sumAprCost.toFixed(0)));
			$('#sumMayCnt').text(addCommas(sumMayCnt.toFixed(0)));
			$('#sumMayCost').text(addCommas(sumMayCost.toFixed(0)));
			$('#sumJunCnt').text(addCommas(sumJunCnt.toFixed(0)));
			$('#sumJunCost').text(addCommas(sumJunCost.toFixed(0)));
			$('#sumJulCnt').text(addCommas(sumJulCnt.toFixed(0)));
			$('#sumJulCost').text(addCommas(sumJulCost.toFixed(0)));
			$('#sumAugCnt').text(addCommas(sumAugCnt.toFixed(0)));
			$('#sumAugCost').text(addCommas(sumAugCost.toFixed(0)));
			$('#sumSepCnt').text(addCommas(sumSepCnt.toFixed(0)));
			$('#sumSepCost').text(addCommas(sumSepCost.toFixed(0)));
			$('#sumOctCnt').text(addCommas(sumOctCnt.toFixed(0)));
			$('#sumOctCost').text(addCommas(sumOctCost.toFixed(0)));
			$('#sumNovCnt').text(addCommas(sumNovCnt.toFixed(0)));
			$('#sumNovCost').text(addCommas(sumNovCost.toFixed(0)));
			$('#sumDecCnt').text(addCommas(sumDecCnt.toFixed(0)));
			$('#sumDecCost').text(addCommas(sumDecCost.toFixed(0)));
	
        }
    });



    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let salesPlanInfoTable2 = $('#salesPlanInfoTable2').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false, 
        searching: false,      
        ajax: {
            url: '<c:url value="/bs/salesPlanAdmQuarterDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planYear': function() { return planYear2; },	           	   
            },            
        },
        rowId: 'rowId',
        columns: [
            { data: 'dealCorpNm' },
            { data: 'gijongNm' },
            { data: 'quarterCnt1' },
            { data: 'quarterCost1' },
            { data: 'qty1' },
            { data: 'cost1' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty1']) / parseFloat(row['quarterCnt1'])) * 100;
                	if(row['qty1'] == '0' || row['quarterCnt1'] == null){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost1']) / parseFloat(row['quarterCost1']))  * 100;
            		if(row['cost1'] == '0' || row['quarterCost1'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'quarterCnt2' },
            { data: 'quarterCost2' },
            { data: 'qty2' },
            { data: 'cost2' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty2']) / parseFloat(row['quarterCnt2'])) * 100;
            		if(row['qty2'] == '0' || row['quarterCnt2'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost2']) / parseFloat(row['quarterCost2']) )  * 100;
            		if(row['cost2'] == '0' || row['quarterCost2'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
			{ data: 'quarterCnt3' },
            { data: 'quarterCost3' },
            { data: 'qty3' },
            { data: 'cost3' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty3']) / parseFloat(row['quarterCnt3'])) * 100;
            		if(row['qty3'] == '0' || row['quarterCnt3'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost3'] /parseFloat(row['quarterCost3']) )) * 100;
            		if(row['cost3'] == '0' || row['quarterCost3'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
			{ data: 'quarterCnt4' },
            { data: 'quarterCost4' },
            { data: 'qty4' },
            { data: 'cost4' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty4']) / parseFloat(row['quarterCnt4'])) * 100;
            		if(row['qty4'] == '0' || row['quarterCnt4'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost4']) / parseFloat(row['quarterCost4']))  * 100;
            		if(row['cost4'] == '0' || row['quarterCost4'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
                
        ],
        columnDefs: [
        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ]           
        ],
        buttons: [
            {
                extend: 'copy',
                title: '분기별 매출계획대비 실적',
            },
            {
                extend: 'excel',
                title: '분기별 매출계획대비 실적',
            },
            {
                extend: 'print',
                title: '분기별 매출계획대비 실적',
            },
        ],
        drawCallback: function () {
			//전역변수들
			var sum1 = $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).data().sum();
			var sum2 = $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).data().sum();
			var sum3 = $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).data().sum();
			var sum4 = $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).data().sum();
			var sum5 = $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).data().sum();
			var sum6 = $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sum7 = $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sum8 = $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sum9 = $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).data().sum();
			var sum10 = $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).data().sum();
			var sum11 = $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sum12 = $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).data().sum();
			var sum13 = $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).data().sum();
			var sum14 = $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).data().sum();
			var sum15 = $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).data().sum();
			var sum16 = $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).data().sum();
			var sum17 = $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).data().sum();
			var sum18 = $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).data().sum();
			var sum19 = $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).data().sum();
			var sum20 = $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).data().sum();
			var sum21 = $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).data().sum();
			var sum22 = $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).data().sum();
			var sum23 = $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).data().sum();
			var sum24 = $('#salesPlanInfoTable2').DataTable().column(25,{ page: 'all'} ).data().sum();			
			
			$('#sum1').text(addCommas(sum1.toFixed(0)));
			$('#sum2').text(addCommas(sum2.toFixed(0)));
			$('#sum3').text(addCommas(sum3.toFixed(0)));
			$('#sum4').text(addCommas(sum4.toFixed(0)));

			if(sum1 == '0' || sum3 == '0'){
				$('#sum5').text('0.00%');                    	
           	} else{
           		$('#sum5').text(addCommas((sum3/sum1*100).toFixed(2)) + '%');                  		
            }
			if(sum2 == '0' || sum4 == '0'){
				$('#sum6').text('0.00%');                    	
           	} else{
           		$('#sum6').text(addCommas((sum4/sum2*100).toFixed(2)) + '%');              		
            }
			
			
			$('#sum7').text(addCommas(sum7.toFixed(0)));
			$('#sum8').text(addCommas(sum8.toFixed(0)));
			$('#sum9').text(addCommas(sum9.toFixed(0)));
			$('#sum10').text(addCommas(sum10.toFixed(0)));

			if(sum7 == '0' || sum9 == '0'){
				$('#sum11').text('0.00%');                    	
           	} else{
           		$('#sum11').text(addCommas((sum9/sum7*100).toFixed(2)) + '%');                  		
            }
			if(sum8 == '0' || sum10 == '0'){
				$('#sum12').text('0.00%');                    	
           	} else{
           		$('#sum12').text(addCommas((sum10/sum8*100).toFixed(2)) + '%');              		
            }            
		
			
			$('#sum13').text(addCommas(sum13.toFixed(0)));			
			$('#sum14').text(addCommas(sum14.toFixed(0)));
			$('#sum15').text(addCommas(sum15.toFixed(0)));
			$('#sum16').text(addCommas(sum16.toFixed(0)));

			if(sum13 == '0' || sum15 == '0'){
				$('#sum17').text('0.00%');                    	
           	} else{
           		$('#sum17').text(addCommas((sum15/sum13*100).toFixed(2)) + '%');                  		
            }
			if(sum14 == '0' || sum16 == '0'){
				$('#sum18').text('0.00%');                    	
           	} else{
           		$('#sum18').text(addCommas((sum16/sum14*100).toFixed(2)) + '%');              		
            }
    
			$('#sum19').text(addCommas(sum19.toFixed(0)));			
			$('#sum20').text(addCommas(sum20.toFixed(0)));
			$('#sum21').text(addCommas(sum21.toFixed(0)));
			$('#sum22').text(addCommas(sum22.toFixed(0)));

			if(sum19 == '0' || sum21 == '0'){
				$('#sum23').text('0.00%');                    	
           	} else{
           		$('#sum23').text(addCommas((sum21/sum19*100).toFixed(2)) + '%');                  		
            }
			if(sum20 == '0' || sum22 == '0'){
				$('#sum24').text('0.00%');                    	
           	} else{
           		$('#sum24').text(addCommas((sum22/sum20*100).toFixed(2)) + '%');              		
            }
            

        }
    });

	   // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let salesPlanInfoTable3 = $('#salesPlanInfoTable3').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false, 
        searching: false,      
        ajax: {
            url: '<c:url value="/bs/salesPlanAdmMonthDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planYear': function() { return planYear3; },	           	   
            },            
        },
        rowId: 'rowId',
        columns: [
            { data: 'dealCorpNm' },
            { data: 'gijongNm' },
            { data: 'janCnt' },
            { data: 'janCost' },
            { data: 'qty1' },
            { data: 'cost1' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty1']) / parseFloat(row['janCnt'])) * 100;
                	if(row['qty1'] == '0' || row['janCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost1']) / parseFloat(row['janCost']))  * 100;
            		if(row['cost1'] == '0' || row['janCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'febCnt' },
            { data: 'febCost' },
            { data: 'qty2' },
            { data: 'cost2' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty2']) / parseFloat(row['febCnt'])) * 100;
            		if(row['qty2'] == '0' || row['febCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost2']) / parseFloat(row['febCost']) )  * 100;
            		if(row['cost2'] == '0' || row['febCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
			{ data: 'marCnt' },
            { data: 'marCost' },
            { data: 'qty3' },
            { data: 'cost3' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty3']) / parseFloat(row['marCnt'])) * 100;
            		if(row['qty3'] == '0' || row['marCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost3'] /parseFloat(row['marCost']) )) * 100;
            		if(row['cost3'] == '0' || row['marCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
			{ data: 'aprCnt' },
            { data: 'aprCost' },
            { data: 'qty4' },
            { data: 'cost4' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty4']) / parseFloat(row['aprCnt'])) * 100;
            		if(row['qty4'] == '0' || row['aprCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost4']) / parseFloat(row['aprCost']))  * 100;
            		if(row['cost4'] == '0' || row['aprCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
			{ data: 'mayCnt' },
            { data: 'mayCost' },
            { data: 'qty5' },
            { data: 'cost5' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty5']) / parseFloat(row['mayCnt'])) * 100;
                	if(row['qty5'] == '0' || row['mayCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost5']) / parseFloat(row['mayCost']))  * 100;
            		if(row['cost5'] == '0' || row['mayCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'junCnt' },
            { data: 'junCost' },
            { data: 'qty6' },
            { data: 'cost6' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty6']) / parseFloat(row['junCnt'])) * 100;
                	if(row['qty6'] == '0' || row['junCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost6']) / parseFloat(row['junCost']))  * 100;
            		if(row['cost6'] == '0' || row['junCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'julCnt' },
            { data: 'julCost' },
            { data: 'qty7' },
            { data: 'cost7' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty7']) / parseFloat(row['julCnt'])) * 100;
                	if(row['qty7'] == '0' || row['julCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost7']) / parseFloat(row['julCost']))  * 100;
            		if(row['cost7'] == '0' || row['julCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'augCnt' },
            { data: 'augCost' },
            { data: 'qty8' },
            { data: 'cost8' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty8']) / parseFloat(row['augCnt'])) * 100;
                	if(row['qty8'] == '0' || row['augCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost8']) / parseFloat(row['augCost']))  * 100;
            		if(row['cost8'] == '0' || row['augCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'sepCnt' },
            { data: 'sepCost' },
            { data: 'qty9' },
            { data: 'cost9' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty9']) / parseFloat(row['sepCnt'])) * 100;
                	if(row['qty9'] == '0' || row['sepCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost9']) / parseFloat(row['sepCost']))  * 100;
            		if(row['cost9'] == '0.0' || row['sepCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'octCnt' },
            { data: 'octCost' },
            { data: 'qty10' },
            { data: 'cost10' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty10']) / parseFloat(row['octCnt'])) * 100;
                	if(row['qty10'] == '0' || row['octCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost10']) / parseFloat(row['octCost']))  * 100;
            		if(row['cost10'] == '0' || row['octCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'novCnt' },
            { data: 'novCost' },
            { data: 'qty11' },
            { data: 'cost11' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty11']) / parseFloat(row['novCnt'])) * 100;
                	if(row['qty11'] == '0' || row['novCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost11']) / parseFloat(row['novCost']))  * 100;
            		if(row['cost11'] == '0' || row['novCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'decCnt' },
            { data: 'decCost' },
            { data: 'qty12' },
            { data: 'cost12' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty12']) / parseFloat(row['decCnt'])) * 100;
                	if(row['qty12'] == '0' || row['decCnt'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost12']) / parseFloat(row['decCost']))  * 100;
            		if(row['cost12'] == '0.0' || row['decCost'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
                
        ],
        columnDefs: [
        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], className: 'text-right-td' },
        	{ targets: [26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],  className: 'text-right-td' },
        	{ targets: [51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73],  className: 'text-right-td' },
        	
        ],
        order: [
            [ 0, 'desc' ]           
        ],
        buttons: [
            {
                extend: 'copy',
                title: '월별 매출계획대비 실적',
            },
            {
                extend: 'excel',
                title: '월별 매출계획대비 실적',
            },
            {
                extend: 'print',
                title: '월별 매출계획대비 실적',
            },
        ],
        drawCallback: function () {
			//전역변수들
			var sum1 = $('#salesPlanInfoTable3').DataTable().column(2,{ page: 'all'} ).data().sum();
			var sum2 = $('#salesPlanInfoTable3').DataTable().column(3,{ page: 'all'} ).data().sum();
			var sum3 = $('#salesPlanInfoTable3').DataTable().column(4,{ page: 'all'} ).data().sum();
			var sum4 = $('#salesPlanInfoTable3').DataTable().column(5,{ page: 'all'} ).data().sum();
			var sum5 = $('#salesPlanInfoTable3').DataTable().column(6,{ page: 'all'} ).data().sum();
			var sum6 = $('#salesPlanInfoTable3').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sum7 = $('#salesPlanInfoTable3').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sum8 = $('#salesPlanInfoTable3').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sum9 = $('#salesPlanInfoTable3').DataTable().column(10,{ page: 'all'} ).data().sum();
			var sum10 = $('#salesPlanInfoTable3').DataTable().column(11,{ page: 'all'} ).data().sum();
			var sum11 = $('#salesPlanInfoTable3').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sum12 = $('#salesPlanInfoTable3').DataTable().column(13,{ page: 'all'} ).data().sum();
			var sum13 = $('#salesPlanInfoTable3').DataTable().column(14,{ page: 'all'} ).data().sum();
			var sum14 = $('#salesPlanInfoTable3').DataTable().column(15,{ page: 'all'} ).data().sum();
			var sum15 = $('#salesPlanInfoTable3').DataTable().column(16,{ page: 'all'} ).data().sum();
			var sum16 = $('#salesPlanInfoTable3').DataTable().column(17,{ page: 'all'} ).data().sum();
			var sum17 = $('#salesPlanInfoTable3').DataTable().column(18,{ page: 'all'} ).data().sum();
			var sum18 = $('#salesPlanInfoTable3').DataTable().column(19,{ page: 'all'} ).data().sum();
			var sum19 = $('#salesPlanInfoTable3').DataTable().column(20,{ page: 'all'} ).data().sum();
			var sum20 = $('#salesPlanInfoTable3').DataTable().column(21,{ page: 'all'} ).data().sum();
			var sum21 = $('#salesPlanInfoTable3').DataTable().column(22,{ page: 'all'} ).data().sum();
			var sum22 = $('#salesPlanInfoTable3').DataTable().column(23,{ page: 'all'} ).data().sum();
			var sum23 = $('#salesPlanInfoTable3').DataTable().column(24,{ page: 'all'} ).data().sum();
			var sum24 = $('#salesPlanInfoTable3').DataTable().column(25,{ page: 'all'} ).data().sum();
			var sum25 = $('#salesPlanInfoTable3').DataTable().column(26,{ page: 'all'} ).data().sum();
			var sum26 = $('#salesPlanInfoTable3').DataTable().column(27,{ page: 'all'} ).data().sum();
			var sum27 = $('#salesPlanInfoTable3').DataTable().column(28,{ page: 'all'} ).data().sum();
			var sum28 = $('#salesPlanInfoTable3').DataTable().column(29,{ page: 'all'} ).data().sum();
			var sum29 = $('#salesPlanInfoTable3').DataTable().column(30,{ page: 'all'} ).data().sum();
			var sum30 = $('#salesPlanInfoTable3').DataTable().column(31,{ page: 'all'} ).data().sum();
			var sum31 = $('#salesPlanInfoTable3').DataTable().column(32,{ page: 'all'} ).data().sum();
			var sum32 = $('#salesPlanInfoTable3').DataTable().column(33,{ page: 'all'} ).data().sum();
			var sum33 = $('#salesPlanInfoTable3').DataTable().column(34,{ page: 'all'} ).data().sum();
			var sum34 = $('#salesPlanInfoTable3').DataTable().column(35,{ page: 'all'} ).data().sum();
			var sum35 = $('#salesPlanInfoTable3').DataTable().column(36,{ page: 'all'} ).data().sum();
			var sum36 = $('#salesPlanInfoTable3').DataTable().column(37,{ page: 'all'} ).data().sum();
			var sum37 = $('#salesPlanInfoTable3').DataTable().column(38,{ page: 'all'} ).data().sum();
			var sum38 = $('#salesPlanInfoTable3').DataTable().column(39,{ page: 'all'} ).data().sum();
			var sum39 = $('#salesPlanInfoTable3').DataTable().column(40,{ page: 'all'} ).data().sum();
			var sum40 = $('#salesPlanInfoTable3').DataTable().column(41,{ page: 'all'} ).data().sum();
			var sum41 = $('#salesPlanInfoTable3').DataTable().column(42,{ page: 'all'} ).data().sum();
			var sum42 = $('#salesPlanInfoTable3').DataTable().column(43,{ page: 'all'} ).data().sum();
			var sum43 = $('#salesPlanInfoTable3').DataTable().column(44,{ page: 'all'} ).data().sum();
			var sum44 = $('#salesPlanInfoTable3').DataTable().column(45,{ page: 'all'} ).data().sum();
			var sum45 = $('#salesPlanInfoTable3').DataTable().column(46,{ page: 'all'} ).data().sum();
			var sum46 = $('#salesPlanInfoTable3').DataTable().column(47,{ page: 'all'} ).data().sum();
			var sum47 = $('#salesPlanInfoTable3').DataTable().column(48,{ page: 'all'} ).data().sum();
			var sum48 = $('#salesPlanInfoTable3').DataTable().column(49,{ page: 'all'} ).data().sum();		
			var sum49 = $('#salesPlanInfoTable3').DataTable().column(50,{ page: 'all'} ).data().sum();
			var sum50 = $('#salesPlanInfoTable3').DataTable().column(51,{ page: 'all'} ).data().sum();
			var sum51 = $('#salesPlanInfoTable3').DataTable().column(52,{ page: 'all'} ).data().sum();
			var sum52 = $('#salesPlanInfoTable3').DataTable().column(53,{ page: 'all'} ).data().sum();
			var sum53 = $('#salesPlanInfoTable3').DataTable().column(54,{ page: 'all'} ).data().sum();
			var sum54 = $('#salesPlanInfoTable3').DataTable().column(55,{ page: 'all'} ).data().sum();
			var sum55 = $('#salesPlanInfoTable3').DataTable().column(56,{ page: 'all'} ).data().sum();
			var sum56 = $('#salesPlanInfoTable3').DataTable().column(57,{ page: 'all'} ).data().sum();
			var sum57 = $('#salesPlanInfoTable3').DataTable().column(58,{ page: 'all'} ).data().sum();
			var sum58 = $('#salesPlanInfoTable3').DataTable().column(59,{ page: 'all'} ).data().sum();
			var sum59 = $('#salesPlanInfoTable3').DataTable().column(60,{ page: 'all'} ).data().sum();
			var sum60 = $('#salesPlanInfoTable3').DataTable().column(61,{ page: 'all'} ).data().sum();
			var sum61 = $('#salesPlanInfoTable3').DataTable().column(62,{ page: 'all'} ).data().sum();
			var sum62 = $('#salesPlanInfoTable3').DataTable().column(63,{ page: 'all'} ).data().sum();
			var sum63 = $('#salesPlanInfoTable3').DataTable().column(64,{ page: 'all'} ).data().sum();
			var sum64 = $('#salesPlanInfoTable3').DataTable().column(65,{ page: 'all'} ).data().sum();
			var sum65 = $('#salesPlanInfoTable3').DataTable().column(66,{ page: 'all'} ).data().sum();
			var sum66 = $('#salesPlanInfoTable3').DataTable().column(67,{ page: 'all'} ).data().sum();
			var sum67 = $('#salesPlanInfoTable3').DataTable().column(68,{ page: 'all'} ).data().sum();
			var sum68 = $('#salesPlanInfoTable3').DataTable().column(69,{ page: 'all'} ).data().sum();
			var sum69 = $('#salesPlanInfoTable3').DataTable().column(70,{ page: 'all'} ).data().sum();
			var sum70 = $('#salesPlanInfoTable3').DataTable().column(71,{ page: 'all'} ).data().sum();
			var sum71 = $('#salesPlanInfoTable3').DataTable().column(72,{ page: 'all'} ).data().sum();
			var sum72 = $('#salesPlanInfoTable3').DataTable().column(73,{ page: 'all'} ).data().sum();					
			
		 	$('#monthSum1').text(addCommas(sum1.toFixed(0)));
			$('#monthSum2').text(addCommas(sum2.toFixed(0)));
			$('#monthSum3').text(addCommas(sum3.toFixed(0)));
			$('#monthSum4').text(addCommas(sum4.toFixed(0)));

			if(sum1 == '0' || sum3 == '0'){
				$('#monthSum5').text('0.00%');                    	
           	} else{
           		$('#monthSum5').text(addCommas((sum3/sum1*100).toFixed(2)) + '%');                  		
            }
			if(sum2 == '0' || sum4 == '0'){
				$('#monthSum6').text('0.00%');                    	
           	} else{
           		$('#monthSum6').text(addCommas((sum4/sum2*100).toFixed(2)) + '%');              		
            }			
			
			$('#monthSum7').text(addCommas(sum7.toFixed(0)));
			$('#monthSum8').text(addCommas(sum8.toFixed(0)));
			$('#monthSum9').text(addCommas(sum9.toFixed(0)));
			$('#monthSum10').text(addCommas(sum10.toFixed(0)));

			if(sum7 == '0' || sum9 == '0'){
				$('#monthSum11').text('0.00%');                    	
           	} else{
           		$('#monthSum11').text(addCommas((sum9/sum7*100).toFixed(2)) + '%');                  		
            }
			if(sum8 == '0' || sum10 == '0'){
				$('#monthSum12').text('0.00%');                    	
           	} else{
           		$('#monthSum12').text(addCommas((sum10/sum8*100).toFixed(2)) + '%');              		
            }   
            	
			
			$('#monthSum13').text(addCommas(sum13.toFixed(0)));
			$('#monthSum14').text(addCommas(sum14.toFixed(0)));
			$('#monthSum15').text(addCommas(sum15.toFixed(0)));
			$('#monthSum16').text(addCommas(sum16.toFixed(0)));

			if(sum13 == '0' || sum15 == '0'){
				$('#monthSum17').text('0.00%');                    	
           	} else{
           		$('#monthSum17').text(addCommas((sum15/sum13*100).toFixed(2)) + '%');                  		
            }
			if(sum14 == '0' || sum16 == '0'){
				$('#monthSum18').text('0.00%');                    	
           	} else{
           		$('#monthSum18').text(addCommas((sum16/sum14*100).toFixed(2)) + '%');              		
            }
			
			$('#monthSum19').text(addCommas(sum19.toFixed(0)));			
			$('#monthSum20').text(addCommas(sum20.toFixed(0)));
			$('#monthSum21').text(addCommas(sum21.toFixed(0)));
			$('#monthSum22').text(addCommas(sum22.toFixed(0)));

			if(sum19 == '0' || sum21 == '0'){
				$('#monthSum23').text('0.00%');                    	
           	} else{
           		$('#monthSum23').text(addCommas((sum21/sum19*100).toFixed(2)) + '%');                  		
            }
			if(sum20 == '0' || sum22 == '0'){
				$('#monthSum24').text('0.00%');                    	
           	} else{
           		$('#monthSum24').text(addCommas((sum22/sum20*100).toFixed(2)) + '%');              		
            }   
		
			$('#monthSum25').text(addCommas(sum25.toFixed(0)));
			$('#monthSum26').text(addCommas(sum26.toFixed(0)));
			$('#monthSum27').text(addCommas(sum27.toFixed(0)));
			$('#monthSum28').text(addCommas(sum28.toFixed(0)));

			if(sum25 == '0' || sum27 == '0'){
				$('#monthSum29').text('0.00%');                    	
           	} else{
           		$('#monthSum29').text(addCommas((sum27/sum25*100).toFixed(2)) + '%');                  		
            }
			if(sum26 == '0' || sum28 == '0'){
				$('#monthSum30').text('0.00%');                    	
           	} else{
           		$('#monthSum30').text(addCommas((sum28/sum26*100).toFixed(2)) + '%');              		
            } 
            
					
			$('#monthSum31').text(addCommas(sum31.toFixed(0)));
			$('#monthSum32').text(addCommas(sum32.toFixed(0)));
			$('#monthSum33').text(addCommas(sum33.toFixed(0)));
			$('#monthSum34').text(addCommas(sum34.toFixed(0)));

			if(sum31 == '0' || sum33 == '0'){
				$('#monthSum35').text('0.00%');                    	
           	} else{
           		$('#monthSum35').text(addCommas((sum33/sum31*100).toFixed(2)) + '%');                  		
            }
			if(sum32 == '0' || sum34 == '0'){
				$('#monthSum36').text('0.00%');                    	
           	} else{
           		$('#monthSum36').text(addCommas((sum34/sum32*100).toFixed(2)) + '%');              		
            } 			

			
			$('#monthSum37').text(addCommas(sum37.toFixed(0)));
			$('#monthSum38').text(addCommas(sum38.toFixed(0)));
			$('#monthSum39').text(addCommas(sum39.toFixed(0)));
			$('#monthSum40').text(addCommas(sum40.toFixed(0)));

			if(sum37 == '0' || sum39 == '0'){
				$('#monthSum41').text('0.00%');                    	
           	} else{
           		$('#monthSum41').text(addCommas((sum39/sum37*100).toFixed(2)) + '%');                  		
            }
			if(sum38 == '0' || sum40 == '0'){
				$('#monthSum42').text('0.00%');                    	
           	} else{
           		$('#monthSum42').text(addCommas((sum40/sum38*100).toFixed(2)) + '%');              		
            } 			

			
			$('#monthSum43').text(addCommas(sum43.toFixed(0)));
			$('#monthSum44').text(addCommas(sum44.toFixed(0)));
			$('#monthSum45').text(addCommas(sum45.toFixed(0)));
			$('#monthSum46').text(addCommas(sum46.toFixed(0)));

			if(sum43 == '0' || sum45 == '0'){
				$('#monthSum47').text('0.00%');                    	
           	} else{
           		$('#monthSum47').text(addCommas((sum45/sum43*100).toFixed(2)) + '%');                  		
            }
			if(sum44 == '0' || sum46 == '0'){
				$('#monthSum48').text('0.00%');                    	
           	} else{
           		$('#monthSum48').text(addCommas((sum46/sum44*100).toFixed(2)) + '%');              		
            } 
			
		
			
			$('#monthSum49').text(addCommas(sum49.toFixed(0)));
			$('#monthSum50').text(addCommas(sum50.toFixed(0)));
			$('#monthSum51').text(addCommas(sum51.toFixed(0)));
			$('#monthSum52').text(addCommas(sum52.toFixed(0)));

			if(sum49 == '0' || sum51 == '0'){
				$('#monthSum53').text('0.00%');                    	
           	} else{
           		$('#monthSum53').text(addCommas((sum51/sum49*100).toFixed(2)) + '%');                  		
            }
			if(sum50 == '0' || sum52 == '0'){
				$('#monthSum54').text('0.00%');                    	
           	} else{
           		$('#monthSum54').text(addCommas((sum52/sum50*100).toFixed(2)) + '%');              		
            } 		
			
			$('#monthSum55').text(addCommas(sum55.toFixed(0)));
			$('#monthSum56').text(addCommas(sum56.toFixed(0)));
			$('#monthSum57').text(addCommas(sum57.toFixed(0)));
			$('#monthSum58').text(addCommas(sum58.toFixed(0)));

			if(sum55 == '0' || sum57 == '0'){
				$('#monthSum59').text('0.00%');                    	
           	} else{
           		$('#monthSum59').text(addCommas((sum57/sum55*100).toFixed(2)) + '%');                  		
            }
			if(sum56 == '0' || sum58 == '0'){
				$('#monthSum60').text('0.00%');                    	
           	} else{
           		$('#monthSum60').text(addCommas((sum58/sum56*100).toFixed(2)) + '%');              		
            }		
			
			$('#monthSum61').text(addCommas(sum61.toFixed(0)));
			$('#monthSum62').text(addCommas(sum62.toFixed(0)));
			$('#monthSum63').text(addCommas(sum63.toFixed(0)));
			$('#monthSum64').text(addCommas(sum64.toFixed(0)));

			if(sum61 == '0' || sum63 == '0'){
				$('#monthSum65').text('0.00%');                    	
           	} else{
           		$('#monthSum65').text(addCommas((sum63/sum61*100).toFixed(2)) + '%');                  		
            }
			if(sum62 == '0' || sum64 == '0'){
				$('#monthSum66').text('0.00%');                    	
           	} else{
           		$('#monthSum66').text(addCommas((sum64/sum62*100).toFixed(2)) + '%');              		
            } 
			
			$('#monthSum67').text(addCommas(sum67.toFixed(0)));
			$('#monthSum68').text(addCommas(sum68.toFixed(0)));
			$('#monthSum69').text(addCommas(sum69.toFixed(0)));
			$('#monthSum70').text(addCommas(sum70.toFixed(0)));

			if(sum67 == '0' || sum69 == '0'){
				$('#monthSum71').text('0.00%');                    	
           	} else{
           		$('#monthSum71').text(addCommas((sum69/sum67*100).toFixed(2)) + '%');                  		
            }
			if(sum68 == '0' || sum70 == '0'){
				$('#monthSum72').text('0.00%');                    	
           	} else{
           		$('#monthSum72').text(addCommas((sum70/sum68*100).toFixed(2)) + '%');              		
            }
			
			
			

		
			
        }
    });


    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let salesPlanInfoTable4 = $('#salesPlanInfoTable4').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false, 
        searching: false,      
        ajax: {
            url: '<c:url value="/bs/allSalesPlanAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planYear': function() { return planYear4; },	           	   
            },            
        },
        rowId: 'rowId',
        columns: [
            { data: 'dealCorpNm' },
            { data: 'gijongNm' },
            { data: 'orderby',
            	render: function(data, type, row) {            		
            		if(row['orderby'] == '1'){                		
                		return '사업 계획';                    	
                   	} else if(row['orderby'] == '2'){
                   		return '실적';                   		
                    } else if(row['orderby'] == '3'){
                    	return '달성율';         
                    }
					
				}
			 },
            { data: 'janCnt',
            	render: function(data, type, row) {            		
            		if(row['orderby'] == '1'){
                		order1[0] += data;
                		return addCommas(data);                    	
                   	} else if(row['orderby'] == '2'){
                   		order2[0] += data;
                   		return addCommas(data);                   		
                    } else if(row['orderby'] == '3'){
                    	return addCommas(data.toFixed(0)) + '%';         
                    }
					
				}
			 },
				 
            { data: 'febCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[1] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[1] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			 },
            { data: 'marCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[2] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[2] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			 },
       	    { data: 'aprCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[3] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[3] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},			
            { data: 'mayCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[4] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[4] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			 },
            { data: 'junCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[5] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[5] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'julCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[6] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[6] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'augCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[7] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[7] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'sepCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[8] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[8] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'octCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[9] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[9] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'novCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[10] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[10] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'decCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[11] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[11] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'totalCnt',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		order1[12] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		order2[12] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
           
                
        ],
        columnDefs: [
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ]           
        ],
        buttons: [
            {
                extend: 'copy',
                title: '년도별 매출계획대비 실적(수량)',
            },
            {
                extend: 'excel',
                title: '년도별 매출계획대비 실적(수량)',
            },
            {
                extend: 'print',
                title: '년도별 매출계획대비 실적(수량)',
            },
        ],
        drawCallback: function () {
			//전역변수들
			var sum1 = $('#salesPlanInfoTable4').DataTable().column(3,{ page: 'all'} ).data().sum();
			var sum2 = $('#salesPlanInfoTable4').DataTable().column(4,{ page: 'all'} ).data().sum();
			var sum3 = $('#salesPlanInfoTable4').DataTable().column(5,{ page: 'all'} ).data().sum();
			var sum4 = $('#salesPlanInfoTable4').DataTable().column(6,{ page: 'all'} ).data().sum();
			var sum5 = $('#salesPlanInfoTable4').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sum6 = $('#salesPlanInfoTable4').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sum7 = $('#salesPlanInfoTable4').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sum8 = $('#salesPlanInfoTable4').DataTable().column(10,{ page: 'all'} ).data().sum();
			var sum9 = $('#salesPlanInfoTable4').DataTable().column(11,{ page: 'all'} ).data().sum();
			var sum10 = $('#salesPlanInfoTable4').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sum11 = $('#salesPlanInfoTable4').DataTable().column(13,{ page: 'all'} ).data().sum();
			var sum12 = $('#salesPlanInfoTable4').DataTable().column(14,{ page: 'all'} ).data().sum();
			var sum13 = $('#salesPlanInfoTable4').DataTable().column(15,{ page: 'all'} ).data().sum();
			
			
			$('#totalSum11').text(addCommas( order1[0].toFixed(0)));
			$('#totalSum12').text(addCommas( order1[1].toFixed(0)));
			$('#totalSum13').text(addCommas( order1[2].toFixed(0)));
			$('#totalSum14').text(addCommas( order1[3].toFixed(0)));
			$('#totalSum15').text(addCommas( order1[4].toFixed(0)));
			$('#totalSum16').text(addCommas( order1[5].toFixed(0)));
			$('#totalSum17').text(addCommas( order1[6].toFixed(0)));
			$('#totalSum18').text(addCommas( order1[7].toFixed(0)));
			$('#totalSum19').text(addCommas( order1[8].toFixed(0)));
			$('#totalSum110').text(addCommas(order1[9].toFixed(0)));
			$('#totalSum111').text(addCommas(order1[10].toFixed(0)));
			$('#totalSum112').text(addCommas(order1[11].toFixed(0)));
			$('#totalSum113').text(addCommas(order1[12].toFixed(0)));

			$('#totalSum21').text(addCommas(order2[0].toFixed(0)));
			$('#totalSum22').text(addCommas(order2[1].toFixed(0)));
			$('#totalSum23').text(addCommas(order2[2].toFixed(0)));
			$('#totalSum24').text(addCommas(order2[3].toFixed(0)));
			$('#totalSum25').text(addCommas(order2[4].toFixed(0)));
			$('#totalSum26').text(addCommas(order2[5].toFixed(0)));
			$('#totalSum27').text(addCommas(order2[6].toFixed(0)));
			$('#totalSum28').text(addCommas(order2[7].toFixed(0)));
			$('#totalSum29').text(addCommas(order2[8].toFixed(0)));
			$('#totalSum210').text(addCommas(order2[9].toFixed(0)));
			$('#totalSum211').text(addCommas(order2[10].toFixed(0)));
			$('#totalSum212').text(addCommas(order2[11].toFixed(0)));
			$('#totalSum213').text(addCommas(order2[12].toFixed(0)));

		 	$('#totalSum31').text(addCommas((order2[0]/order1[0]*100).toFixed(0)) + '%');
			$('#totalSum32').text(addCommas((order2[1]/order1[1]*100).toFixed(0)) + '%');
			$('#totalSum33').text(addCommas((order2[2]/order1[2]*100).toFixed(0)) + '%');
			$('#totalSum34').text(addCommas((order2[3]/order1[3]*100).toFixed(0)) + '%');
			$('#totalSum35').text(addCommas((order2[4]/order1[4]*100).toFixed(0)) + '%');
			$('#totalSum36').text(addCommas((order2[5]/order1[5]*100).toFixed(0)) + '%');
			$('#totalSum37').text(addCommas((order2[6]/order1[6]*100).toFixed(0)) + '%');
			$('#totalSum38').text(addCommas((order2[7]/order1[7]*100).toFixed(0)) + '%');
			$('#totalSum39').text(addCommas((order2[8]/order1[8]*100).toFixed(0)) + '%');
			$('#totalSum310').text(addCommas((order2[9]/order1[9]*100).toFixed(0)) + '%');
			$('#totalSum311').text(addCommas((order2[10]/order1[10]*100).toFixed(0)) + '%');
			$('#totalSum312').text(addCommas((order2[11]/order1[11]*100).toFixed(0)) + '%');
			$('#totalSum313').text(addCommas((order2[12]/order1[12]*100).toFixed(0)) + '%'); 


        }
    });
    

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let salesPlanInfoTable5 = $('#salesPlanInfoTable5').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false, 
        searching: false,      
        ajax: {
            url: '<c:url value="/bs/allSalesPlanAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planYear': function() { return planYear5; },	           	   
            },            
        },
        rowId: 'rowId',
        columns: [
            { data: 'dealCorpNm' },
            { data: 'gijongNm' },
            { data: 'orderby',
            	render: function(data, type, row) {            		
            		if(row['orderby'] == '1'){                		
                		return '사업 계획';                    	
                   	} else if(row['orderby'] == '2'){
                   		return '실적';                   		
                    } else if(row['orderby'] == '3'){
                    	return '달성율';         
                    }
					
				}
			 },
            { data: 'janCost',
            	render: function(data, type, row) {            		
            		if(row['orderby'] == '1'){
                		orderCost1[0] += data;
                		return addCommas(data);                    	
                   	} else if(row['orderby'] == '2'){
                   		orderCost2[0] += data;
                   		return addCommas(data);                   		
                    } else if(row['orderby'] == '3'){
                    	return addCommas(data.toFixed(0)) + '%';         
                    }
					
				}
			 },
				 
            { data: 'febCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[1] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[1] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			 },
            { data: 'marCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[2] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[2] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			 },
       	    { data: 'aprCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[3] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[3] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},			
            { data: 'mayCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[4] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[4] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			 },
            { data: 'junCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[5] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[5] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'julCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[6] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[6] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'augCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[7] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[7] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'sepCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[8] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[8] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'octCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[9] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[9] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'novCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[10] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[10] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'decCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[11] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[11] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
            { data: 'totalCost',
				 render: function(data, type, row) {            		
	            		if(row['orderby'] == '1'){
	                		orderCost1[12] += data;
	                		return addCommas(data);                    	
	                   	} else if(row['orderby'] == '2'){
	                   		orderCost2[12] += data;
	                   		return addCommas(data);                   		
	                    } else if(row['orderby'] == '3'){
	                    	return addCommas(data.toFixed(0)) + '%';         
	                    }
						
				}
			},
           
                
        ],
        columnDefs: [
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ]           
        ],
        buttons: [
            {
                extend: 'copy',
                title: '년도별 매출계획대비 실적(금액)',
            },
            {
                extend: 'excel',
                title: '년도별 매출계획대비 실적(금액)',
            },
            {
                extend: 'print',
                title: '년도별 매출계획대비 실적(금액)',
            },
        ],
        drawCallback: function () {
			//전역변수들
			var sum1 = $('#salesPlanInfoTable5').DataTable().column(3,{ page: 'all'} ).data().sum();
			var sum2 = $('#salesPlanInfoTable5').DataTable().column(4,{ page: 'all'} ).data().sum();
			var sum3 = $('#salesPlanInfoTable5').DataTable().column(5,{ page: 'all'} ).data().sum();
			var sum4 = $('#salesPlanInfoTable5').DataTable().column(6,{ page: 'all'} ).data().sum();
			var sum5 = $('#salesPlanInfoTable5').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sum6 = $('#salesPlanInfoTable5').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sum7 = $('#salesPlanInfoTable5').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sum8 = $('#salesPlanInfoTable5').DataTable().column(10,{ page: 'all'} ).data().sum();
			var sum9 = $('#salesPlanInfoTable5').DataTable().column(11,{ page: 'all'} ).data().sum();
			var sum10 = $('#salesPlanInfoTable5').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sum11 = $('#salesPlanInfoTable5').DataTable().column(13,{ page: 'all'} ).data().sum();
			var sum12 = $('#salesPlanInfoTable5').DataTable().column(14,{ page: 'all'} ).data().sum();
			var sum13 = $('#salesPlanInfoTable5').DataTable().column(15,{ page: 'all'} ).data().sum();
			
			
			$('#totalCostSum11').text(addCommas( orderCost1[0].toFixed(0)));
			$('#totalCostSum12').text(addCommas( orderCost1[1].toFixed(0)));
			$('#totalCostSum13').text(addCommas( orderCost1[2].toFixed(0)));
			$('#totalCostSum14').text(addCommas( orderCost1[3].toFixed(0)));
			$('#totalCostSum15').text(addCommas( orderCost1[4].toFixed(0)));
			$('#totalCostSum16').text(addCommas( orderCost1[5].toFixed(0)));
			$('#totalCostSum17').text(addCommas( orderCost1[6].toFixed(0)));
			$('#totalCostSum18').text(addCommas( orderCost1[7].toFixed(0)));
			$('#totalCostSum19').text(addCommas( orderCost1[8].toFixed(0)));
			$('#totalCostSum110').text(addCommas(orderCost1[9].toFixed(0)));
			$('#totalCostSum111').text(addCommas(orderCost1[10].toFixed(0)));
			$('#totalCostSum112').text(addCommas(orderCost1[11].toFixed(0)));
			$('#totalCostSum113').text(addCommas(orderCost1[12].toFixed(0)));

			$('#totalCostSum21').text(addCommas(orderCost2[0].toFixed(0)));
			$('#totalCostSum22').text(addCommas(orderCost2[1].toFixed(0)));
			$('#totalCostSum23').text(addCommas(orderCost2[2].toFixed(0)));
			$('#totalCostSum24').text(addCommas(orderCost2[3].toFixed(0)));
			$('#totalCostSum25').text(addCommas(orderCost2[4].toFixed(0)));
			$('#totalCostSum26').text(addCommas(orderCost2[5].toFixed(0)));
			$('#totalCostSum27').text(addCommas(orderCost2[6].toFixed(0)));
			$('#totalCostSum28').text(addCommas(orderCost2[7].toFixed(0)));
			$('#totalCostSum29').text(addCommas(orderCost2[8].toFixed(0)));
			$('#totalCostSum210').text(addCommas(orderCost2[9].toFixed(0)));
			$('#totalCostSum211').text(addCommas(orderCost2[10].toFixed(0)));
			$('#totalCostSum212').text(addCommas(orderCost2[11].toFixed(0)));
			$('#totalCostSum213').text(addCommas(orderCost2[12].toFixed(0)));

		 	$('#totalCostSum31').text(addCommas((orderCost2[0]/orderCost1[0]*100).toFixed(0)) + '%');
			$('#totalCostSum32').text(addCommas((orderCost2[1]/orderCost1[1]*100).toFixed(0)) + '%');
			$('#totalCostSum33').text(addCommas((orderCost2[2]/orderCost1[2]*100).toFixed(0)) + '%');
			$('#totalCostSum34').text(addCommas((orderCost2[3]/orderCost1[3]*100).toFixed(0)) + '%');
			$('#totalCostSum35').text(addCommas((orderCost2[4]/orderCost1[4]*100).toFixed(0)) + '%');
			$('#totalCostSum36').text(addCommas((orderCost2[5]/orderCost1[5]*100).toFixed(0)) + '%');
			$('#totalCostSum37').text(addCommas((orderCost2[6]/orderCost1[6]*100).toFixed(0)) + '%');
			$('#totalCostSum38').text(addCommas((orderCost2[7]/orderCost1[7]*100).toFixed(0)) + '%');
			$('#totalCostSum39').text(addCommas((orderCost2[8]/orderCost1[8]*100).toFixed(0)) + '%');
			$('#totalCostSum310').text(addCommas((orderCost2[9]/orderCost1[9]*100).toFixed(0)) + '%');
			$('#totalCostSum311').text(addCommas((orderCost2[10]/orderCost1[10]*100).toFixed(0)) + '%');
			$('#totalCostSum312').text(addCommas((orderCost2[11]/orderCost1[11]*100).toFixed(0)) + '%');
			$('#totalCostSum313').text(addCommas((orderCost2[12]/orderCost1[12]*100).toFixed(0)) + '%'); 


        }
    });


	$('#quarter').on('change',function(){
		if($('#quarter').val() == "1"){
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(25,{ page: 'all'} ).visible(false);	
		} else if($('#quarter').val() == "2"){
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(25,{ page: 'all'} ).visible(false);	
		} else if($('#quarter').val() == "3"){
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(25,{ page: 'all'} ).visible(false);	
		} else if($('#quarter').val() == "4"){
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(25,{ page: 'all'} ).visible(true);	
		} else{
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(25,{ page: 'all'} ).visible(true);	
		}
		
	});
	
	$('#tab1').on('click', function() {
		$('#View2').addClass('d-none');
		$('#View1').removeClass('d-none');
		$('#View3').addClass('d-none');
		$('#View4').addClass('d-none');
		$('#View5').addClass('d-none');
	}); 	   

	$('#tab2').on('click', function() {
		$('#View1').addClass('d-none');
		$('#View2').removeClass('d-none');
		$('#View3').addClass('d-none');
		$('#View4').addClass('d-none');
		$('#View5').addClass('d-none');
	});

	$('#tab3').on('click', function() {
		$('#View1').addClass('d-none');
		$('#View2').addClass('d-none');
		$('#View3').removeClass('d-none');
		$('#View4').addClass('d-none');
		$('#View5').addClass('d-none');
	});

	$('#tab4').on('click', function() {
		$('#View1').addClass('d-none');
		$('#View2').addClass('d-none');
		$('#View3').addClass('d-none');
		$('#View4').removeClass('d-none');
		$('#View5').addClass('d-none');
	});

	$('#tab5').on('click', function() {
		$('#View1').addClass('d-none');
		$('#View2').addClass('d-none');
		$('#View3').addClass('d-none');
		$('#View4').addClass('d-none');
		$('#View5').removeClass('d-none');
	});
	
	// 조회
    $('#btnRetv').on('click', function() {
    	planYear = $('#planYear').val();
    	$('#salesPlanInfoTable').DataTable().ajax.reload( function () {});
    	$(".number-float2").attr("disabled", true);
    	$('#btnSave').attr("disabled",true);
    	$('#btnEdit').attr("disabled",false);
	
    });	

 // 조회
    $('#btnRetv2').on('click', function() {
    	planYear2 = $('#planYear2').val();
    	$('#salesPlanInfoTable2').DataTable().ajax.reload( function () {});
    	$(".number-float2").attr("disabled", true);
    	$('#btnSave').attr("disabled",true);
    	$('#btnEdit').attr("disabled",false);
	
    });	

    // 조회
    $('#btnRetv3').on('click', function() {
    	planYear3 = $('#planYear3').val();
    	$('#salesPlanInfoTable3').DataTable().ajax.reload( function () {});
    	$(".number-float2").attr("disabled", true);
    	$('#btnSave').attr("disabled",true);
    	$('#btnEdit').attr("disabled",false);
	
    });	

    // 조회
    $('#btnRetv4').on('click', function() {
    	for (var i = 0; i < 13; i++) {
    		order1[i] = 0;
    		order2[i] = 0;
    		order3[i] = 0;
    	} 
    	planYear4 = $('#planYear4').val();
    	$('#salesPlanInfoTable4').DataTable().ajax.reload( function () {});
    	$(".number-float2").attr("disabled", true);
    	$('#btnSave').attr("disabled",true);
    	$('#btnEdit').attr("disabled",false);
	
    });	

    // 조회
    $('#btnRetv5').on('click', function() {
    	for (var i = 0; i < 13; i++) {
    		order1[i] = 0;
    		order2[i] = 0;
    		order3[i] = 0;
    	} 
    	planYear5 = $('#planYear5').val();
    	$('#salesPlanInfoTable5').DataTable().ajax.reload( function () {});
    	$(".number-float2").attr("disabled", true);
    	$('#btnSave').attr("disabled",true);
    	$('#btnEdit').attr("disabled",false);
	
    });

	//수정
    $('#btnEdit').on('click', function() {
        if($('#salesPlanInfoTable').DataTable().data().count() != 0){
        	$(".number-float2").attr("disabled", false);
        	$('#btnSave').attr("disabled",false);
        	$('#btnEdit').attr("disabled",true);
        } else{
			toastr.warning("거래처를 선택해 주세요.");
        }
    	
    	
    });

    $('#btnSave').on('click', function() {
    	dataList = new Array();
    	$('#my-spinner').show();

		var check = true;
		if($('#planYear option:selected').val() == ""){
			toastr.warning("년도를 선택해 주세요.");
			check = false;
			return false;
		}
		if($('#dealCorpCd').val() == ""){
			toastr.warning("거래처를 선택해 주세요.");
			check = false;
			return false;
		}
    	
    	$.each($('#salesPlanInfoTable tbody tr'),function(index, item){
    		var rowData = new Object();
    		rowData.dealCorpCd = $('#dealCorpCd').val();
    		rowData.gijongCd = $(this).find('td').eq(2).text();
    		rowData.planYear = $('#planYear option:selected').val();
    		
    		rowData.janCnt  = $(this).find('td input').eq(0).val().replace(/,/g,"");
    		rowData.janCost  = $(this).find('td input').eq(1).val().replace(/,/g,"");
    		rowData.febCnt   = $(this).find('td input').eq(2).val().replace(/,/g,"");
    		rowData.febCost  = $(this).find('td input').eq(3).val().replace(/,/g,"");
    		rowData.marCnt   = $(this).find('td input').eq(4).val().replace(/,/g,"");
    		rowData.marCost  = $(this).find('td input').eq(5).val().replace(/,/g,"");
    		rowData.aprCnt   = $(this).find('td input').eq(6).val().replace(/,/g,"");
    		rowData.aprCost  = $(this).find('td input').eq(7).val().replace(/,/g,"");
    		rowData.mayCnt   = $(this).find('td input').eq(8).val().replace(/,/g,"");
    		rowData.mayCost  = $(this).find('td input').eq(9).val().replace(/,/g,"");
    		rowData.junCnt   = $(this).find('td input').eq(10).val().replace(/,/g,"");
    		rowData.junCost  = $(this).find('td input').eq(11).val().replace(/,/g,"");
    		rowData.julCnt   = $(this).find('td input').eq(12).val().replace(/,/g,"");
    		rowData.julCost  = $(this).find('td input').eq(13).val().replace(/,/g,"");
    		rowData.augCnt   = $(this).find('td input').eq(14).val().replace(/,/g,"");
    		rowData.augCost  = $(this).find('td input').eq(15).val().replace(/,/g,"");
    		rowData.sepCnt   = $(this).find('td input').eq(16).val().replace(/,/g,"");
    		rowData.sepCost  = $(this).find('td input').eq(17).val().replace(/,/g,"");
    		rowData.octCnt   = $(this).find('td input').eq(18).val().replace(/,/g,"");
    		rowData.octCost  = $(this).find('td input').eq(19).val().replace(/,/g,"");
    		rowData.novCnt   = $(this).find('td input').eq(20).val().replace(/,/g,"");
    		rowData.novCost  = $(this).find('td input').eq(21).val().replace(/,/g,"");
    		rowData.decCnt   = $(this).find('td input').eq(22).val().replace(/,/g,"");
    		rowData.decCost  = $(this).find('td input').eq(23).val().replace(/,/g,"");
    		

    		dataList.push(rowData);
    	});
			
		if(check){
	    	$.ajax({		    	
		      	url: '<c:url value="/bs/salesPlanAdmCreate"/>',
		        type: 'POST',
		        datatype: 'json',
		        data: JSON.stringify(dataList),
		        contentType : "application/json; charset=UTF-8",
		        success: function(result){
		        	if(result.result == "ok"){		        		
		        		$('#salesPlanInfoTable').DataTable().ajax.reload( function () {});
						$('.number-float2').attr('disabled',true);		   
						$('#btnSave').attr("disabled",true);
				    	$('#btnEdit').attr("disabled",false);   			
		      			toastr.success('저장되었습니다.');
		        	} else if(result.result == "fail"){
		        		toastr.error(result.message, '', {timeOut: 5000});
		        	}
		        	else{
		        		toastr.error(result.message, '', {timeOut: 5000});
		        	}
		        },
				complete:function(){
					$('#my-spinner').hide();
				}
	       	});
		} else{
			$('#my-spinner').hide();
		}
       	
		
    });

    $(document).on('keyup','.number-float2', function(event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
			$('.number-float2').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
 			$(this).select();
			toastr.warning('최대 크기를 초과하였습니다.');
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
 			$(this).select();
			toastr.warning('최소 크기를 초과하였습니다.');
			return false;
		}
		
 		var _pattern2 = /^\d*[.]\d{3}$/;
        if (_pattern2.test( $(this).val())) {
        	toastr.warning("소수점 둘째 자리까지 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
        }
		if($(this).val().split('.').length >= 10) {
			toastr.warning('소수점기호는 한번만 입력 가능합니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
	});

    function setDateBox(){
        var dt = new Date();
        var year = "";
        var com_year = dt.getFullYear();
        // 발행 뿌려주기
        //$("#planYear").append("<option value=''>년도</option>");
        // 올해 기준으로 -1년부터 +5년을 보여준다.
        for(var y = (com_year-3); y <= (com_year+5); y++){
            $("#planYear").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
            $("#planYear2").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
            $("#planYear3").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
            $("#planYear4").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
            $("#planYear5").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
        }
        $('#planYear').val(dt.getFullYear());
        $('#planYear2').val(dt.getFullYear());
        $('#planYear3').val(dt.getFullYear());
        $('#planYear4').val(dt.getFullYear());
        $('#planYear5').val(dt.getFullYear());
    }

  //거래처정보조회 팝업 시작
   	var dealCorpPopUpTable;
   	function selectDealCorp()
   	{
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
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
		        rowId: 'dealCorpCd',
		        columns: [
		            { data: 'dealCorpCd' },
		            { data: 'dealCorpNm' },
		            { data: 'initial' },
		            { data: 'presidentNm' },
		            { data: 'country' },
		            { data: 'corpNo' },
		        ],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });
		    
		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable.row( this ).data();
				$('#dealCorpCd').val(data.dealCorpCd);
				$('#dealCorpNm').val(data.dealCorpNm);
                $('#dealCorpPopUpModal').modal('hide');
		    });
		} else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload();
		}
		
		$('#dealCorpPopUpModal').modal('show');		
   	}   	
	//거래처정보조회 팝업 종료  


</script>


</body>
</html>