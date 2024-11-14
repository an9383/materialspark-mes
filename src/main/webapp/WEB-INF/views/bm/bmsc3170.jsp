<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%	pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">
	<!-- Modal Start-->
	<div class="modal fade" id="layerPopUpModal" tabindex="-1"
		role="dialog" aria-labelledby="layerPopUpLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="layerPopUpLabel">기초코드등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<hr class="text-secondary">
					<table class="table table-sm table-bordered" id="layerPopUpTable">
					</table>
					<hr class="text-secondary">
				</div>
				<div class="modal-footer">
					<input type="hidden" class="form-control" id="puFlag" name="puFlag">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="layerPopUpSave">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End-->

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">품질정보관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-30" id="left-30" style="width: 28%;">
				<div class="card">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table class="table table-bordered" id="inspectInfoAdmCommonGroupCd">
							<thead class="thead-light">
								<tr>
									<th style="width: 20px" id="useYnCd">사용여부</th>
									<th style="width: 20px" id="baseGroupCd">기초코드</th>
									<th style="width: 100px" id="baseGroupCdNm">기초코드명</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
					<!-- .table-responsive -->
					<div class="table-responsive mt-1">
						<table id="matrlCdTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 50px;">자재코드</th>
									<th style="min-width: 150px;">자재명</th>
									<th style="min-width: 50px;">재질</th>
									<th style="min-width: 120px;">구분(연질/경질)</th>
									<th style="min-width: 50px;">두께</th>
									<th style="min-width: 50px;">폭</th>
									<th style="min-width: 50px;">너비</th>
									<th style="min-width: 50px;">길이</th>
									<th style="min-width: 50px;">피치</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<div class="right-list right-70" id="myrSidenav" style="width: 71%;">		
				<div id="matrl001" class="d-none">
					<div class="card-body col-sm-12 p-2" >
						<button type="button" class="btn btn-primary float-right mr-1" id="001btnSave">저장</button>
					</div>
					<table  class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th style="width:10%" >순번</th>
								<th style="width:20%">관리항목</th>
								<th style="width:50%" colspan="5">규격</th>
								<th style="width:10%">공차(+)</th>
								<th style="width:10%">공차(-)</th>
							</tr>
						</thead>
						<tr>
							<td align=center>1</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_1" value="Scratch" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_4" /></td>
						</tr>
						<tr>
							<td align=center>2</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_1" value="찍힘" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_4" /></td>
						</tr>
						<tr>
							<td align=center>3</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_1" value="이물" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_4" /></td>
						</tr>
						<tr>
							<td align=center>4</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_1" value="얼룩(오염)" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_4" /></td>
						</tr>
						<tr>
							<td align=center>5</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_1" value="권취" disabled></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_4" /></td>
						</tr>
						<tr>
							<td rowspan="3" align=center>6</td>
							<td	rowspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_1" value="치수" disabled></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_2" value="두께(mm)" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_3" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_4" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_5" /></td>
						</tr>
						<tr>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_6" value="폭(mm)" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_7" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_8" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_9" /></td>
						</tr>
						<tr>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_10" value="Burr(mm)" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_11" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_12" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_13" /></td>
						</tr>
						<tr>
							<td rowspan="5" align=center>7</td>
							<td	rowspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_1" value="면취" disabled></td>
							<td rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_2" value="폭" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_3" value="0.2T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_4" value="0.3T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_5" value="0.4T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_6" value="0.6T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_7" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_8" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_9" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_10" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_11" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_12"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_13"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_14"/></td>						</tr>
						<tr>
							<td rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_15" value="T두께" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_16" value="0.2T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_17" value="0.3T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_18" value="0.4T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_19" value="0.6T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_20" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_21" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_22" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_23" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_24" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_25" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_26"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_27"/></td>						</tr>
						<tr>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_28" value="ET두께" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_29" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_30" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_31" /></td>
						</tr>
						<tr>
							<td rowspan="2" align=center>8</td>
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_1" value="내절강도" disabled></td>
							<td rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_2" value="" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_3" value="0.2T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_4" value="0.3T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_5" value="0.4T" disabled/></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_6" value="0.4T (H14)↑" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_7" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_8" /></td>
						</tr>
						<tr>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_9" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_10" value="" >
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_11" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_12" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_13" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem13_14" /></td>
						</tr>
						<tr>
							<td align=center>9</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem14_1" value="기타 유해한 결함" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem14_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem14_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem14_4" /></td>
						</tr>
					</table>
				</div>
				
				
				
				<div id="matrl002" class="d-none">
					<div class="card-body col-sm-12 p-2" >
						<button type="button" class="btn btn-primary float-right mr-1" id="002btnSave">저장</button>
					</div>
					<table  class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th style="width:10%" >순번</th>
								<th style="width:20%">관리항목</th>
								<th style="width:50%" colspan="2">규격</th>
								<th style="width:10%">공차(+)</th>
								<th style="width:10%">공차(-)</th>
							</tr>
						</thead>
						<tr>
							<td align=center>1</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem1_1" value="Scratch" disabled/></td>
							<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem1_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem1_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem1_4" /></td>
						</tr>
						<tr>
							<td align=center>2</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem2_1" value="얼룩" disabled/></td>
							<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem2_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem2_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem2_4" /></td>
						</tr>
						<tr>
							<td align=center>3</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem3_1" value="ROSH" disabled/></td>
							<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem3_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem3_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem3_4" /></td>
						</tr>
						<tr>
							<td rowspan="2" align=center>4</td>
							<td rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_1" value="치수" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_2" value="두께(mm)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_3" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_4" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_5" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_6" value="폭(mm)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_7" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_8" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem6_9" /></td>
						</tr>
					</table>
				</div>
				
				<div id="matrl003" class="d-none">
					<div class="card-body col-sm-12 p-2" >
						<button type="button" class="btn btn-primary float-right mr-1" id="003btnSave">저장</button>
					</div>
					<table  class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th style="width:10%" >순번</th>
								<th style="width:20%">관리항목</th>
								<th style="width:50%" colspan="2">규격</th>
								<th style="width:10%">공차(+)</th>
								<th style="width:10%">공차(-)</th>
							</tr>
						</thead>
						<tr>
							<td align=center>1</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem1_1" value="Scratch" disabled/></td>
							<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem1_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem1_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem1_4" /></td>
						</tr>
						<tr>
							<td align=center>2</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem2_1" value="얼룩" disabled/></td>
							<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem2_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem2_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem2_4" /></td>
						</tr>
						<tr>
							<td align=center>3</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem3_1" value="ROSH" disabled/></td>
							<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem3_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem3_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem3_4" /></td>
						</tr>
						<tr>
							<td align=center>4</td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem6_1" value="치수" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem6_2" value="폭(mm)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem6_3" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem6_4" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl003_inspectItem6_5" /></td>
						</tr>
					</table>
				</div>
			
			
				<div id="matrl004" class="d-none">
					<div class="card-body col-sm-12 p-2" >
						<button type="button" class="btn btn-primary float-right mr-1" id="004btnSave">저장</button>
					</div>
					<table  class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th style="width:10%" >순번</th>
								<th style="width:20%">관리항목</th>
								<th style="width:50%" colspan="5">규격</th>
								<th style="width:10%">공차(+)</th>
								<th style="width:10%">공차(-)</th>
							</tr>
						</thead>
						<tr>
							<td align=center>1</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem1_1" value="Scratch" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem1_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem1_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem1_4" /></td>
						</tr>                                                                                              
						<tr>                                                                                               
							<td align=center>2</td>                                                                        
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem2_1" value="찍힘" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem2_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem2_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem2_4" /></td>
						</tr>                                                                                             
						<tr>                                                                                              
							<td align=center>3</td>                                                                       
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem3_1" value="이물" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem3_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem3_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem3_4" /></td>
						</tr>                                                                                              
						<tr>                                                                                               
							<td align=center>4</td>                                                                        
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem4_1" value="얼룩(오염)" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem4_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem4_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem4_4" /></td>
						</tr>                                                                                              
						<tr>                                                                                               
							<td align=center>5</td>                                                                        
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem5_1" value="Twist(꼬임)" disabled></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem5_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem5_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem5_4" /></td>
						</tr>
						<tr>
							<td rowspan="2" align=center>6</td>
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_1" value="치수" disabled></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_2" value="두께(mm)" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_3" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_4" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_5" /></td>
						</tr>
						<tr>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_6" value="폭(mm)" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_7" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_8" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_9" /></td>
						</tr>
						<tr>
							<td rowspan="3" align=center>7</td>
							<td	rowspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_1" value="단면" disabled></td>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_2" value="Pouch Side(mm)" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_3" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_4" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_5" /></td>
						</tr>
						<tr>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_6" value="Middle Side(mm)" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_7" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_8" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_9" /></td>
						</tr>
						<tr>
							<td 			><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_10" value="Metal Side(mm)" disabled/></td>
							<td colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_11" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_12" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_13" /></td>
						</tr>
						<tr>
							<td align=center>8</td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem14_1" value="기타 유해한 결함" disabled/></td>
							<td colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem14_2" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem14_3" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem14_4" /></td>
						</tr>
					</table>
				</div>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
				<!-- <div class="card" id="formBox">
					<form id="form">
						<div class="table-responsive">
							<table class="table table-bordered" id="inspectInfoAdmCommonCd">
								<thead class="thead-light">
									<tr>
										<th style="width: 70px">사용여부</th>
										<th style="width: 50px">코드</th>
										<th style="width: 80px">코드명</th>
										<th style="width: 40px">약칭</th>
										<th style="width: 50px">체크1</th>
										<th style="width: 50px">체크2</th>
										<th style="width: 50px">체크3</th>
										<th style="width: 50px">체크4</th>
										<th style="width: 50px">체크5</th>
										<th style="width: 50px">체크6</th>
										<th style="width: 50px">체크7</th>
										<th style="width: 50px">체크8</th>
										<th style="width: 50px">체크9</th>
										<th style="width: 50px">체크10</th>
									</tr>
								</thead>
							</table>
						</div>
					</form>
				</div> -->
			</div>
			<!-- .right-sidebar -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'bmsc3170';
	let currentHref = 'bmsc3170';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","품질정보관리");
	sideView = null;
	var baseCd = '000';
	let matrlCd = '';
	var url = null;
	var inspectItem1 = null;
	var inspectItem2 = null;
	var inspectItem3 = null;
	var inspectItem4 = null;
	var inspectItem5 = null;
	var inspectItem6 = null;
	var inspectItem7 = null;
	var inspectItem8 = null;
	var inspectItem9 = null;
	var inspectItem10 = null;
	var inspectItem11 = null;
	var inspectItem12 = null;
	var inspectItem13 = null;
	var inspectItem14 = null;
	var inspectItem15 = null;
	
	//공통코드 처리 시작   	
	var baseCd041 = new Array(); //자재 관리항목
    <c:forEach items="${baseCd041}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		baseCd041.push(json);
    </c:forEach>

    var baseCd042 = new Array(); //원자재 관리항목
    <c:forEach items="${baseCd042}" var="info">
		var json = new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		baseCd042.push(json);
	</c:forEach>

	var baseCd043 = new Array(); //가공원자재 관리항목
	<c:forEach items="${baseCd043}" var="info">
		var json = new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		baseCd043.push(json);
	</c:forEach>
    //공통코드 처리 종료 
    
   	//시스템공통그룹 전체조회
   	$.fn.dataTable.ext.errMode = 'none';
	let inspectInfoAdmCommonGroupCd = $('#inspectInfoAdmCommonGroupCd').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        searching:true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 20,
        lengthChange: false,
		ajax: {
			url: '<c:url value="bm/inspectInfoAdmGroupDataList"/>',
			type: 'GET',
			data: {
				'menuAuth'	 :	menuAuth,
			},
		},
		columns: [
			{ data : 'useYnNm' },
			{ data: 'baseCd' },
			{ data: 'baseCdNm' },
		],
		order: [
			[ 1, 'asc' ],
		],
        buttons: [
            {
                extend: 'copy',
                title: '품질정보 기초 코드',
            },
            {
                extend: 'excel',
                title: '품질정보 기초 코드',
            },
            {
                extend: 'print',
                title: '품질정보 기초 코드',
            },
        ],
         drawCallback : function( settings ) { //데이터 테이블 모두 호출후 실행 유사 complete       
        	//$('#inspectInfoAdmCommonGroupCd_filter').html('<label>검색 : <input type="search" class="form-control form-control-sm" placeholder="" aria-controls="inspectInfoAdmCommonGroupCd" style="width:120px"> </label>');	
        	 $('input[type=search]').attr("style", "width:120px;");
       	} 
	});

	// 시스템코드선택
	$('#inspectInfoAdmCommonGroupCd tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            baseCd = '000';
        }
        else {
        	$('#inspectInfoAdmCommonGroupCd').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            baseCd = inspectInfoAdmCommonGroupCd.row(this).data().baseCd;
            
            if (baseCd == "001"){
    			$('#matrl001').removeClass("d-none");
                $('#matrl002').addClass("d-none");
                $('#matrl003').addClass("d-none");
                $('#matrl004').addClass("d-none");
               // readInspectInfo();
            } else if (baseCd == "002"){
            	$('#matrl001').addClass("d-none");
                $('#matrl002').removeClass("d-none");
                $('#matrl003').addClass("d-none");
                $('#matrl004').addClass("d-none");
                //readInspectInfo();
            } else if (baseCd == "003"){
            	$('#matrl001').addClass("d-none");
                $('#matrl002').addClass("d-none");
                $('#matrl003').removeClass("d-none");
                $('#matrl004').addClass("d-none");
                //readInspectInfo();
            } else if (baseCd == "004"){
            	$('#matrl001').addClass("d-none");
                $('#matrl002').addClass("d-none");
                $('#matrl003').addClass("d-none");
                $('#matrl004').removeClass('d-none');
            }
        }

        matrlCdTable.ajax.reload();
   	});


	// 목록
	$.fn.dataTable.ext.errMode = 'none';
	let matrlCdTable = $('#matrlCdTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-1'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>B",
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
//         autoWidth: false,
//         scrollX : false,
//         lengthChange: true,
//         pageLength: 20,

        autoWidth: false,
		scrollX: true,
        scrollY : "38vh",
        scrollCollapse: true,
        
        ajax: {
            url: '<c:url value="/bm/matrlCdDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 :	  menuAuth,
            	'useYnCd'	 : 	   'Y',
            	'matrlGubunCd' : function(){return baseCd;}
            },
        },
        rowId: 'matrlCd',
        columns: [
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'qutyNm' },
            { data: 'gubunNm' },
            { data: 'thickness' },
            { data: 'depth' }, 
            { data: 'width' },
            { data: 'length' },                       
            { data: 'pitch' }                                              
        ],
        columnDefs: [
        ],
        order: [
            [ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '자재코드관리',
            },
            {
                extend: 'excel',
                title: '자재코드관리',
            },
            {
                extend: 'print',
                title: '자재코드관리',
            }
        ],
	});

	$('#matrlCdTable tbody').on('click', 'tr', function() {
		$('#my-spinner').modal('show');
		if(!$(this).hasClass('selected')){
        	$('#matrlCdTable').DataTable().$('tr.selected').removeClass('selected');
        	$(this).addClass('selected');
		}

		matrlCd = matrlCdTable.row('.selected').data().matrlCd;
		
		if (baseCd == "001"){
			$('#matrl001').removeClass("d-none");
            $('#matrl002').addClass("d-none");
            $('#matrl003').addClass("d-none");
            $('#matrl004').addClass("d-none");
            readInspectInfo();
        } else if (baseCd == "002"){
        	$('#matrl001').addClass("d-none");
            $('#matrl002').removeClass("d-none");
            $('#matrl003').addClass("d-none");
            $('#matrl004').addClass("d-none");
            readInspectInfo();
        } else if (baseCd == "003"){
        	$('#matrl001').addClass("d-none");
            $('#matrl002').addClass("d-none");
            $('#matrl003').removeClass("d-none");
            $('#matrl004').addClass("d-none");
            readInspectInfo();
        } else if (baseCd == "004"){
        	$('#matrl001').addClass("d-none");
            $('#matrl002').addClass("d-none");
            $('#matrl003').addClass("d-none");
            $('#matrl004').removeClass('d-none');
            readInspectInfo();
        }
	})


	//품질정보관리 조회
	function readInspectInfo() {
		//자재 조회
        $.ajax({
           url: '<c:url value="/bm/inspectInfoAdmReadByMatrlCd"/>',
           type: 'GET',
           data: {
           	'menuAuth'	 	: 		menuAuth,
           	'matrlGubunCd' 	:		function() { return baseCd; },
           	'matrlCd'		:		function() { return matrlCd;}
           },
           success: function (res) {
           	let data = res.data;
               if (res.result == 'ok') {
	            	sideView = 'edit';
	            	if ( baseCd == '001' ){
	            		matrl001_clear();
		            	$('#matrl001_inspectItem1_1').val(data[1][0]);
		            	$('#matrl001_inspectItem1_2').val(data[1][1]);
		            	$('#matrl001_inspectItem1_3').val(data[1][2]);
		            	$('#matrl001_inspectItem1_4').val(data[1][3]);
		            	$('#matrl001_inspectItem2_1').val(data[2][0]);
		            	$('#matrl001_inspectItem2_2').val(data[2][1]);
		            	$('#matrl001_inspectItem2_3').val(data[2][2]);
		            	$('#matrl001_inspectItem2_4').val(data[2][3]);
		            	$('#matrl001_inspectItem3_1').val(data[3][0]);
		            	$('#matrl001_inspectItem3_2').val(data[3][1]);
		            	$('#matrl001_inspectItem3_3').val(data[3][2]);
		            	$('#matrl001_inspectItem3_4').val(data[3][3]);
		            	$('#matrl001_inspectItem4_1').val(data[4][0]);
		            	$('#matrl001_inspectItem4_2').val(data[4][1]);
		            	$('#matrl001_inspectItem4_3').val(data[4][2]);
		            	$('#matrl001_inspectItem4_4').val(data[4][3]);
		            	$('#matrl001_inspectItem5_1').val(data[5][0]);
		            	$('#matrl001_inspectItem5_2').val(data[5][1]);
		            	$('#matrl001_inspectItem5_3').val(data[5][2]);
		            	$('#matrl001_inspectItem5_4').val(data[5][3]);
		            	
		            	$('#matrl001_seletBox001').val(data[6][0]);
		            	$('#matrl001_inspectItem6_1').val(data[6][2]);
		            	$('#matrl001_inspectItem6_2').val(data[6][3]);
		            	$('#matrl001_inspectItem6_3').val(data[6][4]);
		            	$('#matrl001_seletBox002').val(data[7][0]);
		            	$('#matrl001_inspectItem7_1').val(data[7][2]);
		            	$('#matrl001_inspectItem7_2').val(data[7][3]);
		            	$('#matrl001_inspectItem7_3').val(data[7][4]);
		            	$('#matrl001_seletBox003').val(data[8][0]);
		            	$('#matrl001_inspectItem8_1').val(data[8][2]);
		            	$('#matrl001_inspectItem8_2').val(data[8][3]);
		            	$('#matrl001_inspectItem8_3').val(data[8][4]);
		            	$('#matrl001_seletBox004').val(data[9][0]);
		            	$('#matrl001_inspectItem9_1').val(data[9][2]);
		            	$('#matrl001_inspectItem9_2').val(data[9][3]);
		            	$('#matrl001_inspectItem9_3').val(data[9][4]);
		            	$('#matrl001_seletBox005').val(data[10][0]);
		            	$('#matrl001_inspectItem10_1').val(data[10][2]);
		            	$('#matrl001_inspectItem10_2').val(data[10][3]);
		            	$('#matrl001_inspectItem10_3').val(data[10][4]);
	
		            	$('#matrl001_inspectItem11_1').val(data[11][0]);
		            	$('#matrl001_inspectItem11_2').val(data[11][1]);
		            	$('#matrl001_inspectItem11_3').val(data[11][2]);
		            	$('#matrl001_inspectItem11_4').val(data[11][3]);
		            	$('#matrl001_inspectItem11_5').val(data[11][4]);
		            	$('#matrl001_inspectItem11_6').val(data[11][5]);
		            	$('#matrl001_inspectItem11_7').val(data[11][6]);
		            	$('#matrl001_inspectItem11_8').val(data[11][7]);
		            	$('#matrl001_inspectItem11_9').val(data[11][8]);
		            	$('#matrl001_inspectItem11_10').val(data[11][9]);
		            	$('#matrl001_inspectItem11_11').val(data[11][10]);
		            	$('#matrl001_inspectItem11_12').val(data[11][11]);
		            	$('#matrl001_inspectItem11_13').val(data[11][12]);
		            	
		            	$('#matrl001_inspectItem12_1').val(data[12][0]);
		            	$('#matrl001_inspectItem12_2').val(data[12][1]);
		            	$('#matrl001_inspectItem12_3').val(data[12][2]);
		            	$('#matrl001_inspectItem12_4').val(data[12][3]);
		            	$('#matrl001_inspectItem12_5').val(data[12][4]);
		            	$('#matrl001_inspectItem12_6').val(data[12][5]);
		            	$('#matrl001_inspectItem12_7').val(data[12][6]);
		            	$('#matrl001_inspectItem12_8').val(data[12][7]);
		            	$('#matrl001_inspectItem12_9').val(data[12][8]);
		            	$('#matrl001_inspectItem12_10').val(data[12][9]);
		            	$('#matrl001_inspectItem12_11').val(data[12][10]);
		            	$('#matrl001_inspectItem12_12').val(data[12][11]);
		            	$('#matrl001_inspectItem12_13').val(data[12][12]);
		            	$('#matrl001_inspectItem12_14').val(data[12][13]);
		            	$('#matrl001_inspectItem12_15').val(data[12][14]);
		            	$('#matrl001_inspectItem12_16').val(data[12][15]);
		            	$('#matrl001_inspectItem12_17').val(data[12][16]);
		            	$('#matrl001_inspectItem12_18').val(data[12][17]);
		            	$('#matrl001_inspectItem12_19').val(data[12][18]);
		            	$('#matrl001_inspectItem12_20').val(data[12][19]);
		            	$('#matrl001_inspectItem12_21').val(data[12][20]);
		            	$('#matrl001_inspectItem12_22').val(data[12][21]);
		            	$('#matrl001_inspectItem12_23').val(data[12][22]);
		            	$('#matrl001_inspectItem12_24').val(data[12][23]);
		            	$('#matrl001_inspectItem12_25').val(data[12][24]);
		            	$('#matrl001_inspectItem12_26').val(data[12][25]);
		            	$('#matrl001_inspectItem12_27').val(data[12][26]);
		            	$('#matrl001_inspectItem12_28').val(data[12][27]);
		            	$('#matrl001_inspectItem12_29').val(data[12][28]);
		            	$('#matrl001_inspectItem12_30').val(data[12][29]);
		            	$('#matrl001_inspectItem12_31').val(data[12][30]);
		            	$('#matrl001_inspectItem12_32').val(data[12][31]);
	
		            	$('#matrl001_inspectItem13_1').val(data[13][0]);
		            	$('#matrl001_inspectItem13_2').val(data[13][1]);
		            	$('#matrl001_inspectItem13_3').val(data[13][2]);
		            	$('#matrl001_inspectItem13_4').val(data[13][3]);
		            	$('#matrl001_inspectItem13_5').val(data[13][4]);
		            	$('#matrl001_inspectItem13_6').val(data[13][5]);
		            	$('#matrl001_inspectItem13_7').val(data[13][6]);
		            	$('#matrl001_inspectItem13_8').val(data[13][7]);
		            	$('#matrl001_inspectItem13_9').val(data[13][8]);
		            	$('#matrl001_inspectItem13_10').val(data[13][9]);
		            	$('#matrl001_inspectItem13_11').val(data[13][10]);
		            	$('#matrl001_inspectItem13_12').val(data[13][11]);
		            	$('#matrl001_inspectItem13_13').val(data[13][12]);
		            	$('#matrl001_inspectItem13_14').val(data[13][13]);
		            	$('#matrl001_inspectItem13_15').val(data[13][14]);
		            	$('#matrl001_inspectItem13_16').val(data[13][15]);
		            	$('#matrl001_inspectItem13_17').val(data[13][16]);
		            	$('#matrl001_inspectItem13_18').val(data[13][17]);
	
		            	$('#matrl001_inspectItem14_1').val(data[14][0]);
		            	$('#matrl001_inspectItem14_2').val(data[14][1]);
		            	$('#matrl001_inspectItem14_3').val(data[14][2]);
		            	$('#matrl001_inspectItem14_4').val(data[14][3]);
		            	$('#matrl001_inspectItem15_1').val(data[15][0]);
		            	$('#matrl001_inspectItem15_2').val(data[15][1]);
		            	$('#matrl001_inspectItem15_3').val(data[15][2]);
		            	$('#matrl001_inspectItem15_4').val(data[15][3]);
		            	
	            	} else if ( baseCd == '002' ){
	            		matrl002_clear();
	            		$('#matrl002_inspectItem1_1').val(data[1][0]);
		            	$('#matrl002_inspectItem1_2').val(data[1][1]);
		            	$('#matrl002_inspectItem1_3').val(data[1][2]);
		            	$('#matrl002_inspectItem1_4').val(data[1][3]);
		            	$('#matrl002_inspectItem2_1').val(data[2][0]);
		            	$('#matrl002_inspectItem2_2').val(data[2][1]);
		            	$('#matrl002_inspectItem2_3').val(data[2][2]);
		            	$('#matrl002_inspectItem2_4').val(data[2][3]);
		            	$('#matrl002_inspectItem3_1').val(data[3][0]);
		            	$('#matrl002_inspectItem3_2').val(data[3][1]);
		            	$('#matrl002_inspectItem3_3').val(data[3][2]);
		            	$('#matrl002_inspectItem3_4').val(data[3][3]);
		            	
		            	$('#matrl002_seletBox001').val(data[4][0]);
		            	$('#matrl002_inspectItem4_1').val(data[4][2]);
		            	$('#matrl002_inspectItem4_2').val(data[4][3]);
		            	$('#matrl002_inspectItem4_3').val(data[4][4]);
		            	$('#matrl002_seletBox002').val(data[5][0]);
		            	$('#matrl002_inspectItem5_1').val(data[5][2]);
		            	$('#matrl002_inspectItem5_2').val(data[5][3]);
		            	$('#matrl002_inspectItem5_3').val(data[5][4]);
		            	
		            	$('#matrl002_inspectItem6_1').val(data[6][0]);
		            	$('#matrl002_inspectItem6_2').val(data[6][1]);
		            	$('#matrl002_inspectItem6_3').val(data[6][2]);
		            	$('#matrl002_inspectItem6_4').val(data[6][3]);
		            	$('#matrl002_inspectItem6_5').val(data[6][4]);
		            	$('#matrl002_inspectItem6_6').val(data[6][5]);
		            	$('#matrl002_inspectItem6_7').val(data[6][6]);
		            	$('#matrl002_inspectItem6_8').val(data[6][7]);
		            	$('#matrl002_inspectItem6_9').val(data[6][8]);
		            	
		            } else if ( baseCd == '003' ){
		            	matrl003_clear();
	            		$('#matrl003_inspectItem1_1').val(data[1][0]);
		            	$('#matrl003_inspectItem1_2').val(data[1][1]);
		            	$('#matrl003_inspectItem1_3').val(data[1][2]);
		            	$('#matrl003_inspectItem1_4').val(data[1][3]);
		            	$('#matrl003_inspectItem2_1').val(data[2][0]);
		            	$('#matrl003_inspectItem2_2').val(data[2][1]);
		            	$('#matrl003_inspectItem2_3').val(data[2][2]);
		            	$('#matrl003_inspectItem2_4').val(data[2][3]);
		            	$('#matrl003_inspectItem3_1').val(data[3][0]);
		            	$('#matrl003_inspectItem3_2').val(data[3][1]);
		            	$('#matrl003_inspectItem3_3').val(data[3][2]);
		            	$('#matrl003_inspectItem3_4').val(data[3][3]);
		            	
		            	$('#matrl003_seletBox001').val(data[4][0]);
		            	$('#matrl003_inspectItem4_1').val(data[4][2]);
		            	$('#matrl003_inspectItem4_2').val(data[4][3]);
		            	$('#matrl003_inspectItem4_3').val(data[4][4]);
		            	$('#matrl003_seletBox002').val(data[5][0]);
		            	$('#matrl003_inspectItem5_1').val(data[5][2]);
		            	$('#matrl003_inspectItem5_2').val(data[5][3]);
		            	$('#matrl003_inspectItem5_3').val(data[5][4]);
		            	
		            	$('#matrl003_inspectItem6_1').val(data[6][0]);
		            	$('#matrl003_inspectItem6_2').val(data[6][1]);
		            	$('#matrl003_inspectItem6_3').val(data[6][2]);
		            	$('#matrl003_inspectItem6_4').val(data[6][3]);
		            	$('#matrl003_inspectItem6_5').val(data[6][4]);
		            	$('#matrl003_inspectItem6_6').val(data[6][5]);
		            	$('#matrl003_inspectItem6_7').val(data[6][6]);
		            	$('#matrl003_inspectItem6_8').val(data[6][7]);
		            	$('#matrl003_inspectItem6_9').val(data[6][8]);
		            } else if(baseCd == '004'){
		            	matrl004_clear();
	            		$('#matrl004_inspectItem1_1').val(data[1][0]);
		            	$('#matrl004_inspectItem1_2').val(data[1][1]);
		            	$('#matrl004_inspectItem1_3').val(data[1][2]);
		            	$('#matrl004_inspectItem1_4').val(data[1][3]);
		            	$('#matrl004_inspectItem2_1').val(data[2][0]);
		            	$('#matrl004_inspectItem2_2').val(data[2][1]);
		            	$('#matrl004_inspectItem2_3').val(data[2][2]);
		            	$('#matrl004_inspectItem2_4').val(data[2][3]);
		            	$('#matrl004_inspectItem3_1').val(data[3][0]);
		            	$('#matrl004_inspectItem3_2').val(data[3][1]);
		            	$('#matrl004_inspectItem3_3').val(data[3][2]);
		            	$('#matrl004_inspectItem3_4').val(data[3][3]);
		            	           
		            	$('#matrl004_inspectItem4_1').val(data[4][0]);
		            	$('#matrl004_inspectItem4_2').val(data[4][2]);
		            	$('#matrl004_inspectItem4_3').val(data[4][3]);
		            	$('#matrl004_inspectItem4_4').val(data[4][4]);
		            	$('#matrl004_inspectItem5_1').val(data[5][0]);
		            	$('#matrl004_inspectItem5_2').val(data[5][2]);
		            	$('#matrl004_inspectItem5_3').val(data[5][3]);
		            	$('#matrl004_inspectItem5_4').val(data[5][4]);
		            	           
		            	$('#matrl004_inspectItem6_1').val(data[6][0]);
		            	$('#matrl004_inspectItem6_2').val(data[6][1]);
		            	$('#matrl004_inspectItem6_3').val(data[6][2]);
		            	$('#matrl004_inspectItem6_4').val(data[6][3]);
		            	$('#matrl004_inspectItem6_5').val(data[6][4]);
		            	$('#matrl004_inspectItem6_6').val(data[6][5]);
		            	$('#matrl004_inspectItem6_7').val(data[6][6]);
		            	$('#matrl004_inspectItem6_8').val(data[6][7]);
		            	$('#matrl004_inspectItem6_9').val(data[6][8]);

		            	$('#matrl004_inspectItem12_1').val(data[7][0]);
		            	$('#matrl004_inspectItem12_2').val(data[7][1]);
		            	$('#matrl004_inspectItem12_3').val(data[7][2]);
		            	$('#matrl004_inspectItem12_4').val(data[7][3]);
		            	$('#matrl004_inspectItem12_5').val(data[7][4]);
		            	$('#matrl004_inspectItem12_6').val(data[7][5]);
		            	$('#matrl004_inspectItem12_7').val(data[7][6]);
		            	$('#matrl004_inspectItem12_8').val(data[7][7]);
		            	$('#matrl004_inspectItem12_9').val(data[7][8]);
		            	
		            	
		            	$('#matrl004_inspectItem14_1').val(data[8][0]);
		            	$('#matrl004_inspectItem14_2').val(data[8][2]);
		            	$('#matrl004_inspectItem14_3').val(data[8][3]);
		            	$('#matrl004_inspectItem14_4').val(data[8][4]);
			           }
	            	
               } else if (res.result == 'fail') {
            	   sideView = 'create';
	               if ( baseCd == '001' ){
	            	   matrl001_clear();
	               } else if ( baseCd == '002' ){
	            	   matrl002_clear();
	               } else if ( baseCd == '003' ){
	            	   matrl003_clear();
	               } else if ( baseCd == '004' ){
		               matrl004_clear();
		           }      	
	                toastr.warning(res.message);
               } else if (res.result == 'error') {
            	   toastr.error(res.message, '', {timeOut: 5000});
               }
           },
           complete : function() {
               $('#my-spinner').modal('hide');
           }
       });
	}

	//자재 저장
	$('#001btnSave').on('click', function () {
		
		if(matrlCdTable.row('.selected').data()==undefined||matrlCdTable.row('.selected').data()==''){
			toastr.warning('자재를 선택해야합니다!');
			return false;
		}
			inspectItem1 = replaceSlash($('#matrl001_inspectItem1_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem1_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem1_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem1_4').val());
			inspectItem2 = replaceSlash($('#matrl001_inspectItem2_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem2_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem2_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem2_4').val());
			inspectItem3 = replaceSlash($('#matrl001_inspectItem3_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem3_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem3_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem3_4').val());
			inspectItem4 = replaceSlash($('#matrl001_inspectItem4_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem4_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem4_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem4_4').val());
			inspectItem5 = replaceSlash($('#matrl001_inspectItem5_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem5_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem5_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem5_4').val());
// 			inspectItem6 = $('#matrl001_seletBox001 option:selected').val() + "/" + $('#matrl001_seletBox001 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem6_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem6_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem6_3').val())
// 			inspectItem7 = $('#matrl001_seletBox002 option:selected').val() + "/" + $('#matrl001_seletBox002 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem7_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem7_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem7_3').val())
// 			inspectItem8 = $('#matrl001_seletBox003 option:selected').val() + "/" + $('#matrl001_seletBox003 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem8_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem8_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem8_3').val())
// 			inspectItem9 = $('#matrl001_seletBox004 option:selected').val() + "/" + $('#matrl001_seletBox004 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem9_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem9_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem9_3').val())
// 			inspectItem10 = $('#matrl001_seletBox005 option:selected').val() + "/" + $('#matrl001_seletBox005 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem10_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem10_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem10_3').val())
			
			inspectItem11 = replaceSlash($('#matrl001_inspectItem11_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_4').val()) + "/";
			inspectItem11 += replaceSlash($('#matrl001_inspectItem11_5').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_6').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_7').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_8').val()) + "/";
			inspectItem11 += replaceSlash($('#matrl001_inspectItem11_9').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_10').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_11').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_12').val()) + "/";
			inspectItem11 += replaceSlash($('#matrl001_inspectItem11_13').val());
			
			inspectItem12 = replaceSlash($('#matrl001_inspectItem12_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_4').val()) + "/";
			inspectItem12 += replaceSlash($('#matrl001_inspectItem12_5').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_6').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_7').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_8').val()) + "/";
			inspectItem12 += replaceSlash($('#matrl001_inspectItem12_9').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_10').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_11').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_12').val()) + "/";
			inspectItem12 += replaceSlash($('#matrl001_inspectItem12_13').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_14').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_15').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_16').val()) + "/";
			inspectItem12 += replaceSlash($('#matrl001_inspectItem12_17').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_18').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_19').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_20').val()) + "/";
			inspectItem12 += replaceSlash($('#matrl001_inspectItem12_21').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_22').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_23').val()) + "/";
			inspectItem12 += replaceSlash($('#matrl001_inspectItem12_24').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_25').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_26').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_27').val()) + "/";
			inspectItem12 += replaceSlash($('#matrl001_inspectItem12_28').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_29').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_30').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_31').val());
			
			inspectItem13 = replaceSlash($('#matrl001_inspectItem13_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_4').val()) + "/";
			inspectItem13 += replaceSlash($('#matrl001_inspectItem13_5').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_6').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_7').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_8').val()) + "/";
			inspectItem13 += replaceSlash($('#matrl001_inspectItem13_9').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_10').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_11').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_12').val()) + "/";
			inspectItem13 += replaceSlash($('#matrl001_inspectItem13_13').val()) + "/" + replaceSlash($('#matrl001_inspectItem13_14').val());

			inspectItem14 = replaceSlash($('#matrl001_inspectItem14_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem14_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem14_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem14_4').val());
			//inspectItem15 = replaceSlash($('#matrl001_inspectItem15_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem15_2').val()) + "/" + replaceSlash($('#matrl001_inspectItem15_3').val()) + "/" + replaceSlash($('#matrl001_inspectItem15_4').val());

		if (sideView == 'create') {
			url = '<c:url value="/bm/inspectInfoAdmCreateByMatrlCd"/>';
		} else if (sideView == 'edit'){
			url = '<c:url value="/bm/inspectInfoAdmUpdateByMatrlCd"/>';
		}
		
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'matrlCd'			:		function() { return matrlCd; },
            	'matrlGubunCd' 		:		function() { return baseCd; },
            	'inspectItem1'		:		inspectItem1,
            	'inspectItem2'		:		inspectItem2,
            	'inspectItem3'		:		inspectItem3,
            	'inspectItem4'		:		inspectItem4,
            	'inspectItem5'		:		inspectItem5,
            	'inspectItem6'		:		inspectItem6,
            	'inspectItem7'		:		inspectItem7,
            	'inspectItem8'		:		inspectItem8,
            	'inspectItem9'		:		inspectItem9,
            	'inspectItem10'		:		inspectItem10,
            	'inspectItem11'		:		inspectItem11,
            	'inspectItem12'		:		inspectItem12,
            	'inspectItem13'		:		inspectItem13,
            	'inspectItem14'		:		inspectItem14,
            	'inspectItem15'		:		inspectItem15,
            },
            success: function (res) {
                if (res.result == 'ok') {
                	toastr.success(res.message);
                	sideView = 'edit';
                } else if (res.result == 'error') {
                	toastr.error(res.message, '', {timeOut: 5000});
                	
                }
            }
        });
	});

	//원자재 저장
	$('#002btnSave').on('click', function () {
		if(matrlCdTable.row('.selected').data()==undefined||matrlCdTable.row('.selected').data()==''){
			toastr.warning('자재를 선택해야합니다!');
			return false;
		}
		
		inspectItem1 = replaceSlash($('#matrl002_inspectItem1_1').val()) + "/" + replaceSlash($('#matrl002_inspectItem1_2').val()) + "/" + replaceSlash($('#matrl002_inspectItem1_3').val()) + "/" + replaceSlash($('#matrl002_inspectItem1_4').val());
		inspectItem2 = replaceSlash($('#matrl002_inspectItem2_1').val()) + "/" + replaceSlash($('#matrl002_inspectItem2_2').val()) + "/" + replaceSlash($('#matrl002_inspectItem2_3').val()) + "/" + replaceSlash($('#matrl002_inspectItem2_4').val());
		inspectItem3 = replaceSlash($('#matrl002_inspectItem3_1').val()) + "/" + replaceSlash($('#matrl002_inspectItem3_2').val()) + "/" + replaceSlash($('#matrl002_inspectItem3_3').val()) + "/" + replaceSlash($('#matrl002_inspectItem3_4').val());
// 		inspectItem4 = $('#matrl002_seletBox001 option:selected').val() + "/" + $('#matrl002_seletBox001 option:selected').text() + "/" + replaceSlash($('#matrl002_inspectItem4_1').val()) + "/" + replaceSlash($('#matrl002_inspectItem4_2').val()) + "/" + replaceSlash($('#matrl002_inspectItem4_3').val())
// 		inspectItem5 = $('#matrl002_seletBox002 option:selected').val() + "/" + $('#matrl002_seletBox002 option:selected').text() + "/" + replaceSlash($('#matrl002_inspectItem5_1').val()) + "/" + replaceSlash($('#matrl002_inspectItem5_2').val()) + "/" + replaceSlash($('#matrl002_inspectItem5_3').val())
 		inspectItem6 = replaceSlash($('#matrl002_inspectItem6_1').val()) + "/" + replaceSlash($('#matrl002_inspectItem6_2').val()) + "/" + replaceSlash($('#matrl002_inspectItem6_3').val()) + "/" + replaceSlash($('#matrl002_inspectItem6_4').val()) + "/" ;
		inspectItem6 += replaceSlash($('#matrl002_inspectItem6_5').val()) + "/" + replaceSlash($('#matrl002_inspectItem6_6').val()) + "/" + replaceSlash($('#matrl002_inspectItem6_7').val()) + "/" + replaceSlash($('#matrl002_inspectItem6_8').val()) + "/" ;
		inspectItem6 += replaceSlash($('#matrl002_inspectItem6_9').val());
				
		if (sideView == 'create') {
			url = '<c:url value="/bm/inspectInfoAdmCreateByMatrlCd"/>';
		} else if (sideView == 'edit'){
			url = '<c:url value="/bm/inspectInfoAdmUpdateByMatrlCd"/>';
		}
		
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'matrlCd'			:		function() { return matrlCd; },
            	'matrlGubunCd' 		:		function() { return baseCd; },
            	'inspectItem1'		:		inspectItem1,
            	'inspectItem2'		:		inspectItem2,
            	'inspectItem3'		:		inspectItem3,
            	'inspectItem4'		:		inspectItem4,
            	'inspectItem5'		:		inspectItem5,
            	'inspectItem6'		:		inspectItem6,
            },
            success: function (res) {
                if (res.result == 'ok') {
                	toastr.success(res.message);
                	sideView = 'edit';
                } else if (res.result == 'error') {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            }
        });
	});

	//가공원자재 저장
	$('#003btnSave').on('click', function () {
		if(matrlCdTable.row('.selected').data()==undefined||matrlCdTable.row('.selected').data()==''){
			toastr.warning('자재를 선택해야합니다!');
			return false;
		}
		
		inspectItem1 = replaceSlash($('#matrl003_inspectItem1_1').val()) + "/" + replaceSlash($('#matrl003_inspectItem1_2').val()) + "/" + replaceSlash($('#matrl003_inspectItem1_3').val()) + "/" + replaceSlash($('#matrl003_inspectItem1_4').val());
		inspectItem2 = replaceSlash($('#matrl003_inspectItem2_1').val()) + "/" + replaceSlash($('#matrl003_inspectItem2_2').val()) + "/" + replaceSlash($('#matrl003_inspectItem2_3').val()) + "/" + replaceSlash($('#matrl003_inspectItem2_4').val());
		inspectItem3 = replaceSlash($('#matrl003_inspectItem3_1').val()) + "/" + replaceSlash($('#matrl003_inspectItem3_2').val()) + "/" + replaceSlash($('#matrl003_inspectItem3_3').val()) + "/" + replaceSlash($('#matrl003_inspectItem3_4').val());
// 		inspectItem4 = $('#matrl003_seletBox001 option:selected').val() + "/" + $('#matrl003_seletBox001 option:selected').text() + "/" + replaceSlash($('#matrl003_inspectItem4_1').val()) + "/" + replaceSlash($('#matrl003_inspectItem4_2').val()) + "/" + replaceSlash($('#matrl003_inspectItem4_3').val())
// 		inspectItem5 = $('#matrl003_seletBox002 option:selected').val() + "/" + $('#matrl003_seletBox002 option:selected').text() + "/" + replaceSlash($('#matrl003_inspectItem5_1').val()) + "/" + replaceSlash($('#matrl003_inspectItem5_2').val()) + "/" + replaceSlash($('#matrl003_inspectItem5_3').val())
		inspectItem6 = replaceSlash($('#matrl003_inspectItem6_1').val()) + "/" + replaceSlash($('#matrl003_inspectItem6_2').val()) + "/" + replaceSlash($('#matrl003_inspectItem6_3').val()) + "/" + replaceSlash($('#matrl003_inspectItem6_4').val()) + "/" ;
		inspectItem6 += replaceSlash($('#matrl003_inspectItem6_5').val()) + "/";
				
		if (sideView == 'create') {
			url = '<c:url value="/bm/inspectInfoAdmCreateByMatrlCd"/>';
		} else if (sideView == 'edit'){
			url = '<c:url value="/bm/inspectInfoAdmUpdateByMatrlCd"/>';
		}
		
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'matrlCd'			:		function() { return matrlCd; },
            	'matrlGubunCd' 		:		function() { return baseCd; },
            	'inspectItem1'		:		inspectItem1,
            	'inspectItem2'		:		inspectItem2,
            	'inspectItem3'		:		inspectItem3,
//             	'inspectItem4'		:		inspectItem4,
//             	'inspectItem5'		:		inspectItem5,
            	'inspectItem6'		:		inspectItem6,
            },
            success: function (res) {
                if (res.result == 'ok') {
                	toastr.success(res.message);
                	sideView = 'edit';
                } else if (res.result == 'error') {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            }
        });
	});

	//필름 저장
	$('#004btnSave').on('click', function () {
		if(matrlCdTable.row('.selected').data()==undefined||matrlCdTable.row('.selected').data()==''){
			toastr.warning('자재를 선택해야합니다!');
			return false;
		}
		
		inspectItem1 = replaceSlash($('#matrl004_inspectItem1_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem1_2').val()) + "/" + replaceSlash($('#matrl004_inspectItem1_3').val()) + "/" + replaceSlash($('#matrl004_inspectItem1_4').val());
		inspectItem2 = replaceSlash($('#matrl004_inspectItem2_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem2_2').val()) + "/" + replaceSlash($('#matrl004_inspectItem2_3').val()) + "/" + replaceSlash($('#matrl004_inspectItem2_4').val());
		inspectItem3 = replaceSlash($('#matrl004_inspectItem3_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem3_2').val()) + "/" + replaceSlash($('#matrl004_inspectItem3_3').val()) + "/" + replaceSlash($('#matrl004_inspectItem3_4').val());
		inspectItem4 = replaceSlash($('#matrl004_inspectItem4_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem4_2').val()) + "/" + replaceSlash($('#matrl004_inspectItem4_3').val()) + "/" + replaceSlash($('#matrl004_inspectItem4_4').val());
		inspectItem5 = replaceSlash($('#matrl004_inspectItem5_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem5_2').val()) + "/" + replaceSlash($('#matrl004_inspectItem5_3').val()) + "/" + replaceSlash($('#matrl004_inspectItem5_4').val());
		inspectItem6 = replaceSlash($('#matrl004_inspectItem6_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_2').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_3').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_4').val()) + "/";
		inspectItem6 += replaceSlash($('#matrl004_inspectItem6_5').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_6').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_7').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_8').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_9').val());
		inspectItem12 = replaceSlash($('#matrl004_inspectItem12_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_2').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_3').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_4').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_5').val()) + "/";
		inspectItem12 += replaceSlash($('#matrl004_inspectItem12_6').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_7').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_8').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_9').val()) + "/";
		inspectItem12 +=  replaceSlash($('#matrl004_inspectItem12_10').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_11').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_12').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_13').val());
		inspectItem14 = replaceSlash($('#matrl004_inspectItem14_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem14_2').val()) + "/" + replaceSlash($('#matrl004_inspectItem14_3').val()) + "/" + replaceSlash($('#matrl004_inspectItem14_4').val());
				
		if (sideView == 'create') {
			url = '<c:url value="/bm/inspectInfoAdmCreateByMatrlCd"/>';
		} else if (sideView == 'edit'){
			url = '<c:url value="/bm/inspectInfoAdmUpdateByMatrlCd"/>';
		}
		
		$.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'matrlCd'			:		function() { return matrlCd; },
            	'matrlGubunCd' 		:		function() { return baseCd; },
            	'inspectItem1'		:		inspectItem1,
            	'inspectItem2'		:		inspectItem2,
            	'inspectItem3'		:		inspectItem3,
            	'inspectItem4'		:		inspectItem4,
            	'inspectItem5'		:		inspectItem5,
            	'inspectItem6'		:		inspectItem6,
            	'inspectItem12'		:		inspectItem12,
            	'inspectItem14'		:		inspectItem14
            },
            success: function (res) {
                if (res.result == 'ok') {
                	toastr.success(res.message);
                	sideView = 'edit';
                } else if (res.result == 'error') {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            }
        });
	});
	
	//입력값에 '/'확인하여 %2f로 변환
	function replaceSlash(data) {
		var temp = data.replace("/", "%2f");
	    return temp;
	}
		
	//입력값 초기화
	function matrl001_clear() {

		$('#matrl001_inspectItem1_2').val("");
		$('#matrl001_inspectItem1_3').val("");
		$('#matrl001_inspectItem1_4').val("");
		
		$('#matrl001_inspectItem2_2').val("");
		$('#matrl001_inspectItem2_3').val("");
		$('#matrl001_inspectItem2_4').val("");
		
		$('#matrl001_inspectItem3_2').val("");
		$('#matrl001_inspectItem3_3').val("");
		$('#matrl001_inspectItem3_4').val("");
		
		$('#matrl001_inspectItem4_2').val("");
		$('#matrl001_inspectItem4_3').val("");
		$('#matrl001_inspectItem4_4').val("");
		
		$('#matrl001_inspectItem5_2').val("");
		$('#matrl001_inspectItem5_3').val("");
		$('#matrl001_inspectItem5_4').val("");
// 		$('#matrl001_inspectItem6_1').val("");
// 		$('#matrl001_inspectItem6_2').val("");
// 		$('#matrl001_inspectItem6_3').val("");
// 		$('#matrl001_inspectItem7_1').val("");
// 		$('#matrl001_inspectItem7_2').val("");
// 		$('#matrl001_inspectItem7_3').val("");
// 		$('#matrl001_inspectItem8_1').val("");
// 		$('#matrl001_inspectItem8_2').val("");
// 		$('#matrl001_inspectItem8_3').val("");
// 		$('#matrl001_inspectItem9_1').val("");
// 		$('#matrl001_inspectItem9_2').val("");
// 		$('#matrl001_inspectItem9_3').val("");
// 		$('#matrl001_inspectItem10_1').val("");
// 		$('#matrl001_inspectItem10_2').val("");
// 		$('#matrl001_inspectItem10_3').val("");
// 		$('#matrl001_inspectItem10_3').val("");

// 		selectBoxAppend(baseCd041, "matrl001_seletBox001", "", "2");
// 		selectBoxAppend(baseCd041, "matrl001_seletBox002", "", "2");
// 		selectBoxAppend(baseCd041, "matrl001_seletBox003", "", "2");
// 		selectBoxAppend(baseCd041, "matrl001_seletBox004", "", "2");
// 		selectBoxAppend(baseCd041, "matrl001_seletBox005", "", "2");

		$('#matrl001_inspectItem11_3').val("");
		$('#matrl001_inspectItem11_4').val("");
		$('#matrl001_inspectItem11_5').val("");
		$('#matrl001_inspectItem11_7').val("");
		$('#matrl001_inspectItem11_8').val("");
		$('#matrl001_inspectItem11_9').val("");
		$('#matrl001_inspectItem11_11').val("");
		$('#matrl001_inspectItem11_12').val("");
		$('#matrl001_inspectItem11_13').val("");

		$('#matrl001_inspectItem12_7').val("");
		$('#matrl001_inspectItem12_8').val("");
		$('#matrl001_inspectItem12_9').val("");
		$('#matrl001_inspectItem12_10').val("");
		$('#matrl001_inspectItem12_11').val("");
		$('#matrl001_inspectItem12_12').val("");
		$('#matrl001_inspectItem12_13').val("");
		$('#matrl001_inspectItem12_14').val("");
		$('#matrl001_inspectItem12_20').val("");
		$('#matrl001_inspectItem12_21').val("");
		$('#matrl001_inspectItem12_22').val("");
		$('#matrl001_inspectItem12_23').val("");
		$('#matrl001_inspectItem12_24').val("");
		$('#matrl001_inspectItem12_25').val("");
		$('#matrl001_inspectItem12_26').val("");
		$('#matrl001_inspectItem12_27').val("");
		$('#matrl001_inspectItem12_29').val("");
		$('#matrl001_inspectItem12_30').val("");
		$('#matrl001_inspectItem12_31').val("");

		$('#matrl001_inspectItem13_7').val("");
		$('#matrl001_inspectItem13_8').val("");
		$('#matrl001_inspectItem13_9').val("");
		$('#matrl001_inspectItem13_10').val("");
		$('#matrl001_inspectItem13_11').val("");
		$('#matrl001_inspectItem13_12').val("");
		$('#matrl001_inspectItem13_13').val("");
		$('#matrl001_inspectItem13_14').val("");

		$('#matrl001_inspectItem14_2').val("");
		$('#matrl001_inspectItem14_3').val("");
		$('#matrl001_inspectItem14_4').val("");
		$('#matrl001_inspectItem15_3').val("");
		$('#matrl001_inspectItem15_4').val("");
	}

	function matrl002_clear() {
		$('#matrl002_inspectItem1_2').val("");
		$('#matrl002_inspectItem1_3').val("");
		$('#matrl002_inspectItem1_4').val("");
		
		$('#matrl002_inspectItem2_2').val("");
		$('#matrl002_inspectItem2_3').val("");
		$('#matrl002_inspectItem2_4').val("");

		$('#matrl002_inspectItem3_2').val("");
		$('#matrl002_inspectItem3_3').val("");
		$('#matrl002_inspectItem3_4').val("");

		selectBoxAppend(baseCd042, "matrl002_seletBox001", "", "2");
		selectBoxAppend(baseCd042, "matrl002_seletBox002", "", "2");
		$('#matrl002_inspectItem4_1').val("");
		$('#matrl002_inspectItem4_2').val("");
		$('#matrl002_inspectItem4_3').val("");
		$('#matrl002_inspectItem4_4').val("");
		$('#matrl002_inspectItem5_1').val("");
		$('#matrl002_inspectItem5_2').val("");
		$('#matrl002_inspectItem5_3').val("");
		$('#matrl002_inspectItem5_4').val("");

		$('#matrl002_inspectItem6_3').val("");
		$('#matrl002_inspectItem6_4').val("");
		$('#matrl002_inspectItem6_5').val("");
		$('#matrl002_inspectItem6_7').val("");
		$('#matrl002_inspectItem6_8').val("");
		$('#matrl002_inspectItem6_9').val("");
	}

	function matrl003_clear() {
		$('#matrl003_inspectItem1_2').val("");
		$('#matrl003_inspectItem1_3').val("");
		$('#matrl003_inspectItem1_4').val("");

		$('#matrl003_inspectItem2_2').val("");
		$('#matrl003_inspectItem2_3').val("");
		$('#matrl003_inspectItem2_4').val("");

		$('#matrl003_inspectItem3_2').val("");
		$('#matrl003_inspectItem3_3').val("");
		$('#matrl003_inspectItem3_4').val("");

		selectBoxAppend(baseCd043, "matrl003_seletBox001", "", "2");
		selectBoxAppend(baseCd043, "matrl003_seletBox002", "", "2");
		$('#matrl003_inspectItem4_2').val("");
		$('#matrl003_inspectItem4_3').val("");
		$('#matrl003_inspectItem4_4').val("");
		$('#matrl003_inspectItem5_2').val("");
		$('#matrl003_inspectItem5_3').val("");
		$('#matrl003_inspectItem5_4').val("");

		$('#matrl003_inspectItem6_3').val("");
		$('#matrl003_inspectItem6_4').val("");
		$('#matrl003_inspectItem6_5').val("");
	}

	function matrl004_clear() {
		$('#matrl004_inspectItem1_2').val("");
		$('#matrl004_inspectItem1_3').val("");
		$('#matrl004_inspectItem1_4').val("");

		$('#matrl004_inspectItem2_2').val("");
		$('#matrl004_inspectItem2_3').val("");
		$('#matrl004_inspectItem2_4').val("");

		$('#matrl004_inspectItem3_2').val("");
		$('#matrl004_inspectItem3_3').val("");
		$('#matrl004_inspectItem3_4').val("");

		$('#matrl004_inspectItem4_2').val("");
		$('#matrl004_inspectItem4_3').val("");
		$('#matrl004_inspectItem4_4').val("");

		$('#matrl004_inspectItem5_2').val("");
		$('#matrl004_inspectItem5_3').val("");
		$('#matrl004_inspectItem5_4').val("");

		
		$('#matrl004_inspectItem6_3').val("");
		$('#matrl004_inspectItem6_4').val("");
		$('#matrl004_inspectItem6_5').val("");
		$('#matrl004_inspectItem6_7').val("");
		$('#matrl004_inspectItem6_8').val("");
		$('#matrl004_inspectItem6_9').val("");

		$('#matrl004_inspectItem12_3').val("");
		$('#matrl004_inspectItem12_4').val("");
		$('#matrl004_inspectItem12_5').val("");
		$('#matrl004_inspectItem12_7').val("");		
		$('#matrl004_inspectItem12_8').val("");
		$('#matrl004_inspectItem12_9').val("");
		$('#matrl004_inspectItem12_11').val("");
		$('#matrl004_inspectItem12_12').val("");
		$('#matrl004_inspectItem12_13').val("");

		$('#matrl004_inspectItem14_2').val("");
		$('#matrl004_inspectItem14_3').val("");
		$('#matrl004_inspectItem14_4').val("");
	}

	//var htmlGroup = '<button class="btn btn-primary float-left mr-2" type="button" id="baseGroupAdd">기초코드등록</button>&nbsp;<button class="btn btn-primary float-left mr-2" type="button" id="baseGroupEdit">수정</button>';
	//$('#inspectInfoAdmCommonGroupCd_length').html(htmlGroup);
	
	//$('#inspectInfoAdmCommonGroupCd_filter').html('<label>검색 : <input type="search" class="form-control form-control-sm" placeholder="" aria-controls="inspectInfoAdmCommonGroupCd" style="width:120px"> </label>');
	  		
	//시스템공통코드 상세조회
	/* var baseGroupCd = "0";
	let inspectInfoAdmCommonCd = $('#inspectInfoAdmCommonCd').DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B", 		
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        //scrollX : true,
        pageLength: 20,	
		'ajax': {
				url: '<c:url value="bm/inspectInfoAdmCodeDataList"/>',
				type: 'GET',
				data: {
					'menuAuth'	 : menuAuth,
					'baseGroupCd': function() { return baseGroupCd; }
				},
			},
			//rowId: 'baseGroupCd', // id값 할당
			columns: [
				{ data: 'useYnNm' },
	  			{ data: 'baseCd' },
	  			{ data: 'baseCdNm' },
	  			{ data: 'baseCdAbbr' },
	  			{ data: 'etc1' },
	  			{ data: 'etc2' },
	  			{ data: 'etc3' },
	  			{ data: 'etc4' },
	  			{ data: 'etc5' },
	  			{ data: 'etc6' },
	  			{ data: 'etc7' },
	  			{ data: 'etc8' },
	  			{ data: 'etc9' },
	  			{ data: 'etc10' }
	  		],
	  		order: [
	  			[ 1, 'asc' ],
	  		],
	  		buttons: [
	            {
	                extend: 'copy',
	                title: '품질정보 기초 코드 - 상세',
	            },
	            {
	                extend: 'excel',
	                title: '품질정보 기초 코드 - 상세',
	            },
	            {
	                extend: 'print',
	                title: '품질정보 기초 코드 - 상세',
	            },
	        ],  		
	}); */
	
	/* var htmlCd = '<button class="btn btn-primary float-left mr-2" type="button" id="baseCdAdd">등록</button>&nbsp;<button class="btn btn-primary float- mr-2" type="button" id="baseCdEdit">수정</button>';
	$('#inspectInfoAdmCommonCd_length').html(htmlCd); */

   	//$('#baseGroupAdd').click(function () {
   	//	addHtml("groupCdAdd", "");
   	//	selectBoxAppend(useYnCode, "puUseYnCd", "001", "2");
   	//	$('#layerPopUpLabel').text('기초코드등록');
   	//	$('#layerPopUpModal').modal('show');
    //
   	//	//기초그룹코드 조회
   	//	$.ajax({
    //    	url: '<c:url value="bm/inspectInfoAdmReadGroupSeq"/>',
    //        type: 'GET',
    //        data: {
    //        	'menuAuth'	 : menuAuth,
	//		},
    //        success: function (res) {
    //            let data = res.data;
    //            let message = res.message;
    //            if(res.result == 'ok'){
	//				$('#puBaseGroupCd').val(data.baseGroupCd);
    //            }
    //            else if (res.result == 'fail') {
    //            	toastr.error(message);
	//			}
    //        }
    //    });
   	//});
    //
   	//$('#baseGroupEdit').click(function () {
   	//	var data = inspectInfoAdmCommonGroupCd.row('.selected').data();
   	//	if(data == null || data == undefined ) {
   	//		toastr.warning("수정할 기초코드들 선택해 주세요.");
   	//	} else {
	//   		addHtml("groupCdEdit", data);
	//   		$('#puBaseGroupCd').val(data.baseGroupCd);
	//   		$('#puBaseGroupCdNm').val(data.baseGroupCdNm);
	//   		$("#puBaseGroupCd").attr("disabled",true);
	//   		selectBoxAppend(useYnCode, "puUseYnCd", data.useYnCd, ""); 
	//   		$('#layerPopUpLabel').text('기초코드수정');
	//   		$('#layerPopUpModal').modal('show');
   	//   	}
   	//});  
/* 
   	$('#baseCdAdd').click(function () {
   		var data = inspectInfoAdmCommonGroupCd.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("등록할 기초코드 목록을 먼저 선택해 주세요.");
   		} else {
   	   		let baseGroupCd = data.baseGroupCd;
	   		addHtml("cdAdd");
	   		$('#puBaseGroupCd').val(data.baseGroupCd);
	   		selectBoxAppend(useYnCode, "puUseYnCd", "001", "2");
	   		$('#layerPopUpLabel').text('코드등록');
	   		$('#layerPopUpModal').modal('show');
	   		//기초코드상세 코드 조회
	   		$.ajax({
	        	url: '<c:url value="bm/inspectInfoAdmReadSeq"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 : menuAuth,
		            'baseGroupCd' : baseGroupCd,
	            },
	            success: function (res) {
	                let data = res.data;
	                let message = res.message;
	                if(res.result == 'ok'){
						$('#puBaseCd').val(data.baseCd);
	                }
	                else if (res.result == 'fail') {
	                	toastr.error(message);
					}
	            }
	        });
   		}
   	});

   	$('#baseCdEdit').click(function () {
   		var dataGrp = inspectInfoAdmCommonGroupCd.row('.selected').data();
   		if(dataGrp == null || dataGrp == undefined ) {
   			toastr.warning("수정할 기초코드들 먼저 선택해 주세요.");
   			return;
   		}
   		var data = systemCommonCd.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("수정할 코드들 선택해 주세요.");
   		} else {
	   		addHtml("cdEdit");
	   		$('#puBaseGroupCd').val(dataGrp.baseGroupCd);	   		
	   		$('#puBaseCd').val(data.baseCd);	
	   		$('#puBaseCdNm').val(data.baseCdNm); 	
	   		$('#puBaseCdAbbr').val(data.baseCdAbbr);
	   		$('#puEtc1').val(data.etc1); 		
	   		$('#puEtc2').val(data.etc2); 		
	   		$('#puEtc3').val(data.etc3); 		
	   		$('#puEtc4').val(data.etc4); 		
	   		$('#puEtc5').val(data.etc5); 		
	   		$('#puEtc6').val(data.etc6); 		
	   		$('#puEtc7').val(data.etc7); 		
	   		$('#puEtc8').val(data.etc8); 		
	   		$('#puEtc9').val(data.etc9); 		
	   		$('#puEtc10').val(data.etc10);
	        $("#puBaseCd").attr("disabled",true); 
	   		selectBoxAppend(useYnCode, "puUseYnCd", data.useYnCd, "");	   		
	   		$('#layerPopUpLabel').text('코드수정');
	   		$('#layerPopUpModal').modal('show');
   		}
   	});
   	  */ 	
   	/*
   	$('#layerPopUpSave').click(function () {
   	   	var puFlag = $('#puFlag').val();

   	   	if(puFlag == "groupCdAdd" || puFlag == "groupCdEdit") {
			baseGroupCdProc(puFlag);
   	   	} else {
   	   		baseCdProc(puFlag);
   	   	}
   		//$('#layerPopUpModal').modal('hide');
   	}); 
	
	// 시스템공통그룹 상세 정보 보기
	$('#inspectInfoAdmCommonGroupCd tbody').on('click', 'tr', function () {

        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#inspectInfoAdmCommonGroupCd').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            
	        baseGroupCd = inspectInfoAdmCommonGroupCd.row( this ).data().baseGroupCd;
		    console.log("baseGroupCd = " + baseGroupCd);
	   		$('#inspectInfoAdmCommonCd').DataTable().ajax.reload( function () {});
        }
   	});
       

   		
	//시스템공통그룹 등록
	function baseGroupCdProc(puFlag)
	{
	    if ( !$.trim($('#puBaseGroupCd').val()) ) {
	        toastr.warning('기초코드를 입력해 주세요.');
	        $('#puBaseGroupCd').focus();
	        return false;
	    }
	    if ( !$.trim($('#puBaseGroupCdNm').val()) ) {
	        toastr.warning('기초코드명을 입력해 주세요.');
	        $('#puBaseGroupCdNm').focus();
	        return false;
	    }
	   	if( $('#puUseYnCd option:selected').val() == "" ) {   
	        toastr.warning('사용여부 선택해 주세요.');
	        $('#puUseYnCd').focus();
	        return false;
	    }
	    
	    var groupUrl;
	    var groupMsg;
	    if(puFlag == "groupCdAdd") {
	    	groupUrl = '<c:url value="bm/inspectInfoAdmGroupCreate"/>';
	    	groupMsg = '기초코드가 등록 되었습니다.';
	    } else {
	    	groupUrl = '<c:url value="bm/inspectInfoAdmGroupUpdate"/>';
	    	groupMsg = '기초코드가 수정 되었습니다.';
	    }
	    
	    $.ajax({
	        url: groupUrl,
	        type: 'POST',
	        data: {
	        	'menuAuth'	 : menuAuth,
	            'baseGroupCd': $('#puBaseGroupCd').val(),
	            'baseGroupCdNm': $('#puBaseGroupCdNm').val(),
	            'useYnCd': $("#puUseYnCd option:selected").val(),
	            'regId': 'reg_id',
	            'updId': 'upd_id'
	        },
	        beforeSend: function() {
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
	            	toastr.success(groupMsg);
		            $('#inspectInfoAdmCommonGroupCd').DataTable().ajax.reload(); //등록 후 테이블 리로드	            	
	            	$('#layerPopUpModal').modal('hide');
	            } else if(res.result == 'exist') {
	            	toastr.warning("이미 등록되어 있는 코드번호 입니다.");
	            	$('#layerPopUpModal').modal('hide');
	            	$('#inspectInfoAdmCommonCd').DataTable().ajax.reload(); //등록 후 테이블 리로드		            	
	            } else {
	                toastr.error(res.message);
	            }
	        },
	        complete:function(){

	        }
	    });
	}

	//시스템공통코드 등록,수정
	function baseCdProc(puFlag)
	{
	    if ( !$.trim($('#puBaseGroupCd').val()) ) {
	        toastr.warning('기초코드를 확인해 주세요.');
	        //$('#puBaseGroupCd').focus();
	        return false;
	    }
	    if ( !$.trim($('#puBaseCd').val()) ) {
	        toastr.warning('코드를 입력해 주세요.');
	        $('#puBaseCd').focus();
	        return false;
	    }
	    if ( !$.trim($('#puBaseCdNm').val()) ) {
	        toastr.warning('코드명을 입력해 주세요.');
	        $('#puBaseCdNm').focus();
	        return false;
	    }
	    //if ( !$.trim($('#puBaseCdAbbr').val()) ) {
	    //    toastr.warning('코드약칭을 입력해 주세요.');
	    //    $('#puBaseCdAbbr').focus();
	    //    return false;	        
	    //}
	   	if( $("#puUseYnCd option:selected").val() == "" ) {   
	        toastr.warning('사용여부 선택해 주세요.');
	        $('#puUseYnCd').focus();
	        return false;
	    }
	    
	    var cdUrl;
	    var cdMsg;
	    if(puFlag == "cdAdd") {
	    	cdUrl = '<c:url value="bm/inspectInfoAdmCodeCreate"/>';
	    	cdMsg = '세부코드가 등록 되었습니다.';
	    } else {
	    	cdUrl = '<c:url value="bm/inspectInfoAdmCodeUpdate"/>';
	    	cdMsg = '세부코드가 수정 되었습니다.';
	    }
	    $.ajax({
	        url: cdUrl,
	        type: 'POST',
	        data: {
	        	'menuAuth'	 : menuAuth,
				'baseGroupCd' 	: $('#puBaseGroupCd').val(),
				'baseCd' 		: $('#puBaseCd').val(),
				'baseCdNm' 		: $('#puBaseCdNm').val(),
				'baseCdAbbr' 	: $('#puBaseCdAbbr').val(),
				'etc1' 			: $('#puEtc1').val(),
				'etc2' 			: $('#puEtc2').val(),
				'etc3' 			: $('#puEtc3').val(),
				'etc4' 			: $('#puEtc4').val(),
				'etc5' 			: $('#puEtc5').val(),
				'etc6' 			: $('#puEtc6').val(),
				'etc7' 			: $('#puEtc7').val(),
				'etc8' 			: $('#puEtc8').val(),
				'etc9' 			: $('#puEtc9').val(),
				'etc10' 		: $('#puEtc10').val(),
				'useYnCd' 		: $("#puUseYnCd option:selected").val(),
	        },
	        beforeSend: function() {
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
	            	toastr.success(cdMsg);
	            	$('#layerPopUpModal').modal('hide');
	            	$('#inspectInfoAdmCommonCd').DataTable().ajax.reload(); //등록 후 테이블 리로드
	            } else if(res.result == 'exist') {
	            	toastr.warning("이미 등록되어 있는 코드번호 입니다.");
	            	$('#layerPopUpModal').modal('hide');
	            	$('#systemCommonCd').DataTable().ajax.reload(); //등록 후 테이블 리로드		            	
	            } else {
	                toastr.error(res.message);
	            }
	        },
	        complete:function(){
	            
	        }
	    });
	}	 
	
   	function addHtml(flag)
   	{
   	   	var html;
   	   	if(flag == "groupCdAdd" || flag == "groupCdEdit") { //기초코드수정
			html = '<tr>';
			html += '<td class="align-middle" style="width: 80px">기초코드</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseGroupCd" name="puBaseGroupCd" disabled></td>';	
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle"  style="width: 80px">*기초코드명</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseGroupCdNm"  name="puBaseGroupCdNm" maxlength="25"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle"  style="width: 80px">*사용여부</td>';
			html += '<td style="width: 100px"><select class="select-custom" id="puUseYnCd"></select></td>';
			html += '</tr>';			
			$('#layerPopUpTable').html(html);
			$('#puFlag').val(flag);
   	   	}  else { // 코드수정
			html = '<tr>';
			html += '<td class="align-middle" style="width: 80px">*코드</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCd"  name="puBaseCd" maxlength="3"></td>';	
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">*코드명</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCdNm"  name="puBaseCdNm" maxlength="25"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">코드약칭</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCdAbbr"  name="puBaseCdAbbr" maxlength="64"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크1</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc1"  name="puEtc1"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크2</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc2"  name="puEtc2"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크3</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc3"  name="puEtc3"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크4</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc4"  name="puEtc4"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크5</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc5"  name="puEtc5"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크6</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc6"  name="puEtc6"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크7</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc7"  name="puEtc7"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크8</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc8"  name="puEtc8"></td>';
			html += '</tr>';						
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크9</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc9"  name="puEtc9"></td>';
			html += '</tr>';																	
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크10</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc10"  name="puEtc10"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">*사용여부</td>';
			html += '<td style="width: 100px"><select class="select-custom" id="puUseYnCd"></select></td>';
			html += '<input type="hidden" id="puBaseGroupCd"  name="puBaseGroupCd">';
			html += '</tr>';
			$('#layerPopUpTable').html(html);
			$('#puFlag').val(flag);
   	   	} 			
   	}*/
</script>

</body>
</html>
