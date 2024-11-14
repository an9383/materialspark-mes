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
				<li class="breadcrumb-item active">가동시간(6층)</li>
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
						<!-- 온도 -->
						<form id="tempatur">
							<!-- 온도 테이블 -->
							<table class="table table-bordered">
								<thead>
									<tr>
										<th rowspan="2" style="min-width:40px">구분</th>
										<th colspan="21" style="min-width:40px">온도(°C)</th>
									</tr>
									<tr>
										<th>상부탭<br>예열</th>
										<th>하부탭<br>예열</th>
										<th>상부롤<br>히터</th>
										<th>하부롤<br>히터</th>
										<th>상부필름연결(상)</th>
										<th>상부필름연결(하)</th>
										<th>하부필름연결(상)</th>
										<th>하부필름연결(하)</th>
										<th>하부탭예열유지</th>
										<th>F-상부1차메탈(Sid)</th>
										<th>F-상부1차메탈(Mid)</th>
										<th>F-하부1차메탈(Sid)</th>
										<th>F-하부1차메탈(Mid)</th>
										<th>F-상부1차푸셔</th>
										<th>F-하부1차푸셔</th>
										<th>B-상부1차메탈(Sid)</th>
										<th>B-상부1차메탈(Mid)</th>
										<th>B-하부1차메탈(Sid)</th>
										<th>B-하부1차메탈(Mid)</th>
										<th>B-상부1차푸셔</th>
										<th>B-하부1차푸셔</th>
									</tr>
								</thead>
								<tbody>
									<tr>
								        <th>조건</th>
								        <td><span id="tempaturUpTabHeatCond" name="upTabHeatCond"></span></td>
								        <td><span id="tempaturDownTabHeatCond" name="downTabHeatCond"></span></td>
								        <td><span id="tempaturUpRollHeatCond" name="upRollHeatCond"></span></td>
								        <td><span id="tempaturDownRollHeatCond" name="downRollHeatCond"></span></td>
								        <td><span id="tempaturUpFilmJoinTopCond" name="upFilmJoinTopCond"></span></td>
								        <td><span id="tempaturUpFilmJoinBottomCond" name="upFilmJoinBottomCond"></span></td>
								        <td><span id="tempaturDownFilmJoinTopCond" name="downFilmJoinTopCond"></span></td>
								        <td><span id="tempaturDownFilmJoinBottomCond" name="downFilmJoinBottomCond"></span></td>
								        <td><span id="tempaturDownTabHeatKeepCond" name="downTabHeatKeepCond"></span></td>
								        <td><span id="tempaturFup1stMTsidCond" name="fup1stMTsidCond"></span></td>
								        <td><span id="tempaturFup1stMTmidCond" name="fup1stMTmidCond"></span></td>
								        <td><span id="tempaturFdown1stMTsidCond" name="fdown1stMTsidCond"></span></td>
								        <td><span id="tempaturFdown1stMTmidCond" name="fdown1stMTmidCond"></span></td>
								        <td><span id="tempaturFup1stMTpushCond" name="fup1stMTpushCond"></span></td>
								        <td><span id="tempaturFdown1stMTpushCond" name="fdown1stMTpushCond"></span></td>
								        <td><span id="tempaturBup1stMTsidCond" name="bup1stMTsidCond"></span></td>
								        <td><span id="tempaturBup1stMTmidCond" name="bup1stMTmidCond"></span></td>
								        <td><span id="tempaturBdown1stMTsidCond" name="bdown1stMTsidCond"></span></td>
								        <td><span id="tempaturBdown1stMTmidCond" name="bdown1stMTmidCond"></span></td>
								        <td><span id="tempaturBup1stPushCond" name="bup1stPushCond"></span></td>
								        <td><span id="tempaturBdown1stPushCond" name="bdown1stPushCond"></span></td>
								    </tr>
								    <tr>
								        <th>공차 (+)</th>
								        <td><span id="tempaturUpTabHeatPlus" name="upTabHeatPlus"></span></td>
								        <td><span id="tempaturDownTabHeatPlus" name="downTabHeatPlus"></span></td>
								        <td><span id="tempaturUpRollHeatPlus" name="upRollHeatPlus"></span></td>
								        <td><span id="tempaturDownRollHeatPlus" name="downRollHeatPlus"></span></td>
								        <td><span id="tempaturUpFilmJoinTopPlus" name="upFilmJoinTopPlus"></span></td>
								        <td><span id="tempaturUpFilmJoinBottomPlus" name="upFilmJoinBottomPlus"></span></td>
								        <td><span id="tempaturDownFilmJoinTopPlus" name="downFilmJoinTopPlus"></span></td>
								        <td><span id="tempaturDownFilmJoinBottomPlus" name="downFilmJoinBottomPlus"></span></td>
								        <td><span id="tempaturDownTabHeatKeepPlus" name="downTabHeatKeepPlus"></span></td>
								        <td><span id="tempaturFup1stMTsidPlus" name="fup1stMTsidPlus"></span></td>
								        <td><span id="tempaturFup1stMTmidPlus" name="fup1stMTmidPlus"></span></td>
								        <td><span id="tempaturFdown1stMTsidPlus" name="fdown1stMTsidPlus"></span></td>
								        <td><span id="tempaturFdown1stMTmidPlus" name="fdown1stMTmidPlus"></span></td>
								        <td><span id="tempaturFup1stMTpushPlus" name="fup1stMTpushPlus"></span></td>
								        <td><span id="tempaturFdown1stMTpushPlus" name="fdown1stMTpushPlus"></span></td>
								        <td><span id="tempaturBup1stMTsidPlus" name="bup1stMTsidPlus"></span></td>
								        <td><span id="tempaturBup1stMTmidPlus" name="bup1stMTmidPlus"></span></td>
								        <td><span id="tempaturBdown1stMTsidPlus" name="bdown1stMTsidPlus"></span></td>
								        <td><span id="tempaturBdown1stMTmidPlus" name="bdown1stMTmidPlus"></span></td>
								        <td><span id="tempaturBup1stPushPlus" name="bup1stPushPlus"></span></td>
								        <td><span id="tempaturBdown1stPushPlus" name="bdown1stPushPlus"></span></td>
								    </tr>
									<tr>
										<th>공차 (-)</th>
										<td><span id="tempaturUpTabHeatMinus" name="upTabHeatMinus"></span></td>
										<td><span id="tempaturDownTabHeatMinus" name="downTabHeatMinus"></span></td>
										<td><span id="tempaturUpRollHeatMinus" name="upRollHeatMinus"></span></td>
										<td><span id="tempaturDownRollHeatMinus" name="downRollHeatMinus"></span></td>
										<td><span id="tempaturUpFilmJoinTopMinus" name="upFilmJoinTopMinus"></span></td>
										<td><span id="tempaturUpFilmJoinBottomMinus" name="upFilmJoinBottomMinus"></span></td>
										<td><span id="tempaturDownFilmJoinTopMinus" name="downFilmJoinTopMinus"></span></td>
										<td><span id="tempaturDownFilmJoinBottomMinus" name="downFilmJoinBottomMinus"></span></td>
										<td><span id="tempaturDownTabHeatKeepMinus" name="downTabHeatKeepMinus"></span></td>
										<td><span id="tempaturFup1stMTsidMinus" name="fup1stMTsidMinus"></span></td>
										<td><span id="tempaturFup1stMTmidMinus" name="fup1stMTmidMinus"></span></td>
										<td><span id="tempaturFdown1stMTsidMinus" name="fdown1stMTsidMinus"></span></td>
										<td><span id="tempaturFdown1stMTmidMinus" name="fdown1stMTmidMinus"></span></td>
										<td><span id="tempaturFup1stMTpushMinus" name="fup1stMTpushMinus"></span></td>
										<td><span id="tempaturFdown1stMTpushMinus" name="fdown1stMTpushMinus"></span></td>
										<td><span id="tempaturBup1stMTsidMinus" name="bup1stMTsidMinus"></span></td>
										<td><span id="tempaturBup1stMTmidMinus" name="bup1stMTmidMinus"></span></td>
										<td><span id="tempaturBdown1stMTsidMinus" name="bdown1stMTsidMinus"></span></td>
										<td><span id="tempaturBdown1stMTmidMinus" name="bdown1stMTmidMinus"></span></td>
										<td><span id="tempaturBup1stPushMinus" name="bup1stPushMinus"></span></td>
										<td><span id="tempaturBdown1stPushMinus" name="bdown1stPushMinus"></span></td>
									</tr>
								</tbody>
							</table>
							
							<!-- 아직 온도 테이블 -->
							<table class="table table-bordered">
								<thead>
									<tr>
										<th rowspan="2" style="min-width:40px">구분</th>
										<th colspan="24" style="min-width:40px">온도(°C)</th>
									</tr>
									<tr>
										<th>F-상부필름융착</th>
										<th>F-하부필름융착</th>
										<th>B-상부필름융착</th>
										<th>B-하부필름융착</th>
										<th>F-상부2차메탈(Sid)</th>
										<th>F-상부2차메탈(Mid)</th>
										<th>F-하부2차메탈(Sid)</th>
										<th>F-하부2차메탈(Mid)</th>
										<th>B-상부2차메탈(Sid)</th>
										<th>B-상부2차메탈(Mid)</th>
										<th>B-하부2차메탈(Sid)</th>
										<th>B-하부2차메탈(Mid)</th>
										<th>F-상부3차메탈(Sid)</th>
										<th>F-상부3차메탈(Mid)</th>
										<th>F-하부3차메탈(Sid)</th>
										<th>F-하부3차메탈(Mid)</th>
										<th>B-상부3차메탈(Sid)</th>
										<th>B-상부3차메탈(Mid)</th>
										<th>B-하부3차메탈(Sid)</th>
										<th>B-하부3차메탈(Mid)</th>
										<th>F-상부필름성형냉각</th>
										<th>F-하부필름성형냉각</th>
										<th>B-상부필름성형냉각</th>
										<th>B-하부필름성형냉각</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>조건	</th>
										<td><span id="tempaturFupFilmFuseCond" name="fupFilmFuseCond"></span></td>
										<td><span id="tempaturFdownFilmFuseCond" name="fdownFilmFuseCond"></span></td>
										<td><span id="tempaturBupFilmFuseCond" name="bupFilmFuseCond"></span></td>
										<td><span id="tempaturBdownFilmFuseCond" name="bdownFilmFuseCond"></span></td>
										<td><span id="tempaturFup2ndMTsidCond" name="fup2ndMTsidCond"></span></td>
										<td><span id="tempaturFup2ndMTmidCond" name="fup2ndMTmidCond"></span></td>
										<td><span id="tempaturFdown2ndMTsidCond" name="fdown2ndMTsidCond"></span></td>
										<td><span id="tempaturFdown2ndMTmidCond" name="fdown2ndMTmidCond"></span></td>
										<td><span id="tempaturBup2ndMTsidCond" name="bup2ndMTsidCond"></span></td>
										<td><span id="tempaturBup2ndMTmidCond" name="bup2ndMTmidCond"></span></td>
										<td><span id="tempaturBdown2ndMTsidCond" name="bdown2ndMTsidCond"></span></td>
										<td><span id="tempaturBdown2ndMTmidCond" name="bdown2ndMTmidCond"></span></td>
										<td><span id="tempaturFup3rdMTsidCond" name="fup3rdMTsidCond"></span></td>
										<td><span id="tempaturFup3rdMTmidCond" name="fup3rdMTmidCond"></span></td>
										<td><span id="tempaturFdown3rdMTsidCond" name="fdown3rdMTsidCond"></span></td>
										<td><span id="tempaturFdown3rdMTmidCond" name="fdown3rdMTmidCond"></span></td>
										<td><span id="tempaturBup3rdMTsidCond" name="bup3rdMTsidCond"></span></td>
										<td><span id="tempaturBup3rdMTmidCond" name="bup3rdMTmidCond"></span></td>
										<td><span id="tempaturBdown3rdMTsidCond" name="bdown3rdMTsidCond"></span></td>
										<td><span id="tempaturBdown3rdMTmidCond" name="bdown3rdMTmidCond"></span></td>
										<td><span id="tempaturFupFilmRfmCoolCond" name="fupFilmRfmCoolCond"></span></td>
										<td><span id="tempaturFdownFilmRfmCoolCond" name="fdownFilmRfmCoolCond"></span></td>
										<td><span id="tempaturBupFilmRfmCoolCond" name="bupFilmRfmCoolCond"></span></td>
										<td><span id="tempaturBdownFilmRfmCoolCond" name="bdownFilmRfmCoolCond"></span></td>
									</tr>
									<tr>
										<th>공차 (+)</th>
										<td><span id="tempaturFupFilmFusePlus" name="fupFilmFusePlus"></span></td>
										<td><span id="tempaturFdownFilmFusePlus" name="fdownFilmFusePlus"></span></td>
										<td><span id="tempaturBupFilmFusePlus" name="bupFilmFusePlus"></span></td>
										<td><span id="tempaturBdownFilmFusePlus" name="bdownFilmFusePlus"></span></td>
										<td><span id="tempaturFup2ndMTsidPlus" name="fup2ndMTsidPlus"></span></td>
										<td><span id="tempaturFup2ndMTmidPlus" name="fup2ndMTmidPlus"></span></td>
										<td><span id="tempaturFdown2ndMTsidPlus" name="fdown2ndMTsidPlus"></span></td>
										<td><span id="tempaturFdown2ndMTmidPlus" name="fdown2ndMTmidPlus"></span></td>
										<td><span id="tempaturBup2ndMTsidPlus" name="bup2ndMTsidPlus"></span></td>
										<td><span id="tempaturBup2ndMTmidPlus" name="bup2ndMTmidPlus"></span></td>
										<td><span id="tempaturBdown2ndMTsidPlus" name="bdown2ndMTsidPlus"></span></td>
										<td><span id="tempaturBdown2ndMTmidPlus" name="bdown2ndMTmidPlus"></span></td>
										<td><span id="tempaturFup3rdMTsidPlus" name="fup3rdMTsidPlus"></span></td>
										<td><span id="tempaturFup3rdMTmidPlus" name="fup3rdMTmidPlus"></span></td>
										<td><span id="tempaturFdown3rdMTsidPlus" name="fdown3rdMTsidPlus"></span></td>
										<td><span id="tempaturFdown3rdMTmidPlus" name="fdown3rdMTmidPlus"></span></td>
										<td><span id="tempaturBup3rdMTsidPlus" name="bup3rdMTsidPlus"></span></td>
										<td><span id="tempaturBup3rdMTmidPlus" name="bup3rdMTmidPlus"></span></td>
										<td><span id="tempaturBdown3rdMTsidPlus" name="bdown3rdMTsidPlus"></span></td>
										<td><span id="tempaturBdown3rdMTmidPlus" name="bdown3rdMTmidPlus"></span></td>
										<td><span id="tempaturFupFilmRfmCoolPlus" name="fupFilmRfmCoolPlus"></span></td>
										<td><span id="tempaturFdownFilmRfmCoolPlus" name="fdownFilmRfmCoolPlus"></span></td>
										<td><span id="tempaturBupFilmRfmCoolPlus" name="bupFilmRfmCoolPlus"></span></td>
										<td><span id="tempaturBdownFilmRfmCoolPlus" name="bdownFilmRfmCoolPlus"></span></td>
									</tr>
									<tr>
										<th>공차 (-)</th>
										<td><span id="tempaturFupFilmFuseMinus" name="fupFilmFuseMinus"></span></td>
										<td><span id="tempaturFdownFilmFuseMinus" name="fdownFilmFuseMinus"></span></td>
										<td><span id="tempaturBupFilmFuseMinus" name="bupFilmFuseMinus"></span></td>
										<td><span id="tempaturBdownFilmFuseMinus" name="bdownFilmFuseMinus"></span></td>
										<td><span id="tempaturFup2ndMTsidMinus" name="fup2ndMTsidMinus"></span></td>
										<td><span id="tempaturFup2ndMTmidMinus" name="fup2ndMTmidMinus"></span></td>
										<td><span id="tempaturFdown2ndMTsidMinus" name="fdown2ndMTsidMinus"></span></td>
										<td><span id="tempaturFdown2ndMTmidMinus" name="fdown2ndMTmidMinus"></span></td>
										<td><span id="tempaturBup2ndMTsidMinus" name="bup2ndMTsidMinus"></span></td>
										<td><span id="tempaturBup2ndMTmidMinus" name="bup2ndMTmidMinus"></span></td>
										<td><span id="tempaturBdown2ndMTsidMinus" name="bdown2ndMTsidMinus"></span></td>
										<td><span id="tempaturBdown2ndMTmidMinus" name="bdown2ndMTmidMinus"></span></td>
										<td><span id="tempaturFup3rdMTsidMinus" name="fup3rdMTsidMinus"></span></td>
										<td><span id="tempaturFup3rdMTmidMinus" name="fup3rdMTmidMinus"></span></td>
										<td><span id="tempaturFdown3rdMTsidMinus" name="fdown3rdMTsidMinus"></span></td>
										<td><span id="tempaturFdown3rdMTmidMinus" name="fdown3rdMTmidMinus"></span></td>
										<td><span id="tempaturBup3rdMTsidMinus" name="bup3rdMTsidMinus"></span></td>
										<td><span id="tempaturBup3rdMTmidMinus" name="bup3rdMTmidMinus"></span></td>
										<td><span id="tempaturBdown3rdMTsidMinus" name="bdown3rdMTsidMinus"></span></td>
										<td><span id="tempaturBdown3rdMTmidMinus" name="bdown3rdMTmidMinus"></span></td>
										<td><span id="tempaturFupFilmRfmCoolMinus" name="fupFilmRfmCoolMinus"></span></td>
										<td><span id="tempaturFdownFilmRfmCoolMinus" name="fdownFilmRfmCoolMinus"></span></td>
										<td><span id="tempaturBupFilmRfmCoolMinus" name="bupFilmRfmCoolMinus"></span></td>
										<td><span id="tempaturBdownFilmRfmCoolMinus" name="bdownFilmRfmCoolMinus"></span></td>
	
									</tr>
								</tbody>
							</table>
							<!-- 온도 테이블 끝 -->
						</form>
						
						<!-- 시간 -->
						<form id="time">
							<!-- 시간 테이블 -->
							<table class="table table-bordered">
								<thead>
									<tr>
										<th rowspan="2" style="min-width:40px">구분</th>
										<th colspan="17" style="min-width:40px">시간(SEC)</th>
									</tr>
									<tr>
										<th>1차메탈 가열대기시간</th>
										<th>1차메탈 가열시간</th>
										<th>1차메탈 푸셔대기시간</th>
										<th>1차메탈 푸셔시간</th>
										<th>2차메탈 가열대기시간</th>
										<th>2차메탈 가열시간</th>
										<th>2차메탈 푸셔대기시간</th>
										<th>2차메탈 푸셔시간</th>
										<th>3차메탈 가열대기시간</th>
										<th>3차메탈 가열시간</th>
										<th>3차메탈 푸셔대기시간</th>
										<th>3차메탈 푸셔시간</th>
										<th>필름융착서보히터 1동작 대기</th>
										<th>필름융착서보히터 1동작 가열</th>
										<th>필름성형서보히터 1동작 대기</th>
										<th>필름성형서보히터 1동작 가열</th>
									</tr>
								</thead>
								<tbody>
									<tr>
									    <th>조건</th>
									    <td><span id="timeOneStMTwaittimeCond" name="oneStMTwaittimeCond"></span></td>
									    <td><span id="timeOneStMTheattimeCond" name="oneStMTheattimeCond"></span></td>
									    <td><span id="timeOneStMTpushwaittimeCond" name="oneStMTpushwaittimeCond"></span></td>
									    <td><span id="timeOneStMTpushheattimeCond" name="oneStMTpushheattimeCond"></span></td>
									    <td><span id="timeTwoNdMTwaittimeCond" name="twoNdMTwaittimeCond"></span></td>
									    <td><span id="timeTwoNdMTheattimeCond" name="twoNdMTheattimeCond"></span></td>
									    <td><span id="timeTwoNdMTpushwaittimeCond" name="twoNdMTpushwaittimeCond"></span></td>
									    <td><span id="timeTwoNdMTpushheattimeCond" name="twoNdMTpushheattimeCond"></span></td>
									    <td><span id="timeThreeRdMTwaittimeCond" name="threeRdMTwaittimeCond"></span></td>
									    <td><span id="timeThreeRdMTheattimeCond" name="threeRdMTheattimeCond"></span></td>
									    <td><span id="timeThreeRdMTpushwaittimeCond" name="threeRdMTpushwaittimeCond"></span></td>
									    <td><span id="timeThreeRdMTpushheattimeCond" name="threeRdMTpushheattimeCond"></span></td>
									    <td><span id="timeFilmFSH1operwaittimeCond" name="filmFSH1operwaittimeCond"></span></td>
									    <td><span id="timeFilmFSH1operheattimeCond" name="filmFSH1operheattimeCond"></span></td>
									    <td><span id="timeFilmRSH1operwaittimeCond" name="filmRSH1operwaittimeCond"></span></td>
									    <td><span id="timeFilmRSH1operheattimeCond" name="filmRSH1operheattimeCond"></span></td>
									</tr>
									<tr>
									    <th>공차 (+)</th>
									    <td><span id="timeOneStMTwaittimePlus" name="oneStMTwaittimePlus"></span></td>
									    <td><span id="timeOneStMTheattimePlus" name="oneStMTheattimePlus"></span></td>
									    <td><span id="timeOneStMTpushwaittimePlus" name="oneStMTpushwaittimePlus"></span></td>
									    <td><span id="timeOneStMTpushheattimePlus" name="oneStMTpushheattimePlus"></span></td>
									    <td><span id="timeTwoNdMTwaittimePlus" name="twoNdMTwaittimePlus"></span></td>
									    <td><span id="timeTwoNdMTheattimePlus" name="twoNdMTheattimePlus"></span></td>
									    <td><span id="timeTwoNdMTpushwaittimePlus" name="twoNdMTpushwaittimePlus"></span></td>
									    <td><span id="timeTwoNdMTpushheattimePlus" name="twoNdMTpushheattimePlus"></span></td>
									    <td><span id="timeThreeRdMTwaittimePlus" name="threeRdMTwaittimePlus"></span></td>
									    <td><span id="timeThreeRdMTheattimePlus" name="threeRdMTheattimePlus"></span></td>
									    <td><span id="timeThreeRdMTpushwaittimePlus" name="threeRdMTpushwaittimePlus"></span></td>
									    <td><span id="timeThreeRdMTpushheattimePlus" name="threeRdMTpushheattimePlus"></span></td>
									    <td><span id="timeFilmFSH1operwaittimePlus" name="filmFSH1operwaittimePlus"></span></td>
									    <td><span id="timeFilmFSH1operheattimePlus" name="filmFSH1operheattimePlus"></span></td>
									    <td><span id="timeFilmRSH1operwaittimePlus" name="filmRSH1operwaittimePlus"></span></td>
									    <td><span id="timeFilmRSH1operheattimePlus" name="filmRSH1operheattimePlus"></span></td>
									</tr>
									<tr>
									    <th>공차 (-)</th>
									    <td><span id="timeOneStMTwaittimeMinus" name="oneStMTwaittimeMinus"></span></td>
									    <td><span id="timeOneStMTheattimeMinus" name="oneStMTheattimeMinus"></span></td>
									    <td><span id="timeOneStMTpushwaittimeMinus" name="oneStMTpushwaittimeMinus"></span></td>
									    <td><span id="timeOneStMTpushheattimeMinus" name="oneStMTpushheattimeMinus"></span></td>
									    <td><span id="timeTwoNdMTwaittimeMinus" name="twoNdMTwaittimeMinus"></span></td>
									    <td><span id="timeTwoNdMTheattimeMinus" name="twoNdMTheattimeMinus"></span></td>
									    <td><span id="timeTwoNdMTpushwaittimeMinus" name="twoNdMTpushwaittimeMinus"></span></td>
									    <td><span id="timeTwoNdMTpushheattimeMinus" name="twoNdMTpushheattimeMinus"></span></td>
									    <td><span id="timeThreeRdMTwaittimeMinus" name="threeRdMTwaittimeMinus"></span></td>
									    <td><span id="timeThreeRdMTheattimeMinus" name="threeRdMTheattimeMinus"></span></td>
									    <td><span id="timeThreeRdMTpushwaittimeMinus" name="threeRdMTpushwaittimeMinus"></span></td>
									    <td><span id="timeThreeRdMTpushheattimeMinus" name="threeRdMTpushheattimeMinus"></span></td>
									    <td><span id="timeFilmFSH1operwaittimeMinus" name="filmFSH1operwaittimeMinus"></span></td>
									    <td><span id="timeFilmFSH1operheattimeMinus" name="filmFSH1operheattimeMinus"></span></td>
									    <td><span id="timeFilmRSH1operwaittimeMinus" name="filmRSH1operwaittimeMinus"></span></td>
									    <td><span id="timeFilmRSH1operheattimeMinus" name="filmRSH1operheattimeMinus"></span></td>
									</tr>
								</tbody>
							</table>
							<!-- 시간 테이블 끝 -->
						</form>
						
						<!-- 치수 -->
						<form id="size">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th style="min-width:40px">구분</th>
										<th colspan="13">연동 치수 항목</th>
										<th colspan="7">Manual 측정 치수 항목</th>									
									</tr>
									<tr>
										<th style="min-width:40px">SK on</th>
										<th style="min-width:40px">Metal 폭</th>
										<th style="min-width:40px">Metal 총길이</th>
										<th style="min-width:40px">Film 폭 (좌)</th>									 
										<th style="min-width:40px">Film 폭 (중)</th>
										<th style="min-width:40px">Film 폭 (우)</th>
										<th style="min-width:40px">Film 총길이</th>
										<th style="min-width:40px">Welding Part (좌)</th>
										<th style="min-width:40px">Welding Part (중)</th>
										<th style="min-width:40px">Welding Part (우)</th>
										<th style="min-width:40px">좌/우 편차</th>
										<th style="min-width:40px">(X1-X2)</th>
										<th style="min-width:40px">날개 Margin (좌)</th>
										<th style="min-width:40px">날개 Margin (우)</th>
										<th style="min-width:40px">Metal 두께</th>
										<th style="min-width:40px">총 두께 (Edge 좌)</th>
										<th style="min-width:40px">총 두께 (Center)</th>
										<th style="min-width:40px">총 두께 (Edge 우)</th>
										<th style="min-width:40px">Metal Burr</th>
										<th style="min-width:40px">Layer</th>
										<th style="min-width:40px">Bending</th>									
									</tr>
									<tr>
										<th style="min-width:40px">LGES</th>
										<th style="min-width:40px">d</th>
										<th style="min-width:40px">L</th>
										<th style="min-width:40px">l1</th>						 
										<th style="min-width:40px">l2</th>
										<th style="min-width:40px">l3</th>
										<th style="min-width:40px">W</th>
										<th style="min-width:40px">S1</th>
										<th style="min-width:40px">S2</th>
										<th style="min-width:40px">S3</th>
										<th style="min-width:40px">S1-S3</th>
										<th style="min-width:40px">X1-X2</th>
										<th style="min-width:40px">M1</th>
										<th style="min-width:40px">M2</th>
										<th style="min-width:40px">t</th>
										<th style="min-width:40px">T1</th>
										<th style="min-width:40px">T2</th>
										<th style="min-width:40px">T3</th>
										<th style="min-width:40px">Burr</th>
										<th style="min-width:40px">g</th>
										<th style="min-width:40px">b</th>			
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>조건	</th>
										<td><span id="sizeViewMetalDepthCond" name="metalDepthCond"></span></td>
										<td><span id="sizeViewPitchLeftCond" name="pitchLeftCond"></span></td>
										<td><span id="sizeViewPpfDepthLeftCond" name="ppfDepthLeftCond"></span></td>
										<td><span id="sizeViewPpfDepthCenterCond" name="ppfDepthCenterCond"></span></td>
										<td><span id="sizeViewPpfDepthRightCond" name="ppfDepthRightCond"></span></td>
										<td><span id="sizeViewFilmCond" name="filmCond"></span></td>
										<td><span id="sizeViewWpLeftCond" name="wpLeftCond"></span></td>
										<td><span id="sizeViewWpCenterCond" name="wpCenterCond"></span></td>
										<td><span id="sizeViewWpRightCond" name="wpRightCond"></span></td>
										<td><span id="sizeViewWpDeviationCond" name="wpDeviationCond"></span></td>
										<td><span id="sizeViewX1X2Cond" name="x1X2Cond"></span></td>
										<td><span id="sizeViewPpfWingLeftCond" name="ppfWingLeftCond"></span></td>
										<td><span id="sizeViewPpfWingRightCond" name="ppfWingRightCond"></span></td>
										<td><span id="sizeViewMetalThicknessCond" name="metalThicknessCond"></span></td>
										<td><span id="sizeViewThEdgeCond" name="thEdgeCond"></span></td>
										<td><span id="sizeViewThCenterCond" name="thCenterCond"></span></td>
										<td><span id="sizeViewThEdgeRightCond" name="thEdgeRightCond"></span></td>
										<td><span id="sizeViewBurrCond" name="burrCond"></span></td>
										<td><span id="sizeViewGapOfLayerCond" name="gapOfLayerCond"></span></td>
										<td><span id="sizeViewBendingCond" name="bendingCond"></span></td>
									</tr>
									<tr>
										<th>공차 (+)</th>
										<td><span id="sizeViewMetalDepthAlwncePlus" name="metalDepthAlwncePlus"></span></td>
										<td><span id="sizeViewPitchLeftAlwncePlus" name="pitchLeftAlwncePlus"></span></td>
										<td><span id="sizeViewPpfDepthLeftAlwncePlus" name="ppfDepthLeftAlwncePlus"></span></td>
										<td><span id="sizeViewPpfDepthCenterAlwncePlus" name="ppfDepthCenterAlwncePlus"></span></td>
										<td><span id="sizeViewPpfDepthRightAlwncePlus" name="ppfDepthRightAlwncePlus"></span></td>
										<td><span id="sizeViewFilmAlwncePlus" name="filmAlwncePlus"></span></td>
										<td><span id="sizeViewWpLeftAlwncePlus" name="wpLeftAlwncePlus"></span></td>
										<td><span id="sizeViewWpCenterAlwncePlus" name="wpCenterAlwncePlus"></span></td>
										<td><span id="sizeViewWpRightAlwncePlus" name="wpRightAlwncePlus"></span></td>
										<td><span id="sizeViewWpDeviationAlwncePlus" name="wpDeviationAlwncePlus"></span></td>
										<td><span id="sizeViewX1X2AlwncePlus" name="x1X2AlwncePlus"></span></td>
										<td><span id="sizeViewPpfWingLeftAlwncePlus" name="ppfWingLeftAlwncePlus"></span></td>
										<td><span id="sizeViewPpfWingRightAlwncePlus" name="ppfWingRightAlwncePlus"></span></td>
										<td><span id="sizeViewMetalThicknessAlwncePlus" name="metalThicknessAlwncePlus"></span></td>
										<td><span id="sizeViewThEdgeAlwncePlus" name="thEdgeAlwncePlus"></span></td>
										<td><span id="sizeViewThCenterAlwncePlus" name="thCenterAlwncePlus"></span></td>
										<td><span id="sizeViewThEdgeRightAlwncePlus" name="thEdgeRightAlwncePlus"></span></td>
										<td><span id="sizeViewBurrAlwncePlus" name="burrAlwncePlus"></span></td>
										<td><span id="sizeViewGapOfLayerPlus" name="gapOfLayerPlus"></span></td>
										<td><span id="sizeViewBendingAlwncePlus" name="bendingAlwncePlus"></span></td>
									</tr>
									<tr>
										<th>공차 (-)</th>
										<td><span id="sizeViewMetalDepthAlwnceMinus" name="metalDepthAlwnceMinus"></span></td>
										<td><span id="sizeViewPitchLeftAlwnceMinus" name="pitchLeftAlwnceMinus"></span></td>
										<td><span id="sizeViewPpfDepthLeftAlwnceMinus" name="ppfDepthLeftAlwnceMinus"></span></td>
										<td><span id="sizeViewPpfDepthCenterAlwnceMinus" name="ppfDepthCenterAlwnceMinus"></span></td>
										<td><span id="sizeViewPpfDepthRightAlwnceMinus" name="ppfDepthRightAlwnceMinus"></span></td>
										<td><span id="sizeViewFilmAlwnceMinus" name="filmAlwnceMinus"></span></td>
										<td><span id="sizeViewWpLeftAlwnceMinus" name="wpLeftAlwnceMinus"></span></td>
										<td><span id="sizeViewWpCenterAlwnceMinus" name="wpCenterAlwnceMinus"></span></td>
										<td><span id="sizeViewWpRightAlwnceMinus" name="wpRightAlwnceMinus"></span></td>
										<td><span id="sizeViewWpDeviationAlwnceMinus" name="wpDeviationAlwnceMinus"></span></td>
										<td><span id="sizeViewX1X2AlwnceMinus" name="x1X2AlwnceMinus"></span></td>
										<td><span id="sizeViewPpfWingLeftAlwnceMinus" name="ppfWingLeftAlwnceMinus"></span></td>
										<td><span id="sizeViewPpfWingRightAlwnceMinus" name="ppfWingRightAlwnceMinus"></span></td>
										<td><span id="sizeViewMetalThicknessAlwnceMinus" name="metalThicknessAlwnceMinus"></span></td>
										<td><span id="sizeViewThEdgeAlwnceMinus" name="thEdgeAlwnceMinus"></span></td>
										<td><span id="sizeViewThCenterAlwnceMinus" name="thCenterAlwnceMinus"></span></td>
										<td><span id="sizeViewThEdgeRightAlwnceMinus" name="thEdgeRightAlwnceMinus"></span></td>
										<td><span id="sizeViewBurrAlwnceMinus" name="burrAlwnceMinus"></span></td>
										<td><span id="sizeViewGapOfLayerMinus" name="gapOfLayerMinus"></span></td>
										<td><span id="sizeViewBendingAlwnceMinus" name="bendingAlwnceMinus"></span></td>
									</tr>
								</tbody>
							</table>
						</form>
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

	let menuAuth = 'eisc3020';
	let currentHref = 'eisc3020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","가동시간(6층)");
	
	//공통코드 처리 시작
	let equipGroupCode = new Array();	//설비그룹
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>

    let ordGubunCode = new Array();		//오더구분(주/야 구분)
    <c:forEach items="${ordGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubunCode.push(json);
    </c:forEach>    
    //공통코드 처리 종료 
    
	// 온도
	$('#tempatur span').text("0");
	  
	// 시간
	$('#time span').text("0");
	  
	// 치수
	$('#size span').text("0");
    
    // 목록
	let equipCd = null;		//설비코드 전역변수 선언(작업지시 계획조회, 제조조건 계획 조회 시 사용)    
	let equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	
	let ordDateCal = "${serverDate}";
	let ordGubunCd = null; 

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
            	'equipGubun' : function() { return "C"; },
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
				/* url: '<c:url value="/wm/onlyBomDataList"/>', */
				url: '<c:url value="/em/equipBomDataSixFloorList"/>',
				type: 'GET',
				data: {
					'equipCondSeq'	: equipCondSeq,
					'pageGubun'		: "emsc3030",
				},
				success: function (res) {
                    let tempaturData		= res.tempaturData;
                    let timeData			= res.timeData;
                    let pressureData		= res.pressureData;
                    let sizeData			= res.sizeData;
					
					let domTempatur			= $('#tempatur table tbody tr').find('td span');
                    let domTime				= $('#time table tbody tr').find('td span');
                    let domSize				= $('#size table tbody tr').find('td span');
					
					if (res.result == 'ok') {
						//온도 처리 부분
		                for(var i=0; i<domTempatur.length; i++){
		                	domTempatur.eq(i).text( tempaturData[domTempatur.eq(i).attr('name')] );
		                }
		                //시간 처리 부분
		                for(var i=0; i<domTime.length; i++){
		                	domTime.eq(i).text( timeData[domTime.eq(i).attr('name')] );
		                }
		                //치수 처리 부분
		                for(var i=0; i<domSize.length; i++){
		                	domSize.eq(i).text( sizeData[domSize.eq(i).attr('name')] );
		                }
 	                    
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
    	
    	 // 온도
        $('#tempatur span').text("0");
        
        // 시간
        $('#time span').text("0");
        
     	// 치수
        $('#size span').text("0");
    }
	
</script>
</body>
</html>
