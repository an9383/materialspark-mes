<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%	pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">수입검사현황</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 99%; overflow: hidden;">
				<div class="card">
					<div class="row" style="margin-bottom: 10px;">
					&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">수입검사 기간</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="chooseDateFrom" />
							<button	onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="chooseDateTo" />
							<button	onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>							
						</div>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
						<div style="margin-left: 10px;">
							<!-- <button type='button' class='btn btn-success' id='btnFakeExcel' disabled>엑셀 다운</button> -->
						</div>
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">자재명</label><select  class="custom-select" id="matrlCd" style="min-width:100px;"></select>
						
						<div class="form-group ml-2">
							<a id="fpHref">
								<span style="font-size: 14px;" id="fpFn">첨부파일이 없습니다.</span>
							</a>
						</div>
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">검색 : </label>
						<input type="search" class="form-control form-control-sm search" onsearch="textSearch($(this).val())">
					</div>
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">자재</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">원자재</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">가공원자재</a></li>
						</ul>
					</div>
					<br>
					<!-- 자재 -->
					<div id="inspectionView001">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="inspectionListTable001" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="3" class="text-center" style="min-width:70px;">상세보기</th>
										<th rowspan="3" class="text-center" style="min-width:90px;">수입검사일</th>
										<th rowspan="3" class="text-center" style="min-width:60px;">자재코드</th>
										<th rowspan="3" class="text-center" style="min-width:170px;">자재명</th>
										<th rowspan="3" class="text-center" style="min-width:160px;">LOT_NO</th>
										<th rowspan="3" class="text-center" style="min-width:60px;">합격여부</th>
										<th rowspan="3" class="text-center" style="min-width:60px;">가입고량</th>
										<th rowspan="3" class="text-center" style="min-width:60px;">입고량</th>
										<th rowspan="3" class="text-center" style="min-width:60px;">차이</th>
										<th rowspan="3" class="text-center" style="min-width:80px;">입고일</th>
										<th rowspan="3" class="text-center" style="min-width:60px;">자재상태</th>
										<th rowspan="3" class="text-center" style="min-width:60px;">승인상태</th>
										<th rowspan="3" class="text-center" style="min-width:80px;">불량일</th>
										<th rowspan="3" class="text-center" style="min-width:60px;">불량유형</th>
										<th rowspan="3" class="text-center" style="min-width:80px;">재검일</th>
										<th colspan="1" class="text-center" style="min-width:60px;" id="matrlHeaderCols001">외관</th>								
										<th colspan="8" class="text-center" style="min-width:60px;" id="matrlHeaderCols011">비고</th>
										<th colspan="3" class="text-center" style="min-width:60px;">치수(평균값)</th>
										<th colspan="5" class="text-center" style="min-width:60px;">면취<!-- (평균값) --></th>
										<th rowspan="3" class="text-center" style="min-width:60px;">내절강도<br>(평균값)</th>
										<th rowspan="3" class="text-center" style="min-width:90px;">공급업체</th>
										<th rowspan="3" class="text-center" style="min-width:70px;">가입고일</th>
										<th rowspan="1" colspan="15" class="text-center" style="min-width:70px;">시편별 측정값</th>
										<th rowspan="1" colspan="10" class="text-center" style="min-width:70px;">내절강도 시편별 측정값</th>	
										<th rowspan="1" colspan="10" class="text-center" style="min-width:70px;">비고</th>	
										
									</tr>
									<tr  id="matrlHeader001" name="matrlHeader001">
										<!-- <th rowspan="2" class="text-center" style="min-width:60px;">Scarch</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">변색</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">이물</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">도금박리</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">권취</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">도금<br>밀착성</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">젖음성</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">자재<br>관리항목1</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">-자재<br>관리항목2</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">두께(mm)</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">폭(mm)</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">Burr(mm)</th>
										<th colspan="2" class="text-center" style="min-width:50px;">폭(µm)</th>
										<th rowspan="2" class="text-center" style="min-width:50px;">T두께(µm)</th>
										<th rowspan="2" class="text-center" style="min-width:50px; border-right:solid #d6d8e1 1px; width: 10px;">ET두께(µm)</th>
										<th rowspan="2" class="text-center" style="min-width:60px; border-right:solid #d6d8e1 1px; width: 10px;">1</th>내절강도 시편별 측정값
										<th rowspan="2" class="text-center" style="min-width:60px;">2</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">3</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">4</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">5</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">6</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">7</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">8</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">9</th>
										<th rowspan="2" class="text-center" style="min-width:60px; border-right:solid #d6d8e1 1px; width: 10px;">10</th> -->
																												
									</tr>
									<tr>
										<th class="text-center" style="min-width:50px;">좌</th>
										<th class="text-center" style="min-width:50px;">우</th>
										<th class="text-center" style="min-width:60px;">1</th><!-- 시판별측정값 / 길이/폭/burr -->
										<th class="text-center" style="min-width:60px;">2</th>
										<th class="text-center" style="min-width:60px;">3</th>
										<th class="text-center" style="min-width:60px;">4</th>
										<th class="text-center" style="min-width:60px;">5</th>
										<th class="text-center" style="min-width:60px;">1</th>
										<th class="text-center" style="min-width:60px;">2</th>
										<th class="text-center" style="min-width:60px;">3</th>
										<th class="text-center" style="min-width:60px;">4</th>
										<th class="text-center" style="min-width:60px;">5</th>
										<th class="text-center" style="min-width:60px;">1</th>
										<th class="text-center" style="min-width:60px;">2</th>
										<th class="text-center" style="min-width:60px;">3</th>
										<th class="text-center" style="min-width:60px;">4</th>
										<th class="text-center" style="min-width:60px; border-right:solid #d6d8e1 1px; width: 10px;">5</th>
										<th class="text-center" style="min-width:60px;">두께(mm)</th>
										<th class="text-center" style="min-width:60px;">폭(mm)</th>
										<th class="text-center" style="min-width:60px;">Burr(mm)</th>
										<th class="text-center" style="min-width:60px;">폭1</th>
										<th class="text-center" style="min-width:60px;">폭2</th>
										<th class="text-center" style="min-width:60px;">T두께</th>
										<th class="text-center" style="min-width:60px;">ET두께</th>
										<th class="text-center" style="min-width:60px;">내절강도1</th>
										<th class="text-center" style="min-width:60px;">내절강도2</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>

					<!-- 원자재 -->
					<div id="inspectionView002" class="d-none">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="inspectionListTable002" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" class="text-center" style="min-width:60px;">상세보기</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">수입검사일</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">자재코드</th>
										<th rowspan="2" class="text-center" style="min-width:170px;">자재명</th>
										<th rowspan="2" class="text-center" style="min-width:160px;">LOT_NO</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">합격여부</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">가입고량</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">입고량</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">차이</th>
										<th rowspan="2" class="text-center" style="min-width:80px;">입고일</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">자재상태</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">승인상태</th>
										<th rowspan="2" class="text-center" style="min-width:80px;">불량일</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">불량유형</th>
										<th rowspan="2" class="text-center" style="min-width:80px;">재검일</th>																				
										<th colspan="6" class="text-center" style="min-width:60px;" id="matrlHeaderCols002">외관</th>										
										<th rowspan="2" class="text-center" style="min-width:90px;">공급업체</th>
										<th rowspan="2" class="text-center" style="min-width:70px;">가입고일</th>
									</tr>
									<tr id="matrlHeader002">
										<th  class="text-center" style="min-width:60px;">Scarch</th>
										<th  class="text-center" style="min-width:60px;">얼룩</th>
										<th  class="text-center" style="min-width:60px;">ROSH</th>
										<th  class="text-center" style="min-width:60px;">치수</th>
										<th  class="text-center" style="min-width:60px;">-</th>
										<th  class="text-center" style="min-width:60px; border-right:solid #d6d8e1 1px; width: 10px;">-</th>
									</tr>			
												
								</thead>
							</table>
						</div>
					</div>

					<!-- 가공원자재 -->
					<div id="inspectionView003" class="d-none">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="inspectionListTable003" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" class="text-center" style="min-width:60px;">상세보기</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">수입검사일</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">자재코드</th>
										<th rowspan="2" class="text-center" style="min-width:170px;">자재명</th>
										<th rowspan="2" class="text-center" style="min-width:160px;">LOT_NO</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">합격여부</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">가입고량</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">입고량</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">차이</th>
										<th rowspan="2" class="text-center" style="min-width:80px;">입고일</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">자재상태</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">승인상태</th>
										<th rowspan="2" class="text-center" style="min-width:80px;">불량일</th>
										<th rowspan="2" class="text-center" style="min-width:60px;">불량유형</th>
										<th rowspan="2" class="text-center" style="min-width:80px;">재검일</th>
										<th colspan="6" class="text-center" style="min-width:60px;" id="matrlHeaderCols003">외관</th>									
										<th rowspan="2" class="text-center" style="min-width:90px;">공급업체</th>
										<th rowspan="2" class="text-center" style="min-width:70px;">가입고일</th>
									</tr>
									<tr id="matrlHeader003">
										<th class="text-center" style="min-width:60px;">Scarch</th>
										<th class="text-center" style="min-width:60px;">얼룩</th>
										<th class="text-center" style="min-width:60px;">ROSH</th>
										<th class="text-center" style="min-width:60px;">치수</th>
										<th class="text-center" style="min-width:60px;">-</th>
										<th class="text-center" style="min-width:60px; border-right:solid #d6d8e1 1px; width: 10px;">-</th>
									</tr>
								
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- /.left-list -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 수입검사 자재 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="realMatrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="realMatrlPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width:1400px;">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id="realMatrlPopUpLabel">자재 수입검사</h5>
		        <h5 class="modal-title" style="margin-left: 70%;">검사일 : <label id="realMatrlDay"></label></h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
			</div>
			<div class="modal-body">
				<table id="exteriorMatrlPopUpTable" class="table table-bordered">
					<thead class="thead-light">
                    	<tr>								
							<th style="width:20%">관리항목</th>
							<th style="width:20%" colspan="3">규격</th>
							<th style="width:10%">검사결과</th>
							<th style="width:40%">비고</th>
						</tr>
					</thead>
					<tbody id="matrlTbody001">
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_1" value="Scratch" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_2" value="유해결점이 없을것" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem1_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_1" value="변색" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_2" value="변색 없을 것" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem2_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_1" value="이물" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_2" value="이물질 없을 것" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem3_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_1" value="도금박리" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_2" value="구리노출 없을 것" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem4_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_1" value="권취" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_2" value="권취기준 1mm 이내의 정렬권취" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem5_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem6_1" value="도금 밀착성" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem6_2" value="4B 이상" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem6_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem6_4" /></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem7_1" value="젖음성" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem7_2" value="물방울이 맺히지 않을 것" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem7_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem7_4" /></td>
						</tr>
						
						
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem8_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem8_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem8_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem8_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem9_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem9_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem9_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem9_4" disabled/></td>
						</tr>
					</tbody>
				</table>
				
				<table id="sizeMatrlPopUpTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>								
							<th style="width:10%;" rowspan="2">관리항목</th>
							<th style="width:30%;" colspan="5" rowspan="2">규격</th>
							<th style="width:10%;" rowspan="2"> 평균값 </th>
							<th style="width:35%;" colspan="10">시편별 측정값</th>
							<th style="width:15%;" rowspan="2">비고</th>
						</tr>
						<tr>
							<th style="width:7%;" colspan="2">1</th>
							<th style="width:7%;" colspan="2">2</th>
							<th style="width:7%;" colspan="2">3</th>
							<th style="width:7%;" colspan="2">4</th>
							<th style="width:7%;" colspan="2">5</th>
						</tr>	
					</thead>						
					<tr>							
						<td	rowspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input1_1" value="치수" disabled></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input1_2" value="두께(mm)" disabled/></td>
						<td	colspan="4" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input1_3" value="±0.015" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input1_4" disabled /></td>
						<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrl001_input1_5" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrl001_input1_6" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrl001_input1_7" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrl001_input1_8" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrl001_input1_9" value="0" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input1_10" disabled/></td>
						
					</tr>
					<tr>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input2_1" value="폭(mm)" disabled/></td>
						<td	colspan="4" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input2_2" value="±0.15" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input2_3" disabled /></td>
						<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrl001_input2_4" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrl001_input2_5" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrl001_input2_6" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrl001_input2_7" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrl001_input2_8" value="0" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input2_9" disabled/></td>
					</tr>
					<tr>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input3_1" value="Burr(mm)" disabled/></td>
						<td	colspan="4" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input3_2" value="±0.015mm ↓" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input3_3" disabled /></td>
						<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl001_input3_4" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl001_input3_5" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl001_input3_6" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl001_input3_7" value="0" disabled/></td>
						<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl001_input3_8" value="0" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input3_9" disabled/></td>
					</tr>
					<tr>
						<td	rowspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_1" value="면취" disabled></td>
						<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_2" value="두께(mm)" disabled/></td>
						<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_3" value="0.2T" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_4" value="0.3T" disabled /></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_5" value="0.4T" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_6" value="0.5T" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_7" disabled/></td>
						<td	colspan="5" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_8" value="좌" disabled/></td>
						<td	colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_9" value="우" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_10" disabled/></td>
					</tr>
					<tr>
						<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_1" value="200±100" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_2" value="300±100" disabled /></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_3" value="350±100" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_4" value="" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_5" disabled/></td>
						<td	colspan="5" ><input class="form-control number-float3 input5_float" style="max-width:100%" 	type="number" id="matrl001_input5_6" value="0" disabled/></td>
						<td	colspan="5"	><input class="form-control number-float3 input5_float" style="max-width:100%" 	type="number" id="matrl001_input5_7" value="0" disabled /></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_8" disabled/></td>
					</tr>
					<tr>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_1" value="T두께" disabled/></td>
						<td	colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_2" value="T+Max20" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_3" value="" disabled /></td>
						<td	colspan="10"><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_4" value="" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_5" value="" disabled/></td>
						
					</tr>
					<tr>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_1" value="ET두께" disabled/></td>
						<td	colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_2" value="TBD" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_3" value="" disabled /></td>
						<td	colspan="10"><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_4" value="" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_5" value="" disabled/></td>
					</tr>						
				
					<tr>
						<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_1" value="내절강도" disabled></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_2" value="" disabled/></td>
						<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_3" value="0.2T" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_4" value="0.2T(H18)" disabled /></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_5" value="0.2T(H14)" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_6" value="0.3T ↑" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_7" value="평균값" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_8" value="1" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_9" value="2" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_10" value="3" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_11" value="4" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_12" value="5" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_13" value="6" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_14" value="7" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_15" value="8" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_16" value="9" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_17" value="10" disabled/></td>												
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_18" disabled/></td>
					</tr>
					<tr>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_1" value="" disabled/></td>
						<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_2" value="7회 ↑" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_3" value="2회 ↑" disabled /></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_4" value="3회 ↑" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_5" value="6회 ↑" disabled/></td>
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_6" value="" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_7" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_8" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_9" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_10" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_11" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_12" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_13" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_14" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_15" value="0" disabled/></td>
						<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_16" value="0" disabled/></td>												
						<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_17" disabled/></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer" style="padding-top: 0px;">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 수입검사 자재 모달 종료 -->

<!-- 수입검사 원자재 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="rowMatrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="rowMatrlPopUpModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1300px;">
    <div class="modal-content">
	      <div class="modal-header" style="padding-bottom: 0px;">
	        <h5 class="modal-title" id="rowMatrlPopUpLabel">원자재 수입검사</h5>
	        <h5 class="modal-title" style="margin-left: 70%;">검사일 : <label id="rowMatrlDay"></label></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body">
	      	<hr class="text-secondary">	         
                <table id="rowMatrlPopUpTable" class="table table-bordered">
                    <thead class="thead-light text-center">
	                    <tr>
	                    	<th>순번</th> 
	                    	<th>관리항목</th> 
	                    	<th colspan="2">규격</th> 
	                    	<th>검사결과</th> 
	                    	<th>비고</th>                    	                  
	                    </tr>
                    </thead>
                    <tbody id="matrlTbody002">
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input1_1" value="1" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input1_2" value="Scratch" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%;" id="matrl002_input1_3" value="유해결점이 없을것" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl002_input1_4" style="min-width:100%" disabled></select></td>
	                    	<td><input type="text" class="form-control" style="max-width:100%"  id="matrl002_input1_5" value="" disabled/></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input2_1" value="2" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input2_2" value="얼룩" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%;" id="matrl002_input2_3" value="유해결점이 없을것" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl002_input2_4" style="min-width:100%" disabled></select></td>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input2_5" value="" disabled/></td>                     	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input3_1" value="3" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input3_2" value="ROSH" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%;" id="matrl002_input3_3" value="환경관리물질 규격에 만족할것" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl002_input3_4" style="min-width:100%" disabled></select></td>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input3_5" value="" disabled/></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td rowspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_1" value="4" disabled/></td> 
	                    	<td rowspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_2" value="치수" disabled/></td> 	                    	
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_3" value="두께(mm)" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_4" value="±0.01" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_5" value="" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_6" value="" disabled/></td> 
	                    </tr>
	                    <tr>	
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input5_1" value="폭(mm)" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input5_2" value="±0.2" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input5_3" value="" disabled/></td> 	                    	
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input5_4" value="" disabled/></td>                        	                  
                    	</tr>                    	
                    
						<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input6_1" value="5" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input6_2" value="" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%;" id="matrl002_input6_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl002_input6_4" style="min-width:100%" disabled></select></td>
	                    	<td><input type="text" class="form-control" style="max-width:100%"  id="matrl002_input6_5" value="" disabled/></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input7_1" value="6" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input7_2" value="" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%;" id="matrl002_input7_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl002_input7_4" style="min-width:100%" disabled></select></td>
	                    	<td><input type="text" class="form-control" style="max-width:100%"  id="matrl002_input7_5" value="" disabled/></td>                    	                  
                    	</tr>
                    </tbody>
				</table>
	      </div>
	     <div class="modal-footer" style="padding-top: 0px;">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- 수입검사 원자재 모달 종료 -->

<!-- 수입검사 가공원자재 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="procMatrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="procMatrlPopUpModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
	      <div class="modal-header" style="padding-bottom: 0px;">
	        <h5 class="modal-title" id="procMatrlPopUpLabel">가공원자재 수입검사</h5>
	        <h5 class="modal-title" style="margin-left: 45%;">검사일 : <label id="procMatrlDay"></label></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body">
                <table id="procMatrlPopUpTable" class="table table-bordered">
                     <thead class="thead-light text-center">
	                    <tr>
	                    	<th>순번</th> 
	                    	<th>관리항목</th> 
	                    	<th colspan="2">규격</th> 
	                    	<th>검사결과</th> 
	                    	<th>비고</th>                    	                  
	                    </tr>
                    </thead>
                    <tbody id="matrlTbody003">
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input1_1" value="1" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input1_2" value="Scratch" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl003_input1_3" value="유해결점이 없을것" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input1_4"></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input1_5" value="" /></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input2_1" value="2" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input2_2" value="얼룩" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl003_input2_3" value="유해결점이 없을것" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input2_4"></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input2_5" value="" /></td>                     	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input3_1" value="3" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input3_2" value="필름꼬임" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl003_input3_3" value="필름 꼬임 없을것" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input3_4"></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input3_5" value="" /></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_1" value="4" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_2" value="치수" disabled/></td>	                    	
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_3" value="폭(mm)" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_4" value="±0.03" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_5" value="" /></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_6" value="" /></td> 
	                    </tr>

						<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input5_1" value="5" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input5_2" value="" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl003_input5_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input5_4" disabled></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input5_5" value="" disabled/></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input6_1" value="6" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input6_2" value="" disabled/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl003_input6_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input6_4" disabled></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input6_5" value="" disabled/></td>                    	                  
                    	</tr>



                    </tbody>
				</table>
	      </div>
	      <div class="modal-footer" style="padding-top: 0px;">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- 수입검사 가공원자재 모달 종료 -->

<%@include file="../layout/bottom.jsp"%>

<script>
	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'qmsc0100';
	let currentHref = 'qmsc0100';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","수입검사현황");

	var serverDateFrom = "${serverDateFrom}";
	var serverDateTo = "${serverDateTo}";
	//var chooseDateFrom = serverDateFrom;
	//var chooseDateTo = serverDateTo;
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDateTo);
	var matrlCd = null;
	//var chooseDateFrom001 = serverDateFrom;
	//var chooseDateTo001 = serverDate;
	//var chooseDateFrom002 = serverDateFrom;
	//var chooseDateTo002 = serverDate;
	//var chooseDateFrom003 = serverDateFrom;
	//var chooseDateTo003 = serverDate;
	
	var approvalCheck=new Array(); // 승인여부
    <c:forEach items="${approvalCheck}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCheck.push(json);
    </c:forEach>
    let arrayTr1;
    let arrayTr2;
    let arrayTr3;
    let arrayRow1;
    let arrayRow2;
	let temp001 = 0;
	let temp002 = 0;
	let temp003 = 0;
	let notHiddenArray = '';	//columns 값 지정 Array
	var managementCode=new Array();	//수입검사 관리항목
    <c:forEach items="${managementCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.baseCdAbbr="${info.baseCdAbbr}";
		json.etc1="${info.etc1}";
		json.etc2="${info.etc2}";
		managementCode.push(json);

		if ('001' == "${info.etc1}") {
			temp001 += 1;
		} else if ('002' == "${info.etc1}") {
			temp002 += 1;
		} else if ('003' == "${info.etc1}") {
			temp003 += 1;
		}
		
    </c:forEach>

    var matrlCdList=new Array();	//matrlCdList
    <c:forEach items="${matrlCdList}" var="info">
		var json=new Object();
		json.baseCd="${info.matrlCd}";
		json.baseCdNm="${info.matrlNm}";
		matrlCdList.push(json);
    </c:forEach>

	//공통코드 처리 시작
    var matrlFaultyType=new Array();	//자재불량유형
    <c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
    </c:forEach>

    matrlSelectSet();
	var tapTemp = 0;
	matrlHeader001Create();

	//managementCode
	
	//자재
	$.fn.dataTable.ext.errMode = 'none';
	let inspectionListTable001 = $('#inspectionListTable001').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
//         dom: //"<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
// 		"<'row'<'col-sm-12'tr>>" +
// 		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
//     	language: lang_kor,
//         paging: true,
//         info: true,
//         ordering: true,
//         processing: true,
//         autoWidth: false,
//         scrollX : false,
//         lengthChange: true,
//         searching: true,
//         pageLength: 16,
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
//         scrollY : "56vh",
        lengthChange: false,
        scrollX: true,
        async: false,
        fixedColumns: {
            leftColumns: 5
        },

        scrollY : "53vh",
        scrollCollapse: true,
        lengthChange: false,
        //pageLength: 16,
        
        ajax: {
            url: '<c:url value="/qm/inspectionListRead"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: menuAuth,
            	'chooseDateFrom'	: function() { return $('#chooseDateFrom').val() },
	           	'chooseDateTo'		: function() { return $('#chooseDateTo').val() + ' 23:59:59.999'; },
	           	'matrlGubunCd'		: '001',
	           	'matrlCd'			: function() { return matrlCd;}
            },
        },
        columns: [
        	{
				render: function(data, type, row, meta) {
// 					var html = '<button type="button" class="btn btn-primary" onClick="inspectionSelect('+meta.row+');" style="height: 14px;"><span>보기</span></button>';
					
					var html = '<label onClick="inspectionSelect('+meta.row+');" style=" border-radius: 10%;';
						html +='border: solid 1px;';
						html +='width: 100%; height: 17px; font-size:11px;';
						html +='background-color: #346cb0; color: white;">보기</label>';
					return html;
				}
			},
        	{ data: 'regDate',
				/* render: function(data, type, row) {
					
					return data.substring(5, 10);
				} */
			},
        	{ data: 'matrlCd' },
        	{ data: 'matrlNm' },
        	{ data: 'lotNo',
				render: function(data, type, row) {
					if(data == null || data ==''){
						data = '-';
					}
					return data;
				}
			 },
        	{ data: 'inspectNm',
				 render: function(data, type, row) {
					if(data == null || data ==''){
						data = '-';
					}
					return data;
				}
			},
        	{ data: 'preInWhsQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
			{ data: 'inWhsQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
        	{ data: 'diffQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
			{ data: 'inWhsDate' ,
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
			{ data: 'statusNm' },
			{ data: 'approvalNm' },
			{ data: 'frrrdDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
             },
			{
				data: 'frrrdType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += matrlFaultyType[jj].baseCdNm + ', ';
								count++;
							}
						}
						if (count == 0) {
							faultyTypeNm = '-';
						} else {
							faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
						}
					} else {
						faultyTypeNm = '';
					}
					return faultyTypeNm;
				}
            },
			{ data: 'retestDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },			
            <c:forEach var="item" begin="1" end="45" step="1">
            	{ data: 'outInspectItem${item}' ,
	                render: function(data, type, row) {
	                	return (data != 'null') ? data : '';
	                } 
	            },
	            
            </c:forEach>
            <c:forEach var="item" begin="1" end="9" step="1">
	            { data: 'insepctEtc00${item}' ,
		                render: function(data, type, row) {
		                	return (data != 'null') ? data : '';
		                } 
		            },
		            
            </c:forEach>
            <c:forEach var="item" begin="10" end="45" step="1">
	            { data: 'insepctEtc0${item}' ,
	                render: function(data, type, row) {
	                	return (data != 'null') ? data : '';
	                } 
	            },
	            
            </c:forEach>
			/* 비고란  */
			
			{ data: 'inspectItem13',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[3];
				}
			},
			{ data: 'inspectItem14',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[2];
				}
			},
			{ data: 'inspectItem15',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[2];
				}
			},
			//{ data: 'inspectItem16' },
			{ data: 'inspectItem17',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[5];
				}
			},
			{ data: 'inspectItem17',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[6];
				}
			},
			{ data: 'inspectItem18',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[3];
				}
			},
			/* { data: 'inspectItem18',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[3];
				}
			}, */
			{ data: 'inspectItem19',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[3];
				}
			},
			{ data: 'inspectItem17',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[4];
				}
			/*  면취 평균 값*/},
			/* { data: 'inspectItem19',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[3];
				}
			}, */
        	//{ data: 'inspectItem20' },
        	{ data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[5];
				}
			},
			{ data: 'dealCorpNm', 'className':'text-center' },
			{ data: 'preInWhsDate',
				render: function(data, type, row) {
					return moment(data).format('YYYY-MM-DD');
				}
			},
			{ /* 시편별 측정값 두께 */
				data: 'inspectItem13',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[4];
				}
			},
			{ 
				data: 'inspectItem13',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[5];
				}
			},
			{ 
				data: 'inspectItem13',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[6];
				}
			},
			{ 
				data: 'inspectItem13',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[7];
				}
			},
			{ 
				data: 'inspectItem13',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[8];
				}
			},
			{ /* 시편별 측정값 폭 */
				data: 'inspectItem14',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[3];
				}
			},
			{ 
				data: 'inspectItem14',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[4];
				}
			},
			{ 
				data: 'inspectItem14',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[5];
				}
			},
			{ 
				data: 'inspectItem14',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[6];
				}
			},
			{ 
				data: 'inspectItem14',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[7];
				}
			},
			{ /* 시편별 측정값 burr*/
				data: 'inspectItem15',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[3];
				}
			},
			{ 
				data: 'inspectItem15',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[4];
				}
			},
			{ 
				data: 'inspectItem15',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[5];
				}
			},
			{ 
				data: 'inspectItem15',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[6];
				}
			},
			{ 
				data: 'inspectItem15',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[7];
				}
			},
			{ /*내절강도 시편별 측정값  */
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[6];
				}
			},
			{ 
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[7];
				}
			},
			{
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[8];
				}
			},
			{
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[9];
				}
			},
			{
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[10];
				}
			},
			{
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[11];
				}
			},
			{
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[12];
				}
			},
			{
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[13];
				}
			},
			{
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[14];
				}
			},
			{
				data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					return temp[15];
				}
			},
			/* 비고란 */
			{ data: 'inspectItem13',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[9];
				}
			},
			{ data: 'inspectItem14',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[8];
				}
			},
			{ data: 'inspectItem15',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[8];
				}
			},
			{ data: 'inspectItem16',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[9];
				}
			},
			{ data: 'inspectItem17',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[7];
				}
			},
			{ data: 'inspectItem18',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[4];
				}
			},
			{ data: 'inspectItem19',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[4];
				}
			},
			{ data: 'inspectItem20',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[17];
				}
			},
			{ data: 'inspectItem21',
				render: function(data, type, row) {
					var temp = (data!=null) ? data.split('/') : '';
					
					return temp[16];
				}
			},
        ],
        columnDefs: [
        	{ targets: [1,2,3,4,5], className: 'text-center' }, 
        	{ targets: [6,7,8,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,
            	59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,
            	102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,
            	135,136,137,138,139,140,141,142,143,144,145,146,147,148,149], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '수입검사현황 - 자재',
            },
            {
            	extend: 'excel',
            	title: '수입검사현황 - 자재',
                exportOptions: {
//                  	columns: notHiddenArray	//원하는 값 지정
                	columns: ':visible',
                },
                footer: false,
                //excelCss
			    customize: function ( xlsx ) {
			        var sheet = xlsx.xl.worksheets['sheet1.xml'];
			        //Bold Header Row
			        $('row[r=3] c', sheet).attr( 's', '2' );
			        $('row[r=4] c', sheet).attr( 's', '2' );
			        $('row[r=5] c', sheet).attr( 's', '2' );
			        
			        //Make Cells Bold
			        $('c[r=A1]', sheet).attr( 's', '2' );
			        $('c[r=A3]', sheet).attr( 's', '2' );

			        //가운데
			        $('row[r=1] c', sheet).attr( 's', '51' );
			        $('row[r=3] c', sheet).attr( 's', '51' );

			        //배경 색
			        /*$('row[r=3] c', sheet).attr( 's', '30' );
			        $('row[r=4] c', sheet).attr( 's', '30' );
			        $('row[r=5] c', sheet).attr( 's', '30' );*/

			        $('row[r=2] c', sheet).remove();	//2번째 행 데이터 삭제

			      	//병합 하고자 하는 셀 지정 
			      	var mergeCells = $('mergeCells', sheet);

				    //rowspan
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A3:A5'} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'B3:B5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'C3:C5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'D3:D5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'E3:E5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'F3:F5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'G3:G5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'H3:H5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'I3:I5'} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'J3:J5'} } )
						);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'K3:K5'} } )
						);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'L3:L5'} } )
						);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'M3:M5'} } )
						);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'N3:N5'} } )
						);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'O3:O5'} } )
						);
					//rowspan

					//colspan
					/* mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'J3:Q3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'R3:Y3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'AZ3:BS3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'BT3:DO3'} } )
					); */
					//colspan
					
// 					mergeCells[0].appendChild(
// 						createNode( sheet, 'mergeCell', { attr: {ref: 'F4:H4'} } )
// 					); 
					
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
			  	//excelCssEnd

			    //헤더 추가하는 부분
			    customizeData: function(data){
				   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				 	//첫 번째 tr
				 	 arrayTr1 = colspanGroupArray('inspectionListTable001', 0, 'th', $('#inspectionListTable001 thead tr').eq(0).find('th').length, 15, 'Y', '');
				 	//두 번째 tr
				 	 arrayTr2 = colspanGroupArray('inspectionListTable001', 1, 'th', $('#inspectionListTable001 thead tr').eq(1).find('th').length, 15, 'N', arrayTr1);
				 	//세 번째 tr
				   	 arrayTr3 = colspanGroupArray('inspectionListTable001', 2, 'th', $('#inspectionListTable001 thead tr').eq(1).find('th').length, 15, 'empty', arrayTr2);
					
					//첫 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					 arrayRow1 = alignToTableSize( data.header.length, arrayTr1  );
					//두 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					 arrayRow2 = alignToTableSize( data.header.length, arrayTr2  );
					//세 번째 행에 헤더 부분 이미 header 개수만큼되어있음. 
					   
				    //거꾸로 감, 제일 위에가 제일 밑으로 감
			        let desc = [
			        	arrayRow2	//두 번째 행
				        , arrayRow1	//첫 번째 행
					];

			        //data.body.unshift(data.header);	//헤더 맨 아래 부분
			        data.body.unshift(arrayTr3);		//헤더 맨 아래 부분 (세 번째 행)
			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }
            },
            {
                extend: 'print',
                title: '수입검사현황 - 자재',
            },
        ],
        drawCallback : function( settings ) {
			let drawTemp001 = temp001 - 8;
// 			$.each($('#inspectionListTable001').find('tr[name=matrlHeader001]').find('th'),function(index,item){
// 				if($(this).find('input[name=listTable001Hidden]').val() == '002' || $(this).find('input[name=listTable001Hidden]').val() == '003' ) {
// 					$('#inspectionListTable001').find('tr[name=matrlHeader001]').find('th').eq(index).addClass('d-none');
// 				}
// 			});
            
        	$.each($('#inspectionListTable001 tbody tr'),function(index,item){	
// 				for(var i=9; i<54;i++){
// 					if($('#matrlHeader001').find('th').eq(i-9).hasClass('d-none') ){
// 						$(this).find('td').eq(i).addClass('d-none');
// 						//console.log($(this).find('td').eq(i));
// 					} else if( $(this).find('td').eq(i).text() == "") {
// 						$(this).find('td').eq(i).addClass('d-none');
// 					}
//         		}
// 				for(var i=54; i<99;i++){//I맞는지 확인하기
// //					console.log($('#matrlHeader001').find('th').eq(i).html());
// 					if($('#matrlHeader001').find('th').eq(i-37 + drawTemp001).hasClass('d-none') ){//
// 						$(this).find('td').eq(i).addClass('d-none');
// 					} else if( $(this).find('td').eq(i).text() == "N") {
// 						$(this).find('td').eq(i).addClass('d-none');
// 					}
//         		}
            	
        		/* if($('#inspectionListTable001 .0').text()==""){          		
					$('#inspectionListTable001 .0').addClass('d-none');	
			 		$(this).find('td').eq(9).addClass('d-none');
			 		$(this).find('td').eq(9).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable001 .1').text()==""){
					$('#inspectionListTable001 .1').addClass('d-none');	
			 		$(this).find('td').eq(10).addClass('d-none');
			 		$(this).find('td').eq(10).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable001 .2').text()==""){
					$('#inspectionListTable001 .2').addClass('d-none');	
			 		$(this).find('td').eq(11).addClass('d-none');
			 		$(this).find('td').eq(11).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable001 .3').text()==""){
					$('#inspectionListTable001 .3').addClass('d-none');	
			 		$(this).find('td').eq(12).addClass('d-none');
			 		$(this).find('td').eq(12).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable001 .4').text()==""){
					$('#inspectionListTable001 .4').addClass('d-none');	
			 		$(this).find('td').eq(13).addClass('d-none');
			 		$(this).find('td').eq(13).addClass('d-none');
			 
				 }
				if($('#inspectionListTable001 .5').text()==""){
					$('#inspectionListTable001 .5').addClass('d-none');	
			 		$(this).find('td').eq(14).addClass('d-none');
			 		$(this).find('td').eq(14).addClass('d-none');
			 
				 }
				if($('#inspectionListTable001 .6').text()==""){
					$('#inspectionListTable001 .6').addClass('d-none');	
			 		$(this).find('td').eq(15).addClass('d-none');
			 		$(this).find('td').eq(15).addClass('d-none');
			 		
				 }
				if($('#inspectionListTable001 .7').text()==""){
					$('#inspectionListTable001 .7').addClass('d-none');	
			 		$(this).find('td').eq(16).addClass('d-none');
			 		$(this).find('td').eq(16).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable001 .8').text()=="" ){
					$('#inspectionListTable001 .8').addClass('d-none');	
			 		$(this).find('td').eq(17).addClass('d-none');
			 		$(this).find('td').eq(17).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable001 .9').text()==""){
					$('#inspectionListTable001 .9').addClass('d-none');	
			 		$(this).find('td').eq(18).addClass('d-none');
			 		$(this).find('td').eq(18).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable001 .10').text()==""){
					$('#inspectionListTable001 .10').addClass('d-none');	
			 		$(this).find('td').eq(19).addClass('d-none');
			 		$(this).find('td').eq(19).addClass('d-none');
	
				 }		
				if($('#inspectionListTable001 .11').text()==""){
					$('#inspectionListTable001 .11').addClass('d-none');	
			 		$(this).find('td').eq(20).addClass('d-none');
			 		$(this).find('td').eq(20).addClass('d-none');
			 	 } */

				/* for( var i = 0; i < 17; i++){
					if($('#inspectionListTable001 .'+i).text() == "" && )
				} */
			 	 
				 if($(this).find('td').eq(5).text() == "불합격"){
					 $(this).find('td').eq(5).addClass('font-red');
				}

				for(var i = 15; i < 27; i++){
					if($(this).find('td').eq(i).text() == "NG"){
						$(this).find('td').eq(i).addClass('font-red');
					}
				}
        	});
       	},
    });

	//$('#inspectionListTable001_wrapper').find('.buttons-excel').attr('id','btnRealExcel');
	//$('#btnRealExcel').attr('style', 'display: none;');
	
	var tapTextValue = inspectionListTable001;

	//검색 기능
	$('.search').on('keyup', function(){
		tapTextValue.search($(this).val()).draw();
	});

	function textSearch(value){
		tapTextValue.search(value).draw();
	}
	//검색 기능 끝
	
	//columnVisibleFun('inspectionListTable001', 10, inspectionListTable001);
	columnVisibleFun(23, 59, inspectionListTable001);
	columnVisibleFun(68, 104, inspectionListTable001);
	
    //var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
	//html1 += '<label class="input-label-sm">&nbsp;수입검사일</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarFrom001" name="chooseCalendarFrom001" />';
	//html1 += '<button onclick="fnPopUpCalendar(chooseCalendarFrom001,chooseCalendarFrom001,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarFrom001" type="button">';
	//html1 += '<span class="oi oi-calendar"></span>';
	//html1 += '</button>'; 
	//html1 += '</div>';
	//html1 += '<div class="form-group input-sub m-0 row">';
	//html1 += '<label class="input-label-sm">&nbsp;&nbsp&nbsp~</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarTo001" name="chooseCalendarTo001" />';
	//html1 += '<button onclick="fnPopUpCalendar(chooseCalendarTo001,chooseCalendarTo001,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar001" type="button">';
	//html1 += '<span class="oi oi-calendar"></span>';
	//html1 += '</button>'; 
	//html1 += '</div>';
	//html1 += '&nbsp<button type="button" class="btn btn-primary" id="btnRetv001">조회</button></div>';
    //
	//$('#inspectionListTable001_length').html(html1);
	//$('#chooseCalendarFrom001').val(serverDateFrom);
	//$('#chooseCalendarTo001').val(serverDate);

    $('#inspectionListTable001 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#inspectionListTable001').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        
        
        let lotNo		= inspectionListTable001.row(this).data().lotNo;
        let fileGroup	= inspectionListTable001.row(this).data().fileGroup;
        let fileNm		= inspectionListTable001.row(this).data().fileNm;
        let inWhsDate	= moment($('#inspectionListTable001').DataTable().rows('.selected').data()[0].inWhsDate).format('YYYY')
        
        
        if( fileGroup != null && fileGroup != "" && fileGroup != "null" ) {
        	$('#fpHref').attr('href','qm/matrlInOutReportDownload?lotNo='+lotNo +'&fileGroup='+fileGroup +'&fileNm='+fileNm +'&inWhsDate=' +inWhsDate);
        	$('#fpFn').text(fileNm);
        } else {
        	$('#fpHref').removeAttr('href');
        	$('#fpFn').text("첨부파일이 없습니다.");
        }
        
    });
        
    matrlHeader002Create();
 	//원자재
	$.fn.dataTable.ext.errMode = 'none';
	let inspectionListTable002 = $('#inspectionListTable002').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: //"<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
		language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
//         scrollY : "56vh",
        lengthChange: false,
        scrollX: true,
        async: false,
   
        scrollY : "53vh",
        scrollCollapse: true,
        lengthChange: false,
        
        ajax: {
            url: '<c:url value="/qm/inspectionListRead"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val() },
	           	'chooseDateTo'		: 		function() { return $('#chooseDateTo').val() + ' 23:59:59.999'; },
	           	'matrlGubunCd'		: 		'002',
	           	'matrlCd'		: function() { return matrlCd;}
            },
        },
        columns: [
        	{
				render: function(data, type, row, meta) {
					var html = '<label onClick="inspectionSelect('+meta.row+');" style=" border-radius: 10%;';
						html +='border: solid 1px;';
						html +='width: 100%; height: 17px; font-size:11px;';
						html +='background-color: #346cb0; color: white;">보기</label>';
					return html;
				}
			},
        	{ data: 'regDate'/* ,
				render: function(data, type, row) {
					return data.substring(5, 10);
				} */
			},
        	{ data: 'matrlCd' },
        	{ data: 'matrlNm' },
        	{ data: 'lotNo',
				render: function(data, type, row) {
					if(data == null || data ==''){
						data = '-';
					}
					return data;
				}
			 },
        	{ data: 'inspectNm',
				 render: function(data, type, row) {
					if(data == null || data ==''){
						data = '-';
					}
					return data;
				}
			},
        	{ data: 'preInWhsQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
			{ data: 'inWhsQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
        	{ data: 'diffQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
			{ data: 'inWhsDate' ,
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
			{ data: 'statusNm' },
			{ data: 'approvalNm' },
			{ data: 'frrrdDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
             },
			{
				data: 'frrrdType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += matrlFaultyType[jj].baseCdNm + ', ';
								count++;
							}
						}
						if (count == 0) {
							faultyTypeNm = '-';
						} else {
							faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
						}
					} else {
						faultyTypeNm = '';
					}
					return faultyTypeNm;
				}
            },
			{ data: 'retestDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },			
			{ data: 'inspectItem1'			},
			{ data: 'inspectItem2'			},
			{ data: 'inspectItem3'			},
			{ data: 'inspectItem4'			},
			{ data: 'inspectItem5'			},
			{ data: 'inspectItem6'			},
			{ data: 'inspectItem7'			},
			{ data: 'inspectItem8'			},
			{ data: 'inspectItem9'			},
			{ data: 'inspectItem10'			},
			{ data: 'inspectItem11'			},
			{ data: 'inspectItem12'			},
			{ data: 'dealCorpNm' },
			{ data: 'preInWhsDate',
				render: function(data, type, row) {
					return moment(data).format('YYYY-MM-DD');
				}
			},			
        ],
        columnDefs: [
        	{ targets: [6,7,8], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '수입검사현황 - 원자재',
            },
            {
                extend: 'excel',
                title: '수입검사현황 - 원자재',
            },
            {
                extend: 'print',
                title: '수입검사현황 - 원자재',
            },
        ],
        drawCallback : function( settings ) { 
            
        	$.each($('#inspectionListTable002 tbody tr'),function(index,item){	
            		 	
        		if($('#inspectionListTable002 .0').text()=="" || $('#inspectionListTable002 .0').text()== null){       
        			$('#inspectionListTable002 .0').addClass('d-none');     		
        			$(this).find('td').eq(15).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable002 .1').text()==""){
					$('#inspectionListTable002 .1').addClass('d-none');
					$(this).find('td').eq(16).addClass('d-none');
			 		
			 	
				 }
				if($('#inspectionListTable002 .2').text()==""){
					$('#inspectionListTable002 .2').addClass('d-none');
					$(this).find('td').eq(17).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable002 .3').text()==""){
					$('#inspectionListTable002 .3').addClass('d-none');
					$(this).find('td').eq(18).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable002 .4').text()==""){
					$('#inspectionListTable002 .4').addClass('d-none');
					$(this).find('td').eq(19).addClass('d-none');
			 
				 }
				if($('#inspectionListTable002 .5').text()==""){
					$('#inspectionListTable002 .5').addClass('d-none');
					$(this).find('td').eq(20).addClass('d-none');
			 
				 }
				if($('#inspectionListTable002 .6').text()==""){
					$('#inspectionListTable002 .6').addClass('d-none');
					$(this).find('td').eq(21).addClass('d-none');
			 		
				 }
				if($('#inspectionListTable002 .7').text()==""){
					$('#inspectionListTable002 .7').addClass('d-none');
					$(this).find('td').eq(22).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable002 .8').text()==""){
					$('#inspectionListTable002 .8').addClass('d-none');
					$(this).find('td').eq(23).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable002 .9').text()==""){
					$('#inspectionListTable002 .9').addClass('d-none');
					$(this).find('td').eq(24).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable002 .10').text()==""){
					$('#inspectionListTable002 .10').addClass('d-none');
					$(this).find('td').eq(25).addClass('d-none');
	
				 }		
				if($('#inspectionListTable002 .11').text()==""){
					$('#inspectionListTable002 .11').addClass('d-none');
					$(this).find('td').eq(26).addClass('d-none');
			 	
				 }
				 if($(this).find('td').eq(5).text() == "불합격"){
					 $(this).find('td').eq(5).addClass('font-red');
				}

				for(var i = 15; i < 27; i++){	
					if($(this).find('td').eq(i).text() == "NG"){
						$(this).find('td').eq(i).addClass('font-red');
					} 					
				}				
        	});        	
        	$('#inspectionListTable002').DataTable().columns.adjust();
       	},
    });

    //var html2 = '<div class="row"><div class="form-group input-sub m-0 row">';
	//html2 += '<label class="input-label-sm">&nbsp;수입검사일</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarFrom002" name="chooseCalendarFrom002" />';
	//html2 += '<button onclick="fnPopUpCalendar(chooseCalendarFrom002,chooseCalendarFrom002,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarFromGoods" type="button">';
	//html2 += '<span class="oi oi-calendar"></span>';
	//html2 += '</button>'; 
	//html2 += '</div>';
	//html2 += '<div class="form-group input-sub m-0 row">';
	//html2 += '<label class="input-label-sm">&nbsp;&nbsp&nbsp~</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarTo002" name="chooseCalendarTo002" />';
	//html2 += '<button onclick="fnPopUpCalendar(chooseCalendarTo002,chooseCalendarTo002,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarGoods" type="button">';
	//html2 += '<span class="oi oi-calendar"></span>';
	//html2 += '</button>'; 
	//html2 += '</div>';
	//html2 += '&nbsp<button type="button" class="btn btn-primary" id="btnRetv002">조회</button></div>';
    //
	//$('#inspectionListTable002_length').html(html2);
	//$('#chooseCalendarFrom002').val(serverDateFrom);
	//$('#chooseCalendarTo002').val(serverDate);

    $('#inspectionListTable002 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#inspectionListTable002').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });




    matrlHeader003Create();
	//원자재
	$.fn.dataTable.ext.errMode = 'none';
	let inspectionListTable003 = $('#inspectionListTable003').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: //"<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
    	language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : true,
        //lengthChange: true,
        //pageLength: 16,
        scrollY : "56vh",
        scrollCollapse: true,
        lengthChange: false,
        ajax: {
            url: '<c:url value="/qm/inspectionListRead"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val() },
	           	'chooseDateTo'		: 		function() { return $('#chooseDateTo').val() + ' 23:59:59.999'; },
	           	'matrlGubunCd'		: 		'003',
	           	'matrlCd'		: function() { return matrlCd;}
            },
        },
        columns: [
        	{
				render: function(data, type, row, meta) {
					var html = '<label onClick="inspectionSelect('+meta.row+');" style=" border-radius: 10%;';
						html +='border: solid 1px;';
						html +='width: 100%; height: 17px; font-size:11px;';
						html +='background-color: #346cb0; color: white;">보기</label>';
					return html;
				}
			},
        	{ data: 'regDate'/* ,
				render: function(data, type, row) {
					return data.substring(5, 10);
				} */
			},
        	{ data: 'matrlCd' },
        	{ data: 'matrlNm' },
        	{ data: 'lotNo',
				render: function(data, type, row) {
					if(data == null || data ==''){
						data = '-';
					}
					return data;
				}
			 },
        	{ data: 'inspectNm',
				 render: function(data, type, row) {
					if(data == null || data ==''){
						data = '-';
					}
					return data;
				}
			},
        	{ data: 'preInWhsQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
			{ data: 'inWhsQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
			{ data: 'diffQty',
				render: function(data, type, row) {
					return addCommas(parseFloat(data).toFixed(1));
				}
			},
			{ data: 'inWhsDate' ,
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
			{ data: 'statusNm' },
			{ data: 'approvalNm' },
			{ data: 'frrrdDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
             },
			{
				data: 'frrrdType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += matrlFaultyType[jj].baseCdNm + ', ';
								count++;
							}
						}
						if (count == 0) {
							faultyTypeNm = '-';
						} else {
							faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
						}
					} else {
						faultyTypeNm = '';
					}
					return faultyTypeNm;
				}
            },
			{ data: 'retestDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },			
			{ data: 'inspectItem1'			},
			{ data: 'inspectItem2'			},
			{ data: 'inspectItem3'			},
			{ data: 'inspectItem4'			},
			{ data: 'inspectItem5'			},
			{ data: 'inspectItem6'			},
			{ data: 'inspectItem7'			},
			{ data: 'inspectItem8'			},
			{ data: 'inspectItem9'			},
			{ data: 'inspectItem10'			},
			{ data: 'inspectItem11'			},
			{ data: 'inspectItem12'			},
			{ data: 'dealCorpNm' },
			{ data: 'preInWhsDate',
				render: function(data, type, row) {
					return moment(data).format('YYYY-MM-DD');
				}
			},
			//{ data: 'inspectItem7' },
			//{ data: 'inspectItem8' },
			//{ data: 'inspectItem9' },
			//{ data: 'inspectItem10' },
			//{ data: 'inspectItem11' },
			//{ data: 'inspectItem12' },
			//{ data: 'inspectItem13' },
			//{ data: 'inspectItem14' },
			//{ data: 'inspectItem15' },
			//{ data: 'inspectItem16' },
			//{ data: 'inspectItem17' },
			//{ data: 'inspectItem18' },
			//{ data: 'inspectItem19' },
			//{ data: 'inspectItem20' },
			//{ data: 'inspectItem21' },
        	//{ data: 'inspectItem22' },
        	//{ data: 'inspectItem23' },
        	//{ data: 'inspectItem24' },
        	//{ data: 'inspectItem25' },
        	//{ data: 'inspectItem26' },
        	//{ data: 'inspectItem27' },
        	//{ data: 'inspectItem28' },
        	//{ data: 'inspectItem29' },
        	//{ data: 'inspectItem30' },
        ],
        columnDefs: [
        	{ targets: [6,7,8], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '수입검사현황 - 가공원자재',
            },
            {
                extend: 'excel',
                title: '수입검사현황 - 가공원자재',
            },
            {
                extend: 'print',
                title: '수입검사현황 - 가공원자재',
            },
        ],
		drawCallback : function( settings ) {
			$.each($('#inspectionListTable003 tbody tr'),function(index,item){
				
        		if($('#inspectionListTable003 .0').text()==""){            		
					$('#inspectionListTable003 .0').addClass('d-none');	
			 		$(this).find('td').eq(15).addClass('d-none');
			 		$(this).find('td').eq(15).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable003 .1').text()==""){
					$('#inspectionListTable003 .1').addClass('d-none');	
			 		$(this).find('td').eq(16).addClass('d-none');
			 		$(this).find('td').eq(16).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable003 .2').text()==""){
					$('#inspectionListTable003 .2').addClass('d-none');	
			 		$(this).find('td').eq(17).addClass('d-none');
			 		$(this).find('td').eq(17).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable003 .3').text()==""){
					$('#inspectionListTable003 .3').addClass('d-none');	
			 		$(this).find('td').eq(18).addClass('d-none');
			 		$(this).find('td').eq(18).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable003 .4').text()==""){
					$('#inspectionListTable003 .4').addClass('d-none');	
			 		$(this).find('td').eq(19).addClass('d-none');
			 		$(this).find('td').eq(19).addClass('d-none');
			 
				 }
				if($('#inspectionListTable003 .5').text()==""){
					$('#inspectionListTable003 .5').addClass('d-none');	
			 		$(this).find('td').eq(20).addClass('d-none');
			 		$(this).find('td').eq(20).addClass('d-none');
			 
				 }
				if($('#inspectionListTable003 .6').text()==""){
					$('#inspectionListTable003 .6').addClass('d-none');	
			 		$(this).find('td').eq(21).addClass('d-none');
			 		$(this).find('td').eq(21).addClass('d-none');
			 		
				 }
				if($('#inspectionListTable003 .7').text()==""){
					$('#inspectionListTable003 .7').addClass('d-none');	
			 		$(this).find('td').eq(22).addClass('d-none');
			 		$(this).find('td').eq(22).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable003 .8').text()==""){
					$('#inspectionListTable003 .8').addClass('d-none');	
			 		$(this).find('td').eq(23).addClass('d-none');
			 		$(this).find('td').eq(23).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable003 .9').text()==""){
					$('#inspectionListTable003 .9').addClass('d-none');	
			 		$(this).find('td').eq(24).addClass('d-none');
			 		$(this).find('td').eq(24).addClass('d-none');
			 	
				 }
				if($('#inspectionListTable003 .10').text()==""){
					$('#inspectionListTable003 .10').addClass('d-none');	
			 		$(this).find('td').eq(25).addClass('d-none');
			 		$(this).find('td').eq(25).addClass('d-none');
	
				 }		
				if($('#inspectionListTable003 .11').text()==""){
					$('#inspectionListTable003 .11').addClass('d-none');	
			 		$(this).find('td').eq(26).addClass('d-none');
			 		$(this).find('td').eq(26).addClass('d-none');
			 	
				 }
				 if($(this).find('td').eq(5).text() == "불합격"){
					 $(this).find('td').eq(5).addClass('font-red');
				}

				for(var i = 15; i < 27; i++){	
					if($(this).find('td').eq(i).text() == "NG"){
						$(this).find('td').eq(i).addClass('font-red');
					} 					
				}				
        	});        	
			$('#inspectionListTable003').DataTable().columns.adjust();
       	},
    });
 
    //var html3 = '<div class="row"><div class="form-group input-sub m-0 row">';
	//html3 += '<label class="input-label-sm">&nbsp;수입검사일</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarFrom003" name="chooseCalendarFrom003" />';
	//html3 += '<button onclick="fnPopUpCalendar(chooseCalendarFrom003,chooseCalendarFrom003,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarFromGoods" type="button">';
	//html3 += '<span class="oi oi-calendar"></span>';
	//html3 += '</button>'; 
	//html3 += '</div>';
	//html3 += '<div class="form-group input-sub m-0 row">';
	//html3 += '<label class="input-label-sm">&nbsp;&nbsp&nbsp~</label><input class="form-control" style="width:97px;" type="text" id="chooseCalendarTo003" name="chooseCalendarTo003" />';
	//html3 += '<button onclick="fnPopUpCalendar(chooseCalendarTo003,chooseCalendarTo003,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendarGoods" type="button">';
	//html3 += '<span class="oi oi-calendar"></span>';
	//html3 += '</button>'; 
	//html3 += '</div>';
	//html3 += '&nbsp<button type="button" class="btn btn-primary" id="btnRetv003">조회</button></div>';
    //
	//$('#inspectionListTable003_length').html(html3);
	//$('#chooseCalendarFrom003').val(serverDateFrom);
	//$('#chooseCalendarTo003').val(serverDate);

    $('#inspectionListTable003 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#inspectionListTable003').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
 

  	//$('#btnRetv001').on('click', function() {
	//	let dateFrom = new Date($('#chooseDateFromCal').val());
	//	let dateTo = new Date($('#chooseDateTo').val());
	//	let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
	//	dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
	//	if (isNaN(dateDiff)) {
	//		toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
	//	if (dateDiff <= 0) {
	//		toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
	//	if (dateDiff > 31) {
	//		toastr.warning("검색 가능 기간은 최대 한달입니다!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
	//	
    //
  	//	$('#inspectionListTable001').DataTable().ajax.reload();
	//});

  	//$('#btnRetv002').on('click', function() {
	//	let dateFrom = new Date($('#chooseDateFrom').val());
	//	let dateTo = new Date($('#chooseDateTo').val());
	//	let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
	//	dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
	//	if (isNaN(dateDiff)) {
	//		toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
	//	if (dateDiff <= 0) {
	//		toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
	//	if (dateDiff > 31) {
	//		toastr.warning("검색 가능 기간은 최대 한달입니다!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
    //
  	//	$('#inspectionListTable002').DataTable().ajax.reload();
	//});

  	//$('#btnRetv003').on('click', function() {
	//	let dateFrom = new Date($('#chooseDateFromCal').val());
	//	let dateTo = new Date($('#chooseDateTo').val());
	//	let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
	//	dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
	//	if (isNaN(dateDiff)) {
	//		toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
	//	if (dateDiff <= 0) {
	//		toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
	//	if (dateDiff > 31) {
	//		toastr.warning("검색 가능 기간은 최대 한달입니다!");
	//		$('#chooseDateFrom').focus();
	//		return false;
	//	}
    //
  	//	$('#inspectionListTable003').DataTable().ajax.reload();
	//});
	selectBoxAppend(matrlCdList, "matrlCd", "", "1");

  	$('#btnRetv').on('click', function() {
		let dateFrom 	= new Date($('#chooseDateFrom').val());
		let dateTo 		= new Date($('#chooseDateTo').val());
		let dateDiff	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}		
		
  		if (tapTemp == 0){
  			$("#tab1").trigger("click");
  			tapTextValue = inspectionListTable001;
  		} else if (tapTemp == 1) {
  			$("#tab2").trigger("click");
  			tapTextValue = inspectionListTable002;
  		} else if (tapTemp == 2) {
  			$("#tab3").trigger("click");
  			tapTextValue = inspectionListTable003;
  		}
	});
	


	
	$('#tab1').click(function(){
		let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}

		$('#btnFakeExcel').removeClass('d-none');
		tapTextValue = inspectionListTable001;
        matrlCd= null;
		$('#inspectionView001').removeClass("d-none");
		$('#inspectionView002').addClass("d-none");
		$('#inspectionView003').addClass("d-none");
		$('#inspectionListTable001').DataTable().ajax.reload();
		
		$.ajax({
            url: '<c:url value="/qm/inspectMatrlCodeList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val() },
	           	'chooseDateTo'		: 		function() { return $('#chooseDateTo').val(); },
	           	'matrlGubunCd'		: 		'001',           
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {	
                    $('#matrlCd').empty();
                    var matrlCdList = new Array();	//matrlCdList
                    for(var i=0; i<data.length; i++){
                    	var json=new Object();
                    	json.baseCd=data[i].matrlCd;
                    	json.baseCdNm=data[i].matrlNm;
                    	matrlCdList.push(json);
                    }
                    selectBoxAppend(matrlCdList, "matrlCd", "", "1");
                } else {
               	 toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            }
        });



		
		tapTemp = 0;
	});
	
	$('#tab2').click(function(){
		let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}

		$('#btnFakeExcel').addClass('d-none');
		
		tapTextValue = inspectionListTable002;
		
		matrlCd= null;
		$('#inspectionView001').addClass("d-none");
		$('#inspectionView002').removeClass("d-none");
		$('#inspectionView003').addClass("d-none");
		$('#inspectionListTable002').DataTable().ajax.reload();
		$.ajax({
            url: '<c:url value="/qm/inspectMatrlCodeList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val() },
	           	'chooseDateTo'		: 		function() { return $('#chooseDateTo').val() + ' 23:59:59.999'; },
	           	'matrlGubunCd'		: 		'002',	           
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {	
                    $('#matrlCd').empty();
                    var matrlCdList = new Array();	//matrlCdList
                    for(var i=0; i<data.length; i++){
                    	var json=new Object();
                    	json.baseCd=data[i].matrlCd;
                    	json.baseCdNm=data[i].matrlNm;
                    	matrlCdList.push(json);
                    }
                    selectBoxAppend(matrlCdList, "matrlCd", "", "1");
                } else {
               	 toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            }
        });

       
		tapTemp = 1;
	});
	
	$('#tab3').click(function(){
		let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}

		$('#btnFakeExcel').addClass('d-none');
		
		tapTextValue = inspectionListTable003;
		
		matrlCd= null;
		$('#inspectionView001').addClass("d-none");
		$('#inspectionView002').addClass("d-none");
		$('#inspectionView003').removeClass("d-none");
		$('#inspectionListTable003').DataTable().ajax.reload();
		
		$.ajax({
            url: '<c:url value="/qm/inspectMatrlCodeList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val() },
	           	'chooseDateTo'		: 		function() { return $('#chooseDateTo').val() + ' 23:59:59.999'; },
	           	'matrlGubunCd'		: 		'003',          
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {	
                    $('#matrlCd').empty();
                    var matrlCdList = new Array();	//matrlCdList
                    for(var i=0; i<data.length; i++){
                    	var json=new Object();
                    	json.baseCd=data[i].matrlCd;
                    	json.baseCdNm=data[i].matrlNm;
                    	matrlCdList.push(json);
                    }
                    selectBoxAppend(matrlCdList, "matrlCd", "", "1");
                } else {
               	 toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            }
        });

       
		tapTemp = 2;
	});

    function matrlHeader001Create(){
    	var Hd_001 = '';
		var arrayLength = 0;
    	var viewArrayLength = 0;
    	$.each(managementCode, function(index,item){
    		Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;"><input type="hidden" name="listTable001Hidden" value="'+ item.etc1 +'"><div class="'+viewArrayLength+'">'+ item.baseCdNm + '</div></th>';
    		viewArrayLength++
    		if(item.etc1 == '001'){    					
    			//Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;"><input type="hidden" name="listTable001Hidden" value="'+ item.etc1 +'"><div class="'+arrayLength+'">'+ item.baseCdNm+'</div></th>';
    			arrayLength++;    	
        	}

    		//영민추가(고정Header개수 세기)
    		else {
    			arrayLength++;
        	}
        	
		});

     	for(var i=0; i<45 - managementCode.length; i++){
     		Hd_001 += '<th rowspan="2">★</th>';
     		arrayLength++;
 		}

		
    	$.each(managementCode, function(index,item){				
    		//if(item.etc1 == '001'){    					
    			Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;"><input type="hidden" name="listTable001Hidden" value="'+ item.etc1 +'"><div class="'+viewArrayLength+'"></div>'+ item.baseCdNm + item.etc1 + '</th>';  	
    			viewArrayLength++;
            //}
		}); 
		
     	for(var i=0; i<45 - managementCode.length; i++){
     		Hd_001 += '<th rowspan="2">★</th>';
     		
 		}
    	
    	Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">두께(mm)</th>';
    	Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">폭(mm)</th>';
    	Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">Burr(mm)</th>';
        Hd_001 += '<th colspan="2" class="text-center" style="min-width:50px;">폭(µm)</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:50px;">T두께(µm)</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:50px; border-right:solid #d6d8e1 1px; width: 10px;">ET두께(µm)</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:50px; border-right:solid #d6d8e1 1px; width: 10px;">평균값</th>';
        Hd_001 += '<th colspan="5" class="text-center" style="min-width:50px;">두께(mm)</th>';
        Hd_001 += '<th colspan="5" class="text-center" style="min-width:50px;">폭(mm)</th>';
        Hd_001 += '<th colspan="5" class="text-center" style="min-width:50px;">Burr(mm)</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px; border-right:solid #d6d8e1 1px; width: 10px;">1</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">2</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">3</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">4</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">5</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">6</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">7</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">8</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">9</th>';
        Hd_001 += '<th rowspan="2" class="text-center" style="min-width:60px;">10</th>';

        Hd_001 += '<th colspan="3" class="text-center" style="min-width:50px;">치수</th>';
        Hd_001 += '<th colspan="4" class="text-center" style="min-width:50px;">면취</th>';
        Hd_001 += '<th colspan="3" class="text-center" style="min-width:50px;">내절강도</th>';
        $('#matrlHeaderCols001').attr('colspan', arrayLength);
        $('#matrlHeaderCols011').attr('colspan', arrayLength);
		$('#matrlHeader001').html(Hd_001); 		
	}

    function matrlHeader002Create(){   			
    	var Hd_002 = '';
		var arrayLength = 0;
    	
    	$.each(managementCode, function(index,item){				
    		if(item.etc1 == '002'){    		  			
    			Hd_002 += '<th  class="text-center" style="min-width:60px;border-right:solid #d6d8e1 1px;"><div class="'+arrayLength+'">'+ item.baseCdNm+'</div></th>';
    			arrayLength++;  
        	}
		});
		
        $('#matrlHeaderCols002').attr('colspan',arrayLength);
		$('#matrlHeader002').html(Hd_002); 	
 
	}

    function matrlHeader003Create(){   			
    	var Hd_003 = '';
		var arrayLength = 0;
    	
    	$.each(managementCode, function(index,item){				
    		if(item.etc1 == '003'){
    			
    			Hd_003 += '<th  class="text-center" style="min-width:60px; border-right:solid #d6d8e1 1px;"><div class="'+arrayLength+'">'+ item.baseCdNm+'</div></th>';        
    			arrayLength++;    			
    		}
		});

        $('#matrlHeaderCols003').attr('colspan',arrayLength);        
		$('#matrlHeader003').html(Hd_003); 	
	}
	
	//자재명 변경감지
    $('#matrlCd').on('change', function() {

    	let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}		
    
		matrlCd =  $('#matrlCd').val();
		
  		if (tapTemp == 0){
  			$('#inspectionListTable001').DataTable().ajax.reload( function () {});	
  		} else if (tapTemp == 1) {
  			$('#inspectionListTable002').DataTable().ajax.reload( function () {});	
  		} else if (tapTemp == 2) {
  			$('#inspectionListTable003').DataTable().ajax.reload( function () {});	
  		}
  		

    });

    function matrlSelectSet(){
		$.ajax({
            url: '<c:url value="/qm/inspectMatrlCodeList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'chooseDateFrom'	: 		function() { return $('#chooseDateFrom').val() },
	           	'chooseDateTo'		: 		function() { return $('#chooseDateTo').val() + ' 23:59:59.999'; },
	           	'matrlGubunCd'		: 		'001',           
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {	
                    $('#matrlCd').empty();
                    var matrlCdList = new Array();	//matrlCdList
                    for(var i=0; i<data.length; i++){
                    	var json=new Object();
                    	json.baseCd=data[i].matrlCd;
                    	json.baseCdNm=data[i].matrlNm;
                    	matrlCdList.push(json);
                    }
                    selectBoxAppend(matrlCdList, "matrlCd", "", "1");
                } else {
               	 toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            }
        });
     }

	//보기 버튼 클릭 시
	function inspectionSelect(value){
		inspectlotNo 	= tapTextValue.row(value).data().lotNo;
       	inWhsGroupSeq 	= tapTextValue.row(value).data().inWhsGroupSeq;
       	matrlGubunCd 	= tapTextValue.row(value).data().matrlGubunCd;
       	matrlCd 		= tapTextValue.row(value).data().matrlCd;

    	if(tapTextValue.row(value).data().regDate == null){
        	toastr.warning("수입검사를 진행하지 않은 LOT 입니다.");
			return false;
        }
		
		$.ajax({
			url: '<c:url value="/qm/inspectList"/>',
			type: 'GET',
			dataType: 'json',
			data : {
				'inWhsGroupSeq'	: function(){return inWhsGroupSeq;},
				'matrlGubunCd'	: function(){return matrlGubunCd;},
				'matrlCd'		: function(){return matrlCd;},
				'lotNo'			: function(){return inspectlotNo;},
				'menuAuth'		: menuAuth,
			},	          
			success: function (res) {
				let data = res.data;
				let data2 = res.data2;
				let data3 = res.data3;  	              
				let matrlData = res.matrlData;  	
				sideView = 'edit';
				if (res.result == 'ok') {
					if(matrlGubunCd=="001"){
						matrl001_clear();  	            	     	
						matrl001_enable_list(data,data2,data3,matrlData);
						$('#realMatrlPopUpModal').modal({backdrop: 'static'});
						$('#realMatrlPopUpModal').modal('show');
					} else if(matrlGubunCd=="002"){
						matrl002_clear();  	            		
						matrl002_enable_list(data,data2,data3,matrlData);
						$('#rowMatrlPopUpModal').modal({backdrop: 'static'});
						$('#rowMatrlPopUpModal').modal('show');
					} else{
						matrl003_clear();  	            		
						matrl003_enable_list(data,data2,data3,matrlData);	          
						$('#procMatrlPopUpModal').modal({backdrop: 'static'});  		
						$('#procMatrlPopUpModal').modal('show');
					}
				} else if(res.result == 'fail'){
					if(matrlGubunCd=="001"){
						matrl001_clear();
	            		matrl001_disabled_list(data,matrlData);
	            		$('#realMatrlPopUpModal').modal({backdrop: 'static'});
		            	$('#realMatrlPopUpModal').modal('show');
	            	} else if(matrlGubunCd=="002"){
	            		matrl002_clear();
	            		matrl002_disabled_list(data,matrlData);
	            		$('#rowMatrlPopUpModal').modal({backdrop: 'static'});
	            		$('#rowMatrlPopUpModal').modal('show');
	            	} else{
	            		matrl003_clear();
	            		matrl003_disabled_list(data,matrlData);
	            		$('#procMatrlPopUpModal').modal({backdrop: 'static'});  	
	            		$('#procMatrlPopUpModal').modal('show');
	            	}
	            } else{
		            toastr.error(res.message, '', {timeOut: 5000});
				}
			},
		});
	}

    //자재 더블 클릭 시
    $('#inspectionListTable001 , #inspectionListTable002, #inspectionListTable003 tbody').on('dblclick', 'tr', function () {
       	inspectlotNo 	= tapTextValue.row( this ).data().lotNo;
       	inWhsGroupSeq 	= tapTextValue.row( this ).data().inWhsGroupSeq;
       	matrlGubunCd 	= tapTextValue.row( this ).data().matrlGubunCd;
       	matrlCd 		= tapTextValue.row( this ).data().matrlCd;

		$.ajax({
			url: '<c:url value="/qm/inspectList"/>',
			type: 'GET',
			dataType: 'json',
			data : {
				'inWhsGroupSeq'	: function(){return inWhsGroupSeq;},
				'matrlGubunCd'	: function(){return matrlGubunCd;},
				'matrlCd'		: function(){return matrlCd;},
				'lotNo'			: function(){return inspectlotNo;},
				'menuAuth'		: menuAuth,
			},	          
			success: function (res) {
				let data 		= res.data;
				let data2 		= res.data2;
				let data3 		= res.data3;  	              
				let matrlData 	= res.matrlData;  	
				sideView = 'edit';
				if (res.result == 'ok') {
					if(matrlGubunCd=="001"){
						matrl001_clear();  	            	     	
						matrl001_enable_list(data,data2,data3,matrlData);
						$('#realMatrlPopUpModal').modal({backdrop: 'static'});
						$('#realMatrlPopUpModal').modal('show');
					} else if(matrlGubunCd=="002"){
						matrl002_clear();  	            		
						matrl002_enable_list(data,data2,data3,matrlData);
						$('#rowMatrlPopUpModal').modal({backdrop: 'static'});
						$('#rowMatrlPopUpModal').modal('show');
					} else{
						matrl003_clear();  	            		
						matrl003_enable_list(data,data2,data3,matrlData);	          
						$('#procMatrlPopUpModal').modal({backdrop: 'static'});  		
						$('#procMatrlPopUpModal').modal('show');
					}
				} else if(res.result == 'fail'){
					if(matrlGubunCd=="001"){
						matrl001_clear();
	            		matrl001_disabled_list(data,matrlData);
	            		$('#realMatrlPopUpModal').modal({backdrop: 'static'});
		            	$('#realMatrlPopUpModal').modal('show');
	            	} else if(matrlGubunCd=="002"){
	            		matrl002_clear();
	            		matrl002_disabled_list(data,matrlData);
	            		$('#rowMatrlPopUpModal').modal({backdrop: 'static'});
	            		$('#rowMatrlPopUpModal').modal('show');
	            	} else{
	            		matrl003_clear();
	            		matrl003_disabled_list(data,matrlData);
	            		$('#procMatrlPopUpModal').modal({backdrop: 'static'});  	
	            		$('#procMatrlPopUpModal').modal('show');
	            	}
	            } else{
		            toastr.error(res.message, '', {timeOut: 5000});
 	              }
 	          },
 	          //complete:function(){
 	              //$('#btnAddConfirm').removeClass('d-none');
 	              //$('#btnAddConfirmLoading').addClass('d-none');
 	          //}
 	      });
    });

	function matrl001_clear() {
    	$('#matrl001_inspectItem1_1').val(""); 
      	$('#matrl001_inspectItem1_2').val("");
      	
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem1_3", "001", "");
      	$('#matrl001_inspectItem1_4').val("");            	
      	$('#matrl001_inspectItem2_1').val("");
      	$('#matrl001_inspectItem2_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem2_3", "001", "");
      	$('#matrl001_inspectItem2_4').val("");
      	$('#matrl001_inspectItem3_1').val("");
      	$('#matrl001_inspectItem3_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem3_3", "001", "");
      	$('#matrl001_inspectItem3_4').val("");
      	$('#matrl001_inspectItem4_1').val("");
      	$('#matrl001_inspectItem4_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem4_3", "001", "");
      	$('#matrl001_inspectItem4_4').val("");
      	$('#matrl001_inspectItem5_1').val("");
      	$('#matrl001_inspectItem5_2').val("");
     	selectBoxAppend(approvalCheck, "matrl001_inspectItem5_3", "001", "");
      	$('#matrl001_inspectItem5_4').val("");
      	$('#matrl001_inspectItem6_1').val("");
      	$('#matrl001_inspectItem6_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem6_3", "001", "");
      	$('#matrl001_inspectItem6_4').val("");
      	$('#matrl001_inspectItem7_1').val("");
      	$('#matrl001_inspectItem7_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem7_3", "001", "");
      	$('#matrl001_inspectItem7_4').val("");

      	$('#matrl001_inspectItem8_1').val("");
      	$('#matrl001_inspectItem8_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem8_3", "", "2");
      	$('#matrl001_inspectItem8_4').val("")
      	$('#matrl001_inspectItem9_1').val("");
      	$('#matrl001_inspectItem9_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem9_3", "", "2");
      	$('#matrl001_inspectItem9_4').val("")
      	$('#matrl001_inspectItem10_1').val("");
      	$('#matrl001_inspectItem10_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem10_3", "", "2");
      	$('#matrl001_inspectItem10_4').val("")
      	$('#matrl001_inspectItem11_1').val("");
      	$('#matrl001_inspectItem11_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem11_3", "", "2");
      	$('#matrl001_inspectItem11_4').val("")
      	$('#matrl001_inspectItem12_1').val("");
      	$('#matrl001_inspectItem12_2').val("");
      	selectBoxAppend(approvalCheck, "matrl001_inspectItem12_3", "", "2");
      	$('#matrl001_inspectItem12_4').val("")

      	$('#matrl001_input1_1').val("");
      	$('#matrl001_input1_2').val("");
      	$('#matrl001_input1_3').val("");
      	$('#matrl001_input1_4').val("0");
      	$('#matrl001_input1_5').val("0");
      	$('#matrl001_input1_6').val("0");
      	$('#matrl001_input1_7').val("0");
      	$('#matrl001_input1_8').val("0");
      	$('#matrl001_input1_9').val("0");
      	$('#matrl001_input1_10').val("");    	
      	$('#matrl001_input2_1').val("");
      	$('#matrl001_input2_2').val("");
      	$('#matrl001_input2_3').val("0");
      	$('#matrl001_input2_4').val("0");
      	$('#matrl001_input2_5').val("0");
      	$('#matrl001_input2_6').val("0");
      	$('#matrl001_input2_7').val("0");
      	$('#matrl001_input2_8').val("0");
      	$('#matrl001_input2_9').val("");     	
      	$('#matrl001_input3_1').val("");
      	$('#matrl001_input3_2').val("");
      	$('#matrl001_input3_3').val("0");
      	$('#matrl001_input3_4').val("0");
      	$('#matrl001_input3_5').val("0");
      	$('#matrl001_input3_6').val("0");
      	$('#matrl001_input3_7').val("0");
      	$('#matrl001_input3_8').val("0");
      	$('#matrl001_input3_9').val("");     	
      	$('#matrl001_input4_1').val("");
      	$('#matrl001_input4_2').val("");
      	$('#matrl001_input4_3').val("");
      	$('#matrl001_input4_4').val("");
      	$('#matrl001_input4_5').val("");
      	$('#matrl001_input4_6').val("");
      	$('#matrl001_input4_7').val("");
      
      	$('#matrl001_input4_10').val("");      	
      	$('#matrl001_input5_1').val("");
      	$('#matrl001_input5_2').val("");
      	$('#matrl001_input5_3').val("");
      	$('#matrl001_input5_4').val("");
      	$('#matrl001_input5_5').val("0");
      	$('#matrl001_input5_6').val("0");
      	$('#matrl001_input5_7').val("0");
      	$('#matrl001_input5_8').val("");     	
      	$('#matrl001_input6_1').val("");
      	$('#matrl001_input6_2').val("");
      	$('#matrl001_input6_3').val("");
      	$('#matrl001_input6_4').val("");
      	$('#matrl001_input6_5').val("");     	
      	$('#matrl001_input7_1').val("");
      	$('#matrl001_input7_2').val("");
      	$('#matrl001_input7_3').val("");
      	$('#matrl001_input7_4').val("");
      	$('#matrl001_input7_5').val("");
      	  	
      	$('#matrl001_input8_1').val("");
      	$('#matrl001_input8_2').val("");
      	$('#matrl001_input8_3').val("");
      	$('#matrl001_input8_4').val("");
      	$('#matrl001_input8_5').val("");
      	$('#matrl001_input8_6').val("");
      	//$('#matrl001_input8_7').val("");
      
      	$('#matrl001_input8_18').val("");	            	
      	$('#matrl001_input9_1').val("");
      	$('#matrl001_input9_2').val("");
      	$('#matrl001_input9_3').val("");
      	$('#matrl001_input9_4').val("");
      	$('#matrl001_input9_5').val("");
      	$('#matrl001_input9_6').val("0");
      	$('#matrl001_input9_7').val("0");
      	$('#matrl001_input9_8').val("0");
      	$('#matrl001_input9_9').val("0");
      	$('#matrl001_input9_10').val("0");
      	$('#matrl001_input9_11').val("0");
      	$('#matrl001_input9_12').val("0");
      	$('#matrl001_input9_13').val("0");
      	$('#matrl001_input9_14').val("0");
      	$('#matrl001_input9_15').val("0");
      	$('#matrl001_input9_16').val("0");
      	$('#matrl001_input9_17').val("");
    }
      
	function matrl002_clear() {
		$('#matrl002_input1_2').val("");
    	$('#matrl002_input1_3').val("");
    	selectBoxAppend(approvalCheck, "matrl002_input1_4", "001", "");
    	$('#matrl002_input1_5').val("");	            		

    	$('#matrl002_input2_2').val("");
    	$('#matrl002_input2_3').val("");
    	selectBoxAppend(approvalCheck, "matrl002_input2_4", "001", "");
    	$('#matrl002_input2_5').val("");	            		

    	$('#matrl002_input3_2').val("");
    	$('#matrl002_input3_3').val("");
    	selectBoxAppend(approvalCheck, "matrl002_input3_4", "001", "");
    	$('#matrl002_input3_5').val("");

    	$('#matrl002_input4_2').val("");
    	$('#matrl002_input4_3').val("");
    	$('#matrl002_input4_4').val("");
    	$('#matrl002_input4_5').val("");
    	$('#matrl002_input4_6').val("");
    	$('#matrl002_input5_1').val("");
    	$('#matrl002_input5_2').val("");
    	$('#matrl002_input5_3').val("");
    	$('#matrl002_input5_4').val("");

    	$('#matrl002_input6_2').val("");
    	$('#matrl002_input6_3').val("");
    	selectBoxAppend(approvalCheck, "matrl002_input6_4", "", "2");
    	$('#matrl002_input6_5').val("");

    	$('#matrl002_input7_2').val("");
    	$('#matrl002_input7_3').val("");
    	selectBoxAppend(approvalCheck, "matrl002_input7_4", "", "2");
    	$('#matrl002_input7_5').val("");
	}

	function matrl003_clear() {
		$('#matrl003_input1_2').val("");
    	$('#matrl003_input1_3').val("");
    	selectBoxAppend(approvalCheck, "matrl003_input1_4", "001", "");
    	$('#matrl003_input1_5').val("");	            		

    	$('#matrl003_input2_2').val("");
    	$('#matrl003_input2_3').val("");
    	selectBoxAppend(approvalCheck, "matrl003_input2_4", "001", "");
    	$('#matrl003_input2_5').val("");	            		

    	$('#matrl003_input3_2').val("");
    	$('#matrl003_input3_3').val("");
    	selectBoxAppend(approvalCheck, "matrl003_input3_4", "001", "");
    	$('#matrl003_input3_5').val("");	            		

    	$('#matrl003_input4_2').val("");	            		
    	$('#matrl003_input4_3').val("");
    	$('#matrl003_input4_4').val("");
    	$('#matrl003_input4_5').val("");
    	$('#matrl003_input4_6').val("");
    	
    	$('#matrl003_input5_2').val("");
    	$('#matrl003_input5_3').val("");
    	selectBoxAppend(approvalCheck, "matrl003_input5_4", "", "2");
    	$('#matrl003_input5_5').val("");

    	$('#matrl003_input6_2').val("");
    	$('#matrl003_input6_3').val("");
    	selectBoxAppend(approvalCheck, "matrl003_input6_4", "", "2");
    	$('#matrl003_input6_5').val("");
	}

	var matrl001_list_idx = 0;
      
	function matrl001_disabled_list(data ,matrlData){
		var inspectHtml = '';
   		matrl001_list_idx = 0;
   		$.each(managementCode, function(index, item){
   			if(item.etc1 == "001"){
   				inspectHtml += '<tr>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem' + (index + 1) + '_1" value="'+item.baseCdNm+'" disabled/>';
   				inspectHtml += '<input  	type="hidden" id="matrl001_inspectItem' + (index + 1) + '" value="'+item.baseCd+'"/> </td>';
   				inspectHtml += '<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem' + (index + 1) + '_2" value="'+item.baseCdAbbr+'" disabled/></td>';
   				inspectHtml += '<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem' + (index + 1) + '_3"></select></td>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem' + (index + 1) + '_4" value=""/></td>';			    
   				inspectHtml += '</tr>';                                                         
   				matrl001_list_idx++;                                                  
   			}
   		});

   		$('#matrlTbody001').html(inspectHtml);
   		$.each(managementCode, function(index, item){
   			selectBoxAppend(approvalCheck, "matrl001_inspectItem"+(index+1)+"_3", "001", "");
   			$('#matrl001_inspectItem'+(index+1)+'_4').val("");      
   		});
   		selectBoxAppend(approvalCheck, "matrl001_inspectItem4_3", "001", "");

   		$('#matrl001_input1_1').val(data[11][0]);
   		$('#matrl001_input1_2').val(data[11][1]);
   		$('#matrl001_input1_3').val(matrlData.thickness + " " + gongcha(data[11][3],data[11][4]));
   		$('#matrl001_input2_1').val(data[11][5]);
   		$('#matrl001_input2_2').val(matrlData.depth + " " + gongcha(data[11][7],data[11][8]));
   		$('#matrl001_input3_1').val(data[11][9]);
   		$('#matrl001_input3_2').val(data[11][10]);
   		
   		$('#matrl001_input4_1').val(data[12][0]);
   		$('#matrl001_input4_2').val(data[12][1]);
   		$('#matrl001_input4_3').val(data[12][2]);
   		$('#matrl001_input4_4').val(data[12][3]);
   		$('#matrl001_input4_5').val(data[12][4]);
   		$('#matrl001_input4_6').val(data[12][5]);		            	
   		$('#matrl001_input5_1').val(data[12][8]);
   		$('#matrl001_input5_2').val(data[12][9]);
   		$('#matrl001_input5_3').val(data[12][10]);
   		$('#matrl001_input5_4').val(data[12][11]);
   		// $('#matrl001_input5_5').val(data[12][4]);
   		
   		$('#matrl001_input6_1').val(data[12][14]);
   		$('#matrl001_input6_2').val(data[12][15]);
   		
   		$('#matrl001_input7_1').val(data[12][18]);
   		$('#matrl001_input7_2').val(data[12][19]);
   		
   		$('#matrl001_input8_1').val(data[13][0]);
   		$('#matrl001_input8_2').val(data[13][1]);
   		$('#matrl001_input8_3').val(data[13][2]);
   		$('#matrl001_input8_4').val(data[13][3]);
   		$('#matrl001_input8_5').val(data[13][4]);
   		$('#matrl001_input8_6').val(data[13][5]);
   		
   		$('#matrl001_input9_1').val(data[13][1]);
   		$('#matrl001_input9_2').val(data[13][8]);
   		$('#matrl001_input9_3').val(data[13][9]);
   		$('#matrl001_input9_4').val(data[13][10]);
   		$('#matrl001_input9_5').val(data[13][11]);
	}
      
	function matrl001_enable_list(data,data2,data3, matrlData){
		$('#realMatrlDay').text(moment(data3[0].inspectDate).format('YYYY-MM-DD'));
    	  
   		var inspectHtml = '';
   		matrl001_list_idx = 0;
   		$.each(data3, function(index, item){
   			if(item.matrlGubunCd == "001"){
   				inspectHtml += '<tr>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem' + (index + 1) + '_1" value="'+item.managementNm+'" disabled/>';
   				inspectHtml += '<input  	type="hidden" id="matrl001_inspectItem' + (index + 1) + '" value="'+item.managementCd+'"/> </td>';
   				inspectHtml += '<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem' + (index + 1) + '_2" value="'+item.modelNm+'" disabled/></td>';
   				inspectHtml += '<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem' + (index + 1) + '_3" disabled></select></td>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem' + (index + 1) + '_4" value="'+item.inspectEtc+'"/ disabled></td>';			    
   				inspectHtml += '</tr>';                                                         
   				matrl001_list_idx++;                                                  
   			}
   		});
   		$('#matrlTbody001').html(inspectHtml);
   		$.each(data3, function(index, item){
   			selectBoxAppend(approvalCheck, "matrl001_inspectItem"+(index+1)+"_3", ""+ item.resultCd +"", "");			
   		});		

   		$('#matrl001_input1_1').val(data[11][0]);
   		$('#matrl001_input1_2').val(data[11][1]);
   		$('#matrl001_input1_3').val(matrlData.thickness + " " + gongcha(data[11][3],data[11][4]));
   		$('#matrl001_input2_1').val(data[11][5]);
   		$('#matrl001_input2_2').val(matrlData.depth + " " + gongcha(data[11][7],data[11][8]));
   		$('#matrl001_input3_1').val(data[11][9]);
   		$('#matrl001_input3_2').val(data[11][10]);
   		
   		$('#matrl001_input4_1').val(data[12][0]);
   		$('#matrl001_input4_2').val(data[12][1]);
   		$('#matrl001_input4_3').val(data[12][2]);
   		$('#matrl001_input4_4').val(data[12][3]);
   		$('#matrl001_input4_5').val(data[12][4]);
   		$('#matrl001_input4_6').val(data[12][5]);		            	
   		$('#matrl001_input5_1').val(data[12][8]);
   		$('#matrl001_input5_2').val(data[12][9]);
   		$('#matrl001_input5_3').val(data[12][10]);
   		$('#matrl001_input5_4').val(data[12][11]);
   		// $('#matrl001_input5_5').val(data[12][4]);
   		
   		$('#matrl001_input6_1').val(data[12][14]);
   		$('#matrl001_input6_2').val(data[12][15]);
   		
   		$('#matrl001_input7_1').val(data[12][18]);
   		$('#matrl001_input7_2').val(data[12][19]);
   		
   		$('#matrl001_input8_1').val(data[13][0]);
   		$('#matrl001_input8_2').val(data[13][1]);
   		$('#matrl001_input8_3').val(data[13][2]);
   		$('#matrl001_input8_4').val(data[13][3]);
   		$('#matrl001_input8_5').val(data[13][4]);
   		$('#matrl001_input8_6').val(data[13][5]);
   		
   		$('#matrl001_input9_1').val(data[13][1]);
   		$('#matrl001_input9_2').val(data[13][8]);
   		$('#matrl001_input9_3').val(data[13][9]);
   		$('#matrl001_input9_4').val(data[13][10]);
   		$('#matrl001_input9_5').val(data[13][11]);

   		$('#matrl001_input1_4').val(data2[0][3]);
   		$('#matrl001_input1_5').val(data2[0][4]);
   		$('#matrl001_input1_6').val(data2[0][5]);
   		$('#matrl001_input1_7').val(data2[0][6]);
   		$('#matrl001_input1_8').val(data2[0][7]);
   		$('#matrl001_input1_9').val(data2[0][8]);
   		$('#matrl001_input1_10').val(data2[0][9]); 
   		
   		$('#matrl001_input2_3').val(data2[1][2]);
   		$('#matrl001_input2_4').val(data2[1][3]);
   		$('#matrl001_input2_5').val(data2[1][4]);
   		$('#matrl001_input2_6').val(data2[1][5]);
   		$('#matrl001_input2_7').val(data2[1][6]);
   		$('#matrl001_input2_8').val(data2[1][7]);
   		$('#matrl001_input2_9').val(data2[1][8]);     	
   		
   		$('#matrl001_input3_3').val(data2[2][2]);
   		$('#matrl001_input3_4').val(data2[2][3]);
   		$('#matrl001_input3_5').val(data2[2][4]);
   		$('#matrl001_input3_6').val(data2[2][5]);
   		$('#matrl001_input3_7').val(data2[2][6]);
   		$('#matrl001_input3_8').val(data2[2][7]);
   		$('#matrl001_input3_9').val(data2[2][8]);     	
   		
   		$('#matrl001_input4_10').val(data2[3][9]); 
   		
   		$('#matrl001_input5_5').val(data2[4][4]);
   		$('#matrl001_input5_6').val(data2[4][5]);
   		$('#matrl001_input5_7').val(data2[4][6]);
   		$('#matrl001_input5_8').val(data2[4][7]);     
   		
   		$('#matrl001_input6_4').val(data2[5][3]);
   		$('#matrl001_input6_5').val(data2[5][4]); 
   		
   		$('#matrl001_input7_4').val(data2[6][3]);
   		$('#matrl001_input7_5').val(data2[6][4]);     	
   		
   		$('#matrl001_input8_18').val(data2[7][17]);			            	
   		
   		$('#matrl001_input9_6').val(data2[8][5]);
   		$('#matrl001_input9_7').val(data2[8][6]);
   		$('#matrl001_input9_8').val(data2[8][7]);
   		$('#matrl001_input9_9').val(data2[8][8]);
   		$('#matrl001_input9_10').val(data2[8][9]);
   		$('#matrl001_input9_11').val(data2[8][10]);
   		$('#matrl001_input9_12').val(data2[8][11]);
   		$('#matrl001_input9_13').val(data2[8][12]);
   		$('#matrl001_input9_14').val(data2[8][13]);
   		$('#matrl001_input9_15').val(data2[8][14]);
   		$('#matrl001_input9_16').val(data2[8][15]);
   		$('#matrl001_input9_17').val(data2[8][16]);
	}
	
	var matrl002_list_idx = 0;
	
	function matrl002_disabled_list(data ,matrlData){
		var inspectHtml = '';
   		matrl002_list_idx = 0;
   		$.each(managementCode, function(index, item){
   			if(item.etc1 == "002"){
   				inspectHtml += '<tr>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_1" value="' + (matrl002_list_idx+1) +'" disabled/>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_2" value="'+item.baseCdNm+'" disabled/>';
   				inspectHtml += '<input  	type="hidden" id="matrl002_inspectItem' + (index + 1) + '" value="'+item.baseCd+'"/> </td>';
   				if((matrl002_list_idx+1) == 4){
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_3" value="'+ matrlData.thickness + item.baseCdAbbr.substring(6,11)+'" disabled/></td>';
   				} else if((matrl002_list_idx+1) ==5){
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_3" value="'+ matrlData.depth + item.baseCdAbbr.substring(5,10)+'" disabled/></td>';
   				} else{
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_3" value="'+ item.baseCdAbbr+'" disabled/></td>';
   				}
   			
   				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_4"></select></td>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_5" value=""/></td>';			    
   				inspectHtml += '</tr>';                                                         
   				matrl002_list_idx++;                                                  
   			}
   		});

   		$('#matrlTbody002').html(inspectHtml);
   		$.each(managementCode, function(index, item){
   			selectBoxAppend(approvalCheck, "matrl002_inspectItem"+(index+1)+"_4", "001", "");
   			$('#matrl002_inspectItem'+(index+1)+'_5').val("");      
   		});
   		//selectBoxAppend(approvalCheck, "matrl002_inspectItem4_3", "001", "");
	}
      
	function matrl002_enable_list(data,data2,data3,matrlData){
// 		$('#rowMatrlDay').text(data3[0].regDate.substring(0,10));
// 		$('#rowMatrlDay').text(data3[0].inspectDate);
		$('#rowMatrlDay').text(moment(data3[0].inspectDate).format('YYYY-MM-DD'));
		var inspectHtml = '';
   		matrl002_list_idx = 0;
   		$.each(data3, function(index, item){
   			if(item.matrlGubunCd == "002"){
   				inspectHtml += '<tr>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_1" value="' + (matrl002_list_idx+1) +'" disabled/>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_2" value="'+item.managementNm+'" disabled/>';
   				inspectHtml += '<input  	type="hidden" id="matrl002_inspectItem' + (index + 1) + '" value="'+item.managementCd+'" disabled/> </td>';
   				if((matrl002_list_idx+1) == 4){
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_3" value="'+matrlData.thickness + item.modelNm.substring(6,11)+'" disabled/></td>';
   				} else if((matrl002_list_idx+1) ==5){
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_3" value="'+ matrlData.depth + item.modelNm.substring(5,10)+'" disabled/></td>';
   				} else{
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_3" value="'+ item.modelNm+'" disabled/></td>';
   				}
   			
   				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_4" disabled></select></td>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_5" value="'+item.inspectEtc+'" disabled/></td>';			    
   				inspectHtml += '</tr>';                                                         
   				matrl002_list_idx++;                                                  
   			}
   		});

   		$('#matrlTbody002').html(inspectHtml);
   		$.each(data3, function(index, item){
   			selectBoxAppend(approvalCheck, "matrl002_inspectItem"+(index+1)+"_4", item.resultCd, "");			
   		});
   	}

   	var matrl003_list_idx = 0;
   	
   	function matrl003_disabled_list(data ,matrlData){
		var inspectHtml = '';
		matrl003_list_idx = 0;
		$.each(managementCode, function(index, item){
   			if(item.etc1 == "003"){
   				inspectHtml += '<tr>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_1" value="' + (matrl003_list_idx+1) +'" disabled/>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_2" value="'+item.baseCdNm+'" disabled/>';
   				inspectHtml += '<input  	type="hidden" id="matrl003_inspectItem' + (index + 1) + '" value="'+item.baseCd+'"/> </td>';
   				if((matrl003_list_idx+1) == 4){
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_3" value="'+ matrlData.depth + item.baseCdAbbr.substring(6,11)+'" disabled/></td>';				
   				} else{
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_3" value="'+ item.baseCdAbbr+'" disabled/></td>';
   				}
   			
   				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_4"></select></td>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_5" value=""/></td>';			    
   				inspectHtml += '</tr>';                                                         
   				matrl003_list_idx++;                                                  
   			}
   		});
   		$('#matrlTbody003').html(inspectHtml);
   		$.each(managementCode, function(index, item){
   			selectBoxAppend(approvalCheck, "matrl003_inspectItem"+(index+1)+"_4", "001", "");
   			$('#matrl003_inspectItem'+(index+1)+'_5').val("");      
   		});
   	}
      
	function matrl003_enable_list(data,data2,data3,matrlData){
// 		$('#procMatrlDay').text(data3[0].regDate.substring(0,10));
// 		$('#procMatrlDay').text(data3[0].inspectDate);
		$('#procMatrlDay').text(moment(data3[0].inspectDate).format('YYYY-MM-DD'));
		var inspectHtml = '';
   		matrl003_list_idx = 0;
   		$.each(data3, function(index, item){
   			if(item.matrlGubunCd == "003"){
   				inspectHtml += '<tr>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_1" value="' + (matrl003_list_idx+1) +'" disabled/>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_2" value="'+item.managementNm+'" disabled/>';
   				inspectHtml += '<input  	type="hidden" id="matrl003_inspectItem' + (index + 1) + '" value="'+item.managementCd+'" disabled/> </td>';
   				if((matrl003_list_idx+1) == 4){
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_3" value="'+ matrlData.depth + item.modelNm.substring(6,11)+'" disabled/></td>';				
   				} else{
   					inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_3" value="'+ item.modelNm+'" disabled/></td>';
   				}
   			
   				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_4" disabled></select></td>';
   				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem' + (matrl003_list_idx + 1) + '_5" value="'+item.inspectEtc+'" disabled/></td>';			    
   				inspectHtml += '</tr>';                                                         
   				matrl003_list_idx++;                                                  
   			}
   		});

   		$('#matrlTbody003').html(inspectHtml);
   		$.each(data3, function(index, item){
   			selectBoxAppend(approvalCheck, "matrl003_inspectItem"+(index+1)+"_4", item.resultCd , "");	  
   		});
	}
      
	function gongcha(plus, minus){
		var result;
		if((plus == 'undefined' || minus == 'undefined') || (plus == '' || minus == '') || (plus == null || minus == null)){
			result = "";
			return result;
		}	 	 
		
		if(plus == minus){
			result = "±" + plus;
		} else{
			result = "+" + plus + " " + "-" + minus;
		} 
		return result;
   }
	//colspan 배열에 담기
	let triggerVal;//1행(위에서부터 2번째줄)에서 다음칸으로 넘어갈 때 사용되는 변수
	let gubunVal;//1행에서 FOR문을 실행하면서 upperHead(0행의 헤더)의 rowspan이 3인경우(꽉채운경우) 올라가는 보정치만큼 뺴주기위한 변수
	let lastRowCorrection;
	function colspanGroupArray( tableName, row, tDivision, trSize, notExistColspanValue, ghostYn, rowData){
	 	//tableName: 테이블 명
	 	//row: 계산하고자 하는  행(0번 부터)
	 	//tDivision: th or td 선택자
	 	//trSize: 계산하고자하는 행 크기
	 	//notExistColspanValue: 계산하고자 하는 행에 calspan이 존재하지 않는 컬럼 개수(앞에서 값으로만 판단, 중간 값은 사용 못함)
	 	//ghostYn: rowspan으로 합쳐진 값이 존재하는지 여부( Y, N ) / 추가로 empty는 colspan, rowspan없이 쭉 이어진 값 
		//berowData : 이전행 데이터 
		let berowData = rowData;
	 	let dt;
	 	let temporaryArray = new Array();
	 	let exceptionArray = new Array();	//empty에서만 사용
  		let temporaryObj = new Object();
    	let temporaryColspanSum = 0; 
    	triggerVal = notExistColspanValue;
    	gubunVal = 0;
    	lastRowCorrection = 0;
    	let thirdIdx = 0;
	 	if( ghostYn == 'Y'){
	 		for(var i = 0; i < trSize; i++) {
	 			dt = $('#'+tableName+' thead tr').eq(row).find( tDivision ).eq(i);
		   	    temporaryObj = new Object();
		   	    if( i < notExistColspanValue ){
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = i;
		   	     temporaryObj.rowspan = dt.attr('rowspan');
		   	        colspanSum = i;
		   	    } else {	
		   	        if( i == notExistColspanValue ) {
		   	            colspanSum += 1;
		   	        }
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = colspanSum;
					//if(dt.attr('rowspan') != '' && dt.attr('rowspan') != undefined){
						temporaryObj.rowspan = dt.attr('rowspan');
					//}
		   	     	temporaryObj.colspan = colspanSum;
		   	        
		   	        colspanSum += parseInt(  dt.attr('colspan') );
		   	    }
		   	 temporaryArray.push(temporaryObj);
		   	}
	 		return temporaryArray;
		} else if( ghostYn == 'N' ) {
			//console.log("for문 반복 횟수 : "+ ( trSize + notExistColspanValue ));
			for(var i=0; i <= ( trSize + notExistColspanValue ) + gubunVal ; i++) {
				
				if( triggerVal == berowData.length){
					triggerVal--;
				}
				//console.log("트리거값:"+triggerVal);
	 			dt = $('#'+tableName+' thead tr').eq(row).find( tDivision ).eq( (i-notExistColspanValue - gubunVal )  );
		   	    temporaryObj = new Object();
		   	    if(!dt.hasClass('d-none')){			   	    
			   	    if( dt.find('colspan') != 1 ) {

			   	    	if( i < notExistColspanValue ){
				   	        temporaryObj.name = '';
				   	        temporaryObj.colspan = i;

				   	        temporaryObj.realColspan = dt.attr('colspan');
				   	   	 	temporaryObj.realRowspan = dt.attr('rowspan');
				   	        colspanSum = i;
				   	    } else {
				   	        if( i == notExistColspanValue ) {
				   	            colspanSum += 1;
				   	        }
							var colVal;
							if ( triggerVal+1 < berowData.length){
								colVal = berowData[triggerVal+1].colspan-1;
							} else if ( triggerVal+1 == berowData.length ) {
								colVal = berowData[triggerVal].colspan-1;
				   	    	} else {
								toast.error("시스템 오류가 발생하였습니다. 에러코드 : ExcelGost-002")
					   	    }
							if( colVal > colspanSum){ //현재 열과 다음 열의 차이가 현재 그리고있는 열보다 작은 경우 -> 이전행의 헤더의 소분류를 그리고 있는중  									
							   	    temporaryObj.name = dt.text();
						   	        temporaryObj.colspan = colspanSum;	
						   	     	temporaryObj.upperHead = berowData[triggerVal].name;
						   	        temporaryObj.realColspan = dt.attr('colspan');
						   	   	 	temporaryObj.realRowspan = dt.attr('rowspan');
						   	    	colspanSum += parseInt(  dt.attr('colspan') );
							} else{ 
								if( berowData[triggerVal].rowspan < $('#'+tableName+' thead tr').length){									
									temporaryObj.name = dt.text();
							   	    temporaryObj.colspan = colspanSum;	
						   	     	temporaryObj.upperHead = berowData[triggerVal].name;
						   	        temporaryObj.realColspan = dt.attr('colspan');
						   	   	 	temporaryObj.realRowspan = dt.attr('rowspan');
							   		colspanSum += parseInt(  dt.attr('colspan') );
							   		triggerVal++;
							   		if( colspanSum == colVal){
							   			triggerVal++;
								   	}
								} else {
									temporaryObj.name = '';
									temporaryObj.rowspan = 3;
								    temporaryObj.colspan = colspanSum;
						   	     	temporaryObj.upperHead = berowData[triggerVal].name;
						   	        temporaryObj.realColspan = dt.attr('colspan');
						   	   	 	temporaryObj.realRowspan = dt.attr('rowspan');
									gubunVal++;
									triggerVal++;
									colspanSum++;
								}
		  
							}
				   	    }
					} else {
						temporaryObj.name = dt.text();
			   	        temporaryObj.colspan = colspanSum;
			   	        colspanSum += parseInt(  dt.attr('colspan') );
			   	        
					}
					//console.log(temporaryObj.name);
					temporaryArray.push(temporaryObj);
		   	    }
		   	}
		   	// console.log("구분값 : "+gubunVal);
			return temporaryArray;
		} else if( ghostYn == 'empty' ) {
			for(var i=0; i < /*( trSize + notExistColspanValue ) */berowData.length; i++) {
				dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( /* (i-notExistColspanValue) */thirdIdx  );
				if( i < notExistColspanValue ){
					exceptionArray[i+lastRowCorrection] = '';
			    } else if ( berowData[i].realRowspan == 1 && berowData[i].realColspan != 1 && berowData[i].rowspan != 3) {
					for( var q=0; q<berowData[i].realColspan;q++){
						dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( thirdIdx );
						exceptionArray[i+q+lastRowCorrection] = dt.text();
						//console.log("추가된 문구 : "+dt.text()+" 추가된 I+Q+보정치 : "+(i+q+lastRowCorrection));
						thirdIdx++;
					}	
					lastRowCorrection+=berowData[i].realColspan-1;		
			    	
			    } else{
			    	exceptionArray[i+lastRowCorrection] = '';
				}
			}
			return exceptionArray;
		} else {
			toastr.error("시스템 오류가 발생했습니다. - excelGhostError-A001");
			return false;
		}
	}


	//가공하고자 하는 행에 헤더 부분 header개수만큼 늘리기 끝
	function alignToTableSize( allDatalength, receivedArray ){
		//colspan된 배열을 가지고, 만들고자하는 길이 만클 데이터를 가공하는 곳
		//allDatalength: 전체 데이터 길이(이 개수만큼 배열이 생성됨)
		//receivedArray: 가공하고자하는 배열 값
		
		let temporaryIsCheck = true;	// brek 역할
		let temporaryArrayRow = new Array();
		
		for(var i=0; i<allDatalength; i++){
			temporaryIsCheck = true;
			
		    for(var j=0; j<receivedArray.length; j++){
		        switch (i){
		        case receivedArray[j].colspan:
		        	temporaryArrayRow.push(receivedArray[j].name);
		        temporaryIsCheck = false;
		            break;
		        default:
		            break;
		        }
		        
		    }
		    if(temporaryIsCheck){
		    	temporaryArrayRow.push(' ');
		    }
		}
		return temporaryArrayRow;
	}

	
	//가짜 엑셀 버튼 클릭 시
	$('#btnFakeExcel').on('click', function(){
// 		console.log("excelButton Click Check");
		inspectionListTable001.buttons(1)[0].inst.c.buttons[1].exportOptions.columns = '';	//c 초기화
		$('#my-spinner').show();
		notHiddenArray = new Array();
		
		for( var i=0; i<$('#inspectionListTable001 tbody tr').eq(0).find('td').length; i++){
    	    if(!$('#inspectionListTable001 tbody tr').eq(0).find('td').eq(i).hasClass('d-none')){
    	        notHiddenArray.push(i);
    	    }
    	}

		//c, s 값 columns를  notHiddenArray에 있는 배열로 교체
		inspectionListTable001.buttons(1)[0].inst.c.buttons[1].exportOptions.columns = notHiddenArray;
// 		allFaultTable.buttons(1)[0].inst.s.buttons[1].conf.exportOptions.columns = notHiddenArray;

		$('#btnRealExcel').click();
		$('#my-spinner').hide();
	});
	inspectionListTable001.on('draw.dt', function(){
		$('#btnFakeExcel').attr('disabled', false);
	});

	
	// 컴럼 숨김 처리 함수
//   	function columnVisibleFun(tableNm, codeLength, domTableId) {
// 		let frontTdNum = 0;	//전체 테이블 개수
		
// 		for( var i=0; i<$('#'+tableNm+' thead tr').eq(0).find('th').length; i++) {
// 	   		if( $('#'+tableNm+' thead tr').eq(0).find('th').eq(i).attr('rowspan') == 3) {
// 	   			frontTdNum++;
// 	   		}
// 		}
		
// 		frontTdNum += $('#'+tableNm+' thead tr').eq(1).find('th').length;

// 		let codeNum = $('#'+tableNm+' thead tr').eq(1).find('th').length - codeLength;

// 		codeNum = frontTdNum - codeNum;
		
// 		//★제거
// 		for( var i=0; i<frontTdNum; i++) {
// 		    if( i >= codeNum ) {
// 		    	domTableId.column( i ).visible( false );
// 		    }
// 		};
// 	}

  	function columnVisibleFun(num1, num2, domTableId) {
		//★제거
		for( var i=num1; i<=num2; i++) {
	    	domTableId.column( i ).visible( false );
		};
	}
	
</script>

</body>
</html>