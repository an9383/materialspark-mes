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
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">기초제조조건관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list left-60" id="left-60" style="width:24%;">
                      <div class="card">
			        	<!-- BOM코드 전체 조회 -->
			        	<select id="bom" class="custom-select custom-select-sm" style="width:25%;"></select>
						<div  class="table-responsive">
							<table class="table table-bordered" id="bomList">
								<thead class="thead-light">
									<tr>
										<th style="min-width: 60px">명칭</th>
										<th style="min-width: 60px">코드</th>
									</tr>
								</thead>
							</table>
						</div>
						<!-- BOM코드 전체 조회 끝-->
	                    </div>
	                <!-- /.table-responsive -->
	                </div>
	                <div class="left-list right-list right-40" id="myrSidenav" style="width:37%;">
                    <div class="card" id="formBox">                                 
                        <div id="tempaturFormBox" class="d-none">
		                <form id="tempaturForm">
		                <div class="card-body col-sm-12">
			                <button type="button" class="btn btn-primary float-right mr-1" id="tempaturBtnEdit" disabled>수정</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="tempaturBtnAdd">등록</button>
						</div>
							<table class="table table-bordered">
								<colgroup>
									<col width="22%">
									<col width="26%">
									<col width="26%">
									<col width="26%">
								</colgroup>
								<tr>
									<th>온도 코드</th>
									<td><input type="text" maxlength="10" class="form-control" id="tempaturTempaturCondCd"name="tempaturCondCd" style="max-width:100%;" disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*온도 명칭</th><td colspan="4">
									<input type="text" class="form-control" id="tempaturTempaturCondNm" name="tempaturCondNm" style="max-width:100%;" maxlength="50"></td>
								</tr>
								<tr>
									<th>구분	</th>
		                            <th>*조건	</th>
		                            <th>*공차(+)</th>
		                            <th>*공차(-)</th>
								</tr>
								<tr>
									<th>예열	</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturWarmupCond" 		name="warmupCond"		></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturWarmupAlwncePlus" 	name="warmupAlwncePlus"	></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturWarmupAlwnceMinus"	name="warmupAlwnceMinus"></td>
								</tr>
								<tr>
									<th>가접1 - 상</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup1UpCond" 		name="fitup1UpCond">		</td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup1UpAlwncePlus" name="fitup1UpAlwncePlus">	</td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup1UpAlwnceMinus"name="fitup1UpAlwnceMinus">	</td>
								</tr>
								<tr>
									<th>가접1 - 하</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup1DownCond"			name="fitup1DownCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup1DownAlwncePlus"	name="fitup1DownAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup1DownAlwnceMinus"	name="fitup1DownAlwnceMinus"></td>
								</tr>
								<tr>
									<th>가접2 - 상좌</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2UpleftCond" 		name="fitup2UpleftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2UpleftAlwncePlus" name="fitup2UpleftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2UpleftAlwnceMinus"name="fitup2UpleftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>가접2 - 하좌</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2DownleftCond" 		name="fitup2DownleftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2DownleftAlwncePlus" 	name="fitup2DownleftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2DownleftAlwnceMinus"	name="fitup2DownleftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>가접2 - 상우</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2UprightCond" 			name="fitup2UprightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2UprightAlwncePlus"	name="fitup2UprightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2UprightAlwnceMinus"	name="fitup2UprightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>가접2 - 하우</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2DownrightCond" 		name="fitup2DownrightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2DownrightAlwncePlus" 	name="fitup2DownrightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2DownrightAlwnceMinus"	name="fitup2DownrightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>롤히터  - 상</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturRollheatUpCond" 			name="rollheatUpCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturRollheatUpAlwncePlus" 		name="rollheatUpAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturRollheatUpAlwnceMinus"		name="rollheatUpAlwnceMinus"></td>
								</tr>
								<tr>
									<th>롤히터 - 하</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturRollheatDownCond" 			name="rollheatDownCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturRollheatDownAlwncePlus" 	name="rollheatDownAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturRollheatDownAlwnceMinus"	name="rollheatDownAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차 - 상좌</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstUpleftCond" 			name="firstUpleftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstUpleftAlwncePlus" 		name="firstUpleftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstUpleftAlwnceMinus"		name="firstUpleftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차 - 하좌</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstDownleftCond" 			name="firstDownleftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstDownleftAlwncePlus" 	name="firstDownleftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstDownleftAlwnceMinus"	name="firstDownleftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차 - 상우</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstUprightCond" 			name="firstUprightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstUprightAlwncePlus" 	name="firstUprightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstUprightAlwnceMinus"	name="firstUprightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차 - 하우</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstDownrightCond" 		name="firstDownrightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstDownrightAlwncePlus" 	name="firstDownrightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstDownrightAlwnceMinus"	name="firstDownrightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차-푸셔-상</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturPush1UpCond" 				name="push1UpCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturPush1UpAlwncePlus" 			name="push1UpAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturPush1UpAlwnceMinus"			name="push1UpAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차-푸셔-하</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturPush1DownCond" 				name="push1DownCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturPush1DownAlwncePlus" 		name="push1DownAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturPush1DownAlwnceMinus"		name="push1DownAlwnceMinus"></td>
								</tr>
								<tr>
									<th>2차 - 상좌</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondUpleftCond" 			name="secondUpleftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondUpleftAlwncePlus" 	name="secondUpleftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondUpleftAlwnceMinus"	name="secondUpleftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>2차 - 하좌</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondDownleftCond" 		name="secondDownleftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondDownleftAlwncePlus" 	name="secondDownleftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondDownleftAlwnceMinus"	name="secondDownleftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>2차 - 상우</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondUprightCond" 			name="secondUprightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondUprightAlwncePlus" 	name="secondUprightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondUprightAlwnceMinus"	name="secondUprightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>2차 - 하우</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondDownrightCond" 		name="secondDownrightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondDownrightAlwncePlus" 	name="secondDownrightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondDownrightAlwnceMinus"	name="secondDownrightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>3차 - 상좌</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdUpleftCond" 			name="thirdUpleftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdUpleftAlwncePlus" 		name="thirdUpleftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdUpleftAlwnceMinus"		name="thirdUpleftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>3차 - 하좌</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdDownleftCond" 			name="thirdDownleftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdDownleftAlwncePlus" 	name="thirdDownleftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdDownleftAlwnceMinus"	name="thirdDownleftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>3차 - 상우</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdUprightCond" 			name="thirdUprightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdUprightAlwncePlus" 	name="thirdUprightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdUprightAlwnceMinus"	name="thirdUprightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>3차 - 하우</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdDownrightCond" 		name="thirdDownrightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdDownrightAlwncePlus" 	name="thirdDownrightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThirdDownrightAlwnceMinus"	name="thirdDownrightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차진접  - 상</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop1UpCond" 			name="jinjeop1UpCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop1UpAlwncePlus" 		name="jinjeop1UpAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop1UpAlwnceMinus"		name="jinjeop1UpAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차진접 - 하</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop1DownCond" 			name="jinjeop1DownCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop1DownAlwncePlus" 	name="jinjeop1DownAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop1DownAlwnceMinus"	name="jinjeop1DownAlwnceMinus"></td>
								</tr>
								<tr>
									<th>2차진접  - 상</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop2UpCond" 			name="jinjeop2UpCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop2UpAlwncePlus" 		name="jinjeop2UpAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop2UpAlwnceMinus"		name="jinjeop2UpAlwnceMinus"></td>
								</tr>
								<tr>
									<th>2차진접 - 하</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop2DownCond" 			name="jinjeop2DownCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop2DownAlwncePlus" 	name="jinjeop2DownAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeop2DownAlwnceMinus"	name="jinjeop2DownAlwnceMinus"></td>
								</tr>
								<!-- 
								<tr>
								<tr>
									<th>가접1	</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitupCond" 			name="fitupCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitupAlwncePlus" 	name="fitupAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitupAlwnceMinus" 	name="fitupAlwnceMinus"></td>
								</tr>
								<tr>
									<th>가접2	</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2Cond" 		name="fitup2Cond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2AlwncePlus" 	name="fitup2AlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFitup2AlwnceMinus" 	name="fitup2AlwnceMinus"></td>
								</tr>
								<tr>
									<th>롤히터</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="rollheatCond" 				name="rollheatCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="rollheatAlwncePlus" 		name="rollheatAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="rollheatAlwnceMinus" 		name="rollheatAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차	</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstCond" 			name="firstCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstAlwncePlus" 	name="firstAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFirstAlwnceMinus" 	name="firstAlwnceMinus"></td>
								</tr>
								<tr>
									<th>2차	</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondCond" 		name="secondCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondAlwncePlus" 	name="secondAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturSecondAlwnceMinus"	name="secondAlwnceMinus"></td>
								</tr>
								<tr>
								<th>3차	</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="thirdCond" 					name="thirdCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="thirdAlwncePlus" 			name="thirdAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="thirdAlwnceMinus"			name="thirdAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차진접	</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeopCond" 		name="jinjeopCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeopAlwncePlus" 	name="jinjeopAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturJinjeopAlwnceMinus"	name="jinjeopAlwnceMinus"></td>
								</tr>
								<tr>
									<th>2차진접	</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="jinjeop2Cond"				name="jinjeop2Cond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="jinjeop2AlwncePlus" 		name="jinjeop2AlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="jinjeop2AlwnceMinus"		name="jinjeop2AlwnceMinus"></td>
								</tr> -->
								<!-- 
								<tr>
									<th>리폼	</th>
									<td><input maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturReformCond" 		name="reformCond"></td>
									<td><input maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturReformAlwncePlus" 	name="reformAlwncePlus"></td>
									<td><input maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturReformAlwnceMinus" 	name="reformAlwnceMinus"></td>
								</tr>
								 -->
								<tr>
									<th>*사용여부	</th>
									<td><select id="tempaturUseYnCd" name="useYnCd" class="custom-select" style="max-width:100%;"></select></td>
									<td colspan="2"></td>
								</tr>
							</table>
							<button type="button" class="btn btn-primary float-right mr-1" id="tempaturBtnSave" disabled>저장</button>
		                </form>
		           	</div>
	            	<!-- 온도 끝 -->
	            	<!-- 시간 시작 -->
		            <div id="timeFormBox" class="d-none">
		                <form id="timeForm">
		                <!-- 시간 입력  & 수정 폼 -->
		                <div class="card-body col-sm-12">
			                <button type="button" class="btn btn-primary float-right mr-1" id="timeBtnEdit" disabled>수정</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="timeBtnAdd">등록</button>
						</div>	
							<table class="table table-bordered">
								<colgroup>
									<col width="22%">
									<col width="26%">
									<col width="26%">
									<col width="26%">
								</colgroup>
								<tr>
									<th>시간 코드</th>
									<td><input type="text" class="form-control" id="timeTimeCondCd" name="timeCondCd" style="max-width:100%;" disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*시간 명칭</th>
									<td colspan="4"><input type="text" class="form-control" id="timeTimeCondNm" name="timeCondNm" style="max-width:100%;" maxlength="50"></td>
								</tr>
								<tr>
									<th>구분	</th>
		                            <th>*조건	</th>
		                            <th>*공차(+)</th>
		                            <th>*공차(-)</th>
								</tr>
								<!-- 
								<tr>
									<th>예열	</th>
									<td><input maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeWarmupCond" 		name="warmupCond"></td>
									<td><input maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeWarmupAlwncePlus" 	name="warmupAlwncePlus"></td>
									<td><input maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeWarmupAlwnceMinus" 	name="warmupAlwnceMinus"></td>
								</tr>    
								 -->                                                                                   
								<tr>                                                                                        
								<tr>                                                                                        
									<th>가접1</th>                                                                       
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFitupCond" 			name="fitupCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFitupAlwncePlus" 	name="fitupAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFitupAlwnceMinus" 	name="fitupAlwnceMinus"></td>
								</tr>
								<tr>                                                                                        
									<th>가접2</th>                                                                       
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFitup2Cond" 		name="fitup2Cond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFitup2AlwncePlus" 	name="fitup2AlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFitup2AlwnceMinus" 	name="fitup2AlwnceMinus"></td>
								</tr>
								<tr>                                                                                        
									<th>1차	</th>                                                                           
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFirstCond" 			name="firstCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFirstAlwncePlus" 	name="firstAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeFirstAlwnceMinus" 	name="firstAlwnceMinus"></td>
								</tr>
								<tr>
									<th>1차 푸셔</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timePush1Cond" 			name="push1Cond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timePush1AlwncePlus" 	name="push1AlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timePush1AlwnceMinus"	name="push1AlwnceMinus"></td>
								</tr>                                                                                       
								<tr>                                                                                        
									<th>2차	</th>                                                                           
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeSecondCond" 		name="secondCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeSecondAlwncePlus" 	name="secondAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeSecondAlwnceMinus" 	name="secondAlwnceMinus"></td>
								</tr>
								<tr>                                                                                        
									<th>3차	</th>                                                                           												
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeThirdCond" 			name="thirdCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeThirdAlwncePlus" 	name="thirdAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeThirdAlwnceMinus" 	name="thirdAlwnceMinus"></td>
								</tr>
								<tr>                                                                                        
									<th>1차 진접</th>                                                                       
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeJinjeopCond" 		name="jinjeopCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeJinjeopAlwncePlus" 	name="jinjeopAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeJinjeopAlwnceMinus"	name="jinjeopAlwnceMinus"></td>
								</tr>
								<tr>                                                                                        
									<th>2차 진접</th>                                                                       
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeJinjeop2Cond" 		name="jinjeop2Cond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeJinjeop2AlwncePlus" name="jinjeop2AlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeJinjeop2AlwnceMinus"name="jinjeop2AlwnceMinus"></td>
								</tr>
								<tr>                                                                                        
									<th>리폼	</th>                                                                       
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeReformCond" 		name="reformCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeReformAlwncePlus" 	name="reformAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="timeReformAlwnceMinus" 	name="reformAlwnceMinus"></td>
								</tr>
								<tr>                                                                                        
									<th>냉각	</th>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="timeCoolCond" 			name="coolCond"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="timeCoolAlwncePlus" 	name="coolAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="timeCoolAlwnceMinus" 	name="coolAlwnceMinus"></td>
								</tr>
								<tr>
								<tr>
									<th>*사용여부	</th>
									<td><select id="timeUseYnCd" name="useYnCd" class="custom-select" style="max-width:100%;"></select></td>
									<td colspan="2"></td>
								</tr>
							</table>
							<button type="button" class="btn btn-primary float-right mr-1" id="timeBtnSave">저장</button>
		                </form>
					</div>
	            	<!-- 시간 끝 -->
	            	<!-- 압력 시작 -->
		            <div id="pressureFormBox" class="d-none">
		                <form id="pressureForm">
		                <!-- 압력코드 입력  & 수정 폼 -->
		                <div class="card-body col-sm-12">
			                <button type="button" class="btn btn-primary float-right mr-1" id="pressureBtnEdit" disabled>수정</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="pressureBtnAdd">등록</button>
						</div>
							<table class="table table-bordered">
								<colgroup>
									<col width="22%">
									<col width="26%">
									<col width="26%">
									<col width="26%">
								</colgroup>
								<tr>
									<th>압력 코드</th>
									<td><input type="text" class="form-control" id="pressurePressureCondCd" name="pressureCondCd" style="max-width:100%;" disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*압력 명칭</th><td colspan="4">
									<input type="text" maxlength="50" class="form-control" id="pressurePressureCondNm" name="pressureCondNm" style="max-width:100%;"></td>
								</tr>
								<tr>
									<th>구분	</th>
		                            <th>*조건	</th>
		                            <th>*공차(+)</th>
		                            <th>*공차(-)</th>
								</tr>
								<!-- 
								<tr>
									<th>예열	</th>
									<td><input maxlength="7" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="pressureWarmupCond" 		name="warmupCond"></td>
									<td><input maxlength="7" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="pressureWarmupAlwncePlus" 	name="warmupAlwncePlus"></td>
									<td><input maxlength="7" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="pressureWarmupAlwnceMinus" 	name="warmupAlwnceMinus"></td>
								</tr>    
								  -->                                                                                  
								<tr>                                                                                        
								<tr>                                                                                        
									<th>가접	</th>                                                                       
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureFitupCond" 			name="fitupCond"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureFitupAlwncePlus" 	name="fitupAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureFitupAlwnceMinus" 	name="fitupAlwnceMinus"></td>
								</tr>
								<!--                                                                                      
								<tr>                                                                                        
									<th>1차	</th>                                                                           
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureFirstCond" 			name="firstCond"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureFirstAlwncePlus" 	name="firstAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureFirstAlwnceMinus" 	name="firstAlwnceMinus"></td>
								</tr>
								 -->                                                                         
								<tr>
									<th>1차푸셔	</th>                                                                           
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressurePush1Cond" 		name="push1Cond"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressurePush1AlwncePlus" 	name="push1AlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressurePush1AlwnceMinus" 	name="push1AlwnceMinus"></td>
								</tr>
								<!--\
								<tr>                                                                                        
									<th>2차	</th>                                                                           
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureSecondCond" 		name="secondCond"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureSecondAlwncePlus" 	name="secondAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureSecondAlwnceMinus" name="secondAlwnceMinus"></td>
								</tr>     
								 -->                                                                                  
								<tr>                                                                                        
									<th>1차 진접</th>                                                                       
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureJinjeopCond" 		name="jinjeopCond"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureJinjeopAlwncePlus" name="jinjeopAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureJinjeopAlwnceMinus"name="jinjeopAlwnceMinus"></td>
								</tr>
								<tr>                                                                                        
									<th>2차 진접</th>                                                                       
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureJinjeop2Cond" 		name="jinjeop2Cond"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureJinjeop2AlwncePlus"name="jinjeop2AlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="7" min="-1000" max="1000" type="number" step="0.01" class="form-control number-float2" id="pressureJinjeop2AlwnceMinus"name="jinjeop2AlwnceMinus"></td>
								</tr>
								<!--                                                                                    
								<tr>                                                                                        
									<th>리폼	</th>                                                                       
									<td><input maxlength="7" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="pressureReformCond" 		name="reformCond"></td>
									<td><input maxlength="7" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="pressureReformAlwncePlus" 	name="reformAlwncePlus"></td>
									<td><input maxlength="7" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="pressureReformAlwnceMinus" 	name="reformAlwnceMinus"></td>
								</tr>
								 -->
								<tr>
									<th>*사용여부	</th>
									<td><select id="pressureUseYnCd" name="useYnCd" class="custom-select" style="max-width:100%;"></select></td>
									<td colspan="2"></td>
								</tr>
							</table>
							<button type="button" class="btn btn-primary float-right mr-1" id="pressureBtnSave">저장</button>
		                </form>
					</div>
	            	<!-- 압력 끝 -->
	            	<!-- 치수 시작 -->
		            <div id="sizeFormBox" class="d-none" style=overflow:auto;>
		                <form id="sizeForm">
		                <div class="card-body col-sm-12">		                
			                <button type="button" class="btn btn-primary float-right mr-1" id="sizeBtnEdit" disabled>수정</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="sizeBtnAdd">등록</button>
						</div>
							<table class="table table-bordered">
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<tr>
									<th>치수 코드	</th>
									<td><input type="text" maxlength="10" class="form-control" id="sizeSizeCondCd" name="sizeCondCd" style="max-width:100%;"  disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*치수 명칭	</th>
									<td colspan="4"><input type="text" class="form-control" id="sizeSizeCondNm" name="sizeCondNm" style="max-width:100%;" maxlength="50"></td>
								</tr>
								<tr>
									<th colspan="5">연동 치수 항목</th>									
								</tr>
								<tr>
									<th>SK on</th>
									<th>LGES</th>
		                            <th>*조건	</th>
		                            <th>*공차(+)</th>
		                            <th>*공차(-)</th>
								</tr>
								<tr>
									<th>Metal 폭</th>
									<th>d</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeMetalDepthCond" name="metalDepthCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeMetalDepthAlwncePlus" name="metalDepthAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeMetalDepthAlwnceMinus" name="metalDepthAlwnceMinus"></td>									
								</tr>
								<tr>
								<tr>
									<th>Metal 총길이</th>
									<th>L</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePitchLeftCond" name="pitchLeftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePitchLeftAlwncePlus" name="pitchLeftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePitchLeftAlwnceMinus" name="pitchLeftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Film 폭 (좌)</th>
									<th>l1</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthLeftCond" name="ppfDepthLeftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthLeftAlwncePlus" name="ppfDepthLeftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthLeftAlwnceMinus" name="ppfDepthLeftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Film 폭 (중)</th>
									<th>l2</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthCenterCond" name="ppfDepthCenterCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthCenterAlwncePlus" name="ppfDepthCenterAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthCenterAlwnceMinus" name="ppfDepthCenterAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Film 폭 (우)</th>
									<th>l3</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthRightCond" name="ppfDepthRightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthRightAlwncePlus" name="ppfDepthRightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfDepthRightAlwnceMinus" name="ppfDepthRightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Film 총길이</th>
									<th>W</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeFilmCond" name="filmCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeFilmAlwncePlus" name="filmAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeFilmAlwnceMinus" name="filmAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Welding Part(좌)</th>
									<th>S1</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpLeftCond" name="wpLeftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpLeftAlwncePlus" name="wpLeftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpLeftAlwnceMinus" name="wpLeftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Welding Part(중)</th>
									<th>S2</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpCenterCond" name="wpCenterCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpCenterAlwncePlus" name="wpCenterAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpCenterAlwnceMinus" name="wpCenterAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Welding Part(우)</th>
									<th>S3</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpRightCond" name="wpRightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpRightAlwncePlus" name="wpRightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpRightAlwnceMinus" name="wpRightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Welding Part 좌/우 편차</th>
									<th>S1 - S3</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpDeviationCond" name="wpDeviationCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpDeviationAlwncePlus" name="wpDeviationAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeWpDeviationAlwnceMinus" name="wpDeviationAlwnceMinus"></td>
								</tr>
								<tr>
									<th>대각선 길이 편차(X1 - X2)</th>
									<th>X1 - X2</th>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeX1X2Cond" name="x1X2Cond"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeX1X2AlwncePlus" name="x1X2AlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeX1X2AlwnceMinus" name="x1X2AlwnceMinus"></td>
								</tr>
								<tr>
									<th>날개 Margin (좌)</th>
									<th>M1</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfWingLeftCond" name="ppfWingLeftCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfWingLeftAlwncePlus" name="ppfWingLeftAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfWingLeftAlwnceMinus" name="ppfWingLeftAlwnceMinus"></td>
								</tr>
								<tr>
									<th>날개 Margin (우)</th>
									<th>M2</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfWingRightCond" name="ppfWingRightCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfWingRightAlwncePlus" name="ppfWingRightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizePpfWingRightAlwnceMinus" name="ppfWingRightAlwnceMinus"></td>
								</tr>								
								<tr>
									<th>*사용여부	</th>
									<th>LGES</th>
									<td><select id="sizeUseYnCd" name="useYnCd" class="custom-select" style="max-width:100%;"></select></td>
									<td colspan="2"></td>
								</tr>
							</table>
							<button type="button" class="btn btn-primary float-right mr-1" id="sizeBtnSave">저장</button>
		                </form>
		           	</div>
	            	<!-- 치수 끝 -->
				</div>
			</div>
			<div class="right-list left-40" id="" style="width:37%;">
				<div id="sizeFormBox2" class="d-none" style=overflow:auto;>
		                <form id="sizeForm2">		            
		                <div class="card-body col-sm-12">		                
			                
						</div>   
						<div class="card-body col-sm-12">		                
			                
						</div>   
						
						  
							<table class="table table-bordered">
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>		
								<tr>
									<th>치수 코드	</th>
									<td><input type="text" maxlength="10" class="form-control" id="sizeSizeCondCd2" name="sizeCondCd2" style="max-width:100%;"  disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*치수 명칭	</th>
									<td colspan="4"><input type="text" class="form-control" id="sizeSizeCondNm2" name="sizeCondNm2" style="max-width:100%;" maxlength="50" disabled></td>
								</tr>
								<tr>
									<th colspan="5" >Manual 측정 치수 항목</th>									
								</tr>						
								<tr>
									<th>SK on</th>
									<th>LGES</th>
		                            <th>*조건	</th>
		                            <th>*공차(+)</th>
		                            <th>*공차(-)</th>
								</tr>
								<tr>
									<th>METAL 두께</th>
									<th>t</th>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeMetalThicknessCond" name="metalThicknessCond"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeMetalThicknessAlwncePlus" name="metalThicknessAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeMetalThicknessAlwnceMinus" name="metalThicknessAlwnceMinus"></td>
								</tr>
								<tr>
								<tr>
									<th>총 두께 (Edge 좌)</th>
									<th>T1</th>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThEdgeCond" name="thEdgeCond"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThEdgeAlwncePlus" name="thEdgeAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThEdgeAlwnceMinus" name="thEdgeAlwnceMinus"></td>
								</tr>
								<tr>
									<th>총 두께 (Center)</th>
									<th>T2</th>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThCenterCond" name="thCenterCond"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThCenterAlwncePlus" name="thCenterAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThCenterAlwnceMinus" name="thCenterAlwnceMinus"></td>
								</tr>
								<tr>
									<th>총 두께 (Edge 우)</th>
									<th>T3</th>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThEdgeRightCond" name="thEdgeRightCond"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThEdgeRightAlwncePlus" name="thEdgeRightAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeThEdgeRightAlwnceMinus" name="thEdgeRightAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Metal Burr</th>
									<th>Burr</th>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeBurrCond" name="burrCond"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeBurrAlwncePlus" name="burrAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeBurrAlwnceMinus" name="burrAlwnceMinus"></td>
								</tr>
								<tr>
									<th>Layer</th>
									<th>g</th>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeGapOfLayerCond" name="gapOfLayerCond"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeGapOfLayerPlus" name="gapOfLayerPlus"></td>
									<td><input style="max-width:100%;" maxlength="8" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeGapOfLayerMinus" name="gapOfLayerMinus"></td>
								</tr>
								<tr>
									<th>Bending</th>
									<th>b</th>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeBendingCond" name="bendingCond"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeBendingAlwncePlus" name="bendingAlwncePlus"></td>
									<td><input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.001" class="form-control number-float3" id="sizeBendingAlwnceMinus" name="bendingAlwnceMinus"></td>
								</tr>								
							</table>							
		                </form>
		           	</div>
			</div>
		</div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'bmsc3040';
	let currentHref = 'bmsc3040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "기초제조조건관리");
	
	let bomList = $('#bomList').DataTable({
		language: lang_kor,
	    paging: true,
	    info: true,
	    ordering: true,
	    processing: true,
	    autoWidth: false,
	    lengthChange: false,
	    pageLength: 20,
	    searching: false,
	});
	
	let factoryCode = "<%=factoryCode%>";
		
	var html = '<select id="bom" ></select>';
	$('#bomList_length').html(html);

    let sideView = 'add';
    var baseCd = "";
    var rowIdx = "";
    var condCd = "";
    var condNm = "";

	//공통코드 처리 시작
	var bom = new Array(); //BOM 목록 정보
    <c:forEach items="${bom}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		bom.push(json);
    </c:forEach>
    selectBoxAppend(bom, "bom", "", "2");
    var useYnCd = new Array(); //사용 목록 정보
    <c:forEach items="${useYnCd}" var="info">
    	var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		useYnCd.push(json);
	</c:forEach>
    //공통코드 처리 종료
    
    if( factoryCode != "003" ) {
    	$('#golHiddenYn').removeClass('d-none');    	
    }
    
    // 온도 등록 클리 시
    $('#tempaturBtnAdd').on('click', function() {
        sideView = 'add';
        $('.form-control').val("");
        //resetForm();	//숫자입력칸 0으로 초기화
        //선택박스처리
        selectBoxAppend(useYnCd, "tempaturUseYnCd", "001", "2");
		$('#tempaturFormBox').removeClass('d-none');
        $('#tempaturBtnEdit').attr('disabled', true);
        $('#tempaturBtnSave').removeClass('d-none');
        $('#tempaturBtnSave').attr('disabled', false);
        tempaturForm(false);
		$('.number-float1, .number-float2, .number-float3').val("0");
    });
    
    // 온도 수정 클릭 시
    $('#tempaturBtnEdit').on('click', function() {
    	sideView = 'edit';	//클릭 시 edit 줘서 클릭 했는지 안했는지 판단
    	if(sideView != 'edit') {
		toastr.warning("수정할 온도를 선택해 주세요!");
			return false;
		}
		$('#tempaturFormBox').removeClass('d-none');
		$("#tempaturBtnSave").attr("disabled",false);
		$('#tempaturBtnSave').removeClass('d-none');
		tempaturForm(false);

		$('.number-float1, .number-float2, .number-float3').each(function(index, value) {
			if ( $(this).val() == "" ){
				$(this).val("0");
			}
		});
		
	});
    
	// 시간 등록 클리 시
    $('#timeBtnAdd').on('click', function() {
        sideView = 'add';
        $('.form-control').val("");
        //선택박스처리
        selectBoxAppend(useYnCd, "timeUseYnCd", "001", "2");
		$('#timeFormBox').removeClass('d-none');
        $('#timeBtnEdit').attr('disabled', true);
        $('#timeBtnSave').removeClass('d-none');
        timeForm(false);
        $('#timeBtnSave').attr('disabled', false);
        $('.number-float1, .number-float2, .number-float3').val("0");
    });
    // 시간 수정 클릭 시
    $('#timeBtnEdit').on('click', function() {
    	sideView = 'edit';	//클릭 시 edit 줘서 클릭 했는지 안했는지 판단
    	if(sideView != 'edit') {
		toastr.warning("수정할 시간을 선택해 주세요!");
			return false;
		}
		$('#timeFormBox').removeClass('d-none');
		$('#timeBtnSave').attr('disabled', false);
		$('#timeBtnSave').removeClass('d-none');
		timeForm(false);

		$('.number-float1, .number-float2, .number-float3').each(function(index, value) {
			if ( $(this).val() == "" ){
				$(this).val("0");
			}
		});
	});

	// 압력 등록 클리 시
    $('#pressureBtnAdd').on('click', function() {
        sideView = 'add';
        $('.form-control').val("");
        //선택박스처리
        selectBoxAppend(useYnCd, "pressureUseYnCd", "001", "2");
		$('#pressureFormBox').removeClass('d-none');
        $('#pressureBtnEdit').attr('disabled', true);
        $('#pressureBtnSave').removeClass('d-none');
        pressureForm(false);
        $('#pressureBtnSave').attr('disabled', false);
        $('.number-float1, .number-float2, .number-float3').val("0");
    });
    
    // 압력 수정 클릭 시
    $('#pressureBtnEdit').on('click', function() {
    	sideView = 'edit';	//클릭 시 edit 줘서 클릭 했는지 안했는지 판단
    	if(sideView != 'edit') {
		toastr.warning("수정할 압력을 선택해 주세요!");
			return false;
		}
        $('#pressureBtnSave').attr('disabled', false);
        $('#pressureBtnSave').removeClass('d-none');
        pressureForm(false);

		$('.number-float1, .number-float2, .number-float3').each(function(index, value) {
			if ( $(this).val() == "" ){
				$(this).val("0");
			}
		});
	});
	
	// 치수 등록 클리 시
    $('#sizeBtnAdd').on('click', function() {
        sideView = 'add';
        $('.form-control').val("");
        //선택박스처리
        selectBoxAppend(useYnCd, "sizeUseYnCd", "001", "2");
		$('#sizeFormBox').removeClass('d-none');
		$('#sizeFormBox2').removeClass('d-none');
        $('#sizeBtnEdit').attr('disabled', true);
        $('#sizeBtnSave').removeClass('d-none');
        
        $('#sizeForm').find('input').attr('disabled',false);
        $('#sizeForm2').find('input').attr('disabled',false);
        $('#sizeSizeCondCd').attr('disabled',true);
        sizeForm(false);
        $('#sizeBtnSave').attr('disabled', false);
        $('#sizeSizeCondCd2').attr('disabled',true);
	    $('#sizeSizeCondNm2').attr('disabled',true);
    });
    
    // 치수 수정 클릭 시
    $('#sizeBtnEdit').on('click', function() {
    	sideView = 'edit';	//클릭 시 edit 줘서 클릭 했는지 안했는지 판단
    	if(sideView != 'edit') {
		toastr.warning("수정할 압력을 선택해 주세요!");
			return false;
		}
		$('#sizeFormBox').removeClass('d-none');
		$('#sizeFormBox2').removeClass('d-none');
		$('#sizeBtnSave').attr('disabled', false);
		$('#sizeBtnSave').removeClass('d-none');
		
		$('#sizeForm').find('input').attr('disabled',false);
	    $('#sizeForm2').find('input').attr('disabled',false);
	    $('#sizeSizeCondCd2').attr('disabled',true);
	    $('#sizeSizeCondNm2').attr('disabled',true);
	    $('#sizeSizeCondCd').attr('disabled',true);
	    sizeForm(false);
		$('.number-float1, .number-float2, .number-float3').each(function(index, value) {
			if ( $(this).val() == "" ){
				$(this).val("0");
			}
		});
	});

    var baseNm = null;
	//bom select box 변경감지
	$('#bom').change(function(){
		baseCd = $("#bom option:selected").val();
		var url = "";
		$('.form-control').val("");
		if (baseCd == "001"){
			url = "bm/tempaturDataList"
			rowIdx = "tempaturCondCd";
			condCd = "tempaturCondCd";
			condNm = "tempaturCondNm";
			$('#tempaturFormBox').removeClass('d-none');
			$('#timeFormBox').addClass('d-none');
			$('#pressureFormBox').addClass('d-none');
			$('#sizeFormBox').addClass('d-none');
			$('#sizeFormBox2').addClass('d-none');
			$('#tempaturBtnSave').attr('disabled', true);
			$('#tempaturBtnSave').addClass('d-none');  // 저장버튼
			tempaturForm(true);
			baseNm = "BOM 온도 정보";
		}
		else if(baseCd == "002") {
			url = "bm/timeDataList"
			rowIdx = "timeCondCd";
			condCd = "timeCondCd";
			condNm = "timeCondNm";
			$('#tempaturFormBox').addClass('d-none');
			$('#timeFormBox').removeClass('d-none');
			$('#pressureFormBox').addClass('d-none');
			$('#sizeFormBox').addClass('d-none');
			$('#sizeFormBox2').addClass('d-none');
			$('#timeBtnSave').attr('disabled', true);
			$('#timeBtnSave').addClass('d-none');  // 저장버튼
			timeForm(true);
			baseNm = "BOM 시간 정보";
		}
		else if(baseCd == "003") {
			url = "bm/pressureDataList"
			rowIdx = "pressureCondCd";
			condCd = "pressureCondCd";
			condNm = "pressureCondNm";
			$('#tempaturFormBox').addClass('d-none');
			$('#timeFormBox').addClass('d-none');
			$('#pressureFormBox').removeClass('d-none');
			$('#sizeFormBox').addClass('d-none');
			$('#sizeFormBox2').addClass('d-none');
            $('#pressureBtnSave').attr('disabled', true);
            $('#pressureBtnSave').addClass('d-none');  // 저장버튼
			pressureForm(true);
			baseNm = "BOM 압력 정보";
		}
		else if(baseCd == "004") {
			url = "bm/sizeDataList"
			rowIdx = "sizeCondCd";
			condCd = "sizeCondCd";
			condNm = "sizeCondNm";
			$('#tempaturFormBox').addClass('d-none');
			$('#timeFormBox').addClass('d-none');
			$('#pressureFormBox').addClass('d-none');
			$('#sizeFormBox').removeClass('d-none');
			$('#sizeFormBox2').removeClass('d-none');
            $('#sizeBtnSave').attr('disabled', true);
            $('#sizeBtnSave').addClass('d-none');  // 저장버튼
			sizeForm(true);
			baseNm = "BOM 치수 정보";
		}
		else {
			toastr.warning("다시 선택해 주세요.");
			$('#bom').focus();
			return false;
		}
		
		// 목록
		$.fn.dataTable.ext.errMode = 'none';
		let bomListTable = $('#bomList').on( 'error.dt', function ( e, settings, techNote, message ) {
		    	if(techNote == 7) {
			    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			       	location.href = "/";
				}
			} ).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			language: lang_kor,
	        paging: true,
	        info: true,
	        ordering: true,
	        processing: true,
	        autoWidth: false,
	        lengthChange: false,
	        pageLength: 20,
	        searching: false,
			destroy: true,
			ajax: {
			    url: url,
			    type: 'GET',
			    data: {
			    	'menuAuth'	:	menuAuth,
			    	'useYnCd'	: 	'Y'
			    },
			},
			rowId: rowIdx,
			columns: [
				{ data: condNm },
				{ data: condCd },
			],
			order: [
				[ 1, 'asc' ],
			],
	        buttons: [
	            {
	                extend: 'copy',
	                title: baseNm,
	            },
	            {
	                extend: 'excel',
	                title: baseNm,
	            },
	            {
	                extend: 'print',
	                title: baseNm,
	            }
	        ],
	    })
	});
	
    $('#bomList tbody').on('click', 'tr', function () {

        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#bomList').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            
			sideView = 'view';
			let val = new Array();
	        for(i=0; i < 2; i++){
	        	val[i] = $(this).closest('tr').find('td:eq(' + i + ')').text();
	        }
	        
	        //온도 Read
			if (baseCd == "001"){
				$('#tempaturBtnSave').addClass('d-none');  // 저장버튼
		        $.ajax({
		        	url: '<c:url value="bm/tempaturView"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	:	menuAuth,
						'tempaturCondCd' : val[1],	
		            },
		            success: function (res) {
		                let data = res.data;
		                $('#tempaturForm input[name="tempaturCondCd"]').val(data.tempaturCondCd);
		                $('#tempaturForm input[name="tempaturCondNm"]').val(data.tempaturCondNm);
						$('#tempaturForm input[name="warmupCond"]').val(data.warmupCond);
						$('#tempaturForm input[name="warmupAlwncePlus"]').val(data.warmupAlwncePlus);
						$('#tempaturForm input[name="warmupAlwnceMinus"]').val(data.warmupAlwnceMinus);
						$('#tempaturForm input[name="fitup1UpCond"]').val(data.fitup1UpCond);
						$('#tempaturForm input[name="fitup1UpAlwncePlus"]').val(data.fitup1UpAlwncePlus);
						$('#tempaturForm input[name="fitup1UpAlwnceMinus"]').val(data.fitup1UpAlwnceMinus);
						$('#tempaturForm input[name="fitup1DownCond"]').val(data.fitup1DownCond);
						$('#tempaturForm input[name="fitup1DownAlwncePlus"]').val(data.fitup1DownAlwncePlus);
						$('#tempaturForm input[name="fitup1DownAlwnceMinus"]').val(data.fitup1DownAlwnceMinus);
						$('#tempaturForm input[name="fitup2UpleftCond"]').val(data.fitup2UpleftCond);
						$('#tempaturForm input[name="fitup2UpleftAlwncePlus"]').val(data.fitup2UpleftAlwncePlus);
						$('#tempaturForm input[name="fitup2UpleftAlwnceMinus"]').val(data.fitup2UpleftAlwnceMinus);
						$('#tempaturForm input[name="fitup2DownleftCond"]').val(data.fitup2DownleftCond);
						$('#tempaturForm input[name="fitup2DownleftAlwncePlus"]').val(data.fitup2DownleftAlwncePlus);
						$('#tempaturForm input[name="fitup2DownleftAlwnceMinus"]').val(data.fitup2DownleftAlwnceMinus);
						$('#tempaturForm input[name="fitup2UprightCond"]').val(data.fitup2UprightCond);
						$('#tempaturForm input[name="fitup2UprightAlwncePlus"]').val(data.fitup2UprightAlwncePlus);
						$('#tempaturForm input[name="fitup2UprightAlwnceMinus"]').val(data.fitup2UprightAlwnceMinus);
						$('#tempaturForm input[name="fitup2DownrightCond"]').val(data.fitup2DownrightCond);
						$('#tempaturForm input[name="fitup2DownrightAlwncePlus"]').val(data.fitup2DownrightAlwncePlus);
						$('#tempaturForm input[name="fitup2DownrightAlwnceMinus"]').val(data.fitup2DownrightAlwnceMinus);
						$('#tempaturForm input[name="rollheatUpCond"]').val(data.rollheatUpCond);
						$('#tempaturForm input[name="rollheatUpAlwncePlus"]').val(data.rollheatUpAlwncePlus);
						$('#tempaturForm input[name="rollheatUpAlwnceMinus"]').val(data.rollheatUpAlwnceMinus);
						$('#tempaturForm input[name="rollheatDownCond"]').val(data.rollheatDownCond);
						$('#tempaturForm input[name="rollheatDownAlwncePlus"]').val(data.rollheatDownAlwncePlus);
						$('#tempaturForm input[name="rollheatDownAlwnceMinus"]').val(data.rollheatDownAlwnceMinus);
						$('#tempaturForm input[name="firstUpleftCond"]').val(data.firstUpleftCond);
						$('#tempaturForm input[name="firstUpleftAlwncePlus"]').val(data.firstUpleftAlwncePlus);
						$('#tempaturForm input[name="firstUpleftAlwnceMinus"]').val(data.firstUpleftAlwnceMinus);
						$('#tempaturForm input[name="firstDownleftCond"]').val(data.firstDownleftCond);
						$('#tempaturForm input[name="firstDownleftAlwncePlus"]').val(data.firstDownleftAlwncePlus);
						$('#tempaturForm input[name="firstDownleftAlwnceMinus"]').val(data.firstDownleftAlwnceMinus);
						$('#tempaturForm input[name="firstUprightCond"]').val(data.firstUprightCond);
						$('#tempaturForm input[name="firstUprightAlwncePlus"]').val(data.firstUprightAlwncePlus);
						$('#tempaturForm input[name="firstUprightAlwnceMinus"]').val(data.firstUprightAlwnceMinus);
						$('#tempaturForm input[name="firstDownrightCond"]').val(data.firstDownrightCond);
						$('#tempaturForm input[name="firstDownrightAlwncePlus"]').val(data.firstDownrightAlwncePlus);
						$('#tempaturForm input[name="firstDownrightAlwnceMinus"]').val(data.firstDownrightAlwnceMinus);

						$('#tempaturForm input[name="push1UpCond"]').val(data.push1UpCond);
						$('#tempaturForm input[name="push1UpAlwncePlus"]').val(data.push1UpAlwncePlus);
						$('#tempaturForm input[name="push1UpAlwnceMinus"]').val(data.push1UpAlwnceMinus);
						$('#tempaturForm input[name="push1DownCond"]').val(data.push1DownCond);
						$('#tempaturForm input[name="push1DownAlwncePlus"]').val(data.push1DownAlwncePlus);
						$('#tempaturForm input[name="push1DownAlwnceMinus"]').val(data.push1DownAlwnceMinus);
						
						$('#tempaturForm input[name="secondUpleftCond"]').val(data.secondUpleftCond);
						$('#tempaturForm input[name="secondUpleftAlwncePlus"]').val(data.secondUpleftAlwncePlus);
						$('#tempaturForm input[name="secondUpleftAlwnceMinus"]').val(data.secondUpleftAlwnceMinus);
						$('#tempaturForm input[name="secondDownleftCond"]').val(data.secondDownleftCond);
						$('#tempaturForm input[name="secondDownleftAlwncePlus"]').val(data.secondDownleftAlwncePlus);
						$('#tempaturForm input[name="secondDownleftAlwnceMinus"]').val(data.secondDownleftAlwnceMinus);
						$('#tempaturForm input[name="secondUprightCond"]').val(data.secondUprightCond);
						$('#tempaturForm input[name="secondUprightAlwncePlus"]').val(data.secondUprightAlwncePlus);
						$('#tempaturForm input[name="secondUprightAlwnceMinus"]').val(data.secondUprightAlwnceMinus);
						$('#tempaturForm input[name="secondDownrightCond"]').val(data.secondDownrightCond);
						$('#tempaturForm input[name="secondDownrightAlwncePlus"]').val(data.secondDownrightAlwncePlus);
						$('#tempaturForm input[name="secondDownrightAlwnceMinus"]').val(data.secondDownrightAlwnceMinus);
						$('#tempaturForm input[name="thirdUpleftCond"]').val(data.thirdUpleftCond);
						$('#tempaturForm input[name="thirdUpleftAlwncePlus"]').val(data.thirdUpleftAlwncePlus);
						$('#tempaturForm input[name="thirdUpleftAlwnceMinus"]').val(data.thirdUpleftAlwnceMinus);
						$('#tempaturForm input[name="thirdDownleftCond"]').val(data.thirdDownleftCond);
						$('#tempaturForm input[name="thirdDownleftAlwncePlus"]').val(data.thirdDownleftAlwncePlus);
						$('#tempaturForm input[name="thirdDownleftAlwnceMinus"]').val(data.thirdDownleftAlwnceMinus);
						$('#tempaturForm input[name="thirdUprightCond"]').val(data.thirdUprightCond);
						$('#tempaturForm input[name="thirdUprightAlwncePlus"]').val(data.thirdUprightAlwncePlus);
						$('#tempaturForm input[name="thirdUprightAlwnceMinus"]').val(data.thirdUprightAlwnceMinus);
						$('#tempaturForm input[name="thirdDownrightCond"]').val(data.thirdDownrightCond);
						$('#tempaturForm input[name="thirdDownrightAlwncePlus"]').val(data.thirdDownrightAlwncePlus);
						$('#tempaturForm input[name="thirdDownrightAlwnceMinus"]').val(data.thirdDownrightAlwnceMinus);
						$('#tempaturForm input[name="jinjeop1UpCond"]').val(data.jinjeop1UpCond);
						$('#tempaturForm input[name="jinjeop1UpAlwncePlus"]').val(data.jinjeop1UpAlwncePlus);
						$('#tempaturForm input[name="jinjeop1UpAlwnceMinus"]').val(data.jinjeop1UpAlwnceMinus);
						$('#tempaturForm input[name="jinjeop1DownCond"]').val(data.jinjeop1DownCond);
						$('#tempaturForm input[name="jinjeop1DownAlwncePlus"]').val(data.jinjeop1DownAlwncePlus);
						$('#tempaturForm input[name="jinjeop1DownAlwnceMinus"]').val(data.jinjeop1DownAlwnceMinus);
						$('#tempaturForm input[name="jinjeop2UpCond"]').val(data.jinjeop2UpCond);
						$('#tempaturForm input[name="jinjeop2UpAlwncePlus"]').val(data.jinjeop2UpAlwncePlus);
						$('#tempaturForm input[name="jinjeop2UpAlwnceMinus"]').val(data.jinjeop2UpAlwnceMinus);
						$('#tempaturForm input[name="jinjeop2DownCond"]').val(data.jinjeop2DownCond);
						$('#tempaturForm input[name="jinjeop2DownAlwncePlus"]').val(data.jinjeop2DownAlwncePlus);
						$('#tempaturForm input[name="jinjeop2DownAlwnceMinus"]').val(data.jinjeop2DownAlwnceMinus);

						//수정 선택박스 처리
		                selectBoxAppend(useYnCd, "tempaturUseYnCd", data.useYnCd, "");
		            },
		            complete:function(){
		                $('#tempaturFormBox').removeClass('d-none');
		                $('#tempaturBtnEdit').attr('disabled', false);
		                $('#tempaturBtnSave').attr('disabled', true);
		                tempaturForm(true);
		            }
				});
			}
			
			//시간 Read
			else if(baseCd == "002") {
				$('#timeBtnSave').addClass('d-none');  // 저장버튼
		        $.ajax({
		        	url: '<c:url value="bm/timeView"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
						'timeCondCd' : val[1],	
		            },
		            success: function (res) {
		                let data = res.data;
						$('#timeForm input[name="timeCondCd"]').val(data.timeCondCd);
						$('#timeForm input[name="timeCondNm"]').val(data.timeCondNm);
						$('#timeForm input[name="warmupCond"]').val(data.warmupCond);
						$('#timeForm input[name="warmupAlwncePlus"]').val(data.warmupAlwncePlus);
						$('#timeForm input[name="warmupAlwnceMinus"]').val(data.warmupAlwnceMinus);
						$('#timeForm input[name="fitupCond"]').val(data.fitupCond);
						$('#timeForm input[name="fitupAlwncePlus"]').val(data.fitupAlwncePlus);
						$('#timeForm input[name="fitupAlwnceMinus"]').val(data.fitupAlwnceMinus);
						$('#timeForm input[name="fitup2Cond"]').val(data.fitup2Cond);
						$('#timeForm input[name="fitup2AlwncePlus"]').val(data.fitup2AlwncePlus);
						$('#timeForm input[name="fitup2AlwnceMinus"]').val(data.fitup2AlwnceMinus);
						$('#timeForm input[name="firstCond"]').val(data.firstCond);
						$('#timeForm input[name="firstAlwncePlus"]').val(data.firstAlwncePlus);
						$('#timeForm input[name="firstAlwnceMinus"]').val(data.firstAlwnceMinus);
						$('#timeForm input[name="secondCond"]').val(data.secondCond);
						$('#timeForm input[name="secondAlwncePlus"]').val(data.secondAlwncePlus);
						$('#timeForm input[name="secondAlwnceMinus"]').val(data.secondAlwnceMinus);

						$('#timeForm input[name="thirdCond"]').val(data.thirdCond);
						$('#timeForm input[name="thirdAlwncePlus"]').val(data.thirdAlwncePlus);
						$('#timeForm input[name="thirdAlwnceMinus"]').val(data.thirdAlwnceMinus);
						
						$('#timeForm input[name="jinjeopCond"]').val(data.jinjeopCond);
						$('#timeForm input[name="jinjeopAlwncePlus"]').val(data.jinjeopAlwncePlus);
						$('#timeForm input[name="jinjeopAlwnceMinus"]').val(data.jinjeopAlwnceMinus);

						$('#timeForm input[name="jinjeop2Cond"]').val(data.jinjeop2Cond);
						$('#timeForm input[name="jinjeop2AlwncePlus"]').val(data.jinjeop2AlwncePlus);
						$('#timeForm input[name="jinjeop2AlwnceMinus"]').val(data.jinjeop2AlwnceMinus);
						$('#timeForm input[name="push1Cond"]').val(data.push1Cond);
						$('#timeForm input[name="push1AlwncePlus"]').val(data.push1AlwncePlus);
						$('#timeForm input[name="push1AlwnceMinus"]').val(data.push1AlwnceMinus);
						
						$('#timeForm input[name="reformCond"]').val(data.reformCond);
						$('#timeForm input[name="reformAlwncePlus"]').val(data.reformAlwncePlus);
						$('#timeForm input[name="reformAlwnceMinus"]').val(data.reformAlwnceMinus);

						$('#timeForm input[name="coolCond"]').val(data.coolCond);
						$('#timeForm input[name="coolAlwncePlus"]').val(data.coolAlwncePlus);
						$('#timeForm input[name="coolAlwnceMinus"]').val(data.coolAlwnceMinus);
												
						//수정 선택박스 처리
		                selectBoxAppend(useYnCd, "timeUseYnCd", data.useYnCd, "");					
		            },
		            complete:function(){
		                $('#timeFormBox').removeClass('d-none');
		                $('#timeBtnEdit').attr('disabled', false);
		                $('#timeBtnSave').attr('disabled', true);
		                timeForm(true);
		            }
		        });
			}
			
			//압력
			else if(baseCd == "003") {
				$('#pressureBtnSave').addClass('d-none');  // 저장버튼
		        $.ajax({
		        	url: '<c:url value="bm/pressureView"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'		 : menuAuth,
						'pressureCondCd' : val[1],	
		            },
		            success: function (res) {
		                let data = res.data;
	
						//수정 단 
						$('#pressureForm input[name="pressureCondCd"]').val(data.pressureCondCd);
						$('#pressureForm input[name="pressureCondNm"]').val(data.pressureCondNm);
						$('#pressureForm input[name="warmupCond"]').val(data.warmupCond);
						$('#pressureForm input[name="warmupAlwncePlus"]').val(data.warmupAlwncePlus);
						$('#pressureForm input[name="warmupAlwnceMinus"]').val(data.warmupAlwnceMinus);
						$('#pressureForm input[name="fitupCond"]').val(data.fitupCond);
						$('#pressureForm input[name="fitupAlwncePlus"]').val(data.fitupAlwncePlus);
						$('#pressureForm input[name="fitupAlwnceMinus"]').val(data.fitupAlwnceMinus);
						
						//$('#pressureForm input[name="firstCond"]').val(data.firstCond);
						//$('#pressureForm input[name="firstAlwncePlus"]').val(data.firstAlwncePlus);
						//$('#pressureForm input[name="firstAlwnceMinus"]').val(data.firstAlwnceMinus);
 						$('#pressureForm input[name="push1Cond"]').val(data.push1Cond);
						$('#pressureForm input[name="push1AlwncePlus"]').val(data.push1AlwncePlus);
						$('#pressureForm input[name="push1AlwnceMinus"]').val(data.push1AlwnceMinus);
						
						$('#pressureForm input[name="secondCond"]').val(data.secondCond);
						$('#pressureForm input[name="secondAlwncePlus"]').val(data.secondAlwncePlus);
						$('#pressureForm input[name="secondAlwnceMinus"]').val(data.secondAlwnceMinus);
						$('#pressureForm input[name="jinjeopCond"]').val(data.jinjeopCond);
						$('#pressureForm input[name="jinjeopAlwncePlus"]').val(data.jinjeopAlwncePlus);
						$('#pressureForm input[name="jinjeopAlwnceMinus"]').val(data.jinjeopAlwnceMinus);

						$('#pressureForm input[name="jinjeop2Cond"]').val(data.jinjeop2Cond);
						$('#pressureForm input[name="jinjeop2AlwncePlus"]').val(data.jinjeop2AlwncePlus);
						$('#pressureForm input[name="jinjeop2AlwnceMinus"]').val(data.jinjeop2AlwnceMinus);
						
						$('#pressureForm input[name="reformCond"]').val(data.reformCond);
						$('#pressureForm input[name="reformAlwncePlus"]').val(data.reformAlwncePlus);
						$('#pressureForm input[name="reformAlwnceMinus"]').val(data.reformAlwnceMinus);
						
						//수정 선택박스 처리
		                selectBoxAppend(useYnCd, "pressureUseYnCd", data.useYnCd, "");
		            },
		            complete:function(){
		                $('#pressureFormBox').removeClass('d-none');
		                $('#pressureBtnEdit').attr('disabled', false);
		                $('#pressureBtnSave').attr('disabled', true);
		                pressureForm(true);
		            }
				});
			}
			
			//치수 read
			else if(baseCd == "004") {
				$('#sizeBtnSave').addClass('d-none');  // 저장버튼
		        $.ajax({
		        	url: '<c:url value="bm/sizeView"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
						'sizeCondCd' : val[1],	
		            },
		            success: function (res) {
		                let data = res.data;
		                					
						//수정 단 
						$('#sizeForm input[name="sizeCondCd"]').val(data.sizeCondCd);
						$('#sizeForm input[name="sizeCondNm"]').val(data.sizeCondNm);
						$('#sizeForm2 input[name="sizeCondCd2"]').val(data.sizeCondCd);
						$('#sizeForm2 input[name="sizeCondNm2"]').val(data.sizeCondNm);
						$('#sizeForm input[name="wpLeftCond"]').val(data.wpLeftCond);
						$('#sizeForm input[name="wpLeftAlwncePlus"]').val(data.wpLeftAlwncePlus);
						$('#sizeForm input[name="wpLeftAlwnceMinus"]').val(data.wpLeftAlwnceMinus);
						$('#sizeForm input[name="wpRightCond"]').val(data.wpRightCond);
						$('#sizeForm input[name="wpRightAlwncePlus"]').val(data.wpRightAlwncePlus);
						$('#sizeForm input[name="wpRightAlwnceMinus"]').val(data.wpRightAlwnceMinus);
						$('#sizeForm input[name="pitchLeftCond"]').val(data.pitchLeftCond);
						$('#sizeForm input[name="pitchLeftAlwncePlus"]').val(data.pitchLeftAlwncePlus);
						$('#sizeForm input[name="pitchLeftAlwnceMinus"]').val(data.pitchLeftAlwnceMinus);
						$('#sizeForm input[name="pitchRightCond"]').val(data.pitchRightCond);
						$('#sizeForm input[name="pitchRightAlwncePlus"]').val(data.pitchRightAlwncePlus);
						$('#sizeForm input[name="pitchRightAlwnceMinus"]').val(data.pitchRightAlwnceMinus);
						$('#sizeForm input[name="ppfWingLeftCond"]').val(data.ppfWingLeftCond);
						$('#sizeForm input[name="ppfWingLeftAlwncePlus"]').val(data.ppfWingLeftAlwncePlus);
						$('#sizeForm input[name="ppfWingLeftAlwnceMinus"]').val(data.ppfWingLeftAlwnceMinus);
						$('#sizeForm input[name="ppfWingRightCond"]').val(data.ppfWingRightCond);
						$('#sizeForm input[name="ppfWingRightAlwncePlus"]').val(data.ppfWingRightAlwncePlus);
						$('#sizeForm input[name="ppfWingRightAlwnceMinus"]').val(data.ppfWingRightAlwnceMinus);
						$('#sizeForm input[name="ppfDepthLeftCond"]').val(data.ppfDepthLeftCond);
						$('#sizeForm input[name="ppfDepthLeftAlwncePlus"]').val(data.ppfDepthLeftAlwncePlus);
						$('#sizeForm input[name="ppfDepthLeftAlwnceMinus"]').val(data.ppfDepthLeftAlwnceMinus);
						$('#sizeForm input[name="ppfDepthRightCond"]').val(data.ppfDepthRightCond);
						$('#sizeForm input[name="ppfDepthRightAlwncePlus"]').val(data.ppfDepthRightAlwncePlus);
						$('#sizeForm input[name="ppfDepthRightAlwnceMinus"]').val(data.ppfDepthRightAlwnceMinus);
						$('#sizeForm input[name="filmCond"]').val(data.filmCond);
						$('#sizeForm input[name="filmAlwncePlus"]').val(data.filmAlwncePlus);
						$('#sizeForm input[name="filmAlwnceMinus"]').val(data.filmAlwnceMinus);
						$('#sizeForm input[name="metalDepthCond"]').val(data.metalDepthCond);
						$('#sizeForm input[name="metalDepthAlwncePlus"]').val(data.metalDepthAlwncePlus);
						$('#sizeForm input[name="metalDepthAlwnceMinus"]').val(data.metalDepthAlwnceMinus);
						
						
						
						

						$('#sizeForm input[name="wpCenterCond"]').val(data.wpCenterCond);             
						$('#sizeForm input[name="wpCenterAlwncePlus"]').val(data.wpCenterAlwncePlus);       
						$('#sizeForm input[name="wpCenterAlwnceMinus"]').val(data.wpCenterAlwnceMinus);      
						$('#sizeForm input[name="ppfDepthCenterCond"]').val(data.ppfDepthCenterCond);       
						$('#sizeForm input[name="ppfDepthCenterAlwncePlus"]').val(data.ppfDepthCenterAlwncePlus); 
						$('#sizeForm input[name="ppfDepthCenterAlwnceMinus"]').val(data.ppfDepthCenterAlwnceMinus);
						$('#sizeForm input[name="wpDeviationCond"]').val(data.wpDeviationCond);          
						$('#sizeForm input[name="wpDeviationAlwncePlus"]').val(data.wpDeviationAlwncePlus);    
						$('#sizeForm input[name="wpDeviationAlwnceMinus"]').val(data.wpDeviationAlwnceMinus);   
						$('#sizeForm input[name="x1X2Cond"]').val(data.x1X2Cond);                 
						$('#sizeForm input[name="x1X2AlwncePlus"]').val(data.x1X2AlwncePlus);           
						$('#sizeForm input[name="x1X2AlwnceMinus"]').val(data.x1X2AlwnceMinus);          
						
								


						$('#sizeForm2 input[name="metalThicknessCond"]').val(data.metalThicknessCond);
						$('#sizeForm2 input[name="metalThicknessAlwncePlus"]').val(data.metalThicknessAlwncePlus);
						$('#sizeForm2 input[name="metalThicknessAlwnceMinus"]').val(data.metalThicknessAlwnceMinus);
						$('#sizeForm2 input[name="thCenterCond"]').val(data.thCenterCond);
						$('#sizeForm2 input[name="thCenterAlwncePlus"]').val(data.thCenterAlwncePlus);
						$('#sizeForm2 input[name="thCenterAlwnceMinus"]').val(data.thCenterAlwnceMinus);
						$('#sizeForm2 input[name="thEdgeCond"]').val(data.thEdgeCond);
						$('#sizeForm2 input[name="thEdgeAlwncePlus"]').val(data.thEdgeAlwncePlus);
						$('#sizeForm2 input[name="thEdgeAlwnceMinus"]').val(data.thEdgeAlwnceMinus);
						$('#sizeForm2 input[name="burrCond"]').val(data.burrCond);
						$('#sizeForm2 input[name="burrAlwncePlus"]').val(data.burrAlwncePlus);
						$('#sizeForm2 input[name="burrAlwnceMinus"]').val(data.burrAlwnceMinus);
						$('#sizeForm2 input[name="gapOfLayerCond"]').val(data.gapOfLayerCond);
						$('#sizeForm2 input[name="gapOfLayerPlus"]').val(data.gapOfLayerPlus);
						$('#sizeForm2 input[name="gapOfLayerMinus"]').val(data.gapOfLayerMinus);
						$('#sizeForm2 input[name="thEdgeRightCond"]').val(data.thEdgeRightCond);          
						$('#sizeForm2 input[name="thEdgeRightAlwncePlus"]').val(data.thEdgeRightAlwncePlus);    
						$('#sizeForm2 input[name="thEdgeRightAlwnceMinus"]').val(data.thEdgeRightAlwnceMinus);   
						$('#sizeForm2 input[name="bendingCond"]').val(data.bendingCond);              
						$('#sizeForm2 input[name="bendingAlwncePlus"]').val(data.bendingAlwncePlus);        
						$('#sizeForm2 input[name="bendingAlwnceMinus"]').val(data.bendingAlwnceMinus);	     		            	

						//수정 선택박스 처리
		                selectBoxAppend(useYnCd, "sizeUseYnCd", data.useYnCd, "");
		            },
		            complete:function(){
						$('#sizeFormBox').removeClass('d-none');
						$('#sizeFormBox2').removeClass('d-none');
		                $('#sizeBtnEdit').attr('disabled', false);
		                sizeForm(true);
		            }
				});
			}
			else {
				toastr.warning('온도, 시간, 압력, 치수 중 하나를 선택하세요.');
				$('#bom').focus();
			}
		}
    });
    
    // 온도 저장 클릭 시 
    $('#tempaturBtnSave').on('click', function() {
        if ( !$.trim($('#tempaturForm input[name=tempaturCondNm]').val()) ) {
            toastr.warning('온도 명칭을 입력해주세요.');
            $('#tempaturForm input[name=tempaturCondNm]').focus();
            return false;
        }
        //if ( !$.trim($('#tempaturForm input[name=warmupCond]').val()) ) {
        //    toastr.warning('예열 조건을 입력해주세요.');
        //    $('#tempaturForm input[name=warmupCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=warmupAlwncePlus]').val()) ) {
        //    toastr.warning('예열 공차(+)를 입력해주세요.');
        //    $('#tempaturForm input[name=warmupAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=warmupAlwnceMinus]').val()) ) {
        //    toastr.warning('예열 공차(-)를 입력해주세요.');
        //    $('#tempaturForm input[name=warmupAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=fitupCond]').val()) ) {
        //    toastr.warning('가접 조건을 입력해주세요.');
        //    $('#tempaturForm input[name=fitupCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=fitupAlwncePlus]').val()) ) {
        //    toastr.warning('가접 공차(+)를 입력해주세요.');
        //    $('#tempaturForm input[name=fitupAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=fitupAlwnceMinus]').val()) ) {
        //    toastr.warning('가접 공차(-)를을 입력해주세요.');
        //    $('#tempaturForm input[name=fitupAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=firstCond]').val()) ) {
        //    toastr.warning('1차 조건을 입력해주세요.');
        //    $('#tempaturForm input[name=firstCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=firstAlwncePlus]').val()) ) {
        //    toastr.warning('1차 공차(+)를 입력해주세요.');
        //    $('#tempaturForm input[name=firstAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=firstAlwnceMinus]').val()) ) {
        //    toastr.warning('1차 공차(-)를 입력해주세요.');
        //    $('#tempaturForm input[name=firstAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=secondCond]').val()) ) {
        //    toastr.warning('2차 조건을 입력해주세요.');
        //    $('#tempaturForm input[name=secondCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=secondAlwncePlus]').val()) ) {
        //    toastr.warning('2차 공차(+)를 입력해주세요.');
        //    $('#tempaturForm input[name=secondAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=secondAlwnceMinus]').val()) ) {
        //    toastr.warning('2차 공차(-)를 입력해주세요.');
        //    $('#tempaturForm input[name=secondAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=jinjeopCond]').val()) ) {
        //    toastr.warning('진접 조건을 입력해주세요.');
        //    $('#tempaturForm input[name=jinjeopCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=jinjeopAlwncePlus]').val()) ) {
        //    toastr.warning('진접 공차(+)를 입력해주세요.');
        //    $('#tempaturForm input[name=jinjeopAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#tempaturForm input[name=jinjeopAlwnceMinus]').val()) ) {
        //    toastr.warning('집접 공차(-)를 입력해주세요.');
        //    $('#tempaturForm input[name=jinjeopAlwnceMinus]').focus();
        //    return false;
        //}
        if ( $("#tempaturUseYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해 주세요.');
            $("#tempaturUseYnCd").focus();
            return false;
        }
		       
		if( sideView == "edit" ) {
			url = '<c:url value="bm/tempaturUpdate"/>';
		} else {
			url = '<c:url value="bm/tempaturCreate"/>';
		}
		
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'						:		menuAuth,
            	'tempaturCondCd'				: 		$('#tempaturForm input[name=tempaturCondCd]').val(),
            	'tempaturCondNm'				: 		$('#tempaturForm input[name=tempaturCondNm]').val(),
            	'warmupCond'					: 		$('#tempaturForm input[name=warmupCond]').val(),
            	'warmupAlwncePlus'				: 		$('#tempaturForm input[name=warmupAlwncePlus]').val(),
            	'warmupAlwnceMinus'				: 		$('#tempaturForm input[name=warmupAlwnceMinus]').val(),
            	'fitup1UpCond'					: 		$('#tempaturForm input[name=fitup1UpCond]').val(),
            	'fitup1UpAlwncePlus'			: 		$('#tempaturForm input[name=fitup1UpAlwncePlus]').val(),
            	'fitup1UpAlwnceMinus'			: 		$('#tempaturForm input[name=fitup1UpAlwnceMinus]').val(),
            	'fitup1DownCond'				: 		$('#tempaturForm input[name=fitup1DownCond]').val(),
            	'fitup1DownAlwncePlus'			: 		$('#tempaturForm input[name=fitup1DownAlwncePlus]').val(),
            	'fitup1DownAlwnceMinus'			: 		$('#tempaturForm input[name=fitup1DownAlwnceMinus]').val(),
            	'fitup2UpleftCond'				: 		$('#tempaturForm input[name=fitup2UpleftCond]').val(),
            	'fitup2UpleftAlwncePlus'		: 		$('#tempaturForm input[name=fitup2UpleftAlwncePlus]').val(),
            	'fitup2UpleftAlwnceMinus'		: 		$('#tempaturForm input[name=fitup2UpleftAlwnceMinus]').val(),
            	'fitup2DownleftCond'			: 		$('#tempaturForm input[name=fitup2DownleftCond]').val(),
            	'fitup2DownleftAlwncePlus'		: 		$('#tempaturForm input[name=fitup2DownleftAlwncePlus]').val(),
            	'fitup2DownleftAlwnceMinus'		: 		$('#tempaturForm input[name=fitup2DownleftAlwnceMinus]').val(),
            	'fitup2UprightCond'				: 		$('#tempaturForm input[name=fitup2UprightCond]').val(),
            	'fitup2UprightAlwncePlus'		: 		$('#tempaturForm input[name=fitup2UprightAlwncePlus]').val(),
            	'fitup2UprightAlwnceMinus'		: 		$('#tempaturForm input[name=fitup2UprightAlwnceMinus]').val(),
            	'fitup2DownrightCond'			: 		$('#tempaturForm input[name=fitup2DownrightCond]').val(),
            	'fitup2DownrightAlwncePlus'		: 		$('#tempaturForm input[name=fitup2DownrightAlwncePlus]').val(),
            	'fitup2DownrightAlwnceMinus'	: 		$('#tempaturForm input[name=fitup2DownrightAlwnceMinus]').val(),
            	'rollheatUpCond'				: 		$('#tempaturForm input[name=rollheatUpCond]').val(),
            	'rollheatUpAlwncePlus'			: 		$('#tempaturForm input[name=rollheatUpAlwncePlus]').val(),
            	'rollheatUpAlwnceMinus'			: 		$('#tempaturForm input[name=rollheatUpAlwnceMinus]').val(),
            	'rollheatDownCond'				: 		$('#tempaturForm input[name=rollheatDownCond]').val(),
            	'rollheatDownAlwncePlus'		: 		$('#tempaturForm input[name=rollheatDownAlwncePlus]').val(),
            	'rollheatDownAlwnceMinus'		: 		$('#tempaturForm input[name=rollheatDownAlwnceMinus]').val(),
            	'firstUpleftCond'				: 		$('#tempaturForm input[name=firstUpleftCond]').val(),
            	'firstUpleftAlwncePlus'			: 		$('#tempaturForm input[name=firstUpleftAlwncePlus]').val(),
            	'firstUpleftAlwnceMinus'		: 		$('#tempaturForm input[name=firstUpleftAlwnceMinus]').val(),
            	'firstDownleftCond'				: 		$('#tempaturForm input[name=firstDownleftCond]').val(),
            	'firstDownleftAlwncePlus'		: 		$('#tempaturForm input[name=firstDownleftAlwncePlus]').val(),
            	'firstDownleftAlwnceMinus'		: 		$('#tempaturForm input[name=firstDownleftAlwnceMinus]').val(),
            	'firstUprightCond'				: 		$('#tempaturForm input[name=firstUprightCond]').val(),
            	'firstUprightAlwncePlus'		: 		$('#tempaturForm input[name=firstUprightAlwncePlus]').val(),
            	'firstUprightAlwnceMinus'		: 		$('#tempaturForm input[name=firstUprightAlwnceMinus]').val(),
            	'firstDownrightCond'			: 		$('#tempaturForm input[name=firstDownrightCond]').val(),
            	'firstDownrightAlwncePlus'		: 		$('#tempaturForm input[name=firstDownrightAlwncePlus]').val(),
            	'firstDownrightAlwnceMinus'		: 		$('#tempaturForm input[name=firstDownrightAlwnceMinus]').val(),

            	'push1UpCond'					: 		$('#tempaturForm input[name=push1UpCond]').val(),
            	'push1UpAlwncePlus'				: 		$('#tempaturForm input[name=push1UpAlwncePlus]').val(),
            	'push1UpAlwnceMinus'			: 		$('#tempaturForm input[name=push1UpAlwnceMinus]').val(),
            	'push1DownCond'					: 		$('#tempaturForm input[name=push1DownCond]').val(),
            	'push1DownAlwncePlus'			: 		$('#tempaturForm input[name=push1DownAlwncePlus]').val(),
            	'push1DownAlwnceMinus'			: 		$('#tempaturForm input[name=push1DownAlwnceMinus]').val(),
            	
            	'secondUpleftCond'				: 		$('#tempaturForm input[name=secondUpleftCond]').val(),
            	'secondUpleftAlwncePlus'		: 		$('#tempaturForm input[name=secondUpleftAlwncePlus]').val(),
            	'secondUpleftAlwnceMinus'		: 		$('#tempaturForm input[name=secondUpleftAlwnceMinus]').val(),
            	'secondDownleftCond'			: 		$('#tempaturForm input[name=secondDownleftCond]').val(),
            	'secondDownleftAlwncePlus'		: 		$('#tempaturForm input[name=secondDownleftAlwncePlus]').val(),
            	'secondDownleftAlwnceMinus'		: 		$('#tempaturForm input[name=secondDownleftAlwnceMinus]').val(),
            	'secondUprightCond'				: 		$('#tempaturForm input[name=secondUprightCond]').val(),
            	'secondUprightAlwncePlus'		: 		$('#tempaturForm input[name=secondUprightAlwncePlus]').val(),
            	'secondUprightAlwnceMinus'		: 		$('#tempaturForm input[name=secondUprightAlwnceMinus]').val(),
            	'secondDownrightCond'			: 		$('#tempaturForm input[name=secondDownrightCond]').val(),
            	'secondDownrightAlwncePlus'		: 		$('#tempaturForm input[name=secondDownrightAlwncePlus]').val(),
            	'secondDownrightAlwnceMinus'	: 		$('#tempaturForm input[name=secondDownrightAlwnceMinus]').val(),
            	'thirdUpleftCond'				: 		$('#tempaturForm input[name=thirdUpleftCond]').val(),
            	'thirdUpleftAlwncePlus'			: 		$('#tempaturForm input[name=thirdUpleftAlwncePlus]').val(),
            	'thirdUpleftAlwnceMinus'		: 		$('#tempaturForm input[name=thirdUpleftAlwnceMinus]').val(),
            	'thirdDownleftCond'				: 		$('#tempaturForm input[name=thirdDownleftCond]').val(),
            	'thirdDownleftAlwncePlus'		: 		$('#tempaturForm input[name=thirdDownleftAlwncePlus]').val(),
            	'thirdDownleftAlwnceMinus'		: 		$('#tempaturForm input[name=thirdDownleftAlwnceMinus]').val(),
            	'thirdUprightCond'				: 		$('#tempaturForm input[name=thirdUprightCond]').val(),
            	'thirdUprightAlwncePlus'		: 		$('#tempaturForm input[name=thirdUprightAlwncePlus]').val(),
            	'thirdUprightAlwnceMinus'		: 		$('#tempaturForm input[name=thirdUprightAlwnceMinus]').val(),
            	'thirdDownrightCond'			: 		$('#tempaturForm input[name=thirdDownrightCond]').val(),
            	'thirdDownrightAlwncePlus'		: 		$('#tempaturForm input[name=thirdDownrightAlwncePlus]').val(),
            	'thirdDownrightAlwnceMinus'		: 		$('#tempaturForm input[name=thirdDownrightAlwnceMinus]').val(),
            	'jinjeop1UpCond'				: 		$('#tempaturForm input[name=jinjeop1UpCond]').val(),
            	'jinjeop1UpAlwncePlus'			: 		$('#tempaturForm input[name=jinjeop1UpAlwncePlus]').val(),
            	'jinjeop1UpAlwnceMinus'			: 		$('#tempaturForm input[name=jinjeop1UpAlwnceMinus]').val(),
            	'jinjeop1DownCond'				: 		$('#tempaturForm input[name=jinjeop1DownCond]').val(),
            	'jinjeop1DownAlwncePlus'		: 		$('#tempaturForm input[name=jinjeop1DownAlwncePlus]').val(),
            	'jinjeop1DownAlwnceMinus'		: 		$('#tempaturForm input[name=jinjeop1DownAlwnceMinus]').val(),
            	'jinjeop2UpCond'				: 		$('#tempaturForm input[name=jinjeop2UpCond]').val(),
            	'jinjeop2UpAlwncePlus'			: 		$('#tempaturForm input[name=jinjeop2UpAlwncePlus]').val(),
            	'jinjeop2UpAlwnceMinus'			: 		$('#tempaturForm input[name=jinjeop2UpAlwnceMinus]').val(),
            	'jinjeop2DownCond'				: 		$('#tempaturForm input[name=jinjeop2DownCond]').val(),
            	'jinjeop2DownAlwncePlus'		: 		$('#tempaturForm input[name=jinjeop2DownAlwncePlus]').val(),
            	'jinjeop2DownAlwnceMinus'		: 		$('#tempaturForm input[name=jinjeop2DownAlwnceMinus]').val(),
            	'useYnCd'						: 		$('#tempaturForm select[name=useYnCd]').val(),
            },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					if( sideView == "edit" ) {
						toastr.success('수정되었습니다.');
					} else {
						toastr.success('등록되었습니다.');
					}
					//등록된 온도코드&정보들 뿌려주기
    				$('#tempaturForm input[name="tempaturCondCd"]').val(data.tempaturCondCd);
    				$('#tempaturForm input[name="tempaturCondNm"]').val(data.tempaturCondNm);
    				//$('#tempaturForm input[name="warmupCond"]').val(data.warmupCond);
    				//$('#tempaturForm input[name="warmupAlwncePlus"]').val(data.warmupAlwncePlus);
    				//$('#tempaturForm input[name="warmupAlwnceMinus"]').val(data.warmupAlwnceMinus);
    				//$('#tempaturForm input[name="fitupCond"]').val(data.fitupCond);
    				//$('#tempaturForm input[name="fitupAlwncePlus"]').val(data.fitupAlwncePlus);
    				//$('#tempaturForm input[name="fitupAlwnceMinus"]').val(data.fitupAlwnceMinus);
    				//$('#tempaturForm input[name="fitup2Cond"]').val(data.fitup2Cond);
    				//$('#tempaturForm input[name="fitup2AlwncePlus"]').val(data.fitup2AlwncePlus);
    				//$('#tempaturForm input[name="fitup2AlwnceMinus"]').val(data.fitup2AlwnceMinus);
    				//$('#tempaturForm input[name="firstCond"]').val(data.firstCond);
    				//$('#tempaturForm input[name="firstAlwncePlus"]').val(data.firstAlwncePlus);
    				//$('#tempaturForm input[name="firstAlwnceMinus"]').val(data.firstAlwnceMinus);
    				//$('#tempaturForm input[name="secondCond"]').val(data.secondCond);
    				//$('#tempaturForm input[name="secondAlwncePlus"]').val(data.secondAlwncePlus);
    				//$('#tempaturForm input[name="secondAlwnceMinus"]').val(data.secondAlwnceMinus);
    				//$('#tempaturForm input[name="jinjeopCond"]').val(data.jinjeopCond);
    				//$('#tempaturForm input[name="jinjeopAlwncePlus"]').val(data.jinjeopAlwncePlus);
    				//$('#tempaturForm input[name="jinjeopAlwnceMinus"]').val(data.jinjeopAlwnceMinus);
    				//$('#tempaturForm input[name="reformCond"]').val(data.reformCond);
    				//$('#tempaturForm input[name="reformAlwncePlus"]').val(data.reformAlwncePlus);
    				//$('#tempaturForm input[name="reformAlwnceMinus"]').val(data.reformAlwnceMinus);
    				//$('#tempaturForm input[name="rollheatCond"]').val(data.rollheatCond);
    				//$('#tempaturForm input[name="rollheatAlwncePlus"]').val(data.rollheatAlwncePlus);
    				//$('#tempaturForm input[name="rollheatAlwnceMinus"]').val(data.rollheatAlwnceMinus);
    				//$('#tempaturForm input[name="thirdCond"]').val(data.thirdCond);
    				//$('#tempaturForm input[name="thirdAlwncePlus"]').val(data.thirdAlwncePlus);
    				//$('#tempaturForm input[name="thirdAlwnceMinus"]').val(data.thirdAlwnceMinus);
    				//$('#tempaturForm input[name="jinjeop2Cond"]').val(data.jinjeop2Cond);
    				//$('#tempaturForm input[name="jinjeop2AlwncePlus"]').val(data.jinjeop2AlwncePlus);
    				//$('#tempaturForm input[name="jinjeop2AlwnceMinus"]').val(data.jinjeop2AlwnceMinus);
    				//$('#tempaturForm select[name=useYnCd]').val(data.useYnCd);
    				
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#bomList').DataTable().ajax.reload();
				$('#tempaturFormBox').removeClass('d-none');
		        $('#tempaturBtnEdit').attr('disabled', false);
		        $('#tempaturBtnSave').attr('disabled', true);
		        $('#tempaturBtnSave').addClass('d-none');
		        tempaturForm(true);
			}
		});
	});

	// 시간 저장 클릭 시 
    $('#timeBtnSave').on('click', function() {
        if ( !$.trim($('#timeForm input[name=timeCondNm]').val()) ) {
            toastr.warning('시간 명칭을 입력해주세요.');
            $('#timeForm input[name=timeCondNm]').focus();
            return false;
        }
        //if ( !$.trim($('#timeForm input[name=warmupCond]').val()) ) {
        //    toastr.warning('예열 조건을 입력해주세요.');
        //    $('#timeForm input[name=warmupCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=warmupAlwncePlus]').val()) ) {
        //    toastr.warning('예열 공차(+)를 입력해주세요.');
        //    $('#timeForm input[name=warmupAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=warmupAlwnceMinus]').val()) ) {
        //    toastr.warning('예열 공차(-)를 입력해주세요.');
        //    $('#timeForm input[name=warmupAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=fitupCond]').val()) ) {
        //    toastr.warning('가접 조건을 입력해주세요.');
        //    $('#timeForm input[name=fitupCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=fitupAlwncePlus]').val()) ) {
        //    toastr.warning('가접 공차(+)를 입력해주세요.');
        //    $('#timeForm input[name=fitupAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=fitupAlwnceMinus]').val()) ) {
        //    toastr.warning('가접 공차(-)를을 입력해주세요.');
        //    $('#timeForm input[name=fitupAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=firstCond]').val()) ) {
        //    toastr.warning('1차 조건을 입력해주세요.');
        //    $('#timeForm input[name=firstCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=firstAlwncePlus]').val()) ) {
        //    toastr.warning('1차 공차(+)를 입력해주세요.');
        //    $('#timeForm input[name=firstAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=firstAlwnceMinus]').val()) ) {
        //    toastr.warning('1차 공차(-)를 입력해주세요.');
        //    $('#timeForm input[name=firstAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=secondCond]').val()) ) {
        //    toastr.warning('2차 조건을 입력해주세요.');
        //    $('#timeForm input[name=secondCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=secondAlwncePlus]').val()) ) {
        //    toastr.warning('2차 공차(+)를 입력해주세요.');
        //    $('#timeForm input[name=secondAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=secondAlwnceMinus]').val()) ) {
        //    toastr.warning('2차 공차(-)를 입력해주세요.');
        //    $('#timeForm input[name=secondAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=jinjeopCond]').val()) ) {
        //    toastr.warning('진접 조건을 입력해주세요.');
        //    $('#timeForm input[name=jinjeopCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=jinjeopAlwncePlus]').val()) ) {
        //    toastr.warning('진접 공차(+)를 입력해주세요.');
        //    $('#timeForm input[name=jinjeopAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#timeForm input[name=jinjeopAlwnceMinus]').val()) ) {
        //    toastr.warning('집접 공차(-)를 입력해주세요.');
        //    $('#timeForm input[name=jinjeopAlwnceMinus]').focus();
        //    return false;
        //}
        if ( $("#timeUseYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해 주세요.');
            $("#timeUseYnCd").focus();
            return false;
		}
        
		if( sideView == "edit" ) {
			url = '<c:url value="bm/timeUpdate"/>';
		} else {
			url = '<c:url value="bm/timeCreate"/>';
		}
		
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'				:		menuAuth,
            	'timeCondCd'			: 		$('#timeForm input[name=timeCondCd]').val(),
            	'timeCondNm'			: 		$('#timeForm input[name=timeCondNm]').val(),
            	'warmupCond'			: 		$('#timeForm input[name=warmupCond]').val(),
            	'warmupAlwncePlus'		: 		$('#timeForm input[name=warmupAlwncePlus]').val(),
            	'warmupAlwnceMinus'		: 		$('#timeForm input[name=warmupAlwnceMinus]').val(),
            	'fitupCond'				: 		$('#timeForm input[name=fitupCond]').val(),
            	'fitupAlwncePlus'		: 		$('#timeForm input[name=fitupAlwncePlus]').val(),
            	'fitupAlwnceMinus'		: 		$('#timeForm input[name=fitupAlwnceMinus]').val(),
            	'fitup2Cond'			: 		$('#timeForm input[name=fitup2Cond]').val(),
            	'fitup2AlwncePlus'		: 		$('#timeForm input[name=fitup2AlwncePlus]').val(),
            	'fitup2AlwnceMinus'		: 		$('#timeForm input[name=fitup2AlwnceMinus]').val(),
            	'firstCond'				: 		$('#timeForm input[name=firstCond]').val(),
            	'firstAlwncePlus'		: 		$('#timeForm input[name=firstAlwncePlus]').val(),
            	'firstAlwnceMinus'		: 		$('#timeForm input[name=firstAlwnceMinus]').val(),
            	'secondCond'			: 		$('#timeForm input[name=secondCond]').val(),
            	'secondAlwncePlus'		: 		$('#timeForm input[name=secondAlwncePlus]').val(),
            	'secondAlwnceMinus'		: 		$('#timeForm input[name=secondAlwnceMinus]').val(),

            	'thirdCond'				: 		$('#timeForm input[name=thirdCond]').val(),
            	'thirdAlwncePlus'		: 		$('#timeForm input[name=thirdAlwncePlus]').val(),
            	'thirdAlwnceMinus'		: 		$('#timeForm input[name=thirdAlwnceMinus]').val(),
            	
            	'jinjeopCond'			: 		$('#timeForm input[name=jinjeopCond]').val(),
            	'jinjeopAlwncePlus'		: 		$('#timeForm input[name=jinjeopAlwncePlus]').val(),
            	'jinjeopAlwnceMinus'	: 		$('#timeForm input[name=jinjeopAlwnceMinus]').val(),

            	'jinjeop2Cond'			: 		$('#timeForm input[name=jinjeop2Cond]').val(),
            	'jinjeop2AlwncePlus'	: 		$('#timeForm input[name=jinjeop2AlwncePlus]').val(),
            	'jinjeop2AlwnceMinus'	: 		$('#timeForm input[name=jinjeop2AlwnceMinus]').val(),
            	'push1Cond'				: 		$('#timeForm input[name=push1Cond]').val(),
            	'push1AlwncePlus'		: 		$('#timeForm input[name=push1AlwncePlus]').val(),
            	'push1AlwnceMinus'		: 		$('#timeForm input[name=push1AlwnceMinus]').val(),
            	
            	'reformCond'			: 		$('#timeForm input[name=reformCond]').val(),
            	'reformAlwncePlus'		: 		$('#timeForm input[name=reformAlwncePlus]').val(),
            	'reformAlwnceMinus'		: 		$('#timeForm input[name=reformAlwnceMinus]').val(),

            	'coolCond'				: 		$('#timeForm input[name=coolCond]').val(),
            	'coolAlwncePlus'		: 		$('#timeForm input[name=coolAlwncePlus]').val(),
            	'coolAlwnceMinus'		: 		$('#timeForm input[name=coolAlwnceMinus]').val(),
            	
            	'useYnCd'				: 		$('#timeForm select[name=useYnCd]').val(),
            },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					if( sideView == "edit" ) {
						toastr.success('수정되었습니다.');
					} else {
						toastr.success('등록되었습니다.');
					}
					//등록된 시간코드&정보들 뿌려주기
    				$('#timeForm input[name="timeCondCd"]').val(data.timeCondCd);
    				$('#timeForm input[name="timeCondNm"]').val(data.timeCondNm);
    				//$('#timeForm input[name="warmupCond"]').val(data.warmupCond);
    				//$('#timeForm input[name="warmupAlwncePlus"]').val(data.warmupAlwncePlus);
    				//$('#timeForm input[name="warmupAlwnceMinus"]').val(data.warmupAlwnceMinus);
    				//$('#timeForm input[name="fitupCond"]').val(data.fitupCond);
    				//$('#timeForm input[name="fitupAlwncePlus"]').val(data.fitupAlwncePlus);
    				//$('#timeForm input[name="fitupAlwnceMinus"]').val(data.fitupAlwnceMinus);
    				//$('#timeForm input[name="fitup2Cond"]').val(data.fitup2Cond);
    				//$('#timeForm input[name="fitup2AlwncePlus"]').val(data.fitup2AlwncePlus);
    				//$('#timeForm input[name="fitup2AlwnceMinus"]').val(data.fitup2AlwnceMinus);
    				//$('#timeForm input[name="firstCond"]').val(data.firstCond);
    				//$('#timeForm input[name="firstAlwncePlus"]').val(data.firstAlwncePlus);
    				//$('#timeForm input[name="firstAlwnceMinus"]').val(data.firstAlwnceMinus);
    				//$('#timeForm input[name="secondCond"]').val(data.secondCond);
    				//$('#timeForm input[name="secondAlwncePlus"]').val(data.secondAlwncePlus);
    				//$('#timeForm input[name="secondAlwnceMinus"]').val(data.secondAlwnceMinus);
    				//$('#timeForm input[name="jinjeopCond"]').val(data.jinjeopCond);
    				//$('#timeForm input[name="jinjeopAlwncePlus"]').val(data.jinjeopAlwncePlus);
    				//$('#timeForm input[name="jinjeopAlwnceMinus"]').val(data.jinjeopAlwnceMinus);
    				//$('#timeForm input[name="reformCond"]').val(data.reformCond);
    				//$('#timeForm input[name="reformAlwncePlus"]').val(data.reformAlwncePlus);
    				//$('#timeForm input[name="reformAlwnceMinus"]').val(data.reformAlwnceMinus);
    				//$('#timeForm select[name=useYnCd]').val(data.useYnCd);
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#bomList').DataTable().ajax.reload();
				$('#timeFormBox').removeClass('d-none');
		        $('#timeBtnEdit').attr('disabled', false);
				$('#timeBtnSave').attr('disabled', true);
				$('#timeBtnSave').addClass('d-none');
		        timeForm(true);
			}
		});
	});

	// 압력 저장 클릭 시 
    $('#pressureBtnSave').on('click', function() {
        if ( !$.trim($('#pressureForm input[name=pressureCondNm]').val()) ) {
            toastr.warning('압력 명칭을 입력해주세요.');
            $('#pressureForm input[name=pressureCondNm]').focus();
            return false;
        }
        //if ( !$.trim($('#pressureForm input[name=warmupCond]').val()) ) {
        //    toastr.warning('예열 조건을 입력해주세요.');
        //    $('#pressureForm input[name=warmupCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=warmupAlwncePlus]').val()) ) {
        //    toastr.warning('예열 공차(+)를 입력해주세요.');
        //    $('#pressureForm input[name=warmupAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=warmupAlwnceMinus]').val()) ) {
        //    toastr.warning('예열 공차(-)를 입력해주세요.');
        //    $('#pressureForm input[name=warmupAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=fitupCond]').val()) ) {
        //    toastr.warning('가접 조건을 입력해주세요.');
        //    $('#pressureForm input[name=fitupCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=fitupAlwncePlus]').val()) ) {
        //    toastr.warning('가접 공차(+)를 입력해주세요.');
        //    $('#pressureForm input[name=fitupAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=fitupAlwnceMinus]').val()) ) {
        //    toastr.warning('가접 공차(-)를을 입력해주세요.');
        //    $('#pressureForm input[name=fitupAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=firstCond]').val()) ) {
        //    toastr.warning('1차 조건을 입력해주세요.');
        //    $('#pressureForm input[name=firstCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=firstAlwncePlus]').val()) ) {
        //    toastr.warning('1차 공차(+)를 입력해주세요.');
        //    $('#pressureForm input[name=firstAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=firstAlwnceMinus]').val()) ) {
        //    toastr.warning('1차 공차(-)를 입력해주세요.');
        //    $('#pressureForm input[name=firstAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=secondCond]').val()) ) {
        //    toastr.warning('2차 조건을 입력해주세요.');
        //    $('#pressureForm input[name=secondCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=secondAlwncePlus]').val()) ) {
        //    toastr.warning('2차 공차(+)를 입력해주세요.');
        //    $('#pressureForm input[name=secondAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=secondAlwnceMinus]').val()) ) {
        //    toastr.warning('2차 공차(-)를 입력해주세요.');
        //    $('#pressureForm input[name=secondAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=jinjeopCond]').val()) ) {
        //    toastr.warning('진접 조건을 입력해주세요.');
        //    $('#pressureForm input[name=jinjeopCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=jinjeopAlwncePlus]').val()) ) {
        //    toastr.warning('진접 공차(+)를 입력해주세요.');
        //    $('#pressureForm input[name=jinjeopAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#pressureForm input[name=jinjeopAlwnceMinus]').val()) ) {
        //    toastr.warning('집접 공차(-)를 입력해주세요.');
        //    $('#pressureForm input[name=jinjeopAlwnceMinus]').focus();
        //    return false;
        //}
        if ( $("#pressureUseYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해 주세요.');
            $("#pressureUseYnCd").focus();
            return false;
        }
		       
		if( sideView == "edit" ) {
			url = '<c:url value="bm/pressureUpdate"/>';
		} else {
			url = '<c:url value="bm/pressureCreate"/>';
		}
		
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'				:		menuAuth,
            	'pressureCondCd'		: 		$('#pressureForm input[name=pressureCondCd]').val(),
            	'pressureCondNm'		: 		$('#pressureForm input[name=pressureCondNm]').val(),
            	'warmupCond'			: 		$('#pressureForm input[name=warmupCond]').val(),
            	'warmupAlwncePlus'		: 		$('#pressureForm input[name=warmupAlwncePlus]').val(),
            	'warmupAlwnceMinus'		: 		$('#pressureForm input[name=warmupAlwnceMinus]').val(),
            	'fitupCond'				: 		$('#pressureForm input[name=fitupCond]').val(),
            	'fitupAlwncePlus'		: 		$('#pressureForm input[name=fitupAlwncePlus]').val(),
            	'fitupAlwnceMinus'		: 		$('#pressureForm input[name=fitupAlwnceMinus]').val(),
            	
            	//'firstCond'			: 		$('#pressureForm input[name=firstCond]').val(),
            	//'firstAlwncePlus'		: 		$('#pressureForm input[name=firstAlwncePlus]').val(),
            	//'firstAlwnceMinus'	: 		$('#pressureForm input[name=firstAlwnceMinus]').val(),
            	'push1Cond'				: 		$('#pressureForm input[name=push1Cond]').val(),       
            	'push1AlwncePlus'		: 		$('#pressureForm input[name=push1AlwncePlus]').val(), 
            	'push1AlwnceMinus'		: 		$('#pressureForm input[name=push1AlwnceMinus]').val(),
            	
            	//'secondCond'			: 		$('#pressureForm input[name=secondCond]').val(),
            	//'secondAlwncePlus'		: 		$('#pressureForm input[name=secondAlwncePlus]').val(),
            	//'secondAlwnceMinus'		: 		$('#pressureForm input[name=secondAlwnceMinus]').val(),
            	'jinjeopCond'			: 		$('#pressureForm input[name=jinjeopCond]').val(),
            	'jinjeopAlwncePlus'		: 		$('#pressureForm input[name=jinjeopAlwncePlus]').val(),
            	'jinjeopAlwnceMinus'	: 		$('#pressureForm input[name=jinjeopAlwnceMinus]').val(),

            	'jinjeop2Cond'			: 		$('#pressureForm input[name=jinjeop2Cond]').val(),
            	'jinjeop2AlwncePlus'	: 		$('#pressureForm input[name=jinjeop2AlwncePlus]').val(),
            	'jinjeop2AlwnceMinus'	: 		$('#pressureForm input[name=jinjeop2AlwnceMinus]').val(),
            	
            	'reformCond'			: 		$('#pressureForm input[name=reformCond]').val(),
            	'reformAlwncePlus'		: 		$('#pressureForm input[name=reformAlwncePlus]').val(),
            	'reformAlwnceMinus'		: 		$('#pressureForm input[name=reformAlwnceMinus]').val(),
            	//'coolCond'				: 		$('#pressureForm input[name=coolCond]').val(),
            	//'coolAlwncePlus'		: 		$('#pressureForm input[name=coolAlwncePlus]').val(),
            	//'coolAlwnceMinus'		: 		$('#pressureForm input[name=coolAlwnceMinus]').val(),
            	'useYnCd'				: 		$('#pressureForm select[name=useYnCd]').val(),
            },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					if( sideView == "edit" ) {
						toastr.success('수정되었습니다.');
					} else {
						toastr.success('등록되었습니다.');
					}
					//등록된 압력코드&정보들 뿌려주기
    				$('#pressure input[name="pressureCondCd"]').val(data.pressureCondCd);
    				$('#pressure input[name="pressureCondNm"]').val(data.pressureCondNm);
    				//$('#pressure input[name="warmupCond"]').val(data.warmupCond);
    				//$('#pressure input[name="warmupAlwncePlus"]').val(data.warmupAlwncePlus);
    				//$('#pressure input[name="warmupAlwnceMinus"]').val(data.warmupAlwnceMinus);
    				//$('#pressure input[name="fitupCond"]').val(data.fitupCond);
    				//$('#pressure input[name="fitupAlwncePlus"]').val(data.fitupAlwncePlus);
    				//$('#pressure input[name="fitupAlwnceMinus"]').val(data.fitupAlwnceMinus);
    				//$('#pressure input[name="firstCond"]').val(data.firstCond);
    				//$('#pressure input[name="firstAlwncePlus"]').val(data.firstAlwncePlus);
    				//$('#pressure input[name="firstAlwnceMinus"]').val(data.firstAlwnceMinus);
    				//$('#pressure input[name="secondCond"]').val(data.secondCond);
    				//$('#pressure input[name="secondAlwncePlus"]').val(data.secondAlwncePlus);
    				//$('#pressure input[name="secondAlwnceMinus"]').val(data.secondAlwnceMinus);
    				//$('#pressure input[name="jinjeopCond"]').val(data.jinjeopCond);
    				//$('#pressure input[name="jinjeopAlwncePlus"]').val(data.jinjeopAlwncePlus);
    				//$('#pressure input[name="jinjeopAlwnceMinus"]').val(data.jinjeopAlwnceMinus);
    				//$('#pressure input[name="reformCond"]').val(data.reformCond);
    				//$('#pressure input[name="reformAlwncePlus"]').val(data.reformAlwncePlus);
    				//$('#pressure input[name="reformAlwnceMinus"]').val(data.reformAlwnceMinus);
    				//$('#pressure input[name="coolCond"]').val(data.reformCond);
    				//$('#pressure input[name="coolAlwncePlus"]').val(data.reformAlwncePlus);
    				//$('#pressure input[name="coolAlwnceMinus"]').val(data.reformAlwnceMinus);
    				//$('#pressure input[name="useYnCd"]').val(data.useYnCd);
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#bomList').DataTable().ajax.reload()
				$('#pressureFormBox').removeClass('d-none');
		        $('#pressureBtnEdit').attr('disabled', false);  //수정버튼
		        $('#pressureBtnSave').attr('disabled', true);
		        $('#pressureBtnSave').addClass('d-none');
		        pressureForm(true);
			}
		});
	});
	
	// 치수 저장 클릭 시 
    $('#sizeBtnSave').on('click', function() {
        if ( !$.trim($('#sizeForm input[name=sizeCondNm]').val()) ) {
            toastr.warning('치수 명칭을 입력해주세요.');
            $('#sizeForm input[name=sizeCondNm]').focus();
            return false;
        }
        //if ( !$.trim($('#sizeForm input[name=wpLeftCond]').val()) ) {
        //    toastr.warning('Welding Park(좌) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=wpLeftCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=wpLeftAlwncePlus]').val()) ) {
        //    toastr.warning('Welding Park(좌) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=wpLeftAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=wpLeftAlwnceMinus]').val()) ) {
        //    toastr.warning('Welding Park(좌) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=wpLeftAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=wpRightCond]').val()) ) {
        //    toastr.warning('Welding paark(우) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=wpRightCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=wpRightAlwncePlus]').val()) ) {
        //    toastr.warning('Welding paark(우) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=wpRightAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=wpRightAlwnceMinus]').val()) ) {
        //    toastr.warning('Welding paark(우) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=wpRightAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=pitchLeftCond]').val()) ) {
        //    toastr.warning('Pitch(좌) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=pitchLeftCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=pitchLeftAlwncePlus]').val()) ) {
        //    toastr.warning('Pitch(좌) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=pitchLeftAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=pitchLeftAlwnceMinus]').val()) ) {
        //    toastr.warning('Pitch(좌) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=pitchLeftAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=pitchRightCond]').val()) ) {
        //    toastr.warning('Pitch(우) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=pitchRightCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=pitchRightAlwncePlus]').val()) ) {
        //    toastr.warning('Pitch(우) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=pitchRightAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=pitchRightAlwnceMinus]').val()) ) {
        //    toastr.warning('Pitch(우) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=pitchRightAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfWingLeftCond]').val()) ) {
        //    toastr.warning('P.P Film 날개(좌) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=ppfWingLeftCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfWingLeftAlwncePlus]').val()) ) {
        //    toastr.warning('P.P Film 날개(좌) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=ppfWingLeftAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfWingLeftAlwnceMinus]').val()) ) {
        //    toastr.warning('P.P Film 날개(좌) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=ppfWingLeftAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfWingRightCond]').val()) ) {
        //    toastr.warning('P.P Film 날개(우) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=ppfWingRightCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfWingRightAlwncePlus]').val()) ) {
        //    toastr.warning('P.P Film 날개(우) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=ppfWingRightAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfWingRightAlwnceMinus]').val()) ) {
        //    toastr.warning('P.P Film 날개(우) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=ppfWingRightAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfDepthLeftCond]').val()) ) {
        //    toastr.warning('P.P File 폭(좌) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=ppfDepthLeftCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfDepthLeftAlwncePlus]').val()) ) {
        //    toastr.warning('P.P File 폭(좌) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=ppfDepthLeftAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfDepthLeftAlwnceMinus]').val()) ) {
        //    toastr.warning('P.P File 폭(좌) (-)를 입력해주세요.');
        //    $('#sizeForm input[name=ppfDepthLeftAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfDepthRightCond]').val()) ) {
        //    toastr.warning('P.P File 폭(우) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=ppfDepthRightCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfDepthRightAlwncePlus]').val()) ) {
        //    toastr.warning('P.P File 폭(우) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=ppfDepthRightAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=ppfDepthRightAlwnceMinus]').val()) ) {
        //    toastr.warning('P.P File 폭(우) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=ppfDepthRightAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=filmCond]').val()) ) {
        //    toastr.warning('Film 조건을 입력해주세요.');
        //    $('#sizeForm input[name=filmCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=filmAlwncePlus]').val()) ) {
        //    toastr.warning('Film 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=filmAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=filmAlwnceMinus]').val()) ) {
        //    toastr.warning('Film (-)를 입력해주세요.');
        //    $('#sizeForm input[name=filmAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=metalDepthCond]').val()) ) {
        //    toastr.warning('Metal(폭)를 입력해주세요.');
        //    $('#sizeForm input[name=metalDepthCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=metalDepthAlwncePlus]').val()) ) {
        //    toastr.warning('Metal(폭) 공차(+) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=metalDepthAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=metalDepthAlwnceMinus]').val()) ) {
        //    toastr.warning('Metal(폭) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=metalDepthAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=metalThicknessCond]').val()) ) {
        //    toastr.warning('Metal(두께)	 조건을 입력해주세요.');
        //    $('#sizeForm input[name=metalThicknessCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=metalThicknessAlwncePlus]').val()) ) {
        //    toastr.warning('Metal(두께)	 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=metalThicknessAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=metalThicknessAlwnceMinus]').val()) ) {
        //    toastr.warning('Metal(두께)	 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=metalThicknessAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=thCenterCond]').val()) ) {
        //    toastr.warning('총두께(Center) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=thCenterCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=thCenterAlwncePlus]').val()) ) {
        //    toastr.warning('총두께(Center) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=thCenterAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=thCenterAlwnceMinus]').val()) ) {
        //    toastr.warning('총두께(Center) 공차(-)울 입력해주세요.');
        //    $('#sizeForm input[name=thCenterAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=thEdgeCond]').val()) ) {
        //    toastr.warning('총두께(Edge) 조건을 입력해주세요.');
        //    $('#sizeForm input[name=thEdgeCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=thEdgeAlwncePlus]').val()) ) {
        //    toastr.warning('총두께(Edge) 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=thEdgeAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=thEdgeAlwnceMinus]').val()) ) {
        //    toastr.warning('총두께(Edge) 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=thEdgeAlwnceMinus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=burrCond]').val()) ) {
        //    toastr.warning('Burr 조건을 입력해주세요.');
        //    $('#sizeForm input[name=burrCond]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=burrAlwncePlus]').val()) ) {
        //    toastr.warning('Burr 공차(+)를 입력해주세요.');
        //    $('#sizeForm input[name=burrAlwncePlus]').focus();
        //    return false;
        //}
        //if ( !$.trim($('#sizeForm input[name=burrAlwnceMinus]').val()) ) {
        //    toastr.warning('Burr 공차(-)를 입력해주세요.');
        //    $('#sizeForm input[name=burrAlwnceMinus]').focus();
        //    return false;
        //}
        if ( $("#sizeUseYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해 주세요.');
            $("#sizeUseYnCd").focus();
            return false;
        }
        
		if( sideView == "edit" ) {
			url = '<c:url value="bm/sizeUpdate"/>';
		} else {
			url = '<c:url value="bm/sizeCreate"/>';
		}

		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'					:		menuAuth,
            	'sizeCondCd'				: 		$('#sizeForm input[name=sizeCondCd]').val(),
            	'sizeCondNm'				: 		$('#sizeForm input[name=sizeCondNm]').val(),
            	'wpLeftCond'				: 		$('#sizeForm input[name=wpLeftCond]').val(),
            	'wpLeftAlwncePlus'			: 		$('#sizeForm input[name=wpLeftAlwncePlus]').val(),
            	'wpLeftAlwnceMinus'			: 		$('#sizeForm input[name=wpLeftAlwnceMinus]').val(),
            	'wpRightCond'				: 		$('#sizeForm input[name=wpRightCond]').val(),
            	'wpRightAlwncePlus'			: 		$('#sizeForm input[name=wpRightAlwncePlus]').val(),
            	'wpRightAlwnceMinus'		: 		$('#sizeForm input[name=wpRightAlwnceMinus]').val(),
            	'pitchLeftCond'				: 		$('#sizeForm input[name=pitchLeftCond]').val(),
            	'pitchLeftAlwncePlus'		: 		$('#sizeForm input[name=pitchLeftAlwncePlus]').val(),
            	'pitchLeftAlwnceMinus'		: 		$('#sizeForm input[name=pitchLeftAlwnceMinus]').val(),
            	'pitchRightCond'			: 		$('#sizeForm input[name=pitchRightCond]').val(),
            	'pitchRightAlwncePlus'		: 		$('#sizeForm input[name=pitchRightAlwncePlus]').val(),
            	'pitchRightAlwnceMinus'		: 		$('#sizeForm input[name=pitchRightAlwnceMinus]').val(),
            	'ppfWingLeftCond'			: 		$('#sizeForm input[name=ppfWingLeftCond]').val(),
            	'ppfWingLeftAlwncePlus'		: 		$('#sizeForm input[name=ppfWingLeftAlwncePlus]').val(),
            	'ppfWingLeftAlwnceMinus'	: 		$('#sizeForm input[name=ppfWingLeftAlwnceMinus]').val(),
            	'ppfWingRightCond'			: 		$('#sizeForm input[name=ppfWingRightCond]').val(),
            	'ppfWingRightAlwncePlus'	: 		$('#sizeForm input[name=ppfWingRightAlwncePlus]').val(),
            	'ppfWingRightAlwnceMinus'	: 		$('#sizeForm input[name=ppfWingRightAlwnceMinus]').val(),
            	'ppfDepthLeftCond'			: 		$('#sizeForm input[name=ppfDepthLeftCond]').val(),
            	'ppfDepthLeftAlwncePlus'	: 		$('#sizeForm input[name=ppfDepthLeftAlwncePlus]').val(),
            	'ppfDepthLeftAlwnceMinus'	: 		$('#sizeForm input[name=ppfDepthLeftAlwnceMinus]').val(),
            	'ppfDepthRightCond'			: 		$('#sizeForm input[name=ppfDepthRightCond]').val(),
            	'ppfDepthRightAlwncePlus'	: 		$('#sizeForm input[name=ppfDepthRightAlwncePlus]').val(),
            	'ppfDepthRightAlwnceMinus'	: 		$('#sizeForm input[name=ppfDepthRightAlwnceMinus]').val(),
            	'filmCond'					: 		$('#sizeForm input[name=filmCond]').val(),
            	'filmAlwncePlus'			: 		$('#sizeForm input[name=filmAlwncePlus]').val(),
            	'filmAlwnceMinus'			: 		$('#sizeForm input[name=filmAlwnceMinus]').val(),
            	'metalDepthCond'			: 		$('#sizeForm input[name=metalDepthCond]').val(),
            	'metalDepthAlwncePlus'		: 		$('#sizeForm input[name=metalDepthAlwncePlus]').val(),
            	'metalDepthAlwnceMinus'		: 		$('#sizeForm input[name=metalDepthAlwnceMinus]').val(),        	            	


            	'wpCenterCond'              :		$('#sizeForm input[name=wpCenterCond]').val(),
            	'wpCenterAlwncePlus'        :       $('#sizeForm input[name=wpCenterAlwncePlus]').val(),
            	'wpCenterAlwnceMinus'       :       $('#sizeForm input[name=wpCenterAlwnceMinus]').val(),
            	'ppfDepthCenterCond'        :       $('#sizeForm input[name=ppfDepthCenterCond]').val(),
            	'ppfDepthCenterAlwncePlus'  :       $('#sizeForm input[name=ppfDepthCenterAlwncePlus]').val(),
            	'ppfDepthCenterAlwnceMinus' :       $('#sizeForm input[name=ppfDepthCenterAlwnceMinus]').val(),
            	'wpDeviationCond'           :       $('#sizeForm input[name=wpDeviationCond]').val(),
            	'wpDeviationAlwncePlus'     :       $('#sizeForm input[name=wpDeviationAlwncePlus]').val(),
            	'wpDeviationAlwnceMinus'    :       $('#sizeForm input[name=wpDeviationAlwnceMinus]').val(),
            	'x1X2Cond'                  :       $('#sizeForm input[name=x1X2Cond]').val(),
            	'x1X2AlwncePlus'            :       $('#sizeForm input[name=x1X2AlwncePlus]').val(),
            	'x1X2AlwnceMinus'           :       $('#sizeForm input[name=x1X2AlwnceMinus]').val(),

            	'metalThicknessCond'		: 		$('#sizeForm2 input[name=metalThicknessCond]').val(),
            	'metalThicknessAlwncePlus'	: 		$('#sizeForm2 input[name=metalThicknessAlwncePlus]').val(),
            	'metalThicknessAlwnceMinus'	: 		$('#sizeForm2 input[name=metalThicknessAlwnceMinus]').val(),
            	'thCenterCond'				: 		$('#sizeForm2 input[name=thCenterCond]').val(),
            	'thCenterAlwncePlus'		: 		$('#sizeForm2 input[name=thCenterAlwncePlus]').val(),
            	'thCenterAlwnceMinus'		: 		$('#sizeForm2 input[name=thCenterAlwnceMinus]').val(),
            	'thEdgeCond'				: 		$('#sizeForm2 input[name=thEdgeCond]').val(),
            	'thEdgeAlwncePlus'			: 		$('#sizeForm2 input[name=thEdgeAlwncePlus]').val(),
            	'thEdgeAlwnceMinus'			: 		$('#sizeForm2 input[name=thEdgeAlwnceMinus]').val(),
            	'burrCond'					: 		$('#sizeForm2 input[name=burrCond]').val(),
            	'burrAlwncePlus'			: 		$('#sizeForm2 input[name=burrAlwncePlus]').val(),
            	'burrAlwnceMinus'			: 		$('#sizeForm2 input[name=burrAlwnceMinus]').val(),
            	'gapOfLayerCond'			: 		$('#sizeForm2 input[name=gapOfLayerCond]').val(),
            	'gapOfLayerPlus'			: 		$('#sizeForm2 input[name=gapOfLayerPlus]').val(),
            	'gapOfLayerMinus'			: 		$('#sizeForm2 input[name=gapOfLayerMinus]').val(),            	
            	'thEdgeRightCond'           :       $('#sizeForm2 input[name=thEdgeRightCond]').val(),
            	'thEdgeRightAlwncePlus'     :       $('#sizeForm2 input[name=thEdgeRightAlwncePlus]').val(),
            	'thEdgeRightAlwnceMinus'    :       $('#sizeForm2 input[name=thEdgeRightAlwnceMinus]').val(),
            	'bendingCond'               :       $('#sizeForm2 input[name=bendingCond]').val(),
            	'bendingAlwncePlus'         :       $('#sizeForm2 input[name=bendingAlwncePlus]').val(),
            	'bendingAlwnceMinus'		:       $('#sizeForm2 input[name=bendingAlwnceMinus]').val(),

            	'useYnCd'					: 		$('#sizeForm select[name=useYnCd]').val(),
            },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					if( sideView == "edit" ) {
						toastr.success('수정되었습니다.');
					} else {
						toastr.success('등록되었습니다.');
					}
					//등록된 치수코드&정보들 뿌려주기
					$('#sizeForm input[name="sizeCondCd"]').val(data.sizeCondCd);
					$('#sizeForm input[name="sizeCondNm"]').val(data.sizeCondNm);
					$('#sizeForm2 input[name="sizeCondCd2"]').val(data.sizeCondCd);
					$('#sizeForm2 input[name="sizeCondNm2"]').val(data.sizeCondNm);
					//$('#sizeForm input[name="wpLeftCond"]').val(data.wpLeftCond);
					//$('#sizeForm input[name="wpLeftAlwncePlus"]').val(data.wpLeftAlwncePlus);
					//$('#sizeForm input[name="wpLeftAlwnceMinus"]').val(data.wpLeftAlwnceMinus);
					//$('#sizeForm input[name="wpRightCond"]').val(data.wpRightCond);
					//$('#sizeForm input[name="wpRightAlwncePlus"]').val(data.wpRightAlwncePlus);
					//$('#sizeForm input[name="wpRightAlwnceMinus"]').val(data.wpRightAlwnceMinus);
					//$('#sizeForm input[name="pitchLeftCond"]').val(data.pitchLeftCond);
					//$('#sizeForm input[name="pitchLeftAlwncePlus"]').val(data.pitchLeftAlwncePlus);
					//$('#sizeForm input[name="pitchLeftAlwnceMinus"]').val(data.pitchLeftAlwnceMinus);
					//$('#sizeForm input[name="pitchRightCond"]').val(data.pitchRightCond);
					//$('#sizeForm input[name="pitchRightAlwncePlus"]').val(data.pitchRightAlwncePlus);
					//$('#sizeForm input[name="pitchRightAlwnceMinus"]').val(data.pitchRightAlwnceMinus);
					//$('#sizeForm input[name="ppfWingLeftCond"]').val(data.ppfWingLeftCond);
					//$('#sizeForm input[name="ppfWingLeftAlwncePlus"]').val(data.ppfWingLeftAlwncePlus);
					//$('#sizeForm input[name="ppfWingLeftAlwnceMinus"]').val(data.ppfWingLeftAlwnceMinus);
					//$('#sizeForm input[name="ppfWingRightCond"]').val(data.ppfWingRightCond);
					//$('#sizeForm input[name="ppfWingRightAlwncePlus"]').val(data.ppfWingRightAlwncePlus);
					//$('#sizeForm input[name="ppfWingRightAlwnceMinus"]').val(data.ppfWingRightAlwnceMinus);
					//$('#sizeForm input[name="ppfDepthLeftCond"]').val(data.ppfDepthLeftCond);
					//$('#sizeForm input[name="ppfDepthLeftAlwncePlus"]').val(data.ppfDepthLeftAlwncePlus);
					//$('#sizeForm input[name="ppfDepthLeftAlwnceMinus"]').val(data.ppfDepthLeftAlwnceMinus);
					//$('#sizeForm input[name="ppfDepthRightCond"]').val(data.ppfDepthRightCond);
					//$('#sizeForm input[name="ppfDepthRightAlwncePlus"]').val(data.ppfDepthRightAlwncePlus);
					//$('#sizeForm input[name="ppfDepthRightAlwnceMinus"]').val(data.ppfDepthRightAlwnceMinus);
					//$('#sizeForm input[name="filmCond"]').val(data.filmCond);
					//$('#sizeForm input[name="filmAlwncePlus"]').val(data.filmAlwncePlus);
					//$('#sizeForm input[name="filmAlwnceMinus"]').val(data.filmAlwnceMinus);
					//$('#sizeForm input[name="metalDepthCond"]').val(data.metalDepthCond);
					//$('#sizeForm input[name="metalDepthAlwncePlus"]').val(data.metalDepthAlwncePlus);
					//$('#sizeForm input[name="metalDepthAlwnceMinus"]').val(data.metalDepthAlwnceMinus);
					//$('#sizeForm input[name="metalThicknessCond"]').val(data.metalThicknessCond);
					//$('#sizeForm input[name="metalThicknessAlwncePlus"]').val(data.metalThicknessAlwncePlus);
					//$('#sizeForm input[name="metalThicknessAlwnceMinus"]').val(data.metalThicknessAlwnceMinus);
					//$('#sizeForm input[name="thCenterCond"]').val(data.thCenterCond);
					//$('#sizeForm input[name="thCenterAlwncePlus"]').val(data.thCenterAlwncePlus);
					//$('#sizeForm input[name="thCenterAlwnceMinus"]').val(data.thCenterAlwnceMinus);
					//$('#sizeForm input[name="thEdgeCond"]').val(data.thEdgeCond);
					//$('#sizeForm input[name="thEdgeAlwncePlus"]').val(data.thEdgeAlwncePlus);
					//$('#sizeForm input[name="thEdgeAlwnceMinus"]').val(data.thEdgeAlwnceMinus);
					//$('#sizeForm input[name="burrCond"]').val(data.burrCond);
					//$('#sizeForm input[name="burrAlwncePlus"]').val(data.burrAlwncePlus);					
	                //selectBoxAppend(useYnCd, "sizeUseYnCd", data.useYnCd, "");
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#bomList').DataTable().ajax.reload();
				$('#sizeFormBox').removeClass('d-none');
				$('#sizeFormBox2').removeClass('d-none');				
		        $('#sizeBtnEdit').attr('disabled', false);
		        $('#sizeBtnSave').attr('disabled', true);		        
		        $('#sizeBtnSave').addClass('d-none');
		        sizeForm(true);
		        $('#sizeSizeCondCd2').attr('disabled',true);
			    $('#sizeSizeCondNm2').attr('disabled',true);
			}
		});
	});

	//온도 View 컨트롤
   	function tempaturForm(flag)
   	{
   		$("#tempaturTempaturCondNm").attr("disabled",flag);
   		$("#tempaturWarmupCond").attr("disabled",flag);
   		$("#tempaturWarmupAlwncePlus").attr("disabled",flag);
   		$("#tempaturWarmupAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFitup1UpCond").attr("disabled",flag);
   		$("#tempaturFitup1UpAlwncePlus").attr("disabled",flag);
   		$("#tempaturFitup1UpAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFitup1DownCond").attr("disabled",flag);
   		$("#tempaturFitup1DownAlwncePlus").attr("disabled",flag);
   		$("#tempaturFitup1DownAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFitup2UpleftCond").attr("disabled",flag);
   		$("#tempaturFitup2UpleftAlwncePlus").attr("disabled",flag);
   		$("#tempaturFitup2UpleftAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFitup2DownleftCond").attr("disabled",flag);
   		$("#tempaturFitup2DownleftAlwncePlus").attr("disabled",flag);
   		$("#tempaturFitup2DownleftAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFitup2UprightCond").attr("disabled",flag);
   		$("#tempaturFitup2UprightAlwncePlus").attr("disabled",flag);
   		$("#tempaturFitup2UprightAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFitup2DownrightCond").attr("disabled",flag);
   		$("#tempaturFitup2DownrightAlwncePlus").attr("disabled",flag);
   		$("#tempaturFitup2DownrightAlwnceMinus").attr("disabled",flag);

   		$("#tempaturPush1UpCond").attr("disabled",flag);
   		$("#tempaturPush1UpAlwncePlus").attr("disabled",flag);
   		$("#tempaturPush1UpAlwnceMinus").attr("disabled",flag);
   		$("#tempaturPush1DownCond").attr("disabled",flag);
   		$("#tempaturPush1DownAlwncePlus").attr("disabled",flag);
   		$("#tempaturPush1DownAlwnceMinus").attr("disabled",flag);
   		
   		$("#tempaturRollheatUpCond").attr("disabled",flag);
   		$("#tempaturRollheatUpAlwncePlus").attr("disabled",flag);
   		$("#tempaturRollheatUpAlwnceMinus").attr("disabled",flag);
   		$("#tempaturRollheatDownCond").attr("disabled",flag);
   		$("#tempaturRollheatDownAlwncePlus").attr("disabled",flag);
   		$("#tempaturRollheatDownAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFirstUpleftCond").attr("disabled",flag);
   		$("#tempaturFirstUpleftAlwncePlus").attr("disabled",flag);
   		$("#tempaturFirstUpleftAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFirstDownleftCond").attr("disabled",flag);
   		$("#tempaturFirstDownleftAlwncePlus").attr("disabled",flag);
   		$("#tempaturFirstDownleftAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFirstUprightCond").attr("disabled",flag);
   		$("#tempaturFirstUprightAlwncePlus").attr("disabled",flag);
   		$("#tempaturFirstUprightAlwnceMinus").attr("disabled",flag);
   		$("#tempaturFirstDownrightCond").attr("disabled",flag);
   		$("#tempaturFirstDownrightAlwncePlus").attr("disabled",flag);
   		$("#tempaturFirstDownrightAlwnceMinus").attr("disabled",flag);
   		$("#tempaturSecondUpleftCond").attr("disabled",flag);
   		$("#tempaturSecondUpleftAlwncePlus").attr("disabled",flag);
   		$("#tempaturSecondUpleftAlwnceMinus").attr("disabled",flag);
   		$("#tempaturSecondDownleftCond").attr("disabled",flag);
   		$("#tempaturSecondDownleftAlwncePlus").attr("disabled",flag);
   		$("#tempaturSecondDownleftAlwnceMinus").attr("disabled",flag);
   		$("#tempaturSecondUprightCond").attr("disabled",flag);
   		$("#tempaturSecondUprightAlwncePlus").attr("disabled",flag);
   		$("#tempaturSecondUprightAlwnceMinus").attr("disabled",flag);
   		$("#tempaturSecondDownrightCond").attr("disabled",flag);
   		$("#tempaturSecondDownrightAlwncePlus").attr("disabled",flag);
   		$("#tempaturSecondDownrightAlwnceMinus").attr("disabled",flag);
   		$("#tempaturThirdUpleftCond").attr("disabled",flag);
   		$("#tempaturThirdUpleftAlwncePlus").attr("disabled",flag);
   		$("#tempaturThirdUpleftAlwnceMinus").attr("disabled",flag);
   		$("#tempaturThirdDownleftCond").attr("disabled",flag);
   		$("#tempaturThirdDownleftAlwncePlus").attr("disabled",flag);
   		$("#tempaturThirdDownleftAlwnceMinus").attr("disabled",flag);
   		$("#tempaturThirdUprightCond").attr("disabled",flag);
   		$("#tempaturThirdUprightAlwncePlus").attr("disabled",flag);
   		$("#tempaturThirdUprightAlwnceMinus").attr("disabled",flag);
   		$("#tempaturThirdDownrightCond").attr("disabled",flag);
   		$("#tempaturThirdDownrightAlwncePlus").attr("disabled",flag);
   		$("#tempaturThirdDownrightAlwnceMinus").attr("disabled",flag);
   		$("#tempaturJinjeop1UpCond").attr("disabled",flag);
   		$("#tempaturJinjeop1UpAlwncePlus").attr("disabled",flag);
   		$("#tempaturJinjeop1UpAlwnceMinus").attr("disabled",flag);
   		$("#tempaturJinjeop1DownCond").attr("disabled",flag);
   		$("#tempaturJinjeop1DownAlwncePlus").attr("disabled",flag);
   		$("#tempaturJinjeop1DownAlwnceMinus").attr("disabled",flag);
   		$("#tempaturJinjeop2UpCond").attr("disabled",flag);
   		$("#tempaturJinjeop2UpAlwncePlus").attr("disabled",flag);
   		$("#tempaturJinjeop2UpAlwnceMinus").attr("disabled",flag);
   		$("#tempaturJinjeop2DownCond").attr("disabled",flag);
   		$("#tempaturJinjeop2DownAlwncePlus").attr("disabled",flag);
   		$("#tempaturJinjeop2DownAlwnceMinus").attr("disabled",flag);
   		$("#tempaturUseYnCd").attr("disabled",flag);
   	}

	//시간 View 컨트롤
   	function timeForm(flag)
   	{
   		$("#timeTimeCondNm").attr("disabled",flag);
   		$("#timeWarmupCond").attr("disabled",flag);
   		$("#timeWarmupAlwncePlus").attr("disabled",flag);
   		$("#timeWarmupAlwnceMinus").attr("disabled",flag);
   		$("#timeFitupCond").attr("disabled",flag);
   		$("#timeFitupAlwncePlus").attr("disabled",flag);
   		$("#timeFitupAlwnceMinus").attr("disabled",flag);
   		$("#timeFitup2Cond").attr("disabled",flag);
   		$("#timeFitup2AlwncePlus").attr("disabled",flag);
   		$("#timeFitup2AlwnceMinus").attr("disabled",flag);
   		$("#timeFirstCond").attr("disabled",flag);
   		$("#timeFirstAlwncePlus").attr("disabled",flag);
   		$("#timeFirstAlwnceMinus").attr("disabled",flag);
   		$("#timeSecondCond").attr("disabled",flag);
   		$("#timeSecondAlwncePlus").attr("disabled",flag);
   		$("#timeSecondAlwnceMinus").attr("disabled",flag);

   		$("#timeThirdCond").attr("disabled",flag);
   		$("#timeThirdAlwncePlus").attr("disabled",flag);
   		$("#timeThirdAlwnceMinus").attr("disabled",flag);
   		
   		$("#timeJinjeopCond").attr("disabled",flag);
   		$("#timeJinjeopAlwncePlus").attr("disabled",flag);
   		$("#timeJinjeopAlwnceMinus").attr("disabled",flag);

   		$("#timeJinjeop2Cond").attr("disabled",flag);
   		$("#timeJinjeop2AlwncePlus").attr("disabled",flag);
   		$("#timeJinjeop2AlwnceMinus").attr("disabled",flag);
   		$("#timePush1Cond").attr("disabled",flag);
   		$("#timePush1AlwncePlus").attr("disabled",flag);
   		$("#timePush1AlwnceMinus").attr("disabled",flag);
   		
   		$("#timeReformCond").attr("disabled",flag);
   		$("#timeReformAlwncePlus").attr("disabled",flag);
   		$("#timeReformAlwnceMinus").attr("disabled",flag);

   		$("#timeCoolCond").attr("disabled",flag);
   		$("#timeCoolAlwncePlus").attr("disabled",flag);
   		$("#timeCoolAlwnceMinus").attr("disabled",flag);
   		$("#timeUseYnCd").attr("disabled",flag);
   	}

	//압력 View 컨트롤
   	function pressureForm(flag)
   	{
   		$("#pressurePressureCondNm").attr("disabled",flag);
   		$("#pressureWarmupCond").attr("disabled",flag);
   		$("#pressureWarmupAlwncePlus").attr("disabled",flag);
   		$("#pressureWarmupAlwnceMinus").attr("disabled",flag);
   		$("#pressureFitupCond").attr("disabled",flag);
   		$("#pressureFitupAlwncePlus").attr("disabled",flag);
   		$("#pressureFitupAlwnceMinus").attr("disabled",flag);
   		//$("#pressureFirstCond").attr("disabled",flag);
   		//$("#pressureFirstAlwncePlus").attr("disabled",flag);
   		//$("#pressureFirstAlwnceMinus").attr("disabled",flag);
   		
   		$("#pressurePush1Cond").attr("disabled",flag);       
   		$("#pressurePush1AlwncePlus").attr("disabled",flag); 
   		$("#pressurePush1AlwnceMinus").attr("disabled",flag);
   		
   		//$("#pressureSecondCond").attr("disabled",flag);
   		//$("#pressureSecondAlwncePlus").attr("disabled",flag);
   		//$("#pressureSecondAlwnceMinus").attr("disabled",flag);
   		$("#pressureJinjeopCond").attr("disabled",flag);
   		$("#pressureJinjeopAlwncePlus").attr("disabled",flag);
   		$("#pressureJinjeopAlwnceMinus").attr("disabled",flag);

   		$("#pressureJinjeop2Cond").attr("disabled",flag);
   		$("#pressureJinjeop2AlwncePlus").attr("disabled",flag);
   		$("#pressureJinjeop2AlwnceMinus").attr("disabled",flag);

   		$("#pressureReformCond").attr("disabled",flag);
   		$("#pressureReformAlwncePlus").attr("disabled",flag);
   		$("#pressureReformAlwnceMinus").attr("disabled",flag);
   		//$("#pressureCoolCond").attr("disabled",flag);
   		//$("#pressureCoolAlwncePlus").attr("disabled",flag);
   		//$("#pressureCoolAlwnceMinus").attr("disabled",flag);
   		$("#pressureUseYnCd").attr("disabled",flag);
   	}

	//치수 View 컨트롤
	function sizeForm(flag)
	{
		$("#sizeSizeCondNm").attr("disabled",flag);
		$("#sizeWpLeftCond").attr("disabled",flag);
		$("#sizeWpLeftAlwncePlus").attr("disabled",flag);
		$("#sizeWpLeftAlwnceMinus").attr("disabled",flag);
		$("#sizeWpRightCond").attr("disabled",flag);
		$("#sizeWpRightAlwncePlus").attr("disabled",flag);
		$("#sizeWpRightAlwnceMinus").attr("disabled",flag);
		$("#sizePitchLeftCond").attr("disabled",flag);
		$("#sizePitchLeftAlwncePlus").attr("disabled",flag);
		$("#sizePitchLeftAlwnceMinus").attr("disabled",flag);
		$("#sizePitchRightCond").attr("disabled",flag);
		$("#sizePitchRightAlwncePlus").attr("disabled",flag);
		$("#sizePitchRightAlwnceMinus").attr("disabled",flag);
		$("#sizePpfWingLeftCond").attr("disabled",flag);
		$("#sizePpfWingLeftAlwncePlus").attr("disabled",flag);
		$("#sizePpfWingLeftAlwnceMinus").attr("disabled",flag);
		$("#sizePpfWingRightCond").attr("disabled",flag);
		$("#sizePpfWingRightAlwncePlus").attr("disabled",flag);
		$("#sizePpfWingRightAlwnceMinus").attr("disabled",flag);
		$("#sizePpfDepthLeftCond").attr("disabled",flag);
		$("#sizePpfDepthLeftAlwncePlus").attr("disabled",flag);
		$("#sizePpfDepthLeftAlwnceMinus").attr("disabled",flag);
		$("#sizePpfDepthRightCond").attr("disabled",flag);
		$("#sizePpfDepthRightAlwncePlus").attr("disabled",flag);
		$("#sizePpfDepthRightAlwnceMinus").attr("disabled",flag);
		$("#sizeFilmCond").attr("disabled",flag);
		$("#sizeFilmAlwncePlus").attr("disabled",flag);
		$("#sizeFilmAlwnceMinus").attr("disabled",flag);
		$("#sizeMetalDepthCond").attr("disabled",flag);
		$("#sizeMetalDepthAlwncePlus").attr("disabled",flag);
		$("#sizeMetalDepthAlwnceMinus").attr("disabled",flag);
		$("#sizeMetalThicknessCond").attr("disabled",flag);
		$("#sizeMetalThicknessAlwncePlus").attr("disabled",flag);
		$("#sizeMetalThicknessAlwnceMinus").attr("disabled",flag);
		$("#sizeThCenterCond").attr("disabled",flag);
		$("#sizeThCenterAlwncePlus").attr("disabled",flag);
		$("#sizeThCenterAlwnceMinus").attr("disabled",flag);
		$("#sizeThEdgeCond").attr("disabled",flag);
		$("#sizeThEdgeAlwncePlus").attr("disabled",flag);
		$("#sizeThEdgeAlwnceMinus").attr("disabled",flag);
		$("#sizeBurrCond").attr("disabled",flag);
		$("#sizeBurrAlwncePlus").attr("disabled",flag);
		$("#sizeBurrAlwnceMinus").attr("disabled",flag);
		$("#sizeGapOfLayerCond").attr("disabled",flag);
		$("#sizeGapOfLayerPlus").attr("disabled",flag);
		$("#sizeGapOfLayerMinus").attr("disabled",flag);
		$("#sizeUseYnCd").attr("disabled",flag);


		$("#sizeWpCenterCond").attr("disabled",flag);             
		$("#sizeWpCenterAlwncePlus").attr("disabled",flag);       
		$("#sizeWpCenterAlwnceMinus").attr("disabled",flag);      
		$("#sizePpfDepthCenterCond").attr("disabled",flag);       
		$("#sizePpfDepthCenterAlwncePlus").attr("disabled",flag); 
		$("#sizePpfDepthCenterAlwnceMinus").attr("disabled",flag);
		$("#sizeWpDeviationCond").attr("disabled",flag);          
		$("#sizeWpDeviationAlwncePlus").attr("disabled",flag);    
		$("#sizeWpDeviationAlwnceMinus").attr("disabled",flag);   
		$("#sizeX1X2Cond").attr("disabled",flag);                 
		$("#sizeX1X2AlwncePlus").attr("disabled",flag);           
		$("#sizeX1X2AlwnceMinus").attr("disabled",flag);          
		$("#sizeThEdgeRightCond").attr("disabled",flag);          
		$("#sizeThEdgeRightAlwncePlus").attr("disabled",flag);    
		$("#sizeThEdgeRightAlwnceMinus").attr("disabled",flag);   
		$("#sizeBendingCond").attr("disabled",flag);              
		$("#sizeBendingAlwncePlus").attr("disabled",flag);        
		$("#sizeBendingAlwnceMinus").attr("disabled",flag);			


		
	}
	

</script>
</body>
</html>