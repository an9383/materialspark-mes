<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>

<!-- .app -->
<div class="app pda_mo_wrap">
	<header class="pda_mo_hd">
		<div class="float-left">
			<a href="#"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a>
		</div>
		<div class="p-2 col-11 text-center">
			<p class="m-0 mo_main_title">자재입고</p>
		</div>
	</header>
	<main>
		<div class="container-fluid" id="main">
			<!--====-sortbox-->
			<div class="mo_sortbox">
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">입고일</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input class="form-control-md" type="text" id="startDate" name="startDate" value="" />
						<button onclick="fnPopUpCalendar(startDate,startDate,'yyyy-mm-dd');" class="btn btn-secondary input-sub-search-md" type="button">
							<span class="oi oi-calendar"></span>
						</button>
					</div>
				</div>
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">Location NO</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<select id="" class="custom-select custom-select-md">
							<option selected>전체</option>
							<option value="1">주간</option>
							<option value="1">야간</option>
						</select>
					</div>
				</div>
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">Barcode NO</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" placeholder="">
					</div>
				</div>
			</div>
			<!--==end==-sortbox-->
			<!--table-->
			<!-- .table-responsive -->
			<div class="card mo_card">
				<div class="table-responsive">
					<table id="" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 5%;" class="p-1">순번</th>
								<th style="min-width: 21%;" class="p-1">재자코드</th>
								<th style="min-width: 21%;" class="p-1">자재명</th>
								<th style="min-width: 21%;" class="p-1">LOT NO</th>
								<th style="min-width: 21%;" class="p-1">입고량</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>M00002</td>
								<td>NiCU1020 H0 0.3*45 압연</td>
								<td>MCS0A20CF001</td>
								<td>23.5</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<!--==end==card-->
			<!--==버튼영역-->
			<div class="mo_btnbox">
				<div class="float-left">
					<button type="button" class="btn btn-danger float-right" id="">라인삭제</button>
					<button class="btn btn-primary d-none" id="" type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
					<button type="button" class="btn btn-danger float-right mr-2" id="">전체삭제</button>
					<button class="btn btn-primary d-none" id="" type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
				</div>
				<div class="float-right">
					<button type="button" class="btn btn-secondary float-right" id="">취소</button>
					<button class="btn btn-primary d-none" id="" type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>

					<button type="button" class="btn btn-primary float-right mr-2" id="">저장</button>
					<button class="btn btn-primary d-none" id="" type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
				</div>
			</div>
			<!--==end==버튼영역-->
			<!--==end==table-->
		</div>
	</main>
</div>
<!-- /.app -->
<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>
<script>

</script>

</body>
</html>
