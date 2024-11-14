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
                <li class="breadcrumb-item active">제조조건관리(4Line)</li>
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
							<button type="button" class="btn btn-primary" id="sizeBtn" onClick="sizeList()" disabled>치수 선택</button>
					
							<input type="hidden" id="hiddenEquipCondSeq" name="equipCondSeq">
							<button type="button" class="btn btn-secondary float-right mr-2" id="btnClose">닫기</button>
							<button type="button" class="btn btn-primary float-right mr-2"	 id="btnEdit">수정</button>
							<button type="button" class="btn btn-primary float-right mr-2"	 id="btnSave">저장</button>
						</div>
						<br>
					
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
										<th>조건	</th>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpTabHeatCond"				name="upTabHeatCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownTabHeatCond"				name="downTabHeatCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpRollHeatCond"				name="upRollHeatCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownRollHeatCond"				name="downRollHeatCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpFilmJoinTopCond"			name="upFilmJoinTopCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpFilmJoinBottomCond"			name="upFilmJoinBottomCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownFilmJoinTopCond"			name="downFilmJoinTopCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownFilmJoinBottomCond"		name="downFilmJoinBottomCond"	style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownTabHeatKeepCond"			name="downTabHeatKeepCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTsidCond"				name="fup1stMTsidCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTsidCond"			name="fdown1stMTsidCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTmidCond"				name="fup1stMTmidCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTmidCond"			name="fdown1stMTmidCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTpushCond"				name="fup1stMTpushCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTpushCond"			name="fdown1stMTpushCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stMTsidCond"				name="bup1stMTsidCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stMTsidCond"			name="bdown1stMTsidCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stMTmidCond"				name="bup1stMTmidCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stMTmidCond"			name="bdown1stMTmidCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stPushCond"				name="bup1stPushCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stPushCond"				name="bdown1stPushCond"			style="width:100%;" class="form-control number-float1"></input></td>
									</tr>
									<tr>
										<th>공차 (+)</th>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpTabHeatPlus"				name="upTabHeatPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownTabHeatPlus"				name="downTabHeatPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpRollHeatPlus"				name="upRollHeatPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownRollHeatPlus"				name="downRollHeatPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpFilmJoinTopPlus"			name="upFilmJoinTopPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpFilmJoinBottomPlus"			name="upFilmJoinBottomPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownFilmJoinTopPlus"			name="downFilmJoinTopPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownFilmJoinBottomPlus"		name="downFilmJoinBottomPlus"	style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownTabHeatKeepPlus"			name="downTabHeatKeepPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTsidPlus"				name="fup1stMTsidPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTsidPlus"			name="fdown1stMTsidPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTmidPlus"				name="fup1stMTmidPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTmidPlus"			name="fdown1stMTmidPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTpushPlus"				name="fup1stMTpushPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTpushPlus"			name="fdown1stMTpushPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stMTsidPlus"				name="bup1stMTsidPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stMTsidPlus"			name="bdown1stMTsidPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stMTmidPlus"				name="bup1stMTmidPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stMTmidPlus"			name="bdown1stMTmidPlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stPushPlus"				name="bup1stPushPlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stPushPlus"				name="bdown1stPushPlus"			style="width:100%;" class="form-control number-float1"></input></td>
									</tr>
									<tr>
										<th>공차 (-)</th>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpTabHeatMinus"				name="upTabHeatMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownTabHeatMinus"				name="downTabHeatMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpRollHeatMinus"				name="upRollHeatMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownRollHeatMinus"			name="downRollHeatMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpFilmJoinTopMinus"			name="upFilmJoinTopMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturUpFilmJoinBottomMinus"		name="upFilmJoinBottomMinus"	style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownFilmJoinTopMinus"			name="downFilmJoinTopMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownFilmJoinBottomMinus"		name="downFilmJoinBottomMinus"	style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturDownTabHeatKeepMinus"			name="downTabHeatKeepMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTsidMinus"				name="fup1stMTsidMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTsidMinus"			name="fdown1stMTsidMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTmidMinus"				name="fup1stMTmidMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTmidMinus"			name="fdown1stMTmidMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFup1stMTpushMinus"			name="fup1stMTpushMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturFdown1stMTpushMinus"			name="fdown1stMTpushMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stMTsidMinus"				name="bup1stMTsidMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stMTsidMinus"			name="bdown1stMTsidMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stMTmidMinus"				name="bup1stMTmidMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stMTmidMinus"			name="bdown1stMTmidMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBup1stPushMinus"				name="bup1stPushMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="tempaturBdown1stPushMinus"			name="bdown1stPushMinus"		style="width:100%;" class="form-control number-float1"></input></td>
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
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFupFilmFuseCond'				name='fupFilmFuseCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdownFilmFuseCond'			name='fdownFilmFuseCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBupFilmFuseCond'				name='bupFilmFuseCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdownFilmFuseCond'			name='bdownFilmFuseCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup2ndMTsidCond'				name='fup2ndMTsidCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup2ndMTmidCond'				name='fup2ndMTmidCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown2ndMTmidCond'			name='fdown2ndMTmidCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown2ndMTsidCond'			name='fdown2ndMTsidCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup2ndMTmidCond'				name='bup2ndMTmidCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup2ndMTsidCond'				name='bup2ndMTsidCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown2ndMTsidCond'			name='bdown2ndMTsidCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup3rdMTsidCond'				name='fup3rdMTsidCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown2ndMTmidCond'			name='bdown2ndMTmidCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown3rdMTsidCond'			name='fdown3rdMTsidCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup3rdMTmidCond'				name='fup3rdMTmidCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown3rdMTmidCond'			name='fdown3rdMTmidCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup3rdMTsidCond'				name='bup3rdMTsidCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup3rdMTmidCond'				name='bup3rdMTmidCond'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown3rdMTmidCond'			name='bdown3rdMTmidCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown3rdMTsidCond'			name='bdown3rdMTsidCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFupFilmRfmCoolCond'			name='fupFilmRfmCoolCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdownFilmRfmCoolCond'			name='fdownFilmRfmCoolCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBupFilmRfmCoolCond'			name='bupFilmRfmCoolCond'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdownFilmRfmCoolCond'			name='bdownFilmRfmCoolCond'		style='width:100%;' class='form-control number-float1'></input></td>
									</tr>
									<tr>
										<th>공차 (+)</th>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFupFilmFusePlus'				name='fupFilmFusePlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdownFilmFusePlus'			name='fdownFilmFusePlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBupFilmFusePlus'				name='bupFilmFusePlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdownFilmFusePlus'			name='bdownFilmFusePlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup2ndMTsidPlus'				name='fup2ndMTsidPlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup2ndMTmidPlus'				name='fup2ndMTmidPlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown2ndMTmidPlus'			name='fdown2ndMTmidPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown2ndMTsidPlus'			name='fdown2ndMTsidPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup2ndMTmidPlus'				name='bup2ndMTmidPlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup2ndMTsidPlus'				name='bup2ndMTsidPlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown2ndMTsidPlus'			name='bdown2ndMTsidPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup3rdMTsidPlus'				name='fup3rdMTsidPlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown2ndMTmidPlus'			name='bdown2ndMTmidPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown3rdMTsidPlus'			name='fdown3rdMTsidPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup3rdMTmidPlus'				name='fup3rdMTmidPlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown3rdMTmidPlus'			name='fdown3rdMTmidPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup3rdMTsidPlus'				name='bup3rdMTsidPlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup3rdMTmidPlus'				name='bup3rdMTmidPlus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown3rdMTmidPlus'			name='bdown3rdMTmidPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown3rdMTsidPlus'			name='bdown3rdMTsidPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFupFilmRfmCoolPlus'			name='fupFilmRfmCoolPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdownFilmRfmCoolPlus'			name='fdownFilmRfmCoolPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBupFilmRfmCoolPlus'			name='bupFilmRfmCoolPlus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdownFilmRfmCoolPlus'			name='bdownFilmRfmCoolPlus'		style='width:100%;' class='form-control number-float1'></input></td>
									</tr>
									<tr>
										<th>공차 (-)</th>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFupFilmFuseMinus'				name='fupFilmFuseMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdownFilmFuseMinus'			name='fdownFilmFuseMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBupFilmFuseMinus'				name='bupFilmFuseMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdownFilmFuseMinus'			name='bdownFilmFuseMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup2ndMTsidMinus'				name='fup2ndMTsidMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup2ndMTmidMinus'				name='fup2ndMTmidMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown2ndMTmidMinus'			name='fdown2ndMTmidMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown2ndMTsidMinus'			name='fdown2ndMTsidMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup2ndMTmidMinus'				name='bup2ndMTmidMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup2ndMTsidMinus'				name='bup2ndMTsidMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown2ndMTsidMinus'			name='bdown2ndMTsidMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup3rdMTsidMinus'				name='fup3rdMTsidMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown2ndMTmidMinus'			name='bdown2ndMTmidMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown3rdMTsidMinus'			name='fdown3rdMTsidMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFup3rdMTmidMinus'				name='fup3rdMTmidMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdown3rdMTmidMinus'			name='fdown3rdMTmidMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup3rdMTsidMinus'				name='bup3rdMTsidMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBup3rdMTmidMinus'				name='bup3rdMTmidMinus'			style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown3rdMTmidMinus'			name='bdown3rdMTmidMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdown3rdMTsidMinus'			name='bdown3rdMTsidMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFupFilmRfmCoolMinus'			name='fupFilmRfmCoolMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturFdownFilmRfmCoolMinus'		name='fdownFilmRfmCoolMinus'	style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBupFilmRfmCoolMinus'			name='bupFilmRfmCoolMinus'		style='width:100%;' class='form-control number-float1'></input></td>
										<td><input type='number'  maxlength='6' min='-1000' max='1000' step='0.1' id='tempaturBdownFilmRfmCoolMinus'		name='bdownFilmRfmCoolMinus'	style='width:100%;' class='form-control number-float1'></input></td>
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
										<th>조건	</th>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTwaittimeCond"				name="oneStMTwaittimeCond"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTheattimeCond"				name="oneStMTheattimeCond"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTpushwaittimeCond"			name="oneStMTpushwaittimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTpushheattimeCond"				name="oneStMTpushheattimeCond"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTwaittimeCond"			name="twoNdMTwaittimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTheattimeCond"				name="twoNdMTheattimeCond"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTpushwaittimeCond"			name="twoNdMTpushwaittimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTpushheattimeCond"				name="twoNdMTpushheattimeCond"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTwaittimeCond"		name="threeRdMTwaittimeCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTheattimeCond"			name="threeRdMTheattimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTpushwaittimeCond"		name="threeRdMTpushwaittimeCond"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTpushheattimeCond"			name="threeRdMTpushheattimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmFSH1operwaittimeCond"			name="filmFSH1operwaittimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmFSH1operheattimeCond"			name="filmFSH1operheattimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmRSH1operwaittimeCond"			name="filmRSH1operwaittimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmRSH1operheattimeCond"			name="filmRSH1operheattimeCond"			style="width:100%;" class="form-control number-float1"></input></td>
									</tr>
									<tr>
										<th>공차 (+)</th>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTwaittimePlus"				name="oneStMTwaittimePlus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTheattimePlus"				name="oneStMTheattimePlus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTpushwaittimePlus"			name="oneStMTpushwaittimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTpushheattimePlus"				name="oneStMTpushheattimePlus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTwaittimePlus"			name="twoNdMTwaittimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTheattimePlus"				name="twoNdMTheattimePlus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTpushwaittimePlus"			name="twoNdMTpushwaittimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTpushheattimePlus"				name="twoNdMTpushheattimePlus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTwaittimePlus"		name="threeRdMTwaittimePlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTheattimePlus"			name="threeRdMTheattimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTpushwaittimePlus"		name="threeRdMTpushwaittimePlus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTpushheattimePlus"			name="threeRdMTpushheattimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmFSH1operwaittimePlus"			name="filmFSH1operwaittimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmFSH1operheattimePlus"			name="filmFSH1operheattimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmRSH1operwaittimePlus"			name="filmRSH1operwaittimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmRSH1operheattimePlus"			name="filmRSH1operheattimePlus"			style="width:100%;" class="form-control number-float1"></input></td>
									</tr>
									<tr>
										<th>공차 (-)</th>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTwaittimeMinus"				name="oneStMTwaittimeMinus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTheattimeMinus"				name="oneStMTheattimeMinus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTpushwaittimeMinus"			name="oneStMTpushwaittimeMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeOneStMTpushheattimeMinus"				name="oneStMTpushheattimeMinus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTwaittimeMinus"			name="twoNdMTwaittimeMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTheattimeMinus"				name="twoNdMTheattimeMinus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTpushwaittimeMinus"			name="twoNdMTpushwaittimeMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeTwoNdMTpushheattimeMinus"				name="twoNdMTpushheattimeMinus"				style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTwaittimeMinus"		name="threeRdMTwaittimeMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTheattimeMinus"			name="threeRdMTheattimeMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTpushwaittimeMinus"		name="threeRdMTpushwaittimeMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeThreeRdMTpushheattimeMinus"			name="threeRdMTpushheattimeMinus"			style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmFSH1operwaittimeMinus"		name="filmFSH1operwaittimeMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmFSH1operheattimeMinus"		name="filmFSH1operheattimeMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmRSH1operwaittimeMinus"		name="filmRSH1operwaittimeMinus"		style="width:100%;" class="form-control number-float1"></input></td>
										<td><input type="number"  maxlength="6" min="-1000" max="1000" step="0.1" id="timeFilmRSH1operheattimeMinus"		name="filmRSH1operheattimeMinus"		style="width:100%;" class="form-control number-float1"></input></td>
									</tr>
								</tbody>
							</table>
							<!-- 시간 테이블 끝 -->
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
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewGapOfLayerAlwncePlus"		name="gapOfLayerPlus"			style="max-width:100%;"  class="form-control number-float3"></input></td>
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
									<td><input type="number" maxlength="6" min="-1000" max="1000" step="0.001" id="sizeViewGapOfLayerAlwnceMinus"		name="gapOfLayerMinus"				style="max-width:100%;"  class="form-control number-float3"></input></td>
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
							<th>시간코드</th>
							<th>시간명</th>
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

	let menuAuth = 'emsc3030';
	let currentHref = 'emsc3030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","제조조건관리(4Line)");
	
	var sideView = null;
	var equipCondSeq = null;
	var equipCd = null;
	var goodsCd = null;
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	
	let factoryCode = "<%=factoryCode%>";
	
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
		$('#sizeBtn').attr('disabled', false);
	});

	//제조조건 계획 등록 버튼 클릭 시
	$(document).on('click','#btnAdd', function() {
		if(equipCd == null){
			toastr.warning('등록할 설비명을 선택해 주세요.');
			return false;
		}
		
		sideView = "create"
		$('#manufacturerListTable').find('tr.selected').removeClass('selected');
   		$('#addForm').removeClass('d-none');
   		$('#viewEquipoBox').removeClass('d-none');
   		$('#tempaturBtn').attr('disabled', false);
   		$('#timeBtn').attr('disabled', false);
   		$('#sizeBtn').attr('disabled', false);
   		$('#btnSelectMatrlCode').attr('disabled', false);
   		$('#btnSave').attr('disabled', true);
   		$('#btnEdit').attr('disabled', true);
   		
   		addFormClear();
   		uiProc(false);
   		$('.number-float1, .number-float2, .number-float3').val("0");
	});
	
	//수정 버튼 클릭
	$('#btnEdit').click(function(){
		sideView = "edit"
		$('#tempaturBtn').attr('disabled', false);
		$('#timeBtn').attr('disabled', false);
		$('#sizeBtn').attr('disabled', false);
		$('#btnSave').attr('disabled', false);
		uiProc(false);
		//수정시 빈칸들 0으로 채워넣기
		$('.number-float1, .number-float2, .number-float3').each(function(index, value) {
			if ( $(this).val() == "" ){
				$(this).val("0");
			}
		});
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
            	'menuAuth'		 : menuAuth,
            	'equipGroup'	: function() { return equipGroup;	},
            	'equipGubun'	: function() { return "C";			},
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
		$('#equipCodeAdmTable').DataTable().ajax.reload();
		$('#manufacturerListTable').DataTable().clear().draw();
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
        } else {
        	
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
    						'menuAuth'	: menuAuth,
    						'equipCd'	: rowIdx,
    						'lineGubun'	: "4Line",
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
        } else {
        	$('#manufacturerListTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            
    		equipCd			= manufacturerListTable.row( this ).data().equipCd;
    		equipCondSeq	= manufacturerListTable.row( this ).data().equipCondSeq;
    		goodsCd			= manufacturerListTable.row( this ).data().goodsCd;
    		let fpUseYn		= manufacturerListTable.row( this ).data().fpUseYn;
    		let fpMainGubun	= manufacturerListTable.row( this ).data().fpMainGubun;
    		
    		$('#btnSelectMatrlCode').attr('disabled', true);
            $('#hiddenEquipCondSeq').val(equipCondSeq);	//SEQ 수정시 사용
            $('.number-float1, .number-float2, .number-float3').val("");
            
            //상세조회
            $.ajax({
            	url: '<c:url value="em/equipBomDataSixFloorList"/>',
                type: 'GET',
                data: {
                	'menuAuth'		: menuAuth,
                	'equipCondSeq'	: equipCondSeq,
                	'goodsCd'		: goodsCd,
                	'pageGubun'		: "emsc3030",
                },
                success: function (res) {
                	let manufacturerData	= res.manufacturerData;
                    let tempaturData		= res.tempaturData;
                    let timeData			= res.timeData;
                    let pressureData		= res.pressureData;
                    let sizeData			= res.sizeData;
                    
                    let domTempatur			= $('#tempatur table tbody tr').find('td input');
                    let domTime				= $('#time table tbody tr').find('td input');
                    let domSize				= $('#size table tbody tr').find('td input');
                    
                    if (res.result == 'ok') {
                    	
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
                    	
		                //온도 처리 부분
		                for(var i=0; i<domTempatur.length; i++){
		                	domTempatur.eq(i).val( tempaturData[domTempatur.eq(i).attr('name')] );
		                }
		                //시간 처리 부분
		                for(var i=0; i<domTime.length; i++){
		                	domTime.eq(i).val( timeData[domTime.eq(i).attr('name')] );
		                }
		                //치수 처리 부분
		                for(var i=0; i<domSize.length; i++){
		                	domSize.eq(i).val( sizeData[domSize.eq(i).attr('name')] );
		                }
		                
		                uiProc(true);
                		$('#btnSave').attr("disabled",true);
                		$('#btnEdit').attr("disabled",false);
                		$('#tempaturBtn').attr("disabled",true);
                		$('#timeBtn').attr("disabled",true);
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
	$('#btnSave').click(function() {
		let checkBlank = false;
		let url = "";
		
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
		
		if (sideView == "create") {
			url = "<c:url value="/em/equipCondCommonSixFloorAdmCreate"/>";
		} else if (sideView == "edit") {
			url = "<c:url value="/em/equipCondCommonSixFloorAdmUpdate"/>";
		} else {
			alert("sideView 알수없는 오류");
		}
		
		//저장 처리 ajax
        $.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'		: menuAuth,
            	'pageGubun'		: "emsc3030",
            	'equipCondSeq'	: function() { return $("#hiddenEquipCondSeq").val(); },
            	'equipCd'		: function() { return $("#addFormEquipCd").text(); },
            	'goodsCd'		: function() { return $("#addFormGoodsCd").text(); },
            	'fpUseYn'		: function() { return ($("#fpUseYn").val() == null || $("#fpUseYn").val() == '') ? ' ' : $("#fpUseYn").val(); },
            	'fpMainGubun'	: function() { return $("#fpMainGubun").is(":checked") ? "001" : "002"; },
            	
            	//온도 
				<c:forEach var="info" items="${tempaturFieldsVo}">
					<c:if test="${info ne 'tempaturCondCd' and info ne 'tempaturCondNm'}">
						"${info}" : $('#tempatur input[name="${info}"]').val(),
					</c:if>
				</c:forEach>
            	
				//시간
	            <c:forEach var="info" items="${timeFieldsVo}">
	            	<c:if test="${info ne 'timeCondCd' and info ne 'timeCondNm'}">
						"${info}" : $('#time input[name="${info}"]').val(),
					</c:if>
				</c:forEach>
				
				//치수
	            <c:forEach var="info" items="${sizeFieldsVo}">
	            	<c:if test="${info ne 'sizeCondCd' and info ne 'sizeCondNm'}">
						"${info}" : $('#size input[name="${info}"]').val(),
					</c:if>
				</c:forEach>
            },
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
           		$('#sizeBtn').attr('disabled', true);
           		$('#btnSave').attr('disabled', true);
           		$('#btnEdit').attr('disabled', true);
           		$('#btnSelectMatrlCode').attr('disabled', true);
            }
        });
	});
	
	
	
	
	
	
	
	
	

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
  	
	

  	//온도 조회 테이블 스크롤 지정
  	$('#tempaturTable thead tr th').attr('style', 'min-width:100px');
  	
  	//온도 조회 팝업 시작
   	let tempaturTable;
   	function tempaturList() {
		if(tempaturTable == null || tempaturTable == undefined)	{
			tempaturTable = $('#tempaturTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        scrollX: true,
		        ajax: {
				    url: "bm/tempaturSixFloorList",
				    type: 'GET',
				    data: {
				    	'menuAuth'	 : menuAuth,
				    },
				},
				rowId: 'tempaturCondCd',
				columns: [
					{ data: 'tempaturCondCd' },
					{ data: 'tempaturCondNm' },
					//조건, Plus, Minus
					<c:forEach var="info" items="${tempaturFieldsVo}" varStatus="loop">
						<c:if test="${info ne 'tempaturCondCd' and info ne 'tempaturCondNm'}">
						    <c:choose>
						        <c:when test="${loop.count % 3 == 0}">
						            <c:set var="infoCond" value="${info}" />
						        </c:when>
						        
						        <c:when test="${loop.count % 3 == 1}">
						            <c:set var="infoPlus" value="${info}" />
						        </c:when>
						        
						        <c:when test="${loop.count % 3 == 2}">
						        	<c:set var="infoMinus" value="${info}" />
						            {
						                render: function(data, type, row) {
						                    return '-' +row['${infoMinus}'] + ' [' + row['${infoCond}'] + '] +' + row['${infoPlus}'];
						                }
						            },
						        </c:when>
						    </c:choose>
						</c:if>
					</c:forEach>
	            	//조건, Plus, Minus
				],
				order: [
					[ 0, 'asc' ],
				],
				columnDefs: [
				       {"className": "text-center", "targets": "_all"}
				],
		    });
			
			//온도 조회 테이블 클릭 시
			$('#tempaturTable tbody').on('click', 'tr', function () {
		    	tempaturCondCd = $(this).closest('tr').attr('id');
		         $.ajax({
		            url: '<c:url value="/bm/tempaturSixFloorRead"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'			: menuAuth,
		                'tempaturCondCd'	: tempaturCondCd,
		                'pageGubun'			: "bmsc3050",
		            },
                    success: function (res) {
                        let data = res.data;
		                let domTempatur = $('#tempatur table tbody tr').find('td input');
		                
		                //조건 처리 부분
		                for(var i=0; i<domTempatur.length; i++){
		                	domTempatur.eq(i).val( data[domTempatur.eq(i).attr('name')] );
		                }
		              	//조건 처리 부분
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
  	
  	
  	//시간 조회 테이블 스크롤 지정
  	$('#timeTable thead tr th').attr('style', 'min-width:100px');
  	
  	//시간 조회 팝업 시작
   	let timeTable;
   	function timeList() {
		if(timeTable == null || timeTable == undefined)	{
			timeTable = $('#timeTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        scrollX: true,
		        ajax: {
				    url: "bm/timeSixFloorList",
				    type: 'GET',
				    data: {
				    	'menuAuth'	 : menuAuth,
				    },
				},
				rowId: 'timeCondCd',
				columns: [
					{ data: 'timeCondCd' },
					{ data: 'timeCondNm' },
					
					//조건, Plus, Minus
					<c:forEach var="info" items="${timeFieldsVo}" varStatus="loop">
						<c:if test="${info ne 'timeCondCd' and info ne 'timeCondNm'}">
						    <c:choose>
						        <c:when test="${loop.count % 3 == 0}">
						            <c:set var="infoCond" value="${info}" />
						        </c:when>
						        
						        <c:when test="${loop.count % 3 == 1}">
						            <c:set var="infoPlus" value="${info}" />
						        </c:when>
						        
						        <c:when test="${loop.count % 3 == 2}">
						        	<c:set var="infoMinus" value="${info}" />
						            {
						                render: function(data, type, row) {
						                    return '-' +row['${infoMinus}'] + ' [' + row['${infoCond}'] + '] +' + row['${infoPlus}'];
						                }
						            },
						        </c:when>
						    </c:choose>
						</c:if>
					</c:forEach>
	            	//조건, Plus, Minus
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
		            url: '<c:url value="/bm/timeSixFloorRead"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'		: menuAuth,
		                'timeCondCd'	: timeCondCd,
		                'pageGubun'		: "bmsc3050",
		            },
                    success: function (res) {
                        let data = res.data;
						let domTime	= $('#time table tbody tr').find('td input');
		                
		                //조건 처리 부분
		                for(var i=0; i<domTime.length; i++){
		                	domTime.eq(i).val( data[domTime.eq(i).attr('name')] );
		                }
		              	//조건 처리 부분

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
  	
  	
  	//치수 조회 테이블 스크롤 지정
  	$('#sizeTable thead tr th').attr('style', 'min-width:100px');
  	
  	//치수 조회 팝업 시작
   	let sizeTable;
   	function sizeList() {
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
				    url: "bm/sizeSixFloorList",
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
		            url: '<c:url value="/bm/sizeSixFloorRead"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'		: menuAuth,
		                'sizeCondCd'	: sizeCondCd,
		                'pageGubun'		: "bmsc3050",
		            },
                    success: function (res) {
                        let data = res.data;
						let domSize	= $('#size table tbody tr').find('td input');
		                
		                //조건 처리 부분
		                for(var i=0; i<domSize.length; i++){
		                	domSize.eq(i).val( data[domSize.eq(i).attr('name')] );
		                }
		              	//조건 처리 부분
     
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
  	
  	//disable_flag
  	function uiProc(flag) {
        // 온도
        $('#tempatur').find('input').attr('disabled', flag);
        
        // 시간
        $('#time').find('input').attr('disabled', flag);
        
     	// 치수
        $('#size').find('input').attr('disabled', flag);
        

        $('#fpUseYn').attr("disabled",flag);
        $('#fpMainGubun').attr("disabled",flag);
   	}

</script>
</body>
</html>
