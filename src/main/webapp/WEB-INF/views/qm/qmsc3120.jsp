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
				<li class="breadcrumb-item">품질관리<a href="#"></a></li>
				<li class="breadcrumb-item active">설비 게더링 데이터</li>
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
				<div class="card" id="formBox" style="margin-bottom: 0px;">                                    
                     <div class="table-responsive" style="height: 81vh;">
						<table id="dgsTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th rowspan="4" style="min-width: 70px;" class="text-center">설비명</th>
									<th rowspan="4" style="min-width: 120px;" class="text-center">작지번호</th>
									<th rowspan="4" style="min-width: 100px;" class="text-center">제품명</th>
									<th rowspan="4" style="min-width: 120px;" class="text-center">수집시간</th>
									<th colspan="26" style="min-width: 70px;" class="text-center">온도</th>
									<th colspan="23" style="min-width: 70px;" class="text-center">시간</th>
									<th colspan="3" style="min-width: 70px;" class="text-center">압력</th>
									<th colspan="47" style="min-width: 70px;" class="text-center">치수</th>
								</tr>
								<tr>
									<th colspan="4" style="min-width:60px;" class="text-center" nowrap>1차</th>
									<th colspan="2" style="min-width:60px;" class="text-center" nowrap>1차 푸셔</th>
									<th colspan="4" style="min-width:60px;" class="text-center" nowrap>2차</th>
									<th colspan="2" style="min-width:60px;" class="text-center" nowrap>2차 푸셔</th>
									<th colspan="4" style="min-width:60px;" class="text-center" nowrap>3차</th>
									<th colspan="2" style="min-width:60px;" class="text-center" nowrap>3차 푸셔</th>
									<th colspan="2" style="min-width:60px;" class="text-center" nowrap>진접1</th>
									<th colspan="2" style="min-width:60px;" class="text-center" nowrap>가접</th>
									<th colspan="2" style="min-width:60px;" class="text-center" nowrap>메탈예열</th>
									<th colspan="2" style="min-width:60px;" class="text-center" nowrap>진접2</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>가접 대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>가접 가열</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>1차 가열대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>1차 가열</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>1차 푸셔대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>1차 푸셔</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>진접1</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>2차 가열대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>2차 가열</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>2차 푸셔대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>2차 푸셔</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>3차 가열대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>3차 가열</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>3차 푸셔대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>3차 푸셔시간</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>수평가대 대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>수평가대 시간</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>냉각 대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>냉각 시간</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>진접2(리폼) 대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>진접2(리폼) 시간</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>가융착 가압대기</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>가융착 가압시간</th>
									
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>1차 푸셔</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>1차 진접</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>2차 진접</th>
									
									<!--
									<th colspan="2" style="min-width:60px;" class="text-center">Welding Part</th>
									<th colspan="2" style="min-width:60px;" class="text-center">Pitch</th>
									<th colspan="2" style="min-width:60px;" class="text-center">P.P Film 날개</th>
									<th colspan="2" style="min-width:60px;" class="text-center">P.P Film 폭</th>
									<th colspan="3" style="min-width:60px;" class="text-center">필름폭</th>
									<th colspan="3" style="min-width:60px;" class="text-center">메탈 폭</th>
									<th colspan="2" style="min-width:60px;" class="text-center">돌기크기-좌상</th>
									<th colspan="2" style="min-width:60px;" class="text-center">돌기크기-좌하</th>
									<th colspan="2" style="min-width:60px;" class="text-center">돌기크기-우상</th>
									<th colspan="2" style="min-width:60px;" class="text-center">돌기크기-우하</th> -->
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>WP(좌)<br>머리치수 좌</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>머리치수+중</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>WP(우)<br>머리치수+우</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>머리치수+필름폭 좌</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>머리치수+필름폭 좌(합)</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름폭 좌</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>메탈길이 좌</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>메탈폭 상</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름총길이 상</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>날개치수 좌</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>비출길이 좌</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>직각도 좌하</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>직각도 좌상</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>Lenth L1</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>X1</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름돌기 좌상 높이</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름돌기 좌상 넓이</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름돌기 좌하 높이</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름돌기 좌하 넓이</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>머리치수 편차</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>비출길이 편차</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름폭 좌(내측)</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름폭 중(내측)</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름폭 우(내측)</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>머리치수+필름폭 우</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>머리치수+필름폭 우(합)</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름폭 우</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>메탈길이 우</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>메탈폭 하</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름총길이 하</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>날개치수 우</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>비출길이 우</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>직각도 우하</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>직각도 우상</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>Lenth L2</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>X2</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름돌기 우상 높이</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름돌기 우상 넓이</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름돌기 우하 높이</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름돌기 우하 넓이</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>머리치수+필름폭 편차</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>X1_X2</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>필름 폭 상하 평균</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>메탈 폭 상하 평균</th>
									<th rowspan="2" style="min-width:60px;" class="text-center" nowrap>판정</th>
								</tr>
								<tr>
									<th style="min-width:50px;" class="text-center">상좌</th>
									<th style="min-width:50px;" class="text-center">하좌</th>
									<th style="min-width:50px;" class="text-center">상우</th>
									<th style="min-width:50px;" class="text-center">하우</th>
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px;" class="text-center">하</th>
									<th style="min-width:50px;" class="text-center">상좌</th>
									<th style="min-width:50px;" class="text-center">하좌</th>
									<th style="min-width:50px;" class="text-center">상우</th>
									<th style="min-width:50px;" class="text-center">하우</th>
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px;" class="text-center">하</th>
									<th style="min-width:50px;" class="text-center">상좌</th>
									<th style="min-width:50px;" class="text-center">하좌</th>
									<th style="min-width:50px;" class="text-center">상우</th>
									<th style="min-width:50px;" class="text-center">하우</th>
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px;" class="text-center">하</th>
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px;" class="text-center">하</th>
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px;" class="text-center">하</th>
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px;" class="text-center">하</th>
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px; border-right:solid #d6d8e1 1px;" class="text-center">하</th>
									
									<!--
									<th style="min-width:50px;" class="text-center">좌</th>
									<th style="min-width:50px;" class="text-center">우</th>
									<th style="min-width:50px;" class="text-center">좌</th>
									<th style="min-width:50px;" class="text-center">우</th>
									<th style="min-width:50px;" class="text-center">좌</th>
									<th style="min-width:50px;" class="text-center">우</th>
									<th style="min-width:50px;" class="text-center">좌</th>
									<th style="min-width:50px;" class="text-center">우</th>
									
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px;" class="text-center">하</th>
									<th style="min-width:50px;" class="text-center">평균</th>
									<th style="min-width:50px;" class="text-center">상</th>
									<th style="min-width:50px;" class="text-center">하</th>
									<th style="min-width:50px;" class="text-center">평균</th>
									
									<th style="min-width:50px;" class="text-center">높이</th>
									<th style="min-width:50px;" class="text-center">넓이</th>
									<th style="min-width:50px;" class="text-center">높이</th>
									<th style="min-width:50px;" class="text-center">넓이</th>
									<th style="min-width:50px;" class="text-center">높이</th>
									<th style="min-width:50px;" class="text-center">넓이</th>
									<th style="min-width:50px;" class="text-center">높이</th>
									<th style="min-width:50px;" class="text-center">넓이</th>
									-->
								</tr>
								
								<tr>
									<!-- 온도 조건 -->
									<th style="min-width:50px;" class="text-center" id="tempaturFirstUpleftCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturFirstDownleftCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturFirstUprightCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturFirstDownrightCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturPush1UpCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturPush1DownCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturSecondUpleftCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturSecondDownleftCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturSecondUprightCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturSecondDownrightCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="tempaturThirdUpleftCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturThirdDownleftCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturThirdUprightCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturThirdDownrightCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="tempaturJinjeop1UpCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturJinjeop1DownCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="tempaturJinjeop2UpCond"></th>
									<th style="min-width:50px;" class="text-center" id="tempaturJinjeop2DownCond"></th>
									
									
									<!-- 시간 조건 -->
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="timeFitupCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="timeFirstCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="timePush1Cond"></th>
									<th style="min-width:50px;" class="text-center" id="timeJinjeopCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="timeSecondCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="timeThirdCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="timeCoolCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="timeJinjeop2Cond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>									
									<th style="min-width:50px;" class="text-center" id="">-</th>
									
									<!-- 압력 조건 -->
									<th style="min-width:50px;" class="text-center" id="pressurePush1Cond"></th>
									<th style="min-width:50px;" class="text-center" id="pressureJinjeopCond"></th>
									<th style="min-width:50px;" class="text-center" id="pressureJinjeop2Cond"></th>
									
									<!-- 치수 조건 -->
									<th style="min-width:50px;" class="text-center" id="sizeWpLeftCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="sizeWpRightCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="sizePitchLeftCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="sizePpfWingLeftCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="sizePpfDepthLeftCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="sizePpfDepthRightCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="sizePitchRightCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="sizePpfWingRightCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
									<th style="min-width:50px;" class="text-center" id="sizeFilmCond"></th>
									<th style="min-width:50px;" class="text-center" id="sizeMetalDepthCond"></th>
									<th style="min-width:50px;" class="text-center" id="">-</th>
								</tr>
							</thead>
	                    </table>
                     </div>
				</div>
			<!--// 등록, 수정 -->
			</div><!-- .right-sidebar -->
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc3120';
	let currentHref = 'qmsc3120';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","설비 게더링 데이터");
	var serverDate =  "${serverDate}";
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	var chooseDate = serverDate;
	var equipNm = "empty";
	var equipCondSeq = null;
	var excelDownAll = 'false';
	
	//공통코드 처리 시작
	var equipGroupCode = new Array(); // 설치장소
    <c:forEach items="${equipGroupCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    //설비 목록
   	$.fn.dataTable.ext.errMode = 'none';
	let equipCodeAdmTable = $('#equipCodeAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
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
            	'menuAuth'		:		menuAuth,
            	'equipGroup'	:		function() { return equipGroup; }
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
	html1 += '&nbsp;<label class="input-label-sm">설비그룹</label><select class="custom-select" id="equipGroupCd" ></select>';
	html1 += '</div>';
	$('#equipCodeAdmTable_length').html(html1);
	selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");

	$("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});
	 	equipCd = "";
	});
	
    $('#equipCodeAdmTable tbody').on('click', 'tr', function () { 
		if ( $(this).hasClass('selected') ) {
			//$(this).removeClass('selected');
			//equipNm = "";
		} else {
			$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		equipNm = equipCodeAdmTable.row(this).data().equipNm;
		chooseDate = $('#date').val();
		equipCondSeq = "";
		$('#dgsTable tbody').html('')
		equipCondSeq = null;
		bomCondCleaer();
		readEquipCondSeqList();
    });

    //해당 설비&날짜롸 제조조건 List 검색
    function readEquipCondSeqList() {
	    $.ajax({
			url: '<c:url value="po/readEquipCondSeqList_F2F3"/>',
			type: 'POST',
			data: {
				'menuAuth'	 	: 	menuAuth,
				'chooseDate'	: 	function() { return chooseDate.replace(/-/g, ''); },
				'equipNm'		: 	function() { return equipNm; },
			},
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
			let data = res.data;
				if (res.result == 'ok') {
					$('#equipCondSeq').empty();
					$('#equipCondSeq').append($("<option value=''>"+ "선택" +"</option>"));
					if (data.length == 0) {
						$('#equipCondSeq').attr('disabled', true);
						toastr.success('조회된 제조조건이 없습니다');
					} else {
						$('#equipCondSeq').attr('disabled', false);
						$('#equipCondSeq').empty();
						$('#equipCondSeq').append($("<option value=''>"+ "선택" +"</option>"));
						for (var i=0; i<data.length; i++){
							if(data[i].equipCondSeq == null){
								$('#equipCondSeq').append($("<option value='" + data[i].equipCondSeq + "'>" + '제조조건 없음' + "</option>"));
							} else {
								$('#equipCondSeq').append($("<option value='" + data[i].equipCondSeq + "'>" + data[i].goodsNm + "</option>"));
							}
						}
						toastr.success(data[0].totalCount + res.message);
					}
		        } else {
		        	toastr.error(res.message, '', {timeOut: 5000});
		        }
		    },
		    complete:function(){
		    	$('#my-spinner').hide();
		    },
		});
    }

    let sudelArray = new Array();
    
	//DGS데이터 목록
   	//$.fn.dataTable.ext.errMode = 'none';
	//let dgsTable = $('#dgsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	//    	if(techNote == 7) {
	//	    	toastr.error("서버사이드 키면 이 옵션 에러남", '', {timeOut: 5000});
	//	    	//toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
	//	       	location.href = "/";
	//		}
	//	} ).DataTable({
	let dgsTable = $('#dgsTable').DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",//B",
															//B 추가시 export 버튼 생성
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: true,
        searching: true,
        pageLength: -1,
		serverSide : true,
		ajax: {
			url: '<c:url value="/po/readDgsDataList_F2F3"/>',
			type: 'POST',
			data: {
				'menuAuth'	 		: 		menuAuth,
				'chooseDate'		: 		function() { return chooseDate.replace(/-/g, ''); },
				'equipNm'			: 		function() { return equipNm; },
				'equipCondSeq'		: 		function() { return equipCondSeq; },
				'excelDownAll'		:		function() { return excelDownAll; },
			},
			/*
			success : function(res) {
			    console.log(res);
			}
			*/
		},
		//rowId: 'lotNo',
		columns: [
			{ data: 'equipNm' },
			{ data: 'workOrdNo' },
			{ data: 'goodsNm' },
			{ data: 'regDate',
				render: function(data, type, row) {
					return moment(data).format('YYYY-MM-DD HH:mm:ss');
				} 
			},

			//온도
			{ data: 'tempData1' },		//1차 상좌
			{ data: 'tempData3' },		//1차 하좌
			{ data: 'tempData2' },		//1차 상우
			{ data: 'tempData4' },		//1차 하우
			{ data: 'tempData5' },		//1차 푸셔 상
			{ data: 'tempData6' },		//1차 푸셔 하
			{ data: 'tempData7' },		//2차 상좌
			{ data: 'tempData9' },		//2차 하좌
			{ data: 'tempData8' },		//2차 상우
			{ data: 'tempData10' },		//2차 하우
			{ data: 'tempData11' },		//2차 푸셔 상
			{ data: 'tempData12' },		//2차 푸셔 하
			{ data: 'tempData13' },		//3차 상좌
			{ data: 'tempData15' },		//3차 하좌
			{ data: 'tempData14' },		//3차 상우
			{ data: 'tempData16' },		//3차 하우
			{ data: 'tempData17' },		//3차 푸셔 상
			{ data: 'tempData18' },		//3차 푸셔 하
			{ data: 'tempData19' },		//진접1 상
			{ data: 'tempData20' },		//진접1 하
			{ data: 'tempData21' },		//상부 가접
			{ data: 'tempData22' },		//하부 가접
			{ data: 'tempData23' },		//상부 메탈예열
			{ data: 'tempData24' },		//하부 메탈예열
			{ data: 'tempData25' },		//진접2 상(1공장만)
			{ data: 'tempData26' },		//진접2 하(1공장만)

			{ data: 'timeData1', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//가접 대기시간
			{ data: 'timeData2', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//가융착 가열시간 ,가접 가열시간
			{ data: 'timeData3', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//1차메탈 가열대기시간 ,1차메탈 대기시간
			{ data: 'timeData4', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//1차메탈 가열시간
			{ data: 'timeData5', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//1차메탈 푸셔대기시간
			{ data: 'timeData6', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//1차메탈 푸셔시간 ,1차메탈 푸셔가열시간
			{ data: 'timeData7', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//진접시간 ,진접 가열시간
			{ data: 'timeData8', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//2차메탈 가열대기시간 ,2차메탈 대기시간
			{ data: 'timeData9', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//2차메탈 가열시간
			{ data: 'timeData10', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//2차메탈 푸셔대기시간
			{ data: 'timeData11', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//2차메탈 푸셔시간, 2차메탈 푸셔가열시간
			{ data: 'timeData12', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//3차메탈 가열대기시간 ,3차메탈 대기시간
			{ data: 'timeData13', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//3차메탈 가열시간
			{ data: 'timeData14', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//3차메탈 푸셔대기시간
			{ data: 'timeData15', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//3차메탈 푸셔시간 ,3차메탈 푸셔가열시간
			{ data: 'timeData16', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//수평가대 대기시간 ,필름수평가이드 대기시간
			{ data: 'timeData17', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//수평가대시간 ,필름수평가이드 가열시간
			{ data: 'timeData18', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//냉각대기시간, 냉각AIR 대기시간
			{ data: 'timeData19', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//냉각시간, 냉각AIR 가열시간
			{ data: 'timeData20', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//리폼대기시간, 필름리폼 대기시간
			{ data: 'timeData21', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//리폼시간, 필름리폼 가열시간
			{ data: 'timeData22', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//가융착 가압대기시간, 필름이송부 대기시간
			{ data: 'timeData23', render: function(data, type, row) { return parseFloat(data).toFixed(1); } },	//가융착 가압시간, 필름이송부 가열시간

			{ data: 'prssData1' },	//1차푸셔
			{ data: 'prssData2' },	//진접1
			{ data: 'prssData3' },	//진접2

			//{ data: 'sizeData1' },	//검사 시간
			//{ data: 'sizeData2' },	//Lot No
			{ data: 'visionData3' },	//머리치수 좌
			{ data: 'visionData4' },	//머리치수+중
			{ data: 'visionData5' },	//머리치수+우
			{ data: 'visionData6' },	//머리치수+필름폭 좌
			{ data: 'visionData7' },	//머리치수+필름폭 좌(합)
			{ data: 'visionData8' },	//필름폭 좌
			{ data: 'visionData9' },	//메탈길이 좌
			{ data: 'visionData10' },	//메탈폭 상
			{ data: 'visionData11' },	//필름총길이 상
			{ data: 'visionData12' },	//날개치수 좌
			{ data: 'visionData13' },	//비출길이 좌
			{ data: 'visionData14' },	//직각도 좌하
			{ data: 'visionData15' },	//직각도 좌상
			{ data: 'visionData16' },	//Lenth L1
			{ data: 'visionData17' },	//X1
			{ data: 'visionData18' },	//필름돌기 좌상 높이
			{ data: 'visionData19' },	//필름돌기 좌상 넓이
			{ data: 'visionData20' },	//필름돌기 좌하 높이
			{ data: 'visionData21' },	//필름돌기 좌하 넓이
			{ data: 'visionData22' },	//머리치수 편차
			{ data: 'visionData23' },	//비출길이 편차
			{ data: 'visionData24' },	//필름폭 좌(내측)
			{ data: 'visionData25' },	//필름폭 중(내측)
			{ data: 'visionData26' },	//필름폭 우(내측)
			{ data: 'visionData27' },	//머리치수+필름폭 우
			{ data: 'visionData28' },	//머리치수+필름폭 우(합)
			{ data: 'visionData29' },	//필름폭 우
			{ data: 'visionData30' },	//메탈길이 우
			{ data: 'visionData31' },	//메탈폭 하
			{ data: 'visionData32' },	//필름총길이 하
			{ data: 'visionData33' },	//날개치수 우
			{ data: 'visionData34' },	//비출길이 우
			{ data: 'visionData35' },	//직각도 우하
			{ data: 'visionData36' },	//직각도 우상
			{ data: 'visionData37' },	//Lenth L2
			{ data: 'visionData38' },	//X2
			{ data: 'visionData39' },	//필름돌기 우상 높이
			{ data: 'visionData40' },	//필름돌기 우상 넓이
			{ data: 'visionData41' },	//필름돌기 우하 높이
			{ data: 'visionData42' },	//필름돌기 우하 넓이
			{ data: 'visionData43' },	//머리치수+필름폭 편차
			{ data: 'visionData44' },	//X1_X2
			{ data: 'filmAlwnce',		//필름 상 하 평균 -- 쿼리에서 계산
				render: function(data, type, row) {
					if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(4);
					}
				}
			},
			{ data: 'metalDepthAlwnce',	//메탈 폭 상 하 평균 -- 쿼리에서 계산
				render: function(data, type, row) {
					if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(4);
					}
				}
			},
			{ data: 'visionData100' },	//판정
			//{ data: '' },	//솔브레인SLD는 WP우가 없네??('WP좌' 는있는데 뭐지?)
		],
		columnDefs: [
		   	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49
						,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94
						,95,96,97,98,99], className: 'text-right' }, 
			{ targets: [0,1,2,3,100], className: 'text-center' }, 
		],
		//order: [
		//    [ 0, 'asc' ]
		//],
		buttons: [
			{
				extend: 'copy',
				title: '픔질관리/설비 게더링 데이터',
			},
			{
				extend: 'excel',
				title: '픔질관리/설비 게더링 데이터',
				/*header: false,
				//굵게
			    customize: function ( xlsx ) {
			        var sheet = xlsx.xl.worksheets['sheet1.xml'];
			        //Bold Header Row
			        $('row[r=2] c', sheet).attr( 's', '2' );
			        
			        //Make You Input Cells Bold Too
			        $('c[r=A1]', sheet).attr( 's', '2' );
			        $('c[r=A2]', sheet).attr( 's', '2' );

			        //가운데
			        $('row[r=2] c', sheet).attr( 's', '2' );
			        $('row[r=5] c', sheet).attr( 's', '2' );
// 			        $('row[r=2] c', sheet).attr({
// 						"S" : "2"
// 						, "S" : "51" 
// 						, "S" : "53" 
// 					});

		            var mergeCells = $('mergeCells', sheet);

		            //병합 하고자 하는 셀 지정 
	               	mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A2:A5'} } )
					);
	                mergeCells[0].appendChild( 
	                		createNode( sheet, 'mergeCell', { attr: {ref: 'B2:B5'} } )
					);
	                mergeCells[0].appendChild( 
	                		createNode( sheet, 'mergeCell', { attr: {ref: 'C2:C5'} } )
					);
	                mergeCells[0].appendChild( 
	                		createNode( sheet, 'mergeCell', { attr: {ref: 'D2:D5'} } )
					);

	                //온도
	                mergeCells[0].appendChild( 
	                		createNode( sheet, 'mergeCell', { attr: {ref: 'E2:AD2'} } )
					);
					//시간
	                mergeCells[0].appendChild( 
	                		createNode( sheet, 'mergeCell', { attr: {ref: 'AE2:BA2'} } )
					);
	              	//압력 
	                mergeCells[0].appendChild( 
	                		createNode( sheet, 'mergeCell', { attr: {ref: 'BB2:BD2'} } )
					);
	              	//치수
	                mergeCells[0].appendChild( 
	                		createNode( sheet, 'mergeCell', { attr: {ref: 'BE2:CW2'} } )
					);
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
			    
			    //헤더 추가하는 부분
			    customizeData: function(data){
				   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해준다.
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				    let array = new Array();
// 				    let obj = new Object();
				    //첫 번째 tr
// 				   for(var i=4; i<$('#dgsTable thead tr').eq(0).find('th').length; i++){
// 				    	obj = new Object();
// 				    	obj.name = $('#dgsTable thead tr').eq(0).find('th').eq(i).text();
// 				    	obj.colspan = $('#dgsTable thead tr').eq(0).find('th').eq(i).attr('colspan');
// 				    	array.push(obj);
// 		        	}

				    for(var i=0; i<data.header.length; i++){
						switch (i){
							case 0: 
								array.push('설비명');
								break;
							case 1: 
								array.push('작지번호');
								break;
							case 2: 
								array.push('제품명');
								break;
							case 3: 
								array.push('수집기간');
								break;
							case 4: 
								array.push('온도');
								break;
							case 30: 
								array.push('시간');
								break;
							case 53: 
								array.push('압력');
								break;
							case 56: 
								array.push('치수');
								break;
							default:
								array.push(' ');
								break;
						}
		        	}
		        	
		        	
				    //거꾸로 감, 젤 위에가 젤 밑으로 감
			        let desc = [
			        	gapCell
			        	, gapCell
				        , array
					];
					
			        data.body.unshift(data.header);
			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }*/

			},
			{
				extend: 'print',
				title: '픔질관리/설비 게더링 데이터',
			},
		],
	});
    
	var html1 =  '<div class="row">&nbsp;<label class="input-label-sm">일자</label>';
		html1 += '<div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" type="text" style="width:97px;" id="date" name="date" />';
		html1 += '<button onclick="fnPopUpCalendar(date,date,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span></button>';
		html1 += '</div>&nbsp;&nbsp;';
		html1 += '<button type="button" class="btn btn-primary mr-2" id="btnRetv">조회</button>';
		html1 += '<select class="custom-select mr-1" id="equipCondSeq" style="width:100px;" disabled></select>';
		html1 += '<button type="button" class="btn btn-success mr-2" id="btnAgtExcelDownload">엑셀다운</button>';
		html1 += '<label for="excelDownAll" class="input-label-sm" checked="">전체 다운</label>';
		html1 += '<input type="checkbox" style="width: 20px; height: 20px; margin-top:2px; margin-left:15px; margin-top:2px; margin-left: 0px; margin-right:3px;" id="excelDownAll">';
		html1 += '</div>';
	$('#dgsTable_length').html(html1);
	$('#equipCondSeq').append($("<option value=''>"+ "선택" +"</option>"));
	$("#date").val(serverDate);
	
	$('#btnRetv').on('click', function () {
		if ( equipNm == "empty" || equipNm == "" || equipNm == null ){
			toastr.warning("설비명을 선택해 주세요.");
			return false;
		}
		if( equipCondSeq == null || equipCondSeq == '') {
  	  	  	toastr.warning("제조조건을 선택해 주세요!");
  	  		$('#equipCondSeq').focus();
  	  		return false;
  	  	}
		equipCondSeq == null
		chooseDate = $('#date').val();
		$('#dgsTable tbody').html('')
		bomCondCleaer();
		readEquipCondSeqList();
	});

	$('#dgsTable').on('click', 'tr', function () {
		if ( $(this).hasClass('selected') ){
			$(this).removeClass('selected');
		} else {
			$(this).addClass('selected');
		}
	});

	$('#buyDateCalendar').on('click', function () {
		$('#equipCondSeq').attr('disabled', true);
		$('#equipCondSeq').empty();
		$('#equipCondSeq').append($("<option value=''>"+ "선택" +"</option>"));
	});

	//제조조건 변경 시
	$("#equipCondSeq").change(function() {
		bomCondCleaer();
		equipCondSeq =  $('#equipCondSeq option:selected').val();
		
		if (equipCondSeq == '') {
			toastr.warning('제조조건을 다시 선택해 주세요!');
			return false;
		}
		
		if (equipCondSeq != null && equipCondSeq != '') {
		    $.ajax({
				url: '<c:url value="/wm/onlyBomDataList"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 	menuAuth,
					'equipCondSeq'	: 	function() { return equipCondSeq; },
				},
				beforeSend: function() {
					$('#my-spinner').show();
				},
				success: function (res) {
					let tempaturData = res.tempaturData;
 	                let timeData = res.timeData;
 	                let pressureData = res.pressureData;
 	                let sizeData = res.sizeData;
					if (res.result == 'ok') {
						if (!$.isEmptyObject(tempaturData)) {
							$('#tempaturWarmupCond').text('-' + tempaturData.warmupAlwnceMinus + ' [' + tempaturData.warmupCond + '] ' + '+' + tempaturData.warmupAlwncePlus);
							$('#tempaturFitup1UpCond').text('-' + tempaturData.fitup1UpAlwnceMinus + ' [' + tempaturData.fitup1UpCond + '] ' + '+' + tempaturData.fitup1UpAlwncePlus);
							$('#tempaturFitup1DownCond').text('-' + tempaturData.fitup1DownAlwnceMinus + ' [' + tempaturData.fitup1DownCond + '] ' + '+' + tempaturData.fitup1DownAlwncePlus);
							$('#tempaturFitup2UpleftCond').text('-' + tempaturData.fitup2UpleftAlwnceMinus + ' [' + tempaturData.fitup2UpleftCond + '] ' + '+' + tempaturData.fitup2UpleftAlwncePlus);
							$('#tempaturFitup2DownleftCond').text('-' + tempaturData.fitup2DownleftAlwnceMinus + ' [' + tempaturData.fitup2DownleftCond + '] ' + '+' + tempaturData.fitup2DownleftAlwncePlus);
							$('#tempaturFitup2UprightCond').text('-' + tempaturData.fitup2UprightAlwnceMinus + ' [' + tempaturData.fitup2UprightCond + '] ' + '+' + tempaturData.fitup2UprightAlwncePlus);
							$('#tempaturFitup2DownrightCond').text('-' + tempaturData.fitup2DownrightAlwnceMinus + ' [' + tempaturData.fitup2DownrightCond + '] ' + '+' + tempaturData.fitup2DownrightAlwncePlus);
							$('#tempaturRollheatUpCond').text('-' + tempaturData.rollheatUpAlwnceMinus + ' [' + tempaturData.rollheatUpCond + '] ' + '+' + tempaturData.rollheatUpAlwncePlus);
							$('#tempaturRollheatDownCond').text('-'  +tempaturData.rollheatDownAlwnceMinus + ' [' + tempaturData.rollheatDownCond + '] ' + '+' + tempaturData.rollheatDownAlwncePlus);
							$('#tempaturFirstUpleftCond').text('-' + tempaturData.firstUpleftAlwnceMinus + ' [' + tempaturData.firstUpleftCond + '] ' + '+' + tempaturData.firstUpleftAlwncePlus);
							$('#tempaturFirstDownleftCond').text('-' + tempaturData.firstDownleftAlwnceMinus + ' [' + tempaturData.firstDownleftCond + '] ' + '+' + tempaturData.firstDownleftAlwncePlus);
							$('#tempaturFirstUprightCond').text('-' + tempaturData.firstUprightAlwnceMinus + ' [' + tempaturData.firstUprightCond + '] ' + '+' + tempaturData.firstUprightAlwncePlus);
							$('#tempaturFirstDownrightCond').text('-' + tempaturData.firstDownrightAlwnceMinus + ' [' + tempaturData.firstDownrightCond + '] ' + '+' + tempaturData.firstDownrightAlwncePlus);
							$('#tempaturPush1UpCond').text('-' + tempaturData.push1UpAlwnceMinus + ' [' + tempaturData.push1UpCond + '] ' + '+' + tempaturData.push1UpAlwncePlus);
							$('#tempaturPush1DownCond').text('-' + tempaturData.push1DownAlwnceMinus + ' [' + tempaturData.push1DownCond + '] ' + '+' + tempaturData.push1DownAlwncePlus);
							$('#tempaturSecondUpleftCond').text('-' + tempaturData.secondUpleftAlwnceMinus + ' [' + tempaturData.secondUpleftCond + '] ' + '+' + tempaturData.secondUpleftAlwncePlus);
							$('#tempaturSecondDownleftCond').text('-' + tempaturData.secondDownleftAlwnceMinus + ' [' + tempaturData.secondDownleftCond + '] ' + '+' + tempaturData.secondDownleftAlwncePlus);
							$('#tempaturSecondUprightCond').text('-' + tempaturData.secondUprightAlwnceMinus + ' [' + tempaturData.secondUprightCond + '] ' + '+' + tempaturData.secondUprightAlwncePlus);
							$('#tempaturSecondDownrightCond').text('-' + tempaturData.secondDownrightAlwnceMinus + ' [' + tempaturData.secondDownrightCond + '] ' + '+' + tempaturData.secondDownrightAlwncePlus);
							$('#tempaturThirdUpleftCond').text('-' + tempaturData.thirdUpleftAlwnceMinus + ' [' + tempaturData.thirdUpleftCond + '] ' + '+' + tempaturData.thirdUpleftAlwncePlus);
							$('#tempaturThirdDownleftCond').text('-' + tempaturData.thirdDownleftAlwnceMinus + ' [' + tempaturData.thirdDownleftCond + '] ' + '+' + tempaturData.thirdDownleftAlwncePlus);
							$('#tempaturThirdUprightCond').text('-' + tempaturData.thirdUprightAlwnceMinus + ' [' + tempaturData.thirdUprightCond + '] ' + '+' + tempaturData.thirdUprightAlwncePlus);
							$('#tempaturThirdDownrightCond').text('-' + tempaturData.thirdDownrightAlwnceMinus + ' [' + tempaturData.thirdDownrightCond + '] ' + '+' + tempaturData.thirdDownrightAlwncePlus);
							$('#tempaturJinjeop1UpCond').text('-' + tempaturData.jinjeop1UpAlwnceMinus + ' [' + tempaturData.jinjeop1UpCond + '] ' + '+' + tempaturData.jinjeop1UpAlwncePlus);
							$('#tempaturJinjeop1DownCond').text('-' + tempaturData.jinjeop1DownAlwnceMinus + ' [' + tempaturData.jinjeop1DownCond + '] ' + '+' + tempaturData.jinjeop1DownAlwncePlus);
							$('#tempaturJinjeop2UpCond').text('-' + tempaturData.jinjeop2UpAlwnceMinus + ' [' + tempaturData.jinjeop2UpCond + '] ' + '+' + tempaturData.jinjeop2UpAlwncePlus);
							$('#tempaturJinjeop2DownCond').text('-' + tempaturData.jinjeop2DownAlwnceMinus + ' [' + tempaturData.jinjeop2DownCond + '] ' + '+' + tempaturData.jinjeop2DownAlwncePlus);
						}
						
						if (!$.isEmptyObject(timeData)) {
							$('#timeFitupCond').text('-' + timeData.fitupAlwnceMinus + ' [' + timeData.fitupCond + '] ' + '+' + timeData.fitupAlwncePlus);
							$('#timeFirstCond').text('-' + timeData.firstAlwnceMinus + ' [' + timeData.firstCond + '] ' + '+' + timeData.firstAlwncePlus);
							$('#timePush1Cond').text('-' + timeData.push1AlwnceMinus + ' [' + timeData.push1Cond + '] ' + '+' + timeData.push1AlwncePlus);
							$('#timeJinjeopCond').text('-' + timeData.jinjeopAlwnceMinus + ' [' + timeData.jinjeopCond + '] ' + '+' + timeData.jinjeopAlwncePlus);
							$('#timeSecondCond').text('-' + timeData.secondAlwnceMinus + ' [' + timeData.secondCond + '] ' + '+' + timeData.secondAlwncePlus);
							$('#timeCoolCond').text('-' + timeData.coolAlwnceMinus + ' [' + timeData.coolCond + '] ' + '+' + timeData.coolAlwncePlus);
							$('#timeJinjeop2Cond').text('-' + timeData.jinjeop2AlwnceMinus + ' [' + timeData.jinjeop2Cond + '] ' + '+' + timeData.jinjeop2AlwncePlus);
//	 						$('#timeReformCond').text('-' + timeData.reformAlwnceMinus + ' [' + timeData.reformCond + '] ' + '+' + timeData.reformAlwncePlus);
							$('#timeThirdCond').text('-' + timeData.thirdAlwnceMinus + ' [' + timeData.thirdCond + '] ' + '+' + timeData.thirdAlwncePlus);
						}
						
						if (!$.isEmptyObject(pressureData)) {
							$('#pressurePush1Cond').text('-' + pressureData.push1AlwnceMinus + ' [' + pressureData.push1Cond + '] ' + '+' + pressureData.push1AlwncePlus);
							$('#pressureJinjeopCond').text('-' + pressureData.jinjeopAlwnceMinus + ' [' + pressureData.jinjeopCond + '] ' + '+' + pressureData.jinjeopAlwncePlus);
							$('#pressureJinjeop2Cond').text('-' + pressureData.jinjeop2AlwnceMinus + ' [' + pressureData.jinjeop2Cond + '] ' + '+' + pressureData.jinjeop2AlwncePlus);
						}
						
						if (!$.isEmptyObject(sizeData)) {
							$('#sizeWpLeftCond').text('-' + sizeData.wpLeftAlwnceMinus + ' [' + sizeData.wpLeftCond + '] ' + '+' + sizeData.wpLeftAlwncePlus);
							$('#sizeWpRightCond').text('-' + sizeData.wpRightAlwnceMinus + ' [' + sizeData.wpRightCond + '] ' + '+' + sizeData.wpRightAlwncePlus);
							$('#sizePitchLeftCond').text('-' + sizeData.pitchLeftAlwnceMinus + ' [' + sizeData.pitchLeftCond + '] ' + '+' + sizeData.pitchLeftAlwncePlus);
							$('#sizePitchRightCond').text('-' + sizeData.pitchRightAlwnceMinus + ' [' + sizeData.pitchRightCond + '] ' + '+' + sizeData.pitchRightAlwncePlus);
							$('#sizePpfWingLeftCond').text('-' + sizeData.ppfWingLeftAlwnceMinus + ' [' + sizeData.ppfWingLeftCond + '] ' + '+' + sizeData.ppfWingLeftAlwncePlus);
							$('#sizePpfWingRightCond').text('-' + sizeData.ppfWingRightAlwnceMinus + ' [' + sizeData.ppfWingRightCond + '] ' + '+' + sizeData.ppfWingRightAlwncePlus);
							$('#sizePpfDepthLeftCond').text('-' + sizeData.ppfDepthLeftAlwnceMinus + ' [' + sizeData.ppfDepthLeftCond + '] ' + '+' + sizeData.ppfDepthLeftAlwncePlus);
							$('#sizePpfDepthRightCond').text('-' + sizeData.ppfDepthRightAlwnceMinus + ' [' + sizeData.ppfDepthRightCond + '] ' + '+' + sizeData.ppfDepthRightAlwncePlus);
							$('#sizeFilmCond').text('-' + sizeData.filmAlwnceMinus + ' [' + sizeData.filmCond + '] ' + '+' + sizeData.filmAlwncePlus);
	 						$('#sizeMetalDepthCond').text('-' + sizeData.metalDepthAlwnceMinus + ' [' + sizeData.metalDepthCond + '] ' + '+' + sizeData.metalDepthAlwncePlus);
						}

						if ($("#equipCondSeq option:selected").val() == 'null') {
							toastr.success($("#equipCondSeq option:selected").text() + "의 제조조건 -가 조회되었습니다.");
						} else {
							toastr.success($("#equipCondSeq option:selected").text() + "의 제조조건 " + $("#equipCondSeq option:selected").val() + "가 조회되었습니다.");
						}
						
		            } else {
		            	toastr.error(res.message, '', {timeOut: 5000});
		            }
		        },
		        complete:function(){
		        	$('#my-spinner').hide();
		        },
		    });
		}

		$('#dgsTable').DataTable().ajax.reload( function () {});
		
    });


	function bomCondCleaer() {
		$('#tempaturFirstUpleftCond').text('');
		$('#tempaturFirstDownleftCond').text('');
		$('#tempaturFirstUprightCond').text('');
		$('#tempaturFirstDownrightCond').text('');
		$('#tempaturPush1UpCond').text('');
		$('#tempaturPush1DownCond').text('');
		$('#tempaturSecondUpleftCond').text('');
		$('#tempaturSecondDownleftCond').text('');
		$('#tempaturSecondUprightCond').text('');
		$('#tempaturSecondDownrightCond').text('');
		$('#tempaturThirdUpleftCond').text('');
		$('#tempaturThirdDownleftCond').text('');
		$('#tempaturThirdUprightCond').text('');
		$('#tempaturThirdDownrightCond').text('');
		$('#tempaturJinjeop1UpCond').text('');
		$('#tempaturJinjeop1DownCond').text('');
		$('#tempaturJinjeop2UpCond').text('');
		$('#tempaturJinjeop2DownCond').text('');
		
		$('#timeFitupCond').text('');
		$('#timeFirstCond').text('');
		$('#timePush1Cond').text('');
		$('#timeJinjeopCond').text('');
		$('#timeSecondCond').text('');
		$('#timeCoolCond').text('');
		$('#timeJinjeop2Cond').text('');
// 		$('#timeReformCond').text('');
		$('#timeThirdCond').text('');
		
		$('#pressurePush1Cond').text('');
		$('#pressureJinjeopCond').text('');
		$('#pressureJinjeop2Cond').text('');
		
		$('#sizeWpLeftCond').text('');
		$('#sizeWpRightCond').text('');
		$('#sizePitchLeftCond').text('');
		$('#sizePitchRightCond').text('');
		$('#sizePpfWingLeftCond').text('');
		$('#sizePpfWingRightCond').text('');
		$('#sizePpfDepthLeftCond').text('');
		$('#sizePpfDepthRightCond').text('');
		$('#sizeFilmCond').text('');
		$('#sizeMetalDepthCond').text('');
	}

	$('#btnAgtExcelDownload').on('click', function() {
  		equipCondSeq =  $('#equipCondSeq option:selected').val();
  	  	if( equipNm == "" || equipNm == null || equipNm == 'empty') {
  	  	  	toastr.warning("설비명을 선택해 주세요!");
  	  	  	return false;
  	  	}

  	  	//전체 
  	  	if ($("input:checkbox[id='excelDownAll']").is(":checked")) {
  	  		equipCondSeq = '';
	  	  	$('#equipCondSeq').empty();
			$('#equipCondSeq').append($("<option value=''>"+ "선택" +"</option>"));
  	  		
		} else {
			if( equipCondSeq == null || equipCondSeq == '') {
	  	  	  	toastr.warning("제조조건을 선택해 주세요!");
	  	  		$('#equipCondSeq').focus();
	  	  		return false;
	  	  	}
		}
  	  	
		$('#my-spinner').show();
		
		$.ajax({
			url: '<c:url value="/qm/agtExcel_F2F3"/>',
			type: 'GET',
			datatype: 'json',
			data:  {
				'menuAuth'	 		: 		menuAuth,
				'equipCondSeq'		: 		function() { return equipCondSeq; },	//제조조건 검색에사용
				//'ifEquipCondSeq'	: 		function() { return equipCondSeq; },	//DGS 데이터 검색에 사용
				'chooseDate'		: 		function() { return chooseDate.replace(/-/g, ''); },
				'equipNm'			:		function() { return equipNm; },
				'searchAll'			:		'all',
				'excelDownAll'		:		function() { return excelDownAll; },
			},
			beforeSend: function() {
				//  $('#btnAddConfirmLoading').removeClass('d-none');
			},            
			success: function (res) {
				let data = res.data
				//console.log(data);
			    if (res.result == 'ok') {
			        location.href = '/agtExcelDownload?id=' + data.chooseDate + '_' + data.equipNm + '_' + data.goodsNm + '_' + data.ifEquipCondSeq;
			    } else if (res.result == 'fail') {
			    	toastr.warning(res.message);
				} else {
					toastr.error("오류가 발생하였습니다. - dgsExcel_nF2/print-001");
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
        });
	});

	//전체 다운 체크박스
	$('#excelDownAll').click(function() {
		if ($(this).prop('checked')) {
			excelDownAll = 'true';
		} else {
			excelDownAll = 'false';
		}
	});
	
</script>
</body>
</html>