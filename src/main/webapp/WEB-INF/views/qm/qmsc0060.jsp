<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% String userNm = session.getAttribute("userNm").toString(); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">외관검사</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main" style="padding-bottom:0px;">
		<div class="row table-wrap-hid" id="mainCard">
			<div class="left-list left-sidebar" id="left-list" style="width: 50%; padding-bottom:0px;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="goodsFaultyAdmTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 50px">검사일</th>
									<th style="min-width: 140px">규격</th>
									<th style="min-width: 100px">생산전표번호</th>
									<th style="min-width: 90px" class="text-center">검사량(엣지양품)</th>
									<th style="min-width: 70px" class="text-center">외관양품수량</th>
									<!-- <th style="min-width: 40px">해외1</th>
	                              <th style="min-width: 40px">해외2</th>
	                              <th style="min-width: 40px">국내</th> -->
									<th style="min-width: 50px" class="text-center">불량 수량</th>
									<th style="min-width: 50px" class="text-center">불량률(%)</th>
									<th style="min-width: 40px">검사자</th>
								</tr>
							</thead>
							<tfoot>
								<!-- <tr class="thead-light"> -->
								<tr>
									<th colspan="3" style="text-align: center">합계</th>
									<td id="edgeOutputCount" style="text-align: right">0</td>
									<td id="appearOutputConut" style="text-align: right">0</td>
									<td id="appearFaultyCount" style="text-align: right">0</td>
									<td id="faultyPercentCount" style="text-align: right">0%</td>
									<th></th>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
                  <!--======================== .right-sidebar 등록,수정 ========================-->
                  <div class="right-list right-sidebar" id="myrSidenav" style="width:49%; padding-top:0px; padding-bottom:0px;">
                  	<div class="card-body col-sm-12" style="padding-bottom:8px;">
                 			<div class="rightsidebar-close">
						<a href="javascript:void(0)" id="rightCardClose" class="closebtn float-right"><i class="mdi mdi-close"></i></a>
					</div>
					<!-- 
					<button type="button" class="btn btn-primary float-left touch6" id="openFullScreen" style="margin-right:5px;">전체화면</button>
					<button type="button" class="btn btn-primary float-left touch6" id="closeFullScreen" style="margin-right:5px;">전체화면 해제</button>
					-->
					<button type="button" class="btn btn-primary float-left touch6" id="btnSizeCondStep" disabled>종물 등록 & 수정</button>
					<button type="button" class="btn btn-primary float-right touch6" id="btnEdit" style="margin-right:5px;"disabled>수정</button>
					<button type="button" class="btn btn-primary float-right touch6" id="btnAdd" style="margin-right:5px;">등록</button>
				</div>
				<div class="card" id="formBox" style="margin-bottom: 5px;">
                      <div class="row mb-2">
                      	<!-- 작지 스캔 테이블 -->
                       <div class="col-4" style="padding-left: 0px;">
						<table class="table table-bordered" id="workOrdScanTable" style="margin-bottom:8px;">
							<colgroup>
								<col width="50%">
								<col width="50%">
							</colgroup>
							<tr>
								<th>외관 검사일</th>
	                            <td><input type="date" class="form-control" id="appearInspctDate" 	name="appearInspctDate" disabled></td>
							</tr>
							<tr>
								<th>생산전표번호</th>
								<td><input type="text" class="form-control" id="ordLotNo" 	name="ordLotNo" disabled></td>
							</tr>
							<tr>
								<th>작지 번호</th>
								<td><input type="text" class="form-control" id="workOrdNo"	name="workOrdNo" style="max-width:100%" disabled></td>								
							</tr>
							<tr>
	                            <th>재질 </th>
								<td><input type="text" class="form-control" id="qutyNm" 	name="qutyNm" disabled></td>
							</tr>
							<tr>
								<th>제품(기종)	</th>
								<td><input type="text" class="form-control" id="goodsNm" 	name="goodsNm" disabled></td>
							</tr>
							<tr>
								<th>검사담당</th>
								<td>
									<div class="input-sub m-0">
										<input type="hidden" id="packYn" name="packYn">
										<input type="hidden" id="userNumber"	name="edgeInspctCharger">
										<input type="text" class="form-control touch6" id="userNm"		name="userNm" disabled>
										<button type="button" class="btn btn-primary input-sub-search-md" id="searchUser" onClick="selectPreWorkCharger()" disabled>
											<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
										</button>
									</div>
								</td>
							</tr>
							<tr>
								<th>엣지양품수량</th>
								<td><input type="text" maxlength="6" min="0" max="100000" class="form-control num_only text-right touch6" id="edgeOutputCnt" 	name="edgeOutputCnt" disabled></td>
							</tr>
							<tr>
								<th>총 외관 불량 개수</th>
								<td><input type="text" class="form-control text-right touch6" style="color:red;" id="appearFaultyCnt" name="appearFaultyCnt" disabled></td>
							<tr>
								<th>메탈부불량</th>
								<td id="metalBadTotal" style="text-align: right">0</td>
<!-- 								<th style="vertical-align: middle;">비고</th> -->
<!-- 								<td><textarea class="form-control text-right" style="min-height:151px; resize: none;" id="" name="" disabled></textarea></td> -->
							</tr>
							<tr>
								<th>필름부불량</th>
								<td id="filmBadTotal" style="text-align: right">0</td>
<!-- 								<th style="vertical-align: middle;">비고</th> -->
<!-- 								<td><textarea class="form-control text-right" style="min-height:151px; resize: none;" id="" name="" disabled></textarea></td> -->
							</tr>
							<tr>
								<th>(비)메탈부불량</th>
								<td id="visionMetalBadTotal" style="text-align: right">0</td>
<!-- 								<th style="vertical-align: middle;">비고</th> -->
<!-- 								<td><textarea class="form-control text-right" style="min-height:151px; resize: none;" id="" name="" disabled></textarea></td> -->
							</tr>
							<tr>
								<th>(비)필름부불량</th>
								<td id="visionFilmBadTotal" style="text-align: right">0</td>
<!-- 								<th style="vertical-align: middle;">비고</th> -->
<!-- 								<td><textarea class="form-control text-right" style="min-height:151px; resize: none;" id="" name="" disabled></textarea></td> -->
							</tr>
							<tr>
								<th>작지 상태</th>
								<td><select class="custom-select" id="subWorkStatusCd" disabled></select></td>
							</tr>
<!-- 							<tr> -->
<!-- 								<th style="vertical-align: middle;">비고</th> -->
<!-- 								<td><textarea class="form-control text-right" style="min-height:151px; resize: none;" id="" name="" disabled></textarea></td> -->
<!-- 							</tr> -->
						</table>
					</div>
					<!--외관 불량 테이블 -->
					<div class="pl-1 col-8" style="padding-right: 0px;">
						<div class="card-header card-tab">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item"><a class="nav-link active" data-toggle="tab" id="tab1">...</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">...</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">...</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">...</a></li>
								<!-- <li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">기타불량</a></li> -->
							</ul>
						</div>
						<br>
						<div id="metalFaultyDiv">
							<table class="table table-bordered exam">
								<colgroup>
									
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
								</colgroup>
								<tbody id="metalFaultyTbody">
									<!-- 
									<tr>	
			                            <th>MMB</th>
			                            <th>MMS</th>
			                            <th>PMS</th>
			                            <th>M찍힘</th>
			                            <th>P찍힘</th>
			                            <th>M이물</th>
			                            <th>M꺽임</th>
			                            <th>M오염</th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalMmb" name="metalMmb" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalMms" name="metalMms" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalPms" name="metalPms" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalFstab" name="metalFstab" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalPstab" name="metalPstab" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalAliensbst" name="metalAliensbst" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalBreak" name="metalBreak" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalPolutn" name="metalPolutn" disabled></td>
									</tr>
									<tr>
										<th>M갈변</th>
										<th>P오염</th>
										<th>도금박리</th>
										<th>총두께</th>
										<th>기타</th>
										<th></th>
										<th></th>
										<th></th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalBrowning" name="metalBrowning" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalPpolutn" name="metalPpolutn" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalGilt" name="metalGilt" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalThickness" name="metalThickness" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metalEtc" name="metalEtc" disabled></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									 -->
								</tbody>
							
							</table>
						</div>
						
						<div id="filmFaultyDiv" class="d-none">
							<table class="table table-bordered exam">
								<colgroup>
									
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
								</colgroup>
								<tbody id="filmFaultyTbody">
									<!-- 
									<tr>
										<th>PFS</th>
			                            <th>F꺽임</th>
			                            <th>뜯김</th>
			                            <th>표면기포</th>
			                            <th>엣지기포</th>
			                            <th>테프론</th>
			                            <th>P이물</th>
			                            <th>P오염</th>
			                           
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmPfs" name="filmPfs" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmBreak" name="filmBreak" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmTornout" name="filmTornout" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmSurfceBb" name="filmSurfceBb" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmEdgeBb" name="filmEdgeBb" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmTeflon" name="filmTeflon" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmAliensbst" name="filmAliensbst" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmPolutn" name="filmPolutn" disabled></td>
									</tr>
									<tr>
										<th>F뭉침</th>
										<th>필름겹침</th>
										<th>미진접</th>
										<th>미부착</th>
										<th>MF</th>
										<th>날개처짐</th>
										<th>기타</th>
										<th></th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmAgglomt" name="filmAgglomt" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmOverlap" name="filmOverlap" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmUnjinjeop" name="filmUnjinjeop" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmUnattch" name="filmUnattch" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmMf" name="filmMf" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmWing" name="filmWing" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="filmEtc" name="filmEtc" disabled></td>
										<td></td>
									</tr>
									 -->
								</tbody>
							</table>
						</div>
						
						<div id="etcVisionMetalFaultyDiv"  class="d-none">
							<table class="table table-bordered exam">
								<colgroup>
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
								</colgroup>
								<tbody id="etcVisionMetalFaultyTbody">
									<!-- 
									<tr>							
			                            <th>치수</th>
			                            <th>컷팅</th>
			                            <th>필름눌림</th>
			                            <th>필름폭</th>
			                            <th>레이어</th>
			                            <th>빨래판</th>
			                            <th>백테이프</th>
			                            <th>결무늬</th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcSize" name="etcSize" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcCutting" name="etcCutting" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcFilmPress" name="etcFilmPress" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcFilmDepth" name="etcFilmDepth" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcLayer" name="etcLayer" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcWashboard" name="etcWashboard" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcWhitetape" name="etcWhitetape" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcPattem" name="etcPattem" disabled></td>
									</tr>
									<tr>
			                            
			                            <th>F찍힘</th>
			                            <th>아지랑이</th>
			                            <th>표면처리</th>
			                            <th>돌기</th>
			                            <th>피딩</th>
			                            <th>필름농</th>
			                            <th>F사선</th>
			                            <th>진접터짐</th>
									</tr>
									<tr>
										
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcStabbed" name="etcStabbed" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcHaze" name="etcHaze" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcSurface" name="etcSurface" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcSwelling" name="etcSwelling" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcFeeding" name="etcFeeding" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcFilm" name="etcFilm" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcSlash" name="etcSlash" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcJinjeop" name="etcJinjeop" disabled></td>
									</tr>
									<tr>
										<th>들뜸</th>
										<th>P.P주름</th>
										<th>기타</th>
										<th></th>
										<th></th>
										<th></th>
										<th></th>
										<th></th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcCrack" name="etcCrack" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcCrease" name="etcCrease" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcEtc" name="etcEtc" disabled></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									 -->
								</tbody>
							</table>
						</div>
						
						<div id="etcVisionFilmFaultyDiv"  class="d-none">
							<table class="table table-bordered exam">
								<colgroup>
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
								</colgroup>
								<tbody id="etcVisionFilmFaultyTbody">
									<!-- 
									<tr>							
			                            <th>치수</th>
			                            <th>컷팅</th>
			                            <th>필름눌림</th>
			                            <th>필름폭</th>
			                            <th>레이어</th>
			                            <th>빨래판</th>
			                            <th>백테이프</th>
			                            <th>결무늬</th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcSize" name="etcSize" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcCutting" name="etcCutting" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcFilmPress" name="etcFilmPress" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcFilmDepth" name="etcFilmDepth" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcLayer" name="etcLayer" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcWashboard" name="etcWashboard" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcWhitetape" name="etcWhitetape" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcPattem" name="etcPattem" disabled></td>
									</tr>
									<tr>
			                            
			                            <th>F찍힘</th>
			                            <th>아지랑이</th>
			                            <th>표면처리</th>
			                            <th>돌기</th>
			                            <th>피딩</th>
			                            <th>필름농</th>
			                            <th>F사선</th>
			                            <th>진접터짐</th>
									</tr>
									<tr>
										
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcStabbed" name="etcStabbed" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcHaze" name="etcHaze" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcSurface" name="etcSurface" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcSwelling" name="etcSwelling" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcFeeding" name="etcFeeding" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcFilm" name="etcFilm" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcSlash" name="etcSlash" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcJinjeop" name="etcJinjeop" disabled></td>
									</tr>
									<tr>
										<th>들뜸</th>
										<th>P.P주름</th>
										<th>기타</th>
										<th></th>
										<th></th>
										<th></th>
										<th></th>
										<th></th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcCrack" name="etcCrack" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcCrease" name="etcCrease" disabled></td>
										<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etcEtc" name="etcEtc" disabled></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									 -->
								</tbody>
							</table>
						</div>
						
					</div>
				</div>
				<button type="button" class="btn btn-primary float-right touch6" id="btnSave" disabled>저장</button>
				<br>
				<br>
				<div class="col-12 num_keypad">
					<table class="table table-bordered" >                                
						<tr>
							<td id="number5" style="height:1px; width:100px;">5</td>
							<td id="number6" style="height:1px; width:100px;">6</td>
							<td id="number7" style="height:1px; width:100px;">7</td>
							<td id="number8" style="height:1px; width:100px;">8</td>
							<td id="number9" style="height:1px; width:100px;">9</td>
							<td id="backSpace" style="height:1px; width:100px;">←<br>(BS)</td>
						</tr>
						<tr>
							<td id="number0" style="height:59px; width:100px;">0</td>
							<td id="number1" style="height:59px; width:100px;">1</td>
							<td id="number2" style="height:59px; width:100px;">2</td>
							<td id="number3" style="height:59px; width:100px;">3</td>
							<td id="number4" style="height:59px; width:100px;">4</td>
							<td id="enter" style="height:59px; width:100px;">ENT</td>
						</tr>
					</table>
				</div>
			</div>
		</div><!-- .right-sidebar -->
	</div><!-- /.row -->
</div><!-- / #main  -->
</div><!-- /.page-wrapper -->
        
<!-- 담당자조회 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="userPopUpModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width: 1300px">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
				<h5 class="modal-title" id="userPopUpLabel">검사 담당</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" style="overflow: auto;">
				<hr class="text-secondary">
				<table id="userPopUpTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th style="min-width: 50px">담당자</th>
							<th style="min-width: 50px">부서명</th>
							<th style="min-width: 50px">직위</th>
							<th style="min-width: 50px">담당업무</th>
							<th style="min-width: 50px">근무조</th>
							<th style="min-width: 50px">사업장</th>
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
<!-- 담당자조회 모달 종료-->
<!-- 초,중,종물 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="sizeCondStepPopUpModal" tabindex="-1" role="dialog" aria-labelledby="sizeCondStepPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg float-right" style="min-width:1800px; margin-right: 10px;">
		<div class="modal-content">
			<div class="row">
				<div class="modal-header col-6" style="padding-bottom: 0px;">
					<!-- 너비맞춤 -->
				</div>
				<div class="modal-header col-6" style="padding-bottom: 0px;">
					<div class="float-right row col-8">
						<h5 class="modal-title" id="sizeCondStepPopUpLabel1"></h5>
						<!-- <h5 class="modal-title" id="sizeCondStepPopUpLabel2">&nbsp;종물 등록 & 수정</h5> -->
					</div>
					<div class="float-right col-3">
						<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnSizeCondStepSave" disabled>저장</button>
						<button type="button" class="btn btn-primary float-right touch6" id="btnSizeCondStepEdit" style="margin-right: 7px;" disabled>수정</button>
					</div>
					<button type="button" class="close m-0 p-1" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>
			<div class="modal-body">
			<!-- <hr class="text-secondary"> -->
				<!-- 상세정보 -->
				<div id="viewBox" class="row">
					<div class="col-6">
						<table class="table table-bordered" id="bulgeCondStepTable">
							<tr>
								<th rowspan="2" class="touch6">돌기크기 좌상</th>
								<th class="touch6">높이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftupHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">넓이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftupWidth" disabled></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">돌기크기 좌하</th>
								<th class="touch6">높이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftdownHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">넓이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftdownWidth" disabled></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">돌기크기 우상</th>
								<th class="touch6">높이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightupHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">넓이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightupWidth" disabled></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">돌기크기 우하</th>
								<th class="touch6">높이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightdownHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">넓이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightdownWidth" disabled></td>
							</tr>
							<!-- 
							<tr>
								<th rowspan="4" class="touch6">돌기크기<br>(높이)</th>
								<th class="touch6">좌상</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftupHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">좌하</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftdownHeight"disabled></td>
							</tr>
							<tr>
								<th class="touch6">우상</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightupHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">우하</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightdownHeight" disabled></td>
							</tr>
							<tr>
								<th rowspan="4" class="touch6">돌기크기<br>(넓이)</th>
								<th class="touch6">좌상</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftupWidth" disabled></td>
							</tr>
							<tr>
								<th class="touch6">좌하</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftdownWidth"disabled></td>
							</tr>
							<tr>
								<th class="touch6">우상</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightupWidth" disabled></td>
							</tr>
							<tr>
								<th class="touch6">우하</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightdownWidth" disabled></td>
							</tr>
							 -->
						</table>
						<br>
						<br>
						<br>
						<div class="row">
							<div class="col-6">
								<!-- 종물 키패드 오른쪽 정렬용 -->
							</div>
							<div class="col-6 num_keypad">
								<table class="table table-bordered">
									<tr>
										<td id="stepNumber7" style="height:80px; width:100px;">7</td>
										<td id="stepNumber8" style="height:80px; width:100px;">8</td>
										<td id="stepNumber9" style="height:80px; width:100px;">9</td>
										<td rowspan="2" id="stepBackSpace" style="height:80px; width:100px;">←<br>(BS)</td>
									</tr>
									<tr>
										<td id="stepNumber4" style="height:80px; width:100px;">4</td>
										<td id="stepNumber5" style="height:80px; width:100px;">5</td>
										<td id="stepNumber6" style="height:80px; width:100px;">6</td>
									</tr>
									<tr>
										<td id="stepNumber1" style="height:80px; width:100px;">1</td>
										<td id="stepNumber2" style="height:80px; width:100px;">2</td>
										<td id="stepNumber3" style="height:80px; width:100px;">3</td>
										<td rowspan="2" id="stepEnter" style="height:80px; width:100px;">ENT</td>
									</tr>
									<tr>
										<td colspan="2" id="stepNumber0" style="height:80px; width:100px;">0</td>
										<td id="stepDot" style="height:80px; width:100px;">.</td>
									<tr>
								</table>
							</div>
						</div>
					</div>
					
					<div class="col-6">
						<table class="table table-bordered" id="sizeCondStepTable" style="margin-bottom:0px;">
							<colgroup><col width="15%"></colgroup>
							<colgroup><col width="10%"></colgroup>
							<colgroup><col width="20%"></colgroup>
							<colgroup><col width="13%"></colgroup>
							<colgroup><col width="13%"></colgroup>
							<colgroup><col width="20%"></colgroup>
							<tr>
								<th rowspan="3" class="touch6">위치</th>
		                        <th rowspan="3" class="touch6">시료</th>
		                        <th rowspan="3" class="touch6">조건</th>
		                        <th colspan="3" class="touch6">측정시간</th>
							</tr>
							<tr>
								<th class="touch6">초물</th>
		                        <th class="touch6">중물</th>
		                        <th class="touch6">종물</th>
							</tr>
							<tr>
								<td><input type="time" maxlength="5" class="form-control text-center touch6 firstStep" id="firstRegTime" placeholder="HH:MM"></td>
		                        <td><input type="time" maxlength="5" class="form-control text-center touch6 secondStep" id="secondRegTime" placeholder="HH:MM"></td>
		                        <td><input type="time" maxlength="5" class="form-control text-center touch6 thridStep" id="thirdRegTime" placeholder="HH:MM" disabled></td>
							</tr>
							<tr>
								<!-- <input type="hidden" id="workOrdNo"> -->
								<input type="hidden" id="equipCondSeq">
								<input type="hidden" id="firstStepSearch">
								<input type="hidden" id="secondStepSearch">
								<input type="hidden" id="thirdStepSearch">
								<th rowspan="2" class="touch6">Welding Part</th>
								<th class="touch6">(좌)</th>
								<th><span class="cond touch6" id="wpLeftCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstWpLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondWpLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdWpLeftAlwnce" min="0" disabled></td>
							</tr>
							<tr>
								<th class="touch6">(우)</th>
								<th class="touch6"><span id="wpRightCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstWpRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondWpRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdWpRightAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">Pitch</th>
								<th class="touch6">(좌)</th>
								<th><span class="cond touch6" id="pitchLeftCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPitchLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPitchLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPitchLeftAlwnce" min="0" ></td>
							</tr>                                                                                       
							<tr>
								<th class="touch6">(우)</th>
								<th class="touch6"><span class="cond touch6" id="pitchRightCond"></span></th>                                                                         
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPitchRightAlwnce" min="0"  ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPitchRightAlwnce" min="0"  ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPitchRightAlwnce" min="0"  ></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">P.P Film 날개</th>
								<th class="touch6">(좌)</th>
								<th><span class="cond touch6" id="ppfWingLeftCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPpfWingLeftAlwnce" min="0"  ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPpfWingLeftAlwnce" min="0"  ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPpfWingLeftAlwnce" min="0"  ></td>
							</tr>
							<tr>
								<th class="touch6">(우)</th>
								<th><span class="cond touch6" id="ppfWingRightCond"></span></th>                                                                         
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPpfWingRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPpfWingRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPpfWingRightAlwnce" min="0" ></td>
							</tr>
							<tr>                                
								<th rowspan="2" class="touch6">P.P Film 폭</th>
								<th class="touch6">(좌)</th>
								<th><span class="cond touch6" id="ppfDepthLeftCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPpfDepthLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPpfDepthLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPpfDepthLeftAlwnce" min="0" ></td>
							</tr>
							<tr>                                                                                        
								<th class="touch6">(우)</th>
								<th><span class="cond touch6" id="ppfDepthRightCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPpfDepthRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPpfDepthRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPpfDepthRightAlwnce" min="0" ></td>
							</tr>
							<tr>                                
								<th class="touch6">Film</th>
								<th class="touch6">총길이</th>
								<th><span class="cond touch6" id="filmCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstFilmAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondFilmAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdFilmAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">METAL</th>
								<th class="touch6">폭</th>
								<th><span class="cond touch6" id="metalDepthCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstMetalDepthAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondMetalDepthAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdMetalDepthAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th class="touch6">두께</th>
								<th><span class="cond touch6" id="metalThicknessCond"></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstMetalThicknessAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondMetalThicknessAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdMetalThicknessAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="3" class="touch6">총두께</th>
								<th class="touch6">Center</th>
								<th><span class="cond touch6" id="thCenterCond"></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstThCenterAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondThCenterAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdThCenterAlwnce" min="0" ></td>
							</tr>                                                                                       
							<tr>
								<th class="touch6">Edge</th>
								<th><span class="cond touch6" id="thEdgeCond"></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstThEdgeAlwncePlus" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondThEdgeAlwncePlus" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdThEdgeAlwncePlus" min="0" ></td>
							</tr>
							<tr>
								<th colspan="2"class="touch6">초물 중물 종물</th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstInput" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondInput" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdInput" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">Burr (MAX)</th>
								<th class="touch6">Metal</th>
								<th><span class="cond touch6" id="burrCond"></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstBurrMetalAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondBurrMetalAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdBurrMetalAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th class="touch6">R-Cut</th>
								<th><span class="cond touch6" id=""></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstBurrRcutAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondBurrRcutAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdBurrRcutAlwnce" min="0"></td>
							</tr>
							<!-- <tr>
								<th class="touch6">R끝단</th>
								<th><span class="cond touch6" id=""></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstBurrRedgeAlwnce" min="0"></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondBurrRedgeAlwnce" min="0"></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdBurrRedgeAlwnce" min="0"></td>
							</tr> -->
							<tr>
								<th colspan="5" class="touch6" style="text-align:right">초,중,종 물의 W.P(좌)+P.P폭(좌) 평균값 </th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.01" class="form-control number-float2 touch6" id="average" min="0" disabled></td>
							</tr>
						</table>
					</div>
					
					</div>
					<!-- 상세정보 끝-->
					<div class="card-body col-sm-12 p-2" style="padding-bottom:8px;">
						<!-- <div class="row">  -->
							<!-- <h5 class="modal-title" class="float-left" id="workOrdNoLabel"></h5> -->
							<!-- <button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnSizeCondStepSave" disabled>저장</button> -->
						<!-- </div> -->
					</div>
					
				<!-- <hr class="text-secondary"> -->
			</div>
			<!--
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
			-->
		</div>
	</div>
</div>
<!-- 초,중,종물 모달 종료-->
<!-- 입력 취소 확인 모달 시작 -->
<div class="modal fade" id="closePopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
				<h5 class="modal-title" id="saveBtnModalLabel">진행정보 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>입력하던 정보가 있습니다. 닫으시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnCloseCheck" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				<button type="button" class="btn btn btn-secondary" id="btnCloseCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 입력 취소 모달 끝 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "50%"
			}, 200);
			$("#myrSidenav").animate({
				width : "49%"
			}, 200);
		}
	
		state = !state;
	});

	let menuAuth = 'qmsc0060';
	let currentHref = 'qmsc0060';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","외관검사");
	
	var sideView = null;
	var sum = 0;
	//공통코드 처리 시작
	var matrlCode=new Array(); // 승인여부
    <c:forEach items="${matrlNm}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlCode.push(json);
    </c:forEach>
    
    var workStatusCode=new Array();
    <c:forEach items="${workStatusCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		workStatusCode.push(json);
    </c:forEach>

	var systemCommonCode=new Array();	//외관검사 소분류
    <c:forEach items="${systemCommonCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";		
		systemCommonCode.push(json);
    </c:forEach>
    
    let systemCommonCode2 = new Array(); //외관검사 대분류
    <c:forEach items="${systemCommonCd2}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";		
		systemCommonCode2.push(json);
    </c:forEach>
    /* 고객이 재질검색 요청 시 추후 추가
	var workTeamCd=new Array(); // 승인여부
    <c:forEach items="${workTeamCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		workTeamCd.push(json);
    </c:forEach>
     */
    //공통코드 처리 종료
      
    //$('.modal-header').css('padding-bottom','0px');
    //$('.card-body.col-sm-12').css('padding-bottom','8px');
    //$('#main').css('padding-bottom','0px');
	//$('#myrSidenav').css('padding-top','0px');
	//$('#myrSidenav').css('padding-bottom','0px');
	//$('#openFullScreen').css('margin-right','5px');
	//$('#closeFullScreen').css('margin-right','5px');
	//$('#btnAdd').css('margin-right','5px');
	//$('#btnEdit').css('margin-right','5px');
	//$('#sizeCondStepTable').css('margin-bottom','0px');
    //$('#workOrdScanTable').css('margin-bottom','8px');
    $('#tab1').text(systemCommonCode2[0].baseCdNm);
	$('#tab2').text(systemCommonCode2[1].baseCdNm);
	$('#tab3').text(systemCommonCode2[2].baseCdNm);
	$('#tab4').text(systemCommonCode2[3].baseCdNm);
	
	var userNm = "<%=userNm%>";
	var serverDate =  "${serverDate}";	//서버 날짜
	var chooseDate =  serverDate;	//서버 날짜
	var searchData = "";	//조회 성공 여부
	$('#btnSave').attr('disabled', true);
	$('#btnedit').attr('disabled', true);
	$('.num_only').attr('disabled', true);
	$(".firstStep, .secondStep, .thridStep").attr("disabled",true);
	selectBoxAppend(workStatusCode, "subWorkStatusCd", "" , "1");

	metalFaultyHdCreate();
	filmFaultyHdCreate();
	etcVisionMetalFaultyHdCreate();
	etcVisionFilmFaultyHdCreate();
	etcFaultyHdCreate();
		
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let goodsFaultyAdmTable = $('#goodsFaultyAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        scrollX : false,
        lengthChange: true,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/qm/readGoodsFaultyAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		:		menuAuth,
	           	'appearInspctDate'	:		function() { return chooseDate.replace(/-/g, ''); },
            },
        },
        rowId: 'workOrdNo',
        columns: [
			{
				render: function(data, type, row) {
					return moment(row['appearInspctDate']).format("YYYY-MM-DD");
				}
			},
			{ data: 'model' },
			{ data: 'ordLotNo',
				render: function(data, type, row) {
					var html = '';
					if( row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'edgeOutputCnt' },
			{ data: 'appearOutputCnt' },
			//{ data: 'appearAbrfCnt' },	//해외1
			//{ data: 'appearAbrsCnt' },	//해외2
			//{ data: 'appearDmsCnt' },		//국내
			{ data: 'appearFaultyCnt' },
			{ data: 'faultyPercent',
				render: function(data, type, row) {
					return row['faultyPercent'] + ' %';
				}
			},
			{ data: 'appearInspctChargerNm' },
        ],
        columnDefs: [
        	{ targets: [3,4,5,6] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [3,4,5,6] , className: 'text-right'},
        ],
        buttons: [
            {
                extend: 'copy',
                title: '외관검사',
            },
            {
                extend: 'excel',
                title: '외관검사',
                exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (row == 6) {
								return data.replace(" %", "");
							} else {
								return data;
							}
						}
					}
			    }
            },
            {
                extend: 'print',
                title: '외관검사',
            },
        ],
        drawCallback: function () {
        	let edgeOutputCount = $('#goodsFaultyAdmTable').DataTable().column(3,{ page: 'all'} ).data().sum();
        	let appearOutputConut = $('#goodsFaultyAdmTable').DataTable().column(4,{ page: 'all'} ).data().sum();
        	let appearFaultyCount = $('#goodsFaultyAdmTable').DataTable().column(5,{ page: 'all'} ).data().sum();
        	let faultyPercentCount = (appearFaultyCount / edgeOutputCount) * 100;
        	
        	$('#edgeOutputCount').text(addCommas(edgeOutputCount));
        	$('#appearOutputConut').text(addCommas(appearOutputConut));
        	$('#appearFaultyCount').text(addCommas(appearFaultyCount));
        	$('#faultyPercentCount').text(faultyPercentCount.toFixed(2) + ' %');
        },
		rowCallback: function (row, data) {
			if (data.packYn == 'Y') {
				$(row).addClass('skyYellow');
			}
		},
    });

	var html1 = '<div class="row">';
	html1 += '&nbsp;<label class="input-label-sm touch6">외관검사일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control touch6" style="width:120px;" type="text" id="calender" name="calender" />';
	html1 += '<button onclick="fnPopUpCalendar(calender,calender,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button" style="width:30px; height:30px;">';
	html1 += '<span class="oi oi-calendar" style="font-size: 15px;"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary touch6" id="btnRetv">조회</button>'
	html1 += '</div>';
	$('#goodsFaultyAdmTable_length').html(html1);
	$('.dataTables_filter').addClass("touch6");		//검색필터 크기조정
	
	$('#calender').val(serverDate);
	selectBoxAppend(matrlCode, "matrlNm", "", "1");
	//selectBoxAppend(workTeamCd, "workTeamCd", "", "1");
	$("#ordLotNo").focus();

	//조회 버튼 클릭시
	$('#btnRetv').on('click', function() {
		chooseDate = $('#calender').val();
		$('#goodsFaultyAdmTable').DataTable().ajax.reload();
	});

	//작지번호 스캔시
	$("#ordLotNo").keypress(function (e) {
		if (e.which == 13){
			$('#ordLotNo').attr('disabled', true);
			
			//한타 영타로 변환
			var engToKor = korTypeToEng( $.trim($('#ordLotNo').val()) );
			//변환대 영타가 소문자여서 대문자로 변환 후 비교
			$('#ordLotNo').val(engToKor.toUpperCase());
			
			if (!$.trim($('#ordLotNo').val())) {
				toastr.warning('생산전표번호를 스캔해주세요!');
				$('#ordLotNo').focus();
				$('#ordLotNo').attr('disabled', false);
				return false;
			}
			
			$.ajax({
				url: '<c:url value="qm/scanWorkOrdOutputSubOrdLotNo"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 		menuAuth,
					'ordLotNo'		:		$('#ordLotNo').val(),
				},
				success: function (res) {
					let data = res.data;
					$('#ordLotNo').attr('disabled', false);
					if (res.result == 'ok') {
						if (data == null || data == "") {
							toastr.warning("검색 결과가 없습니다.");
						} else if (data.subWorkStatusCd == 'B') {
							//toastr.warning("해당 작지는 미발행 작지입니다. 작지바코드를 확인해주세요!", '', {timeOut: 5000});
						} else if (data.subWorkStatusCd == 'P') {
							toastr.warning("해당 작지는 발행 상태 작지입니다. 작지바코드를 확인해주세요!", '', {timeOut: 5000});
						} else if (data.subWorkStatusCd == 'S') {
							toastr.warning("해당 작지는 진행 상태 작지입니다. 작지바코드를 확인해주세요!", '', {timeOut: 5000});
						} else if ( data.subWorkStatusCd == 'C' ) {
							toastr.warning("해당 작지는 엣지검사 대상 작지입니다. 작지바코드를 확인해주세요!", '', {timeOut: 5000});
						} else if ( data.subWorkStatusCd == 'E' ) {
							$(".num_only").val("0");   // * $('#edgeOutputCnt')<-- 해당아이디에 클래스에도 num_only가 있어서 0으로 세팅하는게 맨위에있어야함
							workOrdNo = data.workOrdNo;
							ordLotNo = data.ordLotNo;
							lotNo = data.lotNo;
							equipCondSeq = data.equipCondSeq;
							$('#workTeamCd').val(data.workTeamCd);
							$('#workOrdNo').val(data.workOrdNo);
							$('#goodsNm').val(data.goodsNm);
							$('#qutyNm').val(data.qutyNm);
							$('#edgeOutputCnt').val(addCommas(data.edgeOutputCnt));
							$('#subWorkStatusCd').val(data.subWorkStatusCd);
							$('#btnSave').attr('disabled', false);
							$('#ordLotNo').attr('disabled', true);
							$('.num_only').attr('disabled', false);
							
							$('#searchUser').focus();
							$('#goodsFaultyAdmTable').DataTable().$('tr.selected').removeClass('selected');
							toastr.success("외관검사 대상 작지번호 스캔 되었습니다.");
		                } else if(data.subWorkStatusCd == 'G') {
		                	$('#ordLotNo').attr('disabled', false);
							//toastr.warning("해당 작지는 외관검사 대상 작지입니다. 작지바코드를 확인해주세요!", '', {timeOut: 5000});
						} else if(data.subWorkStatusCd == 'A') {
							$('#ordLotNo').attr('disabled', false);
							toastr.warning("해당 작지는 종료(외관검사 완료) 작지입니다. 작지바코드를 확인해주세요!", '', {timeOut: 5000});
						}
					}
				}
			});
		}
	});

	//외관 등록 데이터 상세보기
	//작업지시 상세조회
	var workOrdNo = null;	//작업지시
	var ordLotNo = null;	//생산lotNo
	var lotNo = null;	//주재료 lotNo
	var equipCondSeq = null;
	$('#goodsFaultyAdmTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#goodsFaultyAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			$('#appearInspctDate').attr('disabled',true);
			sideView = null;
	        var data = goodsFaultyAdmTable.row( this ).data();
	        workOrdNo = data.workOrdNo;
	        ordLotNo = data.ordLotNo;
	        lotNo = data.lotNo;
	        $.ajax({
	        	url: '<c:url value="qm/readWorkOrderOutputSub"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
	            	//'workOrdNo'		:		workOrdNo,		//작업지시
	            	'ordLotNo'		: 		function() { return ordLotNo; },	//생산LorNo
	            },
	            success: function (res) {
	                let data = res.data;
	                if (res.result == 'ok') {
	                	$(".num_only").val("0");
	                	$('.num_only').attr('disabled', true);
	                	workOrdNo = data.workOrdNo;
	                	ordLotNo = data.ordLotNo;
	                	equipCondSeq = data.equipCondSeq;
	                	$('#appearInspctDate').val(moment(data.appearInspctDate).format('YYYY-MM-DD'));
	                	$('#qutyNm').val(data.qutyNm);
	                	$('#goodsNm').val(data.goodsNm);
	                	$('#userNm').val(data.appearInspctChargerNm);
	                	$('#userNumber').val(data.appearInspctCharger);
	                	$('#edgeOutputCnt').val(addCommas(data.edgeOutputCnt));
	                	$('#appearFaultyCnt').val(addCommas(data.appearFaultyCnt));
	                	$('#ordLotNo').val(data.ordLotNo);
	                	$('#workOrdNo').val(data.workOrdNo);
	                	$('#subWorkStatusCd').val(data.subWorkStatusCd);
	                	
	                	$('#packYn').val(data.packYn);
	                	
	                	$('#btnSave').attr('disabled', true);
					} else if (res.result == 'fail') {
	                	toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
	                	toastr.error(res.message, '', {timeOut: 5000});
					}
				},
				complete:function(){
					//외관불량 TB 상세조회
	 		        $.ajax({
	 		        	url: '<c:url value="qm/readGoodsFaultyAdm"/>',
	 		            type: 'GET',
	 		            data: {
	 		            	'menuAuth'	 	: 		menuAuth,
	 		            	//'workOrdNo'		:		workOrdNo,		//작업지시
	 		            	'ordLotNo'		:		ordLotNo,		//생산LorNo
	 		            },
	 		            success: function (res) {
	 		                let data = res.data;
	 		                if (res.result == 'ok') {
	 		                	//$(".num_only").val("0");
	 		                	var i = 0;
	 		                	$.each($('.num_only'), function(index1,item1) {
	 		                		if(data.length > i) {
	 		                			$.each(data, function(index2,item2) {
		 		                			if ($(item1).parent().find('input[type=hidden]').val() == item2.minorCd) {
		 		                				$(item1).val(item2.faultyCnt);
			 		                			i++;
				 		                	}
			 		                	});      		
	 		                		}
	    	   					});	    	   							 		                              	
	 		                	searchData = true;
	 						} else if (res.result == 'fail') {
	 		                	toastr.warning(res.message, '', {timeOut: 5000});
	 		                	searchData = false;
	 						} else if (res.result == 'error') {
	 		                	toastr.error(res.message, '', {timeOut: 5000});
	 		                	searchData = false;
	 						}
	 					},
	 					complete:function() {
	 		 				$('#btnEdit').attr('disabled', false);
	 		 				$('#btnSave').attr('disabled', true);
							$("#btnSizeCondStep").attr("disabled", false);
	 		 				viewDisabled(true);
	 		 				totalDefectiveChange();
	 						if ($('#packYn').val() == 'Y') {
	 							$('#btnEdit').attr('disabled', true);
	 							toastr.warning('포장된 제품으로 조회만 가능합니다!','', {timeOut: 2000});
	 						}	 						
	 					}
	 				});
				}
			});
		}
	});
	
	//총 불량품
	function totalDefectiveChange(){
		var metalBadTotal = 0;
		var filmBadTotal = 0;
		let visionMetalBadTotal = 0;
		let visionFilmBadTotal = 0;
		for(var i=0; i<$('#metalFaultyTbody tr td').length; i++){
		    if($('#metalFaultyTbody tr td').eq(i).find('input').val() != 0){
		    	metalBadTotal = parseInt(metalBadTotal) + parseInt($('#metalFaultyTbody tr td').eq(i).find('input').val());
		    }
		}
		for(var i=0; i<$('#filmFaultyDiv tr td').length; i++){
		    if($('#filmFaultyDiv tr td').eq(i).find('input').val() != 0){
		    	filmBadTotal = parseInt(filmBadTotal) + parseInt($('#filmFaultyDiv tr td').eq(i).find('input').val());
		    }
		}
		for(var i=0; i<$('#etcVisionMetalFaultyTbody tr td').length; i++){
		    if($('#etcVisionMetalFaultyTbody tr td').eq(i).find('input').val() != 0){
		    	visionMetalBadTotal = parseInt(visionMetalBadTotal) + parseInt($('#etcVisionMetalFaultyTbody tr td').eq(i).find('input').val());
		    }
		}
		for(var i=0; i<$('#etcVisionFilmFaultyTbody tr td').length; i++){
		    if($('#etcVisionFilmFaultyTbody tr td').eq(i).find('input').val() != 0){
		    	visionFilmBadTotal = parseInt(visionFilmBadTotal) + parseInt($('#etcVisionFilmFaultyTbody tr td').eq(i).find('input').val());
		    }
		}
		$('#metalBadTotal').text(addCommas(metalBadTotal));
		$('#filmBadTotal').text(addCommas(filmBadTotal));
		$('#visionMetalBadTotal').text(addCommas(visionMetalBadTotal));
		$('#visionFilmBadTotal').text(addCommas(visionFilmBadTotal));
    }

	//초중종물 읽기
    $('#btnSizeCondStep').on('click', function(){
    	selectSizeCondStep();
    });
    
	//저장 버튼 클릭시
	$('#btnSave').on('click', function() {
        if ( !$.trim($('#ordLotNo').val()) ) {
            toastr.warning('생산전표번호를 스캔하세요.');
            $('#ordLotNo').focus();
            return false;
        }
        if ( !$.trim($('#ordLotNo').val()) ) {
            toastr.warning('작지번호가 검색되지 않았습니다. 생산전표번호를 스캔하세요.');
            $('#ordLotNo').focus();
            return false;
        }
		if ( !$.trim($('#qutyNm').val()) ) {
            toastr.warning('재질이 검색되지 않았습니다. 생산전표번호를  스캔하세요.');
            $('#ordLotNo').focus();
            return false;
        }
        if ( !$.trim($('#goodsNm').val()) ) {
            toastr.warning('제품(기종)이 검색되지 않았습니다. 생산전표번호를  스캔하세요.');
            $('#ordLotNo').focus();
            return false;
        }
        if ( !$.trim($('#edgeOutputCnt').val()) ) {
            toastr.warning('엣지양품수량이 검색되지 않았습니다. 생산전표번호를  스캔하세요.');
            $('#ordLotNo').focus();
            return false;
        }
        if ( !$.trim($('#userNumber').val()) ) {
            toastr.warning('검사담당을 검색하세요.');
            $('#searchUser').focus();
            return false;
        }
        var numCheck = false;
        
		$.each($('input.num_only'), function(index,item) {
			if (!$.trim($(this).val())) {
				$(this).focus();
				numCheck = true;
				return false;
			}
		});
		
		if (numCheck) {
			toastr.warning('수량을 입력하세요.');
			return false;
		}
		
		// 엣지양품수량 >= 불량수량 이면 수행		
        var trueFalse = faultyCntCheck();
		
        if (trueFalse) {
			$('#my-spinner').show();
			var dataArray = new Array();
			var edgeOutputCnt = 0;
			edgeOutputCnt = parseInt($('#edgeOutputCnt').val());
			
			$.each($('#metalFaultyTbody .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00') {
					var rowData = new Object();
					rowData.workOrdNo = workOrdNo;
					rowData.ordLotNo = ordLotNo;
					rowData.faultyRegDate = $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd = '001';
					rowData.minorCd = $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt = $(this).val().replace(/,/g,"");
					rowData.sum = sum;
					rowData.inspctChargr = $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#edgeOutputCnt').val().replace(/,/g,"") - sum);
					rowData.appearFaultyCnt = sum;
					//rowData.workOrdDate = $('#appearInspctDate').val().replace(/-/g,"");
					dataArray.push(rowData);
				}
			});
			
			$.each($('#filmFaultyTbody .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00'){	
					var rowData = new Object();
					rowData.workOrdNo = workOrdNo;
					rowData.ordLotNo = ordLotNo;
					rowData.faultyRegDate = $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd = '002';
					rowData.minorCd = $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt = $(this).val().replace(/,/g,"");
					rowData.sum = sum;
					rowData.inspctChargr = $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#edgeOutputCnt').val().replace(/,/g,"") - sum);
					rowData.appearFaultyCnt = sum;
					//rowData.workOrdDate = $('#appearInspctDate').val().replace(/-/g,"");
					dataArray.push(rowData);
				}
			});

			$.each($('#etcVisionMetalFaultyTbody .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00'){	
					var rowData = new Object();
					rowData.workOrdNo = workOrdNo;
					rowData.ordLotNo = ordLotNo;
					rowData.faultyRegDate = $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd = '004';
					rowData.minorCd = $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt = $(this).val().replace(/,/g,"");
					rowData.sum = sum;
					rowData.inspctChargr = $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#edgeOutputCnt').val().replace(/,/g,"") - sum);
					rowData.appearFaultyCnt = sum;
					//rowData.workOrdDate = $('#appearInspctDate').val().replace(/-/g,"");
					dataArray.push(rowData);
				}
			});

			$.each($('#etcVisionFilmFaultyTbody .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00'){	
					var rowData = new Object();
					rowData.workOrdNo = workOrdNo;
					rowData.ordLotNo = ordLotNo;
					rowData.faultyRegDate = $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd = '005';
					rowData.minorCd = $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt = $(this).val().replace(/,/g,"");
					rowData.sum = sum;
					rowData.inspctChargr = $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#edgeOutputCnt').val().replace(/,/g,"") - sum);
					rowData.appearFaultyCnt = sum;
					//rowData.workOrdDate = $('#appearInspctDate').val().replace(/-/g,"");
					dataArray.push(rowData);
				}
			});

			if(dataArray.length == 0){
				var rowData = new Object();
				rowData.workOrdNo = workOrdNo;
				rowData.ordLotNo = ordLotNo;
				rowData.faultyRegDate = $('#appearInspctDate').val().replace(/-/g,"");
				rowData.majorCd = '001';
				rowData.minorCd = '001';
				rowData.faultyCnt = '0';
				rowData.sum = 0;
				rowData.inspctChargr = $('#userNumber').val();
				rowData.appearOutputCnt = parseInt($('#edgeOutputCnt').val().replace(/,/g,"") - sum);
				rowData.appearFaultyCnt = '0';
				//rowData.workOrdDate = $('#appearInspctDate').val().replace(/-/g,"");
				dataArray.push(rowData);
			}
            
            var url = "";
    		if (searchData) {
    			url = '<c:url value="/qm/appearCheckUpdate"/>';
    		} else {
    			url = '<c:url value="/qm/appearCheckInsert"/>';
    		}

    		$.ajax({
				//외관검사 등록 OR 업데이트
				url: url,
				type: 'POST',
				data: JSON.stringify(dataArray),
				dataType:"json",
				contentType : "application/json; charset=UTF-8",		                                                                                    				
				success: function (res) {                                                                  				
					let data = res.data;
					if(res.result == 'ok') {
						if(searchData == true) {
							//appearUpdate();
							$('#appearFaultyCnt').val(sum);
							toastr.success("외관양품수량 수정 되었습니다.");
						} else if(searchData == false) {
							//appearUpdate();
							$('#appearFaultyCnt').val(sum);
							toastr.success("외관양품수량 저장 되었습니다. 종물을 등록해 주세요!");
						}
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
					$('.num_only').attr('disabled', true);
    			},
    			complete:function(){
    				$('#goodsFaultyAdmTable').DataTable().ajax.reload();
    				viewDisabled(true);    				
    				$('#searchUser').attr("disabled", true);
    				$('#btnSave').attr("disabled", true);
    				$('#btnSizeCondStep').attr("disabled", false);
    				$("#btnSizeCondStep").focus();
    				$('#appearInspctDate').attr('disabled',true);
    				totalDefectiveChange();
    				$('#my-spinner').hide();
    				$('#appearFaultyCnt').val(addCommas($('#appearFaultyCnt').val()));
    				$('#edgeOutputCnt').val(addCommas($('#edgeOutputCnt').val()));
				}
			});
		}
	});

	//등록 버튼 클릭시
	$('#btnAdd').on('click', function() {
		sideView = 'add';
		viewDisabled(false);
		viewValueClear();
		$("#btnEdit").attr("disabled", true);
		$("#btnSave").attr("disabled", true);
		$('.num_only').attr('disabled', true);		
		$("#btnSizeCondStep").attr("disabled", true);
		//$("#appearInspctDate").val(serverDate);
		searchData = false;
		$('#ordLotNo').focus();
		$('#appearInspctDate').attr('disabled',false);

		var date = new Date(new Date().setHours(0,0,0,0));			//오늘날짜 00:00:00
		var secondDiff = parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today = new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today = getDateType(today);			//YYYY-MM-DD 형식으로 변환
		var yesterday = new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday = getDateType(yesterday);	//YYYY-MM-DD 형식으로 변환
			 
		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#appearInspctDate').val(today);
			//selectBoxAppend(ordGubunCode, "edgeInspctDate", "N", "");
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#appearInspctDate').val(yesterday);
			//selectBoxAppend(ordGubunCode, "edgeInspctDate", "N", "");

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#appearInspctDate').val(today);
			//selectBoxAppend(ordGubunCode, "edgeInspctDate", "D", "");
		}
	});
	
	//수정 버튼 클릭시
	$('#btnEdit').on('click', function() {
		sideView = 'edit';
		viewDisabled(false);
		$("#btnSave").attr("disabled",false);
		$("#ordLotNo").attr("disabled",true);
		$('.num_only').attr('disabled', false);
		$('#edgeOutputCnt').attr('disabled',true);
		$("#metalMmb").select();
		$('#appearInspctDate').attr('disabled',false);
	});
	
	//담당자조회 팝업 시작
	var userPopUpTable;
	function selectPreWorkCharger()
	{
	     if(userPopUpTable == null || userPopUpTable == undefined)   {
	        userPopUpTable = $('#userPopUpTable').DataTable({
				language: lang_kor,
				lengthChange : false,
				paging: true,
				info: true,
				ordering: true,
				processing: true,
				autoWidth: false,
				pageLength: 20,
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
	                { data : 'departmentNm'   }, 
	                { data : 'postNm' }, 
	                { data : 'chargrDutyNm'   }, 
	                { data : 'teamNm' }, 
	                { data : 'workplaceNm' },
	            ],
	            columnDefs: [
	               //{ "targets": [0], "visible" : true },
	               { "targets": [0,1,2,3,4,5],  "className": "text-center"}
	            ],
	            oSearch: {"sSearch": userNm},
	            order: [
	                [ 0, 'asc' ]
	            ],
			});
			$('#userPopUpTable tbody').on('click', 'tr', function () {
	            var data = userPopUpTable.row( this ).data();
	            $('#userNm').val(data.userNm);			//사원명
	            $('#userNumber').val(data.userNumber);	//사원코드(hidden)
	            $('#userPopUpModal').modal('hide');
	            $('#metalMmb').select();
			});
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
			
     	$('#userPopUpModal').modal('show');   
     }
    //담당자조회 팝업 종료

   //View값 초기화
    function viewValueClear(){
		$('#appearInspctDate').val("");
		$('#goodsNm').val("");
		$('#edgeOutputCnt').val("");
		$('#userNumber').val("");
		$('#userNm').val("");
		$('#qutyNm').val("");
		$('#ordLotNo').val("");
		$('#workOrdNo').val("");
		$('#edgeOutputCnt').val("")
		$('#metalBadTotal').text("0");
		$('#filmBadTotal').text("0");
		//$('#appearAbrfCnt').val("");
		//$('#appearAbrsCnt').val("");
		//$('#appearDmsCnt').val("");
		$('#appearFaultyCnt').val("");
		$('#subWorkStatusCd').val(null);
		
		//$('#metalMmb').val("");
		//$('#metalMms').val("");
		//$('#metalPms').val("");
		//$('#metalFstab').val("");
		//$('#metalPstab').val("");
		//$('#metalAliensbst').val("");
		//$('#metalBreak').val("");
		//$('#metalPolutn').val("");
		//$('#metalBrowning').val("");
		//$('#metalPpolutn').val("");
		//$('#metalGilt').val("");
		//$('#metalThickness').val("");
		//$('#metalEtc').val("");
		//$('#filmPfs').val("");
		//$('#filmBreak').val("");
		//$('#filmTornout').val("");
		//$('#filmSurfceBb').val("");
		//$('#filmEdgeBb').val("");
		//$('#filmTeflon').val("");
		//$('#filmAliensbst').val("");
		//$('#filmPolutn').val("");
		//$('#filmAgglomt').val("");
		//$('#filmOverlap').val("");
		//$('#filmUnjinjeop').val("");
		//$('#filmUnattch').val("");
		//$('#filmMf').val("");
		//$('#filmWing').val("");
		//$('#filmEtc').val("");
		//$('#etcSize').val("");
		//$('#etcCutting').val("");
		//$('#etcFilmPress').val("");
		//$('#etcFilmDepth').val("");
		//$('#etcLayer').val("");
		//$('#etcEtc').val("");
		//$('#etcWashboard').val("");
		//$('#etcWhitetape').val("");
		//$('#etcPattem').val("");
		//$('#etcStabbed').val("");
		//$('#etcHaze').val("");
		//$('#etcSurface').val("");
		//$('#etcSwelling').val("");
		//$('#etcFeeding').val("");
		//$('#etcFilm').val("");
		//$('#etcSlash').val("");
		//$('#etcJinjeop').val("");
		//$('#etcCrack').val("");
		//$('#etcCrease').val("");
	}

    //입력항목들 disabled
    function viewDisabled(flag){
    	$('#edgeInspctDate').attr("disabled",flag);
		$('#searchUser').attr("disabled",flag);

    	$("#searchUser").attr("disabled",flag);
		$("#edgeSampleCnt").attr("disabled",flag);
		$("#edgeFaultyCnt").attr("disabled",flag);
		$("#ordLotNo").attr("disabled",flag);
		
		//$('#appearAbrfCnt').attr("disabled",flag);
		//$('#appearAbrsCnt').attr("disabled",flag);
		//$('#appearDmsCnt').attr("disabled",flag);
		
    	//$("#metalMmb").attr("disabled",flag);
    	//$("#metalMms").attr("disabled",flag);
    	//$("#metalPms").attr("disabled",flag);
    	//$("#metalFstab").attr("disabled",flag);
    	//$("#metalPstab").attr("disabled",flag);
    	//$("#metalAliensbst").attr("disabled",flag);
    	//$("#metalBreak").attr("disabled",flag);
    	//$("#metalPolutn").attr("disabled",flag);
    	//$("#metalGilt").attr("disabled",flag);
    	//$("#metalThickness").attr("disabled",flag);
    	//$("#filmPfs").attr("disabled",flag);
    	//$("#filmBreak").attr("disabled",flag);
    	//$("#filmTornout").attr("disabled",flag);
    	//$("#filmSurfceBb").attr("disabled",flag);
    	//$("#filmEdgeBb").attr("disabled",flag);
    	//$("#filmTeflon").attr("disabled",flag);
    	//$("#filmAliensbst").attr("disabled",flag);
    	//$("#filmPolutn").attr("disabled",flag);
    	//$("#filmAgglomt").attr("disabled",flag);
    	//$("#filmOverlap").attr("disabled",flag);
    	//$("#filmUnjinjeop").attr("disabled",flag);
    	//$("#filmUnattch").attr("disabled",flag);
    	//$("#etcSize").attr("disabled",flag);
    	//$("#etcCutting").attr("disabled",flag);
    	//$("#etcFilmPress").attr("disabled",flag);
    	//$("#etcFilmDepth").attr("disabled",flag);
    	//$("#etcLayer").attr("disabled",flag);
    	//$("#etcEtc").attr("disabled",flag);
    }

	$('.num_only').keypress(function (event) { 
		
		if ($(this).attr("maxlength") < $(this).val().length) {
			$(this).val($(this).val().substring(0, $(this).attr("maxlength")));
			$(this).val("0");
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			event.preventDefault();
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최대 수치를 초과하였습니다.');
			event.preventDefault();
		}
		
		if ( !((event.which >= 48 && event.which <= 57) || event.which == 13 || (event.which >= 37 && event.which <= 40))) {
	 		if ( event.which == 46 ) {
				toastr.warning('정수만 입력 가능합니다.');
				$(this).val("0");
				event.preventDefault();
			}else{
				$('input').on("blur keyup", function() {
					$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
				});
				toastr.warning('양수(+)만 입력해주세요.');
				event.preventDefault();
			}
			
		}
	});
	
	//$(function() faultyCntCheck{
	function faultyCntCheck(){
		//$('input.num_only').on('keyup',function(){
/* 			var sum1 = parseInt($("#metalMmb").val() || 0);
			var sum2 = parseInt($("#metalMms").val() || 0);
			var sum3 = parseInt($("#metalPms").val() || 0);
			var sum4 = parseInt($("#metalFstab").val() || 0);
			var sum5 = parseInt($("#metalPstab").val() || 0);
			var sum6 = parseInt($("#metalAliensbst").val() || 0);
			var sum7 = parseInt($("#metalBreak").val() || 0);
			var sum8 = parseInt($("#metalPolutn").val() || 0);
			var sum9 = parseInt($("#metalBrowning").val() || 0);
			var sum10 = parseInt($("#metalPpolutn").val() || 0);
			var sum11 = parseInt($("#metalGilt").val() || 0);
			var sum12 = parseInt($("#metalThickness").val() || 0);
			var sum13 = parseInt($("#metalEtc").val() || 0);
			var sum14 = parseInt($("#filmPfs").val() || 0);
			var sum15 = parseInt($("#filmBreak").val() || 0);
			var sum16 = parseInt($("#filmTornout").val() || 0);
			var sum17 = parseInt($("#filmSurfceBb").val() || 0);
			var sum18 = parseInt($("#filmEdgeBb").val() || 0);
			var sum19 = parseInt($("#filmTeflon").val() || 0);
			var sum20 = parseInt($("#filmAliensbst").val() || 0);
			var sum21 = parseInt($("#filmPolutn").val() || 0);
			var sum22 = parseInt($("#filmAgglomt").val() || 0);
			var sum23 = parseInt($("#filmOverlap").val() || 0);
			var sum24 = parseInt($("#filmUnjinjeop").val() || 0);
			var sum25 = parseInt($("#filmUnattch").val() || 0);
			var sum26 = parseInt($("#filmMf").val() || 0);
			var sum27 = parseInt($("#filmWing").val() || 0);
			var sum28 = parseInt($("#filmEtc").val() || 0);
			var sum29 = parseInt($("#etcSize").val() || 0);
			var sum30 = parseInt($("#etcCutting").val() || 0);
			var sum31 = parseInt($("#etcFilmPress").val() || 0);
			var sum32 = parseInt($("#etcFilmDepth").val() || 0);
			var sum33 = parseInt($("#etcLayer").val() || 0);
			var sum34 = parseInt($("#etcWashboard").val() || 0);
			var sum35 = parseInt($("#etcWhitetape").val() || 0);
			var sum36 = parseInt($("#etcPattem").val() || 0);
			var sum37 = parseInt($("#etcStabbed").val() || 0);
			var sum38 = parseInt($("#etcHaze").val() || 0);
			var sum39 = parseInt($("#etcSurface").val() || 0);
			var sum40 = parseInt($("#etcSwelling").val() || 0);
			var sum41 = parseInt($("#etcFeeding").val() || 0);
			var sum42 = parseInt($("#etcFilm").val() || 0);
			var sum43 = parseInt($("#etcSlash").val() || 0);
			var sum44 = parseInt($("#etcJinjeop").val() || 0);
			var sum45 = parseInt($("#etcCrack").val() || 0);
			var sum46 = parseInt($("#etcCrease").val() || 0);
			var sum47 = parseInt($("#etcEtc").val() || 0);

			
			var sum = sum1 + sum2 + sum3 + sum4 + sum5 + sum6 + sum7 + sum8 + sum9 + sum10;
			sum+= sum11 + sum12 + sum13 + sum14 + sum15 + sum16 + sum17 + sum18 + sum19 + sum20; 
			sum+= sum21 + sum22 + sum23 + sum24 + sum25 + sum26 + sum27 + sum28 + sum29 + sum30;
			sum+= sum31 + sum32 + sum33 + sum34 + sum35 + sum36 + sum37 + sum38 + sum39 + sum40;
			sum+= sum41 + sum42 + sum44 + sum44 + sum45 + sum46 + sum47; */
			//$("#appearFaultyCnt").val(sum);
			sum = 0;
			$.each($('input.num_only'), function(index,item){				
				sum += parseInt($(this).val() || 0);
			});
			if (sideView == 'add'){
				sum = sum - parseInt($('#edgeOutputCnt').val());
			}
			else if (sideView == 'edit'){
    			sum = sum - parseInt($('#edgeOutputCnt').val());
    		}
			var temp;
			if( parseInt($("#edgeOutputCnt").val().replace(/,/g, '')) < parseInt(sum) ){
				toastr.warning('불량수량이 엣지양품수량보다 많습니다 확인해주세요.');
				temp = false;
			} else {
				temp = true
			}

			return temp;
		 //});
	}
	//});
	
	//var location = null; 요거하면 url주소가 null로 돌아감 왜?
	//외관불량수량 입력 키보드
	var tagId = "";
	var temp = "";
	$('.num_only').focusout(function() {
		tagId = $(this).attr('id');
	});

	$('#number0').on('click', function () {
		let temp = $('#'+tagId).val();		
		if (temp == "0"){
			$('#'+tagId).val("0");
		} else{
			$('#'+tagId).val(temp.concat("0"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number1').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("1");
		} else{
			$('#'+tagId).val(temp.concat("1"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number2').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("2");
		} else{
			$('#'+tagId).val(temp.concat("2"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number3').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("3");
		} else{
			$('#'+tagId).val(temp.concat("3"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number4').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("4");
		} else{
			$('#'+tagId).val(temp.concat("4"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number5').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("5");
		} else{
			$('#'+tagId).val(temp.concat("5"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number6').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("6");
		} else{
			$('#'+tagId).val(temp.concat("6"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number7').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("7");
		} else{
			$('#'+tagId).val(temp.concat("7"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number8').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("8");
		} else{
			$('#'+tagId).val(temp.concat("8"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number9').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("9");
		} else{
			$('#'+tagId).val(temp.concat("9"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number0, #number1, #number2, #number3, #number4, #number5, #number6, #number7, #number8, #number9').on('click', function(){
		if ($('#edgeOutputCnt').attr("maxlength") < $('#edgeOutputCnt').val().length) {
			$('#edgeOutputCnt').val($('#edgeOutputCnt').val().substring(0, $('#edgeOutputCnt').attr("maxlength")));
			$('#edgeOutputCnt').val("0");
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			event.preventDefault();
		}
 		if ( parseFloat($('#edgeOutputCnt').attr("max")) < parseFloat($('#edgeOutputCnt').val())) {
 			$('#edgeOutputCnt').val("0");
			toastr.warning('최대 수치를 초과하였습니다.');
			event.preventDefault();
		}
	});
	//백스페이스
	$('#backSpace').on('click', function () {
		let temp = $('#'+tagId).val();
		temp = temp.slice(0,-1); //문자
		$('#'+tagId).val(temp);
		$(".num_only").trigger("keyup");
	});

	$('.num_only').on('click', function() {
		$(this).select();
	});
	let idStr = '';
	//엔터
	$('#enter').on('click', function () {
		//해당아이디 엔터 강제이벤트로 가기
		if( tagId == 'edgeOutputCnt' ){
			if( $('#tab1').hasClass('active') ){
				//$('#metal001').select();
				idStr = '#' + $('#metalFaultyTbody').find('td').eq(0).html().substring($('#metalFaultyTbody').find('td').eq(0).html().search('id')+4,$('#metalFaultyTbody').find('td').eq(0).html().search('id')+12);
				$(idStr).select();
			} else if ( $('#tab2').hasClass('active') ){
				//$('#film019').select();
				idStr = '#' + $('#filmFaultyTbody').find('td').eq(0).html().substring($('#filmFaultyTbody').find('td').eq(0).html().search('id')+4,$('#filmFaultyTbody').find('td').eq(0).html().search('id')+11);
				$(idStr).select();
			} /* else if ( $('#tab4').hasClass('active') ){
				$('#vision057').select();
			} else if( $('#tab5').hasClass('active') ){
				$('#5058').select();
			} */
		} else{
			$.each($('#metalFaultyTbody .num_only'), function(index, item) {
					/* if (tagId == $(this).attr('id')){
						var str = $(this).attr('id');
						$('#metal'+ numberPad((parseInt(str.slice(-3, str.length))+1),3)).select();
					} */
					if ( tagId ==  $(this).attr('id') ){
						try{
							idStr = '#' + $('#metalFaultyTbody').find('td').eq(index+1).html().substring($('#metalFaultyTbody').find('td').eq(index+1).html().search('id')+4,$('#metalFaultyTbody').find('td').eq(index+1).html().search('id')+12);
							$(idStr).select();
						} 
						catch {
							idStr = '#' + $('#metalFaultyTbody').find('td').eq(0).html().substring($('#metalFaultyTbody').find('td').eq(0).html().search('id')+4,$('#metalFaultyTbody').find('td').eq(0).html().search('id')+12);
							$(idStr).select();
						}
					}	
			});
			$.each($('#filmFaultyTbody .num_only'), function(index, item) {
				/* if (tagId == $(this).attr('id')){
					var str = $(this).attr('id');
					$('#film'+ numberPad((parseInt(str.slice(-3, str.length))+1),3)).select();
				}	 */		
				if ( tagId == $(this).attr('id') ){
					try{
						idStr = '#' + $('#filmFaultyTbody').find('td').eq(index+1).html().substring($('#filmFaultyTbody').find('td').eq(index+1).html().search('id')+4,$('#filmFaultyTbody').find('td').eq(index+1).html().search('id')+11);
						$(idStr).select();
					}
					catch {
						idStr = '#' + $('#filmFaultyTbody').find('td').eq(0).html().substring($('#filmFaultyTbody').find('td').eq(0).html().search('id')+4,$('#filmFaultyTbody').find('td').eq(0).html().search('id')+11);
						$(idStr).select();
					}
				}
			});
		}

		
		/* 
		if (tagId == "metalMmb"){
			$('#metalMms').select();
		} else 	if (tagId == "metalMms"){
			$('#metalPms').select();
		} else 	if (tagId == "metalPms"){
			$('#metalFstab').select();
		} else 	if (tagId == "metalFstab"){
			$('#metalPstab').select();
		} else 	if (tagId == "metalPstab"){
			$('#metalAliensbst').select();
		} else 	if (tagId == "metalAliensbst"){
			$('#metalBreak').select();
		} else 	if (tagId == "metalBreak"){
			$('#metalPolutn').select();
		} else 	if (tagId == "metalPolutn"){
			$('#metalBrowning').select();
		} else 	if (tagId == "metalBrowning"){
			$('#metalPpolutn').select();
		} else 	if (tagId == "metalPpolutn"){
			$('#metalGilt').select();
		} else 	if (tagId == "metalGilt"){
			$('#metalThickness').select();
		} else 	if (tagId == "metalThickness"){
			$('#metalEtc').select();
		} else 	if (tagId == "metalEtc"){
			$('#filmPfs').select();
		} else 	if (tagId == "filmPfs"){
			$('#filmBreak').select();
		} else 	if (tagId == "filmBreak"){
			$('#filmTornout').select();
		} else 	if (tagId == "filmTornout"){
			$('#filmSurfceBb').select();
		} else 	if (tagId == "filmSurfceBb"){
			$('#filmEdgeBb').select();
		} else 	if (tagId == "filmEdgeBb"){
			$('#filmTeflon').select();
		} else 	if (tagId == "filmTeflon"){
			$('#filmAliensbst').select();
		} else 	if (tagId == "filmAliensbst"){
			$('#filmPolutn').select();
		} else 	if (tagId == "filmPolutn"){
			$('#filmAgglomt').select();
		} else 	if (tagId == "filmAgglomt"){
			$('#filmOverlap').select();
		} else 	if (tagId == "filmOverlap"){
			$('#filmUnjinjeop').select();
		} else 	if (tagId == "filmUnjinjeop"){
			$('#filmUnattch').select();
		} else 	if (tagId == "filmUnattch"){
			$('#filmWing').select();
		} else 	if (tagId == "filmWing"){
			$('#filmMf').select();
		} else 	if (tagId == "filmMf"){
			$('#filmEtc').select();
		} else 	if (tagId == "filmEtc"){
			$('#etcSize').select();
		} else 	if (tagId == "etcSize"){
			$('#etcCutting').select();
		} else 	if (tagId == "etcCutting"){
			$('#etcFilmPress').select();
		} else 	if (tagId == "etcFilmPress"){
			$('#etcFilmDepth').select();
		} else 	if (tagId == "etcFilmDepth"){
			$('#etcLayer').select();
		} else 	if (tagId == "etcLayer"){
			$('#etcWashboard').select();
		} else 	if (tagId == "etcWashboard"){
			$('#etcWhitetape').select();
		} else 	if (tagId == "etcWhitetape"){
			$('#etcPattem').select();
		} else 	if (tagId == "etcPattem"){
			$('#etcStabbed').select();
		} else 	if (tagId == "etcStabbed"){
			$('#etcHaze').select();
		} else 	if (tagId == "etcHaze"){
			$('#etcSurface').select();
		} else 	if (tagId == "etcSurface"){
			$('#etcSwelling').select();
		} else 	if (tagId == "etcSwelling"){
			$('#etcFeeding').select();

		} else 	if (tagId == "etcFeeding"){
			$('#etcFilm').select();

			
		} else 	if (tagId == "etcFilm"){
			$('#etcSlash').select();
		} else 	if (tagId == "etcSlash"){
			$('#etcJinjeop').select();
		} else 	if (tagId == "etcJinjeop"){
			$('#etcCrack').select();
		} else 	if (tagId == "etcCrack"){
			$('#etcCrease').select();
		} else 	if (tagId == "etcCrease"){
			$('#etcEtc').select();
		} else 	if (tagId == "etcEtc"){
			$('#btnSave').focus();
		} */
			
		$(".num_only").trigger("keyup");
	});

	//숫자입력 글자 수, min, max 제한
	$('.num_sum').keyup(function (event) {
 		if ($(this).attr("maxlength") < $(this).val().length) {
			$(this).val($(this).val().substring(0, $(this).attr("maxlength")));
			$(this).val("0");
			toastr.warning('최대 입력 글자를 초과하였습니다.');
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최대 수치를 초과하였습니다.');
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최소 크기를 초과하였습니다.');
		}
	});

	//콤마(,) 생성
	function addCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

	//전체화면	
    $('#openFullScreen').on('click', function(){
    	openFullScreenMode();
    });

	//전체화면 해제
    $('#closeFullScreen').on('click', function(){
    	closeFullScreenMode();
    });

	//전체화면(f11)감지
    $(window).resize(function () {
        if ((screen.availHeight || screen.height - 30) <= window.innerHeight) {
        	$('#mainCard').css('height','915px');
        	//$('#rightList').css('min-height','915px');
        }
        else {
        	$('#mainCard').css('height','815px');
        	//$('#rightList').css('min-height','765px');
        }
    });

	//View 초기화
  	function viewClear()
	{
  		//$(".cond, .number-float1, .number-").val(null);
		$(".cond, .step_num_only").val(null);
    	$('#firstRegTime').val("");
    	$('#secondRegTime').val("");
    	$('#thirdRegTime').val("");
    	$("#average").val("");
	}

	function viewForm(flag)	{
		//$(".firstStep, .secondStep, .thridStep").attr("disabled",flag);
		$(".thridStep").attr("disabled",flag);
	}

	//초,중,종물 팝업 시작
	var oldOrdLotNo = null;	//종물 update시 검색조건에 필요
   	function selectSizeCondStep()
   	{
   		$('#my-spinner').show();
   		
   		$('.number-').css('color', 'black');
   		$('#sizeCondStepPopUpModal').modal({backdrop: 'static'});
		$('#sizeCondStepPopUpModal').modal('show');
		$('#firstInput').attr('disabled',true);
		$('#secondInput').attr('disabled',true);
        viewClear();
        viewForm(true);
        
   	    $.ajax({
   	    	url: '<c:url value="/qm/readWorkOrdOutputSubStepData"/>',
   	        type: 'GET',
   	        data: {
   	        	'menuAuth'	 	: 	menuAuth,
	   	        'workOrdNo'		: 	function() { return workOrdNo; },
	   	     	'ordLotNo'		: 	function() { return ordLotNo; },
   				'equipCondSeq' 	: 	function() { return equipCondSeq; },
   	        },
   	        success: function (res) {
   	         	let condStepData = res.condStepData;
				let firstStepData = res.firstStepData;
				let secondStepData = res.secondStepData;
				let thirdStepData = res.thirdStepData;
				let readWorkOrdOutputSubVo = res.readWorkOrdOutputSubVo;

				//종물을 다른 생산실적(ordLotNo)에서 입력했는지 확인
				if (thirdStepData != null && thirdStepData.ordLotNo != ordLotNo) {
					toastr.warning(thirdStepData.ordLotNo + ' 에서 등록&수정된 종물입니다.', '', {timeOut: 7000});
				}
				
				//치수 조건
   	            if (res.result == 'ok') {
   	            	$('#sizeCondStepPopUpLabel1').text(readWorkOrdOutputSubVo.ordLotNo + ' / ' + readWorkOrdOutputSubVo.lotNo);
   	            	
   	            	$('#wpLeftCond').text('-'+condStepData.wpLeftAlwnceMinus + ' [' + condStepData.wpLeftCond + '] +' + condStepData.wpLeftAlwncePlus);
   	            	$('#wpRightCond').text('-'+condStepData.wpRightAlwnceMinus + ' [' + condStepData.wpRightCond + '] +' + condStepData.wpRightAlwncePlus);
   	            	$('#pitchLeftCond').text('-'+condStepData.pitchLeftAlwnceMinus + ' [' + condStepData.pitchLeftCond + '] +' + condStepData.pitchLeftAlwncePlus);
   	            	$('#pitchRightCond').text('-'+condStepData.pitchRightAlwnceMinus + ' [' + condStepData.pitchRightCond + '] +' + condStepData.pitchRightAlwncePlus);
   	            	$('#ppfWingLeftCond').text('-'+condStepData.ppfWingLeftAlwnceMinus + ' [' + condStepData.ppfWingLeftCond + '] +' + condStepData.ppfWingLeftAlwncePlus);
   	            	$('#ppfWingRightCond').text('-'+condStepData.ppfWingRightAlwnceMinus + ' [' + condStepData.ppfWingRightCond + '] +' + condStepData.ppfWingRightAlwncePlus);
   	            	$('#ppfDepthLeftCond').text('-'+condStepData.ppfDepthLeftAlwnceMinus + ' [' + condStepData.ppfDepthLeftCond + '] +' + condStepData.ppfDepthLeftAlwncePlus);
   	            	$('#ppfDepthRightCond').text('-'+condStepData.ppfDepthRightAlwnceMinus + ' [' + condStepData.ppfDepthRightCond + '] +' + condStepData.ppfDepthRightAlwncePlus);
   	            	$('#filmCond').text('-'+condStepData.filmAlwnceMinus + ' [' + condStepData.filmCond + '] +' + condStepData.filmAlwncePlus);
   	            	$('#metalDepthCond').text('-'+condStepData.metalDepthAlwnceMinus + ' [' + condStepData.metalDepthCond + '] +' + condStepData.metalDepthAlwncePlus);
   	            	$('#metalThicknessCond').text('-'+condStepData.metalThicknessAlwnceMinus + ' [' + condStepData.metalThicknessCond + '] +' + condStepData.metalThicknessAlwncePlus);
   	            	$('#thCenterCond').text('-'+condStepData.thCenterAlwnceMinus + ' [' + condStepData.thCenterCond + '] +' + condStepData.thCenterAlwncePlus);
   	            	$('#thEdgeCond').text('-'+condStepData.thEdgeAlwnceMinus + ' [' + condStepData.thEdgeCond + '] +' + condStepData.thEdgeAlwncePlus);
   	            	$('#burrCond').text('-'+condStepData.burrAlwnceMinus + ' [' + condStepData.burrCond + '] +' + condStepData.burrAlwncePlus);

					$('#thirdWpLeftAlwnce').attr("minVal", (parseFloat(condStepData.wpLeftCond) - parseFloat(condStepData.wpLeftAlwnceMinus)).toFixed(3) );
					$('#thirdWpLeftAlwnce').attr("maxVal", (parseFloat(condStepData.wpLeftCond) + parseFloat(condStepData.wpLeftAlwncePlus)).toFixed(3) );
					$('#thirdWpRightAlwnce').attr("minVal", (parseFloat(condStepData.wpRightCond) - parseFloat(condStepData.wpRightAlwnceMinus)).toFixed(3) );
					$('#thirdWpRightAlwnce').attr("maxVal", (parseFloat(condStepData.wpRightCond) + parseFloat(condStepData.wpRightAlwncePlus)).toFixed(3) );
					$('#thirdPitchLeftAlwnce').attr("minVal", (parseFloat(condStepData.pitchLeftCond) - parseFloat(condStepData.pitchLeftAlwnceMinus)).toFixed(3) );
					$('#thirdPitchLeftAlwnce').attr("maxVal", (parseFloat(condStepData.pitchLeftCond) + parseFloat(condStepData.pitchLeftAlwncePlus)).toFixed(3) );
					$('#thirdPitchRightAlwnce').attr("minVal", (parseFloat(condStepData.pitchRightCond) - parseFloat(condStepData.pitchRightAlwnceMinus)).toFixed(3) );
					$('#thirdPitchRightAlwnce').attr("maxVal", (parseFloat(condStepData.pitchRightCond) + parseFloat(condStepData.pitchRightAlwncePlus)).toFixed(3) );
					$('#thirdPpfWingLeftAlwnce').attr("minVal", (parseFloat(condStepData.ppfWingLeftCond) - parseFloat(condStepData.ppfWingLeftAlwnceMinus)).toFixed(3) );
					$('#thirdPpfWingLeftAlwnce').attr("maxVal", (parseFloat(condStepData.ppfWingLeftCond) + parseFloat(condStepData.ppfWingLeftAlwncePlus)).toFixed(3) );
					$('#thirdPpfWingRightAlwnce').attr("minVal", (parseFloat(condStepData.ppfWingRightCond) - parseFloat(condStepData.ppfWingRightAlwnceMinus)).toFixed(3) );
					$('#thirdPpfWingRightAlwnce').attr("maxVal", (parseFloat(condStepData.ppfWingRightCond) + parseFloat(condStepData.ppfWingRightAlwncePlus)).toFixed(3) );
					$('#thirdPpfDepthLeftAlwnce').attr("minVal", (parseFloat(condStepData.ppfDepthLeftCond) - parseFloat(condStepData.ppfDepthLeftAlwnceMinus)).toFixed(3) );
					$('#thirdPpfDepthLeftAlwnce').attr("maxVal", (parseFloat(condStepData.ppfDepthLeftCond) + parseFloat(condStepData.ppfDepthLeftAlwncePlus)).toFixed(3) );
					$('#thirdPpfDepthRightAlwnce').attr("minVal", (parseFloat(condStepData.ppfDepthRightCond) - parseFloat(condStepData.ppfDepthRightAlwnceMinus)).toFixed(3) );
					$('#thirdPpfDepthRightAlwnce').attr("maxVal", (parseFloat(condStepData.ppfDepthRightCond) + parseFloat(condStepData.ppfDepthRightAlwncePlus)).toFixed(3) );
					$('#thirdFilmAlwnce').attr("minVal", (parseFloat(condStepData.filmCond) - parseFloat(condStepData.filmAlwnceMinus)).toFixed(3) );
					$('#thirdFilmAlwnce').attr("maxVal", (parseFloat(condStepData.filmCond) + parseFloat(condStepData.filmAlwncePlus)).toFixed(3) );
					$('#thirdMetalDepthAlwnce').attr("minVal", (parseFloat(condStepData.metalDepthCond) - parseFloat(condStepData.metalDepthAlwnceMinus)).toFixed(3) );
					$('#thirdMetalDepthAlwnce').attr("maxVal", (parseFloat(condStepData.metalDepthCond) + parseFloat(condStepData.metalDepthAlwncePlus)).toFixed(3) );
					$('#thirdMetalThicknessAlwnce').attr("minVal", (parseFloat(condStepData.metalThicknessCond) - parseFloat(condStepData.metalThicknessAlwnceMinus)).toFixed(3) );
					$('#thirdMetalThicknessAlwnce').attr("maxVal", (parseFloat(condStepData.metalThicknessCond) + parseFloat(condStepData.metalThicknessAlwncePlus)).toFixed(3) );
					$('#thirdThCenterAlwnce').attr("minVal", (parseFloat(condStepData.thCenterCond) - parseFloat(condStepData.thCenterAlwnceMinus)).toFixed(3) );
					$('#thirdThCenterAlwnce').attr("maxVal", (parseFloat(condStepData.thCenterCond) + parseFloat(condStepData.thCenterAlwncePlus)).toFixed(3) );
					$('#thirdThEdgeAlwncePlus').attr("minVal", (parseFloat(condStepData.thEdgeCond) - parseFloat(condStepData.thEdgeAlwnceMinus)).toFixed(3) );
					$('#thirdThEdgeAlwncePlus').attr("maxVal", (parseFloat(condStepData.thEdgeCond) + parseFloat(condStepData.thEdgeAlwncePlus)).toFixed(3) );
					$('#thirdBurrMetalAlwnce').attr("minVal", (parseFloat(condStepData.burrCond) - parseFloat(condStepData.burrAlwnceMinus)).toFixed(3) );
					$('#thirdBurrMetalAlwnce').attr("maxVal", (parseFloat(condStepData.burrCond) + parseFloat(condStepData.burrAlwncePlus)).toFixed(3) );
					
   	            	//초물
	   	            if( res.firstStepData != null ){
	   	            	$('#firstStepSearch').val("success");

	   	            	//if ( firstStepData.regTime == null || firstStepData.regTime == "" ) {
						//	let Now = new Date();
						//	$('#firstRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
		   	            //} else {
							//$('#firstRegTime').val(moment(secondStepData.regDate).format('HH:mm'));
		   	            	//$('#firstRegTime').val(firstStepData.regTime);
						//}
	   	            	wpLeft1 = firstStepData.wpLeftAlwnce;
	   	            	ppLeft1 = firstStepData.ppfDepthLeftAlwnce;
						$('#firstWpLeftAlwnce').val(firstStepData.wpLeftAlwnce);
						$('#firstWpRightAlwnce').val(firstStepData.wpRightAlwnce);
						$('#firstPitchLeftAlwnce').val(firstStepData.pitchLeftAlwnce);
						$('#firstPitchRightAlwnce').val(firstStepData.pitchRightAlwnce);
						$('#firstPpfWingLeftAlwnce').val(firstStepData.ppfWingLeftAlwnce);
						$('#firstPpfWingRightAlwnce').val(firstStepData.ppfWingRightAlwnce);
						$('#firstPpfDepthLeftAlwnce').val(firstStepData.ppfDepthLeftAlwnce);
						$('#firstPpfDepthRightAlwnce').val(firstStepData.ppfDepthRightAlwnce);
						$('#firstFilmAlwnce').val(firstStepData.filmAlwnce);
						$('#firstMetalDepthAlwnce').val(firstStepData.metalDepthAlwnce);
						$('#firstMetalThicknessAlwnce').val(firstStepData.metalThicknessAlwnce);
						$('#firstThCenterAlwnce').val(firstStepData.thCenterAlwnce);
						$('#firstThEdgeAlwncePlus').val(firstStepData.thEdgeAlwncePlus);
						$('#firstInput').val(firstStepData.thStepInput);
						$('#firstBurrMetalAlwnce').val(firstStepData.burrMetalAlwnce);
						$('#firstBurrRcutAlwnce').val(firstStepData.burrRcutAlwnce);
						$('#firstBurrRedgeAlwnce').val(firstStepData.burrRedgeAlwnce);
						$('#firstBulgeLeftupHeight').val(firstStepData.bulgeLeftupHeight);
						$('#firstBulgeLeftdownHeight').val(firstStepData.bulgeLeftdownHeight);
						$('#firstBulgeRightupHeight').val(firstStepData.bulgeRightupHeight);
						$('#firstBulgeRightdownHeight').val(firstStepData.bulgeRightdownHeight);
						$('#firstBulgeLeftupWidth').val(firstStepData.bulgeLeftupWidth);
						$('#firstBulgeLeftdownWidth').val(firstStepData.bulgeLeftdownWidth);
						$('#firstBulgeRightupWidth').val(firstStepData.bulgeRightupWidth);
						$('#firstBulgeRightdownWidth').val(firstStepData.bulgeRightdownWidth);
					} else {
						$('#firstStepSearch').val("fail");
						//$('.firstStep').val('0');
						$('.firstStep').val('');
						wpLeft1 = 0;
						ppLeft1 = 0;
					}

   	            	//중물
					if( res.secondStepData != null ){
	   	            	$('#secondStepSearch').val("success");
	   	            	//if ( secondStepData.regTime == null || secondStepData.regTime == "" ) {
						//	let Now = new Date();
						//	$('#secondRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
		   	            //} else {
		   	            	//$('#secondRegTime').val(moment(secondStepData.regDate).format('HH:mm'));
		   	            	//$('#secondRegTime').val(secondStepData.regTime);
						//}
	   	            	wpLeft2 = secondStepData.wpLeftAlwnce;
	   	            	ppLeft2 = secondStepData.ppfDepthLeftAlwnce;
						$('#secondWpLeftAlwnce').val(secondStepData.wpLeftAlwnce);
						$('#secondWpRightAlwnce').val(secondStepData.wpRightAlwnce);
						$('#secondPitchLeftAlwnce').val(secondStepData.pitchLeftAlwnce);
						$('#secondPitchRightAlwnce').val(secondStepData.pitchRightAlwnce);
						$('#secondPpfWingLeftAlwnce').val(secondStepData.ppfWingLeftAlwnce);
						$('#secondPpfWingRightAlwnce').val(secondStepData.ppfWingRightAlwnce);
						$('#secondPpfDepthLeftAlwnce').val(secondStepData.ppfDepthLeftAlwnce);
						$('#secondPpfDepthRightAlwnce').val(secondStepData.ppfDepthRightAlwnce);
						$('#secondFilmAlwnce').val(secondStepData.filmAlwnce);
						$('#secondMetalDepthAlwnce').val(secondStepData.metalDepthAlwnce);
						$('#secondMetalThicknessAlwnce').val(secondStepData.metalThicknessAlwnce);
						$('#secondThCenterAlwnce').val(secondStepData.thCenterAlwnce);
						$('#secondThEdgeAlwncePlus').val(secondStepData.thEdgeAlwncePlus);
						$('#secondInput').val(secondStepData.thStepInput);
						$('#secondBurrMetalAlwnce').val(secondStepData.burrMetalAlwnce);
						$('#secondBurrRcutAlwnce').val(secondStepData.burrRcutAlwnce);
						$('#secondBurrRedgeAlwnce').val(secondStepData.burrRedgeAlwnce);
						$('#secondBulgeLeftupHeight').val(secondStepData.bulgeLeftupHeight);
						$('#secondBulgeLeftdownHeight').val(secondStepData.bulgeLeftdownHeight);
						$('#secondBulgeRightupHeight').val(secondStepData.bulgeRightupHeight);
						$('#secondBulgeRightdownHeight').val(secondStepData.bulgeRightdownHeight);
						$('#secondBulgeLeftupWidth').val(secondStepData.bulgeLeftupWidth);
						$('#secondBulgeLeftdownWidth').val(secondStepData.bulgeLeftdownWidth);
						$('#secondBulgeRightupWidth').val(secondStepData.bulgeRightupWidth);
						$('#secondBulgeRightdownWidth').val(secondStepData.bulgeRightdownWidth);
					} else {
						$('#secondStepSearch').val("fail");
						$('.secondStep').val('0');
						wpLeft2 = 0;
						ppLeft2 = 0;
					}

   	            	//종물
					if( res.thirdStepData != null ){
						$('#thirdStepSearch').val("success");
						oldOrdLotNo = thirdStepData.ordLotNo;
						//if ( thirdStepData.regTime == null || thirdStepData.regTime == "" ) {
						//	let Now = new Date();
						//	$('#thirdRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
		   	            //} else {
		   	            //	$('#thirdRegTime').val(moment(thirdStepData.regDate).format('HH:mm'));
		   	            //	//$('#thirdRegTime').val(thirdStepData.regTime);
						//}
						wpLeft3 = thirdStepData.wpLeftAlwnce;
	   	            	ppLeft3 = thirdStepData.ppfDepthLeftAlwnce;
						$('#thirdRegTime').val(thirdStepData.regTime);
						$('#thirdWpLeftAlwnce').val(thirdStepData.wpLeftAlwnce);
						$('#thirdWpRightAlwnce').val(thirdStepData.wpRightAlwnce);
						$('#thirdPitchLeftAlwnce').val(thirdStepData.pitchLeftAlwnce);
						$('#thirdPitchRightAlwnce').val(thirdStepData.pitchRightAlwnce);
						$('#thirdPpfWingLeftAlwnce').val(thirdStepData.ppfWingLeftAlwnce);
						$('#thirdPpfWingRightAlwnce').val(thirdStepData.ppfWingRightAlwnce);
						$('#thirdPpfDepthLeftAlwnce').val(thirdStepData.ppfDepthLeftAlwnce);
						$('#thirdPpfDepthRightAlwnce').val(thirdStepData.ppfDepthRightAlwnce);
						$('#thirdFilmAlwnce').val(thirdStepData.filmAlwnce);
						$('#thirdMetalDepthAlwnce').val(thirdStepData.metalDepthAlwnce);
						$('#thirdMetalThicknessAlwnce').val(thirdStepData.metalThicknessAlwnce);
						$('#thirdThCenterAlwnce').val(thirdStepData.thCenterAlwnce);
						$('#thirdThEdgeAlwncePlus').val(thirdStepData.thEdgeAlwncePlus);
						$('#thirdInput').val(thirdStepData.thStepInput);
						$('#thirdBurrMetalAlwnce').val(thirdStepData.burrMetalAlwnce);
						$('#thirdBurrRcutAlwnce').val(thirdStepData.burrRcutAlwnce);
						$('#thirdBurrRedgeAlwnce').val(thirdStepData.burrRedgeAlwnce);
						$('#thirdBulgeLeftupHeight').val(thirdStepData.bulgeLeftupHeight);
						$('#thirdBulgeLeftdownHeight').val(thirdStepData.bulgeLeftdownHeight);
						$('#thirdBulgeRightupHeight').val(thirdStepData.bulgeRightupHeight);
						$('#thirdBulgeRightdownHeight').val(thirdStepData.bulgeRightdownHeight);
						$('#thirdBulgeLeftupWidth').val(thirdStepData.bulgeLeftupWidth);
						$('#thirdBulgeLeftdownWidth').val(thirdStepData.bulgeLeftdownWidth);
						$('#thirdBulgeRightupWidth').val(thirdStepData.bulgeRightupWidth);
						$('#thirdBulgeRightdownWidth').val(thirdStepData.bulgeRightdownWidth);
					} else {
						$('#thirdStepSearch').val("fail");
						wpLeft3 = 0;
						ppLeft3 = 0;
					}

					for (var i=0; i<14; i++) {
						if ( i == 0 ){
							if ( parseFloat($('#thirdWpLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdWpLeftAlwnce').val()) && parseFloat($('#thirdWpLeftAlwnce').val()) <= parseFloat($('#thirdWpLeftAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdWpLeftAlwnce').css('color', 'black');
							} else {
								$('#thirdWpLeftAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 1 ) {
							if ( parseFloat($('#thirdWpRightAlwnce').attr("minVal")) <= parseFloat($('#thirdWpRightAlwnce').val()) && parseFloat($('#thirdWpRightAlwnce').val()) <= parseFloat($('#thirdWpRightAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdWpRightAlwnce').css('color', 'black');
							} else {
								$('#thirdWpRightAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 2 ) {
							if ( parseFloat($('#thirdPitchLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchLeftAlwnce').val()) && parseFloat($('#thirdPitchLeftAlwnce').val()) <= parseFloat($('#thirdPitchLeftAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPitchLeftAlwnce').css('color', 'black');
							} else {
								$('#thirdPitchLeftAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 3 ) {
							if ( parseFloat($('#thirdPitchRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchRightAlwnce').val()) && parseFloat($('#thirdPitchRightAlwnce').val()) <= parseFloat($('#thirdPitchRightAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPitchRightAlwnce').css('color', 'black');
							} else {
								$('#thirdPitchRightAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 4 ) {
							if ( parseFloat($('#thirdPpfWingLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingLeftAlwnce').val()) && parseFloat($('#thirdPpfWingLeftAlwnce').val()) <= parseFloat($('#thirdPpfWingLeftAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPpfWingLeftAlwnce').css('color', 'black');
							} else {
								$('#thirdPpfWingLeftAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 5 ) {
							if ( parseFloat($('#thirdPpfWingRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingRightAlwnce').val()) && parseFloat($('#thirdPpfWingRightAlwnce').val()) <= parseFloat($('#thirdPpfWingRightAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPpfWingRightAlwnce').css('color', 'black');
							} else {
								$('#thirdPpfWingRightAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 6 ) {
							if ( parseFloat($('#thirdPpfDepthLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthLeftAlwnce').val()) && parseFloat($('#thirdPpfDepthLeftAlwnce').val()) <= parseFloat($('#thirdPpfDepthLeftAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPpfDepthLeftAlwnce').css('color', 'black');
							} else {
								$('#thirdPpfDepthLeftAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 7 ) {
							if ( parseFloat($('#thirdPpfDepthRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthRightAlwnce').val()) && parseFloat($('#thirdPpfDepthRightAlwnce').val()) <= parseFloat($('#thirdPpfDepthRightAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPpfDepthRightAlwnce').css('color', 'black');
							} else {
								$('#thirdPpfDepthRightAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 8 ) {
							if ( parseFloat($('#thirdFilmAlwnce').attr("minVal")) <= parseFloat($('#thirdFilmAlwnce').val()) && parseFloat($('#thirdFilmAlwnce').val()) <= parseFloat($('#thirdFilmAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdFilmAlwnce').css('color', 'black');
							} else {
								$('#thirdFilmAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 9 ) {
							if ( parseFloat($('#thirdMetalDepthAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalDepthAlwnce').val()) && parseFloat($('#thirdMetalDepthAlwnce').val()) <= parseFloat($('#thirdMetalDepthAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdMetalDepthAlwnce').css('color', 'black');
							} else {
								$('#thirdMetalDepthAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 10 ) {
							if ( parseFloat($('#thirdMetalThicknessAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalThicknessAlwnce').val()) && parseFloat($('#thirdMetalThicknessAlwnce').val()) <= parseFloat($('#thirdMetalThicknessAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdMetalThicknessAlwnce').css('color', 'black');
							} else {
								$('#thirdMetalThicknessAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 11 ) {
							if ( parseFloat($('#thirdThCenterAlwnce').attr("minVal")) <= parseFloat($('#thirdThCenterAlwnce').val()) && parseFloat($('#thirdThCenterAlwnce').val()) <= parseFloat($('#thirdThCenterAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdThCenterAlwnce').css('color', 'black');
							} else {
								$('#thirdThCenterAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 12 ) {
							if ( parseFloat($('#thirdThEdgeAlwncePlus').attr("minVal")) <= parseFloat($('#thirdThEdgeAlwncePlus').val()) && parseFloat($('#thirdThEdgeAlwncePlus').val()) <= parseFloat($('#thirdThEdgeAlwncePlus').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdThEdgeAlwncePlus').css('color', 'black');
							} else {
								$('#thirdThEdgeAlwncePlus').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 13 ) {
							if ( parseFloat($('#thirdBurrMetalAlwnce').attr("minVal")) <= parseFloat($('#thirdBurrMetalAlwnce').val()) && parseFloat($('#thirdBurrMetalAlwnce').val()) <= parseFloat($('#thirdBurrMetalAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdBurrMetalAlwnce').css('color', 'black');
							} else {
								$('#thirdBurrMetalAlwnce').css('color', 'red');
								arr[i] = false;
							}
						}
			        }
			           	            	
   	            	//조회된 값이 없을때 평균값도 공백으로
   	            	if (res.firstStepData == null && res.secondStepData == null && res.thirdStepData == null ) {
   	            		$("#average").val("");
	   	            } else {
	   	            	average();	//초중종물의 WP(좌) PP폭(좌) 의 평균값 계산
					}

					
				} else {
					toastr.error("치수 조건을 조회오류가 발생하였습니다.", '', {timeOut: 5000});
  	        	    //$('#searchData').val("fail");
				}
   	        },
   	        complete:function(){
   	        	if ( $('#thirdStepSearch').val() == "fail" ){
       	    		viewSetData();
       			}
   	        	//$('#workOrdNoLabel').text(workOrdNo + " 종물 등록 & 수정");
   	        	$('#btnSizeCondStepEdit').attr('disabled', false);
   	        	$('#btnSizeCondStepSave').attr('disabled', true);
   	        	$('#my-spinner').hide();
			}
		});
		
   	}
	//초,중,종물 팝업 끝
	
	//초,중,종물 종물 수정 버튼
	$('#btnSizeCondStepEdit').on('click', function() {
    	if ( $('#thirdStepSearch').val() == "fail" ){
    		viewSetData();
		}
    	$('#btnSizeCondStepSave').attr('disabled', false);
    	if( $('#firstStepSearch').val() == "success"){
    		$('#firstInput').attr('disabled',false);
    	} 
    	if( $('#secondStepSearch').val() == "success"){
    		$('#secondInput').attr('disabled',false);
    	}
    	viewForm(false);
    	$('.number-').css('color', 'black');
    	btnSaveClick = false;
    	let Now = new Date();
		//if( ($('#firstRegTime').val()=="") || ($('#firstRegTime').val()==null)){
		//	$('#firstRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		//}
        //
		//if( ($('#secondRegTime').val()=="") || ($('#secondRegTime').val()==null)){
		//	$('#secondRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		//}
		if( ($('#thirdRegTime').val()=="") || ($('#thirdRegTime').val()==null)){
			$('#thirdRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		}
		$('#thirdWpLeftAlwnce').select();
    });

    
    var btnSaveClick = false;	//저장처리 클릭 여부 확인
    var arr = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];
    //초,중,종물 저장처리
    $('#btnSizeCondStepSave').on('click', function() {
        //입력값이 조건(+,-)안에 포함되는지 검사. 포함되지 않는다면 빨간색으로 표시
		for (var i=0; i<14; i++) {
			if ( i == 0 ){
				if ( parseFloat($('#thirdWpLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdWpLeftAlwnce').val()) && parseFloat($('#thirdWpLeftAlwnce').val()) <= parseFloat($('#thirdWpLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdWpLeftAlwnce').css('color', 'black');
				} else {
					$('#thirdWpLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 1 ) {
				if ( parseFloat($('#thirdWpRightAlwnce').attr("minVal")) <= parseFloat($('#thirdWpRightAlwnce').val()) && parseFloat($('#thirdWpRightAlwnce').val()) <= parseFloat($('#thirdWpRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdWpRightAlwnce').css('color', 'black');
				} else {
					$('#thirdWpRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 2 ) {
				if ( parseFloat($('#thirdPitchLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchLeftAlwnce').val()) && parseFloat($('#thirdPitchLeftAlwnce').val()) <= parseFloat($('#thirdPitchLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPitchLeftAlwnce').css('color', 'black');
				} else {
					$('#thirdPitchLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 3 ) {
				if ( parseFloat($('#thirdPitchRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchRightAlwnce').val()) && parseFloat($('#thirdPitchRightAlwnce').val()) <= parseFloat($('#thirdPitchRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPitchRightAlwnce').css('color', 'black');
				} else {
					$('#thirdPitchRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 4 ) {
				if ( parseFloat($('#thirdPpfWingLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingLeftAlwnce').val()) && parseFloat($('#thirdPpfWingLeftAlwnce').val()) <= parseFloat($('#thirdPpfWingLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPpfWingLeftAlwnce').css('color', 'black');
				} else {
					$('#thirdPpfWingLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 5 ) {
				if ( parseFloat($('#thirdPpfWingRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingRightAlwnce').val()) && parseFloat($('#thirdPpfWingRightAlwnce').val()) <= parseFloat($('#thirdPpfWingRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPpfWingRightAlwnce').css('color', 'black');
				} else {
					$('#thirdPpfWingRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 6 ) {
				if ( parseFloat($('#thirdPpfDepthLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthLeftAlwnce').val()) && parseFloat($('#thirdPpfDepthLeftAlwnce').val()) <= parseFloat($('#thirdPpfDepthLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPpfDepthLeftAlwnce').css('color', 'black');
				} else {
					$('#thirdPpfDepthLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 7 ) {
				if ( parseFloat($('#thirdPpfDepthRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthRightAlwnce').val()) && parseFloat($('#thirdPpfDepthRightAlwnce').val()) <= parseFloat($('#thirdPpfDepthRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPpfDepthRightAlwnce').css('color', 'black');
				} else {
					$('#thirdPpfDepthRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 8 ) {
				if ( parseFloat($('#thirdFilmAlwnce').attr("minVal")) <= parseFloat($('#thirdFilmAlwnce').val()) && parseFloat($('#thirdFilmAlwnce').val()) <= parseFloat($('#thirdFilmAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdFilmAlwnce').css('color', 'black');
				} else {
					$('#thirdFilmAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 9 ) {
				if ( parseFloat($('#thirdMetalDepthAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalDepthAlwnce').val()) && parseFloat($('#thirdMetalDepthAlwnce').val()) <= parseFloat($('#thirdMetalDepthAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdMetalDepthAlwnce').css('color', 'black');
				} else {
					$('#thirdMetalDepthAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 10 ) {
				if ( parseFloat($('#thirdMetalThicknessAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalThicknessAlwnce').val()) && parseFloat($('#thirdMetalThicknessAlwnce').val()) <= parseFloat($('#thirdMetalThicknessAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdMetalThicknessAlwnce').css('color', 'black');
				} else {
					$('#thirdMetalThicknessAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 11 ) {
				if ( parseFloat($('#thirdThCenterAlwnce').attr("minVal")) <= parseFloat($('#thirdThCenterAlwnce').val()) && parseFloat($('#thirdThCenterAlwnce').val()) <= parseFloat($('#thirdThCenterAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdThCenterAlwnce').css('color', 'black');
				} else {
					$('#thirdThCenterAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 12 ) {
				if ( parseFloat($('#thirdThEdgeAlwncePlus').attr("minVal")) <= parseFloat($('#thirdThEdgeAlwncePlus').val()) && parseFloat($('#thirdThEdgeAlwncePlus').val()) <= parseFloat($('#thirdThEdgeAlwncePlus').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdThEdgeAlwncePlus').css('color', 'black');
				} else {
					$('#thirdThEdgeAlwncePlus').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 13 ) {
				if ( parseFloat($('#thirdBurrMetalAlwnce').attr("minVal")) <= parseFloat($('#thirdBurrMetalAlwnce').val()) && parseFloat($('#thirdBurrMetalAlwnce').val()) <= parseFloat($('#thirdBurrMetalAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdBurrMetalAlwnce').css('color', 'black');
				} else {
					$('#thirdBurrMetalAlwnce').css('color', 'red');
					arr[i] = false;
				}
			}
        }

        //범위가 벗어난 곳이 있는지 확인 후 안내메세지 출력
        var j = 0;	//조건범위 이탈 수량
		for ( var i=0; i<14; i++) {
			if ( arr[i] == false ) {
				j++;
			}
		}

        //범위가 벗어난곳이 없고, 저장버튼을 처음누르는 것이면 저장처리
		if (j != 0 && btnSaveClick == false) {
			toastr.warning("조건을 벗어난 부분이 " + j + "군데 있습니다. 확인해 주세요!", '', {timeOut: 5000});
			btnSaveClick = true;
		} else {
			
			$('#my-spinner').show();
			
			let url = null;
			if( $('#thirdStepSearch').val() == "fail" ) {
				url = '<c:url value="/po/insertWorkOrderStepData"/>';
	    	} else if( $('#thirdStepSearch').val() == "success" ) {
	        	url = '<c:url value="/po/updateWorkOrderStepData"/>';
	    	}
	    	$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 				: 		menuAuth,
	   	        	'workOrdNo'					: 		function() { return workOrdNo; },
	   	        	'ordLotNo'					: 		function() { return ordLotNo; },
	   	        	'oldOrdLotNo'				:	 	function() { return oldOrdLotNo; },
	   	        	'lotNo'						: 		function() { return lotNo; },
	   	        	'firstStepSearch'			: 		function() { return $('#firstStepSearch').val(); },
	   	        	'secondStepSearch'			: 		function() { return $('#secondStepSearch').val(); },
	   	        	//'firstRegTime'				: $('#firstRegTime').val(),
		   	        //'firstWpLeftAlwnce'			: $('#firstWpLeftAlwnce').val(),
	   	    		//'firstWpRightAlwnce'		: $('#firstWpRightAlwnce').val(),
		    		//'firstPitchLeftAlwnce'		: $('#firstPitchLeftAlwnce').val(),
		    		//'firstPitchRightAlwnce'		: $('#firstPitchRightAlwnce').val(),
	    			//'firstPpfWingLeftAlwnce'	: $('#firstPpfWingLeftAlwnce').val(),
		    		//'firstPpfWingRightAlwnce'	: $('#firstPpfWingRightAlwnce').val(),
	    			//'firstPpfDepthLeftAlwnce'	: $('#firstPpfDepthLeftAlwnce').val(),
		    		//'firstPpfDepthRightAlwnce'	: $('#firstPpfDepthRightAlwnce').val(),
	    			//'firstFilmAlwnce'			: $('#firstFilmAlwnce').val(),
		    		//'firstMetalDepthAlwnce'		: $('#firstMetalDepthAlwnce').val(),
	    			//'firstMetalThicknessAlwnce'	: $('#firstMetalThicknessAlwnce').val(),
		    		//'firstThCenterAlwnce'		: $('#firstThCenterAlwnce').val(),
	    			//'firstThEdgeAlwncePlus'		: $('#firstThEdgeAlwncePlus').val(),
	    			'firstThStepInput'			: $('#firstInput').val(),
		    		//'firstBurrMetalAlwnce'		: $('#firstBurrMetalAlwnce').val(),
		    		//'firstBurrRcutAlwnce'		: $('#firstBurrRcutAlwnce').val(),
		    		//'firstBurrRedgeAlwnce'		: $('#firstBurrRedgeAlwnce').val(),
		    		//'firstBulgeLeftupHeight'	: $('#firstBulgeLeftupHeight').val(),
		    		//'firstBulgeLeftdownHeight'	: $('#firstBulgeLeftdownHeight').val(),
		    		//'firstBulgeRightupHeight'	: $('#firstBulgeRightupHeight').val(),
		    		//'firstBulgeRightdownHeight'	: $('#firstBulgeRightdownHeight').val(),
		    		//'firstBulgeLeftupWidth'		: $('#firstBulgeLeftupWidth').val(),
		    		//'firstBulgeLeftdownWidth'	: $('#firstBulgeLeftdownWidth').val(),
		    		//'firstBulgeRightupWidth'	: $('#firstBulgeRightupWidth').val(),
		    		//'firstBulgeRightdownWidth'	: $('#firstBulgeRightdownWidth').val(),
	                //
		    		//'secondRegTime'				: $('#secondRegTime').val(),
					//'secondWpLeftAlwnce'		: $('#secondWpLeftAlwnce').val(),
		    		//'secondWpRightAlwnce'		: $('#secondWpRightAlwnce').val(),
					//'secondPitchLeftAlwnce'		: $('#secondPitchLeftAlwnce').val(),
		    		//'secondPitchRightAlwnce'	: $('#secondPitchRightAlwnce').val(),
					//'secondPpfWingLeftAlwnce'	: $('#secondPpfWingLeftAlwnce').val(),
		    		//'secondPpfWingRightAlwnce'	: $('#secondPpfWingRightAlwnce').val(),
					//'secondPpfDepthLeftAlwnce'	: $('#secondPpfDepthLeftAlwnce').val(),
		    		//'secondPpfDepthRightAlwnce'	: $('#secondPpfDepthRightAlwnce').val(),
					//'secondFilmAlwnce'			: $('#secondFilmAlwnce').val(),
		    		//'secondMetalDepthAlwnce'	: $('#secondMetalDepthAlwnce').val(),
		    		//'secondMetalThicknessAlwnce': $('#secondMetalThicknessAlwnce').val(),
		    		//'secondThCenterAlwnce'		: $('#secondThCenterAlwnce').val(),
					//'secondThEdgeAlwncePlus'	: $('#secondThEdgeAlwncePlus').val(),
					'secondThStepInput'			: $('#secondInput').val(),
		    		//'secondBurrMetalAlwnce'		: $('#secondBurrMetalAlwnce').val(),
					//'secondBurrRcutAlwnce'		: $('#secondBurrRcutAlwnce').val(),
		    		//'secondBurrRedgeAlwnce'		: $('#secondBurrRedgeAlwnce').val(),
		    		//'secondBulgeLeftupHeight'	: $('#secondBulgeLeftupHeight').val(),
		    		//'secondBulgeLeftdownHeight'	: $('#secondBulgeLeftdownHeight').val(),
		    		//'secondBulgeRightupHeight'	: $('#secondBulgeRightupHeight').val(),
		    		//'secondBulgeRightdownHeight': $('#secondBulgeRightdownHeight').val(),
		    		//'secondBulgeLeftupWidth'	: $('#secondBulgeLeftupWidth').val(),
		    		//'secondBulgeLeftdownWidth'	: $('#secondBulgeLeftdownWidth').val(),
		    		//'secondBulgeRightupWidth'	: $('#secondBulgeRightupWidth').val(),
		    		//'secondBulgeRightdownWidth'	: $('#secondBulgeRightdownWidth').val(),
	        		
		    		'thirdRegTime'				: $('#thirdRegTime').val(),
					'thirdWpLeftAlwnce'			: $('#thirdWpLeftAlwnce').val(),
		    		'thirdWpRightAlwnce'		: $('#thirdWpRightAlwnce').val(),
					'thirdPitchLeftAlwnce'		: $('#thirdPitchLeftAlwnce').val(),
		    		'thirdPitchRightAlwnce'		: $('#thirdPitchRightAlwnce').val(),
					'thirdPpfWingLeftAlwnce'	: $('#thirdPpfWingLeftAlwnce').val(),
		    		'thirdPpfWingRightAlwnce'	: $('#thirdPpfWingRightAlwnce').val(),
		    		'thirdPpfDepthLeftAlwnce'	: $('#thirdPpfDepthLeftAlwnce').val(),
		    		'thirdPpfDepthRightAlwnce'	: $('#thirdPpfDepthRightAlwnce').val(),
					'thirdFilmAlwnce'			: $('#thirdFilmAlwnce').val(),
		    		'thirdMetalDepthAlwnce'		: $('#thirdMetalDepthAlwnce').val(),
					'thirdMetalThicknessAlwnce'	: $('#thirdMetalThicknessAlwnce').val(),
		    		'thirdThCenterAlwnce'		: $('#thirdThCenterAlwnce').val(),
					'thirdThEdgeAlwncePlus'		: $('#thirdThEdgeAlwncePlus').val(),
					'thirdThStepInput'          : $('#thirdInput').val(),
		    		'thirdBurrMetalAlwnce'		: $('#thirdBurrMetalAlwnce').val(),
					'thirdBurrRcutAlwnce'		: $('#thirdBurrRcutAlwnce').val(),
		    		'thirdBurrRedgeAlwnce'		: $('#thirdBurrRedgeAlwnce').val(),
		    		'thirdBulgeLeftupHeight'	: $('#thirdBulgeLeftupHeight').val(),
		    		'thirdBulgeLeftdownHeight'	: $('#thirdBulgeLeftdownHeight').val(),
		    		'thirdBulgeRightupHeight'	: $('#thirdBulgeRightupHeight').val(),
		    		'thirdBulgeRightdownHeight'	: $('#thirdBulgeRightdownHeight').val(),
		    		'thirdBulgeLeftupWidth'		: $('#thirdBulgeLeftupWidth').val(),
		    		'thirdBulgeLeftdownWidth'	: $('#thirdBulgeLeftdownWidth').val(),
		    		'thirdBulgeRightupWidth'	: $('#thirdBulgeRightupWidth').val(),
		    		'thirdBulgeRightdownWidth'	: $('#thirdBulgeRightdownWidth').val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
						if( $('#thirdStepSearch').val() == "fail" ){
							toastr.success("저장 되었습니다.");
	   	            		$('#thirdStepSearch').val("success");
		   	      		} else if( $('#thirdStepSearch').val() == "success" ){
		   	        		toastr.success("수정 되었습니다.");
		   	      		}
						//저장*수정 시 평균값 계산
						wpLeft1 = $('#firstWpLeftAlwnce').val();
						wpLeft2 = $('#secondWpLeftAlwnce').val();
						wpLeft3 = $('#thirdWpLeftAlwnce').val();
						ppLeft1 = $('#firstPpfDepthLeftAlwnce').val();
						ppLeft2 = $('#secondPpfDepthLeftAlwnce').val();
						ppLeft3 = $('#thirdPpfDepthLeftAlwnce').val();

						average();
					} else if (res.result == 'fail') {
	   	            	toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
	   	            	toastr.error(res.message, '', {timeOut: 5000});
	   	            }
	   	        },
	   	        complete:function(){
	   	        	viewForm(true);
	   	        	$("#btnSizeCondStepSave").attr("disabled",true);
	   	        	$('#firstInput').attr('disabled',true);
	   	     		$('#secondInput').attr('disabled',true);
	   	        	$('#my-spinner').hide();
	   	        }
	   	    });
		}
    });

    $("#thirdWpLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdWpRightAlwnce").select();
		}
	});

	$("#thirdWpRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPitchLeftAlwnce").select();
		}
	});

	$("#thirdPitchLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPitchRightAlwnce").select();
		}
	});

	$("#thirdPitchRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfWingLeftAlwnce").select();
		}
	});

	$("#thirdPpfWingLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfWingRightAlwnce").select();
		}
	});

	$("#thirdPpfWingRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfDepthLeftAlwnce").select();
		}
	});

	$("#thirdPpfDepthLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfDepthRightAlwnce").select();
		}
	});

	$("#thirdPpfDepthRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdFilmAlwnce").select();
		}
	});

	$("#thirdFilmAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdMetalDepthAlwnce").select();
		}
	});

	$("#thirdMetalDepthAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdMetalThicknessAlwnce").select();
		}
	});

	$("#thirdMetalThicknessAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdThCenterAlwnce").select();
		}
	});

	$("#thirdThCenterAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdThEdgeAlwncePlus").select();
		}
	});

	$("#thirdThEdgeAlwncePlus").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrMetalAlwnce").select();
		}
	});
	
	$("#thirdBurrMetalAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrRcutAlwnce").select();
		}
	});

	$("#thirdBurrRcutAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrRedgeAlwnce").select();
		}
	});

	$("#thirdBurrRedgeAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeLeftupHeight").select();
		}
	});

	$("#thirdBulgeLeftupHeight").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeLeftupWidth").select();
		}
	});

	$("#thirdBulgeLeftupWidth").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeLeftdownHeight").select();
		}
	});

	$("#thirdBulgeLeftdownHeight").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeLeftdownWidth").select();
		}
	});

	$("#thirdBulgeLeftdownWidth").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeRightupHeight").select();
		}
	});

	$("#thirdBulgeRightupHeight").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeRightupWidth").select();
		}
	});

	$("#thirdBulgeRightupWidth").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeRightdownHeight").select();
		}
	});

	$("#thirdBulgeRightdownHeight").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeRightdownWidth").select();
		}
	});

	$("#thirdBulgeRightdownWidth").keypress(function (e) {
		if (e.which == 13){
			$("#btnSizeCondStepSave").focus();
		}
	});
	

    //새로 등록시 값 0세팅
    function viewSetData()	{
    	//$(".number-float1, .number-").val("0");
    	//$(".step-number-float3").val("0");
    	$(".thridStep").val("0");
    }
    
	//평균 구하기
	function average()	{
		var tempDivsion = 0;
		if ($('#firstStepSearch').val() == "success") {
			//읽어왔어도 값이 0이면 계산식에서 제외
			if (parseFloat(wpLeft1) != 0 && parseFloat(ppLeft1) != 0) {
				tempDivsion += 1;
			}
		} else if ($('#firstStepSearch').val() == "fail") {
			wpLeft1 = 0;
			ppLeft1 = 0;
		}
		if ($('#secondStepSearch').val() == "success") {
			if (parseFloat(wpLeft2) != 0 && parseFloat(ppLeft2) != 0) {
				tempDivsion += 1;
			}
		} else if ($('#firstStepSearch').val() == "fail") {
			wpLeft2 = 0;
			ppLeft2 = 0;
		}
		if ($('#thirdStepSearch').val() == "success") {
			if (parseFloat(wpLeft3) != 0 && parseFloat(ppLeft3) != 0) {
				tempDivsion += 1;
			}
		} else if ($('#firstStepSearch').val() == "fail") {
			wpLeft3 = 0;
			ppLeft3 = 0;
		}
		var temp = ((parseFloat(wpLeft1) + parseFloat(wpLeft2) + parseFloat(wpLeft3) + parseFloat(ppLeft1) + parseFloat(ppLeft2) + parseFloat(ppLeft3)) / tempDivsion ).toFixed(1);
		$("#average").val(temp);
	}

	//종물 치수입력 키보드
	var stepTagId = "";
	var stepTemp = "";
	$('.step_num_only').focusout(function() {
		stepTagId = $(this).attr('id');
	});

	$('#stepNumber0').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();		
		if (stepTemp == "0"){
			$('#'+stepTagId).val("0");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("0"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber1').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("1");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("1"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber2').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("2");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("2"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber3').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("3");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("3"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber4').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("4");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("4"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber5').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("5");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("5"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber6').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("6");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("6"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber7').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("7");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("7"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber8').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("8");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("8"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber9').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("9");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("9"));
		}
		stepNumberFloat3();
	});
	$('#stepDot').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("0.");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("."));
		}
		stepNumberFloat3();
	});

	//백스페이스
	$('#stepBackSpace').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		stepTemp = stepTemp.slice(0,-1); //문자
		$('#'+stepTagId).val(stepTemp);
		stepNumberFloat3();
	});

	$('.step_num_only').on('click', function() {
		$(this).select();
	});
	
	//엔터
	$('#stepEnter').on('click', function () {
		//해당아이디 엔터 강제이벤트로 가기
		if (stepTagId == "thirdWpLeftAlwnce"){
			$('#thirdWpRightAlwnce').select();
		} else 	if (stepTagId == "thirdWpRightAlwnce"){
			$('#thirdPitchLeftAlwnce').select();
		} else 	if (stepTagId == "thirdPitchLeftAlwnce"){
			$('#thirdPitchRightAlwnce').select();
		} else 	if (stepTagId == "thirdPitchRightAlwnce"){
			$('#thirdPpfWingLeftAlwnce').select();
		} else 	if (stepTagId == "thirdPpfWingLeftAlwnce"){
			$('#thirdPpfWingRightAlwnce').select();
		} else 	if (stepTagId == "thirdPpfWingRightAlwnce"){
			$('#thirdPpfDepthLeftAlwnce').select();
		} else 	if (stepTagId == "thirdPpfDepthLeftAlwnce"){
			$('#thirdPpfDepthRightAlwnce').select();
		} else 	if (stepTagId == "thirdPpfDepthRightAlwnce"){
			$('#thirdFilmAlwnce').select();
		} else 	if (stepTagId == "thirdFilmAlwnce"){
			$('#thirdMetalDepthAlwnce').select();
		} else 	if (stepTagId == "thirdMetalDepthAlwnce"){
			$('#thirdMetalThicknessAlwnce').select();
		} else 	if (stepTagId == "thirdMetalThicknessAlwnce"){
			$('#thirdThCenterAlwnce').select();
		} else 	if (stepTagId == "thirdThCenterAlwnce"){
			$('#thirdThEdgeAlwncePlus').select();
		} else 	if (stepTagId == "thirdThEdgeAlwncePlus"){
			$('#thirdBurrMetalAlwnce').select();
		} else 	if (stepTagId == "thirdBurrMetalAlwnce"){
			$('#thirdBurrRcutAlwnce').select();
		} else 	if (stepTagId == "thirdBurrRcutAlwnce"){
			$('#thirdBurrRedgeAlwnce').select();
		} else 	if (stepTagId == "thirdBurrRedgeAlwnce"){
			$('#thirdBulgeLeftupHeight').select();
		} else 	if (stepTagId == "thirdBulgeLeftupHeight"){
			$('#thirdBulgeLeftupWidth').select();
		} else 	if (stepTagId == "thirdBulgeLeftupWidth"){
			$('#thirdBulgeLeftdownHeight').select();
		} else 	if (stepTagId == "thirdBulgeLeftdownHeight"){
			$('#thirdBulgeLeftdownWidth').select();
		} else 	if (stepTagId == "thirdBulgeLeftdownWidth"){
			$('#thirdBulgeRightupHeight').select();
		} else 	if (stepTagId == "thirdBulgeRightupHeight"){
			$('#thirdBulgeRightupWidth').select();
		} else 	if (stepTagId == "thirdBulgeRightupWidth"){
			$('#thirdBulgeRightdownHeight').select();
		} else 	if (stepTagId == "thirdBulgeRightdownHeight"){
			$('#thirdBulgeRightdownWidth').select();
		} else 	if (stepTagId == "thirdBulgeRightdownWidth"){
			$('#btnSizeCondStepSave').focus();
		}
		
		//$(".num_only").trigger("keyup");
	});

	function stepNumberFloat3(){
		//if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
		//	$('.number-').on("blur keyup", function() {
		//		$('#'+stepTagId).val( $('#'+stepTagId).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		//	});
		//	toastr.warning('양수(+)만 입력해주세요.');
		//	event.preventDefault();
		//	$('#'+stepTagId).val("0");
 		//	$('#'+stepTagId).select();
		//	return false;
		//}
		console.log($('#'+stepTagId).val());
 		if ($('#'+stepTagId).val() == "00" || $('#'+stepTagId).val() == "") {
			$('#'+stepTagId).val("0");
			$('#'+stepTagId).select();
			return false;
		}
 		if ($('#'+stepTagId).attr("maxlength") < $('#'+stepTagId).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$('#'+stepTagId).val("0");
 			$('#'+stepTagId).select();
			return false;
		}
 		if ( parseFloat($('#'+stepTagId).attr("max")) < parseFloat($('#'+stepTagId).val())) {
			toastr.warning('최대 크기를 초과하였습니다.');
			$('#'+stepTagId).val("0");
 			$('#'+stepTagId).select();
			return false;
		}
 		if ( parseFloat($('#'+stepTagId).attr("min")) > parseFloat($('#'+stepTagId).val())) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$('#'+stepTagId).val("0");
 			$('#'+stepTagId).select();
			return false;
		}
		// .개수 세기
		if ( $('#'+stepTagId).val().split('.').length > 2  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$('#'+stepTagId).val("0");
			$('#'+stepTagId).select();
			return false;
		}
		//소수점 자리수 제한
 		var _pattern3 = /^\d*[.]\d{4}$/;	//누르고있는 키는 예외처리 안됨
        if (_pattern3.test( $('#'+stepTagId).val())) {
        	toastr.warning("소수점 셋째 자리까지 입력 가능합니다.");
        	$('#'+stepTagId).val("0");
 			$('#'+stepTagId).select();
            return false;
		}
	}
	
	//숫자만 입력, 길이, 소수점 세자리까지 제한
	//$('.step-number-float3').keyup(function (event) {
 	//	
	//});
	
	$('#btnCloseCheck').on('click', function(){
		$('#closePopupModal').modal('hide');
		{
			$("#left-list").animate({
				width : "99%"
			}, 0);
			$("#myrSidenav").animate({
				width : "0%"
			}, 0, function(){
				$('#arrowLeft').css('display', 'block');
			});
		}
	});
		
	//rightList 닫기 버튼
	$('#rightCardClose').on('click', function(){
		if( sideView == 'add' || sideView == 'edit' ){
			$('#closePopupModal').modal('show');
			return false;
		}
  	  	$("#left-list").animate({
			width : "99%"
		}, 200);
		$("#myrSidenav").animate({
			width : "0%"
		}, 200, function(){
			$('#arrowLeft').css('display', 'block');
		});
	});

	$('#arrowLeft').on('click', function(){
  	  	$("#left-list").animate({
			width : "50%"
		}, 200);
		$("#myrSidenav").animate({
			width : "49%"
		}, 200, function(){
			$('#arrowLeft').css('display', 'none');
		});
	});

	function getDateType(date) {
		return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
	}
	
	//function appearUpdate() {
	//	//작업지시에 외관검사 Update
   	//	$.ajax({
    //   		url: '<c:url value="qm/appearWorkOrderInsert"/>',
	//		type: 'POST',
	//		data: {
	//			'menuAuth'	 			: 	menuAuth,
	//			'ordLotNo'				:	$('#ordLotNo').val(),			//작지번호스캔(작업지시)
	//			'appearInspctCharger'	:	$('#userNumber').val(),			//검사담당(사번코드)
	//			'appearInspctDate'		:	$('#appearInspctDate').val().replace(/-/g,""),	
	//			'appearOutputCnt'		:	parseInt($('#edgeOutputCnt').val() - sum),		//외관 양품 개수				
	//			'appearFaultyCnt'		:	function(){return sum},	//외관 총 불량 개수
	//		},
	//		success: function (res) {
	//			let appearFaultyCnt = res.data;
	//			$('#appearInspctDate').attr('disabled',true);
	//			if( res.result == 'ok' ){
	//				if(searchData == true) {
	//					toastr.success("외관검사 불량 수정 되었습니다.");
	//				}
	//				else if(searchData == false){
	//					toastr.success("외관검사 불량 저장 되었습니다. 종물을 등록해 주세요!");
	//				}
	//				$('#appearFaultyCnt').val(addCommas(appearFaultyCnt));
	//			} else if ( res.result == 'fail' ){
	//				toastr.error(res.message, '', {timeOut: 5000});
	//			}
	//		},
	//		complete:function(){
	//			$('#goodsFaultyAdmTable').DataTable().ajax.reload();
	//			viewDisabled(true);
	//			$('#searchUser').attr("disabled", true);
	//			$('#btnSave').attr("disabled", true);
	//			$('#btnSizeCondStep').attr("disabled", false);
	//			$("#btnSizeCondStep").focus();
	//		}
	//	});
	//}

	$('#tab1').click(function(){	
		$('#metalFaultyDiv').removeClass("d-none");
		$('#filmFaultyDiv').addClass("d-none");
		$('#etcVisionMetalFaultyDiv').addClass("d-none");
		$('#etcVisionFilmFaultyDiv').addClass("d-none");
		
		$('#etcFaultyDiv').addClass("d-none");
	});
	
	$('#tab2').click(function(){
		$('#metalFaultyDiv').addClass("d-none");
		$('#filmFaultyDiv').removeClass("d-none");
		$('#etcVisionMetalFaultyDiv').addClass("d-none");
		$('#etcVisionFilmFaultyDiv').addClass("d-none");
		
		$('#etcFaultyDiv').addClass("d-none");
	});
	
	$('#tab3').click(function(){
		$('#metalFaultyDiv').addClass("d-none");
		$('#filmFaultyDiv').addClass("d-none");
		$('#etcVisionMetalFaultyDiv').removeClass("d-none");
		$('#etcVisionFilmFaultyDiv').addClass("d-none");

		
		$('#etcFaultyDiv').removeClass("d-none");
	});

	$('#tab4').click(function(){
		$('#metalFaultyDiv').addClass("d-none");
		$('#filmFaultyDiv').addClass("d-none");
		$('#etcVisionMetalFaultyDiv').addClass("d-none");
		$('#etcVisionFilmFaultyDiv').removeClass("d-none");
		
		$('#etcFaultyDiv').removeClass("d-none");
	});

	function metalFaultyHdCreate(){   			
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '001'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metal'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="metalCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;

           
		$('#metalFaultyTbody').html(Hd_metal); 	
	}

	function filmFaultyHdCreate(){   			
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '002'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="film'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="filmCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;

           
		$('#filmFaultyTbody').html(Hd_metal); 	
	}

	function etcVisionMetalFaultyHdCreate(){   			
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '004'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="film'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="filmCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;

           
		$('#etcVisionMetalFaultyTbody').html(Hd_metal); 	
	}

	function etcVisionFilmFaultyHdCreate(){   			
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '005'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="film'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="filmCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;

           
		$('#etcVisionFilmFaultyTbody').html(Hd_metal); 	
	}
	
	function etcFaultyHdCreate(){   			
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '003'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etc'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="etcCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;

           
		$('#etcFaultyTbody').html(Hd_metal); 	
	}
	function numberPad(n, width) {
	    n = n + '';
	    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}
	
</script>
</body>
</html>