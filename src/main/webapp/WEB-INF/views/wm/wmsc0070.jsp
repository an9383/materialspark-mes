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
									<th rowspan="2" style="min-width:60px;" class="text-center">목표<br>총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">목표 양품<br>생산량<br>달성률(%)</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center">총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">양품 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">폐기loss 율</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center">메탈교체 율</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">필름교체 율</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">실리콘<br>교체 율</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">테프론<br>교체 율</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center">교체loss</th>
									<th colspan="5" style="min-width:80px;" class="text-center">외관불량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${processFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${matrlFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${replaceFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${troubleFaultyNm}<br>불량률</th>
									
									<th colspan="3" style="min-width:80px;" class="text-center">${processFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${matrlFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${replaceFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${troubleFaultyNm}</th>
									
								</tr>
								<tr>
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">총합</th>
									<th style="min-width:60px" class="text-center">외관</th>
									<th style="min-width:60px" class="text-center">엣지</th>
									<th style="min-width:60px" class="text-center">출하</th>
									<th style="min-width:60px" class="text-center">재검</th>									
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
									<td colspan="" id="sumTargetCnt1" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPercent1" style="text-align: right">0</td>									
									
									<td colspan="" id="sumTotalOutputCnt1" style="text-align: right">0</td>
									<td colspan="" id="sumOutputNomal1" style="text-align: right">0</td>
									<td colspan="" id="sumOutputCnt1" style="text-align: right">0</td>
									<td colspan="" id="sumFaultyPercent1" style="text-align: right">0</td>
									
									<td colspan="" id="sumMetalEa1" style="text-align: right">0</td>
									<td colspan="" id="sumFilmEa1" style="text-align: right">0</td>
									<td colspan="" id="sumSiliconEa1" style="text-align: right">0</td>
									<td colspan="" id="sumTeflonEa1" style="text-align: right">0</td>
									
									<td colspan="" id="sumFaultyCnt1" style="text-align: right">0</td>
									
									<td colspan="" id="outputFaultyCnt1" style="text-align: right">0</td>
									<td colspan="" id="appearFaultyCnt1" style="text-align: right">0</td>
									<td colspan="" id="edgeFaultyCnt1" style="text-align: right">0</td>
									<td colspan="" id="shipFaultyCnt1" style="text-align: right">0</td>
									<td colspan="" id="reShipFaultyCnt1" style="text-align: right">0</td>
									
									
									<td colspan="" id="sumProcessPercent1" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlPercent1" style="text-align: right">0</td>
									<td colspan="" id="sumReplacePercent1" style="text-align: right">0</td>
									<td colspan="" id="sumTroublePercent1" style="text-align: right">0</td>
									
									<td colspan="" id="sumProcessCount1" style="text-align: right">0</td>
									<td colspan="" id="sumProcessKg1" style="text-align: right">0</td>
									<td colspan="" id="sumProcessEa1" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlCount1" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlKg1" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlEa1" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceCount1" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceKg1" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceEa1" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleCount1" style="text-align: right">0</td>
									<td colspan="" id="sumTrougleKg1" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleEa1" style="text-align: right">0</td>									
																		
									
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
									<th rowspan="2" style="min-width:60px;" class="text-center">목표<br>총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">목표 양품<br>생산량<br>달성률(%)</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center">총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">양품 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">교체loss 율</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">교체loss</th>
									<th colspan="5" style="min-width:80px;" class="text-center">외관불량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${processFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${matrlFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${replaceFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${troubleFaultyNm}<br>불량률</th>
									
									<th colspan="3" style="min-width:80px;" class="text-center">${processFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${matrlFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${replaceFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${troubleFaultyNm}</th>
								</tr>
								<tr>
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">총합</th>
									<th style="min-width:60px" class="text-center">외관</th>
									<th style="min-width:60px" class="text-center">엣지</th>
									<th style="min-width:60px" class="text-center">출하</th>
									<th style="min-width:60px" class="text-center">재검</th>			
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
									<td colspan="" id="sumTargetCnt2" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPercent2" style="text-align: right">0</td>
									
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
									
									<td colspan="" id="sumProcessPercent2" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlPercent2" style="text-align: right">0</td>
									<td colspan="" id="sumReplacePercent2" style="text-align: right">0</td>
									<td colspan="" id="sumTroublePercent2" style="text-align: right">0</td>
									
									<td colspan="" id="sumProcessCount2" style="text-align: right">0</td>
									<td colspan="" id="sumProcessKg2" style="text-align: right">0</td>
									<td colspan="" id="sumProcessEa2" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlCount2" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlKg2" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlEa2" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceCount2" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceKg2" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceEa2" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleCount2" style="text-align: right">0</td>
									<td colspan="" id="sumTrougleKg2" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleEa2" style="text-align: right">0</td>
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
									<th rowspan="2" style="min-width:60px;" class="text-center">목표<br>총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">목표 양품<br>생산량<br>달성률(%)</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center">총 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">양품 생산량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">교체loss 율</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">교체loss</th>
									<th colspan="5" style="min-width:80px;" class="text-center">외관불량</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${processFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${matrlFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${replaceFaultyNm}<br>불량률</th>
									<th rowspan="2" style="min-width:60px;" class="text-center">${troubleFaultyNm}<br>불량률</th>
									
									<th colspan="3" style="min-width:80px;" class="text-center">${processFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${matrlFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${replaceFaultyNm}</th>
									<th colspan="3" style="min-width:80px;" class="text-center">${troubleFaultyNm}</th>								
								</tr>
								<tr>
									<th style="border-right:solid #d6d8e1 1px; min-width:60px;" class="text-center">총합</th>
									<th style="min-width:60px" class="text-center">외관</th>
									<th style="min-width:60px" class="text-center">엣지</th>
									<th style="min-width:60px" class="text-center">출하</th>
									<th style="min-width:60px" class="text-center">재검</th>	
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
									<td colspan="" id="sumTargetCnt3" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPercent3" style="text-align: right">0</td>
									
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
									
									<td colspan="" id="sumProcessPercent3" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlPercent3" style="text-align: right">0</td>
									<td colspan="" id="sumReplacePercent3" style="text-align: right">0</td>
									<td colspan="" id="sumTroublePercent3" style="text-align: right">0</td>
									
									<td colspan="" id="sumProcessCount3" style="text-align: right">0</td>
									<td colspan="" id="sumProcessKg3" style="text-align: right">0</td>
									<td colspan="" id="sumProcessEa3" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlCount3" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlKg3" style="text-align: right">0</td>
									<td colspan="" id="sumMatrlEa3" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceCount3" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceKg3" style="text-align: right">0</td>
									<td colspan="" id="sumReplaceEa3" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleCount3" style="text-align: right">0</td>
									<td colspan="" id="sumTrougleKg3" style="text-align: right">0</td>
									<td colspan="" id="sumTroubleEa3" style="text-align: right">0</td>

								</tr>
							</tfoot>
						</table>
					</div>
					<div id="tabContent4">
						
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
	let menuAuth = 'wmsc0070';
	let currentHref = 'wmsc0070';
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
	var processFaultyNm =  "${processFaultyNm}";
	var matrlFaultyNm =  "${matrlFaultyNm}";
	var replaceFaultyNm =  "${replaceFaultyNm}";
	var troubleFaultyNm =  "${troubleFaultyNm}";
	
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
			{ data: 'sumTargetCnt' },
			{ data: '',	//목표 양품생산량 %
				render: function(data, type, row) {
					let temp = (row['sumOutputCnt'] / row['sumTargetCnt'] * 100).toFixed(1);
					if (temp == 'NaN') {
						return '0.0 %';
					} else {
						return addCommas(temp) + ' %';		
					}
				}
            },
			{ data: '',	//총생산량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])+ parseFloat(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            { data: '',	//생산량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
				}
            },
			{ data: 'sumOutputCnt' },
			
			{ data: '',	//불량률
				render: function(data, type, row) {
					//불량수량
					let totalFaultyEa = parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])
					let faultyPercent = (totalFaultyEa / (parseFloat(row['sumOutputCnt']) + totalFaultyEa) * 100).toFixed(2);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            
            
            
            { data: '',	//메탈교체 률
				render: function(data, type, row) {
					//불량수량
					let ea = parseFloat(parseFloat(row['metalEa']).toFixed(2));
					let totalFaultyEa = (parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])+ parseFloat(row['outputFaultyCnt'])).toFixed(0);
					
					let faultyPercent = (ea / (parseFloat(row['sumOutputCnt']) + parseFloat(totalFaultyEa)) * 100).toFixed(2);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//필름교체 률
				render: function(data, type, row) {
					//불량수량
					let ea = parseFloat(parseFloat(row['filmEa']).toFixed(2));
					let totalFaultyEa = (parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])+ parseFloat(row['outputFaultyCnt'])).toFixed(0);
					
					let faultyPercent = (ea / (parseFloat(row['sumOutputCnt']) + parseFloat(totalFaultyEa)) * 100).toFixed(2);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//실리콘교체 률
				render: function(data, type, row) {
					//불량수량
					let ea = parseFloat(parseFloat(row['siliconEa']).toFixed(2));
					let totalFaultyEa = (parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])+ parseFloat(row['outputFaultyCnt'])).toFixed(0);
					
					let faultyPercent = (ea / (parseFloat(row['sumOutputCnt']) + parseFloat(totalFaultyEa)) * 100).toFixed(2);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            { data: '',	//테프론교체 률
				render: function(data, type, row) {
					//불량수량
					let ea = parseFloat(parseFloat(row['teflonEa']).toFixed(2));
					let totalFaultyEa = (parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])+ parseFloat(row['outputFaultyCnt'])).toFixed(0);
					
					let faultyPercent = (ea / (parseFloat(row['sumOutputCnt']) + parseFloat(totalFaultyEa)) * 100).toFixed(2);
					if (faultyPercent == 'NaN' || totalFaultyEa == '0') {
						return '0.0 %';
					} else {
						return addCommas(faultyPercent) + ' %';
					}
				}
            },
            
            
            
            
            
            
			{ data: '',	//불량수량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa'])).toFixed(0)  );
				}
            },
            { data: 'outputFaultyCnt' },
        	{ data: 'appearFaultyCnt' },
			{ data: 'edgeFaultyCnt' },
			{ data: 'shipFaultyCnt' },
			{ data: 'reShipFaultyCnt' },			
			{ data: '',	//processFaultyNm 불량률(%)
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
            },
            { data: 'prcsCnt'},		//횟수
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
			 },
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
		
		],
        columnDefs: [
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34], className: 'text-right' },
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
            },
            {
                extend: 'print',
                title: '생산실적관리 - 기종별',
            },
        ],
		drawCallback: function () {
			//9이상
			//+4해주기
			$('#outputTable1 tfoot').remove();
			//총 목표수량
			let sumTargetCnt1		=	$('#outputTable1').DataTable().column(3,{ page: 'all'} ).data().sum();
			//양품 생산량
			let sumOutputCnt1		=	$('#outputTable1').DataTable().column(7,{ page: 'all'} ).data().sum();
			// 생산량
			let sumOutputNomal1		=	$('#outputTable1').DataTable().column(7,{ page: 'all'} ).data().sum() 
										+ $('#outputTable1').DataTable().column(14,{ page: 'all'} ).data().sum();
			
			//목표 양품 생산량 달성률(%)
			let sumOutputPercent1	=	(sumOutputCnt1 / sumTargetCnt1 * 100).toFixed(1) + ' %';
			//총 생산량
			let sumTotalOutputCnt1	=	parseFloat($('#outputTable1').DataTable().column(7,{ page: 'all'} ).data().sum())
									 	+ parseFloat($('#outputTable1').DataTable().column(14,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable1').DataTable().column(25,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable1').DataTable().column(28,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable1').DataTable().column(31,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable1').DataTable().column(34,{ page: 'all'} ).data().sum());
			
			let sumFaultyCnt1 		=	parseFloat($('#outputTable1').DataTable().column(25,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable1').DataTable().column(28,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable1').DataTable().column(31,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable1').DataTable().column(34,{ page: 'all'} ).data().sum());
										

			let sumMetalEa1			=	parseFloat($('#outputTable1').DataTable().column(9,{ page: 'all'} ).data().sum());
			let sumFilmEa1			=	parseFloat($('#outputTable1').DataTable().column(10,{ page: 'all'} ).data().sum());
			let sumSiliconEa1		=	parseFloat($('#outputTable1').DataTable().column(11,{ page: 'all'} ).data().sum());
			let sumTrflonEa1		=	parseFloat($('#outputTable1').DataTable().column(12,{ page: 'all'} ).data().sum());
			
			
			//불량률(%)
			let sumFaultyPercent1	=	(sumFaultyCnt1 / sumTotalOutputCnt1 * 100).toFixed(2) + ' %';
			
			//메탈, 필름, 실리콘, 테프론
			let sumMetalPercent1	= 0;
			let sumFilmPercent1		= 0;
			let sumSiliconPercent1	= 0;
			let sumTrflonPercent1	= 0;
			
			var api = this.api();
			data = api.data();
			if( data.count() != 0 ) {
				//data.reduce((prev, current) => prev + parseFloat(current.metalEa), 0);	//render로 작성된 내용 중 data에서 metalEa만 추출해 합산
				sumMetalPercent1	=	(data.reduce((prev, current) => prev + parseFloat(current.metalEa), 0) / sumTotalOutputCnt1 * 100).toFixed(2) + ' %';
				sumFilmPercent1		=	(data.reduce((prev, current) => prev + parseFloat(current.filmEa), 0) / sumTotalOutputCnt1 * 100).toFixed(2) + ' %';
				sumSiliconPercent1	=	(data.reduce((prev, current) => prev + parseFloat(current.siliconEa), 0) / sumTotalOutputCnt1 * 100).toFixed(2) + ' %';
				sumTrflonPercent1	=	(data.reduce((prev, current) => prev + parseFloat(current.teflonEa), 0) / sumTotalOutputCnt1 * 100).toFixed(2) + ' %';	
			}
			

			let sumProcessCount1	=	$('#outputTable1').DataTable().column(23,{ page: 'all'} ).data().sum();
			let sumProcessKg1		=	$('#outputTable1').DataTable().column(24,{ page: 'all'} ).data().sum();
			let sumProcessEa1		=	parseFloat($('#outputTable1').DataTable().column(25,{ page: 'all'} ).data().sum()).toFixed(0);
			let sumMatrlCount1		=	$('#outputTable1').DataTable().column(26,{ page: 'all'} ).data().sum();
			let sumMatrlKg1			=	$('#outputTable1').DataTable().column(27,{ page: 'all'} ).data().sum();
			let sumMatrlEa1			=	parseFloat($('#outputTable1').DataTable().column(28,{ page: 'all'} ).data().sum()).toFixed(0);
			let sumReplaceCount1	=	$('#outputTable1').DataTable().column(29,{ page: 'all'} ).data().sum();
			let sumReplaceKg1		=	$('#outputTable1').DataTable().column(30,{ page: 'all'} ).data().sum();
			let sumReplaceEa1		=	parseFloat($('#outputTable1').DataTable().column(31,{ page: 'all'} ).data().sum()).toFixed(0);
			let sumTroubleCount1	=	$('#outputTable1').DataTable().column(32,{ page: 'all'} ).data().sum();
			let sumTrougleKg1		=	$('#outputTable1').DataTable().column(33,{ page: 'all'} ).data().sum();
			let sumTroubleEa1		=	parseFloat($('#outputTable1').DataTable().column(34,{ page: 'all'} ).data().sum()).toFixed(0);
			
			let sumProcessPercent1 = (sumProcessEa1 / sumTotalOutputCnt1 * 100).toFixed(1) + ' %';
			let sumMatrlPercent1 = (sumMatrlEa1 / sumTotalOutputCnt1 * 100).toFixed(1) + ' %';
			let sumReplacePercent1 = (sumReplaceEa1 / sumTotalOutputCnt1 * 100).toFixed(1) + ' %';
			let sumTroublePercent1 = (sumTroubleEa1 / sumTotalOutputCnt1 * 100).toFixed(1) + ' %';

		
			let appearFaultyCnt = $('#outputTable1').DataTable().column(15,{ page: 'all'} ).data().sum();
			let edgeFaultyCnt   = $('#outputTable1').DataTable().column(16,{ page: 'all'} ).data().sum();
			let shipFaultyCnt   = $('#outputTable1').DataTable().column(17,{ page: 'all'} ).data().sum();
			let reShipFaultyCnt = $('#outputTable1').DataTable().column(18,{ page: 'all'} ).data().sum();
			let outputFaultyCnt = $('#outputTable1').DataTable().column(14,{ page: 'all'} ).data().sum();

			
            
			$('#sumTargetCnt1').text(addCommas(sumTargetCnt1));
			$('#sumOutputNomal1').text(addCommas(sumOutputNomal1));
			$('#sumOutputPercent1').text(addCommas(sumOutputPercent1));
			$('#sumTotalOutputCnt1').text(addCommas(parseFloat(sumTotalOutputCnt1).toFixed(0)));
			$('#sumOutputCnt1').text(addCommas(sumOutputCnt1));
			$('#sumFaultyPercent1').text(addCommas(sumFaultyPercent1));
			
			//메탈, 필름, 실리콘, 테프론
			$('#sumMetalEa1').text(addCommas(sumMetalPercent1));
			$('#sumFilmEa1').text(addCommas(sumFilmPercent1));
			$('#sumSiliconEa1').text(addCommas(sumSiliconPercent1));
			$('#sumTeflonEa1').text(addCommas(sumTrflonPercent1));
			
			$('#sumFaultyCnt1').text(addCommas(parseFloat(sumFaultyCnt1).toFixed(0)));
			
			$('#sumProcessPercent1').text(addCommas(sumProcessPercent1));
			$('#sumMatrlPercent1').text(addCommas(sumMatrlPercent1));
			$('#sumReplacePercent1').text(addCommas(sumReplacePercent1));
			$('#sumTroublePercent1').text(addCommas(sumTroublePercent1));

			$('#sumProcessCount1').text(addCommas(sumProcessCount1));
			$('#sumProcessKg1').text(sumProcessKg1.toFixed(3));
			$('#sumProcessEa1').text(addCommas(sumProcessEa1));
			$('#sumMatrlCount1').text(addCommas(sumMatrlCount1));
			$('#sumMatrlKg1').text(sumMatrlKg1.toFixed(3));
			$('#sumMatrlEa1').text(addCommas(sumMatrlEa1));
			$('#sumReplaceCount1').text(addCommas(sumReplaceCount1));
			$('#sumReplaceKg1').text(sumReplaceKg1.toFixed(3));
			$('#sumReplaceEa1').text(addCommas(sumReplaceEa1));
			$('#sumTroubleCount1').text(addCommas(sumTroubleCount1));
			$('#sumTrougleKg1').text(sumTrougleKg1.toFixed(3));
			$('#sumTroubleEa1').text(addCommas(sumTroubleEa1));

			$('#appearFaultyCnt1').text(addCommas(appearFaultyCnt));
			$('#edgeFaultyCnt1').text(addCommas(edgeFaultyCnt));
			$('#shipFaultyCnt1').text(addCommas(shipFaultyCnt));
			$('#reShipFaultyCnt1').text(addCommas(reShipFaultyCnt));
			$('#outputFaultyCnt1').text(addCommas(outputFaultyCnt));
			
			
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
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary float-right bumlye">범례</button></div>';

	$('#outputTable1_length').html(html1);
	$('#chooseDateFromCal1').val(chooseDateFrom);
	$('#chooseDateToCal1').val(chooseDateTo);
	
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
			{ data: 'sumTargetCnt' },
			{ data: '',	//목표 양품생산량 %
				render: function(data, type, row) {
					let temp = (row['sumOutputCnt'] / row['sumTargetCnt'] * 100).toFixed(1);
					if (temp == 'NaN') {
						return '0.0 %';
					} else {
						return addCommas(temp) + ' %';		
					}
				}
            },
			{ data: '',	//총생산량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            { data: '',	//생산량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
				}
            },
			{ data: 'sumOutputCnt' },
			{ data: '',	//불량률
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
            },
            { data: 'outputFaultyCnt' },
        	{ data: 'appearFaultyCnt' },
			{ data: 'edgeFaultyCnt' },
			{ data: 'shipFaultyCnt' },
			{ data: 'reShipFaultyCnt' },
			{ data: '',	//processFaultyNm 불량률(%)
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
            },
            { data: 'prcsCnt'},		//횟수
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
			 },
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
		],
        columnDefs: [
        	{ targets: [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32], className: 'text-right' },
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
            },
            {
                extend: 'print',
                title: '생산실적관리 - 라인별',
            },
        ],
		drawCallback: function () {
			$('#outputTable2 tfoot').remove();
			//총 목표수량
			let sumTargetCnt2		=	$('#outputTable2').DataTable().column(5,{ page: 'all'} ).data().sum();
			//양품 생산량
			let sumOutputCnt2		=	$('#outputTable2').DataTable().column(9,{ page: 'all'} ).data().sum()
			//목표 양품 생산량 달성률(%)
			let sumOutputPercent2	=	(sumOutputCnt2 / sumTargetCnt2 * 100).toFixed(1) + ' %';
			//총 생산량
			let sumTotalOutputCnt2	=	parseFloat($('#outputTable2').DataTable().column(9,{ page: 'all'} ).data().sum())
									 	+ parseFloat($('#outputTable2').DataTable().column(23,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable2').DataTable().column(26,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable2').DataTable().column(29,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable2').DataTable().column(32,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable2').DataTable().column(12,{ page: 'all'} ).data().sum());
			
			let sumFaultyCnt2 		=	parseFloat($('#outputTable2').DataTable().column(23,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable2').DataTable().column(26,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable2').DataTable().column(29,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable2').DataTable().column(32,{ page: 'all'} ).data().sum());
            
			//불량률(%)
			let sumFaultyPercent2	=	(sumFaultyCnt2 / sumTotalOutputCnt2 * 100).toFixed(1) + ' %';

			let sumProcessCount2	=	$('#outputTable2').DataTable().column(21,{ page: 'all'} ).data().sum();
			let sumProcessKg2		=	$('#outputTable2').DataTable().column(22,{ page: 'all'} ).data().sum();
			let sumProcessEa2		=	parseFloat($('#outputTable2').DataTable().column(23,{ page: 'all'} ).data().sum());
			let sumMatrlCount2		=	$('#outputTable2').DataTable().column(24,{ page: 'all'} ).data().sum();
			let sumMatrlKg2			=	$('#outputTable2').DataTable().column(25,{ page: 'all'} ).data().sum();
			let sumMatrlEa2			=	parseFloat($('#outputTable2').DataTable().column(26,{ page: 'all'} ).data().sum());
			let sumReplaceCount2	=	$('#outputTable2').DataTable().column(27,{ page: 'all'} ).data().sum();
			let sumReplaceKg2		=	$('#outputTable2').DataTable().column(28,{ page: 'all'} ).data().sum();
			let sumReplaceEa2		=	parseFloat($('#outputTable2').DataTable().column(29,{ page: 'all'} ).data().sum());
			let sumTroubleCount2	=	$('#outputTable2').DataTable().column(30,{ page: 'all'} ).data().sum();
			let sumTrougleKg2		=	$('#outputTable2').DataTable().column(31,{ page: 'all'} ).data().sum();
			let sumTroubleEa2		=	parseFloat($('#outputTable2').DataTable().column(32,{ page: 'all'} ).data().sum());
			
			let sumProcessPercent2 = (sumProcessEa2 / sumTotalOutputCnt2 * 100).toFixed(1) + ' %';
			let sumMatrlPercent2 = (sumMatrlEa2 / sumTotalOutputCnt2 * 100).toFixed(1) + ' %';
			let sumReplacePercent2 = (sumReplaceEa2 / sumTotalOutputCnt2 * 100).toFixed(1) + ' %';
			let sumTroublePercent2 = (sumTroubleEa2 / sumTotalOutputCnt2 * 100).toFixed(1) + ' %';

			// 생산량
			let sumOutputNomal		=	$('#outputTable2').DataTable().column(9,{ page: 'all'} ).data().sum() 
										+ $('#outputTable2').DataTable().column(12,{ page: 'all'} ).data().sum();

			let outputFaultyCnt = $('#outputTable2').DataTable().column(12,{ page: 'all'} ).data().sum();
			let appearFaultyCnt = $('#outputTable2').DataTable().column(13,{ page: 'all'} ).data().sum();
			let edgeFaultyCnt   = $('#outputTable2').DataTable().column(14,{ page: 'all'} ).data().sum();
			let shipFaultyCnt   = $('#outputTable2').DataTable().column(15,{ page: 'all'} ).data().sum();
			let reShipFaultyCnt = $('#outputTable2').DataTable().column(16,{ page: 'all'} ).data().sum();
			
            
			$('#sumTargetCnt2').text(addCommas(sumTargetCnt2));
			$('#sumOutputNomal2').text(addCommas(sumOutputNomal));
			$('#sumOutputPercent2').text(addCommas(sumOutputPercent2));
			$('#sumTotalOutputCnt2').text(addCommas(parseFloat(sumTotalOutputCnt2).toFixed(0)));
			$('#sumOutputCnt2').text(addCommas(sumOutputCnt2));
			$('#sumFaultyPercent2').text(addCommas(sumFaultyPercent2));
			$('#sumFaultyCnt2').text(addCommas(parseFloat(sumFaultyCnt2).toFixed(0)));
			
			$('#sumProcessPercent2').text(addCommas(sumProcessPercent2));
			$('#sumMatrlPercent2').text(addCommas(sumMatrlPercent2));
			$('#sumReplacePercent2').text(addCommas(sumReplacePercent2));
			$('#sumTroublePercent2').text(addCommas(sumTroublePercent2));

			$('#appearFaultyCnt2').text(addCommas(appearFaultyCnt));
			$('#edgeFaultyCnt2').text(addCommas(edgeFaultyCnt));
			$('#shipFaultyCnt2').text(addCommas(shipFaultyCnt));
			$('#reShipFaultyCnt2').text(addCommas(reShipFaultyCnt));
			$('#outputFaultyCnt2').text(addCommas(outputFaultyCnt));

			$('#sumProcessCount2').text(addCommas(sumProcessCount2));
			$('#sumProcessKg2').text(sumProcessKg2.toFixed(3));
			$('#sumProcessEa2').text(addCommas(parseFloat(sumProcessEa2).toFixed(0)));
			$('#sumMatrlCount2').text(addCommas(sumMatrlCount2));
			$('#sumMatrlKg2').text(sumMatrlKg2.toFixed(3));
			$('#sumMatrlEa2').text(addCommas(parseFloat(sumMatrlEa2).toFixed(0)));
			$('#sumReplaceCount2').text(addCommas(sumReplaceCount2));
			$('#sumReplaceKg2').text(sumReplaceKg2.toFixed(3));
			$('#sumReplaceEa2').text(addCommas(parseFloat(sumReplaceEa2).toFixed(0)));
			$('#sumTroubleCount2').text(addCommas(sumTroubleCount2));
			$('#sumTrougleKg2').text(sumTrougleKg2.toFixed(3));
			$('#sumTroubleEa2').text(addCommas(parseFloat(sumTroubleEa2).toFixed(0)));
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
			{ data: 'sumTargetCnt' },
			{ data: '',	//목표 양품생산량 %
				render: function(data, type, row) {
					let temp = (row['sumOutputCnt'] / row['sumTargetCnt'] * 100).toFixed(1);
					if (temp == 'NaN') {
						return '0.0 %';
					} else {
						return addCommas(temp) + ' %';		
					}
				}
            },
            { data: '',	//총생산량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['prcsEa']) + parseFloat(row['matrlEa']) + parseFloat(row['rpcEa']) + parseFloat(row['trbEa']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
				}
            },
            { data: '',	//생산량
				render: function(data, type, row) {
					return addCommas((parseFloat(row['sumOutputCnt']) + parseFloat(row['outputFaultyCnt'])).toFixed(0));
				}
            },
			{ data: 'sumOutputCnt' },
			{ data: '',	//불량률
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
            },
            { data: 'outputFaultyCnt' },
        	{ data: 'appearFaultyCnt' },
			{ data: 'edgeFaultyCnt' },
			{ data: 'shipFaultyCnt' },
			{ data: 'reShipFaultyCnt' },
			{ data: '',	//processFaultyNm 불량률(%)
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
            },
            { data: 'prcsCnt'},		//횟수
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
			 },
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
		],
        columnDefs: [
        	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31], className: 'text-right' },
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
            },
            {
                extend: 'print',
                title: '생산실적관리 - 직원별',
            },
        ],
		drawCallback: function () {

			$('#outputTable3 tfoot').remove();
			//총 목표수량
			let sumTargetCnt3		=	$('#outputTable3').DataTable().column(4,{ page: 'all'} ).data().sum();
			//양품 생산량
			let sumOutputCnt3		=	$('#outputTable3').DataTable().column(8,{ page: 'all'} ).data().sum();

			// 생산량
			let sumOutputNomal3		=	$('#outputTable3').DataTable().column(8,{ page: 'all'} ).data().sum() 
										+ $('#outputTable3').DataTable().column(11,{ page: 'all'} ).data().sum();
			
			//목표 양품 생산량 달성률(%)
			let sumOutputPercent3	=	(sumOutputCnt3 / sumTargetCnt3 * 100).toFixed(1) + ' %';
			//총 생산량
			let sumTotalOutputCnt3	=	parseFloat($('#outputTable3').DataTable().column(8,{ page: 'all'} ).data().sum())
									 	+ parseFloat($('#outputTable3').DataTable().column(22,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable3').DataTable().column(25,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable3').DataTable().column(28,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable3').DataTable().column(31,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable3').DataTable().column(11,{ page: 'all'} ).data().sum());
			
			let sumFaultyCnt3 		=	parseFloat($('#outputTable3').DataTable().column(22,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable3').DataTable().column(25,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable3').DataTable().column(28,{ page: 'all'} ).data().sum())
										+ parseFloat($('#outputTable3').DataTable().column(31,{ page: 'all'} ).data().sum());
            
			//불량률(%)
			let sumFaultyPercent3	=	(sumFaultyCnt3 / sumTotalOutputCnt3 * 100).toFixed(1) + ' %';
			
			let sumProcessCount3	=	$('#outputTable3').DataTable().column(20,{ page: 'all'} ).data().sum();
			let sumProcessKg3		=	$('#outputTable3').DataTable().column(21,{ page: 'all'} ).data().sum();
			let sumProcessEa3		=	parseFloat($('#outputTable3').DataTable().column(22,{ page: 'all'} ).data().sum());
			let sumMatrlCount3		=	$('#outputTable3').DataTable().column(23,{ page: 'all'} ).data().sum();
			let sumMatrlKg3			=	$('#outputTable3').DataTable().column(24,{ page: 'all'} ).data().sum();
			let sumMatrlEa3			=	parseFloat($('#outputTable3').DataTable().column(25,{ page: 'all'} ).data().sum());
			let sumReplaceCount3	=	$('#outputTable3').DataTable().column(26,{ page: 'all'} ).data().sum();
			let sumReplaceKg3		=	$('#outputTable3').DataTable().column(27,{ page: 'all'} ).data().sum();
			let sumReplaceEa3		=	parseFloat($('#outputTable3').DataTable().column(28,{ page: 'all'} ).data().sum());
			let sumTroubleCount3	=	$('#outputTable3').DataTable().column(29,{ page: 'all'} ).data().sum();
			let sumTrougleKg3		=	$('#outputTable3').DataTable().column(30,{ page: 'all'} ).data().sum();
			let sumTroubleEa3		=	parseFloat($('#outputTable3').DataTable().column(31,{ page: 'all'} ).data().sum());
			
			let sumProcessPercent3 = (sumProcessEa3 / sumTotalOutputCnt3 * 100).toFixed(1) + ' %';
			let sumMatrlPercent3 = (sumMatrlEa3 / sumTotalOutputCnt3 * 100).toFixed(1) + ' %';
			let sumReplacePercent3 = (sumReplaceEa3 / sumTotalOutputCnt3 * 100).toFixed(1) + ' %';
			let sumTroublePercent3 = (sumTroubleEa3 / sumTotalOutputCnt3 * 100).toFixed(1) + ' %';

			let appearFaultyCnt = $('#outputTable3').DataTable().column(12,{ page: 'all'} ).data().sum();
			let edgeFaultyCnt   = $('#outputTable3').DataTable().column(13,{ page: 'all'} ).data().sum();
			let shipFaultyCnt   = $('#outputTable3').DataTable().column(14,{ page: 'all'} ).data().sum();
			let reShipFaultyCnt = $('#outputTable3').DataTable().column(15,{ page: 'all'} ).data().sum();
			let outputFaultyCnt = $('#outputTable3').DataTable().column(11,{ page: 'all'} ).data().sum();

			
            
			$('#sumTargetCnt3').text(addCommas(sumTargetCnt3));
			$('#sumOutputNomal3').text(addCommas(sumOutputNomal3));
			$('#sumOutputPercent3').text(addCommas(sumOutputPercent3));
			$('#sumTotalOutputCnt3').text(addCommas(parseFloat(sumTotalOutputCnt3).toFixed(0)));
			$('#sumOutputCnt3').text(addCommas(parseFloat(sumOutputCnt3).toFixed(0)));
			$('#sumFaultyPercent3').text(addCommas(sumFaultyPercent3));
			$('#sumFaultyCnt3').text(addCommas(parseFloat(sumFaultyCnt3).toFixed(0)));
			
			$('#sumProcessPercent3').text(addCommas(sumProcessPercent3));
			$('#sumMatrlPercent3').text(addCommas(sumMatrlPercent3));
			$('#sumReplacePercent3').text(addCommas(sumReplacePercent3));
			$('#sumTroublePercent3').text(addCommas(sumTroublePercent3));

			$('#sumProcessCount3').text(addCommas(sumProcessCount3));
			$('#sumProcessKg3').text(sumProcessKg3.toFixed(3));
			$('#sumProcessEa3').text(addCommas(parseFloat(sumProcessEa3).toFixed(0)));
			$('#sumMatrlCount3').text(addCommas(sumMatrlCount3));
			$('#sumMatrlKg3').text(sumMatrlKg3.toFixed(3));
			$('#sumMatrlEa3').text(addCommas(parseFloat(sumMatrlEa3).toFixed(0)));
			$('#sumReplaceCount3').text(addCommas(sumReplaceCount3));
			$('#sumReplaceKg3').text(sumReplaceKg3.toFixed(3));
			$('#sumReplaceEa3').text(addCommas(parseFloat(sumReplaceEa3).toFixed(0)));
			$('#sumTroubleCount3').text(addCommas(sumTroubleCount3));
			$('#sumTrougleKg3').text(sumTrougleKg3.toFixed(3));
			$('#sumTroubleEa3').text(addCommas(parseFloat(sumTroubleEa3).toFixed(0)));

			$('#appearFaultyCnt3').text(addCommas(appearFaultyCnt));
			$('#edgeFaultyCnt3').text(addCommas(edgeFaultyCnt));
			$('#shipFaultyCnt3').text(addCommas(shipFaultyCnt));
			$('#reShipFaultyCnt3').text(addCommas(reShipFaultyCnt));
			$('#outputFaultyCnt3').text(addCommas(outputFaultyCnt));
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
    
</script>
</body>
</html>
