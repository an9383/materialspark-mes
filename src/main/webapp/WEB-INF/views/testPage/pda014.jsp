<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>

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
						<input type="text" class="form-control-md" placeholder="">
						<button class="btn btn-secondary input-sub-search-md" type="button">
							<span class="oi oi-magnifying-glass"></span>
						</button>
					</div>
				</div>
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">Barcode NO</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="button" class="form-control-md" placeholder="" data-toggle="modal" data-target="#mo-modal">
					</div>
				</div>
			</div>
			<!--==end==-sortbox-->
			<!--table-->
			<!-- .table-responsive -->
			<div class="card mo_card mo_card_fix">
				<div class="table-responsive">
					<table id="" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 5%;" class="p-1">순번</th>
								<th style="min-width: 21%;" class="p-1">재자코드</th>
								<th style="min-width: 21%;" class="p-1">자재명</th>
								<th style="min-width: 21%;" class="p-1">LOT NO</th>
								<th style="min-width: 20%;" class="p-1">입고량</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="p-0">
									<div class="custom-control custom-control-inline custom-checkbox m-0">
										<input type="checkbox" class="custom-control-input" id="ckb1">
										<label class="custom-control-label" for="ckb1"></label>
									</div>
								</td>
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
			<!--합계 영역-->
			<div class="mo_sumbox mb-3">
				<div class="row float-right">
					<div class="mo_roll mr-4">
						<label>합계</label> <span class="mo_sum_font_lg">1</span> <label>Roll</label>
					</div>
					<div class="mo_kg">
						<span class="mo_sum_font_lg">23.5</span> <label>KG</label>
					</div>
				</div>
			</div>
			<!--==end==합계 영역-->
			<!--버튼영역-->
			<div class="col-12 mo_btnbox p-0">
				<div class="float-left d-none">
					<button type="button" class="btn btn-danger float-right" id="">라인삭제</button>
					<button class="btn btn-primary d-none" id="" type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
					<button type="button" class="btn btn-danger float-right mr-2" id="">전체삭제</button>
					<button class="btn btn-primary d-none" id="" type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
				</div>
				<div class="mt-2">
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
<!------------mo_alert------------>
<div class="modal fade mo_modalbox" id="mo-modal" tabindex="-1"
	role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header modal-header-colored">
				<button class="close md-close" type="button" data-dismiss="modal" aria-hidden="true">
					<span class="mdi mdi-close"> </span>
				</button>
			</div>
			<div class="modal-body">
				<div class="mo_alert text-center">
					<p>입고일자 빠른 <span class="font-red">미출고 자재</span>가 있습니다. </p>
					<p>확인 바랍니다.</p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-space btn-info" type="button" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!------------/mo_alert------------>
<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>
<script>

</script>

</body>
</html>
