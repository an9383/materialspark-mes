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
					<li class="breadcrumb-item"><a href="#">공동실적관리(POP)</a></li>
					<li class="breadcrumb-item active">불량등록</li>
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
										<th style="min-width: 50px" >설비명</th>
		                            </tr>
		                        </thead>
                              </table>
                          </div>
						 <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                   <div class="right-list left-60" id="left-60" style="width:45%;">
						<div class="card">
						<!-- .table-responsive -->
							<div class="mt-2">
								<div class="row">
									&nbsp;<label class="input-label-sm">등록일</label>
									<input class="form-control" style="width:130px;" type="date" id="chooseDate" name="chooseDate" />
									<!-- 
									<div class="form-group input-sub m-0 row">
										<input class="form-control" style="width:97px;" type="text" id="chooseDate" name="chooseDate" />
										<button onclick="fnPopUpCalendar(chooseDate,chooseDate,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="chooseCal" type="button">
											<span class="oi oi-calendar"></span>
										</button>
									</div>
									 -->
								</div>
							</div>
							<br>
							<table class="table table-bordered" id="equipFaultyTable">
								<tr>
									<th colspan="2">구분</th>
									<th>주간</th>
									<th>야간</th>
									<th>소계(KG)</th>
								</tr>
								<tr id="prcssFaulty" class="select_prcssFaulty">
									<td colspan="2">공정불량(KG)</td>
									<td align="right"><span id="dayTotalPrcssSum" class="dayTotalFaulty" ></span></td>
									<td align="right"><span id="nightTotalPrcssSum" class="nightTalFaulty"></span></td>
									<td align="right"><span id="totalPrcssSum" class="totalFaulty"></span></td>
								</tr>
								<tr id="matrlFaulty" class="select_matrlFaulty">
									<td colspan="2">원자재불량(KG)</td>
									<td align="right"><span id="dayTotalMatrlSum" class="dayTotalFaulty"></span></td>
									<td align="right"><span id="nightTotalMatrlSum" class="nightTalFaulty"></span></td>
									<td align="right"><span id="totalMatrlSum" class="totalFaulty"></span></td>
								</tr>
								<tr id="replaceFaulty" class="select_replaceFaulty">
									<td rowspan="2">교체불량</td>
									<td>횟수</td>
									<td align="right"><span id="dayTotalReplaceCount"></span></td>
									<td align="right"><span id="nightTotalReplaceCount"></span></td>
									<td align="right"><span id="totalReplaceCount"></span></td>
								</tr>
								<tr id="replaceFaulty" class="select_replaceFaulty">
									<td>불량(KG)</td>
									<td align="right"><span id="dayTotalReplaceSum" class="dayTotalFaulty"></span></td>
									<td align="right"><span id="nightTotalReplaceSum" class="nightTotalFaulty"></span></td>
									<td align="right"><span id="totalReplaceSum" class="totalFaulty"></span></td>
	
								</tr>
								<tr id="troubleFaulty" class="select_troubleFaulty">
									<td rowspan="2">설비트러블불량</td>
									<td>횟수</td>
									<td align="right"><span id="dayTotalTroubleCount"></span></td>
									<td align="right"><span id="nightTotalTroubleCount"></span></td>
									<td align="right"><span id="totalTroubleCount"></span></td>
								</tr>
								<tr id="troubleFaulty" class="select_troubleFaulty">
									<td>불량(KG)</td>
									<td align="right"><span id="dayTotalTroubleSum" class="dayTotalFaulty"></span></td>
									<td align="right"><span id="nightTotalTroubleSum" class="nightTotalFaulty"></span></td>
									<td align="right"><span id="totalTroubleSum" class="totalFaulty"></span></td>
								</tr>
								<tr>
									<th colspan="2">소계</th>
									<th><span id="dayTotalSum"></span></th>
									<th><span id="nightTotalSum"></span></th>
									<th><span id="totalSum"></span></th>
								</tr>
							</table>
							 <!-- /.table-responsive -->
						</div>
					</div><!-- /.left-list -->
					<!--======================== .right-sidebar 등록,수정 ========================-->
	                    <div class="right-list right-40" id="myrSidenav" style="width:41%;">
							<div class="card" id="formBox">
								<!-- 주간 입력&저장 버튼 -->
								<div class="card-body col-sm-12 p-2 d-none" id="cardDay">
									<button type="button" class="btn btn-primary float-left" id="inputDay">주간 입력</button>
									<button type="button" class="btn btn-primary float-right day" id="dayBtnSave">저장</button>
								</div>
								<!-- ----- 주간 공정불량 상세정보 시작-----  -->
								<div id="dayPrcssFaultyView" class="d-none">
									<div class="table-responsive">
										<table class="table table-bordered">
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<tr>
												<input type="hidden" id="dayPrcssFaultySearchData">
												<th>PMS</th>
						                        <th>PFS</th>
						                        <th>P찍힘</th>
						                        <th>P이물</th>
						                        <th>P오염</th>
						                        <th>도금박리</th>
											</tr>
											<tr>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsPms" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsPfs" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsPstab" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsPaliensbst" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsPpolutn" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsGilt" min="0" ></td>
											</tr>
											<tr>
												<th>F꺽임</th>
						                        <th>F뭉침</th>
						                        <th>F눌림</th>
						                        <th>F뜯김</th>
						                        <th>필름자국<!-- <br>(테프론) --></th>
						                        <th>마진편차</th>
											</tr>
											<tr>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsFbreak" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsFagglomt" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsFpress" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsFtornout" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsTeflon" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsMargnDvat" min="0" ></td>
											</tr>
											<tr>
												<th>총두께(M+F)</th>
						                        <th>표면기포</th>
						                        <th>엣지기포</th>
						                        <th>메탈-Burr</th>
						                        <th>R-Burr</th>
						                        <th>치수</th>
											</tr>
											<tr>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsThickness" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsSurfceBb" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsEdgeBb" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsMburr" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsRburr" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsSize" min="0" ></td>
											</tr>
											<tr>
												<th>레이어</th>
						                        <th>미진접</th>
						                        <th>미부착</th>
						                        <th>필름폭</th>
						                        <th></th>
						                        <th></th>
											</tr>
											<tr>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsLayer" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsUnjinjeop" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsUnattch" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayPrcsFilmDepth" min="0" ></td>
												<td></td>
												<td></td>
											</tr>
										</table>
									</div>
								</div>
								<!-- ----- 주간 공정불량 상세정보 끝-----  -->
								
								<!-- ----- 주간 원자재불량 상세정보 시작 ----- -->
								<div id="dayMatrlFaultyView" class="d-none">
									<table class="table table-bordered">
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<tr>
											<input type="hidden" id="dayMatrlFaultySearchData">
											<th>MMB</th>
					                        <th>MMS</th>
					                        <th>M이물</th>
					                        <th>M휨</th>
					                        <th>M오염</th>
					                        <th>도금박리</th>
										</tr>
										<tr>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlMmb" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlMms" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlMaliensbst" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlMflex" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlMpolutn" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlGilt" min="0" ></td>
										</tr>
										<tr>
											<th>찍힘</th>
					                        <th>권취</th>
					                        <th>얼룩</th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
										</tr>
										<tr>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlMstab" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlFagglomt" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayMatrlSpot" min="0" ></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<th>&nbsp</th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
										</tr>
										<tr>
											<td>&nbsp</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<th>&nbsp</th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
										</tr>
										<tr>
											<td>&nbsp</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</table>
								</div>
								<!-- ----- 주간 원자재불량 상세정보 끝 ----- -->
								
								<!-- ----- 주간 교체불량 상세정보 시작 ----- -->
								<div id="dayReplaceFaultyView" class="d-none">
									<table class="table table-bordered">
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<tr>
											<input type="hidden" id="dayReplaceFaultySearchData">
											<th>메탈교체</th>
					                        <th>1회</th>
					                        <th>2회</th>
					                        <th>3회</th>
					                        <th>4회</th>
					                        <th>5회</th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcMetal1" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcMetal2" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcMetal3" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcMetal4" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcMetal5" min="0" ></td>
										</tr>
										<tr>
											<th>필름교체</th>
					                        <th>1회</th>
					                        <th>2회</th>
					                        <th>3회</th>
					                        <th>4회</th>
					                        <th>5회</th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcFilm1" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcFilm2" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcFilm3" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcFilm4" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcFilm5" min="0" ></td>
										</tr>
										<tr>
											<th>실리콘교체</th>
					                        <th>1회</th>
					                        <th>2회</th>
					                        <th>3회</th>
					                        <th>4회</th>
					                        <th>5회</th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcSilicon1" min="0" ></td>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcSilicon2" min="0" ></td>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcSilicon3" min="0" ></td>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcSilicon4" min="0" ></td>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcSilicon5" min="0" ></td>
										</tr>
										<tr>
											<th>메탈교테프론교체</th>
					                        <th>1회</th>
					                        <th>2회</th>
					                        <th>3회</th>
					                        <th>4회</th>
					                        <th>5회</th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcTeflon1" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcTeflon2" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcTeflon3" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcTeflon4" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcTeflon5" min="0" ></td>
										</tr>
										<tr>
											<th>J/C</th>
					                        <th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcJc1" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcJc2" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcJc3" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcJc4" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayRpcJc5" min="0" ></td>
										</tr>
									</table>
								</div>
								<!-- ----- 주간 교체불량 상세정보 끝 ----- -->
								
								<!-- ----- 주간 설비 트러블 불량 상세정보 시작 ----- -->
								<div id="dayTroubleFaultyView" class="d-none">
									<table class="table table-bordered">
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<tr>
											<input type="hidden" id="dayTroubleFaultySearchData">
											<th>서보(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbServo1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbServo2" min="0" ></td>
					                        <th>융착부(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbFuse1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbFuse2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbServoContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbFuseContent" style="max-width:100%"></td>
										</tr>
										<tr>
											<th>기어모터(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbGearmotor1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbGearmotor2" min="0" ></td>
					                        <th>온도(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbTempatur1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbTempatur2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbGearmotorContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbTempaturContent" style="max-width:100%"></td>
										</tr>
										<tr>
											<th>공압(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbPnumt1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbPnumt2" min="0" ></td>
					                        <th>커팅부(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbCutting1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbCutting2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbPnumtContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbCuttingContent" style="max-width:100%"></td>
										</tr>
										<tr>
											<th>센서(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbSensor1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbSensor2" min="0" ></td>
					                        <th>실린더(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbCylinder1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbCylinder2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbSensorContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbCylinderContent" style="max-width:100%"></td>
										</tr>
										<tr>
											<th>비전(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbVision1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbVision2" min="0" ></td>
					                        <th>기타(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbEtc1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 day" id="dayTrbEtc2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbVisionContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day" id="dayTrbEtcContent" style="max-width:100%"></td>
										</tr>
									</table>
								</div>
								<!-- ----- 주간 설비 트러블 불량 상세정보 끝 ----- -->
								
								
								
								
								
								<br>
								
								
								
								
								
								<!-- 야간 입력&저장 버튼 -->
								<div class="card-body col-sm-12 p-2 d-none" id="cardNight">
									<button type="button" class="btn btn-primary float-left" id="inputNight">야간 입력</button>
									<button type="button" class="btn btn-primary float-right night" id="nightBtnSave">저장</button>
								</div>
								<!-- ----- 야간 공정불량 상세정보 시작 ----- -->
								<div id="nightPrcssFaultyView" class="d-none">
									<div class="table-responsive">
										<table class="table table-bordered">
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<colgroup><col width="16%"></colgroup>
											<tr>
												<input type="hidden" id="nightPrcssFaultySearchData">
												<th>PMS</th>
						                        <th>PFS</th>
						                        <th>P찍힘</th>
						                        <th>P이물</th>
						                        <th>P오염</th>
						                        <th>도금박리</th>
											</tr>
											<tr>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsPms" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsPfs" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsPstab" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsPaliensbst" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsPpolutn" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsGilt" min="0" ></td>
											</tr>
											<tr>
												<th>F꺽임</th>
						                        <th>F뭉침</th>
						                        <th>F눌림</th>
						                        <th>F뜯김</th>
						                        <th>필름자국<!-- <br>(테프론) --></th>
						                        <th>마진편차</th>
											</tr>
											<tr>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsFbreak" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsFagglomt" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsFpress" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsFtornout" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsTeflon" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsMargnDvat" min="0" ></td>
											</tr>
																		<tr>
												<th>총두께(M+F)</th>
						                        <th>표면기포</th>
						                        <th>엣지기포</th>
						                        <th>메탈-Burr</th>
						                        <th>R-Burr</th>
						                        <th>치수</th>
											</tr>
											<tr>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsThickness" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsSurfceBb" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsEdgeBb" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsMburr" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsRburr" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsSize" min="0" ></td>
											</tr>
											<tr>
												<th>레이어</th>
						                        <th>미진접</th>
						                        <th>미부착</th>
						                        <th>필름폭</th>
						                        <th></th>
						                        <th></th>
											</tr>
											<tr>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsLayer" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsUnjinjeop" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsUnattch" min="0" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightPrcsFilmDepth" min="0" ></td>
												<td></td>
												<td></td>
											</tr>
										</table>
									</div>
								</div>
								<!-- ----- 야간 공정불량 상세정보 끝 ----- -->
								
								<!-- ----- 야간 원자재불량 상세정보 시작 ----- -->
								<div id="nightMatrlFaultyView" class="d-none">
									<table class="table table-bordered">
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<tr>
											<input type="hidden" id="nightMatrlFaultySearchData">
											<th>MMB</th>
					                        <th>MMS</th>
					                        <th>M이물</th>
					                        <th>M휨</th>
					                        <th>M오염</th>
					                        <th>도금박리</th>
										</tr>
										<tr>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlMmb" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlMms" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlMaliensbst" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlMflex" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlMpolutn" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlGilt" min="0" ></td>
										</tr>
										<tr>
											<th>찍힘</th>
					                        <th>권취</th>
					                        <th>얼룩</th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
										</tr>
										<tr>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlMstab" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlFagglomt" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightMatrlSpot" min="0" ></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<th>&nbsp</th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
										</tr>
										<tr>
											<td>&nbsp</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<th>&nbsp</th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
					                        <th></th>
										</tr>
										<tr>
											<td>&nbsp</td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</table>
								</div>
								<!-- ----- 야간 원자재불량 상세정보 끝 ----- -->
								
								<!-- ----- 야간 교체불량 상세정보 시작 ----- -->
								<div id="nightReplaceFaultyView" class="d-none">
									<table class="table table-bordered">
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<tr>
											<input type="hidden" id="nightReplaceFaultySearchData">
											<th>메탈교체</th>
					                        <th>1회</th>
					                        <th>2회</th>
					                        <th>3회</th>
					                        <th>4회</th>
					                        <th>5회</th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcMetal1" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcMetal2" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcMetal3" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcMetal4" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcMetal5" min="0" ></td>
										</tr>
										<tr>
											<th>필름교체</th>
					                        <th>1회</th>
					                        <th>2회</th>
					                        <th>3회</th>
					                        <th>4회</th>
					                        <th>5회</th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcFilm1" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcFilm2" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcFilm3" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcFilm4" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcFilm5" min="0" ></td>
										</tr>
										<tr>
											<th>실리콘교체</th>
					                        <th>1회</th>
					                        <th>2회</th>
					                        <th>3회</th>
					                        <th>4회</th>
					                        <th>5회</th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcSilicon1" min="0" ></td>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcSilicon2" min="0" ></td>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcSilicon3" min="0" ></td>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcSilicon4" min="0" ></td>
											<td><input  maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcSilicon5" min="0" ></td>
										</tr>
										<tr>
											<th>메탈교테프론교체</th>
					                        <th>1회</th>
					                        <th>2회</th>
					                        <th>3회</th>
					                        <th>4회</th>
					                        <th>5회</th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcTeflon1" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcTeflon2" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcTeflon3" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcTeflon4" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcTeflon5" min="0" ></td>
										</tr>
										<tr>
											<th>J/C</th>
					                        <th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
										</tr>
										<tr>
											<th>KG</th>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcJc1" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcJc2" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcJc3" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcJc4" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightRpcJc5" min="0" ></td>
										</tr>
									</table>
								</div>
								<!-- ----- 야간 교체불량 상세정보 끝 ----- -->
								
								<!-- ----- 야간 설비 트러블 불량 상세정보 시작 ----- -->
								<div id="nightTroubleFaultyView" class="d-none">
									<table class="table table-bordered">
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<colgroup><col width="16%"></colgroup>
										<tr>
											<input type="hidden" id="nightTroubleFaultySearchData">
											<th>서보(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbServo1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbServo2" min="0" ></td>
					                        <th>융착부(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbFuse1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbFuse2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbServoContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbFuseContent" style="max-width:100%"></td>
										</tr>
										<tr>
											<th>기어모터(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbGearmotor1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbGearmotor2" min="0" ></td>
					                        <th>온도(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbTempatur1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbTempatur2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbGearmotorContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbTempaturContent" style="max-width:100%"></td>
										</tr>
										<tr>
											<th>공압(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbPnumt1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbPnumt2" min="0" ></td>
					                        <th>커팅부(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbCutting1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbCutting2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbPnumtContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbCuttingContent" style="max-width:100%"></td>
										</tr>
										<tr>
											<th>센서(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbSensor1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbSensor2" min="0" ></td>
					                        <th>실린더(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbCylinder1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbCylinder2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbSensorContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbCylinderContent" style="max-width:100%"></td>
										</tr>
										<tr>
											<th>비전(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbVision1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbVision2" min="0" ></td>
					                        <th>기타(KG)</th>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbEtc1" min="0" ></td>
					                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.1" class="form-control number-float1 night" id="nightTrbEtc2" min="0" ></td>
										</tr>
										<tr>
											<th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbVisionContent" style="max-width:100%"></td>
					                        <th>내용</th>
					                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night" id="nightTrbEtcContent" style="max-width:100%"></td>
										</tr>
									</table>
								</div>
								<!-- ----- 야간 설비 트러블 불량 상세정보 끝 ----- -->
								

							</div>
						</div><!-- .right-sidebar -->
				</div><!-- /.row -->
			</div><!-- / #main  -->
		</div><!-- /.page-wrapper -->
		
<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'posc0050';
	let currentHref = 'posc0050';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","불량등록");

	var serverDate =  "${serverDate}";
	var equipCd = null;
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	var url = null;
	var sideView = null;
	var prcssTemp = 0;
	var matrlTemp = 0;
	var replaceTemp = 0;
	var troubleTemp = 0;

	$('.day').attr('disabled', true);
	$('.night').attr('disabled', true);
	
	//공통코드 처리 시작
	var equipGroupCode = new Array(); // 설비그룹
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    
	//var dayNightCd = new Array(); // 기계 그룹
    //<c:forEach items="${dayNightCd}" var="info">
	//	var json=new Object();
	//	json.baseCd="${info.baseCd}";
	//	json.baseCdNm="${info.baseCdNm}";
	//	dayNightCd.push(json);
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
        pageLength: 11,
        ajax: {
            url: '<c:url value="bm/equipCodeAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'equipGroup' : function() { return equipGroup; }
            },
        },
		columns: [
			{ data: 'equipNm' },
		],
		order: [
			[ 0, 'asc' ],
		],
	    "drawCallback": function( settings ) {
	    	$('#equipCodeAdmTable tbody tr td').css('height','40px');
	    }
    });
    var html1 =  '&nbsp;<label class="input-label-sm">설비그룹</label><select  class="custom-select" id="equipGroupCd" ></select>';
	$('#equipCodeAdmTable_length').html(html1);
	selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");
	
	$('#chooseDate').val(serverDate);
	var chooseDate = "${serverDate}";
	var equipCd = null;

	$("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});
	 	equipCd = null;
	});

	//설비명 클릭
    $('#equipCodeAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            equipCd = null;
            sideView = null;
        }
        else {
        	$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            chooseDate = $('#chooseDate').val();
            equipCd = equipCodeAdmTable.row( this ).data().equipCd;
			//viewClear();
			$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			prcssTemp = 0;
			matrlTemp = 0;
			replaceTemp = 0;
			troubleTemp = 0;
			$('.day').attr('disabled', true);
			$('.night').attr('disabled', true);
			readTotal();
        }
        $('tr.tableSelected').removeClass('tableSelected');

        $('#cardDay').addClass('d-none');				//주간 상단 버튼 숨김
        $('#cardNight').addClass('d-none');				//야간 상단 버튼 숨김
        $('#dayPrcssFaultyView').addClass('d-none');	//공정불량 주간입력
        $('#nightPrcssFaultyView').addClass('d-none');	//공정불량 야간입력
        $('#dayMatrlFaultyView').addClass('d-none');	//자재불량 주간입력
        $('#nightMatrlFaultyView').addClass('d-none');	//자재불량 야간입력
        $('#dayMatrlFaultyView').addClass('d-none');		//교체불량 주간입력
        $('#nightReplaceFaultyView').addClass('d-none');//교체불량 야간입력
        $('#dayTroubleFaultyView').addClass('d-none');	//트러블불량 주간입력
        $('#nightTroubleFaultyView').addClass('d-none');//트러블불량 야간입력
    });

	//통계 조회
	function readTotal() {
		$.ajax({
  	    	url: '<c:url value="po/readTotalFaulty"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 		: 		menuAuth,
  	        	'equipCd'			:		function() { return equipCd; },
  	        	'faultyRegDate'		:		function() { return chooseDate.replace(/-/g, ''); },
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	          	let totatFaultyData = res.totatFaultyData;
				if (res.result == 'ok') {
	            		$('#dayTotalPrcssSum').text(parseFloat(totatFaultyData.dayTotalPrcssSum));
	  	            	$('#nightTotalPrcssSum').text(parseFloat(totatFaultyData.nightTotalPrcssSum));
	  	            	$('#totalPrcssSum').text(parseFloat(totatFaultyData.totalPrcssSum));
	  	            	$('#dayTotalMatrlSum').text(parseFloat(totatFaultyData.dayTotalMatrlSum));
	  	            	$('#nightTotalMatrlSum').text(parseFloat(totatFaultyData.nightTotalMatrlSum));
	  	            	$('#totalMatrlSum').text(parseFloat(totatFaultyData.totalMatrlSum));
	  	            	$('#dayTotalReplaceCount').text(parseFloat(totatFaultyData.dayTotalReplaceCount));
	  	            	$('#nightTotalReplaceCount').text(parseFloat(totatFaultyData.nightTotalReplaceCount));
	  	            	$('#totalReplaceCount').text(parseFloat(totatFaultyData.totalReplaceCount));
	  	            	$('#dayTotalReplaceSum').text(parseFloat(totatFaultyData.dayTotalReplaceSum));
	  	            	$('#nightTotalReplaceSum').text(parseFloat(totatFaultyData.nightTotalReplaceSum));
	  	            	$('#totalReplaceSum').text(parseFloat(totatFaultyData.totalReplaceSum));
	  	            	$('#dayTotalTroubleCount').text(parseFloat(totatFaultyData.dayTotalTroubleCount));
	  	            	$('#nightTotalTroubleCount').text(parseFloat(totatFaultyData.nightTotalTroubleCount));
	  	            	$('#totalTroubleCount').text(parseFloat(totatFaultyData.totalTroubleCount));
	  	            	$('#dayTotalTroubleSum').text(parseFloat(totatFaultyData.dayTotalTroubleSum));
	  	            	$('#nightTotalTroubleSum').text(parseFloat(totatFaultyData.nightTotalTroubleSum));
	  	            	$('#totalTroubleSum').text(parseFloat(totatFaultyData.totalTroubleSum));
	  	            }
	  	        		total();	// 합산 계산하기
				},
  	        complete:function(){
  	        	//$('#replaceFaultyBtnSave').attr('disabled', true);
			}
		});
	};

	$('#equipFaultyTable tbody').on('click', 'tr', function () {
		if( equipCd == null ){
			toastr.warning('설비명을 선택해주세요.');
			return false;
		}
		else{
			if ( $(this).hasClass('tableSelected') ) {
				//$(this).removeClass('tableSelected');
			}
	        else {
				equipFaultyTable = $(this).closest('tr').attr('id');
	        }
		}
	});

	/* -----------------------------------------------------------------공정불량 시작----------------------------------------------------------------- */
	//공정불량 행 클릭
  	$('.select_prcssFaulty').on('click', function() {
		if( equipCd != null){
	        $('#cardDay').removeClass('d-none');	//주간 상단 버튼 표시
	        $('#cardNight').removeClass('d-none');	//야간 상단 버튼 표시
			$('#matrlFaultyView').addClass('d-none');
			$('#replaceFaultyView').addClass('d-none');
			$('#troubleFaultyView').addClass('d-none');

			$('#dayPrcssFaultyView').removeClass('d-none');
			$('#nightPrcssFaultyView').removeClass('d-none');
			$('#dayMatrlFaultyView').addClass('d-none');
			$('#nightMatrlFaultyView').addClass('d-none');
			$('#dayReplaceFaultyView').addClass('d-none');
			$('#nightReplaceFaultyView').addClass('d-none');
			$('#dayTroubleFaultyView').addClass('d-none');
			$('#nightTroubleFaultyView').addClass('d-none');
			
			if (prcssTemp == 0){
				$('.select_prcssFaulty').css({ "background-color": "#0275D8", "color": "#ffffff" });
				$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				prcssTemp = 1;
				matrlTemp = 0;
				replaceTemp = 0;
				troubleTemp = 0;
				sideView = "prcss";
				$('.day').attr('disabled', true);
				$('.night').attr('disabled', true);
				readPrcssFaulty();
			}
			else if (prcssTemp == 1) {
				$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				prcssTemp = 0;
			}
		}
	});

	//공정불량 주야 조회
	function readPrcssFaulty()	{

  		//주간 공정불량
		$.ajax({
  	    	url: '<c:url value="po/readFaultyAll"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 	: 		menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); },
  	        	'dayNightCd'		:	"D",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {

  	            	if ( data == null) {
  	            		$('#dayPrcssFaultySearchData').val("fail");
  	   	            } else {
	   	   	          	$('#dayPrcsPms').val(data.prcsPms),
	 	            	$('#dayPrcsPfs').val(data.prcsPfs),
	 	            	$('#dayPrcsPstab').val(data.prcsPstab),
	 	            	$('#dayPrcsPaliensbst').val(data.prcsPaliensbst),
	 	            	$('#dayPrcsPpolutn').val(data.prcsPpolutn),
	 	            	$('#dayPrcsGilt').val(data.prcsGilt),
	 	            	$('#dayPrcsFbreak').val(data.prcsFbreak),
	 	            	$('#dayPrcsFagglomt').val(data.prcsFagglomt),
	 	            	$('#dayPrcsFpress').val(data.prcsFpress),
	 	            	$('#dayPrcsFtornout').val(data.prcsFtornout),
	 	            	$('#dayPrcsTeflon').val(data.prcsTeflon),
	 	            	$('#dayPrcsMargnDvat').val(data.prcsMargnDvat),
	 	            	$('#dayPrcsThickness').val(data.prcsThickness),
	 	            	$('#dayPrcsSurfceBb').val(data.prcsSurfceBb),
	 	            	$('#dayPrcsEdgeBb').val(data.prcsEdgeBb),
	 	            	$('#dayPrcsMburr').val(data.prcsMburr),
	 	            	$('#dayPrcsRburr').val(data.prcsRburr),
	 	            	$('#dayPrcsSize').val(data.prcsSize),
	 	            	$('#dayPrcsLayer').val(data.prcsLayer),
	 	            	$('#dayPrcsUnjinjeop').val(data.prcsUnjinjeop),
	 	            	$('#dayPrcsUnattch').val(data.prcsUnattch),
	 	            	$('#dayPrcsFilmDepth').val(data.prcsFilmDepth),
	 	            	
	 	            	$('#dayPrcssFaultySearchData').val("success");
					}
				}
				else {
					toastr.error("주간 공정불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#dayPrcssFaultySearchData').val() == "fail"){
  	  				$('.day').val("0");
  	  			}
			}
		});

		//야간 공정불량
		$.ajax({
  	    	url: '<c:url value="po/readFaultyAll"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 		: 		menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); },
  	        	'dayNightCd'		:	"N",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {

  	            	if ( data == null) {
  	            		$('#nightPrcssFaultySearchData').val("fail");
  	   	            } else {
	   	   	          	$('#nightPrcsPms').val(data.prcsPms),
	 	            	$('#nightPrcsPfs').val(data.prcsPfs),
	 	            	$('#nightPrcsPstab').val(data.prcsPstab),
	 	            	$('#nightPrcsPaliensbst').val(data.prcsPaliensbst),
	 	            	$('#nightPrcsPpolutn').val(data.prcsPpolutn),
	 	            	$('#nightPrcsGilt').val(data.prcsGilt),
	 	            	$('#nightPrcsFbreak').val(data.prcsFbreak),
	 	            	$('#nightPrcsFagglomt').val(data.prcsFagglomt),
	 	            	$('#nightPrcsFpress').val(data.prcsFpress),
	 	            	$('#nightPrcsFtornout').val(data.prcsFtornout),
	 	            	$('#nightPrcsTeflon').val(data.prcsTeflon),
	 	            	$('#nightPrcsMargnDvat').val(data.prcsMargnDvat),
	 	            	$('#nightPrcsThickness').val(data.prcsThickness),
	 	            	$('#nightPrcsSurfceBb').val(data.prcsSurfceBb),
	 	            	$('#nightPrcsEdgeBb').val(data.prcsEdgeBb),
	 	            	$('#nightPrcsMburr').val(data.prcsMburr),
	 	            	$('#nightPrcsRburr').val(data.prcsRburr),
	 	            	$('#nightPrcsSize').val(data.prcsSize),
	 	            	$('#nightPrcsLayer').val(data.prcsLayer),
	 	            	$('#nightPrcsUnjinjeop').val(data.prcsUnjinjeop),
	 	            	$('#nightPrcsUnattch').val(data.prcsUnattch),
	 	            	$('#nightPrcsFilmDepth').val(data.prcsFilmDepth),
	 	            	
	 	            	$('#nightPrcssFaultySearchData').val("success");
					}
				}
				else {
					toastr.error("주간 공정불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#nightPrcssFaultySearchData').val() == "fail"){
  	  				$('.night').val("0");
  	  			}
			}
		});
	};

	/* -----------------------------------------------------------------공정불량 끝----------------------------------------------------------------- */
	
	//주간 저장 버튼
	$('#dayBtnSave').on('click', function() {

		//주간 공정불량 저장&수정
		if (sideView == "prcss"){
			let dayPrcssFaultySearchData = $('#dayPrcssFaultySearchData').val();
			if ( dayPrcssFaultySearchData == "success" ){
				url = "po/updatePrcssFaulty";
			} else if ( dayPrcssFaultySearchData == "fail" ) {
				url = "po/createPrcssFaulty";
			}
			$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 		: 		menuAuth,
	   	        	'equipCd'			:	function() { return equipCd; },
	   	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); }, 
	   	        	'dayNightCd'		:	"D",
					'prcsPms'			: 	$('#dayPrcsPms').val(),
					'prcsPfs'			: 	$('#dayPrcsPfs').val(),
					'prcsPstab'			: 	$('#dayPrcsPstab').val(),
					'prcsPaliensbst'	: 	$('#dayPrcsPaliensbst').val(),
					'prcsPpolutn'		: 	$('#dayPrcsPpolutn').val(),
					'prcsGilt'			: 	$('#dayPrcsGilt').val(),
					'prcsFbreak'		: 	$('#dayPrcsFbreak').val(),
					'prcsFagglomt'		: 	$('#dayPrcsFagglomt').val(),
					'prcsFpress'		: 	$('#dayPrcsFpress').val(),
					'prcsFtornout'		: 	$('#dayPrcsFtornout').val(),
					'prcsTeflon'		: 	$('#dayPrcsTeflon').val(),
					'prcsMargnDvat'		: 	$('#dayPrcsMargnDvat').val(),
					'prcsThickness'		: 	$('#dayPrcsThickness').val(),
					'prcsSurfceBb'		: 	$('#dayPrcsSurfceBb').val(),
					'prcsEdgeBb'		: 	$('#dayPrcsEdgeBb').val(),
					'prcsMburr'			: 	$('#dayPrcsMburr').val(),
					'prcsRburr'			: 	$('#dayPrcsRburr').val(),
					'prcsSize'			: 	$('#dayPrcsSize').val(),
					'prcsLayer'			: 	$('#dayPrcsLayer').val(),
					'prcsUnjinjeop'		: 	$('#dayPrcsUnjinjeop').val(),
					'prcsUnattch'		: 	$('#dayPrcsUnattch').val(),
					'prcsFilmDepth'		: 	$('#dayPrcsFilmDepth').val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if ( dayPrcssFaultySearchData == "success" ){
		   	     			toastr.success("주간 공정불량 수정되었습니다.");
			   	 		} else if ( dayPrcssFaultySearchData == "fail" ) {
			   	 			toastr.success("주간 공정불량 저장되었습니다.");
			   	 		}
	 	            	$('#dayPrcssFaultySearchData').val("success");
		   	        	//viewForm(true);
		   	        	readTotal();
					}
	   	            else if (res.result == 'fail'){
		   	     		if ( dayPrcssFaultySearchData == "success" ){
		   	     			toastr.error("주간 공정불량  수정 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if ( dayPrcssFaultySearchData == "fail" ) {
			   	 			toastr.error("주간 공정불량 저장 실패하였습니다.", '', {timeOut: 5000});
						}
					}
	   	        },
	   	        complete:function(){
	   	        	//$('#prcssFaultyBtnSave').attr('disabled', true);
	   	        	//$('#prcssFaultyBtnEdit').attr('disabled', false);
				}
			});

		//주간 원자재 저장&수정
		} else if (sideView == "matrl"){
			let dayMatrlFaultySearchData = $('#dayMatrlFaultySearchData').val();
			if ( dayMatrlFaultySearchData == "success" ){
				url = "po/updateMatrlFaulty";
			} else if ( dayMatrlFaultySearchData == "fail" ) {
				url = "po/createMatrlFaulty";
			}
			$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 		: 	menuAuth,
	   	        	'equipCd'			:	function() { return equipCd; },
	   	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); }, 
	   	        	'dayNightCd'		:	"D",
	   	        	'matrlMmb'			:	$("#dayMatrlMmb").val(),
	   	        	'matrlMms'			:	$("#dayMatrlMms").val(),
	   	        	'matrlMaliensbst'	:	$("#dayMatrlMaliensbst").val(),
	   	        	'matrlMflex'		:	$("#dayMatrlMflex").val(),
	   	        	'matrlMpolutn'		:	$("#dayMatrlMpolutn").val(),
	   	        	'matrlGilt'			:	$("#dayMatrlGilt").val(),
	   	        	'matrlMstab'		:	$("#dayMatrlMstab").val(),
	   	        	'matrlFagglomt'		:	$("#dayMatrlFagglomt").val(),
	   	        	'matrlSpot'			:	$("#dayMatrlSpot").val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if ( dayMatrlFaultySearchData == "success" ){
		   	     			toastr.success("주간 원자재불량 수정 되었습니다.");
			   	 		} else if ( dayMatrlFaultySearchData == "fail" ) {
			   	 			toastr.success("주간 원자재불량 저장 되었습니다.");
			   	 		}
	   	            	$('#dayMatrlFaultySearchData').val("success");
		   	        	//viewForm(true);
		   	        	readTotal();
					}
	   	         	else if (res.result == "fail") {
		   	     		if ( dayMatrlFaultySearchData == "success" ){
		   	     			toastr.error("주간 원자재불량 수정 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if ( dayMatrlFaultySearchData == "fail" ) {
			   	 			toastr.error("주간 원자재불량 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		}
					}
	   	        },
	   	        complete:function(){
	   	        	//$('#matrlFaultyBtnSave').attr('disabled', true);
	   	        	//$('#matrlFaultyBtnEdit').attr('disabled', false);
				}
			});

		//주간 교체불량 저장&수정
		} else if (sideView == "replace"){
			let dayReplaceFaultySearchData = $('#dayReplaceFaultySearchData').val();
			if ( dayReplaceFaultySearchData == "success" ){
				url = "po/updateReplaceFaulty";
			} else if ( dayReplaceFaultySearchData == "fail" ) {
				url = "po/createReplaceFaulty";
			}
			$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 		: 	menuAuth,
	   	        	'equipCd'			:	function() { return equipCd; },
	   	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); }, 
	   	        	'dayNightCd'		:	"D",
	   	        	'rpcMetal1'			:	$("#dayRpcMetal1").val(),
	   	        	'rpcMetal2'			:	$("#dayRpcMetal2").val(),
	   	        	'rpcMetal3'			:	$("#dayRpcMetal3").val(),
	   	        	'rpcMetal4'			:	$("#dayRpcMetal4").val(),
	   	        	'rpcMetal5'			:	$("#dayRpcMetal5").val(),
	   	        	'rpcFilm1'			:	$("#dayRpcFilm1").val(),
	   	        	'rpcFilm2'			:	$("#dayRpcFilm2").val(),
	   	        	'rpcFilm3'			:	$("#dayRpcFilm3").val(),
	   	        	'rpcFilm4'			:	$("#dayRpcFilm4").val(),
	   	        	'rpcFilm5'			:	$("#dayRpcFilm5").val(),
	   	        	'rpcSilicon1'		:	$("#dayRpcSilicon1").val(),
	   	        	'rpcSilicon2'		:	$("#dayRpcSilicon2").val(),
	   	        	'rpcSilicon3'		:	$("#dayRpcSilicon3").val(),
	   	        	'rpcSilicon4'		:	$("#dayRpcSilicon4").val(),
	   	        	'rpcSilicon5'		:	$("#dayRpcSilicon5").val(),
	   	        	'rpcTeflon1'		:	$("#dayRpcTeflon1").val(),
	   	        	'rpcTeflon2'		:	$("#dayRpcTeflon2").val(),
	   	        	'rpcTeflon3'		:	$("#dayRpcTeflon3").val(),
	   	        	'rpcTeflon4'		:	$("#dayRpcTeflon4").val(),
	   	        	'rpcTeflon5'		:	$("#dayRpcTeflon5").val(),
	   	        	'rpcJc1'			:	$("#dayRpcJc1").val(),
	   	        	'rpcJc2'			:	$("#dayRpcJc2").val(),
	   	        	'rpcJc3'			:	$("#dayRpcJc3").val(),
	   	        	'rpcJc4'			:	$("#dayRpcJc4").val(),
	   	        	'rpcJc5'			:	$("#dayRpcJc5").val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if ( dayReplaceFaultySearchData == "success" ){
		   	     			toastr.success("주간 교체불량 수정 되었습니다.");
			   	 		} else if ( dayReplaceFaultySearchData == "fail" ) {
			   	 			toastr.success("주간 교체불량 저장 되었습니다.");
			   	 		}
	   	            	$('#dayReplaceFaultySearchData').val("success");
		   	        	//viewForm(true);
		   	        	readTotal();
					}
	   	         	else if (res.result == "fail") {
		   	     		if ( dayReplaceFaultySearchData == "success" ){
		   	     			toastr.error("주간 교체불량 수정 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if ( dayReplaceFaultySearchData == "fail" ) {
			   	 			toastr.error("주간 교체불량 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		}
					}
	   	        },
	   	        complete:function(){
	   	        	//$('#replaceFaultyBtnSave').attr('disabled', true);
	   	        	//$('#replaceFaultyBtnEdit').attr('disabled', false);
				}
			});
				
		//주간 설비트러블불량 저장&수정
		} else if (sideView == "trouble"){
			let dayTroubleFaultySearchData = $('#dayTroubleFaultySearchData').val();
			if ( dayTroubleFaultySearchData == "success" ){
				url = "po/updateTroubleFaulty";
			} else if ( dayTroubleFaultySearchData == "fail" ) {
				url = "po/createTroubleFaulty";
			}
			$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 			: 	menuAuth,
	   	        	'equipCd'				:	function() { return equipCd; },
	   	        	'faultyRegDate'			:	function() { return chooseDate.replace(/-/g, ''); }, 
	   	        	'dayNightCd'			:	"D",
	   	        	'trbServo1'				:	$("#dayTrbServo1").val(),
	   	        	'trbServo2'				:	$("#dayTrbServo2").val(),
	   	        	'trbServoContent'		:	$("#dayTrbServoContent").val(),
	   	        	'trbFuse1'				:	$("#dayTrbFuse1").val(),
	   	        	'trbFuse2'				:	$("#dayTrbFuse2").val(),
	   	        	'trbFuseContent'		:	$("#dayTrbFuseContent").val(),
	   	        	'trbGearmotor1'			:	$("#dayTrbGearmotor1").val(),
	   	        	'trbGearmotor2'			:	$("#dayTrbGearmotor2").val(),
	   	        	'trbGearmotorContent'	:	$("#dayTrbGearmotorContent").val(),
	   	        	'trbTempatur1'			:	$("#dayTrbTempatur1").val(),
	   	        	'trbTempatur2'			:	$("#dayTrbTempatur2").val(),
	   	        	'trbTempaturContent'	:	$("#dayTrbTempaturContent").val(),
	   	        	'trbPnumt1'				:	$("#dayTrbPnumt1").val(),
	   	        	'trbPnumt2'				:	$("#dayTrbPnumt2").val(),
	   	        	'trbPnumtContent'		:	$("#dayTrbPnumtContent").val(),
	   	        	'trbCutting1'			:	$("#dayTrbCutting1").val(),
	   	        	'trbCutting2'			:	$("#dayTrbCutting2").val(),
	   	        	'trbCuttingContent'		:	$("#dayTrbCuttingContent").val(),
	   	        	'trbSensor1'			:	$("#dayTrbSensor1").val(),
	   	        	'trbSensor2'			:	$("#dayTrbSensor2").val(),
	   	        	'trbSensorContent'		:	$("#dayTrbSensorContent").val(),
	   	        	'trbCylinder1'			:	$("#dayTrbCylinder1").val(),
	   	        	'trbCylinder2'			:	$("#dayTrbCylinder2").val(),
	   	        	'trbCylinderContent'	:	$("#dayTrbCylinderContent").val(),
	   	        	'trbVision1'			:	$("#dayTrbVision1").val(),
	   	        	'trbVision2'			:	$("#dayTrbVision2").val(),
	   	        	'trbVisionContent'		:	$("#dayTrbVisionContent").val(),
	   	        	'trbEtc1'				:	$("#dayTrbEtc1").val(),
	   	        	'trbEtc2'				:	$("#dayTrbEtc2").val(),
	   	        	'trbEtcContent'			:	$("#dayTrbEtcContent").val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if ( dayTroubleFaultySearchData == "success" ){
		   	     			toastr.success("주간 설비트러블 불량 수정되었습니다.");
			   	 		} else if ( dayTroubleFaultySearchData == "fail" ) {
			   	 			toastr.success("주간 설비트러블 불량 저장되었습니다.");
			   	 		}
	   	            	$('#dayTroubleFaultySearchData').val("success");
		   	        	//viewForm(true);
		   	        	readTotal();
					}
	   	            else if (res.result == "fail") {
		   	     		if ( dayTroubleFaultySearchData == "success" ){
		   	     			toastr.error("주간 설비트러블 불량  수정 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if ( dayTroubleFaultySearchData == "fail" ) {
			   	 			toastr.error("주간 설비트러블 불량 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		}
					}
	   	        },
	   	        complete:function(){
	   	        	//$('#troubleFaultyBtnSave').attr('disabled', true);
	   	        	//$('#troubleFaultyBtnEdit').attr('disabled', false);
				}
			});
		}
	});


	//야간 저장 버튼
	$('#nightBtnSave').on('click', function() {

		//야간 공정불량 저장&수정
		if (sideView == "prcss"){
			let nightPrcssFaultySearchData = $('#nightPrcssFaultySearchData').val();
			if ( nightPrcssFaultySearchData == "success" ){
				url = "po/updatePrcssFaulty";
			} else if ( nightPrcssFaultySearchData == "fail" ) {
				url = "po/createPrcssFaulty";
			}
			$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 		: 	menuAuth,
	   	        	'equipCd'			:	function() { return equipCd; },
	   	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); }, 
	   	        	'dayNightCd'		:	"N",
					'prcsPms'			: 	$('#nightPrcsPms').val(),
					'prcsPfs'			: 	$('#nightPrcsPfs').val(),
					'prcsPstab'			: 	$('#nightPrcsPstab').val(),
					'prcsPaliensbst'	: 	$('#nightPrcsPaliensbst').val(),
					'prcsPpolutn'		: 	$('#nightPrcsPpolutn').val(),
					'prcsGilt'			: 	$('#nightPrcsGilt').val(),
					'prcsFbreak'		: 	$('#nightPrcsFbreak').val(),
					'prcsFagglomt'		: 	$('#nightPrcsFagglomt').val(),
					'prcsFpress'		: 	$('#nightPrcsFpress').val(),
					'prcsFtornout'		: 	$('#nightPrcsFtornout').val(),
					'prcsTeflon'		: 	$('#nightPrcsTeflon').val(),
					'prcsMargnDvat'		: 	$('#nightPrcsMargnDvat').val(),
					'prcsThickness'		: 	$('#nightPrcsThickness').val(),
					'prcsSurfceBb'		: 	$('#nightPrcsSurfceBb').val(),
					'prcsEdgeBb'		: 	$('#nightPrcsEdgeBb').val(),
					'prcsMburr'			: 	$('#nightPrcsMburr').val(),
					'prcsRburr'			: 	$('#nightPrcsRburr').val(),
					'prcsSize'			: 	$('#nightPrcsSize').val(),
					'prcsLayer'			: 	$('#nightPrcsLayer').val(),
					'prcsUnjinjeop'		: 	$('#nightPrcsUnjinjeop').val(),
					'prcsUnattch'		: 	$('#nightPrcsUnattch').val(),
					'prcsFilmDepth'		: 	$('#nightPrcsFilmDepth').val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if ( nightPrcssFaultySearchData == "success" ){
		   	     			toastr.success("야간 공정불량 수정 되었습니다.");
			   	 		} else if ( nightPrcssFaultySearchData == "fail" ) {
			   	 			toastr.success("야간 공정불량 저장 되었습니다.");
			   	 		}
	 	            	$('#nightPrcssFaultySearchData').val("success");
		   	        	//viewForm(true);
		   	        	readTotal();
					}
	   	            else if (res.result == 'fail'){
		   	     		if ( nightPrcssFaultySearchData == "success" ){
		   	     			toastr.error("야간 공정불량 수정 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if ( nightPrcssFaultySearchData == "fail" ) {
			   	 			toastr.error("야간 공정불량 저장 실패하였습니다.", '', {timeOut: 5000});
						}
					}
	   	        },
	   	        complete:function(){
	   	        	//$('#prcssFaultyBtnSave').attr('disabled', true);
	   	        	//$('#prcssFaultyBtnEdit').attr('disabled', false);
				}
			});

		//야간 원자재불량 저장&수정	
		} else if (sideView == "matrl"){
			let nightMatrlFaultySearchData = $('#nightMatrlFaultySearchData').val();
			if ( nightMatrlFaultySearchData == "success" ){
				url = "po/updateMatrlFaulty";
			} else if ( nightMatrlFaultySearchData == "fail" ) {
				url = "po/createMatrlFaulty";
			}
			$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 		: 	menuAuth,
	   	        	'equipCd'			:	function() { return equipCd; },
	   	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); }, 
	   	        	'dayNightCd'		:	"N",
	   	        	'matrlMmb'			:	$("#nightMatrlMmb").val(),
	   	        	'matrlMms'			:	$("#nightMatrlMms").val(),
	   	        	'matrlMaliensbst'	:	$("#nightMatrlMaliensbst").val(),
	   	        	'matrlMflex'		:	$("#nightMatrlMflex").val(),
	   	        	'matrlMpolutn'		:	$("#nightMatrlMpolutn").val(),
	   	        	'matrlGilt'			:	$("#nightMatrlGilt").val(),
	   	        	'matrlMstab'		:	$("#nightMatrlMstab").val(),
	   	        	'matrlFagglomt'		:	$("#nightMatrlFagglomt").val(),
	   	        	'matrlSpot'			:	$("#nightMatrlSpot").val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if ( nightMatrlFaultySearchData == "success" ){
		   	     			toastr.success("야간 원자재불량 수정 되었습니다.");
			   	 		} else if ( nightMatrlFaultySearchData == "fail" ) {
			   	 			toastr.success("야간 원자재불량 저장 되었습니다.");
			   	 		}
	   	            	$('#nightMatrlFaultySearchData').val("success");
		   	        	//viewForm(true);
		   	        	readTotal();
					}
	   	         	else if (res.result == "fail") {
		   	     		if ( nightMatrlFaultySearchData == "success" ){
		   	     			toastr.error("야간 원자재불량 수정 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if ( nightMatrlFaultySearchData == "fail" ) {
			   	 			toastr.error("야간 원자재불량 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		}
					}
	   	        },
	   	        complete:function(){
	   	        	//$('#matrlFaultyBtnSave').attr('disabled', true);
	   	        	//$('#matrlFaultyBtnEdit').attr('disabled', false);
				}
			});

		//야간 교체불량 저장&수정
		} else if (sideView == "replace"){
			let nightReplaceFaultySearchData = $('#nightReplaceFaultySearchData').val();
			if ( nightReplaceFaultySearchData == "success" ){
				url = "po/updateReplaceFaulty";
			} else if ( nightReplaceFaultySearchData == "fail" ) {
				url = "po/createReplaceFaulty";
			}
			$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 		: 	menuAuth,
	   	        	'equipCd'			:	function() { return equipCd; },
	   	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); }, 
	   	        	'dayNightCd'		:	"N",
	   	        	'rpcMetal1'			:	$("#nightRpcMetal1").val(),
	   	        	'rpcMetal2'			:	$("#nightRpcMetal2").val(),
	   	        	'rpcMetal3'			:	$("#nightRpcMetal3").val(),
	   	        	'rpcMetal4'			:	$("#nightRpcMetal4").val(),
	   	        	'rpcMetal5'			:	$("#nightRpcMetal5").val(),
	   	        	'rpcFilm1'			:	$("#nightRpcFilm1").val(),
	   	        	'rpcFilm2'			:	$("#nightRpcFilm2").val(),
	   	        	'rpcFilm3'			:	$("#nightRpcFilm3").val(),
	   	        	'rpcFilm4'			:	$("#nightRpcFilm4").val(),
	   	        	'rpcFilm5'			:	$("#nightRpcFilm5").val(),
	   	        	'rpcSilicon1'		:	$("#nightRpcSilicon1").val(),
	   	        	'rpcSilicon2'		:	$("#nightRpcSilicon2").val(),
	   	        	'rpcSilicon3'		:	$("#nightRpcSilicon3").val(),
	   	        	'rpcSilicon4'		:	$("#nightRpcSilicon4").val(),
	   	        	'rpcSilicon5'		:	$("#nightRpcSilicon5").val(),
	   	        	'rpcTeflon1'		:	$("#nightRpcTeflon1").val(),
	   	        	'rpcTeflon2'		:	$("#nightRpcTeflon2").val(),
	   	        	'rpcTeflon3'		:	$("#nightRpcTeflon3").val(),
	   	        	'rpcTeflon4'		:	$("#nightRpcTeflon4").val(),
	   	        	'rpcTeflon5'		:	$("#nightRpcTeflon5").val(),
	   	        	'rpcJc1'			:	$("#nightRpcJc1").val(),
	   	        	'rpcJc2'			:	$("#nightRpcJc2").val(),
	   	        	'rpcJc3'			:	$("#nightRpcJc3").val(),
	   	        	'rpcJc4'			:	$("#nightRpcJc4").val(),
	   	        	'rpcJc5'			:	$("#nightRpcJc5").val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if ( nightReplaceFaultySearchData == "success" ){
		   	     			toastr.success("야간 교체불량 수정 되었습니다.");
			   	 		} else if ( nightReplaceFaultySearchData == "fail" ) {
			   	 			toastr.success("야간 교체불량 저장 되었습니다.");
			   	 		}
	   	            	$('#nightReplaceFaultySearchData').val("success");
		   	        	//viewForm(true);
		   	        	readTotal();
					}
	   	         	else if (res.result == "fail") {
		   	     		if ( nightReplaceFaultySearchData == "success" ){
		   	     			toastr.error("야간 교체불량 수정 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if ( nightReplaceFaultySearchData == "fail" ) {
			   	 			toastr.error("야간 교체불량 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		}
					}
	   	        },
	   	        complete:function(){
	   	        	//$('#replaceFaultyBtnSave').attr('disabled', true);
	   	        	//$('#replaceFaultyBtnEdit').attr('disabled', false);
				}
			});

		//야간 설비트러블불량 저장&수정
		} else if (sideView == "trouble"){
			let nightTroubleFaultySearchData = $('#nightTroubleFaultySearchData').val();
			if ( nightTroubleFaultySearchData == "success" ){
				url = "po/updateTroubleFaulty";
			} else if ( nightTroubleFaultySearchData == "fail" ) {
				url = "po/createTroubleFaulty";
			}
			$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 			: 	menuAuth,
	   	        	'equipCd'				:	function() { return equipCd; },
	   	        	'faultyRegDate'			:	function() { return chooseDate.replace(/-/g, ''); }, 
	   	        	'dayNightCd'			:	"N",
	   	        	'trbServo1'				:	$("#nightTrbServo1").val(),
	   	        	'trbServo2'				:	$("#nightTrbServo2").val(),
	   	        	'trbServoContent'		:	$("#nightTrbServoContent").val(),
	   	        	'trbFuse1'				:	$("#nightTrbFuse1").val(),
	   	        	'trbFuse2'				:	$("#nightTrbFuse2").val(),
	   	        	'trbFuseContent'		:	$("#nightTrbFuseContent").val(),
	   	        	'trbGearmotor1'			:	$("#nightTrbGearmotor1").val(),
	   	        	'trbGearmotor2'			:	$("#nightTrbGearmotor2").val(),
	   	        	'trbGearmotorContent'	:	$("#nightTrbGearmotorContent").val(),
	   	        	'trbTempatur1'			:	$("#nightTrbTempatur1").val(),
	   	        	'trbTempatur2'			:	$("#nightTrbTempatur2").val(),
	   	        	'trbTempaturContent'	:	$("#nightTrbTempaturContent").val(),
	   	        	'trbPnumt1'				:	$("#nightTrbPnumt1").val(),
	   	        	'trbPnumt2'				:	$("#nightTrbPnumt2").val(),
	   	        	'trbPnumtContent'		:	$("#nightTrbPnumtContent").val(),
	   	        	'trbCutting1'			:	$("#nightTrbCutting1").val(),
	   	        	'trbCutting2'			:	$("#nightTrbCutting2").val(),
	   	        	'trbCuttingContent'		:	$("#nightTrbCuttingContent").val(),
	   	        	'trbSensor1'			:	$("#nightTrbSensor1").val(),
	   	        	'trbSensor2'			:	$("#nightTrbSensor2").val(),
	   	        	'trbSensorContent'		:	$("#nightTrbSensorContent").val(),
	   	        	'trbCylinder1'			:	$("#nightTrbCylinder1").val(),
	   	        	'trbCylinder2'			:	$("#nightTrbCylinder2").val(),
	   	        	'trbCylinderContent'	:	$("#nightTrbCylinderContent").val(),
	   	        	'trbVision1'			:	$("#nightTrbVision1").val(),
	   	        	'trbVision2'			:	$("#nightTrbVision2").val(),
	   	        	'trbVisionContent'		:	$("#nightTrbVisionContent").val(),
	   	        	'trbEtc1'				:	$("#nightTrbEtc1").val(),
	   	        	'trbEtc2'				:	$("#nightTrbEtc2").val(),
	   	        	'trbEtcContent'			:	$("#nightTrbEtcContent").val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if ( nightTroubleFaultySearchData == "success" ){
		   	     			toastr.success("야간 설비트러블 불량 수정되었습니다.");
			   	 		} else if ( nightTroubleFaultySearchData == "fail" ) {
			   	 			toastr.success("야간 설비트러블 불량 저장되었습니다.");
			   	 		}
	   	            	$('#nightTroubleFaultySearchData').val("success");
		   	        	//viewForm(true);
		   	        	readTotal();
					}
	   	            else if (res.result == "fail") {
		   	     		if ( nightTroubleFaultySearchData == "success" ){
		   	     			toastr.error("야간 설비트러블 불량  수정 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if ( nightTroubleFaultySearchData == "fail" ) {
			   	 			toastr.error("야간 설비트러블 불량 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		}
					}
	   	        },
	   	        complete:function(){
	   	        	//$('#troubleFaultyBtnSave').attr('disabled', true);
	   	        	//$('#troubleFaultyBtnEdit').attr('disabled', false);
				}
			});
		}
		
	});

	/* -----------------------------------------------------------------원자재불량 시작----------------------------------------------------------------- */
	//원자재불량 행 클릭
	$('.select_matrlFaulty').on('click', function() {
		if( equipCd != null){
	        $('#cardDay').removeClass('d-none');	//주간 상단 버튼 표시
	        $('#cardNight').removeClass('d-none');	//야간 상단 버튼 표시

			$('#dayPrcssFaultyView').addClass('d-none');
			$('#nightPrcssFaultyView').addClass('d-none');
			$('#dayMatrlFaultyView').removeClass('d-none');
			$('#nightMatrlFaultyView').removeClass('d-none');
			$('#dayReplaceFaultyView').addClass('d-none');
			$('#nightReplaceFaultyView').addClass('d-none');
			$('#dayTroubleFaultyView').addClass('d-none');
			$('#nightTroubleFaultyView').addClass('d-none');
			
			if (matrlTemp == 0){
				$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_matrlFaulty').css({ "background-color": "#0275D8", "color": "#ffffff" });
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				prcssTemp = 0;
				matrlTemp = 1;
				replaceTemp = 0;
				troubleTemp = 0;
				sideView = "matrl";
				$('.day').attr('disabled', true);
				$('.night').attr('disabled', true);
				readMatrlFaulty();
			}
			else if (matrlTemp == 1) {
				$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				matrlTemp = 0;
			}
		}
	});

	//원자재불량 주야 조회
	function readMatrlFaulty()	{

		//원자재 주간
 		$.ajax({
  	    	url: '<c:url value="po/readMatrlFaulty"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); },
  	        	'dayNightCd'		:	"D",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#dayMatrlFaultySearchData').val("fail");
  	   	            } else {
	   	   	          	$('#dayMatrlMmb').val(data.matrlMmb),
	   	   	          	$('#dayMatrlMms').val(data.matrlMms),
	   	   	          	$('#dayMatrlMaliensbst').val(data.matrlMaliensbst),
	   	   	          	$('#dayMatrlMflex').val(data.matrlMflex),
	   	   	          	$('#dayMatrlMpolutn').val(data.matrlMpolutn),
	   	   	          	$('#dayMatrlGilt').val(data.matrlGilt),
	   	   	          	$('#dayMatrlMstab').val(data.matrlMstab),
	   	   	          	$('#dayMatrlFagglomt').val(data.matrlFagglomt),
	   	   	          	$('#dayMatrlSpot').val(data.matrlSpot),   	   	          	
	   	   	          		 	            	
	 	            	$('#dayMatrlFaultySearchData').val("success"); 
					}
				} 
				else {
					toastr.error("원자재불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#dayMatrlFaultySearchData').val() == "fail"){
  	        		$('.day').val("0");
  	  	  		}
			}
		});

 		//원자재 야간
 		$.ajax({
  	    	url: '<c:url value="po/readMatrlFaulty"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); },
  	        	'dayNightCd'		:	"N",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {

  	            	if ( data == null) {
  	            		$('#nightMatrlFaultySearchData').val("fail");
  	   	            } else {
	   	   	          	$('#nightMatrlMmb').val(data.matrlMmb),
	   	   	          	$('#nightMatrlMms').val(data.matrlMms),
	   	   	          	$('#nightMatrlMaliensbst').val(data.matrlMaliensbst),
	   	   	          	$('#nightMatrlMflex').val(data.matrlMflex),
	   	   	          	$('#nightMatrlMpolutn').val(data.matrlMpolutn),
	   	   	          	$('#nightMatrlGilt').val(data.matrlGilt),
	   	   	          	$('#nightMatrlMstab').val(data.matrlMstab),
	   	   	          	$('#nightMatrlFagglomt').val(data.matrlFagglomt),
	   	   	          	$('#nightMatrlSpot').val(data.matrlSpot),   	   	          	
	   	   	          	 	
	 	            	$('#nightMatrlFaultySearchData').val("success"); 
					}
				} 
				else {
					toastr.error("원자재불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#nightMatrlFaultySearchData').val() == "fail"){
  	        		$('.night').val("0");
  	  	  		}
			}
		});
	};

	/* -----------------------------------------------------------------원자재불량 끝----------------------------------------------------------------- */


	/* -----------------------------------------------------------------교체불량 시작----------------------------------------------------------------- */
	//교체불량 행 클릭
	$('.select_replaceFaulty').on('click', function() {
		if( equipCd != null){
	        $('#cardDay').removeClass('d-none');	//주간 상단 버튼 표시
	        $('#cardNight').removeClass('d-none');	//야간 상단 버튼 표시

			$('#dayPrcssFaultyView').addClass('d-none');
			$('#nightPrcssFaultyView').addClass('d-none');
			$('#dayMatrlFaultyView').addClass('d-none');
			$('#nightMatrlFaultyView').addClass('d-none');
			$('#dayReplaceFaultyView').removeClass('d-none');
			$('#nightReplaceFaultyView').removeClass('d-none');
			$('#dayTroubleFaultyView').addClass('d-none');
			$('#nightTroubleFaultyView').addClass('d-none');
			
			if (replaceTemp == 0){
				$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_replaceFaulty').css({ "background-color": "#0275D8", "color": "#ffffff" });
				$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				prcssTemp = 0;
				matrlTemp = 0;
				replaceTemp = 1;
				troubleTemp = 0;
				sideView = "replace";
				$('.day').attr('disabled', true);
				$('.night').attr('disabled', true);
				readReplaceFaulty();
			}
			else if (replaceTemp == 1) {
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				replaceTemp = 0;
			}			
		}
	});

	//교체불량 주야 조회
	function readReplaceFaulty()	{

		//주간
 		$.ajax({
  	    	url: '<c:url value="po/readReplaceFaulty"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 		: 		menuAuth,
  	        	'equipCd'			:		function() { return equipCd; },
  	        	'faultyRegDate'		:		function() { return chooseDate.replace(/-/g, ''); },
  	        	'dayNightCd'		:		"D",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#dayReplaceFaultySearchData').val("fail");
  	   	            } else {
	   	   	          	$('#dayRpcMetal1').val(data.rpcMetal1),
	   	   	          	$('#dayRpcMetal2').val(data.rpcMetal2),
	   	   	          	$('#dayRpcMetal3').val(data.rpcMetal3),
	   	   	          	$('#dayRpcMetal4').val(data.rpcMetal4),
	   	   	          	$('#dayRpcMetal5').val(data.rpcMetal5),
	   	   	          	$('#dayRpcFilm1').val(data.rpcFilm1),
	   	   	          	$('#dayRpcFilm2').val(data.rpcFilm2),
	   	   	          	$('#dayRpcFilm3').val(data.rpcFilm3),
	   	   	          	$('#dayRpcFilm4').val(data.rpcFilm4),
	   	   	          	$('#dayRpcFilm5').val(data.rpcFilm5),
	   	   	          	$('#dayRpcSilicon1').val(data.rpcSilicon1),
	   	   	          	$('#dayRpcSilicon2').val(data.rpcSilicon2),
	   	   	          	$('#dayRpcSilicon3').val(data.rpcSilicon3),
	   	   	          	$('#dayRpcSilicon4').val(data.rpcSilicon4),
	   	   	          	$('#dayRpcSilicon5').val(data.rpcSilicon5),
	   	   	          	$('#dayRpcTeflon1').val(data.rpcTeflon1),
	   	   	          	$('#dayRpcTeflon2').val(data.rpcTeflon2),
	   	   	          	$('#dayRpcTeflon3').val(data.rpcTeflon3),
	   	   	          	$('#dayRpcTeflon4').val(data.rpcTeflon4),
	   	   	          	$('#dayRpcTeflon5').val(data.rpcTeflon5),
	   	   	          	$('#dayRpcJc1').val(data.rpcJc1),
	   	   	          	$('#dayRpcJc2').val(data.rpcJc2),
	   	   	          	$('#dayRpcJc3').val(data.rpcJc3),
	   	   	          	$('#dayRpcJc4').val(data.rpcJc4),
	   	   	          	$('#dayRpcJc5').val(data.rpcJc5),  	   	          	
       	
	 	            	$('#dayReplaceFaultySearchData').val("success"); 
					}
				} 
				else {
					toastr.error("주간 교체불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#dayReplaceFaultySearchData').val() == "fail"){
  	        		$('.day').val("0");
  	  	  		}
			}
		});

		//야간
 		$.ajax({
  	    	url: '<c:url value="po/readReplaceFaulty"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 		: 		menuAuth,
  	        	'equipCd'			:		function() { return equipCd; },
  	        	'faultyRegDate'		:		function() { return chooseDate.replace(/-/g, ''); },
  	        	'dayNightCd'		:		"N",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#nightReplaceFaultySearchData').val("fail");
  	   	            } else {
	   	   	          	$('#nightRpcMetal1').val(data.rpcMetal1),
	   	   	          	$('#nightRpcMetal2').val(data.rpcMetal2),
	   	   	          	$('#nightRpcMetal3').val(data.rpcMetal3),
	   	   	          	$('#nightRpcMetal4').val(data.rpcMetal4),
	   	   	          	$('#nightRpcMetal5').val(data.rpcMetal5),
	   	   	          	$('#nightRpcFilm1').val(data.rpcFilm1),
	   	   	          	$('#nightRpcFilm2').val(data.rpcFilm2),
	   	   	          	$('#nightRpcFilm3').val(data.rpcFilm3),
	   	   	          	$('#nightRpcFilm4').val(data.rpcFilm4),
	   	   	          	$('#nightRpcFilm5').val(data.rpcFilm5),
	   	   	          	$('#nightRpcSilicon1').val(data.rpcSilicon1),
	   	   	          	$('#nightRpcSilicon2').val(data.rpcSilicon2),
	   	   	          	$('#nightRpcSilicon3').val(data.rpcSilicon3),
	   	   	          	$('#nightRpcSilicon4').val(data.rpcSilicon4),
	   	   	          	$('#nightRpcSilicon5').val(data.rpcSilicon5),
	   	   	          	$('#nightRpcTeflon1').val(data.rpcTeflon1),
	   	   	          	$('#nightRpcTeflon2').val(data.rpcTeflon2),
	   	   	          	$('#nightRpcTeflon3').val(data.rpcTeflon3),
	   	   	          	$('#nightRpcTeflon4').val(data.rpcTeflon4),
	   	   	          	$('#nightRpcTeflon5').val(data.rpcTeflon5),
	   	   	          	$('#nightRpcJc1').val(data.rpcJc1),
	   	   	          	$('#nightRpcJc2').val(data.rpcJc2),
	   	   	          	$('#nightRpcJc3').val(data.rpcJc3),
	   	   	          	$('#nightRpcJc4').val(data.rpcJc4),
	   	   	          	$('#nightRpcJc5').val(data.rpcJc5),  	   	          	
       	
	 	            	$('#nightReplaceFaultySearchData').val("success"); 
					}
				} 
				else {
					toastr.error("주간 교체불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#nightReplaceFaultySearchData').val() == "fail"){
  	        		$('.night').val("0");
  	  	  		}
			}
		});
	};

	/* -----------------------------------------------------------------교체불량 끝----------------------------------------------------------------- */

	/* -----------------------------------------------------------------설비 트러불 불량 시작----------------------------------------------------------------- */
	//설비 트러블 행 클릭
	$('.select_troubleFaulty').on('click', function() {
		if( equipCd != null){
	        $('#cardDay').removeClass('d-none');	//주간 상단 버튼 표시
	        $('#cardNight').removeClass('d-none');	//야간 상단 버튼 표시
			$('#dayPrcssFaultyView').addClass('d-none');
			$('#nightPrcssFaultyView').addClass('d-none');
			$('#dayMatrlFaultyView').addClass('d-none');
			$('#nightMatrlFaultyView').addClass('d-none');
			$('#dayReplaceFaultyView').addClass('d-none');
			$('#nightReplaceFaultyView').addClass('d-none');
			$('#dayTroubleFaultyView').removeClass('d-none');
			$('#nightTroubleFaultyView').removeClass('d-none');

			if (troubleTemp == 0){
				$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_troubleFaulty').css({ "background-color": "#0275D8", "color": "#ffffff" });
				prcssTemp = 0;
				matrlTemp = 0;
				replaceTemp = 0;
				troubleTemp = 1;
				sideView = "trouble";
				$('.day').attr('disabled', true);
				$('.night').attr('disabled', true);
				readTroubleFaulty();
			}
			else if (troubleTemp == 1) {
				$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				troubleTemp = 0;
			}			
		}
	});
	
	//설비 트러불 불량 주야 조회
	function readTroubleFaulty() {
		//주간
 		$.ajax({
  	    	url: '<c:url value="po/readTroubleFaulty"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); },
  	        	'dayNightCd'		:	"D",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#dayTroubleFaultySearchData').val("fail");
  	   	            } else {
	   	   	          	$('#dayTrbServo1').val(data.trbServo1),
	   	   	          	$('#dayTrbServo2').val(data.trbServo2),
	   	   	          	$('#dayTrbServoContent').val(data.trbServoContent),
	   	   	          	$('#dayTrbFuse1').val(data.trbFuse1),
	   	   	          	$('#dayTrbFuse2').val(data.trbFuse2),
	   	   	          	$('#dayTrbFuseContent').val(data.trbFuseContent),
	   	   	          	$('#dayTrbGearmotor1').val(data.trbGearmotor1),
	   	   	          	$('#dayTrbGearmotor2').val(data.trbGearmotor2),
	   	   	          	$('#dayTrbGearmotorContent').val(data.trbGearmotorContent),
	   	   	          	$('#dayTrbTempatur1').val(data.trbTempatur1),
	   	   	          	$('#dayTrbTempatur2').val(data.trbTempatur2),
	   	   	          	$('#dayTrbTempaturContent').val(data.trbTempaturContent),
	   	   	          	$('#dayTrbPnumt1').val(data.trbPnumt1),
	   	   	          	$('#dayTrbPnumt2').val(data.trbPnumt2),
	   	   	          	$('#dayTrbPnumtContent').val(data.trbPnumtContent),
	   	   	          	$('#dayTrbCutting1').val(data.trbCutting1),
	   	   	          	$('#dayTrbCutting2').val(data.trbCutting2),
	   	   	          	$('#dayTrbCuttingContent').val(data.trbCuttingContent),
	   	   	          	$('#dayTrbSensor1').val(data.trbSensor1),
	   	   	          	$('#dayTrbSensor2').val(data.trbSensor2),
	   	   	          	$('#dayTrbSensorContent').val(data.trbSensorContent),
	   	   	          	$('#dayTrbCylinder1').val(data.trbCylinder1),
	   	   	          	$('#dayTrbCylinder2').val(data.trbCylinder2),
	   	   	          	$('#dayTrbCylinderContent').val(data.trbCylinderContent),
	   	   	          	$('#dayTrbVision1').val(data.trbVision1),
	   	   	          	$('#dayTrbVision2').val(data.trbVision2),
	   	   	          	$('#dayTrbVisionContent').val(data.trbVisionContent),
	   	   	          	$('#dayTrbEtc1').val(data.trbEtc1),
	   	   	          	$('#dayTrbEtc2').val(data.trbEtc2),
	   	   	          	$('#dayTrbEtcContent').val(data.trbEtcContent),
       	
	 	            	$('#dayTroubleFaultySearchData').val("success"); 
					}
				} 
				else {
   	            	toastr.error("설비 트러불 불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#dayTroubleFaultySearchData').val() == "fail"){
  	  	  			$('.day').val("0");
  	  	  			$('.dayText').val("-");
  	  	  		}
			}
		});

		//야간
 		$.ajax({
  	    	url: '<c:url value="po/readTroubleFaulty"/>',
  	        type: 'GET',
  	        data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'faultyRegDate'		:	function() { return chooseDate.replace(/-/g, ''); },
  	        	'dayNightCd'		:	"N",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#nightTroubleFaultySearchData').val("fail");
  	            		//viewClear();
  	   	            } else {
	   	   	          	$('#nightTrbServo1').val(data.trbServo1),
	   	   	          	$('#nightTrbServo2').val(data.trbServo2),
	   	   	          	$('#nightTrbServoContent').val(data.trbServoContent),
	   	   	          	$('#nightTrbFuse1').val(data.trbFuse1),
	   	   	          	$('#nightTrbFuse2').val(data.trbFuse2),
	   	   	          	$('#nightTrbFuseContent').val(data.trbFuseContent),
	   	   	          	$('#nightTrbGearmotor1').val(data.trbGearmotor1),
	   	   	          	$('#nightTrbGearmotor2').val(data.trbGearmotor2),
	   	   	          	$('#nightTrbGearmotorContent').val(data.trbGearmotorContent),
	   	   	          	$('#nightTrbTempatur1').val(data.trbTempatur1),
	   	   	          	$('#nightTrbTempatur2').val(data.trbTempatur2),
	   	   	          	$('#nightTrbTempaturContent').val(data.trbTempaturContent),
	   	   	          	$('#nightTrbPnumt1').val(data.trbPnumt1),
	   	   	          	$('#nightTrbPnumt2').val(data.trbPnumt2),
	   	   	          	$('#nightTrbPnumtContent').val(data.trbPnumtContent),
	   	   	          	$('#nightTrbCutting1').val(data.trbCutting1),
	   	   	          	$('#nightTrbCutting2').val(data.trbCutting2),
	   	   	          	$('#nightTrbCuttingContent').val(data.trbCuttingContent),
	   	   	          	$('#nightTrbSensor1').val(data.trbSensor1),
	   	   	          	$('#nightTrbSensor2').val(data.trbSensor2),
	   	   	          	$('#nightTrbSensorContent').val(data.trbSensorContent),
	   	   	          	$('#nightTrbCylinder1').val(data.trbCylinder1),
	   	   	          	$('#nightTrbCylinder2').val(data.trbCylinder2),
	   	   	          	$('#nightTrbCylinderContent').val(data.trbCylinderContent),
	   	   	          	$('#nightTrbVision1').val(data.trbVision1),
	   	   	          	$('#nightTrbVision2').val(data.trbVision2),
	   	   	          	$('#nightTrbVisionContent').val(data.trbVisionContent),
	   	   	          	$('#nightTrbEtc1').val(data.trbEtc1),
	   	   	          	$('#nightTrbEtc2').val(data.trbEtc2),
	   	   	          	$('#nightTrbEtcContent').val(data.trbEtcContent),
       	
	 	            	$('#nightTroubleFaultySearchData').val("success"); 
					}
				} 
				else {
   	            	toastr.error("설비 트러불 불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#nightTroubleFaultySearchData').val() == "fail"){
  	  	  			$('.night').val("0");
  	  	  			$('.nightText').val("-");
  	  	  		}
			}
		});
	};
	
	/* -----------------------------------------------------------------설비 트러불 불량 끝----------------------------------------------------------------- */
    
	//달력 변경시
	$("#chooseDate").change(function() {
	//$('#chooseCal').on('click', function() {
  		$('.select_prcssFaulty').css( "background-color", "#FFFFFF" );
		$('.select_matrlFaulty').css( "background-color", "#FFFFFF" );
		$('.select_replaceFaulty').css( "background-color", "#FFFFFF" );
		$('.select_troubleFaulty').css( "background-color", "#FFFFFF" );
  		$('tr.selected').removeClass('selected');
  	  	equipCd = null;
  	});

	$('#inputDay').on('click', function() {
		$('.day').attr('disabled', false);
		$('.night').attr('disabled', true);
	});

	$('#inputNight').on('click', function() {
		$('.day').attr('disabled', true);
		$('.night').attr('disabled', false);
	});
	
	
	function total()
	{
			var sum1 = parseFloat($("#dayTotalPrcssSum").text() || 0);
			var sum2 = parseFloat($("#dayTotalMatrlSum").text() || 0);
			var sum3 = parseFloat($("#dayTotalReplaceSum").text() || 0);
			var sum4 = parseFloat($("#dayTotalTroubleSum").text() || 0);
			var daySum = (sum1 + sum2 + sum3 + sum4).toFixed(1);
			$("#dayTotalSum").text(parseFloat(daySum));
			
			var sum5 = parseFloat($("#nightTotalPrcssSum").text() || 0);
			var sum6 = parseFloat($("#nightTotalMatrlSum").text() || 0);
			var sum7 = parseFloat($("#nightTotalReplaceSum").text() || 0);
			var sum8 = parseFloat($("#nightTotalTroubleSum").text() || 0);
			var nightSum = (sum5 + sum6 + sum7 + sum8).toFixed(1);
			$("#nightTotalSum").text(parseFloat(nightSum));
			
			var sum9 = parseFloat($("#totalPrcssSum").text() || 0);
			var sum10 = parseFloat($("#totalMatrlSum").text() || 0);
			var sum11 = parseFloat($("#totalReplaceSum").text() || 0);
			var sum12 = parseFloat($("#totalTroubleSum").text() || 0);
			var totalSum = (sum9 + sum10 + sum11 + sum12).toFixed(1);
			$("#totalSum").text(parseFloat(totalSum));
	}

</script>
</body>
</html>
