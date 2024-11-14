<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!-- 승인처리 -->
	<div class="modal fade bs-example-modal-lg shadow-lg" id="agreeModal" tabindex="-1" role="dialog" aria-labelledby="agreeModalLabel" aria-hidden="true" data-keyboard="false">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content" style="width: 60%; margin-left: 90%; margin-top: 25%;">
	            <div class="modal-header">
	           		<h5 class="modal-title" id="agreeModalLabel">승인 날짜 확인</h5>
	            </div>
	            <div class="modal-body">
	            	<br>
<!-- 	            	<h6 id="agreeModalH6"></Mh6> -->
			    	<div class="row">
						<h6 style="line-height: 1.7;">승인날짜 : </h6>
			    		<input type="date" class="form-control ml-1" id="agreeModalDate">			    	
			    	</div>
			    </div>
	            <div class="modal-footer" id="divSudel">
	            	<button type="button" class="btn btn btn-primary btnCheckConfirm" style="width: 16%;" id="btnModalAgree">승인</button>
	            	<button type="button" class="btn btn-secondary" style="width: 16%;" data-dismiss="modal">닫기</button>
	            </div>
	        </div>
	    </div>
	</div>
	<!--//승인처리 -->
    <!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">수입검사관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 59%;">
				<div class="card">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="matrlInOutWhsInspectTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width:140px" class="text-center">승인</th>
									<th style="min-width:45px" class="text-center">입고일</th>
									<th style="min-width:50px" class="text-center">자재코드</th>
									<th style="min-width:100px" class="text-center">자재명</th>
									<th style="min-width:50px" class="text-center">가입고량</th>
									<th style="min-width:40px" class="text-center">입고량</th>
									<th style="min-width:40px" class="text-center">차이</th>
									<th style="min-width:60px" class="text-center">공급업체</th>
									<th style="min-width:45px" class="text-center">가입고일</th>
									<th style="min-width:45px" class="text-center">수입검사일</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="4" class="text-center">합계</td>
									<td style="text-align: right" id="sumPreInWhsQty">...</td>
									<td style="text-align: right" id="sumInspectQty">...</td>
									<td style="text-align: right" id="sumDiffQty">...</td>
									<td colspan="3" style="text-align: center">-</td>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-40" id="myrSidenav" style="width: 40%; padding-bottom: 0px;">
				<div class="card" id="formBox">
					<div style="height: 30px;" id="btnDiv"></div>
					<form id="form">
						<div class="table-responsive">
							<table id="matrlInOutWhsInspectDtlTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th class="text-center">
											<input type="checkbox" id="checkAll" name="checkAll" style="width:20px; height:20px">
										</th>
										<th class="text-center" style="min-width:50px; max-width:70px;">비고</th>
										<th class="text-center" style="min-width:50px; max-width:45px;">승인여부</th>
										<th class="text-center" style="min-width:50px; max-width:50px;">상태</th>
										<th class="text-center" style="min-width:50px; max-width:45px;">합격여부</th>
										<th class="text-center">LOT NO</th>
										<th class="text-center" style="min-width:45px; max-width:45px;">가입고량</th>
										<th class="text-center" style="min-width:45px; max-width:45px;">입고량</th>
										<th class="text-center" style="min-width:45px; max-width:45px;">잔여량</th>
										<!-- <th class="text-center">바코드</th> -->
									</tr>
								</thead>
							</table>
						</div>
					</form>
				</div>
				<!--// 등록, 수정 -->
			</div>
			<!-- .right-sidebar -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div><!-- /.page-wrapper -->
<!-- 보류&불량&반품 등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="frrrdPopUpModal" tabindex="-1" role="dialog" aria-labelledby="faultyPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="frrrdPopUpLabel">불량 처리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				<table id="frrrdPopUpTable" class="table table-bordered" style="margin-bottom: 8px;">
					<colgroup><col width="40%"></colgroup>
					<colgroup><col width="60%"></colgroup>
					<thead class="thead-light" style="margin-top: 0px;">
						<tr>
							<th id="frrrdDateLabel"></th>
							<td>
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="min-width:100%;" type="date" id="frrrdDate" name="frrrdDate">
								</div>
							</td>
						</tr>
						<tr>
							<th id="frrrdDescLabel"></th>
							<td>
								<input type="text" id="frrrdDesc" name="frrrdDesc" style="max-width: 100%;" class="form-control" />
							</td>
						<tr>
						<th id="frrrdTypeLabel"></th>
							<td>
							<c:forEach var="item" items="${matrlFaultyType}">
								<div class="row">
									<div class="col-6 text-center">${item.baseCdNm}</div>
									<div class="col-6 text-center"><input type="checkbox" id="frrrdType${item.baseCd}" style="zoom:1.8;"></div>	
								</div>
							</c:forEach>
							</td>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnFaultySave" data-dismiss="modal" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 보류&불량&반품 등록 모달 종료 -->


<!-- 수입검사 메탈 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="realMatrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="realMatrlPopUpModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1400px;">
    <div class="modal-content">
	      <div class="modal-header" style="padding-bottom: 0px;">
	        <h5 class="modal-title" id="realMatrlPopUpLabel">메탈 수입검사</h5>
	        <h5 class="modal-title mb-1" style="margin-left: 65%;">검사일 : <input type="date" style=" width:165px; border:solid 0px; border-bottom:solid 1px" id="realMatrlDate"> </h5>
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
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_1" value="Scratch" disabled/><input  	type="hidden" id="matrl001_inspectItem1" value=""/> </td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem1_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem1_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_1" value="변색" disabled/><input  	type="hidden" id="matrl001_inspectItem2" value=""/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem2_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem2_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_1" value="이물" disabled/><input  	type="hidden" id="matrl001_inspectItem3" value=""/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem3_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem3_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_1" value="도금박리" disabled/><input  	type="hidden" id="matrl001_inspectItem4" value=""/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem4_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem4_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_1" value="권취" disabled><input  	type="hidden" id="matrl001_inspectItem5" value=""/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem5_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem5_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem6_1" value="도금 밀착성" disabled><input  	type="hidden" id="matrl001_inspectItem6" value=""/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem6_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem6_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem6_4" /></td>
						</tr>
<!-- 						<tr>							 -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem7_1" value="젖음성" disabled></td> -->
<!-- 							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem7_2" value="물방울이 맺히지 않을 것" disabled/></td> -->
<!-- 							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem7_3"></select></td> -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem7_4" /></td> -->
<!-- 						</tr> -->
						
						
<!-- 						<tr>							 -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem8_1" value="" disabled></td> -->
<!-- 							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem8_2" value="" disabled/></td> -->
<!-- 							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem8_3" disabled></select></td> -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem8_4" disabled/></td> -->
<!-- 						</tr> -->
<!-- 						<tr>							 -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem9_1" value="" disabled></td> -->
<!-- 							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem9_2" value="" disabled/></td> -->
<!-- 							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem9_3" disabled></select></td> -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem9_4" disabled/></td> -->
<!-- 						</tr> -->
						<!--
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem10_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem10_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem10_3"disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem10_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem11_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem11_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl001_inspectItem12_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_inspectItem12_4" disabled/></td>
						</tr>
						 -->
						 </tbody>
				</table>
				
				 <table id="sizeMatrlPopUpTable" class="table table-bordered">
                 	   <thead class="thead-light">
							<tr>								
								<th style="width:10%;" rowspan="2">관리항목</th>
								<th style="width:38%;" colspan="6" rowspan="2">규격</th>
								<th style="width:7%;" rowspan="2"> 평균값 </th>
								<th style="width:35%;" colspan="10">시편별 측정값</th>
								<th style="width:10%;" rowspan="2">비고</th>
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
							<td	colspan="5" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input1_3" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input1_4" disabled /></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input1_5" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input1_6" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input1_7" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input1_8" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input1_9" value="0"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input1_10" /></td>
							
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input2_1" value="폭(mm)" disabled/></td>
							<td	colspan="5" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input2_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input2_3" disabled /></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input2_4" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input2_5" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input2_6" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input2_7" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input2_8" value="0"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input2_9" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input3_1" value="Burr(mm)" disabled/></td>
							<td	colspan="5" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input3_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input3_3" disabled /></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input3_4" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input3_5" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input3_6" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input3_7" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float mustInput" style="max-width:100%" 	type="text" id="matrl001_input3_8" value="0"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input3_9" /></td>
						</tr>
						<tr>
							<td	rowspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_1" value="면취" disabled></td>
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_2" value="두께(mm)" disabled/></td>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_3" value="0.2T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_4" value="0.3T" disabled /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_5" value="0.4T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_6" value="0.5T" disabled/></td>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" value="공차" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_7" disabled/></td>
							<td	colspan="5" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_8" value="좌" disabled/></td>
							<td	colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input4_9" value="우" disabled/></td>
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_8" /></td>
						</tr>
						<tr>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_1" value="200±100" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_2" value="300±100" disabled /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_3" value="350±100" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_4" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlGongcha1" value="공차1" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_5" disabled/></td>
							<td	colspan="5" ><input class="form-control number-float3 input5_float  mustInput" style="max-width:100%" 	type="number" id="matrl001_input5_6" value="0"/></td>
							<td	colspan="5"	><input class="form-control number-float3 input5_float mustInput" style="max-width:100%" 	type="number" id="matrl001_input5_7" value="0" /></td>
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input5_8" /></td> -->
						</tr>
						<tr>
							<td	rowspan="2" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_1" value="T두께" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_2" value="0.2" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_3" value="0.3" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_4" value="0.4" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_5" value="0.6" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" value="공차" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_6" value="" disabled /></td>
							<td	colspan="10"><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_7" value="" disabled /></td>
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_15" value="" /></td>	
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_9" value="0.2" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_10" value="0.3" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_11" value="0.4" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_12" value="0.6" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlGongcha2" value="공차" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_13" value="" disabled /></td>
							<td	colspan="10"><input class="form-control mustInput" style="max-width:100%" 	type="text" id="matrl001_input6_14" value=""  /></td>
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input6_15" value="" /></td>	 -->
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_1" value="ET두께" disabled/></td>
							<td	colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_3" value="" disabled /></td>
							<td	colspan="10"><input class="form-control mustInput" style="max-width:100%" 	type="text" id="matrl001_input7_4" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input7_5" value="" /></td>
						</tr>						
					
						<tr>
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_1" value="내절강도" disabled></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_2" value="" disabled/></td>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_3" value="0.2T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_4" value="0.2T(H18)" disabled /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_5" value="0.2T(H14)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input8_6" value="0.3T ↑" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" value="공차" disabled/></td>
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
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_17" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_1" value="" disabled/></td>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_3" value="" disabled /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_4" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_5" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlGongcha3" value="공차" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_6" value="" disabled/></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_7" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_8" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_9" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_10" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_11" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_12" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_13" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_14" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_15" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrl001_input9_16" value="0" /></td>												
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl001_input9_17" /></td> -->
						</tr>
				</table>
	      </div>
	      <div class="modal-footer" style="padding-top: 0px;">
	        <button type="button" class="btn btn-primary" id="realMatrlPopUpSave">저장</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- 수입검사 메탈 모달 종료 -->

<!-- 수입검사 자재 기존 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="originMatrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="originMatrlPopUpModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1400px;">
    <div class="modal-content">
	      <div class="modal-header" style="padding-bottom: 0px;">
	        <h5 class="modal-title" id="originMatrlPopUpLabel">메탈 수입검사</h5>
	        <h5 class="modal-title mb-1" style="margin-left: 65%;">검사일 : <input type="date" style=" width:165px; border:solid 0px; border-bottom:solid 1px" id="originMatrlDate"> </h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body">
                <table id="exteriorOriginMatrlPopUpTable" class="table table-bordered">
                    <thead class="thead-light">
							<tr>								
								<th style="width:20%">관리항목</th>
								<th style="width:20%" colspan="3">규격</th>
								<th style="width:10%">검사결과</th>
								<th style="width:40%">비고</th>
							</tr>
						</thead>
						<tbody id="matrlTbody001Origin">
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem1_1" value="Scratch" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem1_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem1_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem1_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem2_1" value="변색" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem2_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem2_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem2_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem3_1" value="이물" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem3_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem3_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem3_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem4_1" value="도금박리" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem4_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem4_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem4_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem5_1" value="권취" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem5_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem5_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem5_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem6_1" value="도금 밀착성" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem6_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem6_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem6_4" /></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem7_1" value="젖음성" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem7_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem7_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem7_4" /></td>
						</tr>
						
						
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem8_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem8_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem8_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem8_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem9_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem9_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem9_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem9_4" disabled/></td>
						</tr>
						<!--
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem10_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem10_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem10_3"disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem10_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem11_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem11_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem11_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem11_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem12_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem12_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem12_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem12_4" disabled/></td>
						</tr>
						 -->
						 </tbody>
				</table>
				
				 <table id="sizeOriginMatrlPopUpTable" class="table table-bordered">
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
							<td	rowspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input1_1" value="치수" disabled></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input1_2" value="두께(mm)" disabled/></td>
							<td	colspan="4" ><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input1_3" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input1_4" disabled /></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrlOld_input1_5" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrlOld_input1_6" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrlOld_input1_7" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrlOld_input1_8" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input1_float" style="max-width:100%" 	type="text" id="matrlOld_input1_9" value="0"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input1_10" /></td>
							
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input2_1" value="폭(mm)" disabled/></td>
							<td	colspan="4" ><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input2_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input2_3" disabled /></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrlOld_input2_4" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrlOld_input2_5" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrlOld_input2_6" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrlOld_input2_7" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input2_float" style="max-width:100%" 	type="text" id="matrlOld_input2_8" value="0"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input2_9" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input3_1" value="Burr(mm)" disabled/></td>
							<td	colspan="4" ><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input3_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input3_3" disabled /></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrlOld_input3_4" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrlOld_input3_5" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrlOld_input3_6" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrlOld_input3_7" value="0"/></td>
							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrlOld_input3_8" value="0"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input3_9" /></td>
						</tr>
						<tr>
							<td	rowspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_1" value="면취" disabled></td>
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_2" value="두께(mm)" disabled/></td>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_3" value="0.2T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_4" value="0.3T" disabled /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_5" value="0.4T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_6" value="0.5T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_7" disabled/></td>
							<td	colspan="5" ><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_8" value="좌" disabled/></td>
							<td	colspan="5"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_9" value="우" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input4_10" /></td>
						</tr>
						<tr>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input5_1" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input5_2" value="" disabled /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input5_3" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input5_4" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input5_5" disabled/></td>
							<td	colspan="5" ><input class="form-control number-float3 input5_float" style="max-width:100%" 	type="number" id="matrlOld_input5_6" value="0"/></td>
							<td	colspan="5"	><input class="form-control number-float3 input5_float" style="max-width:100%" 	type="number" id="matrlOld_input5_7" value="0" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input5_8" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input6_1" value="T두께" disabled/></td>
							<td	colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input6_2" value="T+Max20" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input6_3" value="" disabled /></td>
							<td	colspan="10"><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input6_4" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input6_5" value="" /></td>
							
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input7_1" value="ET두께" disabled/></td>
							<td	colspan="4"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input7_2" value="TBD" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input7_3" value="" disabled /></td>
							<td	colspan="10"><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input7_4" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input7_5" value="" /></td>
						</tr>						
					
						<tr>
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_1" value="내절강도" disabled></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_2" value="" disabled/></td>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_3" value="0.2T" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_4" value="0.2T(H18)" disabled /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_5" value="0.2T(H14)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_6" value="0.3T ↑" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_7" value="평균값" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_8" value="1" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_9" value="2" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_10" value="3" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_11" value="4" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_12" value="5" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_13" value="6" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_14" value="7" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_15" value="8" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_16" value="9" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_17" value="10" disabled/></td>												
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input8_18" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input9_1" value="" disabled/></td>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input9_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input9_3" value="" disabled /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input9_4" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input9_5" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input9_6" value="" disabled/></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_7" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_8" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_9" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_10" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_11" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_12" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_13" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_14" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_15" value="0" /></td>
							<td				><input class="form-control number-float3 input9_float" style="max-width:100%" 	type="number" id="matrlOld_input9_16" value="0" /></td>												
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_input9_17" /></td>
						</tr>
				</table>
	      </div>
	      <div class="modal-footer" style="padding-top: 0px;">
	        <button type="button" class="btn btn-primary" id="originMatrlPopUpSave">저장</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- 수입검사 자재 기존 모달 종료 -->

<!-- 수입검사 원자재 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="rowMatrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="rowMatrlPopUpModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1300px;">
    <div class="modal-content">
	      <div class="modal-header" style="padding-bottom: 0px;">
	        <h5 class="modal-title" id="rowMatrlPopUpLabel">원자재 수입검사</h5>
	        <h5 class="modal-title mb-1" style="margin-left: 65%;">검사일 : <input type="date" style="width:165px; border:solid 0px; border-bottom:solid 1px" id="rowMatrlDate"> </h5>
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
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input1_2" value="Scratch" disabled/><input type="hidden" id="matrl002_inspectItem1" value=""/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%;" id="matrl002_input1_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl002_input1_4" style="min-width:100%"></select></td>
	                    	<td><input type="text" class="form-control etc" style="max-width:100%"  id="matrl002_input1_5" value="" /></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input2_1" value="2" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input2_2" value="얼룩" disabled/><input type="hidden" id="matrl002_inspectItem2" value=""/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%;" id="matrl002_input2_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl002_input2_4" style="min-width:100%"></select></td>
	                    	<td><input type="text" class="form-control etc" style="max-width:100%" id="matrl002_input2_5" value="" /></td>                     	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input3_1" value="3" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input3_2" value="ROSH" disabled/><input type="hidden" id="matrl002_inspectItem3" value=""/></td> 
	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%;" id="matrl002_input3_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl002_input3_4"></select></td>
	                    	<td><input type="text" class="form-control etc" style="max-width:100%" id="matrl002_input3_5" value="" /></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td rowspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_1" value="4" disabled/></td> 
	                    	<td rowspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_2" value="치수" disabled/></td> 	                    	
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_3" value="두께(mm)" disabled/><input type="hidden" id="matrl002_inspectItem4" value=""/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input4_4" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl002_input4_5"/></select></td> 
	                    	<td><input type="text" class="form-control etc" style="max-width:100%" id="matrl002_input4_6" value="" /></td> 
	                    </tr>
	                    <tr>	
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input5_1" value="폭(mm)" disabled/><input type="hidden" id="matrl002_inspectItem5" value=""/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl002_input5_2" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl002_input5_3"/></select></td> 	                    	
	                    	<td><input type="text" class="form-control etc" style="max-width:100%" id="matrl002_input5_4" value="" /></td>                        	                  
                    	</tr>                    	
                    </tbody>
				</table>
	      </div>
	     <div class="modal-footer" style="padding-top: 0px;">
	     	<button type="button" class="btn btn-primary" id="rowMatrlPopUpSave">저장</button>
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
	        <h5 class="modal-title mb-1" style="margin-left: 37%;">검사일 : <input type="date" style="width:165px; border:solid 0px; border-bottom:solid 1px" id="procMatrlDate"> </h5>
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
	                    	<th>규격</th> 
	                    	<th>검사결과</th> 
	                    	<th>비고</th>                    	                  
	                    </tr>
                    </thead>
                    <tbody id="matrlTbody003">
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input1_1" value="1" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input1_2" value="Scratch" disabled/><input type="hidden" id="matrl003_inspectItem1" value=""/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input1_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input1_4"></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input1_5" value="" /></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input2_1" value="2" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input2_2" value="얼룩" disabled/><input type="hidden" id="matrl003_inspectItem2" value=""/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input2_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input2_4"></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input2_5" value="" /></td>                     	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input3_1" value="3" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input3_2" value="ROSH" disabled/><input type="hidden" id="matrl003_inspectItem3" value=""/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input3_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input3_4"></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input3_5" value="" /></td>                    	                  
                    	</tr>
                    	<tr>
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_1" value="4" disabled/></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_2" value="치수 폭(mm)" disabled/><input type="hidden" id="matrl003_inspectItem4" value=""/></td>	                    	
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_3" value="" disabled/></td> 
	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input4_4"></select></td> 
	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input4_5" value="" /></td> 
	                    </tr>

<!-- 						<tr> -->
<!-- 	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input5_1" value="5" disabled/></td>  -->
<!-- 	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input5_2" value="" disabled/></td>  -->
<!-- 	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl003_input5_3" value="" disabled/></td>  -->
<!-- 	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input5_4" disabled></select></td>  -->
<!-- 	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input5_5" value="" disabled/></td>                    	                   -->
<!--                     	</tr> -->
<!--                     	<tr> -->
<!-- 	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input6_1" value="6" disabled/></td>  -->
<!-- 	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input6_2" value="" disabled/></td>  -->
<!-- 	                    	<td colspan="2"><input type="text" class="form-control" style="max-width:100%" id="matrl003_input6_3" value="" disabled/></td>  -->
<!-- 	                    	<td><select class="custom-select custom-select-sm" id="matrl003_input6_4" disabled></select></td>  -->
<!-- 	                    	<td><input type="text" class="form-control" style="max-width:100%" id="matrl003_input6_5" value="" disabled/></td>                    	                   -->
<!--                     	</tr> -->



                    </tbody>
				</table>
	      </div>
	      <div class="modal-footer" style="padding-top: 0px;">
	      	<button type="button" class="btn btn-primary" id="procMatrlPopUpSave">저장</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- 수입검사 가공원자재 모달 종료 -->

<!-- 수입검사 필름 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="filmMatrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="filmMatrlPopUpModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="min-width:1400px;">
    <div class="modal-content">
	      <div class="modal-header" style="padding-bottom: 0px;">
	        <h5 class="modal-title" id="filmMatrlPopUpLabel">필름 수입검사</h5>
	        <h5 class="modal-title mb-1" style="margin-left: 65%;">검사일 : <input type="date" style=" width:165px; border:solid 0px; border-bottom:solid 1px" id="filmMatrlDate"> </h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body">
                <table id="exteriorFilmPopUpTable" class="table table-bordered">
                    <thead class="thead-light">
							<tr>								
								<th style="width:20%">관리항목</th>
								<th style="width:20%" colspan="3">규격</th>
								<th style="width:10%">검사결과</th>
								<th style="width:40%">비고</th>
							</tr>
						</thead>
						<tbody id="matrlTbody004">
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem1_1" value="Scratch" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem1_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem1_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem1_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem2_1" value="변색" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem2_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem2_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem2_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem3_1" value="이물" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem3_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem3_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem3_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem4_1" value="도금박리" disabled/></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem4_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem4_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem4_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem5_1" value="권취" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem5_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem5_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem5_4" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_1" value="도금 밀착성" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem6_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem6_4" /></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem7_1" value="젖음성" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem7_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem7_3"></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem7_4" /></td>
						</tr>
						
						
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem8_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem8_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem8_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem8_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem9_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem9_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem9_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem9_4" disabled/></td>
						</tr>
						<!--
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem10_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem10_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem10_3"disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem10_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem11_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem11_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem11_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem11_4" disabled/></td>
						</tr>
						<tr>							
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_1" value="" disabled></td>
							<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_2" value="" disabled/></td>
							<td				><select class="custom-select custom-select-sm" id="matrl004_inspectItem12_3" disabled></select></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem12_4" disabled/></td>
						</tr>
						 -->
						 </tbody>
				</table>
				
				 <table id="sizeFilmMatrlPopUpTable" class="table table-bordered">
                 	   <thead class="thead-light">
							<tr>								
								<th style="width:10%;" rowspan="2">관리항목</th>
								<th style="width:24%;" colspan="2" rowspan="2">규격</th>
								<th style="width:6%;" rowspan="2">공차</th>
								<th style="width:10%;" rowspan="2"> 평균값 </th>
								<th style="width:35%;" colspan="5">시편별 측정값</th>
								<th style="width:15%;" rowspan="2">비고</th>
							</tr>
							<tr>
								<th style="width:7%;">1</th>
								<th style="width:7%;">2</th>
								<th style="width:7%;">3</th>
								<th style="width:7%;">4</th>
								<th style="width:7%;">5</th>
							</tr>	
							
						</thead>						
						<tr>							
							<td	rowspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input1_1" value="치수" disabled></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input1_2" value="두께(mm)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input1_3" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="004GC1" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input1_4" disabled /></td>
							<td				><input class="form-control number-float3 input11_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input1_5" value="0"/></td>
							<td				><input class="form-control number-float3 input11_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input1_6" value="0"/></td>
							<td				><input class="form-control number-float3 input11_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input1_7" value="0"/></td>
							<td				><input class="form-control number-float3 input11_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input1_8" value="0"/></td>
							<td				><input class="form-control number-float3 input11_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input1_9" value="0"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input1_10" /></td>
							
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input2_1" value="폭(mm)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input2_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="004GC2" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input2_3" disabled /></td>
							<td				><input class="form-control number-float3 input12_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input2_4" value="0"/></td>
							<td				><input class="form-control number-float3 input12_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input2_5" value="0"/></td>
							<td				><input class="form-control number-float3 input12_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input2_6" value="0"/></td>
							<td				><input class="form-control number-float3 input12_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input2_7" value="0"/></td>
							<td				><input class="form-control number-float3 input12_float mustInput" style="max-width:100%" 	type="text" id="matrl004_input2_8" value="0"/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input2_9" /></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input3_1" value="Burr(mm)" disabled/></td> -->
<!-- 							<td	colspan="4" ><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input3_2" value="±0.015mm ↓" disabled/></td> -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input3_3" disabled /></td> -->
<!-- 							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl004_input3_4" value="0"/></td> -->
<!-- 							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl004_input3_5" value="0"/></td> -->
<!-- 							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl004_input3_6" value="0"/></td> -->
<!-- 							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl004_input3_7" value="0"/></td> -->
<!-- 							<td	colspan="2"	><input class="form-control number-float3 input3_float" style="max-width:100%" 	type="text" id="matrl004_input3_8" value="0"/></td> -->
<!-- 							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input3_9" /></td> -->
<!-- 						</tr> -->
						<tr>
							<td	rowspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input4_1" value="단면" disabled></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input4_2" value="Pouch Side(mm)" disabled/></td>
							<td			 	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input4_3" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="004GC3" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input4_7" disabled/></td>
							<td	colspan="5" ><input class="form-control " style="max-width:100%" 	type="text" id="matrl004_input4_8" value=""/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input4_10" /></td>
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input6_1" value="Middle Side(mm)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input6_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="004GC4" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input6_3" value="" disabled /></td>
							<td	colspan="5"><input class="form-control " style="max-width:100%" 	type="text" id="matrl004_input6_4" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input6_5" value="" /></td>
							
						</tr>
						<tr>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input7_1" value="Metal Side(mm)" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input7_2" value="" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="004GC5" disabled/></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input7_3" value="" disabled /></td>
							<td	colspan="5"><input class="form-control " style="max-width:100%" 	type="text" id="matrl004_input7_4" value="" /></td>
							<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_input7_5" value="" /></td>
						</tr>						
					
						
				</table>
	      </div>
	      <div class="modal-footer" style="padding-top: 0px;">
	        <button type="button" class="btn btn-primary" id="filmMatrlPopUpSave">저장</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- 수입검사 필름 모달 종료 -->

<!-- 프린터 인쇄 장수 확인 모달 시작-->
<div class="modal fade" id="printCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="printCheckPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel">바코드 인쇄 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h6>인쇄하시겠습니까?</h6>
      	<div class="row">
      		<select class="custom-select custom-select-sm" id="printCountCheck" style="width:50px;"></select>&nbsp;<label class="input-label-sm">장 인쇄</label>
      	</div>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" id="btnPrintCheck" data-dismiss="modal" style="min-width:70px;">인쇄</button>
      	<button type="button" class="btn btn btn-secondary" id="btnPrintCancel" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 프린터 인쇄 장수 확인 모달 종료 -->
<!-- 삭제 확인 모달 시작-->
<div class="modal fade" id="deleteCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="deleteCheckPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel">삭제 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h6 id="deleteLotNo"></h6>
      	<p>경고! 삭제한 데이터는 복구 할 수 없습니다!</p>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger" id="btnDeleteCheck" data-dismiss="modal" style="min-width:70px;">삭제</button>
      	<button type="button" class="btn btn btn-secondary" id="btnDeleteCancel" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 삭제 확인 모달 종료 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc3020';
	let currentHref = 'qmsc3020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');  
	$(document).attr("title","수입검사관리");
    let viewIdx;
    var factoryCode = "<%=factoryCode%>";
    var sideView = 'add';
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
	var inspectItem16 = null;
	var inspectItem17 = null;
	var inspectItem18 = null;
	var inspectItem19 = null;
	var inspectItem20 = null;
	var inspectItem21 = null;
	var matrlCd = null;
	var preInWhsDate_startDate='';
	let gubun = '001';
	let searchLotNo = null;
	
	//공통코드 처리 시작
	var approvalCode=new Array(); // 승인여부
    <c:forEach items="${approvalCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCode.push(json);
    </c:forEach>

	var approvalCheck=new Array(); // 승인여부
    <c:forEach items="${approvalCheck}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCheck.push(json);
    </c:forEach>

    var printCountCheck=new Array(); // 승인여부
    <c:forEach items="${printCountCheck}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		printCountCheck.push(json);
    </c:forEach>

    var matrlFaultyType=new Array();	//자재불량유형
    <c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
    </c:forEach>

    var managementCode=new Array();	//수입검사 관리항목
    <c:forEach items="${managementCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.baseCdAbbr="${info.baseCdAbbr}";
		json.etc1="${info.etc1}";
		json.etc2="${info.etc2}";
		managementCode.push(json);
    </c:forEach>

    var matrlCdList=new Array();	//matrlCdList
    <c:forEach items="${matrlCdList}" var="info">
		var json=new Object();
		json.baseCd="${info.matrlCd}";
		json.baseCdNm="${info.matrlNm}";
		matrlCdList.push(json);
    </c:forEach>
    //공통코드 처리 종료  
                     		    
	var preInWhsDateCal = null;
	var endDate = "${serverDate}";
	if (factoryCode == '001' || factoryCode == '002') {
		preInWhsDateCal =  "${serverDate}";
	} else if (factoryCode == '003') {
		preInWhsDateCal =  "${serverDateFrom}";
	}
	
	var serverDate = "${serverDate}";
	$('#frrrdDate').val(serverDate);
	var frrrdDate 		= serverDate;			//불량&보류&반품일
	var frrrdType 		= '';
	var frrrdDesc 		= '';
	var approvalCd 		= '';
	var inspectlotNo 	= '';
	var matrlInOutWhsInspectSelectId;	//reload 시 선택 할 값
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let matrlInOutWhsInspectTable = $('#matrlInOutWhsInspectTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-11'l><'col-sm-12 col-md-1'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        searching : false,
        lengthChange: true,
        scrollY : "65vh",
        scrollCollapse: true,
        pageLength: -1,
        ajax: {
            url: '<c:url value="/qm/matrlInOutWhsInspectDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'startDate'		: function() { return preInWhsDateCal.replace(/-/g, ''); },
	           	'endDate'		: function() { return endDate.replace(/-/g, ''); },
// 	           	'endDate'		: $('#endDate').val().replace(/-/g, ''),
	           	'approvalCd'	: function() { return approvalCd; },
	           	'matrlCd'		: function() { return matrlCd;},
	           	'gubun'			: function() {return gubun;},
	           	'lotNo'	: function() {return searchLotNo;}
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'inWhsGroupSeq',
        columns: [
        	{
                data: 'approvalCd001',
                render: function(data, type, row) {
					if(data != "" && data != null) {
						return "<label style='font-size: 11px;'>승:" + data + ", 미:" + row['approvalCd002'] + ", 불:" + row['approvalCd003'] + ", 보:" + row['approvalCd004'] + ", 반:" + row['approvalCd005'] +"</label> <br> <label>"+"실반:" + row['approvalCd006'] + ", 자폐:" + row['approvalCd007'] + ", 폐:" + row['approvalCd008'] + ", 재:" + row['approvalCd009'] + "</label>";
					} else {
						return "-";
					}
                }	  
            },
            //{ data: 'approvalNm' },
            //{ data: 'inWhsDate' },
            { 
                data: 'inWhsDate',
                render: function(data, type, row) {					
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }	  
            },
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'preInWhsQty',
                render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
                }                
            },             
            { data: 'inspectQty',
                render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
                }                
            }, 
            { data: 'diffQty' ,
            	 render: function(data, type, row) {					
 					return parseFloat(data).toFixed(2);
                 }   
            },
            { data: 'spplyDealCorpNm' },                       
            //{ data: 'preInWhsDate' },
            { 
                data: 'preInWhsDate',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },             
            //{ data: 'inspctDate' }
            { 
                data: 'inspctDate',
                render: function(data, type, row) {					
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            }
        ],
        columnDefs: [
        	//{ "targets": [0], "className" : 'text-left' },
           	{ "targets": [4,5,6], "className" : 'text-right' },
           	{ "targets": [4,5,6], render: $.fn.dataTable.render.number( ',' )}
        ],
        order: [
            [ 2, 'asc' ]
        ],
        buttons: [
	        {
	            extend: 'copy',
	            title: '수입검사관리',
	        },
	        {
	            extend: 'excel',
	            title: '수입검사관리',
	        },
	        {
	            extend: 'print',
	            title: '수입검사관리',
	        },
        ],
        drawCallback: function () {
			$('#matrlInOutWhsInspectTable tfoot').remove();
			let sumPreInWhsQty	= $('#matrlInOutWhsInspectTable').DataTable().column(4,{ page: 'current'} ).data().sum();
			let sumInspectQty	= $('#matrlInOutWhsInspectTable').DataTable().column(5,{ page: 'current'} ).data().sum();
			let sumDiffQty		= $('#matrlInOutWhsInspectTable').DataTable().column(6,{ page: 'current'} ).data().sum();
			
			$('#sumPreInWhsQty').text(addCommas(sumPreInWhsQty.toFixed(2)));
			$('#sumInspectQty').text(addCommas(sumInspectQty.toFixed(2)));
			$('#sumDiffQty').text(addCommas(sumDiffQty.toFixed(2)));
        },
    });

    //var sysdate = "${serverTime}";
	var html1 = '<div class="row"><select id="gubun" class="custom-select" >';
		html1 += '<option value="001">가입고일</option>';
		html1 += '<option value="002">수입검사일</option></select>';
		html1 += '	<div class="m-0 row">';

		html1 += '<input class="form-control ml-2" style="width:125px;" type="date" id="preInWhsDate" name="preInWhsDate" />';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:125px;" type="date" id="endDate" name="endDate" />';
		//html1 += '<button onclick="fnPopUpCalendar(preInWhsDate, preInWhsDate, \'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="preInWhsDateCalendar" type="button">';
		//html1 += '<span class="oi oi-calendar"></span>';
		//html1 += '</button>'; 
		html1 += '</div>';
		//html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">승인여부</label><select  class="custom-select" style="width:60px;" id="approvalCd" ></select>&nbsp;  <button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button>';
		html1 += '<select class="custom-select ml-2" id="approvalCd" ></select>&nbsp;  ';
		html1 += '<input class="form-control ml-2" style="width:125px;" type="text" placeholder="LOT NO" id="searchLotNo" name="searchLotNo" />';
		html1 += '<button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button>';
		//html1 += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">자재명</label><select  class="custom-select" id="matrlCd" style="min-width:120px; max-width:120px;"></select></div>';
		html1 += '<select class="custom-select ml-2" id="matrlCd" style="min-width:120px; max-width:120px;"></select>';
		html1 += '<form id="formFile" method="post" enctype="multipart/form-data"><input type="file" class="d-none" id="reportUpload" name="file">';
		html1 += '<label class="btn btn-success ml-2" for="reportUpload">문서업로드</label></form></div>';
    
	$('#matrlInOutWhsInspectTable_length').html(html1);
	//selectBoxAppend(approvalCode, "approvalCd", "", "1");
	//selectBoxAppend(matrlCdList, "matrlCd", "", "1");
	
	selectBoxAppend_NameAdd(approvalCode, "approvalCd", "", "1", "승인");
	selectBoxAppend_NameAdd(matrlCdList, "matrlCd", "", "1", "자재");
	
	$('#preInWhsDate').val(preInWhsDateCal);
	$('#endDate').val(endDate);
	
	matrlSelectSet();
	
	//틀 고정 시 thead, tbody 깨지는 현상 잡아주는 부분
  	matrlInOutWhsInspectTable.on('draw.dt', function(){
  		matrlInOutWhsInspectTable.columns.adjust();
	});
	
	//문서업로드 버튼 클릭 시
	$('#reportUpload').on('click', function(){
		
		if ($("#matrlInOutWhsInspectTable tbody tr").find('td').eq(0).text() == "데이터가 없습니다.") {
			toastr.warning("데이터가 없습니다.");
			return false;
        }
		if($('#matrlInOutWhsInspectTable tbody tr').hasClass('selected') == '') {
			toastr.warning("테이블을 선택해주세요.");
			return false;
		}
	});
	
	$('#reportUpload').on('change', function() {
		
		$('#my-spinner').show();
		
		//데이터 담아주는 부분
		let group	= $('#matrlInOutWhsInspectTable').DataTable().rows('.selected').data()[0].fileGroup;
		let date	= moment($('#matrlInOutWhsInspectTable').DataTable().rows('.selected').data()[0].inWhsDate).format('YYYY');
		let data	= matrlInOutWhsInspectDtlTable.data();
		let lotNos	= data.map(data => data.lotNo).filter(lotNo => lotNo !== '');
			lotNos	= "'"+ lotNos.join().replaceAll(',', "', '") + "'";
			
		//formData 담아주는 부분
		let formData = new FormData(document.getElementById("formFile")); 
			formData.append('lotNo', lotNos);
			formData.append('fileGroup', group);
			formData.append('inWhsDate', date);

		$.ajax({
			url : '<c:url value="qm/matrlInOutReportUpload"/>',
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			success : function(res) {
				if (res.result == 'ok') {
					
					$('#reportUpload').val("");
					
					if($('#matrlCd option:selected').val() == '') {
        				matrlCd=''
            		}
        			inWhsGroupSeq='1';
	
					let mainScrollCatch = $($('.dataTables_scrollBody')[0]).scrollTop();
        			let serveScrollCatch = $($('.dataTables_scrollBody')[1]).scrollTop();
        			
            		$('#matrlInOutWhsInspectTable').DataTable().ajax.reload( function () {
            			$('#'+matrlInOutWhsInspectSelectId).click();
            			$('#'+matrlInOutWhsInspectSelectId).addClass('selected');
            			$($('.dataTables_scrollBody')[0]).scrollTop(mainScrollCatch);
            			setTimeout(function(){
            				$($('.dataTables_scrollBody')[1]).scrollTop(serveScrollCatch);
            				$('#my-spinner').hide();
            				toastr.success('등록되었습니다.');
            			},300);
	            	});
            		
            		
            		
				} else {
					toastr.error(res.message);
					$('#my-spinner').hide();
				}
			},
			complete:function() {
            	//$('#my-spinner').hide();
            }
		});
	});
	
	
	
  /*  $('#btnRetv').on('click', function() {
		preInWhsDateCal =  $('#preInWhsDate').val();
		approvalCd =  $('#approvalCd option:selected').val();
		matrlCd = null;
		$('#matrlInOutWhsInspectTable').DataTable().ajax.reload( function () {});
		$('#matrlInOutWhsInspectDtlTable').DataTable().clear().draw();
		$("#checkAll").prop("checked",false);
		inWhsGroupSeq='1';
		
		matrlSelectSet();
		/*  $.ajax({
	            url: '<c:url value="/io/inspectMatrlCodeList"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
		           	'preInWhsDate'	: function() { return preInWhsDateCal.replace(/-/g, ''); },
		           	'approvalCd'	: function() { return approvalCd; },		           
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
	      }); *//*
    });	*/


    //조회 버튼 클릭 시
    $('#btnRetv').on('click', function() {
		let dateFrom	= new Date($('#preInWhsDate').val());
		let dateTo		= new Date($('#endDate').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#preInWhsDate').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#preInWhsDate').focus();
			return false;
		}
		if (dateDiff >= 92) {
			toastr.warning("검색 가능 기간은 최대 세달입니다!");
			$('#preInWhsDate').focus();
			return false;
		}
		
		approvalCd		= $('#approvalCd option:selected').val();
		matrlCd			= null;
		preInWhsDateCal	= $('#preInWhsDate').val();
		endDate			= $('#endDate').val();
		inWhsGroupSeq	= '1';
		gubun = $('#gubun option:selected').val();
		searchLotNo = $('#searchLotNo').val();
		$('#matrlInOutWhsInspectTable').DataTable().ajax.reload( function () {});
		$('#matrlInOutWhsInspectDtlTable').DataTable().clear().draw();
		
		$("#checkAll").prop("checked",false);
		
		matrlSelectSet();
    });
    

	var inWhsGroupSeq = '1';
	var matrlGubunCd = '001';


	$.fn.dataTable.ext.errMode = 'none';
	let matrlInOutWhsInspectDtlTable = $('#matrlInOutWhsInspectDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-3'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B", 
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : true,
        searching: false,
        scrollY : "650px",
        lengthChange: false,
        pageLength: 20,            
        ajax: {
            url: '<c:url value="/qm/matrlInOutWhsInspectDataDtlList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
               	'inWhsGroupSeq':  function() { return inWhsGroupSeq; },
           		'preInWhsDate':  function() { return preInWhsDate_startDate; }
            },
//             success : function(res) {
//                 console.log(res);
//                 rightSide = false;
//             }
        },
        rowId: 'inWhsGroupSeq',
        columns: [
	    	{ 
	    		render: function(data, type, row, meta) {
	    			/* if( row['statusCd'] == 'P' )  { */
		    		if( row['statusCd'] == 'P' || row['approvalCd'] == '003' || row['approvalCd'] == '005' || row['approvalCd'] == '006' || row['approvalCd'] == '007' )  {
// 		    			return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width:20px; height:20px" disabled>' ;
		    			return '<span style="display: flex;justify-content: center;"> <div style="background-color: #ecebeb8c;width: 20px;height: 20px;border: 1px solid #cccccc;border-radius: 2px;" id="chk-' + meta.row + '" ></div> <span>'
			    	} else {
			    		return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width:20px; height:20px">' ;
				    }
	    			
	    		}	
			},
            { 
                data: 'inWhsDesc',
                render: function(data, type, row) {					
                	return '<input type="text" max="256" step="0.1" class="form-control" id="inWhsDesc" value="' + data + '" ">';
                }		                
            },
            { data: 'approvalNm' },
            { data: 'statusNm' },
        	{ data: 'inspectNm',
            	render: function(data, type, row) {				
                	if(data == null || data==""){
						data = '-';
                    } 
                    return data;
            		
            	}	
             },
            { data: 'lotNo' },
            //{ 
            //    data: 'preInWhsDate',
            //    render: function(data, type, row) {					
			//		if(data != "") {
			//			return moment(data).format("YYYY-MM-DD");
			//		} else {
			//			return "-";
			//		} 
            //    } 
            //},
			{ data: 'preInWhsQty',
			    render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
			    }                
			},
			{
				data: 'inspectQty',
				render: function(data, type, row) {
					if (row['statusCd'] == "S" || row['statusCd'] == "I" || row['statusCd'] == "A" ) {
						return '<input type="number" min="0" max="' + row['preInWhsQty'] + '" step="0.01" class="form-control number-float2" id="inspectQty" name="inspectQty" value="' + data + '" ">';
					} else {
						return '<input type="number" min="0" max="' + row['preInWhsQty'] + '" step="0.01" class="form-control number-float2" id="inspectQty" name="inspectQty" value="' + data + '" " disabled>';
					}
				}
			},
			{ data: 'remainQty',
				render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
				}                
			}
            /* { data: 'barcodeNo' } */
        ],
        columnDefs: [
			{ "targets": [0], "orderable" : false },
			{ "targets": [0,1,2,3,4,5], "className" : 'text-center' },
			{ "targets": [6,7,8], "className" : 'text-right' },
			{ "targets": [6,7,8], render: $.fn.dataTable.render.number( ',' )}
//            {
//                 orderable: false,
//                 className: 'select-checkbox',
//                 targets: 0
//             }		               
        ],
//         select: {
//             style:    'os',
//             selector: 'td:first-child'
//         },	            
        order: [
            [ 5, 'asc' ]
        ],
        buttons: [
	        {
	            extend: 'copy',
	            title: '수입검사 목록',
	        },
	        {
	            extend: 'excel',
	            title: '수입검사 목록',
	        },
	        {
	            extend: 'print',
	            title: '수입검사 목록',
	        },
        ],
        drawCallback : function( settings ) { //데이터 테이블 모두 호출후 실행 유사 complete       
        	//$('#systemCommonGroupCd_filter').html('<label>검색 : <input type="search" class="form-control form-control-sm" placeholder="" aria-controls="systemCommonGroupCd" style="width:120px"> </label>');	
        	 $('input[type=search]').eq(1).attr("style", "width:120px;");
        	 $('#btnDelete').css('margin-left','0px');
        	      	 
       	},
        rowCallback: function (row, data) {
            if ( data.lotNoCheck == null ) {
                $(row).addClass('skyYellow');
              
            } else  {
                $(row).removeClass('skyYellow');
            }
        },
    });

	var htmlDtl = '<button type="button" class="btn btn-danger	float-right mr-3" id="btnDelete">삭제</button>';
		
		htmlDtl += '<button type="button" class="btn float-left mr-1" style="background-color: slateblue; color: white;" id="btnFaulty">불량</button>';
		htmlDtl += '<button type="button" class="btn float-left mr-1" style="background-color: slateblue; color: white;" id="btnPass">합격</button>';
		htmlDtl += '<button type="button" class="btn float-left mr-1" style="background-color: slateblue; color: white;" id="btnNonPass">불합격</button>';
		htmlDtl += '<button type="button" class="btn float-left mr-1 d-none" style="background-color: slateblue; color: white;" id="btnReturn">반품등록</button>';
		htmlDtl += '<button type="button" class="btn float-left mr-1" style="background-color: slateblue; color: white;" id="btnHold">보류</button>';

		htmlDtl += '<button type="button" class="btn btn-primary float-left mr-1  ml-2" id="btnInspect">수입검사</button>&nbsp';
		htmlDtl += '<button type="button" class="btn btn-primary float-left mr-1" id="btnAgree">승인</button>';
		htmlDtl += '<button type="button" class="btn btn-primary float-left mr-1" id="btnCancel">승인취소</button>';

		if (factoryCode == '001' || factoryCode == '002') {
			htmlDtl += '<button type="button" class="btn btn-dark float-left mr-1  ml-2" id="btnPrint">바코드 인쇄</button>';
		} else if (factoryCode == '001' || factoryCode == '002') {
			htmlDtl += '<button type="button" class="btn btn-dark float-left mr-1  ml-2 d-none" id="btnPrint">바코드 인쇄</button>';
		}
		
	$('#btnDiv').html(htmlDtl);
	
	//틀 고정 시 thead, tbody 깨지는 현상 잡아주는 부분
  	matrlInOutWhsInspectDtlTable.on('draw.dt', function(){
  		matrlInOutWhsInspectDtlTable.columns.adjust();
	});

	$('#checkAll').on('click', function(){
		if($("#checkAll").prop("checked")) { 
			$("input[type=checkbox]").prop("checked",true); 
		} else { 
			$("input[type=checkbox]").prop("checked",false);
		}
    });

	//checkBox디테일 설정
    $(document).on('click','input[name=chk]',function(e){
    	if($('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length){
    		$("#checkAll").prop("checked", true);
        }else{
        	$("#checkAll").prop("checked", false);
		}
	});
    
    // 보기
    $('#matrlInOutWhsInspectTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#matrlInOutWhsInspectTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        $("#checkAll").prop("checked",false);
        
        if(matrlInOutWhsInspectTable.row(this).data() != null){
        	inWhsGroupSeq	= matrlInOutWhsInspectTable.row( this ).data().inWhsGroupSeq;
    	    matrlGubunCd 	= matrlInOutWhsInspectTable.row( this ).data().matrlGubunCd;
    	    matrlCd 		= matrlInOutWhsInspectTable.row( this ).data().matrlCd;
    	    
    	    preInWhsDate_startDate = matrlInOutWhsInspectTable.row( this ).data().preInWhsDate;
    	    
    		matrlInOutWhsInspectSelectId 	= $(this).attr('id');
		}
        
	    //console.log("inWhsGroupSeq = " + inWhsGroupSeq);
	    //console.log("matrlGubunCd = " + matrlGubunCd);
   		$('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {}	);
    });

    $('#matrlInOutWhsInspectDtlTable tbody').on('dblclick', 'tr', function () {
        if ( $(this).hasClass('skyYellow') ) {
        	toastr.warning("수입검사가 완료된 항목만 수정이 가능합니다.");
        	return false;
        }
        else {
        	inspectlotNo = matrlInOutWhsInspectDtlTable.row( this ).data().lotNo;
        	
  		  $.ajax({
  	          url: '<c:url value="/qm/inspectList2"/>',
  	          type: 'GET',
  	          dataType: 'json',
  	          data : {
  	        	  'inWhsGroupSeq' 	: function(){return inWhsGroupSeq;},
  	        	  'matrlGubunCd'  	: function(){return matrlGubunCd;},
  	        	  'matrlCd'		  	: function(){return matrlCd;},
  	        	  'lotNo'			: function(){return inspectlotNo;},
  	        	  'menuAuth' 		: menuAuth,
  	          },	          
  	          success: function (res) {
  	              let data = res.data;
  	              let data2 = res.data2;
  	              let data3 = res.data3;  	              
  	              let matrlData = res.matrlData;  	
  	            sideView = 'edit';			
  	              if (res.result == 'ok') {
  	            	if(matrlGubunCd=="001"){
  	  	            	if(res.from=='new'){
	  	            		matrl001_clear();  	            	     	
	  		            	matrl001_enable_list(data,data2,data3,matrlData);
	  		            	$('#realMatrlPopUpModal').modal({backdrop: 'static'});
	  		            	$('#realMatrlPopUpModal').modal('show');
  	  	            	} else {
  	  	  	            	matrl001_clear_old();
  	  	  	            	matrl001_enable_list_old(data,data2,data3,matrlData);
  	  	  	            	$('#originMatrlPopUpModal').modal({backdrop: 'static'});
	  		            	$('#originMatrlPopUpModal').modal('show');
  	  	  	            }
  	            	} else if(matrlGubunCd=="002"){
  	            		matrl002_clear();  	            		
  	            		matrl002_enable_list(data,data2,data3,matrlData);
  	            		$('#rowMatrlPopUpModal').modal({backdrop: 'static'});
  	            		$('#rowMatrlPopUpModal').modal('show');
  	            		
  	            	} else if(matrlGubunCd=="003"){
  	            		matrl003_clear();  	            		
  	            		matrl003_enable_list(data,data2,data3,matrlData);	          
  	            		$('#procMatrlPopUpModal').modal({backdrop: 'static'});  		
  	            		$('#procMatrlPopUpModal').modal('show');
  	            	} else if(matrlGubunCd=="004"){
  	  	            	if(res.from=='new'){
	  	  	            	matrl004_clear();
	  	  	            	matrl004_enable_list(data,data2,data3,matrlData);
	  	  	            	$('#filmMatrlPopUpModal').modal({backdrop:'static'});
	  	  	            	$('#filmMatrlPopUpModal').modal('show');
  	  	            	} else {
  	  	            	matrl001_clear_old();
	  	  	            	matrl001_enable_list_old(data,data2,data3,matrlData);
	  	  	            	$('#originMatrlPopUpModal').modal({backdrop: 'static'});
  		            	$('#originMatrlPopUpModal').modal('show');
  		            	}
  	  	            }
  	          	
  	              } else if(res.result == 'fail'){
  	            	  if(matrlGubunCd=="001"){
	  	            		if(res.from=='new'){
		  	            		matrl001_clear();  	            	     	
		  		            	matrl001_disable_list(data,data2,data3,matrlData);
		  		            	$('#realMatrlPopUpModal').modal({backdrop: 'static'});
		  		            	$('#realMatrlPopUpModal').modal('show');
	  	  	            	} else {
	  	  	  	            	matrl001_clear_old();
	  	  	  	            	matrl001_disable_list_old(data,data2,data3,matrlData);
	  	  	  	            	$('#originMatrlPopUpModal').modal({backdrop: 'static'});
		  		            	$('#originMatrlPopUpModal').modal('show');
	  	  	  	            } 		
  		            	} else if(matrlGubunCd=="002"){
  		            		matrl002_clear();
  		            		matrl002_disabled_list(data,matrlData);
  		            		$('#rowMatrlPopUpModal').modal({backdrop: 'static'});
  		            		$('#rowMatrlPopUpModal').modal('show');
  		            		
  		            	} else if(matrlGubunCd=="003"){
  		            		matrl003_clear();
  		            		matrl003_disabled_list(data,matrlData);
  		            		$('#procMatrlPopUpModal').modal({backdrop: 'static'});  	
  		            		$('#procMatrlPopUpModal').modal('show');
  		            	} else if(matrlGubunCd == "004"){
  	  		            	matrl004_clear();
  	  		            	matrl004_disabled_list(data,matrlData);
  	  		            	$('#filmMatrlPopUpModal').modal({backdrop:'static'});
  	  		            	$('#filmMatrlPopUpModal').modal('show');
  	  		            }
  	              }	  else if(res.result == 'empty'){
  	  	              toastr.warning('품질정보를 먼저 등록해주세요!');
  	  	          }            
  	              else {
  	            	  toastr.error(res.message, '', {timeOut: 5000});
  	              }
  	          },
  	          //complete:function(){
  	              //$('#btnAddConfirm').removeClass('d-none');
  	              //$('#btnAddConfirmLoading').addClass('d-none');
  	          //}
  	      });
        }       
    });

    //합격
    $('#btnPass').on('click', function() {
    	if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("자재를 체크해 선택해주세요!");
    		return false;
        }
    	approvalCd='';
    	updateInspectCd("001");    
    	$("#checkAll").prop("checked",false);
    });

    //불합격
    $('#btnNonPass').on('click', function() {
    	if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("자재를 체크해 선택해주세요!");
    		return false;
        }
    	approvalCd='';
    	updateInspectCd("002");  
    	$("#checkAll").prop("checked",false);  
    });

    //승인
    $('#btnAgree').on('click', function() {
        isFailed = false;
    	if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("승인할 자재를 선택해주세요!");
    		return false;
        }
        $.each($('input[name=chk]:checked'), function(index, item){
            if(matrlInOutWhsInspectDtlTable.row(this.closest('tr')).data().lotNoCheck == null){
               
                isFailed = true;
                return false;
            }
        });
        if(isFailed){
        	 toastr.warning('수입검사가 완료된 항목만 승인할 수 있습니다.');
            return false;
        }
    	$('#agreeModalDate').val("${serverDate}");
    	$('#agreeModal').modal({backdrop: 'static'});
    	$('#agreeModal').modal('show');
    });

    //승인 모달 승인 버튼 클릭시
    $('#btnModalAgree').on('click', function(){
    	approvalCd='';
    	approvalCd = '001';
    	
    	if( $('#matrlInOutWhsInspectTable tbody').find('.selected').find('td').eq(8).text() == "" ) {
    		toastr.warning("다시 선택해주세요.");
    		return false;
    	}
    	
        updateMtrlInOutWhsInspectQty("001");
        $('#agreeModal').modal('hide');
	});

    //승인취소
    $('#btnCancel').on('click', function() {
    	if ($('input[name=chk]:checked').length == 0) {
    		toastr.warning("승인취소할 자재를 선택해주세요!");
    		return false;
        }
    	approvalCd='';
    	approvalCd = '002';
    	updateMtrlInOutWhsInspectQty("002");
    });

    //불량
    $('#btnFaulty').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("불량 처리할 자재를 선택해주세요!");
			return false;
		}
		approvalCd='';
		approvalCd = '003';
		//선택해제
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		$('#frrrdDate').val(serverDate);
		$('#frrrdDesc').val('');
		$('#frrrdPopUpLabel').text('불량 처리');
		$('#frrrdDateLabel').text('불량일');
		$('#frrrdDescLabel').text('비고');
		$('#frrrdTypeLabel').text('불량유형');
		$('#frrrdPopUpModal').modal('show');
    });

    //보류
    $('#btnHold').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("보류 처리할 자재를 선택해주세요!");
			return false;
		}
		approvalCd='';
		approvalCd = '004';
		//선택해제
    	for (let i=0; i<matrlFaultyType.length; i++) {
    		$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
        }
    	$('#frrrdDate').val(serverDate);
    	$('#frrrdDesc').val('');
        $('#frrrdPopUpLabel').text('보류 처리');
        $('#frrrdDateLabel').text('보류일');
        $('#frrrdDescLabel').text('비고');
        $('#frrrdTypeLabel').text('보류유형');
        $('#frrrdPopUpModal').modal('show');
    });

	//반품등록
	$('#btnReturn').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("반품 처리할 자재를 선택해주세요!");
			return false;
		}
		approvalCd='';
		approvalCd = '005';
		//선택해제
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		$('#frrrdDate').val(serverDate);
		$('#frrrdDesc').val('');
		$('#frrrdPopUpLabel').text('반품 처리');
		$('#frrrdDateLabel').text('반품일');
		$('#frrrdDescLabel').text('비고');
		$('#frrrdTypeLabel').text('반품유형');
		$('#frrrdDesc').val("");
		$('#frrrdPopUpModal').modal('show');
	});

	//불량&보류&반품등록 저장 클릭 시
	//불량유형 선택항목 1 미선택 0
	$('#btnFaultySave').on('click', function() {
		frrrdDate = '';
		frrrdType = '';
		frrrdDesc = '';
		if (approvalCd == '001') {
			toastr.warning("일시적인 오류가 발생했습니다.<br>취소 후 다시 시도해 주세요!")
			return false;
		} else if (approvalCd == '002') {
			toastr.warning("일시적인 오류가 발생했습니다.<br>취소 후 다시 시도해 주세요!")
			return false;

		//불량
		} else if (approvalCd == '003') {
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			for (let i=0; i<matrlFaultyType.length; i++) {
				if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
					frrrdType += '1';
				} else {
					frrrdType += '0';
				}
			}
			updateMtrlInOutWhsInspectQty("003");
			updateInspectCd("002");

		//보류
		} else if (approvalCd == '004') {
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			for (let i=0; i<matrlFaultyType.length; i++) {
				if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
					frrrdType += '1';
				} else {
					frrrdType += '0';
				}
			}
			updateMtrlInOutWhsInspectQty("004");

		//반품
		} else if (approvalCd == '005') {
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			for (let i=0; i<matrlFaultyType.length; i++) {
				if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
					frrrdType += '1';
				} else {
					frrrdType += '0';
				}
			}
			updateMtrlInOutWhsInspectQty("005");
			updateInspectCd("002");
		}
	});
	
	var deleteLotNo = null;
    //삭제
    $('#btnDelete').on('click', function() {
        var count = 0;
    	var checkbox = $("input[name=chk]:checked");    	
    	
    	if (checkbox.length==0){
    		toastr.warning("삭제할 자재를 선택해주세요.");
    		return false;
        } 

         else {
        	 $('#deleteLotNo').text("해당 LOT들을 삭제하시겠습니까?");
     		$('#deleteCheckPopupModal').modal('show');
        } 
	});

	//삭제 취소
    $('#btnDeleteCancel').on('click', function() {
		$('#deleteCheckPopupModal').modal('hide');
	});

	//삭제 실행
    $('#btnDeleteCheck').on('click', function() {
        var count = 0;
    	var checkbox = $("input[name=chk]:checked");
    	var dataArray = new Array();

    	if (checkbox.length==0){
    		toastr.warning("삭제할 자재를 선택해주세요.");
    		return false;
        } else{
        	checkbox.each(function(i) {
        		var rowData = new Object();
        		var tr = checkbox.parent().parent().eq(i);
        		var td = tr.children();
        		rowData.lotNo = td.eq(5).text();
            	dataArray.push(rowData);
        	});
        }
		
    	$('#my-spinner').show();
    	
    	$.ajax({
			url: '<c:url value="io/deleteMatrlInOut"/>',
			type: 'POST',
			data: JSON.stringify(dataArray),
			dataType:"json",
			contentType : "application/json; charset=UTF-8",
			success: function (res) {
				let data = res.data;
				if( res.result == 'ok' ){
					matrlCd = null;
				   	$('#matrlInOutWhsInspectTable').DataTable().ajax.reload( function () {});
				   	$('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {});
				   	$("#checkAll").prop("checked",false);
				   	toastr.success("삭제되었습니다.");
				} else if(res.result =='statError') {
					toastr.warning(res.message, '', {timeOut: 5000});
				}
				else if(res.result =='error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function() {
				$('#my-spinner').hide();
			}
		});
	});
    
	//품질관리 수입검사관리 인쇄
	$('#btnPrint').on('click', function() {		
    	$('#printCheckPopupModal').modal('show');
	});

	
    function updateMtrlInOutWhsInspectQty(approvalCdTemp) {
		var dataArray 	= new Array();
		var checkbox 	= $("input[name=chk]:checked");
		var checkboxCnt = 0;
		var errorFlag 	= false;
		//체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
			var rowData = new Object();
			var inWhsDesc	= td.eq(1).find('#inWhsDesc').val();
			var lotNo 		= td.eq(5).text();
			var preInWhsQty	= td.eq(6).text();
			var remainQty	= td.eq(8).text();
			var inspectQty 	= td.eq(7).find('input[type="number"]').val();
			var barcode 	= td.eq(9).text();
			var filmCode 	= $('#matrlInOutWhsInspectTable tbody').find('.selected').find('td').eq(2).text();
			var rowCount 	= $(this).attr('id').split('-');
			var etc1 		= matrlInOutWhsInspectDtlTable.row(rowCount[1]).data().etc1;
			var countPrint	= $('#printCountCheck option:selected').text();

			var inWhsDate='';	//입고일

			// 입고일 값 설정
			if(factoryCode == "001" || factoryCode == "002"){
				inWhsDate = $('#agreeModalDate').val();
			} else if(factoryCode == "003"){
				//inWhsDate = $('#matrlInOutWhsInspectTable tbody').find('.selected').find('td').eq(8).text();
				inWhsDate = matrlInOutWhsInspectTable.rows('.selected').data()[0].preInWhsDate
				
				//날짜 값이 안들어 올때 승인 날짜로 넣어줌
				if( inWhsDate == null || inWhsDate == "" ) {
					inWhsDate = matrlInOutWhsInspectTable.rows('.selected').data()[0].inWhsDate
				}
				
				//날짜 값이 안들어 올때 승인 날짜로 넣어줌
				/* if( inWhsDate == null || inWhsDate == "" ) {
					inWhsDate = $('#agreeModalDate').val();
				} */
			}else{
				toastr.warning('잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!')
				return false;
			}
			
			// 가져온 값을 배열에 담는다.
			rowData.menuAuth	= menuAuth;
			rowData.inWhsDesc	= inWhsDesc;
			rowData.lotNo		= lotNo;
			rowData.preInWhsQty	= preInWhsQty;
			rowData.inspectQty	= inspectQty;
			rowData.remainQty	= remainQty;
			rowData.approvalCd	= approvalCdTemp;
			rowData.barcode 	= barcode;
			rowData.matrlCd 	= filmCode;
			rowData.etc1 		= etc1;
			rowData.countPrint	= countPrint;
			rowData.frrrdDate	= frrrdDate;	//불량&보류&반품 처리일
			rowData.frrrdType	= frrrdType;	//불량&보류&반품 유형
			rowData.frrrdDesc	= frrrdDesc;	//불량&보류&반품 비고
			rowData.inspctDate	= $('#agreeModalDate').val().replace(/-/g, '');	//수입검사일
			rowData.inWhsDate	= inWhsDate.replace(/-/g, '');	//입고일
			
			//if(approvalCdTemp=="005"){
			//	rowData.inWhsDesc = $('#faultyDesc').val();
			//} else{
			//	rowData.inWhsDesc = '';
			//}
			dataArray.push(rowData);
			checkboxCnt += 1;
			//console.log(dataArray);
			if(inspectQty == null || inspectQty == '') {
				toastr.warning("LOT번호 " + lotNo + " 입고량을 입력해 주세요");
				errorFlag = true;
				return false;
			}
								
			if(parseFloat(inspectQty) > parseFloat(preInWhsQty)) {
				toastr.warning("LOT번호 " + lotNo + " 입고량은 가입고량을 초과할 수 없습니다.<br/> 다시 입력해 주세요");
				errorFlag = true;
				return false;
			}
		});

		//인쇄 명령인지 판단
		var url = null;
		var temp = null;
		if(approvalCdTemp != "010"){
			url = '<c:url value="/qm/matrlInOutWhsInspectUpdateDtl"/>';
		} else{ //단순 인쇄시 010
			if (factoryCode == "001") {
				url = '<c:url value="/qm/matrlPrint"/>';
			} else if (factoryCode == "002" || factoryCode == "003") {
				url = '<c:url value="/qm/matrlPrint_F3"/>';
			} else {
				toastr.warning('잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!')
				return false;
			}
			temp = approvalCdTemp;
		}
		if(!errorFlag && checkboxCnt > 0) {
			$('#my-spinner').show();
	        $.ajax({
	            url: url,
	            type: 'POST',
	            dataType: 'json',
	            data : JSON.stringify(dataArray),
	            contentType : "application/json; charset=UTF-8",
	            beforeSend: function() {
	              //  $('#btnAddConfirm').addClass('d-none');
	            },
	            success: function (res) {
		            
	                let data = res.data;
	                if (res.result == 'ok') {
	                	if (factoryCode == "002" && approvalCdTemp == "010") {
	                		labelPrint(res.printList);
	                	} else if (factoryCode == "003" && approvalCdTemp == "010") {
	                		labelPrint(res.printList);
		                }else{
	                    	// 보기
		                	toastr.success("처리 되었습니다.");
		                	preInWhsDateCal =  $('#preInWhsDate').val();
	            			approvalCd =  $('#approvalCd option:selected').val();
		            		$("#checkAll").prop("checked", false);
		            		//바코드 인쇄시 리로드할 필요 없음, temp 변수는 위에서 approvalCd를 사용하기때문에 임시변수 만들어 둔것
		            		if(temp != "010") {
		            			if($('#matrlCd option:selected').val() == ''){
		            				matrlCd=''
		                		}
		            			inWhsGroupSeq='1';
		            			
		            			let mainScrollCatch = $($('.dataTables_scrollBody')[0]).scrollTop();
		            			let serveScrollCatch = $($('.dataTables_scrollBody')[1]).scrollTop();
		            			
			            		$('#matrlInOutWhsInspectTable').DataTable().ajax.reload( function () {
			            			$('#'+matrlInOutWhsInspectSelectId).click();
			            			$('#'+matrlInOutWhsInspectSelectId).addClass('selected');
			            			$($('.dataTables_scrollBody')[0]).scrollTop(mainScrollCatch);
			            			setTimeout(function(){
			            				$($('.dataTables_scrollBody')[1]).scrollTop(serveScrollCatch);
			            			},300);
				            	});
			            		
			            		//$('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {});
		            		}
	                	}
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function() {
	            	$('#my-spinner').hide();
	            }
	        });
	        
		} else if (approvalCdTemp == "010"){
			toastr.warning("인쇄할 바코드를 선택해주세요!");
		} else {
			toastr.warning("수정할 목록을 선택해 주세요!");
		}
    }
    
  $('#btnInspect').on('click',function(){
	  $('#my-spinner').modal('show');
 	 var checkInspect = true;
	 if(inWhsGroupSeq == '1'){
		toastr.warning("수입검사할 목록을 선택해주세요");
   		$('#my-spinner').modal('hide');
	 	return false;
	 }
	 if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("수입검사할 LOT를 선택해주세요!");
	    	 $('#my-spinner').modal('hide');
 			return false;
     }     
     $.each($('input[name=chk]:checked'),function(index, item){         
    	if(matrlInOutWhsInspectDtlTable.row(this.closest('tr')).data().lotNoCheck != null){
    		checkInspect = false;
       	}       	
      });

     if(!checkInspect){
    	 toastr.warning("수입검사가 완료된 항목을 제외하여 주세요.");
    	 $('#my-spinner').modal('hide');
			return false;
     }
     
		  $.ajax({
	          url: '<c:url value="/qm/inspectList2"/>',
	          type: 'GET',
	          dataType: 'json',
	          data : {
	        	  'inWhsGroupSeq' 	: function(){return inWhsGroupSeq;},
	        	  'matrlGubunCd'  	: function(){return matrlGubunCd;},
	        	  'matrlCd'		  	: function(){return matrlCd;},
	        	  'menuAuth' 		: menuAuth,
	          },	          
	          success: function (res) {
	              let data = res.data;
	              let data2 = res.data2;
	              let data3 = res.data3;	           
	              let matrlData = res.matrlData;
	              sideView = 'add';
// 					console.log(matrlGubunCd);
					console.log(matrlGubunCd);
	              if (res.result == 'ok') {	            	 
	            	if(matrlGubunCd=="001"){
	            		if(res.from=='new'){
	  	            		matrl001_clear();  	            	     	
	  		            	matrl001_disabled_list(data,data2,data3,matrlData);
	  		            	$('#realMatrlPopUpModal').modal({backdrop: 'static'});
	  		            	$('#realMatrlPopUpModal').modal('show');
  	  	            	} else {
  	  	  	            	matrl001_clear_old();
  	  	  	            	matrl001_disabled_list_old(data,data2,data3,matrlData);
  	  	  	            	$('#originMatrlPopUpModal').modal({backdrop: 'static'});
	  		            	$('#originMatrlPopUpModal').modal('show');
  	  	  	            }
	            	} else if(matrlGubunCd=="002"){
	            		matrl002_clear();
	            		matrl002_disabled_list(data,matrlData);
	            		//matrl002_enable_list(data2,data3,matrlData);
	            		$('#rowMatrlPopUpModal').modal({backdrop: 'static'});
	            		$('#rowMatrlPopUpModal').modal('show');
	            		
	            	} else if(matrlGubunCd=="003"){
	            		matrl003_clear();
	            		matrl003_disabled_list(data,matrlData);
	            		//matrl003_enable_list(data2,matrlData);	          
	            		$('#procMatrlPopUpModal').modal({backdrop: 'static'});  		
	            		$('#procMatrlPopUpModal').modal('show');
	            	} else if(matrlGubunCd=="004"){
		            	matrl004_clear();
		            	matrl004_disabled_list(data,matrlData);
		            	$('#filmMatrlPopUpModal').modal({backdrop: 'static'});
		            	$('#filmMatrlPopUpModal').modal('show');
		            }

	          		//$('#matrlInOutWhsInspectTable').DataTable().ajax.reload( function () {});
	          		$("#checkAll").prop("checked",false);
	          		//$('#matrlInOutWhsInspectDtlTable').DataTable().clear().draw();

					//
	              } else if(res.result == 'fail'){
	            	  if(matrlGubunCd=="001"){
	            		  if(res.from=='new'){
		  	            		matrl001_clear();  	            	     	
		  		            	matrl001_disabled_list(data,data2,data3,matrlData);
		  		            	$('#realMatrlPopUpModal').modal({backdrop: 'static'});
		  		            	$('#realMatrlPopUpModal').modal('show');
	  	  	            	} else {
	  	  	  	            	matrl001_clear_old();
	  	  	  	            	matrl001_disabled_list_old(data,data2,data3,matrlData);
	  	  	  	            	$('#originMatrlPopUpModal').modal({backdrop: 'static'});
		  		            	$('#originMatrlPopUpModal').modal('show');
	  	  	  	            }
		            		
		            	} else if(matrlGubunCd=="002"){
		            		matrl002_clear();
		            		matrl002_disabled_list(data,matrlData);
		            		$('#rowMatrlPopUpModal').modal({backdrop: 'static'});
		            		$('#rowMatrlPopUpModal').modal('show');
		            		
		            	} else if(matrlGubunCd=="003"){
		            		matrl003_clear();
		            		matrl003_disabled_list(data,matrlData);
		            		$('#procMatrlPopUpModal').modal({backdrop: 'static'});  	
		            		$('#procMatrlPopUpModal').modal('show');
		            	}else if(matrlGubunCd=="004"){
			            	matrl004_clear();
			            	matrl004_disabled_list(data,matrlData);
			            	$('#filmMatrlPopUpModal').modal({backdrop: 'static'});
			            	$('#filmMatrlPopUpModal').modal('show');
			            }
	            	  
	              }	 else if(res.result == 'empty'){
  	  	              toastr.warning('품질정보를 먼저 등록해주세요!');
  	  	          }    
	              else {
	            	  toastr.error(res.message, '', {timeOut: 5000});
	              }
	          },
	          complete:function(){
	              $('#my-spinner').modal('hide');
	          }
	      });
  });
  
	//입력값에 '/'확인하여 %2f로 변환
	function replaceSlash(data) {
		var temp = data.replace("/", "%2f");
	    return temp;
	}

	//메탈 수입검사 저장
  $('#realMatrlPopUpSave').on('click',function(){
	  $('#my-spinner').modal('show');
	  var InspectArray = new Array();
	  var InspectArrayPopup = new Array();
	  var check = true;

	  $.each($('#sizeMatrlPopUpTable .mustInput'), function(index, item){
		  if($(this).val()=='0'||$(this).val()==''){
			  check = false;
			  toastr.warning('필수값이 입력되지 않았습니다.');
			  $(this).focus();
			  return false;
		}
	});
	  
	  
	  if(sideView == 'add'&&check){
		  $.each($('input[name=chk]:checked'),function(index, item){ 		  
			var rowData = new Object();
			var thisLotNo = "";
			rowData.inWhsGroupSeq = inWhsGroupSeq;
			rowData.matrlGubunCd = matrlGubunCd;		 
			rowData.lotNo = $(this).closest('tr').find('td').eq(5).text();
			thisLotNo  = $(this).closest('tr').find('td').eq(5).text();
			rowData.matrlCd = matrlCd;
			rowData.inspectDate  = $('#realMatrlDate').val();
			rowData.inspectItem1 = replaceSlash($('#matrl001_inspectItem1_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem1_2').val()) + "/" + $('#matrl001_inspectItem1_3 option:selected').val() + "/" + $('#matrl001_inspectItem1_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem1_4').val());
			rowData.inspectItem2 = replaceSlash($('#matrl001_inspectItem2_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem2_2').val()) + "/" + $('#matrl001_inspectItem2_3 option:selected').val() + "/" + $('#matrl001_inspectItem2_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem2_4').val());
			rowData.inspectItem3 = replaceSlash($('#matrl001_inspectItem3_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem3_2').val()) + "/" + $('#matrl001_inspectItem3_3 option:selected').val() + "/" + $('#matrl001_inspectItem3_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem3_4').val());
			rowData.inspectItem4 = replaceSlash($('#matrl001_inspectItem4_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem4_2').val()) + "/" + $('#matrl001_inspectItem4_3 option:selected').val() + "/" + $('#matrl001_inspectItem4_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem4_4').val());
			rowData.inspectItem5 = replaceSlash($('#matrl001_inspectItem5_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem5_2').val()) + "/" + $('#matrl001_inspectItem5_3 option:selected').val() + "/" + $('#matrl001_inspectItem5_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem5_4').val());
			rowData.inspectItem6 = replaceSlash($('#matrl001_inspectItem6_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem6_2').val()) + "/" + $('#matrl001_inspectItem6_3 option:selected').val() + "/" + $('#matrl001_inspectItem6_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem6_4').val());
// 			rowData.inspectItem7 = replaceSlash($('#matrl001_inspectItem7_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem7_2').val()) + "/" + $('#matrl001_inspectItem7_3 option:selected').val() + "/" + $('#matrl001_inspectItem7_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem7_4').val());
// 			rowData.inspectItem8 = replaceSlash($('#matrl001_inspectItem8_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem8_2').val()) + "/" + $('#matrl001_inspectItem8_3 option:selected').val() + "/" + $('#matrl001_inspectItem8_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem8_4').val());
			//rowData.inspectItem9 = replaceSlash($('#matrl001_inspectItem9_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem9_2').val()) + "/" + $('#matrl001_inspectItem9_3 option:selected').val() + "/" + $('#matrl001_inspectItem9_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem9_4').val());
			//추후 자재수입검사 추가할때 html이랑 밑에주석만 지워주면 됨!
			//inspectItem10 = replaceSlash($('#matrl001_inspectItem10_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem10_2').val()) + "/" + $('#matrl001_inspectItem10_3 option:selected').val() + "/" + $('#matrl001_inspectItem10_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem10_4').val());
			//inspectItem11 = replaceSlash($('#matrl001_inspectItem11_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_2').val()) + "/" + $('#matrl001_inspectItem11_3 option:selected').val() + "/" + $('#matrl001_inspectItem11_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem11_4').val());
			//inspectItem12 = replaceSlash($('#matrl001_inspectItem12_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_2').val()) + "/" + $('#matrl001_inspectItem12_3 option:selected').val() + "/" + $('#matrl001_inspectItem12_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem12_4').val());
		     
	        rowData.inspectItem13 = replaceSlash($('#matrl001_input1_1').val()) + "/" + replaceSlash($('#matrl001_input1_2').val()) + "/" + replaceSlash($('#matrl001_input1_3').val()) + "/" + parseFloat(replaceSlash($('#matrl001_input1_4').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input1_5').val())) + "/";
	        rowData.inspectItem13 += parseFloat(replaceSlash($('#matrl001_input1_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input1_7').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input1_8').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input1_9').val())) + "/" + replaceSlash($('#matrl001_input1_10').val());
	        rowData.inspectItem14 = replaceSlash($('#matrl001_input2_1').val()) + "/" + replaceSlash($('#matrl001_input2_2').val()) + "/" + parseFloat(replaceSlash($('#matrl001_input2_3').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input2_4').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input2_5').val())) + "/";
		    rowData.inspectItem14 += parseFloat(replaceSlash($('#matrl001_input2_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input2_7').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input2_8').val())) + "/" + replaceSlash($('#matrl001_input2_9').val());
		    rowData.inspectItem15 = replaceSlash($('#matrl001_input3_1').val()) + "/" + replaceSlash($('#matrl001_input3_2').val()) + "/" + parseFloat(replaceSlash($('#matrl001_input3_3').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input3_4').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input3_5').val())) + "/";
		    rowData.inspectItem15 += parseFloat(replaceSlash($('#matrl001_input3_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input3_7').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input3_8').val())) + "/" + replaceSlash($('#matrl001_input3_9').val());
		    rowData.inspectItem16 = replaceSlash($('#matrl001_input4_1').val()) + "/" + replaceSlash($('#matrl001_input4_2').val()) + "/" + replaceSlash($('#matrl001_input4_3').val()) + "/" + replaceSlash($('#matrl001_input4_4').val()) + "/" + replaceSlash($('#matrl001_input4_5').val()) + "/";
		    rowData.inspectItem16 += replaceSlash($('#matrl001_input4_6').val()) + "/" + replaceSlash($('#matrl001_input4_7').val()) + "/" + replaceSlash($('#matrl001_input4_8').val()) + "/" + replaceSlash($('#matrl001_input4_9').val()) + "/";
		    rowData.inspectItem17 = replaceSlash($('#matrl001_input5_1').val()) + "/" + replaceSlash($('#matrl001_input5_2').val()) + "/" + replaceSlash($('#matrl001_input5_3').val()) + "/" + replaceSlash($('#matrl001_input5_4').val()) + "/" + parseFloat(replaceSlash($('#matrl001_input5_5').val())) + "/";
		    rowData.inspectItem17 += parseFloat(replaceSlash($('#matrl001_input5_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input5_7').val())) + "/" + replaceSlash($('#matrl001_input5_8').val());
		    rowData.inspectItem18 = replaceSlash($('#matrl001_input6_1').val()) + "/" + replaceSlash($('#matrl001_input6_2').val()) + "/" + replaceSlash($('#matrl001_input6_3').val()) + "/" + replaceSlash($('#matrl001_input6_4').val()) + "/" + replaceSlash($('#matrl001_input6_5').val());
		    rowData.inspectItem18 += replaceSlash($('#matrl001_input6_6').val()) + "/" + replaceSlash($('#matrl001_input6_7').val()) + "//" + replaceSlash($('#matrl001_input6_9').val()) + "/" + replaceSlash($('#matrl001_input6_10').val());
		    rowData.inspectItem18 += replaceSlash($('#matrl001_input6_11').val()) + "/" + replaceSlash($('#matrl001_input6_12').val()) + "/" + replaceSlash($('#matrl001_input6_13').val()) + "/" + replaceSlash($('#matrl001_input6_14').val()) + "/" + replaceSlash($('#matrl001_input6_15').val());
		    rowData.inspectItem19 = replaceSlash($('#matrl001_input7_1').val()) + "/" + replaceSlash($('#matrl001_input7_2').val()) + "/" + replaceSlash($('#matrl001_input7_3').val()) + "/" + replaceSlash($('#matrl001_input7_4').val()) + "/" + replaceSlash($('#matrl001_input7_5').val());		    
		    rowData.inspectItem20 = replaceSlash($('#matrl001_input8_1').val()) + "/" + replaceSlash($('#matrl001_input8_2').val()) + "/" + replaceSlash($('#matrl001_input8_3').val()) + "/" + replaceSlash($('#matrl001_input8_4').val()) + "/" + replaceSlash($('#matrl001_input8_5').val()) + "/";      
		    rowData.inspectItem20 += replaceSlash($('#matrl001_input8_6').val()) + "/" + replaceSlash($('#matrl001_input8_7').val()) + "/" + replaceSlash($('#matrl001_input8_8').val()) + "/" + replaceSlash($('#matrl001_input8_9').val()) + "/" + replaceSlash($('#matrl001_input8_10').val()) + "/";    
		    rowData.inspectItem20 += replaceSlash($('#matrl001_input8_11').val()) + "/" + replaceSlash($('#matrl001_input8_12').val()) + "/" + replaceSlash($('#matrl001_input8_13').val()) + "/" + replaceSlash($('#matrl001_input8_14').val()) + "/" + replaceSlash($('#matrl001_input8_15').val()) + "/";
		    rowData.inspectItem20 += replaceSlash($('#matrl001_input8_16').val()) + "/" + replaceSlash($('#matrl001_input8_17').val()) + "/";	      	                                                                                                       
		    rowData.inspectItem21 = replaceSlash($('#matrl001_input9_1').val()) + "/" + replaceSlash($('#matrl001_input9_2').val()) + "/" + replaceSlash($('#matrl001_input9_3').val()) + "/" + replaceSlash($('#matrl001_input9_4').val()) + "/" + replaceSlash($('#matrl001_input9_5').val()) + "/";      
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl001_input9_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_7').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_8').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_9').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_10').val())) + "/";    
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl001_input9_11').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_12').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_13').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_14').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_15').val())) + "/";
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl001_input9_16').val())) + "/" + replaceSlash($('#matrl001_input9_17').val());
		    InspectArray.push(rowData);
		    $.each($('#exteriorMatrlPopUpTable tbody tr'),function(idx, itm){ 	
		    	var rowData2 = new Object();
		    	rowData2.matrlCd		= matrlCd;
		    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
				rowData2.matrlGubunCd 	= matrlGubunCd;		 
				rowData2.lotNo 			= thisLotNo;
				rowData2.managementCd 	= $(this).find('td').eq(0).find('input[type=hidden]').val();
				rowData2.resultCd 		= $(this).find('td').eq(2).find('select').val();
				rowData2.inspectEtc 	=  $(this).find('td').eq(3).find('input[type=text]').val();
				rowData2.inspectDate 	= $('#realMatrlDate').val();
				InspectArrayPopup.push(rowData2);
				
		    });
		  });
	  } else{
		  var rowData = new Object();
			var thisLotNo = "";
			rowData.inWhsGroupSeq = inWhsGroupSeq;
			rowData.matrlGubunCd = matrlGubunCd;		 
			rowData.lotNo =inspectlotNo;
			rowData.matrlCd = matrlCd;
			rowData.inspectDate  = $('#realMatrlDate').val();
			rowData.inspectItem1 = replaceSlash($('#matrl001_inspectItem1_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem1_2').val()) + "/" + $('#matrl001_inspectItem1_3 option:selected').val() + "/" + $('#matrl001_inspectItem1_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem1_4').val());
			rowData.inspectItem2 = replaceSlash($('#matrl001_inspectItem2_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem2_2').val()) + "/" + $('#matrl001_inspectItem2_3 option:selected').val() + "/" + $('#matrl001_inspectItem2_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem2_4').val());
			rowData.inspectItem3 = replaceSlash($('#matrl001_inspectItem3_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem3_2').val()) + "/" + $('#matrl001_inspectItem3_3 option:selected').val() + "/" + $('#matrl001_inspectItem3_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem3_4').val());
			rowData.inspectItem4 = replaceSlash($('#matrl001_inspectItem4_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem4_2').val()) + "/" + $('#matrl001_inspectItem4_3 option:selected').val() + "/" + $('#matrl001_inspectItem4_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem4_4').val());
			rowData.inspectItem5 = replaceSlash($('#matrl001_inspectItem5_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem5_2').val()) + "/" + $('#matrl001_inspectItem5_3 option:selected').val() + "/" + $('#matrl001_inspectItem5_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem5_4').val());
			rowData.inspectItem6 = replaceSlash($('#matrl001_inspectItem6_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem6_2').val()) + "/" + $('#matrl001_inspectItem6_3 option:selected').val() + "/" + $('#matrl001_inspectItem6_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem6_4').val());
// 			rowData.inspectItem7 = replaceSlash($('#matrl001_inspectItem7_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem7_2').val()) + "/" + $('#matrl001_inspectItem7_3 option:selected').val() + "/" + $('#matrl001_inspectItem7_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem7_4').val());
// 			rowData.inspectItem8 = replaceSlash($('#matrl001_inspectItem8_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem8_2').val()) + "/" + $('#matrl001_inspectItem8_3 option:selected').val() + "/" + $('#matrl001_inspectItem8_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem8_4').val());
			//rowData.inspectItem9 = replaceSlash($('#matrl001_inspectItem9_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem9_2').val()) + "/" + $('#matrl001_inspectItem9_3 option:selected').val() + "/" + $('#matrl001_inspectItem9_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem9_4').val());
			//추후 자재수입검사 추가할때 html이랑 밑에주석만 지워주면 됨!
			//inspectItem10 = replaceSlash($('#matrl001_inspectItem10_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem10_2').val()) + "/" + $('#matrl001_inspectItem10_3 option:selected').val() + "/" + $('#matrl001_inspectItem10_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem10_4').val());
			//inspectItem11 = replaceSlash($('#matrl001_inspectItem11_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem11_2').val()) + "/" + $('#matrl001_inspectItem11_3 option:selected').val() + "/" + $('#matrl001_inspectItem11_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem11_4').val());
			//inspectItem12 = replaceSlash($('#matrl001_inspectItem12_1').val()) + "/" + replaceSlash($('#matrl001_inspectItem12_2').val()) + "/" + $('#matrl001_inspectItem12_3 option:selected').val() + "/" + $('#matrl001_inspectItem12_3 option:selected').text() + "/" + replaceSlash($('#matrl001_inspectItem12_4').val());
		     
	        rowData.inspectItem13 = replaceSlash($('#matrl001_input1_1').val()) + "/" + replaceSlash($('#matrl001_input1_2').val()) + "/" + replaceSlash($('#matrl001_input1_3').val()) + "/" + parseFloat(replaceSlash($('#matrl001_input1_4').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input1_5').val())) + "/";
	        rowData.inspectItem13 += parseFloat(replaceSlash($('#matrl001_input1_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input1_7').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input1_8').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input1_9').val())) + "/" + replaceSlash($('#matrl001_input1_10').val());
	        rowData.inspectItem14 = replaceSlash($('#matrl001_input2_1').val()) + "/" + replaceSlash($('#matrl001_input2_2').val()) + "/" + parseFloat(replaceSlash($('#matrl001_input2_3').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input2_4').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input2_5').val())) + "/";
		    rowData.inspectItem14 += parseFloat(replaceSlash($('#matrl001_input2_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input2_7').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input2_8').val())) + "/" + replaceSlash($('#matrl001_input2_9').val());
		    rowData.inspectItem15 = replaceSlash($('#matrl001_input3_1').val()) + "/" + replaceSlash($('#matrl001_input3_2').val()) + "/" + parseFloat(replaceSlash($('#matrl001_input3_3').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input3_4').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input3_5').val())) + "/";
		    rowData.inspectItem15 += parseFloat(replaceSlash($('#matrl001_input3_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input3_7').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input3_8').val())) + "/" + replaceSlash($('#matrl001_input3_9').val());
		    rowData.inspectItem16 = replaceSlash($('#matrl001_input4_1').val()) + "/" + replaceSlash($('#matrl001_input4_2').val()) + "/" + replaceSlash($('#matrl001_input4_3').val()) + "/" + replaceSlash($('#matrl001_input4_4').val()) + "/" + replaceSlash($('#matrl001_input4_5').val()) + "/";
		    rowData.inspectItem16 += replaceSlash($('#matrl001_input4_6').val()) + "/" + replaceSlash($('#matrl001_input4_7').val()) + "/" + replaceSlash($('#matrl001_input4_8').val()) + "/" + replaceSlash($('#matrl001_input4_9').val()) + "/";
		    rowData.inspectItem17 = replaceSlash($('#matrl001_input5_1').val()) + "/" + replaceSlash($('#matrl001_input5_2').val()) + "/" + replaceSlash($('#matrl001_input5_3').val()) + "/" + replaceSlash($('#matrl001_input5_4').val()) + "/" + parseFloat(replaceSlash($('#matrl001_input5_5').val())) + "/";
		    rowData.inspectItem17 += parseFloat(replaceSlash($('#matrl001_input5_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input5_7').val())) + "/" + replaceSlash($('#matrl001_input5_8').val());
		    rowData.inspectItem18 = replaceSlash($('#matrl001_input6_1').val()) + "/" + replaceSlash($('#matrl001_input6_2').val()) + "/" + replaceSlash($('#matrl001_input6_3').val()) + "/" + replaceSlash($('#matrl001_input6_4').val()) + "/" + replaceSlash($('#matrl001_input6_5').val());
		    rowData.inspectItem18 += replaceSlash($('#matrl001_input6_6').val()) + "/" + replaceSlash($('#matrl001_input6_7').val()) + "//" + replaceSlash($('#matrl001_input6_9').val()) + "/" + replaceSlash($('#matrl001_input6_10').val());
		    rowData.inspectItem18 += replaceSlash($('#matrl001_input6_11').val()) + "/" + replaceSlash($('#matrl001_input6_12').val()) + "/" + replaceSlash($('#matrl001_input6_13').val()) + "/" + replaceSlash($('#matrl001_input6_14').val()) + "/" + replaceSlash($('#matrl001_input6_15').val());		    
		    rowData.inspectItem19 = replaceSlash($('#matrl001_input7_1').val()) + "/" + replaceSlash($('#matrl001_input7_2').val()) + "/" + replaceSlash($('#matrl001_input7_3').val()) + "/" + replaceSlash($('#matrl001_input7_4').val()) + "/" + replaceSlash($('#matrl001_input7_5').val());  
		    rowData.inspectItem20 = replaceSlash($('#matrl001_input8_1').val()) + "/" + replaceSlash($('#matrl001_input8_2').val()) + "/" + replaceSlash($('#matrl001_input8_3').val()) + "/" + replaceSlash($('#matrl001_input8_4').val()) + "/" + replaceSlash($('#matrl001_input8_5').val()) + "/";      
		    rowData.inspectItem20 += replaceSlash($('#matrl001_input8_6').val()) + "/" + replaceSlash($('#matrl001_input8_7').val()) + "/" + replaceSlash($('#matrl001_input8_8').val()) + "/" + replaceSlash($('#matrl001_input8_9').val()) + "/" + replaceSlash($('#matrl001_input8_10').val()) + "/";    
		    rowData.inspectItem20 += replaceSlash($('#matrl001_input8_11').val()) + "/" + replaceSlash($('#matrl001_input8_12').val()) + "/" + replaceSlash($('#matrl001_input8_13').val()) + "/" + replaceSlash($('#matrl001_input8_14').val()) + "/" + replaceSlash($('#matrl001_input8_15').val()) + "/";
		    rowData.inspectItem20 += replaceSlash($('#matrl001_input8_16').val()) + "/" + replaceSlash($('#matrl001_input8_17').val()) + "/";	      	                                                                                                       
		    rowData.inspectItem21 = replaceSlash($('#matrl001_input9_1').val()) + "/" + replaceSlash($('#matrl001_input9_2').val()) + "/" + replaceSlash($('#matrl001_input9_3').val()) + "/" + replaceSlash($('#matrl001_input9_4').val()) + "/" + replaceSlash($('#matrl001_input9_5').val()) + "/";      
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl001_input9_6').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_7').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_8').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_9').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_10').val())) + "/";    
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl001_input9_11').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_12').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_13').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_14').val())) + "/" + parseFloat(replaceSlash($('#matrl001_input9_15').val())) + "/";
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl001_input9_16').val())) + "/" + replaceSlash($('#matrl001_input9_17').val());
		    InspectArray.push(rowData);
		    $.each($('#exteriorMatrlPopUpTable tbody tr'),function(idx, itm){ 	
		    	var rowData2 = new Object();
		    	rowData2.matrlCd		= matrlCd;
		    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
				rowData2.matrlGubunCd 	= matrlGubunCd;		 
				rowData2.lotNo 			= inspectlotNo;
				rowData2.managementCd 	= $(this).find('td').eq(0).find('input[type=hidden]').val();
				rowData2.resultCd 		= $(this).find('td').eq(2).find('select').val();
				rowData2.inspectEtc 	=  $(this).find('td').eq(3).find('input[type=text]').val();
				rowData2.inspectDate 	= $('#realMatrlDate').val();
				InspectArrayPopup.push(rowData2);
			    	
		    });

		}
	var url;
	var url2;
	if(sideView == 'add'){
		url = '<c:url value="/qm/inspectCreateNew"/>'; //상단
		url2 = '<c:url value="/qm/inspectCreateNew2"/>'; //하단
	} else{
		url = '<c:url value="/qm/inspectUpdateNew"/>';
		url2 = '<c:url value="/qm/inspectUpdateNew2"/>';
	}

	  
	 //001 상단 메뉴 저장
	 if(check){
	  $.ajax({
          url: url,
          type: 'POST',
          data: JSON.stringify(InspectArrayPopup),
          dataType:"json",
          contentType : "application/json; charset=UTF-8",
          success: function (res) {
              let data = res.data;

              if (res.result == 'ok') {

            		 //001 하단메뉴 저장
            		  $.ajax({
            	          url: url2,
            	          type: 'POST',
            	          data: JSON.stringify(InspectArray),
            	          dataType:"json",
            	          contentType : "application/json; charset=UTF-8",
            	          success: function (res) {
            	           
            	              if (res.result == 'ok') {            	
            	            	  toastr.success("저장되었습니다.");
            	            	  $('#realMatrlPopUpModal').modal('hide');
            	            	  $('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {}	);
            	              } else{
            	            	  toastr.warning(res.message);
            	              }
            	              $("#checkAll").prop("checked",false);
            	          },
            		  });
            		  
              } else{
            	  toastr.warning(res.message);
              }
          },
          complete: function() {
              $('#my-spinner').modal('hide');
          }
	  });
	 } else {
		 $('#my-spinner').modal('hide');
		}

  });

  $('#originMatrlPopUpSave').on('click',function(){
	  $('#my-spinner').modal('show');
	  var InspectArray = new Array();
	  var InspectArrayPopup = new Array();
	  if(sideView == 'add'){
		  $.each($('input[name=chk]:checked'),function(index, item){ 		  
			var rowData = new Object();
			var thisLotNo = "";
			rowData.inWhsGroupSeq = inWhsGroupSeq;
			rowData.matrlGubunCd = matrlGubunCd;		 
			rowData.lotNo = $(this).closest('tr').find('td').eq(5).text();
			thisLotNo  = $(this).closest('tr').find('td').eq(5).text();
			rowData.inspectDate  = $('#originMatrlDate').val();
			rowData.matrlCd		 = '';
			rowData.inspectItem1 = replaceSlash($('#matrlOld_inspectItem1_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem1_2').val()) + "/" + $('#matrlOld_inspectItem1_3 option:selected').val() + "/" + $('#matrlOld_inspectItem1_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem1_4').val());
			rowData.inspectItem2 = replaceSlash($('#matrlOld_inspectItem2_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem2_2').val()) + "/" + $('#matrlOld_inspectItem2_3 option:selected').val() + "/" + $('#matrlOld_inspectItem2_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem2_4').val());
			rowData.inspectItem3 = replaceSlash($('#matrlOld_inspectItem3_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem3_2').val()) + "/" + $('#matrlOld_inspectItem3_3 option:selected').val() + "/" + $('#matrlOld_inspectItem3_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem3_4').val());
			rowData.inspectItem4 = replaceSlash($('#matrlOld_inspectItem4_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem4_2').val()) + "/" + $('#matrlOld_inspectItem4_3 option:selected').val() + "/" + $('#matrlOld_inspectItem4_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem4_4').val());
			rowData.inspectItem5 = replaceSlash($('#matrlOld_inspectItem5_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem5_2').val()) + "/" + $('#matrlOld_inspectItem5_3 option:selected').val() + "/" + $('#matrlOld_inspectItem5_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem5_4').val());
			rowData.inspectItem6 = replaceSlash($('#matrlOld_inspectItem6_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem6_2').val()) + "/" + $('#matrlOld_inspectItem6_3 option:selected').val() + "/" + $('#matrlOld_inspectItem6_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem6_4').val());
// 			rowData.inspectItem7 = replaceSlash($('#matrlOld_inspectItem7_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem7_2').val()) + "/" + $('#matrlOld_inspectItem7_3 option:selected').val() + "/" + $('#matrlOld_inspectItem7_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem7_4').val());
// 			rowData.inspectItem8 = replaceSlash($('#matrlOld_inspectItem8_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem8_2').val()) + "/" + $('#matrlOld_inspectItem8_3 option:selected').val() + "/" + $('#matrlOld_inspectItem8_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem8_4').val());
			//rowData.inspectItem9 = replaceSlash($('#matrlOld_inspectItem9_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem9_2').val()) + "/" + $('#matrlOld_inspectItem9_3 option:selected').val() + "/" + $('#matrlOld_inspectItem9_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem9_4').val());
			//추후 자재수입검사 추가할때 html이랑 밑에주석만 지워주면 됨!
			//inspectItem10 = replaceSlash($('#matrlOld_inspectItem10_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem10_2').val()) + "/" + $('#matrlOld_inspectItem10_3 option:selected').val() + "/" + $('#matrlOld_inspectItem10_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem10_4').val());
			//inspectItem11 = replaceSlash($('#matrlOld_inspectItem11_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem11_2').val()) + "/" + $('#matrlOld_inspectItem11_3 option:selected').val() + "/" + $('#matrlOld_inspectItem11_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem11_4').val());
			//inspectItem12 = replaceSlash($('#matrlOld_inspectItem12_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem12_2').val()) + "/" + $('#matrlOld_inspectItem12_3 option:selected').val() + "/" + $('#matrlOld_inspectItem12_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem12_4').val());
		     
	        rowData.inspectItem13 = replaceSlash($('#matrlOld_input1_1').val()) + "/" + replaceSlash($('#matrlOld_input1_2').val()) + "/" + replaceSlash($('#matrlOld_input1_3').val()) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_4').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_5').val())) + "/";
	        rowData.inspectItem13 += parseFloat(replaceSlash($('#matrlOld_input1_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_7').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_8').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_9').val())) + "/" + replaceSlash($('#matrlOld_input1_10').val());
	        rowData.inspectItem14 = replaceSlash($('#matrlOld_input2_1').val()) + "/" + replaceSlash($('#matrlOld_input2_2').val()) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_3').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_4').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_5').val())) + "/";
		    rowData.inspectItem14 += parseFloat(replaceSlash($('#matrlOld_input2_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_7').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_8').val())) + "/" + replaceSlash($('#matrlOld_input2_9').val());
		    rowData.inspectItem15 = replaceSlash($('#matrlOld_input3_1').val()) + "/" + replaceSlash($('#matrlOld_input3_2').val()) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_3').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_4').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_5').val())) + "/";
		    rowData.inspectItem15 += parseFloat(replaceSlash($('#matrlOld_input3_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_7').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_8').val())) + "/" + replaceSlash($('#matrlOld_input3_9').val());
		    rowData.inspectItem16 = replaceSlash($('#matrlOld_input4_1').val()) + "/" + replaceSlash($('#matrlOld_input4_2').val()) + "/" + replaceSlash($('#matrlOld_input4_3').val()) + "/" + replaceSlash($('#matrlOld_input4_4').val()) + "/" + replaceSlash($('#matrlOld_input4_5').val()) + "/";
		    rowData.inspectItem16 += replaceSlash($('#matrlOld_input4_6').val()) + "/" + replaceSlash($('#matrlOld_input4_7').val()) + "/" + replaceSlash($('#matrlOld_input4_8').val()) + "/" + replaceSlash($('#matrlOld_input4_9').val()) + "/" + replaceSlash($('#matrlOld_input4_10').val());
		    rowData.inspectItem17 = replaceSlash($('#matrlOld_input5_1').val()) + "/" + replaceSlash($('#matrlOld_input5_2').val()) + "/" + replaceSlash($('#matrlOld_input5_3').val()) + "/" + replaceSlash($('#matrlOld_input5_4').val()) + "/" + parseFloat(replaceSlash($('#matrlOld_input5_5').val())) + "/";
		    rowData.inspectItem17 += parseFloat(replaceSlash($('#matrlOld_input5_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input5_7').val())) + "/" + replaceSlash($('#matrlOld_input5_8').val());
		    rowData.inspectItem18 = replaceSlash($('#matrlOld_input6_1').val()) + "/" + replaceSlash($('#matrlOld_input6_2').val()) + "/" + replaceSlash($('#matrlOld_input6_3').val()) + "/" + replaceSlash($('#matrlOld_input6_4').val()) + "/" + replaceSlash($('#matrlOld_input6_5').val());
		    rowData.inspectItem19 = replaceSlash($('#matrlOld_input7_1').val()) + "/" + replaceSlash($('#matrlOld_input7_2').val()) + "/" + replaceSlash($('#matrlOld_input7_3').val()) + "/" + replaceSlash($('#matrlOld_input7_4').val()) + "/" + replaceSlash($('#matrlOld_input7_5').val());
		      
		    rowData.inspectItem20 = replaceSlash($('#matrlOld_input8_1').val()) + "/" + replaceSlash($('#matrlOld_input8_2').val()) + "/" + replaceSlash($('#matrlOld_input8_3').val()) + "/" + replaceSlash($('#matrlOld_input8_4').val()) + "/" + replaceSlash($('#matrlOld_input8_5').val()) + "/";      
		    rowData.inspectItem20 += replaceSlash($('#matrlOld_input8_6').val()) + "/" + replaceSlash($('#matrlOld_input8_7').val()) + "/" + replaceSlash($('#matrlOld_input8_8').val()) + "/" + replaceSlash($('#matrlOld_input8_9').val()) + "/" + replaceSlash($('#matrlOld_input8_10').val()) + "/";    
		    rowData.inspectItem20 += replaceSlash($('#matrlOld_input8_11').val()) + "/" + replaceSlash($('#matrlOld_input8_12').val()) + "/" + replaceSlash($('#matrlOld_input8_13').val()) + "/" + replaceSlash($('#matrlOld_input8_14').val()) + "/" + replaceSlash($('#matrlOld_input8_15').val()) + "/";
		    rowData.inspectItem20 += replaceSlash($('#matrlOld_input8_16').val()) + "/" + replaceSlash($('#matrlOld_input8_17').val()) + "/" + replaceSlash($('#matrlOld_input8_18').val());	      	                                                                                                       
		    rowData.inspectItem21 = replaceSlash($('#matrlOld_input9_1').val()) + "/" + replaceSlash($('#matrlOld_input9_2').val()) + "/" + replaceSlash($('#matrlOld_input9_3').val()) + "/" + replaceSlash($('#matrlOld_input9_4').val()) + "/" + replaceSlash($('#matrlOld_input9_5').val()) + "/";      
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrlOld_input9_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_7').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_8').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_9').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_10').val())) + "/";    
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrlOld_input9_11').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_12').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_13').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_14').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_15').val())) + "/";
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrlOld_input9_16').val())) + "/" + replaceSlash($('#matrlOld_input9_17').val());
		    InspectArray.push(rowData);
		    $.each($('#exteriorOriginMatrlPopUpTable tbody tr'),function(idx, itm){ 	
		    	var rowData2 = new Object();
		    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
				rowData2.matrlGubunCd 	= matrlGubunCd;		 
				rowData2.lotNo 			= thisLotNo;
				rowData2.matrlCd		= '';
				rowData2.managementCd 	= $(this).find('td').eq(0).find('input[type=hidden]').val();
				rowData2.resultCd 		= $(this).find('td').eq(2).find('select').val();
				rowData2.inspectEtc 	=  $(this).find('td').eq(3).find('input[type=text]').val();
				rowData2.inspectDate 	= $('#originMatrlDate').val();
				InspectArrayPopup.push(rowData2);
				
		    });
		  });
	  } else{
		  var rowData = new Object();
			var thisLotNo = "";
			rowData.inWhsGroupSeq = inWhsGroupSeq;
			rowData.matrlGubunCd = matrlGubunCd;		 
			rowData.lotNo =inspectlotNo;
			rowData.matrlCd = matrlCd;
			rowData.inspectDate  = $('#originMatrlDate').val();
			rowData.inspectItem1 = replaceSlash($('#matrlOld_inspectItem1_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem1_2').val()) + "/" + $('#matrlOld_inspectItem1_3 option:selected').val() + "/" + $('#matrlOld_inspectItem1_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem1_4').val());
			rowData.inspectItem2 = replaceSlash($('#matrlOld_inspectItem2_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem2_2').val()) + "/" + $('#matrlOld_inspectItem2_3 option:selected').val() + "/" + $('#matrlOld_inspectItem2_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem2_4').val());
			rowData.inspectItem3 = replaceSlash($('#matrlOld_inspectItem3_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem3_2').val()) + "/" + $('#matrlOld_inspectItem3_3 option:selected').val() + "/" + $('#matrlOld_inspectItem3_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem3_4').val());
			rowData.inspectItem4 = replaceSlash($('#matrlOld_inspectItem4_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem4_2').val()) + "/" + $('#matrlOld_inspectItem4_3 option:selected').val() + "/" + $('#matrlOld_inspectItem4_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem4_4').val());
			rowData.inspectItem5 = replaceSlash($('#matrlOld_inspectItem5_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem5_2').val()) + "/" + $('#matrlOld_inspectItem5_3 option:selected').val() + "/" + $('#matrlOld_inspectItem5_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem5_4').val());
			rowData.inspectItem6 = replaceSlash($('#matrlOld_inspectItem6_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem6_2').val()) + "/" + $('#matrlOld_inspectItem6_3 option:selected').val() + "/" + $('#matrlOld_inspectItem6_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem6_4').val());
// 			rowData.inspectItem7 = replaceSlash($('#matrlOld_inspectItem7_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem7_2').val()) + "/" + $('#matrlOld_inspectItem7_3 option:selected').val() + "/" + $('#matrlOld_inspectItem7_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem7_4').val());
// 			rowData.inspectItem8 = replaceSlash($('#matrlOld_inspectItem8_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem8_2').val()) + "/" + $('#matrlOld_inspectItem8_3 option:selected').val() + "/" + $('#matrlOld_inspectItem8_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem8_4').val());
			//rowData.inspectItem9 = replaceSlash($('#matrlOld_inspectItem9_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem9_2').val()) + "/" + $('#matrlOld_inspectItem9_3 option:selected').val() + "/" + $('#matrlOld_inspectItem9_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem9_4').val());
			//추후 자재수입검사 추가할때 html이랑 밑에주석만 지워주면 됨!
			//inspectItem10 = replaceSlash($('#matrlOld_inspectItem10_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem10_2').val()) + "/" + $('#matrlOld_inspectItem10_3 option:selected').val() + "/" + $('#matrlOld_inspectItem10_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem10_4').val());
			//inspectItem11 = replaceSlash($('#matrlOld_inspectItem11_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem11_2').val()) + "/" + $('#matrlOld_inspectItem11_3 option:selected').val() + "/" + $('#matrlOld_inspectItem11_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem11_4').val());
			//inspectItem12 = replaceSlash($('#matrlOld_inspectItem12_1').val()) + "/" + replaceSlash($('#matrlOld_inspectItem12_2').val()) + "/" + $('#matrlOld_inspectItem12_3 option:selected').val() + "/" + $('#matrlOld_inspectItem12_3 option:selected').text() + "/" + replaceSlash($('#matrlOld_inspectItem12_4').val());
		     
	        rowData.inspectItem13 = replaceSlash($('#matrlOld_input1_1').val()) + "/" + replaceSlash($('#matrlOld_input1_2').val()) + "/" + replaceSlash($('#matrlOld_input1_3').val()) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_4').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_5').val())) + "/";
	        rowData.inspectItem13 += parseFloat(replaceSlash($('#matrlOld_input1_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_7').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_8').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input1_9').val())) + "/" + replaceSlash($('#matrlOld_input1_10').val());
	        rowData.inspectItem14 = replaceSlash($('#matrlOld_input2_1').val()) + "/" + replaceSlash($('#matrlOld_input2_2').val()) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_3').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_4').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_5').val())) + "/";
		    rowData.inspectItem14 += parseFloat(replaceSlash($('#matrlOld_input2_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_7').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input2_8').val())) + "/" + replaceSlash($('#matrlOld_input2_9').val());
		    rowData.inspectItem15 = replaceSlash($('#matrlOld_input3_1').val()) + "/" + replaceSlash($('#matrlOld_input3_2').val()) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_3').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_4').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_5').val())) + "/";
		    rowData.inspectItem15 += parseFloat(replaceSlash($('#matrlOld_input3_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_7').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input3_8').val())) + "/" + replaceSlash($('#matrlOld_input3_9').val());
		    rowData.inspectItem16 = replaceSlash($('#matrlOld_input4_1').val()) + "/" + replaceSlash($('#matrlOld_input4_2').val()) + "/" + replaceSlash($('#matrlOld_input4_3').val()) + "/" + replaceSlash($('#matrlOld_input4_4').val()) + "/" + replaceSlash($('#matrlOld_input4_5').val()) + "/";
		    rowData.inspectItem16 += replaceSlash($('#matrlOld_input4_6').val()) + "/" + replaceSlash($('#matrlOld_input4_7').val()) + "/" + replaceSlash($('#matrlOld_input4_8').val()) + "/" + replaceSlash($('#matrlOld_input4_9').val()) + "/" + replaceSlash($('#matrlOld_input4_10').val());
		    rowData.inspectItem17 = replaceSlash($('#matrlOld_input5_1').val()) + "/" + replaceSlash($('#matrlOld_input5_2').val()) + "/" + replaceSlash($('#matrlOld_input5_3').val()) + "/" + replaceSlash($('#matrlOld_input5_4').val()) + "/" + parseFloat(replaceSlash($('#matrlOld_input5_5').val())) + "/";
		    rowData.inspectItem17 += parseFloat(replaceSlash($('#matrlOld_input5_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input5_7').val())) + "/" + replaceSlash($('#matrlOld_input5_8').val());
		    rowData.inspectItem18 = replaceSlash($('#matrlOld_input6_1').val()) + "/" + replaceSlash($('#matrlOld_input6_2').val()) + "/" + replaceSlash($('#matrlOld_input6_3').val()) + "/" + replaceSlash($('#matrlOld_input6_4').val()) + "/" + replaceSlash($('#matrlOld_input6_5').val());
		    rowData.inspectItem19 = replaceSlash($('#matrlOld_input7_1').val()) + "/" + replaceSlash($('#matrlOld_input7_2').val()) + "/" + replaceSlash($('#matrlOld_input7_3').val()) + "/" + replaceSlash($('#matrlOld_input7_4').val()) + "/" + replaceSlash($('#matrlOld_input7_5').val());
		      
		    rowData.inspectItem20 = replaceSlash($('#matrlOld_input8_1').val()) + "/" + replaceSlash($('#matrlOld_input8_2').val()) + "/" + replaceSlash($('#matrlOld_input8_3').val()) + "/" + replaceSlash($('#matrlOld_input8_4').val()) + "/" + replaceSlash($('#matrlOld_input8_5').val()) + "/";      
		    rowData.inspectItem20 += replaceSlash($('#matrlOld_input8_6').val()) + "/" + replaceSlash($('#matrlOld_input8_7').val()) + "/" + replaceSlash($('#matrlOld_input8_8').val()) + "/" + replaceSlash($('#matrlOld_input8_9').val()) + "/" + replaceSlash($('#matrlOld_input8_10').val()) + "/";    
		    rowData.inspectItem20 += replaceSlash($('#matrlOld_input8_11').val()) + "/" + replaceSlash($('#matrlOld_input8_12').val()) + "/" + replaceSlash($('#matrlOld_input8_13').val()) + "/" + replaceSlash($('#matrlOld_input8_14').val()) + "/" + replaceSlash($('#matrlOld_input8_15').val()) + "/";
		    rowData.inspectItem20 += replaceSlash($('#matrlOld_input8_16').val()) + "/" + replaceSlash($('#matrlOld_input8_17').val()) + "/" + replaceSlash($('#matrlOld_input8_18').val());	      	                                                                                                       
		    rowData.inspectItem21 = replaceSlash($('#matrlOld_input9_1').val()) + "/" + replaceSlash($('#matrlOld_input9_2').val()) + "/" + replaceSlash($('#matrlOld_input9_3').val()) + "/" + replaceSlash($('#matrlOld_input9_4').val()) + "/" + replaceSlash($('#matrlOld_input9_5').val()) + "/";      
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrlOld_input9_6').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_7').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_8').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_9').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_10').val())) + "/";    
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrlOld_input9_11').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_12').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_13').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_14').val())) + "/" + parseFloat(replaceSlash($('#matrlOld_input9_15').val())) + "/";
		    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrlOld_input9_16').val())) + "/" + replaceSlash($('#matrlOld_input9_17').val());
		    InspectArray.push(rowData);
		    $.each($('#exteriorOriginMatrlPopUpTable tbody tr'),function(idx, itm){ 	
		    	var rowData2 = new Object();
		    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
				rowData2.matrlGubunCd 	= matrlGubunCd;		 
				rowData2.lotNo 			= inspectlotNo;
				rowData2.matrlCd		= matrlCd;
				rowData2.managementCd 	= $(this).find('td').eq(0).find('input[type=hidden]').val();
				rowData2.resultCd 		= $(this).find('td').eq(2).find('select').val();
				rowData2.inspectEtc 	=  $(this).find('td').eq(3).find('input[type=text]').val();
				rowData2.inspectDate 	= $('#originMatrlDate').val();
				InspectArrayPopup.push(rowData2);
			    	
		    });

		}
	var url;
	var url2;
	if(sideView == 'add'){
		url = '<c:url value="/qm/inspectCreateNew"/>'; //상단
		url2 = '<c:url value="/qm/inspectCreateNew2"/>'; //하단
	} else{
		url = '<c:url value="/qm/inspectUpdate"/>';
		url2 = '<c:url value="/qm/inspectUpdate2"/>';
	}

	  
	 //001 상단 메뉴 저장
	  $.ajax({
          url: url,
          type: 'POST',
          data: JSON.stringify(InspectArrayPopup),
          dataType:"json",
          contentType : "application/json; charset=UTF-8",
          success: function (res) {
              let data = res.data;

              if (res.result == 'ok') {

            		 //001 하단메뉴 저장
            		  $.ajax({
            	          url: url2,
            	          type: 'POST',
            	          data: JSON.stringify(InspectArray),
            	          dataType:"json",
            	          contentType : "application/json; charset=UTF-8",
            	          success: function (res) {
            	           
            	              if (res.result == 'ok') {            	
            	            	  toastr.success("저장되었습니다.");
            	            	  $('#originMatrlPopUpModal').modal('hide');
            	            	  $('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {}	);
            	              } else{
            	            	  toastr.warning(res.message);
            	              }
            	              $("#checkAll").prop("checked",false);
            	          },
            		  });
            		  
              } else{
            	  toastr.warning(res.message);
              }
          },
          complete : function() {
              $('#my-spinner').modal('hide');
          }
	  });

  });
  
	$('#rowMatrlPopUpSave').on('click',function(){
		$('#my-spinner').modal('show');
		  var InspectArrayPopup = new Array();
		  if(sideView == 'add'){
		  $.each($('input[name=chk]:checked'),function(index, item){ 		  
			  var thisLotNo =  $(this).closest('tr').find('td').eq(5).text();
			  $.each($('#rowMatrlPopUpTable tbody tr'),function(idx, itm){ 	
			 	var rowData2 = new Object();
		    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
				rowData2.matrlGubunCd 	= matrlGubunCd;		 
				rowData2.lotNo 			= thisLotNo;
				rowData2.matrlCd		= matrlCd;
				rowData2.managementCd 	= $(this).find('td').find('input[type=hidden]').val();
				rowData2.resultCd	 	= $(this).find('td').find('select').val();
				rowData2.inspectEtc 	= $(this).find('td').find('.etc').val();
				rowData2.inspectDate 	= $('#rowMatrlDate').val();
				InspectArrayPopup.push(rowData2); 
				
			  });			
		  });
		  } else{
			  $.each($('#rowMatrlPopUpTable tbody tr'),function(idx, itm){ 	
				 	 var rowData2 = new Object();
			    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
					rowData2.matrlGubunCd 	= matrlGubunCd;		 
					rowData2.lotNo 			= inspectlotNo;
					rowData2.matrlCd		= matrlCd;
					rowData2.managementCd 	= $(this).find('td').find('input[type=hidden]').val();
					rowData2.resultCd	 	= $(this).find('td').find('select').val();
					rowData2.inspectEtc 	= $(this).find('td').find('.etc').val();
					rowData2.inspectDate 	= $('#rowMatrlDate').val();
					InspectArrayPopup.push(rowData2); 
			  });	

			}
	
		var url;
		if(sideView == 'add'){
			url = '<c:url value="/qm/inspectCreateNew"/>';
		} else{
			url = '<c:url value="/qm/inspectUpdateNew"/>';
		}
		$.ajax({
			url: url,
			 type: 'POST',
	          data: JSON.stringify(InspectArrayPopup),
	          dataType:"json",
	          contentType : "application/json; charset=UTF-8",		         
			success: function (res) {           
			
				if (res.result == 'ok') {
					toastr.success("저장되었습니다.");
					$('#rowMatrlPopUpModal').modal('hide');
					//$('#rowMatrlPopUpTable').DataTable().ajax.reload( function () {}	);
					 $('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {}	);					 
				} else{
            		toastr.warning(res.message);
				}
				$("#checkAll").prop("checked",false);
			},
			complete: function() {
				$('#my-spinner').modal('hide');
			}
		});
	});
  
	$('#procMatrlPopUpSave').on('click',function(){
/* 		inspectItem1 = replaceSlash($('#matrl003_input1_1').val()) + "/" + replaceSlash($('#matrl003_input1_2').val()) + "/" + replaceSlash($('#matrl003_input1_3').val()) + "/" + $('#matrl003_input1_4 option:selected').val() + "/" + $('#matrl003_input1_4 option:selected').text() + "/" + replaceSlash($('#matrl003_input1_5').val());
		inspectItem2 = replaceSlash($('#matrl003_input2_1').val()) + "/" + replaceSlash($('#matrl003_input2_2').val()) + "/" + replaceSlash($('#matrl003_input2_3').val()) + "/" + $('#matrl003_input2_4 option:selected').val() + "/" + $('#matrl003_input2_4 option:selected').text() + "/" + replaceSlash($('#matrl003_input2_5').val());
		inspectItem3 = replaceSlash($('#matrl003_input3_1').val()) + "/" + replaceSlash($('#matrl003_input3_2').val()) + "/" + replaceSlash($('#matrl003_input3_3').val()) + "/" + $('#matrl003_input3_4 option:selected').val() + "/" + $('#matrl003_input3_4 option:selected').text() + "/" + replaceSlash($('#matrl003_input3_5').val());
		inspectItem4 = replaceSlash($('#matrl003_input4_1').val()) + "/" + replaceSlash($('#matrl003_input4_2').val()) + "/" + replaceSlash($('#matrl003_input4_3').val()) + "/" + replaceSlash($('#matrl003_input4_4').val()) + "/" + replaceSlash($('#matrl003_input4_5').val()) + "/";
		inspectItem4 += replaceSlash($('#matrl003_input4_6').val());
		
		inspectItem5 = replaceSlash($('#matrl003_input5_1').val()) + "/" + replaceSlash($('#matrl003_input5_2').val()) + "/" + replaceSlash($('#matrl003_input5_3').val()) + "/" + $('#matrl003_input5_4 option:selected').val() + "/" + $('#matrl003_input5_4 option:selected').text() + "/" + replaceSlash($('#matrl003_input5_5').val());
		inspectItem6 = replaceSlash($('#matrl003_input6_1').val()) + "/" + replaceSlash($('#matrl003_input6_2').val()) + "/" + replaceSlash($('#matrl003_input6_3').val()) + "/" + $('#matrl003_input6_4 option:selected').val() + "/" + $('#matrl003_input6_4 option:selected').text() + "/" + replaceSlash($('#matrl003_input6_5').val());
		 */

		 $('#my-spinner').modal('show')
		  var InspectArrayPopup = new Array();
		 if(sideView == 'add'){
		  $.each($('input[name=chk]:checked'),function(index, item){ 		  
			  var thisLotNo =  $(this).closest('tr').find('td').eq(5).text();
			  $.each($('#procMatrlPopUpTable tbody tr'),function(idx, itm){ 	
			 	 var rowData2 = new Object();
		    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
				rowData2.matrlGubunCd 	= matrlGubunCd;		 
				rowData2.lotNo 			= thisLotNo;
				rowData2.matrlCd		= matrlCd;
				rowData2.managementCd 	= $(this).find('td').find('input[type=hidden]').val();
				rowData2.resultCd 		= $(this).find('td').eq(3).find('select').val();
				rowData2.inspectEtc 	= $(this).find('td').eq(4).find('input[type=text]').val();
				rowData2.inspectDate 	= $('#procMatrlDate').val();
				InspectArrayPopup.push(rowData2); 
				
			  });			
		  });
		 } else{
			 $.each($('#procMatrlPopUpTable tbody tr'),function(idx, itm){ 	
			 	 var rowData2 = new Object();
		    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
				rowData2.matrlGubunCd 	= matrlGubunCd;		 
				rowData2.lotNo 			= inspectlotNo;
				rowData2.matrlCd		= matrlCd;
				rowData2.managementCd 	= $(this).find('td').find('input[type=hidden]').val();
				rowData2.resultCd 		= $(this).find('td').eq(3).find('select').val();
				rowData2.inspectEtc 	= $(this).find('td').eq(4).find('input[type=text]').val();
				rowData2.inspectDate 	= $('#procMatrlDate').val();
				InspectArrayPopup.push(rowData2); 
				
			  });			

			 }

		var url;
		if(sideView == 'add'){
			url = '<c:url value="/qm/inspectCreateNew"/>';
		} else{
			url = '<c:url value="/qm/inspectUpdateNew"/>';
		}
		$.ajax({
			url: url,
			type: 'POST',
	        data: JSON.stringify(InspectArrayPopup),
	        dataType:"json",
	        contentType : "application/json; charset=UTF-8",		 
			success: function (res) {           				
				
				if (res.result == 'ok') {
				  toastr.success("저장되었습니다.");
				  $('#procMatrlPopUpModal').modal('hide');
				 // $('#rowMatrlPopUpTable').DataTable().ajax.reload( function () {}	);
				  $('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {}	);
				} else{
				  toastr.warning(res.message);
				}
				$("#checkAll").prop("checked",false);
			},
			complete: function(){
				$('#my-spinner').modal('hide');
			}
		});
	});

	  $('#filmMatrlPopUpSave').on('click',function(){
		  $('#my-spinner').modal('show');
		  var InspectArray = new Array();
		  var InspectArrayPopup = new Array();

		  var check = true;

		  $.each($('#sizeFilmMatrlPopUpTable .mustInput'), function(index, item){
			  if($(this).val()=='0'||$(this).val()==''){
				  check = false;
				  toastr.warning('필수값이 입력되지 않았습니다.');
				  $(this).focus();
				  return false;
			}
		});

			
		  if(sideView == 'add'&&check){
			  $.each($('input[name=chk]:checked'),function(index, item){ 		  
				var rowData = new Object();
				var thisLotNo = "";
				rowData.inWhsGroupSeq = inWhsGroupSeq;
				rowData.matrlGubunCd = matrlGubunCd;		 
				rowData.lotNo = $(this).closest('tr').find('td').eq(5).text();
				thisLotNo  = $(this).closest('tr').find('td').eq(5).text();
				rowData.inspectDate  = $('#realMatrlDate').val();
				rowData.matrlCd	 = matrlCd;
				rowData.inspectItem1 = replaceSlash($('#matrl004_inspectItem1_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem1_2').val()) + "/" + $('#matrl004_inspectItem1_3 option:selected').val() + "/" + $('#matrl004_inspectItem1_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem1_4').val());
				rowData.inspectItem2 = replaceSlash($('#matrl004_inspectItem2_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem2_2').val()) + "/" + $('#matrl004_inspectItem2_3 option:selected').val() + "/" + $('#matrl004_inspectItem2_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem2_4').val());
				rowData.inspectItem3 = replaceSlash($('#matrl004_inspectItem3_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem3_2').val()) + "/" + $('#matrl004_inspectItem3_3 option:selected').val() + "/" + $('#matrl004_inspectItem3_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem3_4').val());
				rowData.inspectItem4 = replaceSlash($('#matrl004_inspectItem4_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem4_2').val()) + "/" + $('#matrl004_inspectItem4_3 option:selected').val() + "/" + $('#matrl004_inspectItem4_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem4_4').val());
				rowData.inspectItem5 = replaceSlash($('#matrl004_inspectItem5_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem5_2').val()) + "/" + $('#matrl004_inspectItem5_3 option:selected').val() + "/" + $('#matrl004_inspectItem5_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem5_4').val());
				rowData.inspectItem6 = replaceSlash($('#matrl004_inspectItem6_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_2').val()) + "/" + $('#matrl004_inspectItem6_3 option:selected').val() + "/" + $('#matrl004_inspectItem6_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem6_4').val());
// 				rowData.inspectItem7 = replaceSlash($('#matrl004_inspectItem7_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem7_2').val()) + "/" + $('#matrl004_inspectItem7_3 option:selected').val() + "/" + $('#matrl004_inspectItem7_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem7_4').val());
// 				rowData.inspectItem8 = replaceSlash($('#matrl004_inspectItem8_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem8_2').val()) + "/" + $('#matrl004_inspectItem8_3 option:selected').val() + "/" + $('#matrl004_inspectItem8_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem8_4').val());
				//rowData.inspectItem9 = replaceSlash($('#matrl004_inspectItem9_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem9_2').val()) + "/" + $('#matrl004_inspectItem9_3 option:selected').val() + "/" + $('#matrl004_inspectItem9_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem9_4').val());
				//추후 자재수입검사 추가할때 html이랑 밑에주석만 지워주면 됨!
				//inspectItem10 = replaceSlash($('#matrl004_inspectItem10_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem10_2').val()) + "/" + $('#matrl004_inspectItem10_3 option:selected').val() + "/" + $('#matrl004_inspectItem10_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem10_4').val());
				//inspectItem11 = replaceSlash($('#matrl004_inspectItem11_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem11_2').val()) + "/" + $('#matrl004_inspectItem11_3 option:selected').val() + "/" + $('#matrl004_inspectItem11_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem11_4').val());
				//inspectItem12 = replaceSlash($('#matrl004_inspectItem12_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_2').val()) + "/" + $('#matrl004_inspectItem12_3 option:selected').val() + "/" + $('#matrl004_inspectItem12_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem12_4').val());
			     
		        rowData.inspectItem13 = replaceSlash($('#matrl004_input1_1').val()) + "/" + replaceSlash($('#matrl004_input1_2').val()) + "/" + replaceSlash($('#matrl004_input1_3').val()) + "/" + parseFloat(replaceSlash($('#matrl004_input1_4').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input1_5').val())) + "/";
		        rowData.inspectItem13 += parseFloat(replaceSlash($('#matrl004_input1_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input1_7').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input1_8').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input1_9').val())) + "/" + replaceSlash($('#matrl004_input1_10').val());
		        rowData.inspectItem14 = replaceSlash($('#matrl004_input2_1').val()) + "/" + replaceSlash($('#matrl004_input2_2').val()) + "/" + parseFloat(replaceSlash($('#matrl004_input2_3').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input2_4').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input2_5').val())) + "/";
			    rowData.inspectItem14 += parseFloat(replaceSlash($('#matrl004_input2_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input2_7').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input2_8').val())) + "/" + replaceSlash($('#matrl004_input2_9').val());
			    rowData.inspectItem15 = '';
// 			    rowData.inspectItem15 = replaceSlash($('#matrl004_input3_1').val()) + "/" + replaceSlash($('#matrl004_input3_2').val()) + "/" + parseFloat(replaceSlash($('#matrl004_input3_3').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input3_4').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input3_5').val())) + "/";
// 			    rowData.inspectItem15 += parseFloat(replaceSlash($('#matrl004_input3_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input3_7').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input3_8').val())) + "/" + replaceSlash($('#matrl004_input3_9').val());
			    rowData.inspectItem16 = replaceSlash($('#matrl004_input4_1').val()) + "/" + replaceSlash($('#matrl004_input4_2').val()) + "/" + replaceSlash($('#matrl004_input4_3').val());// + "/" + replaceSlash($('#matrl004_input4_4').val()) + "/" + replaceSlash($('#matrl004_input4_5').val()) + "/";
			    rowData.inspectItem16 +=  replaceSlash($('#matrl004_input4_7').val()) + "/" + replaceSlash($('#matrl004_input4_8').val()) + "/" + replaceSlash($('#matrl004_input4_10').val());
// 			    rowData.inspectItem17 = replaceSlash($('#matrl004_input5_1').val()) + "/" + replaceSlash($('#matrl004_input5_2').val()) + "/" + replaceSlash($('#matrl004_input5_3').val()) + "/" + replaceSlash($('#matrl004_input5_4').val()) + "/" + parseFloat(replaceSlash($('#matrl004_input5_5').val())) + "/";
// 			    rowData.inspectItem17 += parseFloat(replaceSlash($('#matrl004_input5_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input5_7').val())) + "/" + replaceSlash($('#matrl004_input5_8').val());
				rowData.inspectItem17 = '';
			    rowData.inspectItem18 = replaceSlash($('#matrl004_input6_1').val()) + "/" + replaceSlash($('#matrl004_input6_2').val()) + "/" + replaceSlash($('#matrl004_input6_3').val()) + "/" + replaceSlash($('#matrl004_input6_4').val()) + "/" + replaceSlash($('#matrl004_input6_5').val());
			    rowData.inspectItem19 = replaceSlash($('#matrl004_input7_1').val()) + "/" + replaceSlash($('#matrl004_input7_2').val()) + "/" + replaceSlash($('#matrl004_input7_3').val()) + "/" + replaceSlash($('#matrl004_input7_4').val()) + "/" + replaceSlash($('#matrl004_input7_5').val());
			    rowData.inspectItem20 = '';
			    rowData.inspectItem21 = '';
// 			    rowData.inspectItem20 = replaceSlash($('#matrl004_input8_1').val()) + "/" + replaceSlash($('#matrl004_input8_2').val()) + "/" + replaceSlash($('#matrl004_input8_3').val()) + "/" + replaceSlash($('#matrl004_input8_4').val()) + "/" + replaceSlash($('#matrl004_input8_5').val()) + "/";      
// 			    rowData.inspectItem20 += replaceSlash($('#matrl004_input8_6').val()) + "/" + replaceSlash($('#matrl004_input8_7').val()) + "/" + replaceSlash($('#matrl004_input8_8').val()) + "/" + replaceSlash($('#matrl004_input8_9').val()) + "/" + replaceSlash($('#matrl004_input8_10').val()) + "/";    
// 			    rowData.inspectItem20 += replaceSlash($('#matrl004_input8_11').val()) + "/" + replaceSlash($('#matrl004_input8_12').val()) + "/" + replaceSlash($('#matrl004_input8_13').val()) + "/" + replaceSlash($('#matrl004_input8_14').val()) + "/" + replaceSlash($('#matrl004_input8_15').val()) + "/";
// 			    rowData.inspectItem20 += replaceSlash($('#matrl004_input8_16').val()) + "/" + replaceSlash($('#matrl004_input8_17').val()) + "/" + replaceSlash($('#matrl004_input8_18').val());	      	                                                                                                       
// 			    rowData.inspectItem21 = replaceSlash($('#matrl004_input9_1').val()) + "/" + replaceSlash($('#matrl004_input9_2').val()) + "/" + replaceSlash($('#matrl004_input9_3').val()) + "/" + replaceSlash($('#matrl004_input9_4').val()) + "/" + replaceSlash($('#matrl004_input9_5').val()) + "/";      
// 			    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl004_input9_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_7').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_8').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_9').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_10').val())) + "/";    
// 			    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl004_input9_11').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_12').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_13').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_14').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_15').val())) + "/";
// 			    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl004_input9_16').val())) + "/" + replaceSlash($('#matrl004_input9_17').val());
			    InspectArray.push(rowData);
			    $.each($('#exteriorFilmPopUpTable tbody tr'),function(idx, itm){ 	
			    	var rowData2 = new Object();
			    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
					rowData2.matrlGubunCd 	= matrlGubunCd;		 
					rowData2.lotNo 			= thisLotNo;
					rowData2.matrlCd		= matrlCd;
					rowData2.managementCd 	= $(this).find('td').eq(0).find('input[type=hidden]').val();
					rowData2.resultCd 		= $(this).find('td').eq(2).find('select').val();
					rowData2.inspectEtc 	=  $(this).find('td').eq(3).find('input[type=text]').val();
					rowData2.inspectDate 	= $('#filmMatrlDate').val();
					InspectArrayPopup.push(rowData2);
					
			    });
			  });
		  } else{
			  var rowData = new Object();
				var thisLotNo = "";
				rowData.inWhsGroupSeq = inWhsGroupSeq;
				rowData.matrlGubunCd = matrlGubunCd;		 
				rowData.lotNo =inspectlotNo;
				rowData.inspectDate  = $('#realMatrlDate').val();
				rowData.matrlCd  	 = matrlCd;
				rowData.inspectItem1 = replaceSlash($('#matrl004_inspectItem1_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem1_2').val()) + "/" + $('#matrl004_inspectItem1_3 option:selected').val() + "/" + $('#matrl004_inspectItem1_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem1_4').val());
				rowData.inspectItem2 = replaceSlash($('#matrl004_inspectItem2_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem2_2').val()) + "/" + $('#matrl004_inspectItem2_3 option:selected').val() + "/" + $('#matrl004_inspectItem2_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem2_4').val());
				rowData.inspectItem3 = replaceSlash($('#matrl004_inspectItem3_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem3_2').val()) + "/" + $('#matrl004_inspectItem3_3 option:selected').val() + "/" + $('#matrl004_inspectItem3_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem3_4').val());
				rowData.inspectItem4 = replaceSlash($('#matrl004_inspectItem4_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem4_2').val()) + "/" + $('#matrl004_inspectItem4_3 option:selected').val() + "/" + $('#matrl004_inspectItem4_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem4_4').val());
				rowData.inspectItem5 = replaceSlash($('#matrl004_inspectItem5_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem5_2').val()) + "/" + $('#matrl004_inspectItem5_3 option:selected').val() + "/" + $('#matrl004_inspectItem5_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem5_4').val());
				rowData.inspectItem6 = replaceSlash($('#matrl004_inspectItem6_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem6_2').val()) + "/" + $('#matrl004_inspectItem6_3 option:selected').val() + "/" + $('#matrl004_inspectItem6_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem6_4').val());
// 				rowData.inspectItem7 = replaceSlash($('#matrl004_inspectItem7_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem7_2').val()) + "/" + $('#matrl004_inspectItem7_3 option:selected').val() + "/" + $('#matrl004_inspectItem7_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem7_4').val());
// 				rowData.inspectItem8 = replaceSlash($('#matrl004_inspectItem8_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem8_2').val()) + "/" + $('#matrl004_inspectItem8_3 option:selected').val() + "/" + $('#matrl004_inspectItem8_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem8_4').val());
				//rowData.inspectItem9 = replaceSlash($('#matrl004_inspectItem9_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem9_2').val()) + "/" + $('#matrl004_inspectItem9_3 option:selected').val() + "/" + $('#matrl004_inspectItem9_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem9_4').val());
				//추후 자재수입검사 추가할때 html이랑 밑에주석만 지워주면 됨!
				//inspectItem10 = replaceSlash($('#matrl004_inspectItem10_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem10_2').val()) + "/" + $('#matrl004_inspectItem10_3 option:selected').val() + "/" + $('#matrl004_inspectItem10_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem10_4').val());
				//inspectItem11 = replaceSlash($('#matrl004_inspectItem11_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem11_2').val()) + "/" + $('#matrl004_inspectItem11_3 option:selected').val() + "/" + $('#matrl004_inspectItem11_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem11_4').val());
				//inspectItem12 = replaceSlash($('#matrl004_inspectItem12_1').val()) + "/" + replaceSlash($('#matrl004_inspectItem12_2').val()) + "/" + $('#matrl004_inspectItem12_3 option:selected').val() + "/" + $('#matrl004_inspectItem12_3 option:selected').text() + "/" + replaceSlash($('#matrl004_inspectItem12_4').val());
			     
		        rowData.inspectItem13 = replaceSlash($('#matrl004_input1_1').val()) + "/" + replaceSlash($('#matrl004_input1_2').val()) + "/" + replaceSlash($('#matrl004_input1_3').val()) + "/" + parseFloat(replaceSlash($('#matrl004_input1_4').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input1_5').val())) + "/";
		        rowData.inspectItem13 += parseFloat(replaceSlash($('#matrl004_input1_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input1_7').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input1_8').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input1_9').val())) + "/" + replaceSlash($('#matrl004_input1_10').val());
		        rowData.inspectItem14 = replaceSlash($('#matrl004_input2_1').val()) + "/" + replaceSlash($('#matrl004_input2_2').val()) + "/" + parseFloat(replaceSlash($('#matrl004_input2_3').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input2_4').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input2_5').val())) + "/";
			    rowData.inspectItem14 += parseFloat(replaceSlash($('#matrl004_input2_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input2_7').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input2_8').val())) + "/" + replaceSlash($('#matrl004_input2_9').val());
 			    rowData.inspectItem15 = ''; //replaceSlash($('#matrl004_input3_1').val()) + "/" + replaceSlash($('#matrl004_input3_2').val()) + "/" + parseFloat(replaceSlash($('#matrl004_input3_3').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input3_4').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input3_5').val())) + "/";
// 			    rowData.inspectItem15 += parseFloat(replaceSlash($('#matrl004_input3_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input3_7').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input3_8').val())) + "/" + replaceSlash($('#matrl004_input3_9').val());
			    rowData.inspectItem16 = replaceSlash($('#matrl004_input4_1').val()) + "/" + replaceSlash($('#matrl004_input4_2').val()) + "/" + replaceSlash($('#matrl004_input4_3').val());// + "/" + replaceSlash($('#matrl004_input4_4').val()) + "/" + replaceSlash($('#matrl004_input4_5').val()) + "/";
			    rowData.inspectItem16 += replaceSlash($('#matrl004_input4_7').val()) + "/" + replaceSlash($('#matrl004_input4_8').val()) + "/" + replaceSlash($('#matrl004_input4_10').val());
			    rowData.inspectItem17 = '';//replaceSlash($('#matrl004_input5_1').val()) + "/" + replaceSlash($('#matrl004_input5_2').val()) + "/" + replaceSlash($('#matrl004_input5_3').val()) + "/" + replaceSlash($('#matrl004_input5_4').val()) + "/" + parseFloat(replaceSlash($('#matrl004_input5_5').val())) + "/";
			    //rowData.inspectItem17 += parseFloat(replaceSlash($('#matrl004_input5_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input5_7').val())) + "/" + replaceSlash($('#matrl004_input5_8').val());
			    rowData.inspectItem18 = replaceSlash($('#matrl004_input6_1').val()) + "/" + replaceSlash($('#matrl004_input6_2').val()) + "/" + replaceSlash($('#matrl004_input6_3').val()) + "/" + replaceSlash($('#matrl004_input6_4').val()) + "/" + replaceSlash($('#matrl004_input6_5').val());
			    rowData.inspectItem19 = replaceSlash($('#matrl004_input7_1').val()) + "/" + replaceSlash($('#matrl004_input7_2').val()) + "/" + replaceSlash($('#matrl004_input7_3').val()) + "/" + replaceSlash($('#matrl004_input7_4').val()) + "/" + replaceSlash($('#matrl004_input7_5').val());
			      
			    rowData.inspectItem20 = '';//replaceSlash($('#matrl004_input8_1').val()) + "/" + replaceSlash($('#matrl004_input8_2').val()) + "/" + replaceSlash($('#matrl004_input8_3').val()) + "/" + replaceSlash($('#matrl004_input8_4').val()) + "/" + replaceSlash($('#matrl004_input8_5').val()) + "/";      
// 			    rowData.inspectItem20 += replaceSlash($('#matrl004_input8_6').val()) + "/" + replaceSlash($('#matrl004_input8_7').val()) + "/" + replaceSlash($('#matrl004_input8_8').val()) + "/" + replaceSlash($('#matrl004_input8_9').val()) + "/" + replaceSlash($('#matrl004_input8_10').val()) + "/";    
// 			    rowData.inspectItem20 += replaceSlash($('#matrl004_input8_11').val()) + "/" + replaceSlash($('#matrl004_input8_12').val()) + "/" + replaceSlash($('#matrl004_input8_13').val()) + "/" + replaceSlash($('#matrl004_input8_14').val()) + "/" + replaceSlash($('#matrl004_input8_15').val()) + "/";
// 			    rowData.inspectItem20 += replaceSlash($('#matrl004_input8_16').val()) + "/" + replaceSlash($('#matrl004_input8_17').val()) + "/" + replaceSlash($('#matrl004_input8_18').val());	      	                                                                                                       
			    rowData.inspectItem21 = '';//replaceSlash($('#matrl004_input9_1').val()) + "/" + replaceSlash($('#matrl004_input9_2').val()) + "/" + replaceSlash($('#matrl004_input9_3').val()) + "/" + replaceSlash($('#matrl004_input9_4').val()) + "/" + replaceSlash($('#matrl004_input9_5').val()) + "/";      
// 			    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl004_input9_6').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_7').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_8').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_9').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_10').val())) + "/";    
// 			    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl004_input9_11').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_12').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_13').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_14').val())) + "/" + parseFloat(replaceSlash($('#matrl004_input9_15').val())) + "/";
// 			    rowData.inspectItem21 += parseFloat(replaceSlash($('#matrl004_input9_16').val())) + "/" + replaceSlash($('#matrl004_input9_17').val());
			    InspectArray.push(rowData);
			    $.each($('#exteriorFilmPopUpTable tbody tr'),function(idx, itm){ 	
			    	var rowData2 = new Object();
			    	rowData2.inWhsGroupSeq 	= inWhsGroupSeq;
					rowData2.matrlGubunCd 	= matrlGubunCd;		 
					rowData2.lotNo 			= inspectlotNo;
					rowData2.matrlCd		= matrlCd;
					rowData2.managementCd 	= $(this).find('td').eq(0).find('input[type=hidden]').val();
					rowData2.resultCd 		= $(this).find('td').eq(2).find('select').val();
					rowData2.inspectEtc 	=  $(this).find('td').eq(3).find('input[type=text]').val();
					rowData2.inspectDate 	= $('#filmMatrlDate').val();
					InspectArrayPopup.push(rowData2);
				    	
			    });

			}
		var url;
		var url2;
		if(sideView == 'add'){
			url = '<c:url value="/qm/inspectCreateNew"/>'; //상단
			url2 = '<c:url value="/qm/inspectCreateNew2"/>'; //하단
		} else{
			url = '<c:url value="/qm/inspectUpdateNew"/>';
			url2 = '<c:url value="/qm/inspectUpdateNew2"/>';
		}

		  
		 //004 상단 메뉴 저장
		 if(check){
		  $.ajax({
	          url: url,
	          type: 'POST',
	          data: JSON.stringify(InspectArrayPopup),
	          dataType:"json",
	          contentType : "application/json; charset=UTF-8",
	          success: function (res) {
	              let data = res.data;

	              if (res.result == 'ok') {

	            		 //004 하단메뉴 저장
	            		  $.ajax({
	            	          url: url2,
	            	          type: 'POST',
	            	          data: JSON.stringify(InspectArray),
	            	          dataType:"json",
	            	          contentType : "application/json; charset=UTF-8",
	            	          success: function (res) {
	            	           
	            	              if (res.result == 'ok') {            	
	            	            	  toastr.success("저장되었습니다.");
	            	            	  $('#filmMatrlPopUpModal').modal('hide');
	            	            	  $('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {}	);
	            	              } else{
	            	            	  toastr.warning(res.message);
	            	              }
	            	              $("#checkAll").prop("checked",false);
	            	          },
	            		  });
	            		  
	              } else{
	            	  toastr.warning(res.message);
	              }
	          },
	          complete: function(){
		          $('#my-spinner').modal('hide');
		      }
		  });
		 }else {
			 $('#my-spinner').modal('hide');
			}

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
  	$('#matrl001_input6_14').val("");
  	$('#matrl001_input6_15').val("");   	
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

  function matrl001_clear_old() {
		$('#matrlOld_inspectItem1_1').val(""); 
	  	$('#matrlOld_inspectItem1_2').val("");
	  	
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem1_3", "001", "");
	  	$('#matrlOld_inspectItem1_4').val("");            	
	  	$('#matrlOld_inspectItem2_1').val("");
	  	$('#matrlOld_inspectItem2_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem2_3", "001", "");
	  	$('#matrlOld_inspectItem2_4').val("");
	  	$('#matrlOld_inspectItem3_1').val("");
	  	$('#matrlOld_inspectItem3_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem3_3", "001", "");
	  	$('#matrlOld_inspectItem3_4').val("");
	  	$('#matrlOld_inspectItem4_1').val("");
	  	$('#matrlOld_inspectItem4_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem4_3", "001", "");
	  	$('#matrlOld_inspectItem4_4').val("");
	  	$('#matrlOld_inspectItem5_1').val("");
	  	$('#matrlOld_inspectItem5_2').val("");
	 	selectBoxAppend(approvalCheck, "matrlOld_inspectItem5_3", "001", "");
	  	$('#matrlOld_inspectItem5_4').val("");
	  	$('#matrlOld_inspectItem6_1').val("");
	  	$('#matrlOld_inspectItem6_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem6_3", "001", "");
	  	$('#matrlOld_inspectItem6_4').val("");
	  	$('#matrlOld_inspectItem7_1').val("");
	  	$('#matrlOld_inspectItem7_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem7_3", "001", "");
	  	$('#matrlOld_inspectItem7_4').val("");

	  	$('#matrlOld_inspectItem8_1').val("");
	  	$('#matrlOld_inspectItem8_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem8_3", "", "2");
	  	$('#matrlOld_inspectItem8_4').val("")
	  	$('#matrlOld_inspectItem9_1').val("");
	  	$('#matrlOld_inspectItem9_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem9_3", "", "2");
	  	$('#matrlOld_inspectItem9_4').val("")
	  	$('#matrlOld_inspectItem10_1').val("");
	  	$('#matrlOld_inspectItem10_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem10_3", "", "2");
	  	$('#matrlOld_inspectItem10_4').val("")
	  	$('#matrlOld_inspectItem11_1').val("");
	  	$('#matrlOld_inspectItem11_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem11_3", "", "2");
	  	$('#matrlOld_inspectItem11_4').val("")
	  	$('#matrlOld_inspectItem12_1').val("");
	  	$('#matrlOld_inspectItem12_2').val("");
	  	selectBoxAppend(approvalCheck, "matrlOld_inspectItem12_3", "", "2");
	  	$('#matrlOld_inspectItem12_4').val("")

	  	
	  	$('#matrlOld_input1_1').val("");
	  	$('#matrlOld_input1_2').val("");
	  	$('#matrlOld_input1_3').val("");
	  	$('#matrlOld_input1_4').val("0");
	  	$('#matrlOld_input1_5').val("0");
	  	$('#matrlOld_input1_6').val("0");
	  	$('#matrlOld_input1_7').val("0");
	  	$('#matrlOld_input1_8').val("0");
	  	$('#matrlOld_input1_9').val("0");
	  	$('#matrlOld_input1_10').val("");    	
	  	$('#matrlOld_input2_1').val("");
	  	$('#matrlOld_input2_2').val("");
	  	$('#matrlOld_input2_3').val("0");
	  	$('#matrlOld_input2_4').val("0");
	  	$('#matrlOld_input2_5').val("0");
	  	$('#matrlOld_input2_6').val("0");
	  	$('#matrlOld_input2_7').val("0");
	  	$('#matrlOld_input2_8').val("0");
	  	$('#matrlOld_input2_9').val("");     	
	  	$('#matrlOld_input3_1').val("");
	  	$('#matrlOld_input3_2').val("");
	  	$('#matrlOld_input3_3').val("0");
	  	$('#matrlOld_input3_4').val("0");
	  	$('#matrlOld_input3_5').val("0");
	  	$('#matrlOld_input3_6').val("0");
	  	$('#matrlOld_input3_7').val("0");
	  	$('#matrlOld_input3_8').val("0");
	  	$('#matrlOld_input3_9').val("");     	
	  	$('#matrlOld_input4_1').val("");
	  	$('#matrlOld_input4_2').val("");
	  	$('#matrlOld_input4_3').val("");
	  	$('#matrlOld_input4_4').val("");
	  	$('#matrlOld_input4_5').val("");
	  	$('#matrlOld_input4_6').val("");
	  	$('#matrlOld_input4_7').val("");
	  
	  	$('#matrlOld_input4_10').val("");      	
	  	$('#matrlOld_input5_1').val("");
	  	$('#matrlOld_input5_2').val("");
	  	$('#matrlOld_input5_3').val("");
	  	$('#matrlOld_input5_4').val("");
	  	$('#matrlOld_input5_5').val("0");
	  	$('#matrlOld_input5_6').val("0");
	  	$('#matrlOld_input5_7').val("0");
	  	$('#matrlOld_input5_8').val("");     	
	  	$('#matrlOld_input6_1').val("");
	  	$('#matrlOld_input6_2').val("");
	  	$('#matrlOld_input6_3').val("");
	  	$('#matrlOld_input6_4').val("");
	  	$('#matrlOld_input6_5').val("");     	
	  	$('#matrlOld_input7_1').val("");
	  	$('#matrlOld_input7_2').val("");
	  	$('#matrlOld_input7_3').val("");
	  	$('#matrlOld_input7_4').val("");
	  	$('#matrlOld_input7_5').val("");
	  	  	
	  	$('#matrlOld_input8_1').val("");
	  	$('#matrlOld_input8_2').val("");
	  	$('#matrlOld_input8_3').val("");
	  	$('#matrlOld_input8_4').val("");
	  	$('#matrlOld_input8_5').val("");
	  	$('#matrlOld_input8_6').val("");
	  	//$('#matrlOld_input8_7').val("");
	  
	  	$('#matrlOld_input8_18').val("");	            	
	  	$('#matrlOld_input9_1').val("");
	  	$('#matrlOld_input9_2').val("");
	  	$('#matrlOld_input9_3').val("");
	  	$('#matrlOld_input9_4').val("");
	  	$('#matrlOld_input9_5').val("");
	  	$('#matrlOld_input9_6').val("0");
	  	$('#matrlOld_input9_7').val("0");
	  	$('#matrlOld_input9_8').val("0");
	  	$('#matrlOld_input9_9').val("0");
	  	$('#matrlOld_input9_10').val("0");
	  	$('#matrlOld_input9_11').val("0");
	  	$('#matrlOld_input9_12').val("0");
	  	$('#matrlOld_input9_13').val("0");
	  	$('#matrlOld_input9_14').val("0");
	  	$('#matrlOld_input9_15').val("0");
	  	$('#matrlOld_input9_16').val("0");
	  	$('#matrlOld_input9_17').val("");
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

  function matrl004_clear() {
		$('#matrl004_inspectItem1_1').val(""); 
	  	$('#matrl004_inspectItem1_2').val("");
	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem1_3", "001", "");
	  	$('#matrl004_inspectItem1_4').val("");     
	  	       	
	  	$('#matrl004_inspectItem2_1').val("");
	  	$('#matrl004_inspectItem2_2').val("");
	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem2_3", "001", "");
	  	$('#matrl004_inspectItem2_4').val("");
	  	
	  	$('#matrl004_inspectItem3_1').val("");
	  	$('#matrl004_inspectItem3_2').val("");
	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem3_3", "001", "");
	  	$('#matrl004_inspectItem3_4').val("");
	  	
	  	$('#matrl004_inspectItem4_1').val("");
	  	$('#matrl004_inspectItem4_2').val("");
	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem4_3", "001", "");
	  	$('#matrl004_inspectItem4_4').val("");
	  	
	  	$('#matrl004_inspectItem5_1').val("");
	  	$('#matrl004_inspectItem5_2').val("");
	 	selectBoxAppend(approvalCheck, "matrl004_inspectItem5_3", "001", "");
	  	$('#matrl004_inspectItem5_4').val("");
	  	
	  	$('#matrl004_inspectItem6_1').val("");
	  	$('#matrl004_inspectItem6_2').val("");
	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem6_3", "001", "");
	  	$('#matrl004_inspectItem6_4').val("");
	  	
	  	$('#matrl004_inspectItem7_1').val("");
	  	$('#matrl004_inspectItem7_2').val("");
	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem7_3", "001", "");
	  	$('#matrl004_inspectItem7_4').val("");
	  	

// 	  	$('#matrl004_inspectItem8_1').val("");
// 	  	$('#matrl004_inspectItem8_2').val("");
// 	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem8_3", "", "2");
// 	  	$('#matrl004_inspectItem8_4').val("")
	  	
// 	  	$('#matrl004_inspectItem9_1').val("");
// 	  	$('#matrl004_inspectItem9_2').val("");
// 	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem9_3", "", "2");
// 	  	$('#matrl004_inspectItem9_4').val("")
	  	
// 	  	$('#matrl004_inspectItem10_1').val("");
// 	  	$('#matrl004_inspectItem10_2').val("");
// 	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem10_3", "", "2");
// 	  	$('#matrl004_inspectItem10_4').val("")
// 	  	$('#matrl004_inspectItem11_1').val("");
// 	  	$('#matrl004_inspectItem11_2').val("");
// 	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem11_3", "", "2");
// 	  	$('#matrl004_inspectItem11_4').val("")
// 	  	$('#matrl004_inspectItem12_1').val("");
// 	  	$('#matrl004_inspectItem12_2').val("");
// 	  	selectBoxAppend(approvalCheck, "matrl004_inspectItem12_3", "", "2");
// 	  	$('#matrl004_inspectItem12_4').val("")

	  	
	  	$('#matrl004_input1_1').val("");
	  	$('#matrl004_input1_2').val("");
	  	$('#matrl004_input1_3').val("");
	  	$('#matrl004_input1_4').val("0");
	  	$('#matrl004_input1_5').val("0");
	  	$('#matrl004_input1_6').val("0");
	  	$('#matrl004_input1_7').val("0");
	  	$('#matrl004_input1_8').val("0");
	  	$('#matrl004_input1_9').val("0");
	  	$('#matrl004_input1_10').val("");    	
	  	$('#matrl004_input2_1').val("");
	  	$('#matrl004_input2_2').val("");
	  	$('#matrl004_input2_3').val("0");
	  	$('#matrl004_input2_4').val("0");
	  	$('#matrl004_input2_5').val("0");
	  	$('#matrl004_input2_6').val("0");
	  	$('#matrl004_input2_7').val("0");
	  	$('#matrl004_input2_8').val("0");
	  	$('#matrl004_input2_9').val("");     	
// 	  	$('#matrl004_input3_1').val("");
// 	  	$('#matrl004_input3_2').val("");
// 	  	$('#matrl004_input3_3').val("0");
// 	  	$('#matrl004_input3_4').val("0");
// 	  	$('#matrl004_input3_5').val("0");
// 	  	$('#matrl004_input3_6').val("0");
// 	  	$('#matrl004_input3_7').val("0");
// 	  	$('#matrl004_input3_8').val("0");
// 	  	$('#matrl004_input3_9').val("");     	
	  	$('#matrl004_input4_1').val("");
	  	$('#matrl004_input4_2').val("");
	  	$('#matrl004_input4_3').val("");
	  	$('#matrl004_input4_4').val("");
	  	$('#matrl004_input4_5').val("");
	  	$('#matrl004_input4_6').val("");
	  	$('#matrl004_input4_7').val("");
	  	$('#matrl004_input4_8').val("");
	  	$('#matrl004_input4_10').val(""); 
	  	     	
// 	  	$('#matrl004_input5_1').val("");
// 	  	$('#matrl004_input5_2').val("");
// 	  	$('#matrl004_input5_3').val("");
// 	  	$('#matrl004_input5_4').val("");
// 	  	$('#matrl004_input5_5').val("0");
// 	  	$('#matrl004_input5_6').val("0");
// 	  	$('#matrl004_input5_7').val("0");
// 	  	$('#matrl004_input5_8').val("");     	
	  	$('#matrl004_input6_1').val("");
	  	$('#matrl004_input6_2').val("");
	  	$('#matrl004_input6_3').val("");
	  	$('#matrl004_input6_4').val("");
	  	$('#matrl004_input6_5').val("");     	
	  	$('#matrl004_input7_1').val("");
	  	$('#matrl004_input7_2').val("");
	  	$('#matrl004_input7_3').val("");
	  	$('#matrl004_input7_4').val("");
	  	$('#matrl004_input7_5').val("");
	  	  	
// 	  	$('#matrl004_input8_1').val("");
// 	  	$('#matrl004_input8_2').val("");
// 	  	$('#matrl004_input8_3').val("");
// 	  	$('#matrl004_input8_4').val("");
// 	  	$('#matrl004_input8_5').val("");
// 	  	$('#matrl004_input8_6').val("");
// 	  	//$('#matrl004_input8_7').val("");
	  
// 	  	$('#matrl004_input8_18').val("");	            	
// 	  	$('#matrl004_input9_1').val("");
// 	  	$('#matrl004_input9_2').val("");
// 	  	$('#matrl004_input9_3').val("");
// 	  	$('#matrl004_input9_4').val("");
// 	  	$('#matrl004_input9_5').val("");
// 	  	$('#matrl004_input9_6').val("0");
// 	  	$('#matrl004_input9_7').val("0");
// 	  	$('#matrl004_input9_8').val("0");
// 	  	$('#matrl004_input9_9').val("0");
// 	  	$('#matrl004_input9_10').val("0");
// 	  	$('#matrl004_input9_11').val("0");
// 	  	$('#matrl004_input9_12').val("0");
// 	  	$('#matrl004_input9_13').val("0");
// 	  	$('#matrl004_input9_14').val("0");
// 	  	$('#matrl004_input9_15').val("0");
// 	  	$('#matrl004_input9_16').val("0");
// 	  	$('#matrl004_input9_17').val("");
		}

	var matrl001_list_idx = 0;
  
	function matrl001_disabled_list(data ,matrlData){

		$('#realMatrlDate').val(serverDate);

		var inspectHtml = '';
		const inputData = managementCode.filter(item=>item.etc1=='001');
		
		matrl001_list_idx = 0;
		$.each(data, function(index, item){
			if(index==1||index==2||index==3||index==4||index==5||index==14){
				$('#matrl001_inspectItem'+(matrl001_list_idx+1)+'_1').val(item[0]);
				if(item[2]!=undefined&&item[3]!=undefined){
					$('#matrl001_inspectItem'+(matrl001_list_idx+1)+'_2').val(item[1]!=undefined?item[1]+' '+gongcha(item[2],item[3]):'');
				} else {
					$('#matrl001_inspectItem'+(matrl001_list_idx+1)+'_2').val(item[1]!=undefined?item[1]:'');
				}
				let baseCd = '';
				for(var i = 0; i<inputData.length;i++){
					if(inputData[i].baseCdNm==item[0]){
						baseCd = inputData[i].baseCd;
						break;
					}
				}
				$('#matrl001_inspectItem'+(matrl001_list_idx+1)).val(baseCd);                                                       
				matrl001_list_idx++;                                                  
			} else {
				}
		});
 

		let matrl001_select_idx = 0;
		$.each(data, function(index, item){
			selectBoxAppend(approvalCheck, "matrl001_inspectItem"+(matrl001_select_idx+1)+"_3", "001", "");
			$('#matrl001_inspectItem'+(matrl001_select_idx+1)+'_4').val("");      
			matrl001_select_idx++;
		});
		selectBoxAppend(approvalCheck, "matrl001_inspectItem4_3", "001", "");

		$('#matrl001_input1_1').val(data[11][0]);
		$('#matrl001_input1_2').val(data[11][1]);
		$('#matrl001_input1_3').val(data[11][2] + " " + gongcha(data[11][3],data[11][4]));
		$('#matrl001_input2_1').val(data[11][5]);
		$('#matrl001_input2_2').val(data[11][6] + " " + gongcha(data[11][7],data[11][8]));
		$('#matrl001_input3_1').val(data[11][9]);
		$('#matrl001_input3_2').val(data[11][10]!=undefined?data[11][10]:'' + (data[11][11]!=undefined&&data[11][12]!=undefined)?" " + gongcha(data[11][11],data[11][12]):'');
		
		$('#matrl001_input4_1').val(data[12][0]);
		$('#matrl001_input4_2').val(data[12][1]);
		$('#matrl001_input4_3').val(data[12][2]);
		$('#matrl001_input4_4').val(data[12][3]);
		$('#matrl001_input4_5').val(data[12][4]);
		$('#matrl001_input4_6').val(data[12][5]);
		$('#matrlGongcha1').val(data[12][12]!=undefined&&data[12][13]!=undefined?gongcha(data[12][12],data[12][13]):'');		            	
		$('#matrl001_input5_1').val(data[12][8]);
		$('#matrl001_input5_2').val(data[12][9]);
		$('#matrl001_input5_3').val(data[12][10]);
		$('#matrl001_input5_4').val(data[12][11]);
		// $('#matrl001_input5_5').val(data[12][4]);
		
		$('#matrl001_input6_1').val(data[12][14]);
		$('#matrl001_input6_2').val(data[12][15]);
		$('#matrl001_input6_3').val(data[12][16]);
		$('#matrl001_input6_4').val(data[12][17]);
		$('#matrl001_input6_5').val(data[12][18]);
		$('#matrlGongcha2').val(data[12][25]!=undefined&&data[12][26]!=undefined?gongcha(data[12][25],data[12][26]):'');
		
		$('#matrl001_input6_9').val(data[12][21]);
		$('#matrl001_input6_10').val(data[12][22]);
		$('#matrl001_input6_11').val(data[12][23]);
		$('#matrl001_input6_12').val(data[12][24]);
		
		$('#matrl001_input7_1').val(data[12][27]);
		$('#matrl001_input7_2').val(data[12][29]!=undefined&&data[12][30]!=undefined?data[12][28]+" "+gongcha(data[12][29],data[12][30]):data[12][28]);
		
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
		$('#matrlGongcha3').val(data[13][12]!=undefined&&data[13][13]!=undefined?gongcha(data[13][12],data[13][13]):'');
	}
  
	function matrl001_enable_list(data,data2,data3, matrlData){

		$('#realMatrlDate').val(data3[0].inspectDate);

		var inspectHtml = '';
		matrl001_list_idx = 0;
		$.each(data3, function(index, item){
			if(item.matrlGubunCd == "001"){
				let baseNm='';
   				$.each(data, function(idx, item2){
   				    if(idx==1||idx==2||idx==3||idx==4||idx==5||idx==14){
   				        if(data3[index].managementNm==item2[0]){
   	   				        baseNm=item2.length>1?item2[1]:'';
   	   				        return false;
   	   				    }
   				    }
   				});
				$('#matrl001_inspectItem'+(matrl001_list_idx+1)).val(item.managementCd);
				$('#matrl001_inspectItem'+(matrl001_list_idx+1)+'_1').val(item.managementNm);
				$('#matrl001_inspectItem'+(matrl001_list_idx+1)+'_2').val(baseNm);
				$('#matrl001_inspectItem'+(matrl001_list_idx+1)+'_4').val(item.inspectEtc);
                                                    
				matrl001_list_idx++;                                                  
			}
		});
		$.each(data3, function(index, item){
			selectBoxAppend(approvalCheck, "matrl001_inspectItem"+(index+1)+"_3", ""+ item.resultCd +"", "");			
		});		

		$('#matrl001_input1_1').val(data[11][0]);
		$('#matrl001_input1_2').val(data[11][1]);
		$('#matrl001_input1_3').val(data[11][2] + " " + gongcha(data[11][3],data[11][4]));
		$('#matrl001_input2_1').val(data[11][5]);
		$('#matrl001_input2_2').val(data[11][6] + " " + gongcha(data[11][7],data[11][8]));
		$('#matrl001_input3_1').val(data[11][9]);
		$('#matrl001_input3_2').val(data[11][10]!=undefined?data[11][10]:'' + (data[11][11]!=undefined&&data[11][12]!=undefined)?" " + gongcha(data[11][11],data[11][12]):'');
		
		$('#matrl001_input4_1').val(data[12][0]);
		$('#matrl001_input4_2').val(data[12][1]);
		$('#matrl001_input4_3').val(data[12][2]);
		$('#matrl001_input4_4').val(data[12][3]);
		$('#matrl001_input4_5').val(data[12][4]);
		$('#matrl001_input4_6').val(data[12][5]);
		$('#matrlGongcha1').val(data[12][12]!=undefined&&data[12][13]!=undefined?gongcha(data[12][12],data[12][13]):'');		            	
		$('#matrl001_input5_1').val(data[12][8]);
		$('#matrl001_input5_2').val(data[12][9]);
		$('#matrl001_input5_3').val(data[12][10]);
		$('#matrl001_input5_4').val(data[12][11]);
		// $('#matrl001_input5_5').val(data[12][4]);
		
		$('#matrl001_input6_1').val(data[12][14]);
		$('#matrl001_input6_2').val(data[12][15]);
		$('#matrl001_input6_3').val(data[12][16]);
		$('#matrl001_input6_4').val(data[12][17]);
		$('#matrl001_input6_5').val(data[12][18]);
		$('#matrlGongcha2').val(data[12][25]!=undefined&&data[12][26]!=undefined?gongcha(data[12][25],data[12][26]):'');
		
		$('#matrl001_input6_9').val(data[12][21]);
		$('#matrl001_input6_10').val(data[12][22]);
		$('#matrl001_input6_11').val(data[12][23]);
		$('#matrl001_input6_12').val(data[12][24]);
		
		$('#matrl001_input7_1').val(data[12][27]);
		$('#matrl001_input7_2').val(data[12][29]!=undefined&&data[12][30]!=undefined?data[12][28]+" "+gongcha(data[12][29],data[12][30]):data[12][28]);
		
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
		$('#matrlGongcha3').val(data[13][12]!=undefined&&data[13][13]!=undefined?gongcha(data[13][12],data[13][13]):'');
		


		
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
		
		$('#matrl001_input6_14').val(data2[5][11]);
		$('#matrl001_input6_15').val(data2[5][12]); 
		
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


	function matrl001_disabled_list_old(data ,matrlData){

		$('#originMatrlDate').val(serverDate);

		var inspectHtml = '';
		const inputData = managementCode.filter(item=>item.etc1=='001');
		
		matrl001_list_idx = 0;
		$.each(data, function(index, item){
			if(item.length>1 && item[0]!='치수'&&item[0]!='면취'&&item[0]!='내절강도'&&item[0]!=''){
				let baseCd = '';
				
				if(item.length==2){
					for(var i = 0; i<inputData.length;i++){
						if(inputData[i].baseCdNm==item[0]){
							baseCd = inputData[i].baseCd;
							break;
						}
					}
					inspectHtml += '<tr>';
					inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (matrl001_list_idx + 1) + '_1" value="'+item[0]+'" disabled/>';
					inspectHtml += '<input  	type="hidden" id="matrlOld_inspectItem' + (index + 1) + '" value="'+baseCd+'"/> </td>';
					inspectHtml += '<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (matrl001_list_idx + 1) + '_2" value="'+item[1]+'" disabled/></td>';
					inspectHtml += '<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem' + (matrl001_list_idx + 1) + '_3"></select></td>';
					inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (matrl001_list_idx + 1) + '_4" value=""/></td>';			    
					inspectHtml += '</tr>';                                                         
					matrl001_list_idx++;     
				} else {
					for(var i = 0; i<inputData.length;i++){
						if(inputData[i].baseCdNm==item[1]){
							baseCd = inputData[i].baseCd;
							break;
						}
					}
					inspectHtml += '<tr>';
					inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (matrl001_list_idx + 1) + '_1" value="'+item[1]+'" disabled/>';
					inspectHtml += '<input  	type="hidden" id="matrlOld_inspectItem' + (index + 1) + '" value="'+baseCd+'"/> </td>';
					inspectHtml += '<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (matrl001_list_idx + 1) + '_2" value="'+item[2]+'" disabled/></td>';
					inspectHtml += '<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem' + (matrl001_list_idx + 1) + '_3"></select></td>';
					inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (matrl001_list_idx + 1) + '_4" value=""/></td>';			    
					inspectHtml += '</tr>';                                                         
					matrl001_list_idx++;   
				}                                             
			}
		});

		$('#matrlTbody001Origin').html(inspectHtml);
		$.each(managementCode, function(index, item){
			selectBoxAppend(approvalCheck, "matrlOld_inspectItem"+(index+1)+"_3", "001", "");
			$('#matrlOld_inspectItem'+(index+1)+'_4').val("");      
		});
		selectBoxAppend(approvalCheck, "matrlOld_inspectItem4_3", "001", "");

		$('#matrlOld_input1_1').val(data[11][0]);
		$('#matrlOld_input1_2').val(data[11][1]);
		$('#matrlOld_input1_3').val(data[11][2] + " " + gongcha(data[11][3],data[11][4]));
		$('#matrlOld_input2_1').val(data[11][5]);
		$('#matrlOld_input2_2').val(data[11][6] + " " + gongcha(data[11][7],data[11][8]));
		$('#matrlOld_input3_1').val(data[11][9]);
		$('#matrlOld_input3_2').val(data[11][10]);
		
		$('#matrlOld_input4_1').val(data[12][0]);
		$('#matrlOld_input4_2').val(data[12][1]);
		$('#matrlOld_input4_3').val(data[12][2]);
		$('#matrlOld_input4_4').val(data[12][3]);
		$('#matrlOld_input4_5').val(data[12][4]);
		$('#matrlOld_input4_6').val(data[12][5]);		            	
		$('#matrlOld_input5_1').val(data[12][8]);
		$('#matrlOld_input5_2').val(data[12][9]);
		$('#matrlOld_input5_3').val(data[12][10]);
		$('#matrlOld_input5_4').val(data[12][11]);
		// $('#matrlOld_input5_5').val(data[12][4]);
		
		$('#matrlOld_input6_1').val(data[12][14]);
		$('#matrlOld_input6_2').val(data[12][15]);
		
		$('#matrlOld_input7_1').val(data[12][18]);
		$('#matrlOld_input7_2').val(data[12][19]);
		
		$('#matrlOld_input8_1').val(data[13][0]);
		$('#matrlOld_input8_2').val(data[13][1]);
		$('#matrlOld_input8_3').val(data[13][2]);
		$('#matrlOld_input8_4').val(data[13][3]);
		$('#matrlOld_input8_5').val(data[13][4]);
		$('#matrlOld_input8_6').val(data[13][5]);
		
		$('#matrlOld_input9_1').val(data[13][1]);
		$('#matrlOld_input9_2').val(data[13][8]);
		$('#matrlOld_input9_3').val(data[13][9]);
		$('#matrlOld_input9_4').val(data[13][10]);
		$('#matrlOld_input9_5').val(data[13][11]);
	}
  
	function matrl001_enable_list_old(data,data2,data3, matrlData){

		$('#originMatrlDate').val(data3[0].inspectDate);

		var inspectHtml = '';
		matrl001_list_idx = 0;
		$.each(data3, function(index, item){
			if(item.matrlGubunCd == "001"){
				inspectHtml += '<tr>';
				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (index + 1) + '_1" value="'+item.managementNm+'" disabled/>';
				inspectHtml += '<input  	type="hidden" id="matrlOld_inspectItem' + (index + 1) + '" value="'+item.managementCd+'"/> </td>';
				inspectHtml += '<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (index + 1) + '_2" value="'+item.modelNm+'" disabled/></td>';
				inspectHtml += '<td				><select class="custom-select custom-select-sm" id="matrlOld_inspectItem' + (index + 1) + '_3"></select></td>';
				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrlOld_inspectItem' + (index + 1) + '_4" value="'+item.inspectEtc+'"/></td>';			    
				inspectHtml += '</tr>';                                                         
				matrl001_list_idx++;                                                  
			}
		});
		$('#matrlTbody001Origin').html(inspectHtml);
		$.each(data3, function(index, item){
			selectBoxAppend(approvalCheck, "matrlOld_inspectItem"+(index+1)+"_3", ""+ item.resultCd +"", "");			
		});		

		$('#matrlOld_input1_1').val(data[11][0]);
		$('#matrlOld_input1_2').val(data[11][1]);
		$('#matrlOld_input1_3').val(data2[0][2]);
		$('#matrlOld_input2_1').val(data[11][5]);
		$('#matrlOld_input2_2').val(data2[1][1]);
		$('#matrlOld_input3_1').val(data[11][9]);
		$('#matrlOld_input3_2').val(data2[2][1]);
		
		$('#matrlOld_input4_1').val(data[12][0]);
		$('#matrlOld_input4_2').val(data[12][1]);
		$('#matrlOld_input4_3').val(data[12][2]);
		$('#matrlOld_input4_4').val(data[12][3]);
		$('#matrlOld_input4_5').val(data[12][4]);
		$('#matrlOld_input4_6').val(data[12][5]);		            	
		$('#matrlOld_input5_1').val(data[12][8]);
		$('#matrlOld_input5_2').val(data[12][9]);
		$('#matrlOld_input5_3').val(data[12][10]);
		$('#matrlOld_input5_4').val(data[12][11]);
		// $('#matrlOld_input5_5').val(data[12][4]);
		
		$('#matrlOld_input6_1').val(data[12][14]);
		$('#matrlOld_input6_2').val(data[12][15]);
		
		$('#matrlOld_input7_1').val(data[12][18]);
		$('#matrlOld_input7_2').val(data[12][19]);
		
		$('#matrlOld_input8_1').val(data[13][0]);
		$('#matrlOld_input8_2').val(data[13][1]);
		$('#matrlOld_input8_3').val(data[13][2]);
		$('#matrlOld_input8_4').val(data[13][3]);
		$('#matrlOld_input8_5').val(data[13][4]);
		$('#matrlOld_input8_6').val(data[13][5]);
		
		$('#matrlOld_input9_1').val(data[13][1]);
		$('#matrlOld_input9_2').val(data[13][8]);
		$('#matrlOld_input9_3').val(data[13][9]);
		$('#matrlOld_input9_4').val(data[13][10]);
		$('#matrlOld_input9_5').val(data[13][11]);
		


		
		$('#matrlOld_input1_4').val(data2[0][3]);
		$('#matrlOld_input1_5').val(data2[0][4]);
		$('#matrlOld_input1_6').val(data2[0][5]);
		$('#matrlOld_input1_7').val(data2[0][6]);
		$('#matrlOld_input1_8').val(data2[0][7]);
		$('#matrlOld_input1_9').val(data2[0][8]);
		$('#matrlOld_input1_10').val(data2[0][9]); 
		
		$('#matrlOld_input2_3').val(data2[1][2]);
		$('#matrlOld_input2_4').val(data2[1][3]);
		$('#matrlOld_input2_5').val(data2[1][4]);
		$('#matrlOld_input2_6').val(data2[1][5]);
		$('#matrlOld_input2_7').val(data2[1][6]);
		$('#matrlOld_input2_8').val(data2[1][7]);
		$('#matrlOld_input2_9').val(data2[1][8]);     	
		
		$('#matrlOld_input3_3').val(data2[2][2]);
		$('#matrlOld_input3_4').val(data2[2][3]);
		$('#matrlOld_input3_5').val(data2[2][4]);
		$('#matrlOld_input3_6').val(data2[2][5]);
		$('#matrlOld_input3_7').val(data2[2][6]);
		$('#matrlOld_input3_8').val(data2[2][7]);
		$('#matrlOld_input3_9').val(data2[2][8]);     	
		
		$('#matrlOld_input4_10').val(data2[3][9]); 
		
		$('#matrlOld_input5_5').val(data2[4][4]);
		$('#matrlOld_input5_6').val(data2[4][5]);
		$('#matrlOld_input5_7').val(data2[4][6]);
		$('#matrlOld_input5_8').val(data2[4][7]);     
		
		$('#matrlOld_input6_4').val(data2[5][3]);
		$('#matrlOld_input6_5').val(data2[5][4]); 
		
		$('#matrlOld_input7_4').val(data2[6][3]);
		$('#matrlOld_input7_5').val(data2[6][4]);     	
		
		$('#matrlOld_input8_18').val(data2[7][17]);			            	
		
		$('#matrlOld_input9_6').val(data2[8][5]);
		$('#matrlOld_input9_7').val(data2[8][6]);
		$('#matrlOld_input9_8').val(data2[8][7]);
		$('#matrlOld_input9_9').val(data2[8][8]);
		$('#matrlOld_input9_10').val(data2[8][9]);
		$('#matrlOld_input9_11').val(data2[8][10]);
		$('#matrlOld_input9_12').val(data2[8][11]);
		$('#matrlOld_input9_13').val(data2[8][12]);
		$('#matrlOld_input9_14').val(data2[8][13]);
		$('#matrlOld_input9_15').val(data2[8][14]);
		$('#matrlOld_input9_16').val(data2[8][15]);
		$('#matrlOld_input9_17').val(data2[8][16]);
  	
  }
	  
  var matrl002_list_idx = 0;
  
	function matrl002_disabled_list(data ,matrlData){
		$('#rowMatrlDate').val(serverDate);
/* 		$('#matrl002_input1_2').val(data[1][0]);
		$('#matrl002_input1_3').val(data[1][1]);
		$('#matrl002_input2_2').val(data[2][0]);
		$('#matrl002_input2_3').val(data[2][1]);
		$('#matrl002_input3_2').val(data[3][0]);
		$('#matrl002_input3_3').val(data[3][1]);
		$('#matrl002_input4_2').val(data[6][0]);	            		
		$('#matrl002_input4_3').val(data[6][1]);	  
		$('#matrl002_input4_4').val(matrlData.thickness + " " + gongcha(data[6][3],data[6][4]));	  
		$('#matrl002_input5_1').val(data[6][5]);	  
		$('#matrl002_input5_2').val(matrlData.depth + " " + gongcha(data[6][7],data[6][8]));

		if( data[4][0] == '') {
			$('#matrl002_input6_4').attr('disabled', true);
			$('#matrl002_input6_5').attr('disabled', true);
		} else {
			$('#matrl002_input6_2').val(data[4][1]);
			$('#matrl002_input6_3').val(data[4][2]);
			selectBoxAppend(approvalCheck, "matrl002_input6_4", "001", "");
			$('#matrl002_input6_4').attr('disabled', false);
			$('#matrl002_input6_5').attr('disabled', false);
		}
		if( data[5][0] == '') {
			$('#matrl002_input7_4').attr('disabled', true);
			$('#matrl002_input7_5').attr('disabled', true);
		} else {
			$('#matrl002_input7_2').val(data[5][1]);
			$('#matrl002_input7_3').val(data[5][2]);
			selectBoxAppend(approvalCheck, "matrl002_input7_4", "001", "");
			$('#matrl002_input7_4').attr('disabled', false);
			$('#matrl002_input7_5').attr('disabled', false);
		}
		 */

		var inspectHtml = '';
		const inputData = managementCode.filter(item=>item.etc1=='002');
			
		matrl002_list_idx = 0;
		$.each(data, function(index, item){
			if(index==1||index==2||index==3){
				let baseCd = '';
				for(var i = 0; i<inputData.length;i++){
					if(inputData[i].baseCdNm==item[0]){
						baseCd = inputData[i].baseCd;
						break;
					}
				}
				$('#matrl002_input'+(matrl002_list_idx+1)+'_2').val(item[0]);
				$('#matrl002_input'+(matrl002_list_idx+1)+'_3').val(item[1]!=undefined?item[1]:'');
				selectBoxAppend(approvalCheck, "matrl002_input"+(matrl002_list_idx+1)+"_4", "001", "");
				$('#matrl002_input'+(matrl002_list_idx+1)+'_5').val("");     
				$('#matrl002_inspectItem'+(matrl002_list_idx+1)).val(baseCd); 
// 				inspectHtml += '<tr>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_input' + (matrl002_list_idx + 1) + '_1" value="' + (matrl002_list_idx+1) +'" disabled/>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_input' + (matrl002_list_idx + 1) + '_2" value="'+item[0]+'" disabled/>';
// 				inspectHtml += '<input  	type="hidden" id="matrl002_input' + (matrl002_list_idx + 1) + '" value="'+baseCd+'"/> </td>';
// 				inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_input' + (matrl002_list_idx + 1) + '_3" value="'+ item[1]+'" disabled/></td>';
				
			
// 				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl002_input' + (matrl002_list_idx + 1) + '_4"></select></td>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_input' + (matrl002_list_idx + 1) + '_5" value=""/></td>';			    
// 				inspectHtml += '</tr>';                                                         
				matrl002_list_idx++;                                                  
			} else if(index==6){
				let baseCd1 = '';
				let baseCd2 = '';
				for(var i = 0; i<inputData.length;i++){
					if(inputData[i].baseCdNm==item[0]+' '+item[1]){
						baseCd1 = inputData[i].baseCd;
					}
					if(inputData[i].baseCdNm==item[0]+' '+item[5]){
						baseCd2 = inputData[i].baseCd;
						break;
					}
				}
				$('#matrl002_input4_2').val('치수');
				$('#matrl002_input4_3').val(item[1]);
				$('#matrl002_input4_4').val((item[2]!=undefined&&item[2]!='')? item[2]+'mm '+gongcha(item[3],item[4]):'');
				$('#matrl002_input5_1').val(item[5]);
				$('#matrl002_input5_2').val((item[6]!=undefined&&item[6]!='')? item[6]+'mm '+gongcha(item[7],item[8]):'');
				$('#matrl002_inspectItem4').val(baseCd1);
				$('#matrl002_inspectItem5').val(baseCd2);
				selectBoxAppend(approvalCheck, "matrl002_input"+(matrl002_list_idx+1)+"_5", "001", "");
				$('#matrl002_input'+(matrl002_list_idx+1)+'_6').val("");      
				selectBoxAppend(approvalCheck, "matrl002_input"+(matrl002_list_idx+2)+"_3", "001", "");
				$('#matrl002_input'+(matrl002_list_idx+2)+'_4').val("");      
// 				inspectHtml += '<tr>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_1" value="' + (matrl002_list_idx+1) +'" disabled/>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_2" value="'+item[0]+' '+item[1]+'" disabled/>';
// 				inspectHtml += '<input  	type="hidden" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '" value="'+baseCd1+'"/> </td>';
// 				inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_3" value="'+ item[2]+'mm '+gongcha(item[3],item[4])+'" disabled/></td>';
// 				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_4"></select></td>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 1) + '_5" value=""/></td>';			    
// 				inspectHtml += '</tr>';     
				    
// 				inspectHtml += '<tr>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 2) + '_1" value="' + (matrl002_list_idx+2) +'" disabled/>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 2) + '_2" value="'+item[0]+' '+item[5]+'" disabled/>';
// 				inspectHtml += '<input  	type="hidden" id="matrl002_inspectItem' + (matrl002_list_idx + 2) + '" value="'+baseCd2+'"/> </td>';
// 				inspectHtml += '<td colspan="2"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 2) + '_3" value="'+ item[6]+'mm '+gongcha(item[7],item[8])+'" disabled/></td>';
// 				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl002_inspectItem' + (matrl002_list_idx + 2) + '_4"></select></td>';
// 				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl002_inspectItem' + (matrl002_list_idx + 2) + '_5" value=""/></td>';			    
// 				inspectHtml += '</tr>';                                                  
// 				matrl002_list_idx++;
// 				matrl002_list_idx++;   
			}
		});

		//$('#matrlTbody002').html(inspectHtml);

		let matrl002_select_idx = 0;
		$.each(data, function(index, item){

			matrl002_select_idx++;
		});
		//selectBoxAppend(approvalCheck, "matrl002_inspectItem4_3", "001", "");
		
	}
  
	function matrl002_enable_list(data,data2,data3,matrlData){
		$('#rowMatrlDate').val(data3[0].inspectDate);
		var inspectHtml = '';
		let baseNm='';
		
		matrl002_list_idx = 0;
		$.each(data3, function(index, item){
			$('#matrl002_input4_2').val('치수');
			
			if(item.matrlGubunCd == "002"){
				
   				$.each(data, function(idx, item2){
   				    if(idx==1||idx==2||idx==3){
   				        if(data3[index].managementNm==item2[0]){
   	   				        baseNm=item2.length>1?item2[1]:'';
   	   				        return false;
   	   				    }
   				    }
   				});
				if(index<3){
					$('#matrl002_input'+(matrl002_list_idx+1)).val(item.managementCd);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_2').val(item.managementNm);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_3').val(baseNm);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_5').val(item.inspectEtc);
					selectBoxAppend(approvalCheck, "matrl002_input"+(matrl002_list_idx+1)+"_4", item.resultCd, "");	
				} else if(index==3) {
 					baseNm=(data[6][2]!=undefined&&data[6][2]!='')?data[6][2]+' '+gongcha(data[6][3],data[6][4]):'';
					
					$('#matrl002_inspectItem'+(matrl002_list_idx+1)).val(item.managementCd);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_3').val(item.managementNm);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_4').val(baseNm);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_6').val(item.inspectEtc);
					selectBoxAppend(approvalCheck, "matrl002_input"+(matrl002_list_idx+1)+"_5", item.resultCd, "");	
				} else {
 				    baseNm=(data[6][6]!=undefined&&data[6][6]!='')?data[6][6]+' '+gongcha(data[6][7],data[6][8]):'';

					$('#matrl002_inspectItem'+(matrl002_list_idx+1)).val(item.managementCd);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_1').val(item.managementNm);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_2').val(baseNm);
					$('#matrl002_input'+(matrl002_list_idx+1)+'_4').val(item.inspectEtc);
					selectBoxAppend(approvalCheck, "matrl002_input"+(matrl002_list_idx+1)+"_3", item.resultCd, "");	
				}                                                        
				matrl002_list_idx++;
				                                                  
			}
		});
		
	}


	var matrl003_list_idx = 0;
	function matrl003_disabled_list(data ,matrlData){
		$('#procMatrlDate').val(serverDate);
		var inspectHtml = '';

		const inputData = managementCode.filter(item=>item.etc1=='003');
		
		matrl003_list_idx = 0;
		$.each(data, function(index, item){
			if(index>=1&&index<=4){
				let baseCd = '';
				for(var i = 0; i<inputData.length;i++){
					if(inputData[i].baseCdNm==item[0]){
						baseCd = inputData[i].baseCd;
						break;
					}
					if(index==4){
						baseCd = inputData[3].baseCd;
						break;
					}
				}

				if(index!=4){
					$('#matrl003_input'+(matrl003_list_idx+1)+'_2').val(item[0]);
					if(item[2]!=undefined&&item[3]!=undefined){
						$('#matrl003_input'+(matrl003_list_idx+1)+'_3').val(item[1]!=undefined?item[1]+' '+gongcha(item[2],item[3]):'');
					} else {
						$('#matrl003_input'+(matrl003_list_idx+1)+'_3').val(item[1]!=undefined?item[1]:'');
					}
					selectBoxAppend(approvalCheck, "matrl003_input"+(matrl003_list_idx+1)+"_4", "001", "");
					$('#matrl003_input'+(matrl003_list_idx+1)+'_5').val("");
					$('#matrl003_inspectItem'+(matrl003_list_idx+1)).val(baseCd);
				} else {
					$('#matrl003_input4_2').val('치수 폭(mm)');
					$('#matrl003_input4_3').val((item[2]!=undefined&&item[2]!='')?item[2]+' '+gongcha(item[3],item[4]):'');
					selectBoxAppend(approvalCheck, "matrl003_input"+(matrl003_list_idx+1)+"_4", "001", "");
					$('#matrl003_inspectItem'+(matrl003_list_idx+1)).val(baseCd);
				}                                                      
				matrl003_list_idx++;
				                                                  
			}
		});

// 		$.each(data, function(index, item){
// 			selectBoxAppend(approvalCheck, "matrl003_inspectItem"+(index+1)+"_4", item.resultCd , "");	  
// 		});
	}
  
	function matrl003_enable_list(data,data2,data3,matrlData){
		$('#procMatrlDate').val(data3[0].inspectDate);
		var inspectHtml = '';
		let baseNm = '';
		matrl003_list_idx = 0;
		$.each(data3, function(index, item){
			if(item.matrlGubunCd == "003"){
				$.each(data, function(idx, item2){
   				    if(idx==1||idx==2||idx==3){
   				        if(data3[index].managementNm==item2[0]){
   	   				        baseNm=item2.length>1?item2[1]:'';
   	   				        return false;
   	   				    }
   				    } else if(idx==4){
   	   				    baseNm=(item2[2]!=undefined&&item2[2]!='')?item2[2]+gongcha(item2[3],item2[4]):'';
   	   				}
   				});
				$('#matrl003_inspectItem'+(matrl003_list_idx+1)).val(item.managementCd);
				$('#matrl003_input'+(matrl003_list_idx+1)+'_2').val(item.managementNm);
				$('#matrl003_input'+(matrl003_list_idx+1)+'_3').val(baseNm);
				$('#matrl003_input'+(matrl003_list_idx+1)+'_5').val(item.inspectEtc);
				selectBoxAppend(approvalCheck, "matrl003_input"+(matrl003_list_idx+1)+"_4", item.resultCd, "");	                                         
				matrl003_list_idx++;
				                                                  
			}
		});

  }

	var martl004_list_idx = 0;
	function matrl004_disabled_list(data, matrlData){

		$('#filmMatrlDate').val(serverDate);

		var inspectHtml = '';
		const inputData = managementCode.filter(item=>item.etc1=='004');
		
		matrl004_list_idx = 0;
		$.each(data, function(index, item){
			if((index >=1 && index <=5 ) || index==8){
				let baseCd = '';
				for(var i = 0; i<inputData.length;i++){
					if(inputData[i].baseCdNm==item[0]){
						baseCd = inputData[i].baseCd;
						break;
					}
				}			
				let item1 = item.length>1?item[1]:'';
				inspectHtml += '<tr>';
				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem' + (matrl004_list_idx + 1) + '_1" value="'+item[0]+'" disabled/>';
				inspectHtml += '<input  	type="hidden" id="matrl004_inspectItem' + (matrl004_list_idx + 1) + '" value="'+baseCd+'"/> </td>';
				inspectHtml += '<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem' + (matrl004_list_idx + 1) + '_2" value="'+item1+'" disabled/></td>';
				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl004_inspectItem' + (matrl004_list_idx + 1) + '_3" style="min-width:100%;"></select></td>';
				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem' + (matrl004_list_idx + 1) + '_4" value=""/></td>';			    
				inspectHtml += '</tr>';                                                         
				matrl004_list_idx++; 
			}
		})

		$('#matrlTbody004').html(inspectHtml);

		let matrl004_select_idx=0;
		$.each(data, function(index, item){
			if((index >=1 && index <=5 ) || index==8){
				selectBoxAppend(approvalCheck, "matrl004_inspectItem"+(matrl004_select_idx+1)+"_3", "001", "");
				$('#matrl004_inspectItem'+(matrl004_select_idx+1)+'_4').val('');
				matrl004_select_idx++;
			}
		})

		$('#matrl004_input1_1').val(data[6][0]);
		$('#matrl004_input1_2').val(data[6][1]);
		$('#matrl004_input1_3').val(data[6][2]);
		$('#004GC1').val(data[6][3]!=undefined?gongcha(data[6][3],data[6][4]):'');
		$('#matrl004_input2_1').val(data[6][5]);
		$('#matrl004_input2_2').val(data[6][6]);
		$('#004GC2').val(data[6][7]!=undefined?gongcha(data[6][7],data[6][8]):'');
		$('#matrl004_input4_1').val(data[7][0]);
		$('#matrl004_input4_2').val(data[7][1]);
		$('#matrl004_input4_3').val(data[7][2]);
		$('#004GC3').val(data[7][3]!=undefined?gongcha(data[7][3],data[7][4]):'');

		$('#matrl004_input6_1').val(data[7][5]);
		$('#matrl004_input6_2').val(data[7][6]);
		$('#004GC4').val(data[7][7]!=undefined?gongcha(data[7][7],data[7][8]):'');

		$('#matrl004_input7_1').val(data[7][9]);
		$('#matrl004_input7_2').val(data[7][10]);
		$('#004GC5').val(data[7][11]!=undefined?gongcha(data[7][11],data[7][12]):'');

		
	}

	function matrl004_enable_list(data,data2,data3, matrlData){

		$('#filmMatrlDate').val(data3[0].inspectDate);


		var inspectHtml = '';
		matrl004_list_idx = 0;
		$.each(data3, function(index, item){
			if(item.matrlGubunCd == "004"){
				let baseNm='';
				$.each(data, function(idx, item2){
   				    if(idx==1||idx==2||idx==3||idx==4||idx==5||idx==8){
   				        if(data3[index].managementNm==item2[0]){
   	   				        baseNm=item2.length>1?item2[1]:'';
   	   				        return false;
   	   				    }
   				    }
   				});
				inspectHtml += '<tr>';
				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem' + (index + 1) + '_1" value="'+item.managementNm+'" disabled/>';
				inspectHtml += '<input  	type="hidden" id="matrl004_inspectItem' + (index + 1) + '" value="'+item.managementCd+'"/> </td>';
				inspectHtml += '<td colspan="3"	><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem' + (index + 1) + '_2" value="'+baseNm+'" disabled/></td>';
				inspectHtml += '<td				><select class="custom-select custom-select-sm" style="min-width:100%" id="matrl004_inspectItem' + (index + 1) + '_3"></select></td>';
				inspectHtml += '<td				><input class="form-control" style="max-width:100%" 	type="text" id="matrl004_inspectItem' + (index + 1) + '_4" value="'+item.inspectEtc+'"/></td>';			    
				inspectHtml += '</tr>';                                                         
				matrl004_list_idx++;                                                  
			}
		});
		$('#matrlTbody004').html(inspectHtml);
		$.each(data3, function(index, item){
			selectBoxAppend(approvalCheck, "matrl004_inspectItem"+(index+1)+"_3", ""+ item.resultCd +"", "");			
		});		

		$('#matrl004_input1_1').val(data[6][0]);
		$('#matrl004_input1_2').val(data[6][1]);
		$('#matrl004_input1_3').val(data[6][2]);
		$('#004GC1').val(data[6][3]!=undefined?gongcha(data[6][3],data[6][4]):'');
		$('#matrl004_input2_1').val(data[6][5]);
		$('#matrl004_input2_2').val(data[6][6]);
		$('#004GC2').val(data[6][7]!=undefined?gongcha(data[6][7],data[6][8]):'');
		$('#matrl004_input4_1').val(data[7][0]);
		$('#matrl004_input4_2').val(data[7][1]);
		$('#matrl004_input4_3').val(data[7][2]);
		$('#004GC3').val(data[7][3]!=undefined?gongcha(data[7][3],data[7][4]):'');

		$('#matrl004_input6_1').val(data[7][5]);
		$('#matrl004_input6_2').val(data[7][6]);
		$('#004GC4').val(data[7][7]!=undefined?gongcha(data[7][7],data[7][8]):'');

		$('#matrl004_input7_1').val(data[7][9]);
		$('#matrl004_input7_2').val(data[7][10]);
		$('#004GC5').val(data[7][11]!=undefined?gongcha(data[7][11],data[7][12]):'');

		           
                   
                   
		           
		$('#matrl004_input1_4').val(data2[0][3]);
		$('#matrl004_input1_5').val(data2[0][4]);
		$('#matrl004_input1_6').val(data2[0][5]);
		$('#matrl004_input1_7').val(data2[0][6]);
		$('#matrl004_input1_8').val(data2[0][7]);
		$('#matrl004_input1_9').val(data2[0][8]);
		$('#matrl004_input1_10').val(data2[0][9]); 
		           
		$('#matrl004_input2_3').val(data2[1][2]);
		$('#matrl004_input2_4').val(data2[1][3]);
		$('#matrl004_input2_5').val(data2[1][4]);
		$('#matrl004_input2_6').val(data2[1][5]);
		$('#matrl004_input2_7').val(data2[1][6]);
		$('#matrl004_input2_8').val(data2[1][7]);
		$('#matrl004_input2_9').val(data2[1][8]);     	
		           
		$('#matrl004_input3_3').val(data2[2][2]);
		$('#matrl004_input3_4').val(data2[2][3]);
		$('#matrl004_input3_5').val(data2[2][4]);
		$('#matrl004_input3_6').val(data2[2][5]);
		$('#matrl004_input3_7').val(data2[2][6]);
		$('#matrl004_input3_8').val(data2[2][7]);
		$('#matrl004_input3_9').val(data2[2][8]);     	

        $('#matrl004_input4_8').val(data2[3][3]);
		$('#matrl004_input4_10').val(data2[3][4]); 
		           
		$('#matrl004_input5_5').val(data2[4][4]);
		$('#matrl004_input5_6').val(data2[4][5]);
		$('#matrl004_input5_7').val(data2[4][6]);
		$('#matrl004_input5_8').val(data2[4][7]);     
		           
		$('#matrl004_input6_4').val(data2[5][3]);
		$('#matrl004_input6_5').val(data2[5][4]); 
		           
		$('#matrl004_input7_4').val(data2[6][3]);
		$('#matrl004_input7_5').val(data2[6][4]);     	
		           
		$('#matrl004_input8_18').val(data2[7][17]);			            	
		           
		$('#matrl004_input9_6').val(data2[8][5]);
		$('#matrl004_input9_7').val(data2[8][6]);
		$('#matrl004_input9_8').val(data2[8][7]);
		$('#matrl004_input9_9').val(data2[8][8]);
		$('#matrl004_input9_10').val(data2[8][9]);
		$('#matrl004_input9_11').val(data2[8][10]);
		$('#matrl004_input9_12').val(data2[8][11]);
		$('#matrl004_input9_13').val(data2[8][12]);
		$('#matrl004_input9_14').val(data2[8][13]);
		$('#matrl004_input9_15').val(data2[8][14]);
		$('#matrl004_input9_16').val(data2[8][15]);
		$('#matrl004_input9_17').val(data2[8][16]);
  	
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
  
	floatAvg('input1_float','matrl001_input1_4');
	floatAvg('input2_float','matrl001_input2_3');
	floatAvg('input3_float','matrl001_input3_3');
	floatAvg('input5_float','matrl001_input5_5');
	floatAvg('input9_float','matrl001_input9_6');
	floatAvg('input1_float','matrlOld_input1_4');
	floatAvg('input2_float','matrlOld_input2_3');
	floatAvg('input3_float','matrlOld_input3_3');
	floatAvg('input5_float','matrlOld_input5_5');
	floatAvg('input9_float','matrlOld_input9_6');
	floatAvg('input11_float', 'matrl004_input1_4');
	floatAvg('input12_float', 'matrl004_input2_3');
	
	function floatAvg(className,avgResultId){
		$(document).on('keyup','.'+className, function(event) {
			var sum = parseFloat("0");
	 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 43 || event.which == 144 || event.which == 110 ||  event.which == 190)	) {
				$('.'+className).on("blur keyup", function() {
					$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
				});
				toastr.warning('양수(+)만 입력해주세요.');
				$(this).val("0");
				$(this).focus();
				event.preventDefault();
				return false;
			}

	 		//. 존재 여부 확인
	 		if($(this).val().indexOf(".") !== -1) {
		 		//.앞에 숫자 미입력 제한
		 		if($(this).val().length == 1 ){
	 				toastr.warning('숫자 입력후 . 을 입력해 주세요.');
	 				$(this).val("0");
	 				$(this).focus();
		 		}
		 		//.입력 개수 제한
	 			if($(this).val().split(".").length > 2 ){
	 				toastr.warning('. 은 한번만 입력해 주세요.');
	 				$(this).val("0");
	 				$(this).focus();
		 		}
		 		//소수점 자리수 제한
		 		if ($(this).val().split('.')[1].length > 3) {
					toastr.warning('소수점 세자리까지 입력 가능합니다.');
					$(this).val("0");
					$(this).focus();
				}
	 		}

			//0이 아닌 입력개수 세기
	 		var count = 0;
	 		$('.'+className).each(function(){
	 			if ($(this).val() != "0"){
	 				count += 1;
		 		}
	 			sum = parseFloat(sum) + parseFloat($(this).val());
	 		});

	 		//입력값이 모두 0일때 예외처리
	 		if (count=="0"){
	 			$('#'+avgResultId).val("0");
			}
	 		else {
		 		$('#'+avgResultId).val((sum/parseFloat(count)).toFixed(3));
	 		}
		});
	}

	//수입검사관리 수입검사 목록 입력시 예외처리
	//숫자만 입력, 길이, 소수점 한자리까지 제한
	$(document).on('keyup','.number-float2', function(event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
			$('.number-float2').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
	 		$(this).select();
			return false;
		}
 		if ($(this).val() == "00") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
			toastr.warning('최대 크기를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}

 		var _pattern1 = /^\d*[.]\d{3}$/;
        if (_pattern1.test( $(this).val())) {
        	toastr.warning("소수점 둘째 자리까지 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
 			return false;
        }
        
 		if($(this).val().split('.').length >= 3) {
			toastr.warning('소수점기호는 한번만 입력 가능합니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
	});

	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});

	//바코드 인쇄시 인쇄 장수 모달 출력
  	$('#btnPrint').on('click', function() {
  		selectBoxAppend(printCountCheck, "printCountCheck", 2, "");
  		$('#printCheckPopupModal').modal('show');
  		$('#printCountCheck').focus();
    });

  	$('#btnPrintCheck').on('click', function() {	
  		updateMtrlInOutWhsInspectQty("010");
    });

  	$('#btnPrintCancel').on('click', function() {	
  		$('#printCheckPopupModal').modal('hide');
    });

	$('#approvalCd').change(function() {
		
		preInWhsDateCal	=  $('#preInWhsDate').val();
		endDate			=  $('#endDate').val();
		approvalCd		=  $('#approvalCd option:selected').val();
		
		$('#matrlInOutWhsInspectTable').DataTable().ajax.reload( function () {});
    });

	//합격 여부 업데이트
	function updateInspectCd(inspectCd) {
		console.log('approvalCd sudel check : ' + approvalCd);

	 	$.ajax({
            url: '<c:url value="/qm/inspectPassCheck"/>',
            type: 'GET',
            dataType: 'json',
            data : {
                'menuAuth' : menuAuth,
                'inWhsGroupSeq' : function(){return inWhsGroupSeq;}
            },        
            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {
                    // 보기
                    if(data == "create"){
                    	var dataArray = new Array();	
                		
	               	 	 $.each($('#matrlInOutWhsInspectDtlTable tbody tr'),function(idx, itm){
	               	 		var rowData = new Object();			
	               			if($(this).find('td').eq(0).find('input[name=chk]').is(":checked")){				
	               				rowData.inspectCd = inspectCd;			
	               			} else{				
	               				rowData.inspectCd = "";				
	               			}
	               			rowData.inWhsGroupSeq = inWhsGroupSeq;
	               			rowData.lotNo = $(this).find('td').eq(5).text();
	               	
	               			dataArray.push(rowData);
	               		});

	                    $.ajax({
				            url: '<c:url value="/qm/inspectPassCreate"/>',
				            type: 'POST',
				            dataType: 'json',
				            data : JSON.stringify(dataArray),
				            contentType : "application/json; charset=UTF-8",
				            beforeSend: function() {
				              //  $('#btnAddConfirm').addClass('d-none');
				            },
				            success: function (res) {
				                let data = res.data;
				                if (res.result == 'ok') {
				                    // 보기
				                    
				                    $('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {}	);
				                    if(approvalCd ==''){
				                    	toastr.success("처리 되었습니다.");
									}
				                } else {
				                	toastr.error(res.message, '', {timeOut: 5000});
				                }
				            },
				            complete:function() {
				            	
				            }
				        });
                    } else{
                    	var dataArray = new Array();  
                		var checkbox = $("input[name=chk]:checked");             
                		
                		//체크된 체크박스 값을 가져온다
                		checkbox.each(function(i) {
                			var tr = checkbox.parent().parent().eq(i);
                			var td = tr.children();
                			// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
                			var rowData = new Object();                		
                			var lotNo = td.eq(5).text();              			

	               			rowData.inspectCd = inspectCd;	
	               			rowData.inWhsGroupSeq = inWhsGroupSeq;
	               			rowData.lotNo = lotNo;
	               	
	               			dataArray.push(rowData);
	               		});

                       
	                    $.ajax({
				            url: '<c:url value="/qm/inspectPassUpdate"/>',
				            type: 'POST',
				            dataType: 'json',
				            data : JSON.stringify(dataArray),
				            contentType : "application/json; charset=UTF-8",
				            beforeSend: function() {
				              //  $('#btnAddConfirm').addClass('d-none');
				            },
				            success: function (res) {
				                let data = res.data;
				                if (res.result == 'ok') {
				                    // 보기
				                    
				                    $('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {}	);
				                    if(approvalCd ==''){
				                		toastr.success("처리 되었습니다.");
				                    } 
				                } else {
				                	toastr.error(res.message, '', {timeOut: 5000});
				                }
				            },
				            complete:function() {
				            	
				            }
				        });
                    }
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function() {
            	
            }
        });
	}
	
	//자재명 변경감지
    $('#matrlCd').on('change', function() {
    	preInWhsDateCal =  $('#preInWhsDate').val();
		approvalCd =  $('#approvalCd option:selected').val();
		matrlCd =  $('#matrlCd').val();
		$('#matrlInOutWhsInspectTable').DataTable().ajax.reload( function () {});	
		$('#matrlInOutWhsInspectDtlTable').DataTable().clear().draw();
		$("#checkAll").prop("checked",false);
		inWhsGroupSeq='1';	

    });

    function matrlSelectSet(){

    	 $.ajax({
	            url: '<c:url value="/io/inspectMatrlCodeList"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
// 		           	'preInWhsDate'	: function() { return preInWhsDateCal.replace(/-/g, '');	},
		           	'startDate'		: function() { return preInWhsDateCal.replace(/-/g, '');	},
		           	'endDate'		: function() { return endDate.replace(/-/g, ''); 			},
		           	'approvalCd'	: function() { return approvalCd; 							},		  
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
	                    //selectBoxAppend(matrlCdList, "matrlCd", "", "1");
	                    selectBoxAppend_NameAdd(matrlCdList, "matrlCd", "", "1", "자재");
	                } else {
	               	 toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            }
	      });


    }

    let inspectQty;
    let barcodeNo;
    $(document).on('keypress','input[name=inspectQty]',function (e) {
		//엔터키
    	if (e.which == 13){
			//toastr.warning($(this).val());
			$('#my-spinner').show();
			inspectQty = $(this).val();
			barcodeNo = $(this).closest('tr').find('td').eq(9).html();
			$.ajax({
				url: '<c:url value="/qm/inspectQtyUpdate"/>',
				type: 'POST',
				data: {
					//'menuAuth'		: 	menuAuth,
					'barcodeNo'		: 	function() { return barcodeNo; },
					'inWhsQty'          :   function() { return inspectQty; },
 					'inspectQty'		: 	function() { return inspectQty; },
 					'remainQty'		: 	function() { return inspectQty; },
				}, 
				
				success: function (res) {
					let result = res.result;
					if (res.result == 'ok') {
						toastr.success("입고량이 변경되었습니다.");
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				 },
				complete:function(){
					//matrlCd='';
        			//inWhsGroupSeq='1';	
        			if($('#matrlCd option:selected').val() == ''){
        				matrlCd=''
            		}
					$('#matrlInOutWhsInspectTable').DataTable().ajax.reload(function (){
						$('#'+matrlInOutWhsInspectSelectId).click();
            			$('#'+matrlInOutWhsInspectSelectId).addClass('selected');	
						
					});
					$('#matrlInOutWhsInspectDtlTable').DataTable().ajax.reload( function () {});
					$('#my-spinner').hide();
				 }
			});

    		
    	}
    });

    /*
	let labelArray = new Array();
	var paperSize = null;
	var printCnt = null;
	var printOrder = null;
	var printCnt = 1;
	var printVer = "";
	var printNo = "1";
	var strPrintText = [""];
*/
    let printCnt = 1;
    let printLalCnt = 1;
    
  	//Do printing...
	function labelPrint(printList) {
		printLalCnt = printList.length;		//몇 장 출력 하는지
		printCnt	= printLalCnt;
		printNo 	= "0";
		
		// 0 제품이름 - 1 생산전표번호 - 2 생산전표수량
		sendJson(printList);
	}
	function sendJson(printList) {
		var obj = {
			printCnt 	: printCnt,
            printLalCnt : printLalCnt,
            data 		: printList,
            paperSize 	: "materialLabel",
            printOrder 	: 1,
            company 	: "MTP2",
            printType 	: "C",
            printNo 	: "0",
            reseverd6 	: "",
            reseverd7 	: ""
		};
		var send = JSON.stringify(obj);
		//console.log(send);
		sendMessage(send)
	}
	/*
	
	//Do printing...
	function labelPrint(printList) {	
		// 0 제품코드 - 1 lotNo - 2 바코드 - 3 제품사양 - 4 중량 - 5 체크1(출력) - 6 딜레이시간
	    sendJson(printList);
	}
	function sendJson(printList) {
		var obj = {
				printCnt : printList.length,
				printLalCnt : 0,
				data : printList,
				paperSize : "100_20",
				printOrder : 0,
				company : "SLD",
				reseverd4 : "",
				reseverd5 : "",
				reseverd6 : "",
				reseverd7 : ""
		};
	
		
		var send = JSON.stringify(obj);
		sendMessage(send);
	
		printCnt = 1;
		labelArray = [];
		printVer = "";
		printNo = "1";
		paperSize = "";
	}
	*/
	
	var webSocket;
	if (factoryCode == "002") {
		//웹 서버를 접속한다.
		webSocket = new WebSocket("ws://localhost:8181");
		// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
		var messageTextArea = document.getElementById("installedPrinterName");
	}
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		if (factoryCode == "002") {
			toastr.success('인쇄 서버에 연결되었습니다.')
			$('#wsStateView').text('연결됨');
			$('#wsStateView').css('color','#19FF00');
		}
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		if (factoryCode == "002") {
			toastr.error('인쇄 서버가 종료되었습니다.')
			$('#wsStateView').text('연결끊김');
			$('#wsStateView').css('color','#FF0004');
		}
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		if (factoryCode == "002") {
			toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
		}
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		if (factoryCode == "002") {
			if(message.data == "이 문자열이 보이면 성공!") {
				toastr.success("라벨이 발행되었습니다.");
			} else {
				toastr.warning("오류가 발생하였습니다.");
			}
		}
	};
	// 서버로 메시지를 전송하는 함수
	function sendMessage(cmd){
		if(webSocket.readyState == 1) {
			webSocket.send(cmd);
		} else {
			toastr.error('인쇄 서버와의 연결을 확인해주세요.');
			//webSocket = new WebSocket("ws://localhost:9998");
		}
	}

</script>
</body>
</html>
