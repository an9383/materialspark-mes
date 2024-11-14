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
				<li class="breadcrumb-item active">작업지시(6층)</li>
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
										<th><!-- 주야구분 --></th>
										<th>제조조건코드</th>
										<th>제품(기종)</th>
										<th>재질</th>
										<th>규격</th>
										<th>표면처리</th>
									</tr>
								</thead>
								<tbody>
									<tr id="day">
										<!-- <th>주간</th> -->
										<th>
											<input type="hidden" id="searchDay">
											<input type="hidden" id="dayEquipCondSeq" name="equipCondSeq">
											<input type="hidden" id="dayEquipCd" name="equipCd">
											<input type="hidden" id="dayGoodsCd" name="goodsCd">
											<input type="hidden" id="dayWorkGubunCd" name="workGubunCd" value="day">
											작업지시 계획
										</th>
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
								</tbody>
							</table>
						</form>
					</div>
					
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
									<th>F-하부1차메탈(Sid)</th>
									<th>F-상부1차메탈(Mid)</th>
									<th>F-하부1차메탈(Mid)</th>
									<th>F-상부1차푸셔</th>
									<th>F-하부1차푸셔</th>
									<th>B-상부1차메탈(Sid)</th>
									<th>B-하부1차메탈(Sid)</th>
									<th>B-상부1차메탈(Mid)</th>
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
									<th>F-하부2차메탈(Sid)</th>
									<th>F-상부2차메탈(Mid)</th>
									<th>F-하부2차메탈(Mid)</th>
									<th>B-상부2차메탈(Sid)</th>
									<th>B-하부2차메탈(Sid)</th>
									<th>B-상부2차메탈(Mid)</th>
									<th>B-하부2차메탈(Mid)</th>
									<th>F-상부3차메탈(Sid)</th>
									<th>F-하부3차메탈(Sid)</th>
									<th>F-상부3차메탈(Mid)</th>
									<th>F-하부3차메탈(Mid)</th>
									<th>B-상부3차메탈(Sid)</th>
									<th>B-하부3차메탈(Sid)</th>
									<th>B-상부3차메탈(Mid)</th>
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
				
				</div><!--// 등록, 수정 -->
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

	let menuAuth = 'wmsc3020';
	let currentHref = 'wmsc3020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "작업지시(6층)");
	
	var serverDate =  "${serverDate}";
	var serverDateFuture =  "${serverDateFuture}";
    //var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	//if( equipGroup == 'null'){
	//	equipGroup = null;
	//}
	
	//공통코드 처리 시작
	//var equipGroupCode = new Array(); // 설치장소
    //<c:forEach items="${equipGroupCd}" var="info">
	//	var json=new Object();
	//	json.baseCd="${info.baseCd}";
	//	json.baseCdNm="${info.baseCdNm}";
	//	equipGroupCode.push(json);
    //</c:forEach>
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
            	'menuAuth'	 	: 	menuAuth,
            	'equipGubun'	:	function() { return "C"; },
            	//'equipGroup' : function() { return equipGroup; }
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
	//html1 += '&nbsp;<label class="input-label-sm">설비그룹</label><select  class="custom-select" id="equipGroupCd" ></select>';
	html1 += '</div>';
	$('#equipCodeAdmTable_length').html(html1);
	//selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");

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
   	   	} else {
   			if ( $(this).hasClass('tableSelected') ) {
   	            $(this).removeClass('tableSelected');
				rowNumber = null;
   	        } else {
   				$('tr.tableSelected').removeClass('tableSelected');
   				$(this).addClass('tableSelected');
   				workOrderPlanRowIdx = $(this).closest('tr').attr('id');
   			 	$('#btnSave').attr('disabled', false);
   				rowNumber = $(this).closest('tr').prevAll().length;
   				rowNumberTemp = rowNumber;
    			var equipCondSeq = null;
    			
    			//주간, 야간 선택행 판단
    			if (rowNumber == 0) {
    				
    				equipCondSeq = $('#dayEquipCondSeq').val();
    				
 			    	if( equipCondSeq != null && equipCondSeq != "" ) {
 			    		
    			      	$.ajax({
    			 	            //url: '<c:url value="/wm/onlyBomDataList"/>',
    			 	            url: '<c:url value="/em/equipBomDataSixFloorList"/>',
    			 	            type: 'GET',
    			 	            data: {
    			 	            	'menuAuth'	 	: 	menuAuth,
    			 	            	'equipCondSeq'	: 	equipCondSeq,
    			 	            	'pageGubun'		:	"emsc3030",
    			 	            },
    			 	            success: function (res) {
									let manufacturerData	= res.manufacturerData;
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
   	function manufacturerList() {
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
						'equipCd'		:		function() { return equipCd; },
						'lineGubun'		:		function() { return "4Line"; },
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

			//제조조건 계획 정보 클릭 시
			$('#equipCondCommonAdmTable tbody').on('click', 'tr', function () {
				goodsCd			= equipCondCommonAdmTable.row( this ).data().goodsCd;
				equipCondSeq	= equipCondCommonAdmTable.row( this ).data().equipCondSeq;
				
				//상세조회
				$.ajax({
		            url: '<c:url value="/em/equipBomDataSixFloorList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 	menuAuth,
		            	'equipCondSeq'	:	equipCondSeq,
		            	'goodsCd'		:	goodsCd,
		            	'pageGubun'		:	"emsc3030",
		            },
		            success: function (res) {
		                
		                let manufacturerData	= res.manufacturerData;
	                    let tempaturData		= res.tempaturData;
	                    let timeData			= res.timeData;
	                    let pressureData		= res.pressureData;
	                    let sizeData			= res.sizeData;
	                    
	                    let domTempatur			= $('#tempatur table tbody tr').find('td span');
	                    let domTime				= $('#time table tbody tr').find('td span');
	                    let domSize				= $('#size table tbody tr').find('td span');
		                
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
			               		
							} else if (workOrderPlanRowIdx == "night") {
								$('#equipCondSeq2').text(equipCondSeq);								//제조조건코드
			               		$('#addFormGoodsNm2').val(manufacturerData.goodsNm);				//제품명
			               		$('#addFormModel2').text(manufacturerData.model);					//규격
			               		$('#addFormQutyCd2').text(manufacturerData.alniQutyNm);				//재질
			               		$('#addFormSurfaceTrtmtNm2').text(manufacturerData.surfaceTrtmtNm);	//표면처리
			               		$('#nightEquipCondSeq').val(tempaturData.equipCondSeq);				//야간조 hidden SEQ
			               		$('#nightGoodsCd').val(manufacturerData.goodsCd);					//제품코드
							}
				
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
  			toastr.warning('저장할 작업지시 계획을 선택해 주세요.');
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
							toastr.success('작업지시 계획이 등록되었습니다.');
				  	  	}
				  		else if (flag == "U"){
				  			toastr.success('작업지시 계획이 수정되었습니다.');
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
  		 // 온도
        $('#tempatur span').text("0");
        
        // 시간
        $('#time span').text("0");
        
     	// 치수
        $('#size span').text("0");
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
	function date() {
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
	
</script>
</body>
</html>
