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
                <li class="breadcrumb-item">
                  <a href="#">설비관리</a>
                </li>
                <li class="breadcrumb-item active">제조조건관리</li>
               </ol>
              </nav>
             </header>      
          <!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list left-60" id="left-60" style="width:15%;">
                      <div class="card">
                          <div class="table-responsive">
		                    <table id="equipCodeAdmTable" class="table table-bordered">
		                        <thead class="thead-light">
		                        <tr>
								<th style="min-width:50px">설비코드</th>
								<th style="min-width:40px">설비명</th>
	                            </tr>
		                        </thead>
                              </table>
                          </div>
                      </div>
                  </div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
                    <div class="right-list right-40" id="myrSidenav" style="width:84%;">
						<div class="card" id="formBox"> 
	            	<!-- 제조조건 리스트 -->
					<div id="viewBox">
						<table class="table table-bordered" id="manufacturerListTable">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 50px">등록일자</th>
									<th style="min-width: 60px">제조조건코드</th>
									<th style="min-width: 50px">제품코드</th>
									<th style="min-width: 35px">제품명</th>
									<th style="min-width: 25px">재질</th>
									<th style="min-width: 200px">규격</th>
									<th style="min-width: 25px">두께</th>
									<th style="min-width: 10px">폭</th>
									<th style="min-width: 25px">너비</th>
									<th style="min-width: 25px">길이</th>
									<th style="min-width: 25px">피치</th>
									<th style="min-width: 25px">필름</th>
									<!-- <th style="min-width: 110px">규격</th> -->
									<th style="min-width: 25px">두께</th>
									<th style="min-width: 25px">폭</th>
									<th style="min-width: 70px">비고</th>
									<th style="min-width: 25px">FP사용</th>
									<th style="min-width: 70px">메인구분</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- 제조조건 리스트 끝 -->
				<div >
					<div id="addForm" class="d-none"> 
						<form id="addForm">
						<br>
							<table class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th style="min-width:100px">설비코드</th>
										<th style="min-width:100px">제품코드</th>
										<th style="min-width:130px">제품명</th>
										<th style="min-width:30px">재질</th>
										<th style="min-width:220px">규격</th>
										<th style="min-width:50px">두께</th>
										<th style="min-width:50px">폭</th>
										<th style="min-width:50px">너비</th>
										<th style="min-width:50px">길이</th>
										<th style="min-width:50px">피치</th>
										<th style="min-width:60px">필름</th>
										<!-- <th style="min-width:130px">규격</th> -->
										<th style="min-width:60px">두께</th>
										<th style="min-width:60px">폭</th>
										<th>비고</th>
										<th>FP사용</th>
										<th>메인구분</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td align="center"><span id="addFormEquipCd"></span><!-- <input type="text" class="form-control" id="addFormEquipCd" name="equipCd" style="min-width: 100px" disabled> --></td>
										<td align="center"><span id="addFormGoodsCd"></span></td>
										<td align="center"><!-- <input type="text" class="form-control" id="addFormGoodsNm" disabled> -->
											<div class="input-sub m-0">
												<input type="text" class="form-control" id="addFormGoodsNm" disabled >
												<button type="button" class="btn btn-primary input-sub-search" id="btnSelectMatrlCode" onClick="selectGoodsCode()" disabled>
													<span class="oi oi-magnifying-glass"></span>
												</button>
											</div>										
										</td>
										<td align="center"><span id="addFormQutyNm"></span></td>										
										<td align="center"><span id="addFormModel"></span></td>
										<td align="right"><span id="addFormAlniThickness"></span></td>
										<td align="right"><span id="addFormAlniDepth"></span></td>
										<td align="right"><span id="addFormAlniWidth"></span></td>
										<td align="right"><span id="addFormAlniLength"></span></td>
										<td align="right"><span id="addFormAlniPtich"></span></td>
										<td align="center"><span id="addFormFilmQutyNm"></span></td>
										<td align="right"><span id="addFormFilmThickness"></span></td>
										<td align="right"><span id="addFormFilmDepth"></span></td>
										<td align="center"><span id="addFormFilmMatrlDesc"></span></td>
										<td align="center">
											<select id="fpUseYn" class="custom-select" disabled>
												<option value="001">사용</option>
												<option value="002">미사용</option>			
											</select>
										</td>
										<td align="center">
											<input type="checkbox" id="fpMainGubun" name="fpMainGubun" style="width:20px; height:20px" disabled>										
										</td>
									</tr>
								</tbody>
							</table>
						</form>
						<div class="mt-2">
							<button type="button" class="btn btn-primary" id="tempaturBtn" onClick="tempaturList()" disabled>온도 선택</button>
							<button type="button" class="btn btn-primary" id="timeBtn" onClick="timeList()" disabled>시간 선택</button>
							<button type="button" class="btn btn-primary" id="pressureBtn" onClick="pressureList()" disabled>압력 선택</button>
							<button type="button" class="btn btn-primary" id="sizeBtn" onClick="sizeList()" disabled>치수 선택</button>
					
							<input type="hidden" id="hiddenEquipCondSeq" name="equipCondSeq">
							<button type="button" class="btn btn-secondary float-right mr-2" id="btnClose">닫기</button>
							<button type="button" class="btn btn-primary float-right mr-2"	 id="btnEdit">수정</button>
							<button type="button" class="btn btn-primary float-right mr-2"	 id="btnSave">저장</button>
						</div>
						<br>
					
						<form id="tempatur">
							<table class="table table-bordered">
								<tr>
									<th rowspan="2" style="min-width:40px">구분		</th>
									<th colspan="21" style="min-width:40px">온도(°C)	</th>
								</tr>
								<tr>
									<th style="min-width:40px">예열</th>
									<th style="min-width:40px">가접1-상</th>
									<th style="min-width:40px">가접1-하</th>
									<th style="min-width:50px">가접2-상좌</th>
									<th style="min-width:50px">가접2-하좌</th>
									<th style="min-width:50px">가접2-상우</th>
									<th style="min-width:50px">가접2-하우</th>
									<th style="min-width:40px">롤히터-상</th>
									<th style="min-width:40px">롤히터-하</th>
									<th style="min-width:40px">1차-상좌</th>
									<th style="min-width:40px">1차-하좌</th>
									<th style="min-width:40px">1차-상우</th>
									<th style="min-width:40px">1차-하우</th>
									<th style="min-width:40px">2차-상좌</th>
									<th style="min-width:40px">2차-하좌</th>
									<th style="min-width:40px">2차-상우</th>
									<th style="min-width:40px">2차-하우</th>
									<th style="min-width:40px">3차-상좌</th>
									<th style="min-width:40px">3차-하좌</th>
									<th style="min-width:40px">3차-상우</th>
									<th style="min-width:40px">3차-하우</th>
								</tr>
								<tr>
									<th>조건	</th>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewWarmupCond" 				name="warmupCond" 				style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup1UpCond" 			name="fitup1UpCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup1DownCond" 			name="fitup1DownCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2UpleftCond" 		name="fitup2UpleftCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2DownleftCond" 		name="fitup2DownleftCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2UprightCond" 		name="fitup2UprightCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2DownrightCond" 		name="fitup2DownrightCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewRollheatUpCond" 			name="rollheatUpCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewRollheatDownCond" 		name="rollheatDownCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstUpleftCond" 			name="firstUpleftCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstDownleftCond" 		name="firstDownleftCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstUprightCond" 		name="firstUprightCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstDownrightCond" 		name="firstDownrightCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondUpleftCond" 		name="secondUpleftCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondDownleftCond" 		name="secondDownleftCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondUprightCond" 		name="secondUprightCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondDownrightCond" 		name="secondDownrightCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdUpleftCond" 			name="thirdUpleftCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdDownleftCond" 		name="thirdDownleftCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdUprightCond" 		name="thirdUprightCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdDownrightCond" 		name="thirdDownrightCond" 		style="width:100%;" class="form-control number-float1"></input></td>
								</tr>
								<tr>
									<th>공차 (+)</th>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewWarmupAlwncePlus" 			name="warmupAlwncePlus" 		style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup1UpAlwncePlus" 		name="fitup1UpAlwncePlus" 		style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup1DownAlwncePlus" 		name="fitup1DownAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2UpleftAlwncePlus" 	name="fitup2UpleftAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2DownleftAlwncePlus" 	name="fitup2DownleftAlwncePlus" style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2UprightAlwncePlus" 	name="fitup2UprightAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2DownrightAlwncePlus" name="fitup2DownrightAlwncePlus"style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewRollheatUpAlwncePlus" 		name="rollheatUpAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewRollheatDownAlwncePlus" 	name="rollheatDownAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstUpleftAlwncePlus" 	name="firstUpleftAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstDownleftAlwncePlus" 	name="firstDownleftAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstUprightAlwncePlus" 	name="firstUprightAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstDownrightAlwncePlus" 	name="firstDownrightAlwncePlus" style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondUpleftAlwncePlus" 	name="secondUpleftAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondDownleftAlwncePlus" 	name="secondDownleftAlwncePlus" style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondUprightAlwncePlus" 	name="secondUprightAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondDownrightAlwncePlus" name="secondDownrightAlwncePlus"style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdUpleftAlwncePlus" 	name="thirdUpleftAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdDownleftAlwncePlus" 	name="thirdDownleftAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdUprightAlwncePlus" 	name="thirdUprightAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdDownrightAlwncePlus" 	name="thirdDownrightAlwncePlus" style="width:100%" class="form-control number-float1"></input></td>
								</tr>
								<tr>
									<th>공차 (-)</th>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewWarmupAlwnceMinus"			name="warmupAlwnceMinus" 		style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup1UpAlwnceMinus"		name="fitup1UpAlwnceMinus" 		style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup1DownAlwnceMinus"		name="fitup1DownAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2UpleftAlwnceMinus"	name="fitup2UpleftAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2DownleftAlwnceMinus"	name="fitup2DownleftAlwnceMinus"style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2UprightAlwnceMinus"	name="fitup2UprightAlwnceMinus" style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFitup2DownrightAlwnceMinus"name="fitup2DownrightAlwnceMinus"style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewRollheatUpAlwnceMinus"		name="rollheatUpAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewRollheatDownAlwnceMinus"	name="rollheatDownAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstUpleftAlwnceMinus"	name="firstUpleftAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstDownleftAlwnceMinus"	name="firstDownleftAlwnceMinus" style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstUprightAlwnceMinus"	name="firstUprightAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewFirstDownrightAlwnceMinus"	name="firstDownrightAlwnceMinus"style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondUpleftAlwnceMinus"	name="secondUpleftAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondDownleftAlwnceMinus"	name="secondDownleftAlwnceMinus"style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondUprightAlwnceMinus"	name="secondUprightAlwnceMinus" style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewSecondDownrightAlwnceMinus"name="secondDownrightAlwnceMinus"style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdUpleftAlwnceMinus"	name="thirdUpleftAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdDownleftAlwnceMinus"	name="thirdDownleftAlwnceMinus" style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdUprightAlwnceMinus"	name="thirdUprightAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewThirdDownrightAlwnceMinus"	name="thirdDownrightAlwnceMinus"style="width:100%" class="form-control number-float1"></input></td>
								</tr>
							</table>
							
							
							<table class="table table-bordered">
								<tr>
									<th rowspan="2" style="min-width:40px">구분		</th>
									<th colspan="6" style="min-width:40px">온도(°C)	</th>
									<th colspan="10" style="min-width:40px">시간(SEC)</th>
									<th colspan="4" style="min-width:40px">압력(Mpz)</th>
								</tr>
								<tr>
									<th style="min-width:40px">1차푸셔-상</th>
									<th style="min-width:40px">1차푸셔-하</th>				
									<th style="min-width:40px">1차진접-상</th>
									<th style="min-width:40px">1차진접-하</th>
									<th style="min-width:40px">2차진접-상</th>
									<th style="min-width:40px">2차진접-하</th>									
									<th style="min-width:40px">가접1	</th>
									<th style="min-width:40px">가접2	</th>
									<th style="min-width:40px">1차	</th>
									<th style="min-width:40px">1차푸셔</th>
									<th style="min-width:40px">2차	</th>
									<th style="min-width:40px">3차	</th>
									<th style="min-width:40px">1차진접</th>
									<th style="min-width:40px">2차진접</th>
									<th style="min-width:40px">리폼	</th>
									<th style="min-width:40px">냉각	</th>
									<th style="min-width:40px">가접	</th>
									<th style="min-width:40px">1차푸셔</th>
									<!-- <th style="min-width:40px">2차	</th> -->
									<th style="min-width:40px">1차진접</th>
									<th style="min-width:40px">2차진접</th>
								</tr>
								<tr>
									<th>조건	</th>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewPush1UpCond" 			name="push1UpCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewPush1DownCond" 		name="push1DownCond"		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop1UpCond" 		name="jinjeop1UpCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop1DownCond" 	name="jinjeop1DownCond" 	style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop2UpCond" 		name="jinjeop2UpCond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop2DownCond" 	name="jinjeop2DownCond" 	style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewFitupCond" 				name="fitupCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewFitup2Cond" 				name="fitup2Cond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewFirstCond" 				name="firstCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewPush1Cond" 				name="push1Cond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewSecondCond" 				name="secondCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewThirdCond" 				name="thirdCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewJinjeopCond" 				name="jinjeopCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewJinjeop2Cond" 			name="jinjeop2Cond" 		style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewReformCond" 				name="reformCond" 			style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number"  maxlength="7" min="-1000" max="1000" step="0.01" id="timeViewCoolCond" 				name="coolCond" 			style="width:100%;" class="form-control number-float2"></input></td>
									<td><input type="number"  maxlength="7" min="-1000" max="1000" step="0.01" id="pressureViewFitupCond" 			name="fitupCond" 			style="width:100%;" class="form-control number-float2"></input></td>
									<td><input type="number"  maxlength="7" min="-1000" max="1000" step="0.01" id="pressureViewPush1Cond" 			name="push1Cond" 			style="width:100%;" class="form-control number-float2"></input></td>
									<td><input type="number"  maxlength="7" min="-1000" max="1000" step="0.01" id="pressureViewJinjeopCond" 		name="jinjeopCond" 			style="width:100%;" class="form-control number-float2"></input></td>
									<td><input type="number"  maxlength="7" min="-1000" max="1000" step="0.01" id="pressureViewJinjeop2Cond" 		name="jinjeop2Cond" 		style="width:100%;" class="form-control number-float2"></input></td>
								</tr>
								<tr>
									<th>공차 (+)</th>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewPush1UpAlwncePlus" 	name="push1UpAlwncePlus"	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewPush1DownAlwncePlus" 	name="push1DownAlwncePlus"	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop1UpAlwncePlus" 	name="jinjeop1UpAlwncePlus"	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop1DownAlwncePlus"name="jinjeop1DownAlwncePlus"style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop2UpAlwncePlus" 	name="jinjeop2UpAlwncePlus" style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop2DownAlwncePlus"name="jinjeop2DownAlwncePlus"style="width:100%;" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewFitupAlwncePlus" 			name="fitupAlwncePlus" 		style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewFitup2AlwncePlus" 			name="fitup2AlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewFirstAlwncePlus" 			name="firstAlwncePlus" 		style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewPush1AlwncePlus" 			name="push1AlwncePlus" 		style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewSecondAlwncePlus" 			name="secondAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewThirdAlwncePlus" 			name="thirdAlwncePlus" 		style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewJinjeopAlwncePlus" 		name="jinjeopAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewJinjeop2AlwncePlus" 		name="jinjeop2AlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="timeViewReformAlwncePlus" 			name="reformAlwncePlus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000" step="0.01" id="timeViewCoolAlwncePlus" 			name="coolAlwncePlus" 		style="width:100%" class="form-control number-float2"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000" step="0.01" id="pressureViewFitupAlwncePlus" 		name="fitupAlwncePlus" 		style="width:100%" class="form-control number-float2"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000" step="0.01" id="pressureViewPush1AlwncePlus" 		name="push1AlwncePlus" 		style="width:100%" class="form-control number-float2"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000" step="0.01" id="pressureViewJinjeopAlwncePlus" 	name="jinjeopAlwncePlus"	style="width:100%" class="form-control number-float2"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000" step="0.01" id="pressureViewJinjeop2AlwncePlus" 	name="jinjeop2AlwncePlus"	style="width:100%" class="form-control number-float2"></input></td>
								</tr>
								<tr>
									<th>공차 (-)</th>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewPush1UpAlwnceMinus"	name="push1UpAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewPush1DownAlwnceMinus"	name="push1DownAlwnceMinus"	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop1UpAlwnceMinus"		name="jinjeop1UpAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop1DownAlwnceMinus"	name="jinjeop1DownAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop2UpAlwnceMinus" 	name="jinjeop2UpAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturViewJinjeop2DownAlwnceMinus" 	name="jinjeop2DownAlwnceMinus"	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewFitupAlwnceMinus" 			name="fitupAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewFitup2AlwnceMinus" 			name="fitupAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewFirstAlwnceMinus" 			name="firstAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewPush1AlwnceMinus" 			name="push1AlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewSecondAlwnceMinus" 			name="secondAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewThirdAlwnceMinus" 			name="thirdAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewJinjeopAlwnceMinus" 		name="jinjeopAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewJinjeop2AlwnceMinus" 		name="jinjeop2AlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000"step="0.1" id="timeViewReformAlwnceMinus" 			name="reformAlwnceMinus" 	style="width:100%" class="form-control number-float1"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000"step="0.01" id="timeViewCoolAlwnceMinus" 			name="coolAlwnceMinus" 		style="width:100%" class="form-control number-float2"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000"step="0.01" id="pressureViewFitupAlwnceMinus" 		name="fitupAlwnceMinus" 	style="width:100%" class="form-control number-float2"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000"step="0.01" id="pressureViewPush1AlwnceMinus" 		name="push1AlwnceMinus" 	style="width:100%" class="form-control number-float2"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000"step="0.01" id="pressureViewJinjeopAlwnceMinus"	name="jinjeopAlwnceMinus"	style="width:100%" class="form-control number-float2"></input></td>
									<td><input type="number" maxlength="7" min="-1000" max="1000"step="0.01" id="pressureViewJinjeop2AlwnceMinus"	name="jinjeop2AlwnceMinus"	style="width:100%" class="form-control number-float2"></input></td>
								</tr>
							</table>
						</form>
						
						<form id="size">
							<table class="table table-bordered" id="timeView">
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
								<tr>
									<th>조건	</th>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewMetalDepthCond"			name="metalDepthCond"		style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPitchLeftCond"			name="pitchLeftCond"		style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthLeftCond"		name="ppfDepthLeftCond"		style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthCenterCond"		name="ppfDepthCenterCond"	style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthRightCond"		name="ppfDepthRightCond"	style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewFilmCond"				name="filmCond"				style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpLeftCond"				name="wpLeftCond"			style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpCenterCond"			name="wpCenterCond"			style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpRightCond"				name="wpRightCond"			style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpDeviationCond"			name="wpDeviationCond"		style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewX1X2Cond"				name="x1X2Cond"				style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfWingLeftCond"			name="ppfWingLeftCond"		style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfWingRightCond"		name="ppfWingRightCond"		style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewMetalThicknessCond"		name="metalThicknessCond"	style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThEdgeCond"				name="thEdgeCond"			style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThCenterCond"			name="thCenterCond"			style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThEdgeRightCond"			name="thEdgeRightCond"		style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewBurrCond"				name="burrCond"				style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewGapOfLayerCond"			name="gapOfLayerCond"		style="max-width:100%"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewBendingCond"				name="bendingCond"			style="max-width:100%"  class="form-control number-float3"></input></td>			
								</tr>
								<tr>
									<th>공차 (+)</th>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewMetalDepthAlwncePlus"		name="metalDepthAlwncePlus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPitchLeftAlwncePlus"			name="pitchLeftAlwncePlus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthLeftAlwncePlus"		name="ppfDepthLeftAlwncePlus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthCenterAlwncePlus"	name="ppfDepthCenterAlwncePlus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthRightAlwncePlus"		name="ppfDepthRightAlwncePlus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewFilmAlwncePlus"				name="filmAlwncePlus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpLeftAlwncePlus"			name="wpLeftAlwncePlus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpCenterAlwncePlus"			name="wpCenterAlwncePlus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpRightAlwncePlus"			name="wpRightAlwncePlus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpDeviationAlwncePlus"		name="wpDeviationAlwncePlus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewX1X2AlwncePlus"				name="x1X2AlwncePlus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfWingLeftAlwncePlus"		name="ppfWingLeftAlwncePlus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfWingRightAlwncePlus"		name="ppfWingRightAlwncePlus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewMetalThicknessAlwncePlus"	name="metalThicknessAlwncePlus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThEdgeAlwncePlus"			name="thEdgeAlwncePlus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThCenterAlwncePlus"			name="thCenterAlwncePlus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThEdgeRightAlwncePlus"		name="thEdgeRightAlwncePlus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewBurrAlwncePlus"				name="burrAlwncePlus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewGapOfLayerAlwncePlus"		name="gapOfLayerAlwncePlus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewBendingAlwncePlus"			name="bendingAlwncePlus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
								</tr>
								<tr>
									<th>공차 (-)</th>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewMetalDepthAlwnceMinus"		name="metalDepthAlwnceMinus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPitchLeftAlwnceMinus"		name="pitchLeftAlwnceMinus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthLeftAlwnceMinus"		name="ppfDepthLeftAlwnceMinus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthCenterAlwnceMinus"	name="ppfDepthCenterAlwnceMinus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfDepthRightAlwnceMinus"	name="ppfDepthRightAlwnceMinus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewFilmAlwnceMinus"				name="filmAlwnceMinus"				style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpLeftAlwnceMinus"			name="wpLeftAlwnceMinus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpCenterAlwnceMinus"			name="wpCenterAlwnceMinus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpRightAlwnceMinus"			name="wpRightAlwnceMinus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewWpDeviationAlwnceMinus"		name="wpDeviationAlwnceMinus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewX1X2AlwnceMinus"				name="x1X2AlwnceMinus"				style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfWingLeftAlwnceMinus"		name="ppfWingLeftAlwnceMinus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewPpfWingRightAlwnceMinus"		name="ppfWingRightAlwnceMinus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewMetalThicknessAlwnceMinus"	name="metalThicknessAlwnceMinus"	style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThEdgeAlwnceMinus"			name="thEdgeAlwnceMinus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThCenterAlwnceMinus"			name="thCenterAlwnceMinus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewThEdgeRightAlwnceMinus"		name="thEdgeRightAlwnceMinus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewBurrAlwnceMinus"				name="burrAlwnceMinus"				style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewGapOfLayerAlwnceMinus"		name="gapOfLayerAlwnceMinus"		style="max-width:100%;"  class="form-control number-float3"></input></td>
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewBendingAlwnceMinus"			name="bendingAlwnceMinus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<!-- 상세정보 끝-->
	        </div>
          </div><!-- .right-sidebar -->
      </div><!-- /.row -->
    </div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<!-- 온도 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="tempaturModal" tabindex="-1" role="dialog" aria-labelledby="tempaturModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1300px" >
    <div class="modal-content" >
	      <div class="modal-header">
	        <h5 class="modal-title" id="tempaturPopUpLabel">온도 정보</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body" style="overflow:auto;">
	      	<hr class="text-secondary">	     
	      	    
                <table id="tempaturTable" class="table table-bordered">
                    <thead class="thead-light">
                    <tr>
						<th style="min-width: 60px">온도코드</th>
						<th style="min-width: 60px">온도명</th>
						<th style="min-width: 60px">예열</th>
						<th style="min-width: 60px">가접1-상</th>
						<th style="min-width: 60px">가접1-하</th>
						<th style="min-width: 60px">가접2-상좌</th>
						<th style="min-width: 60px">가접2-하좌</th>
						<th style="min-width: 60px">가접2-상우</th>
						<th style="min-width: 60px">가접2-하우</th>
						<th style="min-width: 60px">롤히터-상</th>
						<th style="min-width: 60px">롤히터-하</th>
						<th style="min-width: 60px">1차-상좌</th>
						<th style="min-width: 60px">1차-하좌</th>
						<th style="min-width: 60px">1차-상우</th>
						<th style="min-width: 60px">1차-하우</th>
						<th style="min-width: 60px">1차-푸셔상</th>
						<th style="min-width: 60px">1차-푸셔하</th>
						<th style="min-width: 60px">2차-상좌</th>
						<th style="min-width: 60px">2차-하좌</th>
						<th style="min-width: 60px">2차-상우</th>
						<th style="min-width: 60px">2차-하우</th>
						<th style="min-width: 60px">3차-상좌</th>
						<th style="min-width: 60px">3차-하좌</th>
						<th style="min-width: 60px">3차-상우</th>
						<th style="min-width: 60px">3차-하우</th>
						<th style="min-width: 60px">1차진접-상</th>
						<th style="min-width: 60px">1차진접-하</th>
						<th style="min-width: 60px">2차진접-상</th>
						<th style="min-width: 60px">2차진접-하</th>
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
<!-- 온도 모달 종료-->
<!-- 시간 모달 시작-->
<!-- <button type="button" class="btn btn-primary"  data-toggle="modal" data-target=".bd-example-modal-lg">제품코드조회</button> -->
<div class="modal fade bd-example-modal-lg" id="timeModal" tabindex="-1" role="dialog" aria-labelledby="timeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1400px">
    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="timePopUpLabel">시간 정보</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body" style="overflow:auto;">
	      	<hr class="text-secondary" style="overflow:auto;">
	      		         
                <table id="timeTable" class="table table-bordered">
                    <thead class="thead-light">
                    <tr>
						<th style="min-width: 50px">시간코드</th>
						<th style="min-width: 50px">시간명</th>
						<!-- <th style="min-width: 50px">예열조건</th> -->
						<th style="min-width: 50px">가접1조건</th>
						<th style="min-width: 50px">가접2조건</th>
						<th style="min-width: 50px">1차조건</th>
						<th style="min-width: 50px">1차푸셔</th>
						<th style="min-width: 50px">2차조건</th>
						<th style="min-width: 50px">3차조건</th>
						<th style="min-width: 50px">1차진접조건</th>
						<th style="min-width: 50px">2차진접조건</th>
						<th style="min-width: 50px">리폼조건</th>
						<th style="min-width: 50px">냉각조건</th>
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
<!-- 시간 모달 종료-->
<!-- 압력 모달 시작-->
<!-- <button type="button" class="btn btn-primary"  data-toggle="modal" data-target=".bd-example-modal-lg">제품코드조회</button> -->
<div class="modal fade bd-example-modal-lg" id="pressureModal" tabindex="-1" role="dialog" aria-labelledby="pressureModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1300px">
    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="pressurePopUpLabel">압력 정보</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body" style="overflow:auto;">
	      	<hr class="text-secondary">	         
	      	
                <table id="pressureTable" class="table table-bordered">
                    <thead class="thead-light">
                    <tr>
						<th style="min-width: 50px">압력코드</th>
						<th style="min-width: 50px">압력명</th>
						<!-- <th style="min-width: 50px">예열조건</th> -->
						<th style="min-width: 50px">가접조건</th>
						<!-- <th style="min-width: 50px">1차조건</th> -->
						<th style="min-width: 50px">1차푸셔</th>
						<!-- <th style="min-width: 50px">2차조건</th> -->
						<th style="min-width: 50px">1차진접조건</th>
						<th style="min-width: 50px">2차진접조건</th>
						<!-- <th style="min-width: 50px">리폼조건</th> -->
						<!-- <th style="min-width: 50px">냉각조건</th> -->
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
<!-- 압력 모달 종료-->
<!-- 치수 모달 시작-->
<!-- <button type="button" class="btn btn-primary"  data-toggle="modal" data-target=".bd-example-modal-lg">제품코드조회</button> -->
<div class="modal fade bd-example-modal-lg" id="sizeModal" tabindex="-1" role="dialog" aria-labelledby="sizeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1300px">
    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="sizePopUpLabel">치수 정보</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body" style="overflow:auto;">
	      	<hr class="text-secondary">	         
	      	
                <table id="sizeTable" class="table table-bordered" style="min-width:1300px">
                    <thead class="thead-light">
                    
						
								<tr>
									<th colspan="2" style="min-width:40px">구분</th>
									<th colspan="13">연동 치수 항목</th>
									<th colspan="7">Manual 측정 치수 항목</th>									
								</tr>								
								<tr>
									<th rowspan="2" style="min-width: 100px">치수코드</th>
									<th rowspan="2" style="min-width: 100px">치수명</th>
									<th style="min-width:100px">Metal 폭</th>
									<th style="min-width:100px">Metal 총길이</th>
									<th style="min-width:100px">Film 폭 (좌)</th>									 
									<th style="min-width:100px">Film 폭 (중)</th>
									<th style="min-width:100px">Film 폭 (우)</th>
									<th style="min-width:100px">Film 총길이</th>
									<th style="min-width:100px">Welding Part (좌)</th>
									<th style="min-width:100px">Welding Part (중)</th>
									<th style="min-width:100px">Welding Part (우)</th>
									<th style="min-width:100px">좌/우 편차</th>
									<th style="min-width:100px">(X1-X2)</th>
									<th style="min-width:100px">날개 Margin (좌)</th>
									<th style="min-width:100px">날개 Margin (우)</th>
									<th style="min-width:100px">Metal 두께</th>
									<th style="min-width:100px">총 두께 (Edge 좌)</th>
									<th style="min-width:100px">총 두께 (Center)</th>
									<th style="min-width:100px">총 두께 (Edge 우)</th>
									<th style="min-width:100px">Metal Burr</th>
									<th style="min-width:100px">Layer</th>
									<th style="min-width:100px">Bending</th>									
								</tr>
								<tr>
									<th style="min-width:100px">d</th>
									<th style="min-width:100px">L</th>
									<th style="min-width:100px">l1</th>						 
									<th style="min-width:100px">l2</th>
									<th style="min-width:100px">l3</th>
									<th style="min-width:100px">W</th>
									<th style="min-width:100px">S1</th>
									<th style="min-width:100px">S2</th>
									<th style="min-width:100px">S3</th>
									<th style="min-width:100px">S1-S3</th>
									<th style="min-width:100px">X1-X2</th>
									<th style="min-width:100px">M1</th>
									<th style="min-width:100px">M2</th>
									<th style="min-width:100px">t</th>
									<th style="min-width:100px">T1</th>
									<th style="min-width:100px">T2</th>
									<th style="min-width:100px">T3</th>
									<th style="min-width:100px">Burr</th>
									<th style="min-width:100px">g</th>
									<th style="min-width:100px">b</th>			
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
<!-- 치수 모달 종료-->
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
						<th style="min-width: 50px">SEQ</th>
						<th style="min-width: 50px">등록일</th>
						<th style="min-width: 50px">설비명</th>
						<th style="min-width: 50px">제품코드</th>
						<th style="min-width: 100px">제품명</th>
						<th style="min-width: 50px">모델NO</th>
						<th style="min-width: 100px">AL/NICU자재코드</th>
						<th style="min-width: 80px">필름자재코드</th>
						<th style="min-width: 50px">비중</th>
						<th style="min-width: 70px">거래처코드</th>
						<th style="min-width: 50px">재고단위</th>
						<th style="min-width: 50px">포장단위</th>
						<th style="min-width: 50px">체크1</th>
						<th style="min-width: 100px">비고</th>
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

	let menuAuth = 'emsc3020';
	let currentHref = 'emsc3020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","제조조건관리");
	
	var sideView = null;
	var equipCondSeq = null;
	var equipCd = null;
	var goodsCd = null;
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	
	let factoryCode = "<%=factoryCode%>";
	
	//if( factoryCode == "003" ){
	//	timeView.rows[0].cells[8].style.display = "none";	//gap Of Layer
	//	timeView.rows[1].cells[14].style.display = "none";	//폭
	//	
	//	timeView.rows[2].cells[14].style.display = "none";	//조건
	//	timeView.rows[3].cells[14].style.display = "none";	//Plus
	//	timeView.rows[4].cells[14].style.display = "none";	//Minus
	//}

	//공통코드 처리 시작
	var equipGroupCode = new Array(); // 설치장소
    <c:forEach items="${equipGroupCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
	//제품코드 선택(검색팝업) btn 클릭
	$('#btnSelectMatrlCode').click(function(){
		$('#tempaturBtn').attr('disabled', false);
		$('#timeBtn').attr('disabled', false);
		$('#pressureBtn').attr('disabled', false);
		$('#sizeBtn').attr('disabled', false);
	});

	//수정 btn 클릭
	$('#btnEdit').click(function(){
		sideView = "edit"
		$('#tempaturBtn').attr('disabled', false);
		$('#timeBtn').attr('disabled', false);
		$('#pressureBtn').attr('disabled', false);
		$('#sizeBtn').attr('disabled', false);
		//$('#btnSelectMatrlCode').attr('disabled', false);
		$('#btnSave').attr('disabled', false);
		uiProc(false);
		//수정시 빈칸들 0으로 채워넣기
		$('.number-float1, .number-float2, .number-float3').each(function(index, value) {
			if ( $(this).val() == "" ){
				$(this).val("0");
			}
		});
	});
	
	$(document).on('click','#btnAdd', function() {
		if(equipCd == null){
			toastr.warning('등록할 설비명을 선택해 주세요.');
			return false;
		}
		$('#manufacturerListTable').find('tr.selected').removeClass('selected');
		sideView = "create"
   		$('#addForm').removeClass('d-none');
   		$('#viewEquipoBox').removeClass('d-none');
   		$('#tempaturBtn').attr('disabled', false);
   		$('#timeBtn').attr('disabled', false);
   		$('#pressureBtn').attr('disabled', false);
   		$('#sizeBtn').attr('disabled', false);
   		$('#btnSelectMatrlCode').attr('disabled', false);
   		$('#btnSave').attr('disabled', true);
   		$('#btnEdit').attr('disabled', true);
   		addFormClear();

   		$('.number-float1, .number-float2, .number-float3').val("0");
   		//$('#tempatur').each(function(){
        //	this.reset();
    	//}); 
   		//$('#time').each(function(){
        //	this.reset();
    	//}); 
   		//$('#pressure').each(function(){
        //	this.reset();
    	//}); 
   		//$('#size').each(function(){
        //	this.reset();
    	//});
    	
   		uiProc(false);			
	});

   	$('#btnClose').click(function () {
   		$('#addForm').addClass('d-none');
   		$('#viewEquipoBox').addClass('d-none');
   	});
	    
    // 목록$.fn.dataTable.ext.errMode = 'none';
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
            	'equipGroup' : function() { return equipGroup; }
            },
        },
        rowId: 'equipCd',
		columns: [
			{ data: 'equipCd' },
			{ data: 'equipNm' },
		],
		order: [
			[ 1, 'asc' ],
		],
	    drawCallback: function( settings ) {
	    	$('#equipCodeAdmTable_previous').html('');
	    	$('#equipCodeAdmTable_next').html('');
	    	$('#equipCodeAdmTable tbody tr td').css('height','52px');
	    }
    });
    var html1 =  '&nbsp;<label class="input-label-sm">설비그룹</label><select class="custom-select" id="equipGroupCd"></select>';
    $('#equipCodeAdmTable_length').html(html1)
	selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");

	$("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});
		$('#addForm').addClass('d-none');
   		$('#viewEquipoBox').addClass('d-none');
	 	equipCd = null;
	});

	$.fn.dataTable.ext.errMode = 'none';
	let manufacturerListTable = $('#manufacturerListTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        language: lang_kor,
		paging: true,
		info: false,
		ordering: false,
		processing: true,
		searching: true,
		autoWidth: false,
		destroy: true,
		pageLength: 5,
	});
	
	var html = '<button type="button" class="btn btn-primary float-left mr-2" id="btnAdd">제조조건 계획 등록</button>';
	html += '<label class="input-label-sm ml-2">* FP사용과 메인구분은 A호기에만 넣어주세요</label>';
	$('#manufacturerListTable_length').html(html);

	//클릭 설비의 작업 계획 리스트
	$('#equipCodeAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            $('#manufacturerListTable').DataTable().clear().draw();
            equipCd = null;
        }
        else {
        	$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            $('#viewEquipoBox').addClass('d-none');
            $('#addForm').addClass('d-none');
            rowIdx = $(this).closest('tr').attr('id');
            equipCd = $(this).closest('tr').attr('id');
    		$('#addFormEquipCd').text(rowIdx);
    		
    		manufacturerListTable = $('#manufacturerListTable').DataTable({
    			language: lang_kor,
    			paging: true,
    			info: true,
    			ordering: false,
    			processing: true,
    			searching: true,
    			autoWidth: false,
    			destroy: true,
    			pageLength: 5,
    			ajax: {
    					url: '<c:url value="em/manufacturerPlanListRead"/>',
    					type: 'GET',
    					data: {
    						'menuAuth'	 : menuAuth,
    						'equipCd': rowIdx,
    					},
    				},
    				columns: [
    					{ data: 'condRegDate',
    		                render: function(data, type, row) {					
    							if(data != "") {
    								return moment(data).format("YYYY-MM-DD");
    							} else {
    								return "-";
    							}
    		                }	         					
        				},
        				{ data: 'equipCondSeq' },
    					{ data: 'goodsCd' },
    					{ data: 'goodsNm' },
    					{ data: 'alniQutyNm' },
    					{ data: 'model' },
    				    { data: 'alniThickness',
    				   		render: function(data, type) {
    				   			return parseFloat(data).toFixed(1);
    				   		}
    		            },
    				    { data: 'alniDepth',
    				   		render: function(data, type) {
    				   			return parseFloat(data).toFixed(1);
    				   		}
    		            },
    				    { data: 'alniWidth',
    				   		render: function(data, type) {
    				   			return parseFloat(data).toFixed(1);
    				   		}
    		            },
    				    { data: 'alniLength',
    				   		render: function(data, type) {
    				   			return parseFloat(data).toFixed(1);
    				   		}
    		            },
    				    { data: 'alniPitch',
    				   		render: function(data, type) {
    				   			return parseFloat(data).toFixed(1);
    				   		}
    		            },
    					{ data: 'filmQutyNm' },
    					//{ data: 'filmModel' },	//필름 규격
    					{ data: 'filmThickness',
    				   		render: function(data, type) {
    				   			return parseFloat(data).toFixed(1);
    				   		}
    		            },
    		            { data: 'filmDepth',
    				   		render: function(data, type) {
    				   			return parseFloat(data).toFixed(1);
    				   		}
    		            },
    					{ data: 'filmMatrlDesc' },
    					{ data: 'fpUseYn',
    				   		render: function(data, type) {
        				   		if(data == null || data == ''){            				   		
									return '';
                				} else{
									if(data == '001'){
										return '사용';
									} else if( data == '002'){
										return '미사용';
									}
                    			}    				   			
    				   		}
				   		 },
    					{ data: 'fpMainGubun',
				   			render: function(data, type) {
        				   		if(data == null || data == ''){            				   		
									return '';
                				} else{
                    				if(data == '001'){
                    					return '메인';
                        			} else{
                            			return '';
                                	}
									
                    			}    				   			
    				   		}
 				   		 },
    		  		],
    		        columnDefs: [
    		        	{ targets: [0,1,2,3,4,10,13,14,15,16], className: 'text-center' },
    		        	{ targets: [5,6,7,8,9,11,12], render: $.fn.dataTable.render.number( ',' ) },
    		        	{ targets: [5,6,7,8,9,11,12], className: 'text-right-td' },
    		        ],	    		  		
    		  		order: [
    		  			[ 0, 'DESC' ],
    		  		],
    	    });
    		$('#manufacturerListTable_length').html(html);
        }
	});
	
	//설비계획 상세 조회
	$('#manufacturerListTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#manufacturerListTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
    		equipCd = manufacturerListTable.row( this ).data().equipCd;
    		equipCondSeq = manufacturerListTable.row( this ).data().equipCondSeq;
    		goodsCd = manufacturerListTable.row( this ).data().goodsCd;
    		let fpUseYn = manufacturerListTable.row( this ).data().fpUseYn;
    		let fpMainGubun = manufacturerListTable.row( this ).data().fpMainGubun;
    		$('#btnSelectMatrlCode').attr('disabled', true);
            $('#hiddenEquipCondSeq').val(equipCondSeq);	//SEQ 수정시 사용
            $('.number-float1, .number-float2, .number-float3').val("");
            
            $.ajax({
            	url: '<c:url value="em/equipBomDataList"/>',
                type: 'GET',
                data: {
                	'menuAuth'	 : menuAuth,
                	'equipCondSeq' : equipCondSeq,
                	'goodsCd' : goodsCd,
                },
                success: function (res) {
                	let manufacturerData = res.manufacturerData;
                    let tempaturData = res.tempaturData;
                    let timeData = res.timeData;
                    let pressureData = res.pressureData;
                    let sizeData = res.sizeData;
                    
                    if (res.result == 'ok') {
                   		//toastr.success("조회 완료");

                   		$('#addFormGoodsCd').text(manufacturerData.goodsCd);
                   		$('#addFormGoodsNm').val(manufacturerData.goodsNm);
                   		$('#addFormQutyNm').text(manufacturerData.alniQutyNm);
                   		$('#addFormModel').text(manufacturerData.model);
                   		$('#addFormAlniThickness').text(manufacturerData.alniThickness);//두께
                   		$('#addFormAlniDepth').text(manufacturerData.alniDepth);     	//폭
                   		$('#addFormAlniWidth').text(manufacturerData.alniWidth);     	//너비
                   		$('#addFormAlniLength').text(manufacturerData.alniLength);    	//길이
                   		$('#addFormAlniPtich').text(manufacturerData.alniPitch);     	//피치
                   		$('#addFormFilmQutyNm').text(manufacturerData.filmQutyNm);     	  //필름명  
                   		$('#addFormFilmThickness').text(manufacturerData.filmThickness);  //필름 두께
                   		$('#addFormFilmDepth').text(manufacturerData.filmDepth);     	  //필름 규격
                   		$('#addFormFilmMatrlDesc').text(manufacturerData.filmMatrlDesc);  //필름 비고
                   		$('#fpUseYn').val(fpUseYn);
                   		if(fpMainGubun == '001'){
                   			$('#fpMainGubun').prop('checked',true);
                       	} else{
                       		$('#fpMainGubun').prop('checked',false);
                        }
 
                        $('#tempaturViewWarmupCond').val(tempaturData.warmupCond);
                        $('#tempaturViewWarmupAlwncePlus').val(tempaturData.warmupAlwncePlus);
                        $('#tempaturViewWarmupAlwnceMinus').val(tempaturData.warmupAlwnceMinus);
                        $('#tempaturViewFitup1UpCond').val(tempaturData.fitup1UpCond);
                        $('#tempaturViewFitup1UpAlwncePlus').val(tempaturData.fitup1UpAlwncePlus);
                        $('#tempaturViewFitup1UpAlwnceMinus').val(tempaturData.fitup1UpAlwnceMinus);
                        $('#tempaturViewFitup1DownCond').val(tempaturData.fitup1DownCond);
                        $('#tempaturViewFitup1DownAlwncePlus').val(tempaturData.fitup1DownAlwncePlus);
                        $('#tempaturViewFitup1DownAlwnceMinus').val(tempaturData.fitup1DownAlwnceMinus);
                        $('#tempaturViewFitup2UpleftCond').val(tempaturData.fitup2UpleftCond);
                        $('#tempaturViewFitup2UpleftAlwncePlus').val(tempaturData.fitup2UpleftAlwncePlus);
                        $('#tempaturViewFitup2UpleftAlwnceMinus').val(tempaturData.fitup2UpleftAlwnceMinus);
                        $('#tempaturViewFitup2DownleftCond').val(tempaturData.fitup2DownleftCond);
                        $('#tempaturViewFitup2DownleftAlwncePlus').val(tempaturData.fitup2DownleftAlwncePlus);
                        $('#tempaturViewFitup2DownleftAlwnceMinus').val(tempaturData.fitup2DownleftAlwnceMinus);
                        $('#tempaturViewFitup2UprightCond').val(tempaturData.fitup2UprightCond);
                        $('#tempaturViewFitup2UprightAlwncePlus').val(tempaturData.fitup2UprightAlwncePlus);
                        $('#tempaturViewFitup2UprightAlwnceMinus').val(tempaturData.fitup2UprightAlwnceMinus);
                        $('#tempaturViewFitup2DownrightCond').val(tempaturData.fitup2DownrightCond);
                        $('#tempaturViewFitup2DownrightAlwncePlus').val(tempaturData.fitup2DownrightAlwncePlus);
                        $('#tempaturViewFitup2DownrightAlwnceMinus').val(tempaturData.fitup2DownrightAlwnceMinus);
                        $('#tempaturViewRollheatUpCond').val(tempaturData.rollheatUpCond);
                        $('#tempaturViewRollheatUpAlwncePlus').val(tempaturData.rollheatUpAlwncePlus);
                        $('#tempaturViewRollheatUpAlwnceMinus').val(tempaturData.rollheatUpAlwnceMinus);
                        $('#tempaturViewRollheatDownCond').val(tempaturData.rollheatDownCond);
                        $('#tempaturViewRollheatDownAlwncePlus').val(tempaturData.rollheatDownAlwncePlus);
                        $('#tempaturViewRollheatDownAlwnceMinus').val(tempaturData.rollheatDownAlwnceMinus);
                        $('#tempaturViewFirstUpleftCond').val(tempaturData.firstUpleftCond);
                        $('#tempaturViewFirstUpleftAlwncePlus').val(tempaturData.firstUpleftAlwncePlus);
                        $('#tempaturViewFirstUpleftAlwnceMinus').val(tempaturData.firstUpleftAlwnceMinus);
                        $('#tempaturViewFirstDownleftCond').val(tempaturData.firstDownleftCond);
                        $('#tempaturViewFirstDownleftAlwncePlus').val(tempaturData.firstDownleftAlwncePlus);
                        $('#tempaturViewFirstDownleftAlwnceMinus').val(tempaturData.firstDownleftAlwnceMinus);
                        $('#tempaturViewFirstUprightCond').val(tempaturData.firstUprightCond);
                        $('#tempaturViewFirstUprightAlwncePlus').val(tempaturData.firstUprightAlwncePlus);
                        $('#tempaturViewFirstUprightAlwnceMinus').val(tempaturData.firstUprightAlwnceMinus);
                        $('#tempaturViewFirstDownrightCond').val(tempaturData.firstDownrightCond);
                        $('#tempaturViewFirstDownrightAlwncePlus').val(tempaturData.firstDownrightAlwncePlus);
                        $('#tempaturViewFirstDownrightAlwnceMinus').val(tempaturData.firstDownrightAlwnceMinus);

                        $('#tempaturViewPush1UpCond').val(tempaturData.push1UpCond);
                        $('#tempaturViewPush1UpAlwncePlus').val(tempaturData.push1UpAlwncePlus);
                        $('#tempaturViewPush1UpAlwnceMinus').val(tempaturData.push1UpAlwnceMinus);
                        $('#tempaturViewPush1DownCond').val(tempaturData.push1DownCond);
                        $('#tempaturViewPush1DownAlwncePlus').val(tempaturData.push1DownAlwncePlus);
                        $('#tempaturViewPush1DownAlwnceMinus').val(tempaturData.push1DownAlwnceMinus);
                        
                        $('#tempaturViewSecondUpleftCond').val(tempaturData.secondUpleftCond);
                        $('#tempaturViewSecondUpleftAlwncePlus').val(tempaturData.secondUpleftAlwncePlus);
                        $('#tempaturViewSecondUpleftAlwnceMinus').val(tempaturData.secondUpleftAlwnceMinus);
                        $('#tempaturViewSecondDownleftCond').val(tempaturData.secondDownleftCond);
                        $('#tempaturViewSecondDownleftAlwncePlus').val(tempaturData.secondDownleftAlwncePlus);
                        $('#tempaturViewSecondDownleftAlwnceMinus').val(tempaturData.secondDownleftAlwnceMinus);
                        $('#tempaturViewSecondUprightCond').val(tempaturData.secondUprightCond);
                        $('#tempaturViewSecondUprightAlwncePlus').val(tempaturData.secondUprightAlwncePlus);
                        $('#tempaturViewSecondUprightAlwnceMinus').val(tempaturData.secondUprightAlwnceMinus);
                        $('#tempaturViewSecondDownrightCond').val(tempaturData.secondDownrightCond);
                        $('#tempaturViewSecondDownrightAlwncePlus').val(tempaturData.secondDownrightAlwncePlus);
                        $('#tempaturViewSecondDownrightAlwnceMinus').val(tempaturData.secondDownrightAlwnceMinus);
                        $('#tempaturViewThirdUpleftCond').val(tempaturData.thirdUpleftCond);
                        $('#tempaturViewThirdUpleftAlwncePlus').val(tempaturData.thirdUpleftAlwncePlus);
                        $('#tempaturViewThirdUpleftAlwnceMinus').val(tempaturData.thirdUpleftAlwnceMinus);
                        $('#tempaturViewThirdDownleftCond').val(tempaturData.thirdDownleftCond);
                        $('#tempaturViewThirdDownleftAlwncePlus').val(tempaturData.thirdDownleftAlwncePlus);
                        $('#tempaturViewThirdDownleftAlwnceMinus').val(tempaturData.thirdDownleftAlwnceMinus);
                        $('#tempaturViewThirdUprightCond').val(tempaturData.thirdUprightCond);
                        $('#tempaturViewThirdUprightAlwncePlus').val(tempaturData.thirdUprightAlwncePlus);
                        $('#tempaturViewThirdUprightAlwnceMinus').val(tempaturData.thirdUprightAlwnceMinus);
                        $('#tempaturViewThirdDownrightCond').val(tempaturData.thirdDownrightCond);
                        $('#tempaturViewThirdDownrightAlwncePlus').val(tempaturData.thirdDownrightAlwncePlus);
                        $('#tempaturViewThirdDownrightAlwnceMinus').val(tempaturData.thirdDownrightAlwnceMinus);
                        $('#tempaturViewJinjeop1UpCond').val(tempaturData.jinjeop1UpCond);
                        $('#tempaturViewJinjeop1UpAlwncePlus').val(tempaturData.jinjeop1UpAlwncePlus);
                        $('#tempaturViewJinjeop1UpAlwnceMinus').val(tempaturData.jinjeop1UpAlwnceMinus);
                        $('#tempaturViewJinjeop1DownCond').val(tempaturData.jinjeop1DownCond);
                        $('#tempaturViewJinjeop1DownAlwncePlus').val(tempaturData.jinjeop1DownAlwncePlus);
                        $('#tempaturViewJinjeop1DownAlwnceMinus').val(tempaturData.jinjeop1DownAlwnceMinus);
                        $('#tempaturViewJinjeop2UpCond').val(tempaturData.jinjeop2UpCond);
                        $('#tempaturViewJinjeop2UpAlwncePlus').val(tempaturData.jinjeop2UpAlwncePlus);
                        $('#tempaturViewJinjeop2UpAlwnceMinus').val(tempaturData.jinjeop2UpAlwnceMinus);
                        $('#tempaturViewJinjeop2DownCond').val(tempaturData.jinjeop2DownCond);
                        $('#tempaturViewJinjeop2DownAlwncePlus').val(tempaturData.jinjeop2DownAlwncePlus);
                        $('#tempaturViewJinjeop2DownAlwnceMinus').val(tempaturData.jinjeop2DownAlwnceMinus);

                        $('#tempaturViewRollheatCond').val(tempaturData.rollheatCond);
                        $('#tempaturViewRollheatAlwncePlus').val(tempaturData.rollheatAlwncePlus);
                        $('#tempaturViewRollheatAlwnceMinus').val(tempaturData.rollheatAlwnceMinus);
                        $('#tempaturViewThirdCond').val(tempaturData.thirdCond);
                        $('#tempaturViewThirdAlwncePlus').val(tempaturData.thirdAlwncePlus);
                        $('#tempaturViewThirdAlwnceMinus').val(tempaturData.thirdAlwnceMinus);
                        $('#tempaturViewJinjeop2Cond').val(tempaturData.jinjeop2Cond);
                        $('#tempaturViewJinjeop2AlwncePlus').val(tempaturData.jinjeop2AlwncePlus);
                        $('#tempaturViewJinjeop2AlwnceMinus').val(tempaturData.jinjeop2AlwnceMinus);

                        $('#timeViewWarmupCond').val(timeData.warmupCond);
                        $('#timeViewWarmupAlwncePlus').val(timeData.warmupAlwncePlus);
                        $('#timeViewWarmupAlwnceMinus').val(timeData.warmupAlwnceMinus);
                        $('#timeViewFitupCond').val(timeData.fitupCond);
                        $('#timeViewFitupAlwncePlus').val(timeData.fitupAlwncePlus);
                        $('#timeViewFitupAlwnceMinus').val(timeData.fitupAlwnceMinus);
                        $('#timeViewFitup2Cond').val(timeData.fitup2Cond);
                        $('#timeViewFitup2AlwncePlus').val(timeData.fitup2AlwncePlus);
                        $('#timeViewFitup2AlwnceMinus').val(timeData.fitup2AlwnceMinus);
                        $('#timeViewFirstCond').val(timeData.firstCond);
                        $('#timeViewFirstAlwncePlus').val(timeData.firstAlwncePlus);
                        $('#timeViewFirstAlwnceMinus').val(timeData.firstAlwnceMinus);
                        $('#timeViewSecondCond').val(timeData.secondCond);
                        $('#timeViewSecondAlwncePlus').val(timeData.secondAlwncePlus);
                        $('#timeViewSecondAlwnceMinus').val(timeData.secondAlwnceMinus);
                        $('#timeViewThirdCond').val(timeData.thirdCond);
                        $('#timeViewThirdAlwncePlus').val(timeData.thirdAlwncePlus);
                        $('#timeViewThirdAlwnceMinus').val(timeData.thirdAlwnceMinus);
                        $('#timeViewJinjeopCond').val(timeData.jinjeopCond);
                        $('#timeViewJinjeopAlwncePlus').val(timeData.jinjeopAlwncePlus);
                        $('#timeViewJinjeopAlwnceMinus').val(timeData.jinjeopAlwnceMinus);

                        $('#timeViewJinjeop2Cond').val(timeData.jinjeop2Cond);
                        $('#timeViewJinjeop2AlwncePlus').val(timeData.jinjeop2AlwncePlus);
                        $('#timeViewJinjeop2AlwnceMinus').val(timeData.jinjeop2AlwnceMinus);
                        $('#timeViewPush1Cond').val(timeData.push1Cond);
                        $('#timeViewPush1AlwncePlus').val(timeData.push1AlwncePlus);
                        $('#timeViewPush1AlwnceMinus').val(timeData.push1AlwnceMinus);
                        
                        $('#timeViewReformCond').val(timeData.reformCond);
                        $('#timeViewReformAlwncePlus').val(timeData.reformAlwncePlus);
                        $('#timeViewReformAlwnceMinus').val(timeData.reformAlwnceMinus);

                        $('#timeViewCoolCond').val(timeData.coolCond);
                        $('#timeViewCoolAlwncePlus').val(timeData.coolAlwncePlus);
                        $('#timeViewCoolAlwnceMinus').val(timeData.coolAlwnceMinus);
                        
                        $('#pressureViewWarmupCond').val(pressureData.warmupCond);
                        $('#pressureViewWarmupAlwncePlus').val(pressureData.warmupAlwncePlus);
                        $('#pressureViewWarmupAlwnceMinus').val(pressureData.warmupAlwnceMinus);
                        $('#pressureViewFitupCond').val(pressureData.fitupCond);
                        $('#pressureViewFitupAlwncePlus').val(pressureData.fitupAlwncePlus);
                        $('#pressureViewFitupAlwnceMinus').val(pressureData.fitupAlwnceMinus);
                        $('#pressureViewPush1Cond').val(pressureData.push1Cond);
                        $('#pressureViewPush1AlwncePlus').val(pressureData.push1AlwncePlus);
                        $('#pressureViewPush1AlwnceMinus').val(pressureData.push1AlwnceMinus);
                        //$('#pressureViewSecondCond').val(pressureData.secondCond);
                        //$('#pressureViewSecondAlwncePlus').val(pressureData.secondAlwncePlus);
                        //$('#pressureViewSecondAlwnceMinus').val(pressureData.secondAlwnceMinus);
                        $('#pressureViewJinjeopCond').val(pressureData.jinjeopCond);
                        $('#pressureViewJinjeopAlwncePlus').val(pressureData.jinjeopAlwncePlus);
                        $('#pressureViewJinjeopAlwnceMinus').val(pressureData.jinjeopAlwnceMinus);

                        $('#pressureViewJinjeop2Cond').val(pressureData.jinjeop2Cond);
                        $('#pressureViewJinjeop2AlwncePlus').val(pressureData.jinjeop2AlwncePlus);
                        $('#pressureViewJinjeop2AlwnceMinus').val(pressureData.jinjeop2AlwnceMinus);
                        
                        $('#pressureViewReformCond').val(pressureData.reformCond);
                        $('#pressureViewReformAlwncePlus').val(pressureData.reformAlwncePlus);
                        $('#pressureViewReformAlwnceMinus').val(pressureData.reformAlwnceMinus);

    				
						$('#sizeViewWpLeftCond').val(sizeData.wpLeftCond);
						$('#sizeViewWpLeftAlwncePlus').val(sizeData.wpLeftAlwncePlus);
						$('#sizeViewWpLeftAlwnceMinus').val(sizeData.wpLeftAlwnceMinus);
						$('#sizeViewWpRightCond').val(sizeData.wpRightCond);
						$('#sizeViewWpRightAlwncePlus').val(sizeData.wpRightAlwncePlus);
						$('#sizeViewWpRightAlwnceMinus').val(sizeData.wpRightAlwnceMinus);
						$('#sizeViewPitchLeftCond').val(sizeData.pitchLeftCond);
						$('#sizeViewPitchLeftAlwncePlus').val(sizeData.pitchLeftAlwncePlus);
						$('#sizeViewPitchLeftAlwnceMinus').val(sizeData.pitchLeftAlwnceMinus);
						$('#sizeViewPitchRightCond').val(sizeData.pitchRightCond);
						$('#sizeViewPitchRightAlwncePlus').val(sizeData.pitchRightAlwncePlus);
						$('#sizeViewPitchRightAlwnceMinus').val(sizeData.pitchRightAlwnceMinus);
						$('#sizeViewPpfWingLeftCond').val(sizeData.ppfWingLeftCond);
						$('#sizeViewPpfWingLeftAlwncePlus').val(sizeData.ppfWingLeftAlwncePlus);
						$('#sizeViewPpfWingLeftAlwnceMinus').val(sizeData.ppfWingLeftAlwnceMinus);
						$('#sizeViewPpfWingRightCond').val(sizeData.ppfWingRightCond);
						$('#sizeViewPpfWingRightAlwncePlus').val(sizeData.ppfWingRightAlwncePlus);
						$('#sizeViewPpfWingRightAlwnceMinus').val(sizeData.ppfWingRightAlwnceMinus);
						$('#sizeViewPpfDepthLeftCond').val(sizeData.ppfDepthLeftCond);
						$('#sizeViewPpfDepthLeftAlwncePlus').val(sizeData.ppfDepthLeftAlwncePlus);
						$('#sizeViewPpfDepthLeftAlwnceMinus').val(sizeData.ppfDepthLeftAlwnceMinus);
						$('#sizeViewPpfDepthRightCond').val(sizeData.ppfDepthRightCond);
						$('#sizeViewPpfDepthRightAlwncePlus').val(sizeData.ppfDepthRightAlwncePlus);
						$('#sizeViewPpfDepthRightAlwnceMinus').val(sizeData.ppfDepthRightAlwnceMinus);
						$('#sizeViewFilmCond').val(sizeData.filmCond);
						$('#sizeViewFilmAlwncePlus').val(sizeData.filmAlwncePlus);
						$('#sizeViewFilmAlwnceMinus').val(sizeData.filmAlwnceMinus);
						$('#sizeViewMetalDepthCond').val(sizeData.metalDepthCond);
						$('#sizeViewMetalDepthAlwncePlus').val(sizeData.metalDepthAlwncePlus);
						$('#sizeViewMetalDepthAlwnceMinus').val(sizeData.metalDepthAlwnceMinus);	
						$('#sizeViewWpCenterCond').val(sizeData.wpCenterCond);             
						$('#sizeViewWpCenterAlwncePlus').val(sizeData.wpCenterAlwncePlus);       
						$('#sizeViewWpCenterAlwnceMinus').val(sizeData.wpCenterAlwnceMinus);      
						$('#sizeViewPpfDepthCenterCond').val(sizeData.ppfDepthCenterCond);       
						$('#sizeViewPpfDepthCenterAlwncePlus').val(sizeData.ppfDepthCenterAlwncePlus); 
						$('#sizeViewPpfDepthCenterAlwnceMinus').val(sizeData.ppfDepthCenterAlwnceMinus);
						$('#sizeViewWpDeviationCond').val(sizeData.wpDeviationCond);          
						$('#sizeViewWpDeviationAlwncePlus').val(sizeData.wpDeviationAlwncePlus);    
						$('#sizeViewWpDeviationAlwnceMinus').val(sizeData.wpDeviationAlwnceMinus);   
						$('#sizeViewX1X2Cond').val(sizeData.x1X2Cond);                 
						$('#sizeViewX1X2AlwncePlus').val(sizeData.x1X2AlwncePlus);           
						$('#sizeViewX1X2AlwnceMinus').val(sizeData.x1X2AlwnceMinus); 
						$('#sizeViewMetalThicknessCond').val(sizeData.metalThicknessCond);
						$('#sizeViewMetalThicknessAlwncePlus').val(sizeData.metalThicknessAlwncePlus);
						$('#sizeViewMetalThicknessAlwnceMinus').val(sizeData.metalThicknessAlwnceMinus);
						$('#sizeViewThCenterCond').val(sizeData.thCenterCond);
						$('#sizeViewThCenterAlwncePlus').val(sizeData.thCenterAlwncePlus);
						$('#sizeViewThCenterAlwnceMinus').val(sizeData.thCenterAlwnceMinus);
						$('#sizeViewThEdgeCond').val(sizeData.thEdgeCond);
						$('#sizeViewThEdgeAlwncePlus').val(sizeData.thEdgeAlwncePlus);
						$('#sizeViewThEdgeAlwnceMinus').val(sizeData.thEdgeAlwnceMinus);
						$('#sizeViewBurrCond').val(sizeData.burrCond);
						$('#sizeViewBurrAlwncePlus').val(sizeData.burrAlwncePlus);
						$('#sizeViewBurrAlwnceMinus').val(sizeData.burrAlwnceMinus);
						$('#sizeViewGapOfLayerCond').val(sizeData.gapOfLayerCond);
						$('#sizeViewGapOfLayerAlwncePlus').val(sizeData.gapOfLayerAlwncePlus);
						$('#sizeViewGapOfLayerAlwnceMinus').val(sizeData.gapOfLayerAlwnceMinus);
						$('#sizeViewThEdgeRightCond').val(sizeData.thEdgeRightCond);          
						$('#sizeViewThEdgeRightAlwncePlus').val(sizeData.thEdgeRightAlwncePlus);    
						$('#sizeViewThEdgeRightAlwnceMinus').val(sizeData.thEdgeRightAlwnceMinus);   
						$('#sizeViewBendingCond').val(sizeData.bendingCond);              
						$('#sizeViewBendingAlwncePlus').val(sizeData.bendingAlwncePlus);        
						$('#sizeViewBendingAlwnceMinus').val(sizeData.bendingAlwnceMinus);	     		           


                        

                        
                        uiProc(true);
                		$('#btnSave').attr("disabled",true);
                		$('#btnEdit').attr("disabled",false);
                		$('#tempaturBtn').attr("disabled",true);
                		$('#timeBtn').attr("disabled",true);
                		$('#pressureBtn').attr("disabled",true);
                		$('#sizeBtn').attr("disabled",true);
                		
                    } else {
                    	toastr.error(res.message, '', {timeOut: 5000});
					}
                },
                complete:function(){
                    $('#addForm').removeClass('d-none');
                	$('#viewEquipoBox').removeClass('d-none');
                }
            });
        }
	});
   
	//설비 계획 등록 & 수정
	$('#btnSave').click(function(){
		let checkBlank = false;
		$('.number-float1, .number-float2, .number-float3').each(function(index, value) {
			if ( $(this).val() == "" ){
				$(this).focus();
				toastr.warning("미입력 구간이 있습니다.");
				checkBlank = true;
				return false;
			}
		});

		if(checkBlank){
			return false;
		}
		
		var dataArray = new Array()
		//설비조건공통
		var commomData = new Object();
		commomData.menuAuth = menuAuth;
		commomData.equipCd = $("#addFormEquipCd").text();
		commomData.goodsCd = $("#addFormGoodsCd").text();
		commomData.equipCondSeq = $("#hiddenEquipCondSeq").val();
		commomData.fpUseYn = ($("#fpUseYn").val() == null || $("#fpUseYn").val() == '') ? ' ' : $("#fpUseYn").val();
		if($("#fpMainGubun").is(":checked")){
			commomData.fpMainGubun = "001";
		} else{
			commomData.fpMainGubun = "002";
		}
		dataArray.push(commomData);
		
		//온도
		var tempaturData = new Object();
		tempaturData.warmupCond = $("#tempaturViewWarmupCond").val();
		tempaturData.warmupAlwncePlus = $("#tempaturViewWarmupAlwncePlus").val();
		tempaturData.warmupAlwnceMinus = $("#tempaturViewWarmupAlwnceMinus").val();
		tempaturData.fitup1UpCond = $("#tempaturViewFitup1UpCond").val();
		tempaturData.fitup1UpAlwncePlus = $("#tempaturViewFitup1UpAlwncePlus").val();
		tempaturData.fitup1UpAlwnceMinus = $("#tempaturViewFitup1UpAlwnceMinus").val();
		tempaturData.fitup1DownCond = $("#tempaturViewFitup1DownCond").val();
		tempaturData.fitup1DownAlwncePlus = $("#tempaturViewFitup1DownAlwncePlus").val();
		tempaturData.fitup1DownAlwnceMinus = $("#tempaturViewFitup1DownAlwnceMinus").val();
		tempaturData.fitup2UpleftCond = $("#tempaturViewFitup2UpleftCond").val();
		tempaturData.fitup2UpleftAlwncePlus = $("#tempaturViewFitup2UpleftAlwncePlus").val();
		tempaturData.fitup2UpleftAlwnceMinus = $("#tempaturViewFitup2UpleftAlwnceMinus").val();
		tempaturData.fitup2DownleftCond = $("#tempaturViewFitup2DownleftCond").val();
		tempaturData.fitup2DownleftAlwncePlus = $("#tempaturViewFitup2DownleftAlwncePlus").val();
		tempaturData.fitup2DownleftAlwnceMinus = $("#tempaturViewFitup2DownleftAlwnceMinus").val();
		tempaturData.fitup2UprightCond = $("#tempaturViewFitup2UprightCond").val();
		tempaturData.fitup2UprightAlwncePlus = $("#tempaturViewFitup2UprightAlwncePlus").val();
		tempaturData.fitup2UprightAlwnceMinus = $("#tempaturViewFitup2UprightAlwnceMinus").val();
		tempaturData.fitup2DownrightCond = $("#tempaturViewFitup2DownrightCond").val();
		tempaturData.fitup2DownrightAlwncePlus = $("#tempaturViewFitup2DownrightAlwncePlus").val();
		tempaturData.fitup2DownrightAlwnceMinus = $("#tempaturViewFitup2DownrightAlwnceMinus").val();		
		tempaturData.rollheatUpCond = $("#tempaturViewRollheatUpCond").val();
		tempaturData.rollheatUpAlwncePlus = $("#tempaturViewRollheatUpAlwncePlus").val();
		tempaturData.rollheatUpAlwnceMinus = $("#tempaturViewRollheatUpAlwnceMinus").val();
		tempaturData.rollheatDownCond = $("#tempaturViewRollheatDownCond").val();
		tempaturData.rollheatDownAlwncePlus = $("#tempaturViewRollheatDownAlwncePlus").val();
		tempaturData.rollheatDownAlwnceMinus = $("#tempaturViewRollheatDownAlwnceMinus").val();
		tempaturData.firstUpleftCond = $("#tempaturViewFirstUpleftCond").val();
		tempaturData.firstUpleftAlwncePlus = $("#tempaturViewFirstUpleftAlwncePlus").val();
		tempaturData.firstUpleftAlwnceMinus = $("#tempaturViewFirstUpleftAlwnceMinus").val();
		tempaturData.firstDownleftCond = $("#tempaturViewFirstDownleftCond").val();
		tempaturData.firstDownleftAlwncePlus = $("#tempaturViewFirstDownleftAlwncePlus").val();
		tempaturData.firstDownleftAlwnceMinus = $("#tempaturViewFirstDownleftAlwnceMinus").val();
		tempaturData.firstUprightCond = $("#tempaturViewFirstUprightCond").val();
		tempaturData.firstUprightAlwncePlus = $("#tempaturViewFirstUprightAlwncePlus").val();
		tempaturData.firstUprightAlwnceMinus = $("#tempaturViewFirstUprightAlwnceMinus").val();
		tempaturData.firstDownrightCond = $("#tempaturViewFirstDownrightCond").val();
		tempaturData.firstDownrightAlwncePlus = $("#tempaturViewFirstDownrightAlwncePlus").val();
		tempaturData.firstDownrightAlwnceMinus = $("#tempaturViewFirstDownrightAlwnceMinus").val();

		tempaturData.push1UpCond = $("#tempaturViewPush1UpCond").val();
		tempaturData.push1UpAlwncePlus = $("#tempaturViewPush1UpAlwncePlus").val();
		tempaturData.push1UpAlwnceMinus = $("#tempaturViewPush1UpAlwnceMinus").val();
		tempaturData.push1DownCond = $("#tempaturViewPush1DownCond").val();
		tempaturData.push1DownAlwncePlus = $("#tempaturViewPush1DownAlwncePlus").val();
		tempaturData.push1DownAlwnceMinus = $("#tempaturViewPush1DownAlwnceMinus").val();
		
		tempaturData.secondUpleftCond = $("#tempaturViewSecondUpleftCond").val();
		tempaturData.secondUpleftAlwncePlus = $("#tempaturViewSecondUpleftAlwncePlus").val();
		tempaturData.secondUpleftAlwnceMinus = $("#tempaturViewSecondUpleftAlwnceMinus").val();
		tempaturData.secondDownleftCond = $("#tempaturViewSecondDownleftCond").val();
		tempaturData.secondDownleftAlwncePlus = $("#tempaturViewSecondDownleftAlwncePlus").val();
		tempaturData.secondDownleftAlwnceMinus = $("#tempaturViewSecondDownleftAlwnceMinus").val();
		tempaturData.secondUprightCond = $("#tempaturViewSecondUprightCond").val();
		tempaturData.secondUprightAlwncePlus = $("#tempaturViewSecondUprightAlwncePlus").val();
		tempaturData.secondUprightAlwnceMinus = $("#tempaturViewSecondUprightAlwnceMinus").val();
		tempaturData.secondDownrightCond = $("#tempaturViewSecondDownrightCond").val();
		tempaturData.secondDownrightAlwncePlus = $("#tempaturViewSecondDownrightAlwncePlus").val();
		tempaturData.secondDownrightAlwnceMinus = $("#tempaturViewSecondDownrightAlwnceMinus").val();
		tempaturData.thirdUpleftCond = $("#tempaturViewThirdUpleftCond").val();
		tempaturData.thirdUpleftAlwncePlus = $("#tempaturViewThirdUpleftAlwncePlus").val();
		tempaturData.thirdUpleftAlwnceMinus = $("#tempaturViewThirdUpleftAlwnceMinus").val();
		tempaturData.thirdDownleftCond = $("#tempaturViewThirdDownleftCond").val();
		tempaturData.thirdDownleftAlwncePlus = $("#tempaturViewThirdDownleftAlwncePlus").val();
		tempaturData.thirdDownleftAlwnceMinus = $("#tempaturViewThirdDownleftAlwnceMinus").val();
		tempaturData.thirdUprightCond = $("#tempaturViewThirdUprightCond").val();
		tempaturData.thirdUprightAlwncePlus = $("#tempaturViewThirdUprightAlwncePlus").val();
		tempaturData.thirdUprightAlwnceMinus = $("#tempaturViewThirdUprightAlwnceMinus").val();
		tempaturData.thirdDownrightCond = $("#tempaturViewThirdDownrightCond").val();
		tempaturData.thirdDownrightAlwncePlus = $("#tempaturViewThirdDownrightAlwncePlus").val();
		tempaturData.thirdDownrightAlwnceMinus = $("#tempaturViewThirdDownrightAlwnceMinus").val();
		tempaturData.jinjeop1UpCond = $("#tempaturViewJinjeop1UpCond").val();
		tempaturData.jinjeop1UpAlwncePlus = $("#tempaturViewJinjeop1UpAlwncePlus").val();
		tempaturData.jinjeop1UpAlwnceMinus = $("#tempaturViewJinjeop1UpAlwnceMinus").val();
		tempaturData.jinjeop1DownCond = $("#tempaturViewJinjeop1DownCond").val();
		tempaturData.jinjeop1DownAlwncePlus = $("#tempaturViewJinjeop1DownAlwncePlus").val();
		tempaturData.jinjeop1DownAlwnceMinus = $("#tempaturViewJinjeop1DownAlwnceMinus").val();
		tempaturData.jinjeop2UpCond = $("#tempaturViewJinjeop2UpCond").val();
		tempaturData.jinjeop2UpAlwncePlus = $("#tempaturViewJinjeop2UpAlwncePlus").val();
		tempaturData.jinjeop2UpAlwnceMinus = $("#tempaturViewJinjeop2UpAlwnceMinus").val();
		tempaturData.jinjeop2DownCond = $("#tempaturViewJinjeop2DownCond").val();
		tempaturData.jinjeop2DownAlwncePlus = $("#tempaturViewJinjeop2DownAlwncePlus").val();
		tempaturData.jinjeop2DownAlwnceMinus = $("#tempaturViewJinjeop2DownAlwnceMinus").val();
		
		dataArray.push(tempaturData);

		//시간
		var timeData = new Object();
		timeData.warmupCond= $("#timeViewWarmupCond").val();
		timeData.fitupCond= $("#timeViewFitupCond").val();
		timeData.fitup2Cond= $("#timeViewFitup2Cond").val();
		timeData.firstCond= $("#timeViewFirstCond").val();
		timeData.secondCond= $("#timeViewSecondCond").val();
		timeData.jinjeopCond= $("#timeViewJinjeopCond").val();
		timeData.reformCond= $("#timeViewReformCond").val();
		timeData.warmupAlwncePlus= $("#timeViewWarmupAlwncePlus").val();
		timeData.fitupAlwncePlus= $("#timeViewFitupAlwncePlus").val();
		timeData.fitup2AlwncePlus= $("#timeViewFitup2AlwncePlus").val();
		timeData.firstAlwncePlus= $("#timeViewFirstAlwncePlus").val();
		timeData.secondAlwncePlus= $("#timeViewSecondAlwncePlus").val();
		timeData.jinjeopAlwncePlus= $("#timeViewJinjeopAlwncePlus").val();
		timeData.reformAlwncePlus= $("#timeViewReformAlwncePlus").val();
		timeData.warmupAlwnceMinus= $("#timeViewWarmupAlwnceMinus").val();
		timeData.fitupAlwnceMinus= $("#timeViewFitupAlwnceMinus").val();
		timeData.fitup2AlwnceMinus= $("#timeViewFitup2AlwnceMinus").val();
		timeData.firstAlwnceMinus= $("#timeViewFirstAlwnceMinus").val();
		timeData.secondAlwnceMinus= $("#timeViewSecondAlwnceMinus").val();
		timeData.jinjeopAlwnceMinus= $("#timeViewJinjeopAlwnceMinus").val();
		timeData.reformAlwnceMinus= $("#timeViewReformAlwnceMinus").val();

		timeData.jinjeop2Cond = $("#timeViewJinjeop2Cond").val();
		timeData.jinjeop2AlwncePlus = $("#timeViewJinjeop2AlwncePlus").val();
		timeData.jinjeop2AlwnceMinus = $("#timeViewJinjeop2AlwnceMinus").val();	
		timeData.push1Cond= $("#timeViewPush1Cond").val();
		timeData.push1AlwncePlus= $("#timeViewPush1AlwncePlus").val();
		timeData.push1AlwnceMinus= $("#timeViewPush1AlwnceMinus").val();
		timeData.thirdCond= $("#timeViewThirdCond").val();
		timeData.thirdAlwncePlus= $("#timeViewThirdAlwncePlus").val();
		timeData.thirdAlwnceMinus= $("#timeViewThirdAlwnceMinus").val();

		timeData.coolCond= $("#timeViewCoolCond").val();
		timeData.coolAlwncePlus= $("#timeViewCoolAlwncePlus").val();
		timeData.coolAlwnceMinus= $("#timeViewCoolAlwnceMinus").val();
		
		dataArray.push(timeData);

		//압력
		var pressureData = new Object();
		pressureData.warmupCond= $("#pressureViewWarmupCond").val();
		pressureData.fitupCond= $("#pressureViewFitupCond").val();
		//pressureData.firstCond= $("#pressureViewFirstCond").val();
		//pressureData.secondCond= $("#pressureViewSecondCond").val();
		pressureData.jinjeopCond= $("#pressureViewJinjeopCond").val();
		pressureData.reformCond= $("#pressureViewReformCond").val();
		
		pressureData.warmupAlwncePlus= $("#pressureViewWarmupAlwncePlus").val();
		pressureData.fitupAlwncePlus= $("#pressureViewFitupAlwncePlus").val();
		//pressureData.firstAlwncePlus= $("#pressureViewFirstAlwncePlus").val();
		//pressureData.secondAlwncePlus= $("#pressureViewSecondAlwncePlus").val();
		pressureData.jinjeopAlwncePlus= $("#pressureViewJinjeopAlwncePlus").val();
		pressureData.reformAlwncePlus= $("#pressureViewReformAlwncePlus").val();
		
		pressureData.warmupAlwnceMinus= $("#pressureViewWarmupAlwnceMinus").val();
		pressureData.fitupAlwnceMinus= $("#pressureViewFitupAlwnceMinus").val();
		//pressureData.firstAlwnceMinus= $("#pressureViewFirstAlwnceMinus").val();
		//pressureData.secondAlwnceMinus= $("#pressureViewSecondAlwnceMinus").val();
		pressureData.jinjeopAlwnceMinus= $("#pressureViewJinjeopAlwnceMinus").val();
		pressureData.reformAlwnceMinus= $("#pressureViewReformAlwnceMinus").val();
		

		pressureData.push1Cond= $("#pressureViewPush1Cond").val();
		pressureData.push1AlwncePlus= $("#pressureViewPush1AlwncePlus").val();
		pressureData.push1AlwnceMinus= $("#pressureViewPush1AlwnceMinus").val();
					
		pressureData.jinjeop2Cond= $("#pressureViewJinjeop2Cond").val();
		pressureData.jinjeop2AlwncePlus= $("#pressureViewJinjeop2AlwncePlus").val();
		pressureData.jinjeop2AlwnceMinus= $("#pressureViewJinjeop2AlwnceMinus").val();

		dataArray.push(pressureData);
		
		//치수
		var sizeData = new Object();
		sizeData.metalDepthCond         = $("#sizeViewMetalDepthCond").val();
		sizeData.pitchLeftCond          = $("#sizeViewPitchLeftCond").val();
		sizeData.ppfDepthLeftCond       = $("#sizeViewPpfDepthLeftCond").val();
		sizeData.ppfDepthCenterCond     = $("#sizeViewPpfDepthCenterCond").val();
		sizeData.ppfDepthRightCond      = $("#sizeViewPpfDepthRightCond").val();
		sizeData.filmCond               = $("#sizeViewFilmCond").val();
		sizeData.wpLeftCond             = $("#sizeViewWpLeftCond").val();
		sizeData.wpCenterCond           = $("#sizeViewWpCenterCond").val();
		sizeData.wpRightCond            = $("#sizeViewWpRightCond").val();
		sizeData.wpDeviationCond        = $("#sizeViewWpDeviationCond").val();
		sizeData.x1X2Cond               = $("#sizeViewX1X2Cond").val();
		sizeData.ppfWingLeftCond        = $("#sizeViewPpfWingLeftCond").val();
		sizeData.ppfWingRightCond       = $("#sizeViewPpfWingRightCond").val();
		sizeData.metalThicknessCond     = $("#sizeViewMetalThicknessCond").val();
		sizeData.thEdgeCond             = $("#sizeViewThEdgeCond").val();
		sizeData.thCenterCond           = $("#sizeViewThCenterCond").val();
		sizeData.thEdgeRightCond        = $("#sizeViewThEdgeRightCond").val();
		sizeData.burrCond               = $("#sizeViewBurrCond").val();
		sizeData.gapOfLayerCond         = $("#sizeViewGapOfLayerCond").val();
		sizeData.bendingCond            = $("#sizeViewBendingCond").val();

		sizeData.metalDepthAlwncePlus         = $("#sizeViewMetalDepthAlwncePlus").val();
		sizeData.pitchLeftAlwncePlus          = $("#sizeViewPitchLeftAlwncePlus").val();
		sizeData.ppfDepthLeftAlwncePlus       = $("#sizeViewPpfDepthLeftAlwncePlus").val();
		sizeData.ppfDepthCenterAlwncePlus     = $("#sizeViewPpfDepthCenterAlwncePlus").val();
		sizeData.ppfDepthRightAlwncePlus      = $("#sizeViewPpfDepthRightAlwncePlus").val();
		sizeData.filmAlwncePlus               = $("#sizeViewFilmAlwncePlus").val();
		sizeData.wpLeftAlwncePlus             = $("#sizeViewWpLeftAlwncePlus").val();
		sizeData.wpCenterAlwncePlus           = $("#sizeViewWpCenterAlwncePlus").val();
		sizeData.wpRightAlwncePlus            = $("#sizeViewWpRightAlwncePlus").val();
		sizeData.wpDeviationAlwncePlus        = $("#sizeViewWpDeviationAlwncePlus").val();
		sizeData.x1X2AlwncePlus               = $("#sizeViewX1X2AlwncePlus").val();
		sizeData.ppfWingLeftAlwncePlus        = $("#sizeViewPpfWingLeftAlwncePlus").val();
		sizeData.ppfWingRightAlwncePlus       = $("#sizeViewPpfWingRightAlwncePlus").val();
		sizeData.metalThicknessAlwncePlus     = $("#sizeViewMetalThicknessAlwncePlus").val();
		sizeData.thEdgeAlwncePlus             = $("#sizeViewThEdgeAlwncePlus").val();
		sizeData.thCenterAlwncePlus           = $("#sizeViewThCenterAlwncePlus").val();
		sizeData.thEdgeRightAlwncePlus        = $("#sizeViewThEdgeRightAlwncePlus").val();
		sizeData.burrAlwncePlus               = $("#sizeViewBurrAlwncePlus").val();
		sizeData.gapOfLayerAlwncePlus         = $("#sizeViewGapOfLayerAlwncePlus").val();
		sizeData.bendingAlwncePlus            = $("#sizeViewBendingAlwncePlus").val();

		sizeData.metalDepthAlwnceMinus         = $("#sizeViewMetalDepthAlwnceMinus").val();
		sizeData.pitchLeftAlwnceMinus          = $("#sizeViewPitchLeftAlwnceMinus").val();
		sizeData.ppfDepthLeftAlwnceMinus       = $("#sizeViewPpfDepthLeftAlwnceMinus").val();
		sizeData.ppfDepthCenterAlwnceMinus     = $("#sizeViewPpfDepthCenterAlwnceMinus").val();
		sizeData.ppfDepthRightAlwnceMinus      = $("#sizeViewPpfDepthRightAlwnceMinus").val();
		sizeData.filmAlwnceMinus               = $("#sizeViewFilmAlwnceMinus").val();
		sizeData.wpLeftAlwnceMinus             = $("#sizeViewWpLeftAlwnceMinus").val();
		sizeData.wpCenterAlwnceMinus           = $("#sizeViewWpCenterAlwnceMinus").val();
		sizeData.wpRightAlwnceMinus            = $("#sizeViewWpRightAlwnceMinus").val();
		sizeData.wpDeviationAlwnceMinus        = $("#sizeViewWpDeviationAlwnceMinus").val();
		sizeData.x1X2AlwnceMinus               = $("#sizeViewX1X2AlwnceMinus").val();
		sizeData.ppfWingLeftAlwnceMinus        = $("#sizeViewPpfWingLeftAlwnceMinus").val();
		sizeData.ppfWingRightAlwnceMinus       = $("#sizeViewPpfWingRightAlwnceMinus").val();
		sizeData.metalThicknessAlwnceMinus     = $("#sizeViewMetalThicknessAlwnceMinus").val();
		sizeData.thEdgeAlwnceMinus             = $("#sizeViewThEdgeAlwnceMinus").val();
		sizeData.thCenterAlwnceMinus           = $("#sizeViewThCenterAlwnceMinus").val();
		sizeData.thEdgeRightAlwnceMinus        = $("#sizeViewThEdgeRightAlwnceMinus").val();
		sizeData.burrAlwnceMinus               = $("#sizeViewBurrAlwnceMinus").val();
		sizeData.gapOfLayerAlwnceMinus         = $("#sizeViewGapOfLayerAlwnceMinus").val();
		sizeData.bendingAlwnceMinus            = $("#sizeViewBendingAlwnceMinus").val();
		
		dataArray.push(sizeData);
		
		var url = ""
		if (sideView == "create"){
			url = "<c:url value="/em/equipCondCommonAdmCreate"/>";
		}
		else if (sideView == "edit"){
			url = "<c:url value="/em/equipCondCommonAdmEdit"/>";
		}
		else {
			alert("sideView 알수없는 오류");
		}
		
        $.ajax({
            url: url,
            type: 'POST',
			data : JSON.stringify(dataArray),
            dataType : "json",
            contentType : "application/json; charset=UTF-8",
            success: function (res) {
                if (res.result == 'ok') {
             		if (sideView == "create"){
             			toastr.success("설비계획이 등록 되었습니다.");
            		}
            		else if (sideView == "edit"){
            			toastr.success("설비계획이 수정 되었습니다.");
            		}
                }  else {
                	toastr.error(res.message, '', {timeOut: 5000});
                } 
            },
            complete:function(){
            	$('#manufacturerListTable').DataTable().ajax.reload();
           		uiProc(true);
           		$('#tempaturBtn').attr('disabled', true);
           		$('#timeBtn').attr('disabled', true);
           		$('#pressureBtn').attr('disabled', true);
           		$('#sizeBtn').attr('disabled', true);
           		$('#btnSave').attr('disabled', true);
           		$('#btnEdit').attr('disabled', true);
           		$('#btnSelectMatrlCode').attr('disabled', true);
            }
        });
	});

	function uiProc(flag)
   	{ 		
        $("#tempaturViewWarmupCond").attr("disabled",flag);
        $("#tempaturViewWarmupAlwncePlus").attr("disabled",flag);
        $("#tempaturViewWarmupAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFitup1UpCond").attr("disabled",flag);
        $("#tempaturViewFitup1UpAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFitup1UpAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFitup1DownCond").attr("disabled",flag);
        $("#tempaturViewFitup1DownAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFitup1DownAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFitup2UpleftCond").attr("disabled",flag);
        $("#tempaturViewFitup2UpleftAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFitup2UpleftAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFitup2DownleftCond").attr("disabled",flag);
        $("#tempaturViewFitup2DownleftAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFitup2DownleftAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFitup2UprightCond").attr("disabled",flag);
        $("#tempaturViewFitup2UprightAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFitup2UprightAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFitup2DownrightCond").attr("disabled",flag);
        $("#tempaturViewFitup2DownrightAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFitup2DownrightAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewRollheatUpCond").attr("disabled",flag);
        $("#tempaturViewRollheatUpAlwncePlus").attr("disabled",flag);
        $("#tempaturViewRollheatUpAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewRollheatDownCond").attr("disabled",flag);
        $("#tempaturViewRollheatDownAlwncePlus").attr("disabled",flag);
        $("#tempaturViewRollheatDownAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFirstUpleftCond").attr("disabled",flag);
        $("#tempaturViewFirstUpleftAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFirstUpleftAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFirstDownleftCond").attr("disabled",flag);
        $("#tempaturViewFirstDownleftAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFirstDownleftAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFirstUprightCond").attr("disabled",flag);
        $("#tempaturViewFirstUprightAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFirstUprightAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFirstDownrightCond").attr("disabled",flag);
        $("#tempaturViewFirstDownrightAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFirstDownrightAlwnceMinus").attr("disabled",flag);

        $("#tempaturViewPush1UpCond").attr("disabled",flag);
        $("#tempaturViewPush1UpAlwncePlus").attr("disabled",flag);
        $("#tempaturViewPush1UpAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewPush1DownCond").attr("disabled",flag);
        $("#tempaturViewPush1DownAlwncePlus").attr("disabled",flag);
        $("#tempaturViewPush1DownAlwnceMinus").attr("disabled",flag);
        
        $("#tempaturViewSecondUpleftCond").attr("disabled",flag);
        $("#tempaturViewSecondUpleftAlwncePlus").attr("disabled",flag);
        $("#tempaturViewSecondUpleftAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewSecondDownleftCond").attr("disabled",flag);
        $("#tempaturViewSecondDownleftAlwncePlus").attr("disabled",flag);
        $("#tempaturViewSecondDownleftAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewSecondUprightCond").attr("disabled",flag);
        $("#tempaturViewSecondUprightAlwncePlus").attr("disabled",flag);
        $("#tempaturViewSecondUprightAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewSecondDownrightCond").attr("disabled",flag);
        $("#tempaturViewSecondDownrightAlwncePlus").attr("disabled",flag);
        $("#tempaturViewSecondDownrightAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewThirdUpleftCond").attr("disabled",flag);
        $("#tempaturViewThirdUpleftAlwncePlus").attr("disabled",flag);
        $("#tempaturViewThirdUpleftAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewThirdDownleftCond").attr("disabled",flag);
        $("#tempaturViewThirdDownleftAlwncePlus").attr("disabled",flag);
        $("#tempaturViewThirdDownleftAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewThirdUprightCond").attr("disabled",flag);
        $("#tempaturViewThirdUprightAlwncePlus").attr("disabled",flag);
        $("#tempaturViewThirdUprightAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewThirdDownrightCond").attr("disabled",flag);
        $("#tempaturViewThirdDownrightAlwncePlus").attr("disabled",flag);
        $("#tempaturViewThirdDownrightAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewJinjeop1UpCond").attr("disabled",flag);
        $("#tempaturViewJinjeop1UpAlwncePlus").attr("disabled",flag);
        $("#tempaturViewJinjeop1UpAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewJinjeop1DownCond").attr("disabled",flag);
        $("#tempaturViewJinjeop1DownAlwncePlus").attr("disabled",flag);
        $("#tempaturViewJinjeop1DownAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewJinjeop2UpCond").attr("disabled",flag);
        $("#tempaturViewJinjeop2UpAlwncePlus").attr("disabled",flag);
        $("#tempaturViewJinjeop2UpAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewJinjeop2DownCond").attr("disabled",flag);
        $("#tempaturViewJinjeop2DownAlwncePlus").attr("disabled",flag);
        $("#tempaturViewJinjeop2DownAlwnceMinus").attr("disabled",flag);
        
        $("#timeViewWarmupCond").attr("disabled",flag);
        $("#timeViewFitupCond").attr("disabled",flag);
        $("#timeViewFitup2Cond").attr("disabled",flag);
        $("#timeViewFirstCond").attr("disabled",flag);
        $("#timeViewSecondCond").attr("disabled",flag);
        $("#timeViewJinjeopCond").attr("disabled",flag);
        $("#timeViewReformCond").attr("disabled",flag);
        $("#pressureViewWarmupCond").attr("disabled",flag);
        $("#pressureViewFitupCond").attr("disabled",flag);
        //$("#pressureViewFirstCond").attr("disabled",flag);
        //$("#pressureViewSecondCond").attr("disabled",flag);
        $("#pressureViewJinjeopCond").attr("disabled",flag);
        $("#pressureViewReformCond").attr("disabled",flag);

        $("#timeViewJinjeop2Cond").attr("disabled",flag);
        $("#timeViewJinjeop2AlwncePlus").attr("disabled",flag);
        $("#timeViewJinjeop2AlwnceMinus").attr("disabled",flag);
        $("#timeViewPush1Cond").attr("disabled",flag);
        $("#timeViewPush1AlwncePlus").attr("disabled",flag);
        $("#timeViewPush1AlwnceMinus").attr("disabled",flag);
        
        $("#timeViewThirdCond").attr("disabled",flag);
        $("#timeViewThirdAlwncePlus").attr("disabled",flag);
        $("#timeViewThirdAlwnceMinus").attr("disabled",flag);

        
        $("#tempaturViewWarmupAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFitupAlwncePlus").attr("disabled",flag);
        $("#tempaturViewFitup2AlwncePlus").attr("disabled",flag);
        $("#tempaturViewFirstAlwncePlus").attr("disabled",flag);
        $("#tempaturViewSecondAlwncePlus").attr("disabled",flag);
        $("#tempaturViewJinjeopAlwncePlus").attr("disabled",flag);
        $("#tempaturViewReformAlwncePlus").attr("disabled",flag);
        $("#timeViewWarmupAlwncePlus").attr("disabled",flag);
        $("#timeViewFitupAlwncePlus").attr("disabled",flag);
        $("#timeViewFitup2AlwncePlus").attr("disabled",flag);
        $("#timeViewFirstAlwncePlus").attr("disabled",flag);
        $("#timeViewSecondAlwncePlus").attr("disabled",flag);
        $("#timeViewJinjeopAlwncePlus").attr("disabled",flag);
        $("#timeViewReformAlwncePlus").attr("disabled",flag);
        $("#timeViewCoolCond").attr("disabled",flag);
        $("#timeViewCoolAlwncePlus").attr("disabled",flag);
        $("#timeViewCoolAlwnceMinus").attr("disabled",flag); 
        
        $("#pressureViewWarmupAlwncePlus").attr("disabled",flag);
        $("#pressureViewFitupAlwncePlus").attr("disabled",flag);
        //$("#pressureViewFirstAlwncePlus").attr("disabled",flag);
        //$("#pressureViewSecondAlwncePlus").attr("disabled",flag);
        $("#pressureViewJinjeopAlwncePlus").attr("disabled",flag);
        $("#pressureViewReformAlwncePlus").attr("disabled",flag);

        $("#tempaturViewWarmupAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFitupAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFitup2AlwnceMinus").attr("disabled",flag);
        $("#tempaturViewFirstAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewSecondAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewJinjeopAlwnceMinus").attr("disabled",flag);
        $("#tempaturViewReformAlwnceMinus").attr("disabled",flag);
        $("#timeViewWarmupAlwnceMinus").attr("disabled",flag);
        $("#timeViewFitupAlwnceMinus").attr("disabled",flag);
        $("#timeViewFitup2AlwnceMinus").attr("disabled",flag);
        $("#timeViewFirstAlwnceMinus").attr("disabled",flag);
        $("#timeViewSecondAlwnceMinus").attr("disabled",flag);
        $("#timeViewJinjeopAlwnceMinus").attr("disabled",flag);    
        $("#timeViewReformAlwnceMinus").attr("disabled",flag);
        $("#pressureViewWarmupAlwnceMinus").attr("disabled",flag);    
        $("#pressureViewFitupAlwnceMinus").attr("disabled",flag);    
        //$("#pressureViewFirstAlwnceMinus").attr("disabled",flag);    
        //$("#pressureViewSecondAlwnceMinus").attr("disabled",flag);    
        $("#pressureViewJinjeopAlwnceMinus").attr("disabled",flag);    
        $("#pressureViewReformAlwnceMinus").attr("disabled",flag); 

        $("#pressureViewPush1Cond").attr("disabled",flag);
        $("#pressureViewPush1AlwncePlus").attr("disabled",flag);
        $("#pressureViewPush1AlwnceMinus").attr("disabled",flag);
        $("#pressureViewJinjeop2Cond").attr("disabled",flag);
        $("#pressureViewJinjeop2AlwncePlus").attr("disabled",flag);
        $("#pressureViewJinjeop2AlwnceMinus").attr("disabled",flag);
        
        $("#sizeViewWpLeftCond").attr("disabled",flag);
        $("#sizeViewWpRightCond").attr("disabled",flag);
        $("#sizeViewPitchLeftCond").attr("disabled",flag);
        $("#sizeViewPitchRightCond").attr("disabled",flag);
        $("#sizeViewPpfWingLeftCond").attr("disabled",flag);
        $("#sizeViewPpfWingRightCond").attr("disabled",flag);
        $("#sizeViewPpfDepthLeftCond").attr("disabled",flag);
        $("#sizeViewPpfDepthRightCond").attr("disabled",flag);
        $("#sizeViewFilmCond").attr("disabled",flag);
        $("#sizeViewMetalDepthCond").attr("disabled",flag);
        $("#sizeViewMetalThicknessCond").attr("disabled",flag);
        $("#sizeViewThCenterCond").attr("disabled",flag);
        $("#sizeViewThEdgeCond").attr("disabled",flag);
        $("#sizeViewGapOfLayerCond").attr("disabled",flag);
        
        $("#sizeViewBurrCond").attr("disabled",flag);
        $("#sizeViewWpLeftAlwncePlus").attr("disabled",flag);
		$("#sizeViewWpRightAlwncePlus").attr("disabled",flag);
        $("#sizeViewPitchLeftAlwncePlus").attr("disabled",flag);
        $("#sizeViewPitchRightAlwncePlus").attr("disabled",flag);
        $("#sizeViewPpfWingLeftAlwncePlus").attr("disabled",flag);
        $("#sizeViewPpfWingRightAlwncePlus").attr("disabled",flag);
        $("#sizeViewPpfDepthLeftAlwncePlus").attr("disabled",flag);
        $("#sizeViewPpfDepthRightAlwncePlus").attr("disabled",flag);
        $("#sizeViewFilmAlwncePlus").attr("disabled",flag);
        $("#sizeViewMetalDepthAlwncePlus").attr("disabled",flag);
        $("#sizeViewMetalThicknessAlwncePlus").attr("disabled",flag);
        $("#sizeViewThCenterAlwncePlus").attr("disabled",flag);
        $("#sizeViewThEdgeAlwncePlus").attr("disabled",flag);
        $("#sizeViewGapOfLayerAlwncePlus").attr("disabled",flag);
        $("#sizeViewBurrAlwncePlus").attr("disabled",flag);

        $("#sizeViewWpLeftAlwnceMinus").attr("disabled",flag);
        $("#sizeViewWpRightAlwnceMinus").attr("disabled",flag);
        $("#sizeViewPitchLeftAlwnceMinus").attr("disabled",flag);
        $("#sizeViewPitchRightAlwnceMinus").attr("disabled",flag);
        $("#sizeViewPpfWingLeftAlwnceMinus").attr("disabled",flag);
        $("#sizeViewPpfWingRightAlwnceMinus").attr("disabled",flag);
        $("#sizeViewPpfDepthLeftAlwnceMinus").attr("disabled",flag);
        $("#sizeViewPpfDepthRightAlwnceMinus").attr("disabled",flag);
        $("#sizeViewFilmAlwnceMinus").attr("disabled",flag);
        $("#sizeViewMetalDepthAlwnceMinus").attr("disabled",flag);
        $("#sizeViewMetalThicknessAlwnceMinus").attr("disabled",flag);
        $("#sizeViewThCenterAlwnceMinus").attr("disabled",flag);
        $("#sizeViewThEdgeAlwnceMinus").attr("disabled",flag);
        $("#sizeViewGapOfLayerAlwnceMinus").attr("disabled",flag);
        $("#sizeViewBurrAlwnceMinus").attr("disabled",flag);

        $("#sizeViewWpCenterCond").attr("disabled",flag);             
        $("#sizeViewWpCenterAlwncePlus").attr("disabled",flag);       
        $("#sizeViewWpCenterAlwnceMinus").attr("disabled",flag);      
        $("#sizeViewPpfDepthCenterCond").attr("disabled",flag);       
        $("#sizeViewPpfDepthCenterAlwncePlus").attr("disabled",flag); 
        $("#sizeViewPpfDepthCenterAlwnceMinus").attr("disabled",flag);
        $("#sizeViewWpDeviationCond").attr("disabled",flag);          
        $("#sizeViewWpDeviationAlwncePlus").attr("disabled",flag);    
        $("#sizeViewWpDeviationAlwnceMinus").attr("disabled",flag);   
        $("#sizeViewX1X2Cond").attr("disabled",flag);                 
        $("#sizeViewX1X2AlwncePlus").attr("disabled",flag);           
        $("#sizeViewX1X2AlwnceMinus").attr("disabled",flag);          
        $("#sizeViewThEdgeRightCond").attr("disabled",flag);          
        $("#sizeViewThEdgeRightAlwncePlus").attr("disabled",flag);    
        $("#sizeViewThEdgeRightAlwnceMinus").attr("disabled",flag);   
        $("#sizeViewBendingCond").attr("disabled",flag);              
        $("#sizeViewBendingAlwncePlus").attr("disabled",flag);        
        $("#sizeViewBendingAlwnceMinus").attr("disabled",flag);       
        

        $('#fpUseYn').attr("disabled",flag);
        $('#fpMainGubun').attr("disabled",flag);
   	}

	//제품코드조회 팝업 시작
   	var goodsCdPopUpTable;
   	function selectGoodsCode()
   	{
		if(goodsCdPopUpTable == null || goodsCdPopUpTable == undefined)	{
			goodsCdPopUpTable = $('#goodsCdPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/bm/goodsCodeDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'goodsCd',
		        columns: [
		            { data: 'goodsCd' },
		            { data: 'goodsNm' },
		            { data: 'model' },
		            { data: 'modelNo' },
		            { data: 'alnicuMatrlNm' },
		            { data: 'alnicuMatrlCd' },
		            { data: 'filmMatrlCd' },		            		            
		        ],
		        columnDefs: [
		        	{ "targets": [0], "visible" : true },
		        	{"className": "text-center", "targets": "_all"}
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [
		        ],
		    });

		    $('#goodsCdPopUpTable tbody').on('click', 'tr', function () {
		    	var goodsCd = goodsCdPopUpTable.row(this).data().goodsCd;
                $.ajax({
                    url: '<c:url value="/em/manufacturerData"/>',
                    type: 'GET',
                    data: {
                    	'menuAuth'	 : menuAuth,
                        'goodsCd': goodsCd,
                    },
                    success: function (res) {
                    	let data = res.data;
    					if (res.result == 'ok') {
    						let data = res.data;
   	                        // 보기
   	                   		$('#addFormGoodsCd').text(data.goodsCd);
   	                   		$('#addFormGoodsNm').val(data.goodsNm);
   	                   		$('#addFormQutyNm').text(data.alniQutyNm);
   	                   		$('#addFormModel').text(data.model);
   	                   		$('#addFormAlniThickness').text(data.alniThickness);//두께
   	                   		$('#addFormAlniDepth').text(data.alniDepth);     	//폭
   	                   		$('#addFormAlniWidth').text(data.alniWidth);     	//너비
   	                   		$('#addFormAlniLength').text(data.alniLength);    	//길이
   	                   		$('#addFormAlniPtich').text(data.alniPitch);     	//피치
   	                   		$('#addFormFilmQutyNm').text(data.filmQutyNm);     	  //필름명  
   	                   		$('#addFormFilmThickness').text(data.filmThickness);  //필름 두께
   	                   		$('#addFormFilmDepth').text(data.filmDepth);     	  //필름 규격
   	                   		$('#addFormFilmMatrlDesc').text(data.filmMatrlDesc);  //필름 비고
   	             			$('#btnSave').attr('disabled', false);
    					} else {
    	                	toastr.error(res.message, '', {timeOut: 5000});
    					}
                        $('#goodsPopUpModal').modal('hide');
                    }
                });
		    });
		} else{
			$('#goodsCdPopUpTable').DataTable().ajax.reload();
		}
		
		$('#goodsPopUpModal').modal('show');		
   	}
  	//제품코드조회 팝업 종료

  	//온도 조회 팝업 시작
   	var tempaturTable;
   	function tempaturList()
   	{	
		if(tempaturTable == null || tempaturTable == undefined)	{
			tempaturTable = $('#tempaturTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        scrollX: true,			//가로스크롤
		        ajax: {
				    url: "bm/tempaturDataList",
				    type: 'GET',
				    data: {
				    	'menuAuth'	 : menuAuth,
				    },
				},
				rowId: 'tempaturCondCd',
				columns: [
					{ data: 'tempaturCondCd' },
					{ data: 'tempaturCondNm' },
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['warmupAlwnceMinus'].concat(' ['.concat(row['warmupCond'].concat('] +').concat(row['warmupAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitup1UpAlwnceMinus'].concat(' ['.concat(row['fitup1UpCond'].concat('] +').concat(row['fitup1UpAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitup1DownAlwnceMinus'].concat(' ['.concat(row['fitup1DownCond'].concat('] +').concat(row['fitup1DownAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitup2UpleftAlwnceMinus'].concat(' ['.concat(row['fitup2UpleftCond'].concat('] +').concat(row['fitup2UpleftAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitup2DownleftAlwnceMinus'].concat(' ['.concat(row['fitup2DownleftCond'].concat('] +').concat(row['fitup2DownleftAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitup2UprightAlwnceMinus'].concat(' ['.concat(row['fitup2UprightCond'].concat('] +').concat(row['fitup2UprightAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitup2DownrightAlwnceMinus'].concat(' ['.concat(row['fitup2DownrightCond'].concat('] +').concat(row['fitup2DownrightAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['rollheatUpAlwnceMinus'].concat(' ['.concat(row['rollheatUpCond'].concat('] +').concat(row['rollheatUpAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['rollheatDownAlwnceMinus'].concat(' ['.concat(row['rollheatDownCond'].concat('] +').concat(row['rollheatDownAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['firstUpleftAlwnceMinus'].concat(' ['.concat(row['firstUpleftCond'].concat('] +').concat(row['firstUpleftAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['firstDownleftAlwnceMinus'].concat(' ['.concat(row['firstDownleftCond'].concat('] +').concat(row['firstDownleftAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['firstUprightAlwnceMinus'].concat(' ['.concat(row['firstUprightCond'].concat('] +').concat(row['firstUprightAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['firstDownrightAlwnceMinus'].concat(' ['.concat(row['firstDownrightCond'].concat('] +').concat(row['firstDownrightAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['push1UpAlwnceMinus'].concat(' ['.concat(row['push1UpCond'].concat('] +').concat(row['push1UpAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['push1DownAlwnceMinus'].concat(' ['.concat(row['push1DownCond'].concat('] +').concat(row['push1DownAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['secondUpleftAlwnceMinus'].concat(' ['.concat(row['secondUpleftCond'].concat('] +').concat(row['secondUpleftAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['secondDownleftAlwnceMinus'].concat(' ['.concat(row['secondDownleftCond'].concat('] +').concat(row['secondDownleftAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['secondUprightAlwnceMinus'].concat(' ['.concat(row['secondUprightCond'].concat('] +').concat(row['secondUprightAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['secondDownrightAlwnceMinus'].concat(' ['.concat(row['secondDownrightCond'].concat('] +').concat(row['secondDownrightAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['thirdUpleftAlwnceMinus'].concat(' ['.concat(row['thirdUpleftCond'].concat('] +').concat(row['thirdUpleftAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['thirdDownleftAlwnceMinus'].concat(' ['.concat(row['thirdDownleftCond'].concat('] +').concat(row['thirdDownleftAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['thirdUprightAlwnceMinus'].concat(' ['.concat(row['thirdUprightCond'].concat('] +').concat(row['thirdUprightAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['thirdDownrightAlwnceMinus'].concat(' ['.concat(row['thirdDownrightCond'].concat('] +').concat(row['thirdDownrightAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['jinjeop1UpAlwnceMinus'].concat(' ['.concat(row['jinjeop1UpCond'].concat('] +').concat(row['jinjeop1UpAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['jinjeop1DownAlwnceMinus'].concat(' ['.concat(row['jinjeop1DownCond'].concat('] +').concat(row['jinjeop1DownAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['jinjeop2UpAlwnceMinus'].concat(' ['.concat(row['jinjeop2UpCond'].concat('] +').concat(row['jinjeop2UpAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['jinjeop2DownAlwnceMinus'].concat(' ['.concat(row['jinjeop2DownCond'].concat('] +').concat(row['jinjeop2DownAlwncePlus']))));
		                }
		            },
				],
				order: [
					[ 0, 'asc' ],
				],
				columnDefs: [
				       {"className": "text-center", "targets": "_all"}
				],
		    });

			$('#tempaturTable tbody').on('click', 'tr', function () {
		    	tempaturCondCd = $(this).closest('tr').attr('id');
		         $.ajax({
		            url: '<c:url value="/bm/tempaturView"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
		                'tempaturCondCd': tempaturCondCd
		            },
                    success: function (res) {
                        let data = res.data;
                        $('#tempaturViewWarmupCond').val(data.warmupCond);
                        $('#tempaturViewWarmupAlwncePlus').val(data.warmupAlwncePlus);
                        $('#tempaturViewWarmupAlwnceMinus').val(data.warmupAlwnceMinus);
                        $('#tempaturViewFitup1UpCond').val(data.fitup1UpCond);
                        $('#tempaturViewFitup1UpAlwncePlus').val(data.fitup1UpAlwncePlus);
                        $('#tempaturViewFitup1UpAlwnceMinus').val(data.fitup1UpAlwnceMinus);
                        $('#tempaturViewFitup1DownCond').val(data.fitup1DownCond);
                        $('#tempaturViewFitup1DownAlwncePlus').val(data.fitup1DownAlwncePlus);
                        $('#tempaturViewFitup1DownAlwnceMinus').val(data.fitup1DownAlwnceMinus);
                        $('#tempaturViewFitup2UpleftCond').val(data.fitup2UpleftCond);
                        $('#tempaturViewFitup2UpleftAlwncePlus').val(data.fitup2UpleftAlwncePlus);
                        $('#tempaturViewFitup2UpleftAlwnceMinus').val(data.fitup2UpleftAlwnceMinus);
                        $('#tempaturViewFitup2DownleftCond').val(data.fitup2DownleftCond);
                        $('#tempaturViewFitup2DownleftAlwncePlus').val(data.fitup2DownleftAlwncePlus);
                        $('#tempaturViewFitup2DownleftAlwnceMinus').val(data.fitup2DownleftAlwnceMinus);
                        $('#tempaturViewFitup2UprightCond').val(data.fitup2UprightCond);
                        $('#tempaturViewFitup2UprightAlwncePlus').val(data.fitup2UprightAlwncePlus);
                        $('#tempaturViewFitup2UprightAlwnceMinus').val(data.fitup2UprightAlwnceMinus);
                        $('#tempaturViewFitup2DownrightCond').val(data.fitup2DownrightCond);
                        $('#tempaturViewFitup2DownrightAlwncePlus').val(data.fitup2DownrightAlwncePlus);
                        $('#tempaturViewFitup2DownrightAlwnceMinus').val(data.fitup2DownrightAlwnceMinus);
                        $('#tempaturViewRollheatUpCond').val(data.rollheatUpCond);
                        $('#tempaturViewRollheatUpAlwncePlus').val(data.rollheatUpAlwncePlus);
                        $('#tempaturViewRollheatUpAlwnceMinus').val(data.rollheatUpAlwnceMinus);
                        $('#tempaturViewRollheatDownCond').val(data.rollheatDownCond);
                        $('#tempaturViewRollheatDownAlwncePlus').val(data.rollheatDownAlwncePlus);
                        $('#tempaturViewRollheatDownAlwnceMinus').val(data.rollheatDownAlwnceMinus);
                        $('#tempaturViewFirstUpleftCond').val(data.firstUpleftCond);
                        $('#tempaturViewFirstUpleftAlwncePlus').val(data.firstUpleftAlwncePlus);
                        $('#tempaturViewFirstUpleftAlwnceMinus').val(data.firstUpleftAlwnceMinus);
                        $('#tempaturViewFirstDownleftCond').val(data.firstDownleftCond);
                        $('#tempaturViewFirstDownleftAlwncePlus').val(data.firstDownleftAlwncePlus);
                        $('#tempaturViewFirstDownleftAlwnceMinus').val(data.firstDownleftAlwnceMinus);
                        $('#tempaturViewFirstUprightCond').val(data.firstUprightCond);
                        $('#tempaturViewFirstUprightAlwncePlus').val(data.firstUprightAlwncePlus);
                        $('#tempaturViewFirstUprightAlwnceMinus').val(data.firstUprightAlwnceMinus);
                        $('#tempaturViewFirstDownrightCond').val(data.firstDownrightCond);
                        $('#tempaturViewFirstDownrightAlwncePlus').val(data.firstDownrightAlwncePlus);
                        $('#tempaturViewFirstDownrightAlwnceMinus').val(data.firstDownrightAlwnceMinus);

                        $('#tempaturViewPush1UpCond').val(data.push1UpCond);
                        $('#tempaturViewPush1UpAlwncePlus').val(data.push1UpAlwncePlus);
                        $('#tempaturViewPush1UpAlwnceMinus').val(data.push1UpAlwnceMinus);
                        $('#tempaturViewPush1DownCond').val(data.push1DownCond);
                        $('#tempaturViewPush1DownAlwncePlus').val(data.push1DownAlwncePlus);
                        $('#tempaturViewPush1DownAlwnceMinus').val(data.push1DownAlwnceMinus);
                        
                        $('#tempaturViewSecondUpleftCond').val(data.secondUpleftCond);
                        $('#tempaturViewSecondUpleftAlwncePlus').val(data.secondUpleftAlwncePlus);
                        $('#tempaturViewSecondUpleftAlwnceMinus').val(data.secondUpleftAlwnceMinus);
                        $('#tempaturViewSecondDownleftCond').val(data.secondDownleftCond);
                        $('#tempaturViewSecondDownleftAlwncePlus').val(data.secondDownleftAlwncePlus);
                        $('#tempaturViewSecondDownleftAlwnceMinus').val(data.secondDownleftAlwnceMinus);
                        $('#tempaturViewSecondUprightCond').val(data.secondUprightCond);
                        $('#tempaturViewSecondUprightAlwncePlus').val(data.secondUprightAlwncePlus);
                        $('#tempaturViewSecondUprightAlwnceMinus').val(data.secondUprightAlwnceMinus);
                        $('#tempaturViewSecondDownrightCond').val(data.secondDownrightCond);
                        $('#tempaturViewSecondDownrightAlwncePlus').val(data.secondDownrightAlwncePlus);
                        $('#tempaturViewSecondDownrightAlwnceMinus').val(data.secondDownrightAlwnceMinus);
                        $('#tempaturViewThirdUpleftCond').val(data.thirdUpleftCond);
                        $('#tempaturViewThirdUpleftAlwncePlus').val(data.thirdUpleftAlwncePlus);
                        $('#tempaturViewThirdUpleftAlwnceMinus').val(data.thirdUpleftAlwnceMinus);
                        $('#tempaturViewThirdDownleftCond').val(data.thirdDownleftCond);
                        $('#tempaturViewThirdDownleftAlwncePlus').val(data.thirdDownleftAlwncePlus);
                        $('#tempaturViewThirdDownleftAlwnceMinus').val(data.thirdDownleftAlwnceMinus);
                        $('#tempaturViewThirdUprightCond').val(data.thirdUprightCond);
                        $('#tempaturViewThirdUprightAlwncePlus').val(data.thirdUprightAlwncePlus);
                        $('#tempaturViewThirdUprightAlwnceMinus').val(data.thirdUprightAlwnceMinus);
                        $('#tempaturViewThirdDownrightCond').val(data.thirdDownrightCond);
                        $('#tempaturViewThirdDownrightAlwncePlus').val(data.thirdDownrightAlwncePlus);
                        $('#tempaturViewThirdDownrightAlwnceMinus').val(data.thirdDownrightAlwnceMinus);
                        $('#tempaturViewJinjeop1UpCond').val(data.jinjeop1UpCond);
                        $('#tempaturViewJinjeop1UpAlwncePlus').val(data.jinjeop1UpAlwncePlus);
                        $('#tempaturViewJinjeop1UpAlwnceMinus').val(data.jinjeop1UpAlwnceMinus);
                        $('#tempaturViewJinjeop1DownCond').val(data.jinjeop1DownCond);
                        $('#tempaturViewJinjeop1DownAlwncePlus').val(data.jinjeop1DownAlwncePlus);
                        $('#tempaturViewJinjeop1DownAlwnceMinus').val(data.jinjeop1DownAlwnceMinus);
                        $('#tempaturViewJinjeop2UpCond').val(data.jinjeop2UpCond);
                        $('#tempaturViewJinjeop2UpAlwncePlus').val(data.jinjeop2UpAlwncePlus);
                        $('#tempaturViewJinjeop2UpAlwnceMinus').val(data.jinjeop2UpAlwnceMinus);
                        $('#tempaturViewJinjeop2DownCond').val(data.jinjeop2DownCond);
                        $('#tempaturViewJinjeop2DownAlwncePlus').val(data.jinjeop2DownAlwncePlus);
                        $('#tempaturViewJinjeop2DownAlwnceMinus').val(data.jinjeop2DownAlwnceMinus);
                        
                        $('#tempaturModal').modal('hide');
                    }
                });
		    });
		} else{
			$('#tempaturTable').DataTable().ajax.reload();
		}
		
		$('#tempaturModal').modal('show');
   	}
  	//온도 조회 팝업 종료
  	
  	//시간 조회 팝업 시작
   	var timeTable;
   	function timeList()
   	{
		if(timeTable == null || timeTable == undefined)	{
			timeTable = $('#timeTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
				    url: "bm/timeDataList",
				    type: 'GET',
				    data: {
				    	'menuAuth'	 : menuAuth,
				    },
				},
				rowId: 'timeCondCd',
				columns: [
					{ data: 'timeCondCd' },
					{ data: 'timeCondNm' },
					/* 
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['warmupAlwnceMinus'].concat(' ['.concat(row['warmupCond'].concat('] +').concat(row['warmupAlwnceMinus']))));
		                }
		            },
		             */
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitupAlwnceMinus'].concat(' ['.concat(row['fitupCond'].concat('] +').concat(row['fitupAlwncePlus']))));
		                }
		            },
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitup2AlwnceMinus'].concat(' ['.concat(row['fitup2Cond'].concat('] +').concat(row['fitup2AlwncePlus']))));
		                }
		            },
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['firstAlwnceMinus'].concat(' ['.concat(row['firstCond'].concat('] +').concat(row['firstAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['push1AlwnceMinus'].concat(' ['.concat(row['push1Cond'].concat('] +').concat(row['push1AlwncePlus']))));
		                }
		            },
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['secondAlwnceMinus'].concat(' ['.concat(row['secondCond'].concat('] +').concat(row['secondAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['thirdAlwnceMinus'].concat(' ['.concat(row['thirdCond'].concat('] +').concat(row['thirdAlwncePlus']))));
		                }
		            },
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['jinjeopAlwnceMinus'].concat(' ['.concat(row['jinjeopCond'].concat('] +').concat(row['jinjeopAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['jinjeop2AlwnceMinus'].concat(' ['.concat(row['jinjeop2Cond'].concat('] +').concat(row['jinjeop2AlwncePlus']))));
		                }
		            },
		            
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['reformAlwnceMinus'].concat(' ['.concat(row['reformCond'].concat('] +').concat(row['reformAlwncePlus']))));
		                }
		            },

		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['coolAlwnceMinus'].concat(' ['.concat(row['coolCond'].concat('] +').concat(row['coolAlwncePlus']))));
		                }
		            },
		            
				],
				order: [
					[ 0, 'asc' ],
				],
				columnDefs: [
				       {"className": "text-center", "targets": "_all"}
				],
		    });

			$('#timeTable tbody').on('click', 'tr', function () {
		    	timeCondCd = $(this).closest('tr').attr('id');
		         $.ajax({
		            url: '<c:url value="/bm/timeView"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
		                'timeCondCd': timeCondCd
		            },
                    success: function (res) {
                        let data = res.data;
                        /* 
                        $('#timeViewWarmupCond').val(data.warmupCond);
                        $('#timeViewWarmupAlwncePlus').val(data.warmupAlwncePlus);
                        $('#timeViewWarmupAlwnceMinus').val(data.warmupAlwnceMinus);
                         */
                        $('#timeViewFitupCond').val(data.fitupCond);
                        $('#timeViewFitupAlwncePlus').val(data.fitupAlwncePlus);
                        $('#timeViewFitupAlwnceMinus').val(data.fitupAlwnceMinus);
                        $('#timeViewFitup2Cond').val(data.fitup2Cond);
                        $('#timeViewFitup2AlwncePlus').val(data.fitup2AlwncePlus);
                        $('#timeViewFitup2AlwnceMinus').val(data.fitup2AlwnceMinus);
                        $('#timeViewFirstCond').val(data.firstCond);
                        $('#timeViewFirstAlwncePlus').val(data.firstAlwncePlus);
                        $('#timeViewFirstAlwnceMinus').val(data.firstAlwnceMinus);
                        $('#timeViewPush1Cond').val(data.push1Cond);
                        $('#timeViewPush1AlwncePlus').val(data.push1AlwncePlus);
                        $('#timeViewPush1AlwnceMinus').val(data.push1AlwnceMinus);
                        $('#timeViewSecondCond').val(data.secondCond);
                        $('#timeViewSecondAlwncePlus').val(data.secondAlwncePlus);
                        $('#timeViewSecondAlwnceMinus').val(data.secondAlwnceMinus);
                        $('#timeViewThirdCond').val(data.thirdCond);
                        $('#timeViewThirdAlwncePlus').val(data.thirdAlwncePlus);
                        $('#timeViewThirdAlwnceMinus').val(data.thirdAlwnceMinus);
                        $('#timeViewJinjeopCond').val(data.jinjeopCond);
                        $('#timeViewJinjeopAlwncePlus').val(data.jinjeopAlwncePlus);
                        $('#timeViewJinjeopAlwnceMinus').val(data.jinjeopAlwnceMinus);
                        $('#timeViewJinjeop2Cond').val(data.jinjeop2Cond);
                        $('#timeViewJinjeop2AlwncePlus').val(data.jinjeop2AlwncePlus);
                        $('#timeViewJinjeop2AlwnceMinus').val(data.jinjeop2AlwnceMinus);
                        $('#timeViewReformCond').val(data.reformCond);
                        $('#timeViewReformAlwncePlus').val(data.reformAlwncePlus);
                        $('#timeViewReformAlwnceMinus').val(data.reformAlwnceMinus);

                        $('#timeViewCoolCond').val(data.coolCond);
                        $('#timeViewCoolAlwncePlus').val(data.coolAlwncePlus);
                        $('#timeViewCoolAlwnceMinus').val(data.coolAlwnceMinus);

                        $('#timeModal').modal('hide');
                    }
                });
		    });
		} else {
			$('#timeTable').DataTable().ajax.reload();
		}
		
		$('#timeModal').modal('show');		
   	}
  	//시간 조회 팝업 종료
  	
  	//압력 조회 팝업 시작
   	var pressureTable;
   	function pressureList()
   	{
		if(pressureTable == null || pressureTable == undefined)	{
			pressureTable = $('#pressureTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
				    url: "bm/pressureDataList",
				    type: 'GET',
				    data: {
				    	'menuAuth'	 : menuAuth,
				    },
				},
				rowId: 'pressureCondCd',
				columns: [
					{ data: 'pressureCondCd' },
					{ data: 'pressureCondNm' },
					/* 
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['warmupAlwnceMinus'].concat(' ['.concat(row['warmupCond'].concat('] +').concat(row['warmupAlwnceMinus']))));
		                }
		            },
		             */
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['fitupAlwnceMinus'].concat(' ['.concat(row['fitupCond'].concat('] +').concat(row['fitupAlwncePlus']))));
		                }
		            },
					//{
		            //    render: function(data, type, row) {
		            //        return '-'.concat(row['firstAlwnceMinus'].concat(' ['.concat(row['firstCond'].concat('] +').concat(row['firstAlwncePlus']))));
		            //    }
		            //},
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['push1AlwnceMinus'].concat(' ['.concat(row['push1Cond'].concat('] +').concat(row['push1AlwncePlus']))));
		                }
		            },
					//{
		            //    render: function(data, type, row) {
		            //        return '-'.concat(row['secondAlwnceMinus'].concat(' ['.concat(row['secondCond'].concat('] +').concat(row['secondAlwncePlus']))));
		            //    }
		            //},
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['jinjeopAlwnceMinus'].concat(' ['.concat(row['jinjeopCond'].concat('] +').concat(row['jinjeopAlwncePlus']))));
		                }
		            },
		            {
		                render: function(data, type, row) {
		                    return '-'.concat(row['jinjeop2AlwnceMinus'].concat(' ['.concat(row['jinjeop2Cond'].concat('] +').concat(row['jinjeop2AlwncePlus']))));
		                }
		            },
		            /* 
					{
		                render: function(data, type, row) {
		                    return '-'.concat(row['reformAlwnceMinus'].concat(' ['.concat(row['reformCond'].concat('] +').concat(row['reformAlwncePlus']))));
		                }
		            },
		             */
				],
				order: [
					[ 0, 'asc' ],
				],
				columnDefs: [
				       {"className": "text-center", "targets": "_all"}
				],
		    });

			$('#pressureTable tbody').on('click', 'tr', function () {
		    	pressureCondCd = $(this).closest('tr').attr('id');
		         $.ajax({
		            url: '<c:url value="/bm/pressureView"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
		                'pressureCondCd': pressureCondCd
		            },
                    success: function (res) {
                        let data = res.data;
                        /* 
                        $('#pressureViewWarmupCond').val(data.warmupCond);
                        $('#pressureViewWarmupAlwncePlus').val(data.warmupAlwncePlus);
                        $('#pressureViewWarmupAlwnceMinus').val(data.warmupAlwnceMinus);
                         */
                        $('#pressureViewFitupCond').val(data.fitupCond);
                        $('#pressureViewFitupAlwncePlus').val(data.fitupAlwncePlus);
                        $('#pressureViewFitupAlwnceMinus').val(data.fitupAlwnceMinus);
                        
                        //$('#pressureViewFirstCond').val(data.firstCond);
                        //$('#pressureViewFirstAlwncePlus').val(data.firstAlwncePlus);
                        //$('#pressureViewFirstAlwnceMinus').val(data.firstAlwnceMinus);
                        $('#pressureViewPush1Cond').val(data.push1Cond);
                        $('#pressureViewPush1AlwncePlus').val(data.push1AlwncePlus);
                        $('#pressureViewPush1AlwnceMinus').val(data.push1AlwnceMinus);
                        
                        $('#pressureViewSecondCond').val(data.secondCond);
                        $('#pressureViewSecondAlwncePlus').val(data.secondAlwncePlus);
                        $('#pressureViewSecondAlwnceMinus').val(data.secondAlwnceMinus);
                        $('#pressureViewJinjeopCond').val(data.jinjeopCond);
                        $('#pressureViewJinjeopAlwncePlus').val(data.jinjeopAlwncePlus);
                        $('#pressureViewJinjeopAlwnceMinus').val(data.jinjeopAlwnceMinus);

                        $('#pressureViewJinjeop2Cond').val(data.jinjeop2Cond);
                        $('#pressureViewJinjeop2AlwncePlus').val(data.jinjeop2AlwncePlus);
                        $('#pressureViewJinjeop2AlwnceMinus').val(data.jinjeop2AlwnceMinus);

                        /* 
                        $('#pressureViewReformCond').val(data.reformCond);
                        $('#pressureViewReformAlwncePlus').val(data.reformAlwncePlus);
                        $('#pressureViewReformAlwnceMinus').val(data.reformAlwnceMinus);
                         */

                        $('#pressureModal').modal('hide');
                    }
                });
		    });
		} else{
			$('#pressureTable').DataTable().ajax.reload();
		}
		$('#pressureModal').modal('show');		
   	}
  	//압력 조회 팝업 종료
  	
  	//치수 조회 팝업 시작
   	var sizeTable;
   	function sizeList()
   	{
		if(sizeTable == null || sizeTable == undefined)	{
			sizeTable = $('#sizeTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        scrollX: true,			//가로스크롤
		        ajax: {
				    url: "bm/sizeDataList",
				    type: 'GET',
				    data: {
				    	'menuAuth'	 : menuAuth,
				    },
				},
				rowId: 'sizeCondCd',
				columns: [
					{ data: 'sizeCondCd' },
					{ data: 'sizeCondNm' },

					{
		                render: function(data, type, row) {			   
		                	if(row['metalDepthCond'] != null){
		                		 return '-' + row['metalDepthAlwnceMinus']+' ['+ row['metalDepthCond'] + '] +' + row['metalDepthAlwncePlus'];
		                	}             		                   
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['pitchLeftCond'] != null){
		                		 return '-' + row['pitchLeftAlwnceMinus'] + ' [' + row['pitchLeftCond'] + '] +' + row['pitchLeftAlwncePlus'];
		                	} 
		                   
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['ppfDepthLeftCond'] != null){
		                		return '-' + row['ppfDepthLeftAlwnceMinus'] + ' [' + row['ppfDepthLeftCond'] + '] +' + row['ppfDepthLeftAlwncePlus'];
		                	} 
		                    
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['ppfDepthCenterCond'] != null){
		                		 return '-' + row['ppfDepthCenterAlwnceMinus'] + ' [' + row['ppfDepthCenterCond'] + '] +' + row['ppfDepthCenterAlwncePlus'];
				            }
		                   
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['ppfDepthRightCond'] != null){
		                		return '-' + row['ppfDepthRightAlwnceMinus'] + ' [' + row['ppfDepthRightCond'] + '] +' + row['ppfDepthRightAlwncePlus'];
		                	} 
		                    
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['filmCond'] != null){
		                		return '-' + row['filmAlwnceMinus'] + ' [' + row['filmCond'] + '] +' + row['filmAlwncePlus'];
		                	} 
		                    
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['wpLeftCond'] != null){
		                		 return '-' + row['wpLeftAlwnceMinus'] + ' [' + row['wpLeftCond'] + '] +' + row['wpLeftAlwncePlus'];
		                	} 
		                   
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['wpCenterCond'] != null){
		                		return '-' + row['wpCenterAlwnceMinus'] + ' [' + row['wpCenterCond'] + '] +' + row['wpCenterAlwncePlus'];
		                	} 
		                    
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['wpRightCond'] != null){
		                		return '-' + row['wpRightAlwnceMinus'] + ' [' + row['wpRightCond'] + '] +' + row['wpRightAlwncePlus'];
		                	} 
		                    
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['wpDeviationCond'] != null){
		                		return '-' + row['wpDeviationAlwnceMinus'] + ' [' + row['wpDeviationCond'] + '] +' + row['wpDeviationAlwncePlus'];
		                	} 
		                    
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['x1X2Cond'] != null){
		                		return '-' + row['x1X2AlwnceMinus'] + ' [' + row['x1X2Cond'] + '] +' + row['x1X2AlwncePlus'];
		                	} 
		                    
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['ppfWingLeftCond'] != null){
		                		return '-' + row['ppfWingLeftAlwnceMinus'] + ' [' + row['ppfWingLeftCond'] + '] +' + row['ppfWingLeftAlwncePlus'];
		                	} 
		                    
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['ppfWingRightCond'] != null){
		                		return '-' + row['ppfWingRightAlwnceMinus'] + ' [' + row['ppfWingRightCond'] + '] +' + row['ppfWingRightAlwncePlus'];
		                	} 
		                    
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['metalThicknessCond'] != null){
		                		return '-' + row['metalThicknessAlwnceMinus'] + ' [' + row['metalThicknessCond'] + '] +' + row['metalThicknessAlwncePlus'];
		                	} 
		                    
		                }
		            },
					{
		                render: function(data, type, row) {
		                	if(row['thEdgeCond'] != null){
		                		return '-' + row['thEdgeAlwnceMinus'] + ' [' + row['thEdgeCond'] + '] +' + row['thEdgeAlwncePlus'];
		                	} 
		                    
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['thCenterCond'] != null){
		                		return '-' + row['thCenterAlwnceMinus'] + ' [' + row['thCenterCond'] + '] +' + row['thCenterAlwncePlus'];
		                	} 
		                    
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['thEdgeRightCond'] != null){
		                		return '-' + row['thEdgeRightAlwnceMinus'] + ' [' + row['thEdgeRightCond'] + '] +' + row['thEdgeRightAlwncePlus'];
		                	} 
		                    
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['burrCond'] != null){
		                		return '-' + row['burrAlwnceMinus'] + ' [' + row['burrCond'] + '] +' + row['burrAlwncePlus'];
		                	} 
		                    
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['gapOfLayerCond'] != null){
		                		return '-' + row['gapOfLayerMinus'] + ' [' + row['gapOfLayerCond'] + '] +' + row['gapOfLayerPlus'];
		                	} 
		                    
		                }
		            },
		            {
		                render: function(data, type, row) {
		                	if(row['bendingCond'] != null){
		                		return '-' + row['bendingAlwnceMinus'] + ' [' + row['bendingCond'] + '] +' + row['bendingAlwncePlus'];
		                	} 
		                }
		            },
				],
				order: [
					[ 0, 'asc' ],
				],
				columnDefs: [
				       {"className": "text-center", "targets": "_all"}
				],
		    });

			$('#sizeTable tbody').on('click', 'tr', function () {
		    	sizeCondCd = $(this).closest('tr').attr('id');
		         $.ajax({
		            url: '<c:url value="/bm/sizeView"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
		                'sizeCondCd': sizeCondCd
		            },
                    success: function (res) {
                        let data = res.data;

                        $('#sizeViewSizeCondCd').val(data.sizeCondCd);                              
                        $('#sizeViewSizeCondNm').val(data.sizeCondNm);  


                        $('#sizeViewMetalDepthCond').val(data.metalDepthCond);  
                        $('#sizeViewPitchLeftCond').val(data.pitchLeftCond);  
                        $('#sizeViewPpfDepthLeftCond').val(data.ppfDepthLeftCond);  
                        $('#sizeViewPpfDepthCenterCond').val(data.ppfDepthCenterCond);  
                        $('#sizeViewPpfDepthRightCond').val(data.ppfDepthRightCond);  
                        $('#sizeViewFilmCond').val(data.filmCond);  
                        $('#sizeViewWpLeftCond').val(data.wpLeftCond);  
                        $('#sizeViewWpCenterCond').val(data.wpCenterCond);  
                        $('#sizeViewWpRightCond').val(data.wpRightCond);  
                        $('#sizeViewWpDeviationCond').val(data.wpDeviationCond);  
                        $('#sizeViewX1X2Cond').val(data.x1X2Cond);  
                        $('#sizeViewPpfWingLeftCond').val(data.ppfWingLeftCond);  
                        $('#sizeViewPpfWingRightCond').val(data.ppfWingRightCond);  
                        $('#sizeViewMetalThicknessCond').val(data.metalThicknessCond);  
                        $('#sizeViewThEdgeCond').val(data.thEdgeCond);  
                        $('#sizeViewThCenterCond').val(data.thCenterCond);  
                        $('#sizeViewThEdgeRightCond').val(data.thEdgeRightCond);  
                        $('#sizeViewBurrCond').val(data.burrCond);  
                        $('#sizeViewGapOfLayerCond').val(data.gapOfLayerCond);  
                        $('#sizeViewBendingCond').val(data.bendingCond);  

                        $('#sizeViewMetalDepthAlwnceMinus').val(data.metalDepthAlwnceMinus);  
                        $('#sizeViewPitchLeftAlwnceMinus').val(data.pitchLeftAlwnceMinus);  
                        $('#sizeViewPpfDepthLeftAlwnceMinus').val(data.ppfDepthLeftAlwnceMinus);  
                        $('#sizeViewPpfDepthCenterAlwnceMinus').val(data.ppfDepthCenterAlwnceMinus);  
                        $('#sizeViewPpfDepthRightAlwnceMinus').val(data.ppfDepthRightAlwnceMinus);  
                        $('#sizeViewFilmAlwnceMinus').val(data.filmAlwnceMinus);  
                        $('#sizeViewWpLeftAlwnceMinus').val(data.wpLeftAlwnceMinus);  
                        $('#sizeViewWpCenterAlwnceMinus').val(data.wpCenterAlwnceMinus);  
                        $('#sizeViewWpRightAlwnceMinus').val(data.wpRightAlwnceMinus);  
                        $('#sizeViewWpDeviationAlwnceMinus').val(data.wpDeviationAlwnceMinus);  
                        $('#sizeViewX1X2AlwnceMinus').val(data.x1X2AlwnceMinus);  
                        $('#sizeViewPpfWingLeftAlwnceMinus').val(data.ppfWingLeftAlwnceMinus);  
                        $('#sizeViewPpfWingRightAlwnceMinus').val(data.ppfWingRightAlwnceMinus);  
                        $('#sizeViewMetalThicknessAlwnceMinus').val(data.metalThicknessAlwnceMinus);  
                        $('#sizeViewThEdgeAlwnceMinus').val(data.thEdgeAlwnceMinus);  
                        $('#sizeViewThCenterAlwnceMinus').val(data.thCenterAlwnceMinus);  
                        $('#sizeViewThEdgeRightAlwnceMinus').val(data.thEdgeRightAlwnceMinus);  
                        $('#sizeViewBurrAlwnceMinus').val(data.burrAlwnceMinus);  
                        $('#sizeViewGapOfLayerAlwnceMinus').val(data.gapOfLayerMinus);  
                        $('#sizeViewBendingAlwnceMinus').val(data.bendingAlwnceMinus);  

                        $('#sizeViewMetalDepthAlwncePlus').val(data.metalDepthAlwncePlus);  
                        $('#sizeViewPitchLeftAlwncePlus').val(data.pitchLeftAlwncePlus);  
                        $('#sizeViewPpfDepthLeftAlwncePlus').val(data.ppfDepthLeftAlwncePlus);  
                        $('#sizeViewPpfDepthCenterAlwncePlus').val(data.ppfDepthCenterAlwncePlus);  
                        $('#sizeViewPpfDepthRightAlwncePlus').val(data.ppfDepthRightAlwncePlus);  
                        $('#sizeViewFilmAlwncePlus').val(data.filmAlwncePlus);  
                        $('#sizeViewWpLeftAlwncePlus').val(data.wpLeftAlwncePlus);  
                        $('#sizeViewWpCenterAlwncePlus').val(data.wpCenterAlwncePlus);  
                        $('#sizeViewWpRightAlwncePlus').val(data.wpRightAlwncePlus);  
                        $('#sizeViewWpDeviationAlwncePlus').val(data.wpDeviationAlwncePlus);  
                        $('#sizeViewX1X2AlwncePlus').val(data.x1X2AlwncePlus);  
                        $('#sizeViewPpfWingLeftAlwncePlus').val(data.ppfWingLeftAlwncePlus);  
                        $('#sizeViewPpfWingRightAlwncePlus').val(data.ppfWingRightAlwncePlus);  
                        $('#sizeViewMetalThicknessAlwncePlus').val(data.metalThicknessAlwncePlus);  
                        $('#sizeViewThEdgeAlwncePlus').val(data.thEdgeAlwncePlus);  
                        $('#sizeViewThCenterAlwncePlus').val(data.thCenterAlwncePlus);  
                        $('#sizeViewThEdgeRightAlwncePlus').val(data.thEdgeRightAlwncePlus);  
                        $('#sizeViewBurrAlwncePlus').val(data.burrAlwncePlus);  
                        $('#sizeViewGapOfLayerAlwncePlus').val(data.gapOfLayerPlus);  
                        $('#sizeViewBendingAlwncePlus').val(data.bendingAlwncePlus);  
     
                        $('#sizeModal').modal('hide');
                    }
                });
		    });
		} else{
			$('#sizeTable').DataTable().ajax.reload();
		}

		$('#sizeModal').modal('show');		
   	}
  	//치수 조회 팝업 종료

  	function addFormClear() {
  		$('#addFormGoodsCd').text("");
  		$('#addFormGoodsNm').val("");
  		$('#addFormQutyNm').text("");
  		$('#addFormModel').text("");
  		$('#addFormAlniThickness').text("");
  		$('#addFormAlniDepth').text("");
  		$('#addFormAlniWidth').text("");
  		$('#addFormAlniLength').text("");
  		$('#addFormAlniPtich').text("");
  		$('#addFormFilmQutyNm').text("");
  		$('#addFormFilmThickness').text("");
  		$('#addFormFilmDepth').text("");
  		$('#addFormFilmMatrlDesc').text("");  	
  	}

</script>
</body>
</html>
