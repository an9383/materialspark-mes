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
				<li class="breadcrumb-item active">기초제조조건관리(4Line)</li>
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
						<table class="table table-bordered" id="bomListTable">
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
				                <button type="button" class="btn btn-primary float-right mr-1" id="tempaturBtnEdit" onclick="funBtnEditClick('tempatur')"  disabled>수정</button>
								<button type="button" class="btn btn-primary float-right mr-1" id="tempaturBtnAdd" onclick="funBtnAddClick('tempatur')">등록</button>
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
									<td><input type="text" maxlength="10" class="form-control" id="tempaturCondCd"name="tempaturCondCd" style="max-width:100%;" disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*온도 명칭</th><td colspan="4">
									<input type="text" class="form-control" id="tempaturCondNm" name="tempaturCondNm" style="max-width:100%;" maxlength="50"></td>
								</tr>
								<tr>
									<th>구분	</th>
		                            <th>*조건	</th>
		                            <th>*공차(+)</th>
		                            <th>*공차(-)</th>
								</tr>
								<tr>
									<th>상부탭예열</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpTabHeatCond" name="upTabHeatCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpTabHeatPlus" name="upTabHeatPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpTabHeatMinus" name="upTabHeatMinus">
									</td>
								</tr>
								<tr>
									<th>하부탭예열</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownTabHeatCond" name="downTabHeatCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownTabHeatPlus" name="downTabHeatPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownTabHeatMinus" name="downTabHeatMinus">
									</td>
								</tr>
								<tr>
									<th>상부롤히터</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpRollHeatCond" name="upRollHeatCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpRollHeatPlus" name="upRollHeatPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpRollHeatMinus" name="upRollHeatMinus">
									</td>
								</tr>
								<tr>
									<th>하부롤히터</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownRollHeatCond" name="downRollHeatCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownRollHeatPlus" name="downRollHeatPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownRollHeatMinus" name="downRollHeatMinus">
									</td>
								</tr>
								<tr>
									<th>상부필름연결(상)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpFilmJoinTopCond" name="upFilmJoinTopCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpFilmJoinTopPlus" name="upFilmJoinTopPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpFilmJoinTopMinus" name="upFilmJoinTopMinus">
									</td>
								</tr>
								<tr>
									<th>상부필름연결(하)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpFilmJoinBottomCond" name="upFilmJoinBottomCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpFilmJoinBottomPlus" name="upFilmJoinBottomPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturUpFilmJoinBottomMinus" name="upFilmJoinBottomMinus">
									</td>
								</tr>
								<tr>
									<th>하부필름연결(상)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownFilmJoinTopCond" name="downFilmJoinTopCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownFilmJoinTopPlus" name="downFilmJoinTopPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownFilmJoinTopMinus" name="downFilmJoinTopMinus">
									</td>
								</tr>
								<tr>
									<th>하부필름연결(하)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownFilmJoinBottomCond" name="downFilmJoinBottomCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownFilmJoinBottomPlus" name="downFilmJoinBottomPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownFilmJoinBottomMinus" name="downFilmJoinBottomMinus">
									</td>
								</tr>
								<tr>
									<th>하부탭예열유지</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownTabHeatKeepCond" name="downTabHeatKeepCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownTabHeatKeepPlus" name="downTabHeatKeepPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturDownTabHeatKeepMinus" name="downTabHeatKeepMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부1차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTsidCond" name="fup1stMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTsidPlus" name="fup1stMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTsidMinus" name="fup1stMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부1차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTsidCond" name="fdown1stMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTsidPlus" name="fdown1stMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTsidMinus" name="fdown1stMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부1차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTmidCond" name="fup1stMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTmidPlus" name="fup1stMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTmidMinus" name="fup1stMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부1차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTmidCond" name="fdown1stMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTmidPlus" name="fdown1stMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTmidMinus" name="fdown1stMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부1차푸셔</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTpushCond" name="fup1stMTpushCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTpushPlus" name="fup1stMTpushPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup1stMTpushMinus" name="fup1stMTpushMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부1차푸셔</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTpushCond" name="fdown1stMTpushCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTpushPlus" name="fdown1stMTpushPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown1stMTpushMinus" name="fdown1stMTpushMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부1차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stMTsidCond" name="bup1stMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stMTsidPlus" name="bup1stMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stMTsidMinus" name="bup1stMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부1차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stMTsidCond" name="bdown1stMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stMTsidPlus" name="bdown1stMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stMTsidMinus" name="bdown1stMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부1차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stMTmidCond" name="bup1stMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stMTmidPlus" name="bup1stMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stMTmidMinus" name="bup1stMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부1차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stMTmidCond" name="bdown1stMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stMTmidPlus" name="bdown1stMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stMTmidMinus" name="bdown1stMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부1차푸셔</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stPushCond" name="bup1stPushCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stPushPlus" name="bup1stPushPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup1stPushMinus" name="bup1stPushMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부1차푸셔</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stPushCond" name="bdown1stPushCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stPushPlus" name="bdown1stPushPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown1stPushMinus" name="bdown1stPushMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부필름융착</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFupFilmFuseCond" name="fupFilmFuseCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFupFilmFusePlus" name="fupFilmFusePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFupFilmFuseMinus" name="fupFilmFuseMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부필름융착</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdownFilmFuseCond" name="fdownFilmFuseCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdownFilmFusePlus" name="fdownFilmFusePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdownFilmFuseMinus" name="fdownFilmFuseMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부필름융착</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBupFilmFuseCond" name="bupFilmFuseCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBupFilmFusePlus" name="bupFilmFusePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBupFilmFuseMinus" name="bupFilmFuseMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부필름융착</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdownFilmFuseCond" name="bdownFilmFuseCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdownFilmFusePlus" name="bdownFilmFusePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdownFilmFuseMinus" name="bdownFilmFuseMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부2차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup2ndMTsidCond" name="fup2ndMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup2ndMTsidPlus" name="fup2ndMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup2ndMTsidMinus" name="fup2ndMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부2차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown2ndMTsidCond" name="fdown2ndMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown2ndMTsidPlus" name="fdown2ndMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown2ndMTsidMinus" name="fdown2ndMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부2차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup2ndMTmidCond" name="fup2ndMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup2ndMTmidPlus" name="fup2ndMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup2ndMTmidMinus" name="fup2ndMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부2차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown2ndMTmidCond" name="fdown2ndMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown2ndMTmidPlus" name="fdown2ndMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown2ndMTmidMinus" name="fdown2ndMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부2차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup2ndMTsidCond" name="bup2ndMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup2ndMTsidPlus" name="bup2ndMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup2ndMTsidMinus" name="bup2ndMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부2차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown2ndMTsidCond" name="bdown2ndMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown2ndMTsidPlus" name="bdown2ndMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown2ndMTsidMinus" name="bdown2ndMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부2차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup2ndMTmidCond" name="bup2ndMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup2ndMTmidPlus" name="bup2ndMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup2ndMTmidMinus" name="bup2ndMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부2차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown2ndMTmidCond" name="bdown2ndMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown2ndMTmidPlus" name="bdown2ndMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown2ndMTmidMinus" name="bdown2ndMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부3차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup3rdMTsidCond" name="fup3rdMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup3rdMTsidPlus" name="fup3rdMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup3rdMTsidMinus" name="fup3rdMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부3차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown3rdMTsidCond" name="fdown3rdMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown3rdMTsidPlus" name="fdown3rdMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown3rdMTsidMinus" name="fdown3rdMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부3차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup3rdMTmidCond" name="fup3rdMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup3rdMTmidPlus" name="fup3rdMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFup3rdMTmidMinus" name="fup3rdMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부3차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown3rdMTmidCond" name="fdown3rdMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown3rdMTmidPlus" name="fdown3rdMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdown3rdMTmidMinus" name="fdown3rdMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부3차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup3rdMTsidCond" name="bup3rdMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup3rdMTsidPlus" name="bup3rdMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup3rdMTsidMinus" name="bup3rdMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부3차메탈(Sid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown3rdMTsidCond" name="bdown3rdMTsidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown3rdMTsidPlus" name="bdown3rdMTsidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown3rdMTsidMinus" name="bdown3rdMTsidMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부3차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup3rdMTmidCond" name="bup3rdMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup3rdMTmidPlus" name="bup3rdMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBup3rdMTmidMinus" name="bup3rdMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부3차메탈(Mid)</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown3rdMTmidCond" name="bdown3rdMTmidCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown3rdMTmidPlus" name="bdown3rdMTmidPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdown3rdMTmidMinus" name="bdown3rdMTmidMinus">
									</td>
								</tr>
								<tr>
									<th>F-상부필름성형냉각</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFupFilmRfmCoolCond" name="fupFilmRfmCoolCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFupFilmRfmCoolPlus" name="fupFilmRfmCoolPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFupFilmRfmCoolMinus" name="fupFilmRfmCoolMinus">
									</td>
								</tr>
								<tr>
									<th>F-하부필름성형냉각</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdownFilmRfmCoolCond" name="fdownFilmRfmCoolCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdownFilmRfmCoolPlus" name="fdownFilmRfmCoolPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFdownFilmRfmCoolMinus" name="fdownFilmRfmCoolMinus">
									</td>
								</tr>
								<tr>
									<th>B-상부필름성형냉각</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBupFilmRfmCoolCond" name="bupFilmRfmCoolCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBupFilmRfmCoolPlus" name="bupFilmRfmCoolPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBupFilmRfmCoolMinus" name="bupFilmRfmCoolMinus">
									</td>
								</tr>
								<tr>
									<th>B-하부필름성형냉각</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdownFilmRfmCoolCond" name="bdownFilmRfmCoolCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdownFilmRfmCoolPlus" name="bdownFilmRfmCoolPlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturBdownFilmRfmCoolMinus" name="bdownFilmRfmCoolMinus">
									</td>
								</tr>
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
			                <button type="button" class="btn btn-primary float-right mr-1" id="timeBtnEdit" onclick="funBtnEditClick('time')" disabled>수정</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="timeBtnAdd" onclick="funBtnAddClick('time')">등록</button>
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
									<td><input type="text" class="form-control" id="timeCondCd" name="timeCondCd" style="max-width:100%;" disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*시간 명칭</th>
									<td colspan="4"><input type="text" class="form-control" id="timeCondNm" name="timeCondNm" style="max-width:100%;" maxlength="50"></td>
								</tr>
								<tr>
									<th>구분	</th>
		                            <th>*조건	</th>
		                            <th>*공차(+)</th>
		                            <th>*공차(-)</th>
								</tr>
								<tr>
									<th>1차메탈 가열대기시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTwaittimeCond" name="oneStMTwaittimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTwaittimePlus" name="oneStMTwaittimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTwaittimeMinus" name="oneStMTwaittimeMinus">
									</td>
								</tr>
								<tr>
									<th>1차메탈 가열시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTheattimeCond" name="oneStMTheattimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTheattimePlus" name="oneStMTheattimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTheattimeMinus" name="oneStMTheattimeMinus">
									</td>
								</tr>
								<tr>
									<th>1차메탈 푸셔대기시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTpushwaittimeCond" name="oneStMTpushwaittimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTpushwaittimePlus" name="oneStMTpushwaittimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTpushwaittimeMinus" name="oneStMTpushwaittimeMinus">
									</td>
								</tr>
								<tr>
									<th>1차메탈 푸셔시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTpushheattimeCond" name="oneStMTpushheattimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTpushheattimePlus" name="oneStMTpushheattimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturOneStMTpushheattimeMinus" name="oneStMTpushheattimeMinus">
									</td>
								</tr>
								<tr>
									<th>2차메탈 가열대기시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTwaittimeCond" name="twoNdMTwaittimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTwaittimePlus" name="twoNdMTwaittimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTwaittimeMinus" name="twoNdMTwaittimeMinus">
									</td>
								</tr>
								<tr>
									<th>2차메탈 가열시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTheattimeCond" name="twoNdMTheattimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTheattimePlus" name="twoNdMTheattimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTheattimeMinus" name="twoNdMTheattimeMinus">
									</td>
								</tr>
								<tr>
									<th>2차메탈 푸셔대기시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTpushwaittimeCond" name="twoNdMTpushwaittimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTpushwaittimePlus" name="twoNdMTpushwaittimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTpushwaittimeMinus" name="twoNdMTpushwaittimeMinus">
									</td>
								</tr>
								<tr>
									<th>2차메탈 푸셔시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTpushheattimeCond" name="twoNdMTpushheattimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTpushheattimePlus" name="twoNdMTpushheattimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturTwoNdMTpushheattimeMinus" name="twoNdMTpushheattimeMinus">
									</td>
								</tr>
								<tr>
									<th>3차메탈 가열대기시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTwaittimeCond" name="threeRdMTwaittimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTwaittimePlus" name="threeRdMTwaittimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTwaittimeMinus" name="threeRdMTwaittimeMinus">
									</td>
								</tr>
								<tr>
									<th>3차메탈 가열시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTheattimeCond" name="threeRdMTheattimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTheattimePlus" name="threeRdMTheattimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTheattimeMinus" name="threeRdMTheattimeMinus">
									</td>
								</tr>
								<tr>
									<th>3차메탈 푸셔대기시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTpushwaittimeCond" name="threeRdMTpushwaittimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTpushwaittimePlus" name="threeRdMTpushwaittimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTpushwaittimeMinus" name="threeRdMTpushwaittimeMinus">
									</td>
								</tr>
								<tr>
									<th>3차메탈 푸셔시간</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTpushheattimeCond" name="threeRdMTpushheattimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTpushheattimePlus" name="threeRdMTpushheattimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturThreeRdMTpushheattimeMinus" name="threeRdMTpushheattimeMinus">
									</td>
								</tr>
								<tr>
									<th>필름융착서보히터 1동작 대기</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmFSH1operwaittimeCond" name="filmFSH1operwaittimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmFSH1operwaittimePlus" name="filmFSH1operwaittimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmFSH1operwaittimeMinus" name="filmFSH1operwaittimeMinus">
									</td>
								</tr>
								<tr>
									<th>필름융착서보히터 1동작 가열</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmFSH1operheattimeCond" name="filmFSH1operheattimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmFSH1operheattimePlus" name="filmFSH1operheattimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmFSH1operheattimeMinus" name="filmFSH1operheattimeMinus">
									</td>
								</tr>
								<tr>
									<th>필름성형서보히터 1동작 대기</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmRSH1operwaittimeCond" name="filmRSH1operwaittimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmRSH1operwaittimePlus" name="filmRSH1operwaittimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmRSH1operwaittimeMinus" name="filmRSH1operwaittimeMinus">
									</td>
								</tr>
								<tr>
									<th>필름성형서보히터 1동작 가열</th>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmRSH1operheattimeCond" name="filmRSH1operheattimeCond">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmRSH1operheattimePlus" name="filmRSH1operheattimePlus">
									</td>
									<td>
										<input style="max-width:100%;" maxlength="6" min="-1000" max="1000" type="number" step="0.1" class="form-control number-float1" id="tempaturFilmRSH1operheattimeMinus" name="filmRSH1operheattimeMinus">
									</td>
								</tr>
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
			                <button type="button" class="btn btn-primary float-right mr-1" id="sizeBtnEdit" onclick="funBtnEditClick('size')" disabled>수정</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="sizeBtnAdd" onclick="funBtnAddClick('size')">등록</button>
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
									<td><input type="text" maxlength="10" class="form-control" id="sizeCondCd" name="sizeCondCd" style="max-width:100%;"  disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*치수 명칭	</th>
									<td colspan="4"><input type="text" class="form-control" id="sizeCondNm" name="sizeCondNm" style="max-width:100%;" maxlength="50"></td>
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
						<div class="card-body col-sm-12"></div>   
						<div class="card-body col-sm-12"></div>   
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
									<td><input type="text" maxlength="10" class="form-control" id="sizeCondCd2" name="sizeCondCd2" style="max-width:100%;"  disabled></td>
									<td colspan="2"></td>
								</tr>
								<tr>
									<th>*치수 명칭	</th>
									<td colspan="4"><input type="text" class="form-control" id="sizeCondNm2" name="sizeCondNm2" style="max-width:100%;" maxlength="50" disabled></td>
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

	let menuAuth = 'bmsc3050';
	let currentHref = 'bmsc3050';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "기초제조조건관리(4Line)");
	
	let factoryCode	= "<%=factoryCode%>";
    let sideView	= 'add';
    let baseCd		= "";
    let baseNm		= null;
    let rowIdx		= "";
    let condCd		= "";
    let condNm		= "";
    let url			= "";

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
    
    let bomListTable = $('#bomListTable').DataTable({
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
    
	let html1 = '<select id="bom" ></select>';
	$('#bomListTable_length').html(html1);
    
	//bom select box 변경감지
	$('#bom').change(function(){
		
		baseCd = $("#bom option:selected").val();
		
		$('.form-control').val("");
		
		if (baseCd == "001"){
			//온도
			url = "bm/tempaturSixFloorList"
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
		} else if(baseCd == "002") {
			//시간
			url = "bm/timeSixFloorList"
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
		} else if(baseCd == "003") {
			//압력 -> 치수
			url = "bm/sizeSixFloorList"
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
		} else {
			toastr.warning("다시 선택해 주세요.");
			$('#bom').focus();
			return false;
		}
		
		
		// 목록
		$.fn.dataTable.ext.errMode = 'none';
		bomListTable = $('#bomListTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
			    'copy', 'excel', 'print'
			],
	    });
	});
	
	//BomList 조회 시
    $('#bomListTable tbody').on('click', 'tr', function () {

        if( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#bomListTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            
			sideView = 'view';
			let val = new Array();
	        for(i=0; i < 2; i++){
	        	val[i] = $(this).closest('tr').find('td:eq(' + i + ')').text();
	        }
	        
	        //온도 Read
			if(baseCd == "001") {
				$('#tempaturBtnSave').addClass('d-none');  // 저장버튼
		        $.ajax({
		        	url: '<c:url value="bm/tempaturSixFloorRead"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'			: menuAuth,
						'tempaturCondCd'	: val[1],
						'pageGubun'			: "bmsc3050",
		            },
		            success: function (res) {
		                let data = res.data;
		                let domTempatur = $('#tempaturFormBox table tbody tr').find('td input');
		                
		                //조건 처리 부분
		                for(var i=0; i<domTempatur.length; i++){
		                	domTempatur.eq(i).val( data[domTempatur.eq(i).attr('name')] );
		                }
		              	//조건 처리 부분
		              	
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
			} else if(baseCd == "002") {
				//시간 Read
				$('#timeBtnSave').addClass('d-none');  // 저장버튼
		        $.ajax({
		        	url: '<c:url value="bm/timeSixFloorRead"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'		: menuAuth,
						'timeCondCd'	: val[1],
						'pageGubun'		: "bmsc3050",
		            },
		            success: function (res) {
		                let data		= res.data;
						let domTime	= $('#timeFormBox table tbody tr').find('td input');
		                
		                //조건 처리 부분
		                for(var i=0; i<domTime.length; i++){
		                	domTime.eq(i).val( data[domTime.eq(i).attr('name')] );
		                }
		              	//조건 처리 부분
												
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
			} else if(baseCd == "003") {
				//치수 read
				$('#sizeBtnSave').addClass('d-none');  // 저장버튼
		        $.ajax({
		        	url: '<c:url value="bm/sizeSixFloorRead"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'		: menuAuth,
						'sizeCondCd'	: val[1],
						'pageGubun'		: "bmsc3050",
		            },
		            success: function (res) {
		                let data = res.data;
						let domSize		= $('#sizeFormBox table tbody tr').find('td input');
						let domSize2	= $('#sizeFormBox2 table tbody tr').find('td input');
		                
		                //조건 처리 부분
		                for(var i=0; i<domSize.length; i++){
		                	domSize.eq(i).val( data[domSize.eq(i).attr('name')] );
		                }
		                for(var i=0; i<domSize2.length; i++){
		                	domSize2.eq(i).val( data[domSize2.eq(i).attr('name')] );
		                }
		              	//조건 처리 부분
		              	
						$('#sizeCondCd2').val(data["sizeCondCd"]);
						$('#sizeCondNm2').val(data["sizeCondNm"]);

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
			} else {
				toastr.warning('온도, 시간, 압력, 치수 중 하나를 선택하세요.');
				$('#bom').focus();
			}
		}
    });
	
 	// 온도 저장 클릭 시 
    $('#tempaturBtnSave').on('click', function() {
        if ( !$.trim($('#tempaturCondNm').val()) ) {
            toastr.warning('온도 명칭을 입력해주세요.');
            $('#tempaturCondNm').focus();
            return false;
        }
        if ( $("#tempaturUseYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해 주세요.');
            $("#tempaturUseYnCd").focus();
            return false;
        }
		
        //경로 지정
		if( sideView == "edit" ) {
			url = '<c:url value="bm/tempaturSixFloorUpdate"/>';
		} else {
			url = '<c:url value="bm/tempaturSixFloorCreate"/>';
		}
		
        //저장 처리 ajax
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'	: menuAuth,
            	'useYnCd'	: $('#tempaturForm select[name=useYnCd]').val(),
            	'pageGubun'	: "bmsc3050",
            	//조건, Plus, Minus
				<c:forEach var="info" items="${tempaturFieldsVo}">
					"${info}" : $('#tempaturForm input[name="${info}"]').val(),
				</c:forEach>
            	//조건, Plus, Minus
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
    				$('#tempaturCondCd').val(data.tempaturCondCd);
    				$('#tempaturCondNm').val(data.tempaturCondNm);
    				
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#bomListTable').DataTable().ajax.reload();
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
        if ( !$.trim($('#timeCondNm').val()) ) {
            toastr.warning('시간 명칭을 입력해주세요.');
            $('#timeCondNm').focus();
            return false;
        }
        if ( $("#timeUseYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해 주세요.');
            $("#timeUseYnCd").focus();
            return false;
		}
        
		//경로 지정
		if( sideView == "edit" ) {
			url = '<c:url value="bm/timeSixFloorUpdate"/>';
		} else {
			url = '<c:url value="bm/timeSixFloorCreate"/>';
		}
		
		//저장 ajax
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'	:	menuAuth,
            	'useYnCd'	:	$('#timeForm select[name=useYnCd]').val(),
            	'pageGubun'	:	"bmsc3050",
            	//조건, Plus, Minus
				<c:forEach var="info" items="${timeFieldsVo}">
					"${info}" : $('#timeFormBox input[name="${info}"]').val(),
				</c:forEach>
            	//조건, Plus, Minus
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
    				$('#timeCondCd').val(data.timeCondCd);
    				$('#timeCondNm').val(data.timeCondNm);
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#bomListTable').DataTable().ajax.reload();
				$('#timeFormBox').removeClass('d-none');
		        $('#timeBtnEdit').attr('disabled', false);
				$('#timeBtnSave').attr('disabled', true);
				$('#timeBtnSave').addClass('d-none');
		        timeForm(true);
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
        if ( $("#sizeUseYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해 주세요.');
            $("#sizeUseYnCd").focus();
            return false;
        }
        
		if( sideView == "edit" ) {
			url = '<c:url value="bm/sizeSixFloorUpdate"/>';
		} else {
			url = '<c:url value="bm/sizeSixFloorCeate"/>';
		}

		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'	:	menuAuth,
            	'useYnCd'	:	$('#sizeForm select[name=useYnCd]').val(),
            	'pageGubun'	:	"bmsc3050",
            	//조건, Plus, Minus
            	//"${info}" : $('#sizeFormBox input[name="${info}"]').val(),
				<c:forEach var="info" items="${sizeFieldsVo}">
					"${info}" : $('[id*="sizeFormBox"] input[name="${info}"]').val(),
				</c:forEach>
            	//조건, Plus, Minus
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
					$('#sizeCondCd').val(data.sizeCondCd);
					$('#sizeCondNm').val(data.sizeCondNm);
					$('#sizeCondCd2').val(data.sizeCondCd);
					$('#sizeCondNm2').val(data.sizeCondNm);
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#bomListTable').DataTable().ajax.reload();
				$('#sizeFormBox').removeClass('d-none');
				$('#sizeFormBox2').removeClass('d-none');				
		        $('#sizeBtnEdit').attr('disabled', false);
		        $('#sizeBtnSave').attr('disabled', true);		        
		        $('#sizeBtnSave').addClass('d-none');
		        sizeForm(true);
		        $('#sizeCondCd2').attr('disabled',true);
			    $('#sizeCondNm2').attr('disabled',true);
			}
		});
	});
	
	
	
	
	
	//등록 버튼 클릭 시
    function funBtnAddClick(name) {
    	sideView = 'add';
        $('.form-control').val("");
        
        //선택박스처리
        selectBoxAppend(useYnCd, ""+name+"UseYnCd", "001", "2");
		$('#'+name+'FormBox').removeClass('d-none');
        $('#'+name+'BtnEdit').attr('disabled', true);
        $('#'+name+'BtnSave').removeClass('d-none');
        $('#'+name+'BtnSave').attr('disabled', false);
        
        if( baseCd == "001" ) {
        	tempaturForm(false);
        } else if( baseCd == "002" ) {
        	timeForm(false);
        } else if( baseCd == "003" ) {
        	sizeForm(false);
        } else {
        	toastr.warning("다시 선택해 주세요.");
        }
        
		$('.number-float1, .number-float2, .number-float3').val("0");
    }
    
  	//수정 버튼 클릭 시
    function funBtnEditClick(name) {
    	sideView = 'edit';	//클릭 시 edit 줘서 클릭 했는지 안했는지 판단
    	if(sideView != 'edit') {
		toastr.warning("수정할 온도를 선택해 주세요!");
			return false;
		}
    	
		$('#'+name+'FormBox').removeClass('d-none');
        $('#'+name+'BtnSave').removeClass('d-none');
        $('#'+name+'BtnSave').attr('disabled', false);
        
        if( baseCd == "001" ) {
        	tempaturForm(false);
        } else if( baseCd == "002" ) {
        	timeForm(false);
        } else if( baseCd == "003" ) {
        	sizeForm(false);
        	$('#sizeFormBox2').removeClass('d-none');
        } else {
        	toastr.warning("다시 선택해 주세요.");
        }
		
        $('.number-float1, .number-float2, .number-float3').each(function(index, value) {
			if ( $(this).val() == "" ){
				$(this).val("0");
			}
		});
    }

	//온도 View 컨트롤
   	function tempaturForm(flag) {
   		$('#tempaturFormBox table tbody tr').find('td input').attr('disabled', flag);
   		$("#tempaturUseYnCd").attr("disabled",flag);
   		$('#tempaturCondCd').attr('disabled', true);
   	}

	//시간 View 컨트롤
   	function timeForm(flag) {
   		$('#timeForm table tbody tr').find('td input').attr('disabled', flag);
   		$("#timeUseYnCd").attr("disabled",flag);
   		$('#timeCondCd').attr('disabled', true);
   	}

	//치수 View 컨트롤
	function sizeForm(flag) {
		$('#sizeForm table tbody tr').find('td input').attr('disabled', flag);
		$("#sizeUseYnCd").attr("disabled",flag);
		
		//맨 오른쪽 테이블
		$('#sizeForm2 table tbody tr').find('td input').attr('disabled', flag);
		
		$('#sizeCondCd').attr('disabled', true);
		$('#sizeCondCd2').attr('disabled', true);
	    $('#sizeCondNm2').attr('disabled',true);
	}
	
</script>

</body>
</html>