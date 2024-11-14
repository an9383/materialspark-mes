<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>


<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">

	<!-- 저장 여부 모달 -->
	<div class="modal fade" id="saveBtnModal" tabindex="-1" role="dialog" aria-labelledby="saveBtnModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="saveBtnModalLabel">주의</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<h6>입력하던 정보가 있습니다. 입력을 그만두시겠습니까?</h6> 
	      </div>
	      <div class="modal-footer">
	     	<button type="button" class="btn btn-danger" id="btnDeleteConfirm">삭제</button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 저장 여부 모달 종료 -->

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">기타관리</a></li>
				<li class="breadcrumb-item active">고객클레임</li>
			</ol>
		</nav>
	</header>

	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">

			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list"
				style="width: 59%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<div class="table-responsive">
						<table id="custCmplnAdmTable" class="table table-bordered">
<%-- 							<colgroup> --%>
<%-- 								<col width="20%"> --%>
<%-- 							</colgroup> --%>
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>접수일</th>
									<th>제품명/모델명</th>
									<th>Serial No</th>
									<th>제조일</th>
									<th>고객명</th>
									<th>고객확인 및 의뢰사항</th>
<!-- 									<th>불량확인날짜</th>
									<th>당사과실유무</th>
									<th>유/무상</th>
									<th>고객확인</th>
									<th>완료여부</th> -->
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
				<!--                       <button type="button" class="btn btn-success float-right">Excel</button> -->
			</div>
			<!-- /.left-list -->

			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 40%;">
				<div class="card" id="formBox">

					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand"
								class="closebtn float-right" onclick="closerNav()"><i
								class="mdi mdi-close"></i></a>
						</div>
						<div class="card-header card-tab p-0 mb-2">
							<ul class="nav nav-tabs card-header-tabs m-0">
								<li class="nav-item"><a class="nav-link active show"
									id="tab1Nav" data-toggle="tab" href="#tab1">내역등록</a></li>
								<li class="nav-item"><a class="nav-link disabled d-none"
									id="tab2Nav" data-toggle="tab" href="#tab2">검토부서(품질)</a></li>
								<li class="nav-item"><a class="nav-link disabled d-none"
									id="tab3Nav" data-toggle="tab" href="#tab3">검토부서(영업)</a></li>
								<li class="nav-item"><a class="nav-link disabled d-none"
									id="tab4Nav" data-toggle="tab" href="#tab4">검토부서(생산)</a></li>
								<li class="nav-item"><a class="nav-link disabled d-none"
									id="tab5Nav" data-toggle="tab" href="#tab5">재발방지(품질)</a></li>
							</ul>
						</div>
					</div>

					<div class="card-body p-0">
						<div id="myTabContent" class="tab-content">
							<!--========tab1 part=====-->
							<div class="tab-pane fade active show" id="tab1">
								<div class="card-body col-sm-12 p-1 mb-2">
									<button type="button" class="btn btn-primary float-right"
										id="btnEdit">수정</button>
									<button class="btn btn-warning d-none"
										id="btnEditConfirmLoading" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
									<button type="button" class="btn btn-primary float-right mr-1"
										id="btnAdd">등록</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
								<form id="form" enctype="multipart/form-data">
									<div class="table-responsive">
										<table class="table table-bordered" id="">
											<colgroup>
												<col width="20%">
												<col width="30%">
												<col width="20%">
												<col width="30%">
											</colgroup>
											<tr>
												<th>접수일</th>
												<td><input type="date" class="form-control" id="cmplnDate"
													name="cmplnDate" style="max-width: 100%"></td>
												<th>접수자</th>
												<td>
													<div class="input-sub m-0" style="width: 100%;">
													<input type="text" class="form-control" name="rcvChargr" id="rcvChargr" disabled>
													<button type="button" class="btn btn-primary input-sub-search" id="btnRcvChargr" onClick="selectCust();">
													<span class="oi oi-magnifying-glass"></span>
													</button>
													</div>
												</td>
											</tr>
											<tr>
												<th>제품명/모델명</th>
												<td>
													<div class="input-sub m-0" style="width: 100%;">
													<input type="text" class="form-control" name="itemCd" id="itemCd" disabled>
													<button type="button" class="btn btn-primary input-sub-search" id="btnItemCd" onClick="selectProductName();">
													<span class="oi oi-magnifying-glass"></span>
													</button>
													</div>
												</td>
												<th>Serial No</th>
												<td><input type="text" class="form-control"id="itemRev"
													 name="itemRev" maxlength="25" style="max-width: 100%" disabled></td>
											</tr>
											<tr>
												<th>제조일</th>
												<td><input type="date" class="form-control" id="mfcDate"
													name="mfcDate" maxlength="32" style="max-width: 100%"></td>
												<th>고객명</th>
												<td><input type="text" class="form-control" id="custNm"
													name="custNm" maxlength="10" style="max-width: 100%"></td>
											</tr>
											<tr>
												<th>업체담당자</th>
												<td><input type="text" class="form-control"
													id="coChargr" name="coChargr" maxlength="10"
													style="max-width: 100%"></td>
												<th>업체이메일</th>
												<td><input type="text" class="form-control"
													id="coChargrMail" name="coChargrMail" maxlength="128"
													style="max-width: 100%"></td>
											</tr>
											<tr>
												<th>불량확인서</th><!-- faultyCheckFn -->
												<td>
												<div class="row">
													<div class="custom-file d-none" id="fileSearch1" style="width: 83%;">
														<input type="file" class="custom-file-input" id="fileNm1" name="fileNm1" value="">
														 <label class="custom-file-label" id="fpValue1" for="fileNm1">파일을 선택해주세요</label>
													</div>

													<div class="rightsidebar-close d-none" id="btnFpFileDel1"
														style="width: 10%;">
														<button type="button" class="btn"
															onClick="fileDelete()">
															<i class="mdi mdi-close"></i>
														</button>
													</div>
													
												</div> <!--첨부파일1-->
												<div class="form-group m-0 mr-2 row p-0 " id="fileTag1">
													<a href="#" id="fpHref1"><span id="fpFn1"></span></a>
												</div>
											</td>
												<th>완료요청일</th>
												<td><input type="date" class="form-control"
													id="complReqDate" name="complReqDate" maxlength="56"
													style="max-width: 100%"></td>
											</tr>
											<tr>
												<th>고객확인 및 의뢰사항</th>
												<td colspan="3">
													<textarea class="form-control" id="custConfirmCont"
													 name="custConfirmCont" style="max-width: 100%; resize: none;"></textarea>
												 </td>
											</tr>
											<tr>
												<th>고객요구사항</th>
												<td colspan="3">
													<textarea class="form-control" id="custReqCont"
													 name="custReqCont" style="max-width: 100%; resize: none;"></textarea>
												</td>
											</tr>
										</table>
									</div>
								</form>
								<div class="mt-2">
									<button type="button"
										class="btn btn-primary d-none float-right" id="btnSave">저장</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
							</div>
							<!-- 검토부서(품질) ReviewqualityTable -->
							<%-- <div class="tab-pane fade" id="tab2">
								<div class="card-body col-sm-12 p-1 mb-2">
<!-- 									<button type="button" class="btn btn-primary float-right" -->
<!-- 										id="btnEdit2">수정</button> -->
<!-- 									<button class="btn btn-warning d-none" -->
<!-- 										id="btnEditConfirmLoading2" type="button" disabled> -->
<!-- 										<span class="spinner-border spinner-border-sm" role="status" -->
<!-- 											aria-hidden="true"></span> 처리중 -->
<!-- 									</button> -->
									<button type="button" class="btn btn-primary float-right mr-1"
										id="btnAdd2">수정</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading2" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
								<form id="form2" enctype="multipart/form-data">
									<div class="table-responsive">
										<table class="table table-bordered" id="ReviewqualityTable">
											<colgroup>
												<col width="20%">
												<col width="30%">
												<col width="20%">
												<col width="30%">
											</colgroup>
											<thead>
												<tr>
													<th>불량확인일자</th>
													<td><input type="date" class="form-control" id="faultyRheckDate"
														name="faultyRheckDate" style="max-width: 100%"></td>
													<th>불량확인자</th>
													<td>
														<div class="input-sub m-0" style="width: 100%;">
															<input type="text" class="form-control" name="faultyCheckChargr" id="faultyCheckChargr">
															<button type="button" class="btn btn-primary input-sub-search" id="btnFaultyCheckChargr" onClick="selectBadCheck();">
																<span class="oi oi-magnifying-glass"></span>
															</button>
														</div>
													</td>
												</tr>
												<tr>
													<th>당사과실유무</th>
													<td>
														<select class="custom-select" id="coErrorYn" name="coErrorYn" style="max-width: 100%">
															<option value="">선택</option>
															<option value="O">O</option>
															<option value="X">X</option>
															<option value="무">무</option>
															
														</select>
													</td>
													<th>검사경과일</th>
													<td><input type="text" class="form-control"
														id="inspectPassDate" name="inspectPassDate" maxlength="7"
														style="max-width: 100%"></td>
												</tr>
												<tr>
													<th>불량확인내용</th>
													<td colspan="3">
														<textarea class="form-control" id="faultyCheckCont"
														 name="faultyCheckCont" style="max-width: 100%; resize: none;"></textarea>
													</td>
												</tr>
											</thead>
										</table>
									</div>
								</form>
								<div class="mt-2">
									<button type="button"
										class="btn btn-primary d-none float-right" id="btnSave2">저장</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
							</div> --%>
							<!-- 검토부서(품질) -->
							<!-- 검토부서(영업) ReviewSalesTable -->
							<%-- <div class="tab-pane fade" id="tab3">
								<div class="card-body col-sm-12 p-1 mb-2">
<!-- 									<button type="button" class="btn btn-primary float-right" -->
<!-- 										id="btnEdit3">수정</button> -->
<!-- 									<button class="btn btn-warning d-none" -->
<!-- 										id="btnEditConfirmLoading3" type="button" disabled> -->
<!-- 										<span class="spinner-border spinner-border-sm" role="status" -->
<!-- 											aria-hidden="true"></span> 처리중 -->
<!-- 									</button> -->
									<button type="button" class="btn btn-primary float-right mr-1"
										id="btnAdd3">수정</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading3" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
								<form id="form3" enctype="multipart/form-data">
									<div class="table-responsive">
										<table class="table table-bordered" id="ReviewSalesTable">
											<colgroup>
												<col width="20%">
												<col width="30%">
												<col width="20%">
												<col width="30%">
											</colgroup>
											<thead>
												<tr>
													<th>검토일자</th>
													<td><input type="date" class="form-control"
														id="reviewDate" maxlength="56"
														name="reviewDate" style="max-width: 100%"></td>
													<th>검토확인자</th>
													<td>
														<div class="input-sub m-0" style="width: 100%;">
															<input type="text" class="form-control" name="reviewChargr" id="reviewChargr">
															<button type="button" class="btn btn-primary input-sub-search" id="btnReviewChargr" onClick="selectReview();">
																<span class="oi oi-magnifying-glass"></span>
															</button>
														</div>
													</td>
												</tr>
												<tr>
													<th>유/무상</th>
													<td>
														<select class="custom-select" id="chargeYn" name="chargeYn" style="max-width: 100%">
															<option value="">선택</option>
															<option value="1">유상</option>
															<option value="2">무상</option>
														</select>
													</td>
													<th>고객확인</th>
													<td>
														<select class="custom-select" id="custCheck" name="custCheck" style="max-width: 100%">
															<option value="">선택</option>
															<option value="1">완료</option>
														</select>
													</td>
												</tr>
												<tr>
													<th>의뢰후 납품경과</th>
													<td><input type="text" class="form-control"
														id="paymentProg" name="paymentProg" maxlength="56"
														style="max-width: 100%"></td>
													<th>완료여부</th>
													<td><input type="text" class="form-control"
														id="confirmYn" name="confirmYn" maxlength="7"
														style="max-width: 100%"></td>
												</tr>
												<tr>
													<th>협의내용</th>
													<td colspan="3">
														<textarea class="form-control" id="consultCont"
														 name="consultCont" style="max-width: 100%; resize: none;"></textarea>
													</td>
												</tr>
											</thead>
										</table>
									</div>
								</form>
								<div class="mt-2">
									<button type="button"
										class="btn btn-primary d-none float-right" id="btnSave3">저장</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
							</div> --%>
							<!-- 검토부서(영업) -->
							<!-- 검토부서(생산) ReviewqualityTable -->
							<%-- <div class="tab-pane fade" id="tab4">
								<div class="card-body col-sm-12 p-1 mb-2">
									<button type="button" class="btn btn-primary float-right mr-1"
										id="btnAdd4">수정</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading4" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
								<form id="form4" enctype="multipart/form-data">
									<div class="table-responsive">
										<table class="table table-bordered" id="">
											<colgroup>
												<col width="20%">
												<col width="30%">
												<col width="20%">
												<col width="30%">
											</colgroup>
											<tr>
												<th>생산접수일</th>
												<td><input type="date" class="form-control" id="prodDate"
													name="prodDate" style="max-width: 100%"></td>
												<th>생산접수자</th>
												<td>
													<div class="input-sub m-0" style="width: 100%;">
													<input type="text" class="form-control" name="prodChargr" id="prodChargr" disabled>
													<button type="button" class="btn btn-primary input-sub-search" id="btnProdChargr" onClick="selectCust();">
													<span class="oi oi-magnifying-glass"></span>
													</button>
													</div>
												</td>
											</tr>
											<tr>
												<th>제품명/모델명</th>
												<td>
													<div class="input-sub m-0" style="width: 100%;">
													<input type="text" class="form-control" name="itemProdCd" id="itemProdCd" disabled>
													<button type="button" class="btn btn-primary input-sub-search" id="btnItemProdCd" onClick="selectProductName();">
													<span class="oi oi-magnifying-glass"></span>
													</button>
													</div>
												</td>
												<th>Serial No</th>
												<td><input type="text" class="form-control"id="itemProdRev"
													 name="itemProdRev" maxlength="25" style="max-width: 100%" disabled></td>
											</tr>
											<tr>
												<th>생산제조일</th>
												<td><input type="date" class="form-control" id="mfcProdDate"
													name="mfcProdDate" maxlength="32" style="max-width: 100%"></td>
												<th>고객명</th>
												<td><input type="text" class="form-control" id="prodNm"
													name="prodNm" maxlength="32" style="max-width: 100%"></td>
											</tr>
											<tr>
												<th>생산업체담당자</th>
												<td><input type="text" class="form-control"
													id="coProdChargr" name="coProdChargr" maxlength="56"
													style="max-width: 100%"></td>
												<th>생산업체이메일</th>
												<td><input type="text" class="form-control"
													id="coProdChargrMail" name="prodChargrMail" maxlength="56"
													style="max-width: 100%"></td>
											</tr>
											<tr>
												<th>생산 불량확인서</th><!-- faultyCheckFn -->
												<td>
												<div class="row">
													<div class="custom-file d-none" id="fileSearch4" style="width: 83%;">
														<input type="file" class="custom-file-input" id="fileNm4" name="fileNm4" value="">
														 <label class="custom-file-label" id="fpValue4" for="fileNm4">파일을 선택해주세요</label>
													</div>
	
													<div class="rightsidebar-close d-none" id="btnFpFileDel4"
														style="width: 10%;">
														<button type="button" class="btn"
															onClick="fileDelete4()">
															<i class="mdi mdi-close"></i>
														</button>
													</div>
													
												</div> <!--첨부파일4-->
												<div class="form-group m-0 mr-2 row p-0 " id="fileTag4">
													<a href="#" id="fpHref4"><span id="fpFn4"></span></a>
												</div>
											</td>
												<th>생산완료요청일</th>
												<td><input type="date" class="form-control"
													id="prodReqDate" name="prodReqDate" maxlength="56"
													style="max-width: 100%"></td>
											</tr>
											<tr>
												<th>고객확인 및 의뢰사항</th>
												<td colspan="3">
													<textarea class="form-control" id="prodConfirmCont"
													 name="prodConfirmCont" style="max-width: 100%; resize: none;"></textarea>
												 </td>
											</tr>
											<tr>
												<th>고객요구사항</th>
												<td colspan="3">
													<textarea class="form-control" id="prodReqCont"
													 name="prodReqCont" style="max-width: 100%; resize: none;"></textarea>
												</td>
											</tr>
										</table>
									</div>
								</form>
								<div class="mt-2">
									<button type="button"
										class="btn btn-primary d-none float-right" id="btnSave4">저장</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
							</div> --%>
							<!-- 검토부서(생산) -->
							<!-- 재발방지(품질) RelapsequalityTable -->
							<%-- <div class="tab-pane fade" id="tab5">
								<div class="card-body col-sm-12 p-1 mb-2">
<!-- 									<button type="button" class="btn btn-primary float-right" -->
<!-- 										id="btnEdit5">수정</button> -->
<!-- 									<button class="btn btn-warning d-none" -->
<!-- 										id="btnEditConfirmLoading4" type="button" disabled> -->
<!-- 										<span class="spinner-border spinner-border-sm" role="status" -->
<!-- 											aria-hidden="true"></span> 처리중 -->
<!-- 									</button> -->
									<button type="button" class="btn btn-primary float-right mr-1"
										id="btnAdd5">수정</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading5" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
								<form id="form5" enctype="multipart/form-data">
									<div class="table-responsive">
										<table class="table table-bordered" id="RelapsequalityTable">
											<colgroup>
												<col width="20%">
												<col width="30%">
												<col width="20%">
												<col width="30%">
											</colgroup>
											<thead>
												<tr>
													<th>귀책부서</th>
													<td>
														<div class="input-sub m-0" style="width: 100%;">
															<input type="text" class="form-control" name="faultyDept" id="faultyDept">
															<button type="button" class="btn btn-primary input-sub-search" id="btnFaultyDept" onClick="selectInspectDept();">
																<span class="oi oi-magnifying-glass"></span>
															</button>
														</div>
													</td>
													<th>시정조치요구일</th>
													<td><input type="date" class="form-control"
														id="caReqDate" name="caReqDate" maxlength="56"
														style="max-width: 100%"></td>
												</tr>
												<tr>
													<th>시정조치수신일</th>
													<td><input type="date" class="form-control"
														id="caRecepDate" name="caRecepDate" maxlength="56"
														style="max-width: 100%"></td>
													<th>만족여부</th>
													<td>
														<select class="custom-select" id="satisfyYn"
														name="satisfyYn" style="max-width: 100%">
															<option value="">선택</option>
															<option value="1">만족</option>
															<option value="2">불만족</option>
														</select>
													</td>
												</tr>
												<tr>
													<th>대책서</th><!-- caPlan -->
													<td colspan="3">
														<div class="row">
															<div class="custom-file d-none" id="fileSearch2" style="width: 90%;">
																<input type="file" class="custom-file-input" id="fileNm2" name="fileNm2" value="">
																 <label class="custom-file-label" id="fpValue2" for="fileNm2">파일을 선택해주세요</label>
															</div>
			
															<div class="rightsidebar-close d-none" id="btnFpFileDel2"
																style="width: 10%;">
																<button type="button" class="btn"
																	onClick="fileDelete2()">
																	<i class="mdi mdi-close"></i>
																</button>
															</div>
															
														</div> <!--첨부파일2-->
														<div class="form-group m-0 mr-2 row p-0 " id="fileTag2">
															<a href="#" id="fpHref2"><span id="fpFn2"></span></a>
														</div>
													</td>
												</tr>
												<tr>
													<th>시정조치No</th><!-- caNo -->
													<td colspan="3">
														<div class="row">
															<div class="custom-file d-none" id="fileSearch3" style="width: 90%;">
																<input type="file" class="custom-file-input" id="fileNm3" name="fileNm3" value="">
																 <label class="custom-file-label" id="fpValue3" for="fileNm3">파일을 선택해주세요</label>
															</div>
			
															<div class="rightsidebar-close d-none" id="btnFpFileDel3"
																style="width: 10%;">
																<button type="button" class="btn"
																	onClick="fileDelete3()">
																	<i class="mdi mdi-close"></i>
																</button>
															</div>
															
														</div> <!--첨부파일3-->
														<div class="form-group m-0 mr-2 row p-0 " id="fileTag3">
															<a href="#" id="fpHref3"><span id="fpFn3"></span></a>
														</div>
													</td>
												</tr>
												<tr>
													<th>시정조치내용</th>
													<td colspan="3">
														<textarea class="form-control" id="caNoCont"
														 name="caNoCont" style="max-width: 100%; resize: none;"></textarea>
													</td>
												</tr>
											</thead>
										</table>
									</div>
								</form>
								<div class="mt-2">
									<button type="button"
										class="btn btn-primary d-none float-right" id="btnSave5">저장</button>
									<button class="btn btn-primary d-none"
										id="btnAddConfirmLoading" type="button" disabled>
										<span class="spinner-border spinner-border-sm" role="status"
											aria-hidden="true"></span> 처리중
									</button>
								</div>
							</div> --%>
							<!-- 재발방지(품질) -->
						</div>
					</div>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->


<%@include file="../layout/bottom.jsp" %>

<script>
	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "59%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}

		state = !state;
	});

	let currentHref = "bssc0090";
	let currentPage = $('.' + currentHref).attr('id');

	$('#' + currentPage).closest('.has-child', 'li').addClass(
			'has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","고객클레임"); 
	
	let sideView = 'add';
	var tableIdx = 0;
	let btnView = '';
	let activeButton = '';
	var serverDateFrom = "${serverDateFrom}";
	var serverDateTo = "${serverDateTo}";
	var serverDate = "${serverDate}";
	var rcvDateOutFromCal = serverDateFrom;
	var rcvDateOutToCal = serverDateTo;
	var custNo='';
	var tableIdx2;
	var faultyCheckFn = ''; 

	uiProc(true);
	/* uiProc2(true);
	uiProc3(true);
	uiProc4(true);
	uiProc5(true); */
	btnUiProc(true);
	
	// 목록
	let custCmplnAdmTable = $('#custCmplnAdmTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : false,
		ordering : true,
		processing : true,
		autoWidth : false,
		scrollX : false,
		lengthChange : true,
		pageLength : 20,
		ajax : {
			url : '<c:url value="bs/custCmplnAdmList"/>',
			type : 'GET',
			data : {
				'startDate' : function(){return rcvDateOutFromCal.replace(/-/g,"");},
				'endDate' : function(){return rcvDateOutToCal.replace(/-/g,"")+1;} 
			},
		},
		rowId : 'goodsCd',
		columns : [ 
			{ data : 'cmplnDate'		},	//접수일
			{ data : 'itemCd'			},	//제품명/모델명(제품번호)
			{ data : 'itemRev'			},	//serlalNo(리비전)
			{ data : 'mfcDate'			},	//제조일
			{ data : 'custNm'			},	//고객명
			{ data : 'custConfirmCont'	},	//고객확인 및 의뢰사항
/*			{ data : 'faultyRheckDate'	},	//불량확인 날짜
			{ data : 'coErrorYn'		},	//당사과실유무
			{name: '유/무상',
            	render: function(data, type, row) {
            		var rtn='';
	            	if(row['chargeYn']==''||row['chargeYn']==null){
	            		rtn='';
	            	}else if(row['chargeYn']==1){
	            		rtn='유상';
	            	}else{
	            		rtn='무상';
		            }
            		return rtn;
            	}
            },
			{name: '고객확인',
            	render: function(data, type, row) {
            		var rtn='';
            		row['custCheck']==''||row['custCheck']==null?rtn='':rtn='완료';
            		return rtn;
            	}
            },
			{ data : 'confirmYn'		},	//완료여부 */
		],
		order : [ [ 0, 'asc' ] ],
		buttons : [ 'copy', {
			extend : 'excel',
			title : '고객불만등록'
		}, 'print' ],
	});
	
	// 보기
	$('#custCmplnAdmTable tbody').on('click','tr',function() {
// 		$('#tab1Nav').tab('show');
	
		if ($('#btnSave').attr('class') == 'btn btn-primary float-right') {
			$('#saveBtnModal').modal('show');

//			$('#saveBtnModalY').on('click', function() {
//				activeButton = '';
				$('#btnDeleteConfirm').on('click', function() {
					uiProc(true);
					btnUiProc(true);
					$('#btnSave').addClass('d-none'); //저장버튼
					$('#btnEdit').attr('disabled', false); // 수정버튼
					$('#tab1Nav').removeClass('disabled');
					$('#custCmplnAdmTable').DataTable().ajax.reload();
					$('#form').each(function() {
						this.reset();
					});
					$('#tab1Nav').tab('show');
					$('#fileSearch1').addClass('d-none');
					$('#btnFpFileDel1').addClass('d-none');
					$('#fileTag1').removeClass('d-none');
//	 				$('#fpHref1').text('');
					$('#tab1Nav').tab('show');
					$('#saveBtnModal').modal('hide');
				})
				
//			});

			return false;
		}

/* 		if ($('#btnSave2').attr('class') == 'btn btn-primary float-right') {
			$('#saveBtnModal').modal('show');

			$('#saveBtnModalY').on('click', function() {
				uiProc2(true);
				btnUiProc(true);
				$('#btnSave2').addClass('d-none'); //저장버튼
				$('#tab1Nav').removeClass('disabled');
				$('#custCmplnAdmTable').DataTable().ajax.reload();
				$('#form').each(function() {
					this.reset();
				});
				$('#tab1Nav').tab('show');
				tabNav();
			});
			return false;
		}

		if ($('#btnSave3').attr('class') == 'btn btn-primary float-right') {
			$('#saveBtnModal').modal('show');

			$('#saveBtnModalY').on('click', function() {
				uiProc3(true);
				btnUiProc(true);
				$('#btnSave3').addClass('d-none'); //저장버튼
				$('#tab1Nav').removeClass('disabled');
				$('#custCmplnAdmTable').DataTable().ajax.reload();
				$('#form').each(function() {
					this.reset();
				});
				$('#tab1Nav').tab('show');
				tabNav();
			});
			return false;
		}

		if ($('#btnSave4').attr('class') == 'btn btn-primary float-right') {
			$('#saveBtnModal').modal('show');

			$('#saveBtnModalY').on('click', function() {
				uiProc3(true);
				btnUiProc(true);
				$('#btnSave4').addClass('d-none'); //저장버튼
				$('#tab1Nav').removeClass('disabled');
				$('#custCmplnAdmTable').DataTable().ajax.reload();
				$('#form').each(function() {
					this.reset();
				});
				$('#tab1Nav').tab('show');
				tabNav();
			});
			return false;
		}

		if ($('#btnSave5').attr('class') == 'btn btn-primary float-right') {
			$('#saveBtnModal').modal('show');

			$('#saveBtnModalY').on('click', function() {
				uiProc5(true);
				btnUiProc(true);
				$('#btnSave5').addClass('d-none'); //저장버튼
				$('#tab1Nav').removeClass('disabled');
				$('#custCmplnAdmTable').DataTable().ajax.reload();
				$('#form').each(function() {
					this.reset();
				});
				$('#fileSearch2').addClass('d-none');
				$('#btnFpFileDel2').addClass('d-none');
				$('#fileTag2').removeClass('d-none');

				$('#fileSearch3').addClass('d-none');
				$('#btnFpFileDel3').addClass('d-none');
				$('#fileTag3').removeClass('d-none');
				
// 				$('#fpHref2').text('');
				$('#tab1Nav').tab('show');
				tabNav();
			});
			return false;
		} */
		
		if ($(this).hasClass('selected')) {
// 			$(this).removeClass('selected');
		} else {
			$('#custCmplnAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		tableIdx2 = $('#custCmplnAdmTable').DataTable().row(this).index();
//		console.log(tableIdx2);
		custNo = custCmplnAdmTable.row(this).data().custNo;
	
		$('#btnSave').addClass('d-none'); // 저장버튼
		$('#btnEdit').attr('disabled', false);
/* 		$('#tab2Nav').removeClass('disabled');
		$('#tab3Nav').removeClass('disabled');
		$('#tab4Nav').removeClass('disabled');
		$('#tab5Nav').removeClass('disabled'); */
	
		$.ajax({
			url : '<c:url value="bs/custCmplnAdmRead"/>',
			type : 'GET',
			data : {
				'custNo' : custNo
			},
			success : function(res) {
				let data = res.data;
	
				if (res.result == 'ok') {
					sideView = 'edit';
					uiProc(true);
					btnUiProc(true);
					$('#cmplnDate').val(data.cmplnDate);                  //접수일
					$('#rcvChargr').val(data.rcvChargr);                  //접수자
					$('#itemCd').val(data.itemCd);                        //제품번호
					$('#itemRev').val(data.itemRev);                      //리비전
					$('#mfcDate').val(data.mfcDate);                      //제조일
					$('#custNm').val(data.custNm);                        //고객명
					$('#coChargr').val(data.coChargr);                    //업체담당자
					$('#coChargrMail').val(data.coChargrMail);            //업체이메일
					$('#complReqDate').val(data.complReqDate);            //완료요청일
					$('#custConfirmCont').val(data.custConfirmCont);      //고객확인 및 의뢰사항
					$('#custReqCont').val(data.custReqCont);              //고객요구사항
/*					$('#faultyRheckDate').val(data.faultyRheckDate);      //불량확인일자
					$('#faultyCheckChargr').val(data.faultyCheckChargr);  //불량확인자
					$('#coErrorYn').val(data.coErrorYn);                  //당사과실유무
					$('#inspectPassDate').val(data.inspectPassDate);      //검사경과일
					$('#faultyCheckCont').val(data.faultyCheckCont);      //불량확인내용
					$('#reviewDate').val(data.reviewDate);                //검토일자
					$('#reviewChargr').val(data.reviewChargr);            //검토확인자
					$('#chargeYn').val(data.chargeYn);                    //유/무상
					$('#custCheck').val(data.custCheck);                  //고객확인 
					$('#paymentProg').val(data.paymentProg);              //의뢰후 납부경과
					$('#confirmYn').val(data.confirmYn);                  //완료여부
					$('#consultCont').val(data.consultCont);              //협의내용
					$('#prodDate').val(data.prodDate);                    //생산접수일
					$('#prodChargr').val(data.prodChargr);                //생산접수자
					$('#itemProdCd').val(data.itemProdCd);                //생산제품번호
					$('#itemProdRev').val(data.itemProdRev);              //생산리비전
					$('#mfcProdDate').val(data.mfcProdDate);              //생산제조일
					$('#prodNm').val(data.prodNm);                        //고객명
					$('#coProdChargr').val(data.coProdChargr);            //생산업체담당자
					$('#coProdChargrMail').val(data.coProdChargrMail);    //생산업체이메일
					$('#prodReqDate').val(data.prodReqDate);              //생산완료요청일
					$('#prodConfirmCont').val(data.prodConfirmCont);      //고객확인 및 의뢰사항
					$('#prodReqCont').val(data.prodReqCont);              //고객요구사항
					$('#faultyDept').val(data.faultyDept);                //귀책부서
					$('#caReqDate').val(data.caReqDate);                  //시정조치요구일
					$('#caRecepDate').val(data.caRecepDate);              //시정조치수신일
					$('#satisfyYn').val(data.satisfyYn);                  //만족여부
					$('#caNoCont').val(data.caNoCont);                    //시정조치No내용
*/					
					$('#fpFn1').text(data.faultyCheckFn);		
					(data.faultyCheckFn == null || data.faultyCheckFn == "") ? $('#fpValue1').text("파일을 선택해주세요") : $('#fpValue1').text(data.faultyCheckFn);
					$('#fpHref1').attr('href','bs/downloadFile?custNo='+data.custNo);
/* 
					$('#fpFn4').text(data.prodCheckFn);
					(data.prodCheckFn == null || data.prodCheckFn == "") ? $('#fpValue4').text("파일을 선택해주세요") : $('#fpValue4').text(data.prodCheckFn);
					$('#fpHref4').attr('href','bs/downloadFile4?custNo='+data.custNo);
					
					$('#fpFn2').text(data.caPlan);
					(data.caPlan == null || data.caPlan == "") ? $('#fpValue2').text("파일을 선택해주세요") : $('#fpValue2').text(data.caNo);
					$('#fpHref2').attr('href','bs/downloadFile2?custNo='+data.custNo);
					
					$('#fpFn3').text(data.caNo);
					(data.caNo == null || data.caNo == "") ? $('#fpValue3').text("파일을 선택해주세요") : $('#fpValue3').text(data.caNo);
					$('#fpHref3').attr('href','bs/downloadFile3?custNo='+data.custNo);
					console.log() */
				} else {
					toastr.error(res.message);
				}
			}
		});
	});

	//일반정보(영업)등록폼
	$('#btnAdd').on('click', function() {
		sideView = 'add';
		$('#form').each(function() {
			this.reset();
		});
		$('#fpValue1').text("파일을 선택해주세요");
		$('#cmplnDate').val(moment().format('YYYY-MM-DD'));
		$('#mfcDate').val(moment().format('YYYY-MM-DD'));
		$('#complReqDate').val(moment().format('YYYY-MM-DD'));

		$('#fileSearch1').removeClass('d-none');
		$('#btnFpFileDel1').removeClass('d-none');
		$('#fileTag1').addClass('d-none');
		
		/* $('#tab2Nav').addClass('disabled');
		$('#tab3Nav').addClass('disabled');
		$('#tab4Nav').addClass('disabled'); */
		$('#custCmplnAdmTable').dataTable().$('tr.selected').removeClass('selected');
		uiProc(false);
		btnUiProc(false);
		$('#tab1Nav').addClass('disabled');
		tabNav();
		$('#btnSave').removeClass('d-none'); 
		$('#btnEdit').attr('disabled', true);
	});

	/* //검토부서(품질)등록폼
	$('#btnAdd2').on('click', function() {
		sideView = 'add';
// 		$('#faultyRheckDate').val(moment().format('YYYY-MM-DD'));
		uiProc2(false);
		btnUiProc(false);
		$('#tab1Nav').addClass('disabled');
		tabNav();
		$('#btnSave2').removeClass('d-none');
		$('#btnEdit2').attr('disabled', true);
	}); */

	/* //검토부서(영업)등록폼
	$('#btnAdd3').on('click', function() {
		sideView = 'add';
// 		$('#reviewDate').val(moment().format('YYYY-MM-DD'));
		uiProc3(false);
		btnUiProc(false);
		$('#tab1Nav').addClass('disabled');
		tabNav();
		$('#btnSave3').removeClass('d-none');
		$('#btnEdit3').attr('disabled', true);
	}); */

	/* //검토부서(생산) 등록폼
	$('#btnAdd4').on('click', function() {
		activeButton='btnAdd4';
		
		$('#fpValue4').text("파일을 선택해주세요");
		$('#prodDate').val(moment().format('YYYY-MM-DD'));
		$('#mfcProdDate').val(moment().format('YYYY-MM-DD'));
		$('#prodReqDate').val(moment().format('YYYY-MM-DD'));

		$('#fileSearch4').removeClass('d-none');
		$('#btnFpFileDel4').removeClass('d-none');
		$('#fileTag4').addClass('d-none');

		uiProc4(false);
		btnUiProc(false);
		$('#tab1Nav').addClass('disabled');
		tabNav();
		$('#btnSave4').removeClass('d-none'); 
		$('#btnEdit4').attr('disabled', true);
	}); */
	
	/* //재발방지(품질)등록폼
	$('#btnAdd5').on('click', function() {
		sideView = 'add';
// 		$('#caReqDate').val(moment().format('YYYY-MM-DD'));
// 		$('#caRecepDate').val(moment().format('YYYY-MM-DD'));
		
		$('#fileSearch2').removeClass('d-none');
		$('#btnFpFileDel2').removeClass('d-none');
		$('#fileTag2').addClass('d-none');

		$('#fileSearch3').removeClass('d-none');
		$('#btnFpFileDel3').removeClass('d-none');
		$('#fileTag3').addClass('d-none');

// 		$('#fpValue2').text($('#fpFn2').text());
		imgRead();
		
		uiProc5(false);
		btnUiProc(false);
		$('#tab1Nav').addClass('disabled');
		tabNav();
		$('#btnSave5').removeClass('d-none');
		$('#btnEdit5').attr('disabled', true);
	}); */

	// 수정폼
	$('#btnEdit').on('click', function() {
		if ($('#custCmplnAdmTable tbody tr').hasClass('selected')=='') {
			toastr.warning("수정할 항목을 선택해주세요.");
			return false;
		}
		uiProc(false);
		btnUiProc(false);
		imgRead();
		$('#tab1Nav').addClass('disabled');
		tabNav();
// 		$('#tab2Nav').addClass('disabled');
// 		$('#tab3Nav').addClass('disabled');
// 		$('#tab4Nav').addClass('disabled');

// 		$('#fpValue1').text($('#fpFn1').text());

		$('#fileSearch1').removeClass('d-none');
		$('#btnFpFileDel1').removeClass('d-none');
		$('#fileTag1').addClass('d-none');
		
		$('#btnSave').removeClass('d-none'); // 등록버튼
	});

	//일반정보(영업)저장 처리
	$('#btnSave').on('click',function(){
		var check = true;
		if (!$.trim($('#rcvChargr').val())) {
			toastr.warning('접수자를 선택해주세요');
			$('#btnRcvChargr').focus();
			return false;
		}
		if (!$.trim($('#itemCd').val())) {
			toastr.warning('제품명/모델명을 선택해주세요');
			$('#btnItemCd').focus();
			return false;
		}
		if (!$.trim($('#custNm').val())) {
			toastr.warning('고객명을 입력해주세요');
			$('#custNm').focus();
			return false;
		}
		if (!$.trim($('#coChargr').val())) {
			toastr.warning('업체명을 입력해주세요');
			$('#coChargr').focus();
			return false;
		}

		$('#my-spinner').show();

		var formData = new FormData(document.getElementById("form"));
		
		formData.set('cmplnDate',$('#cmplnDate').val());
		formData.set('rcvChargr',$('#rcvChargr').val());
		formData.set('itemCd',$('#itemCd').val());
		formData.set('itemRev',$('#itemRev').val());
		formData.set('mfcDate',$('#mfcDate').val());
		formData.set('custNm',$('#custNm').val());
		formData.set('coChargr',$('#coChargr').val());
		formData.set('coChargrMail',$('#coChargrMail').val());
		formData.set('complReqDate',$('#complReqDate').val());
		formData.set('custConfirmCont',$('#custConfirmCont').val());
		formData.set('custReqCont',$('#custReqCont').val());

		formData.append('custNo',custNo);
		
		if(sideView == 'add'){
			var url = '<c:url value="bs/custCmplnAdmCreate"/>'; 
		}else{
			url = '<c:url value="bs/custCmplnAdmUpdate"/>';
		}
		
		$.ajax({
			url : url,
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			success : function(res) {
				if (res.result == 'ok') {					
					if(sideView == 'add'){
						toastr.success("등록되었습니다.");	
						$('#form').each(function() {
							this.reset();
						});	
						$('#custCmplnAdmTable').DataTable().ajax.reload(function() {});			
					}else{
						toastr.success("수정되었습니다.");
						$('#custCmplnAdmTable').DataTable().ajax.reload(function() { $('#custCmplnAdmTable tbody tr').eq(tableIdx2).addClass('selected');});
						imgRead();
					}
				}else {
					toastr.error(res.message);
				}
			},
			complete : function() {
				uiProc(true);
				btnUiProc(true);
				$('#btnSave').addClass('d-none');
				$('#btnAdd').attr('disabled',false);
			    $('#btnEdit').attr('disabled',false);
//				$('#btnTypeAdd').attr('disabled',true);
// 				$('#custCmplnAdmTable').DataTable().ajax.reload(function() {});
// 				$('#custCmplnAdmTable').row().select();
				tabNavRemove();
				$('#fileSearch1').addClass('d-none');
				$('#btnFpFileDel1').addClass('d-none');
				$('#fileTag1').removeClass('d-none');
				$('#my-spinner').hide();
			}
		});
		
	});

	/* //검토부서(품질)저장 처리
	$('#btnSave2').on('click', function() {
		var url = 'bs/custCmplnAdmSideUpdate';
// 		if (sideView == "edit") {
// 			url = 'bs/custCmplnAdmUpdate'
// 		}

		$.ajax({
			url : url,
			type : 'POST',
			data : {
				'custNo' 			:	 function(){return custNo;},	//식별값
				'faultyRheckDate'	:	$('#faultyRheckDate').val(),  	//불량확인일자
				'faultyCheckChargr'	:	$('#faultyCheckChargr').val(),  //불량확인자
				'coErrorYn'			:	$('#coErrorYn').val(),  		//당사과실유무
				'inspectPassDate'	:	$('#inspectPassDate').val(),  	//검사경과일
				'faultyCheckCont'	:	$('#faultyCheckCont').val(),	//검사경과일
			},
			beforeSend : function() {
				// $('#btnAddConfirm').addClass('d-none');
				// $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success : function(res) {
				let data = res.data;
				$('#btnSave2').addClass('d-none');

				if (res.result == 'ok') {
					$('#custCmplnAdmTable').DataTable().ajax.reload(function() { $('#custCmplnAdmTable tbody tr').eq(tableIdx2).addClass('selected');});
					// 보기
					toastr.success('수정되었습니다.');					
				} else {
					toastr.error(res.message);
				}
			},
			complete : function() {
				$('#btnEdit2').attr("disabled", false);
				$('#btnAdd2').attr('disabled',false);
				uiProc2(true); //검토부서
				btnUiProc(true);
				$('#tab1Nav').removeClass('disabled');
// 				$('#tab3Nav').removeClass('disabled');
// 				$('#tab4Nav').removeClass('disabled');
// 				$('#tab1Nav').tab('show');
				tabNavRemove();
			}
		});
	});

	//검토부서(영업)저장 처리
	$('#btnSave3').on('click', function() {
		var url = 'bs/custCmplnAdmSideUpdate';
// 		if (sideView == "edit") {
// 			url = 'bs/custCmplnAdmUpdate'
// 		}

		$.ajax({
			url : url,
			type : 'POST',
			data : {
				'custNo' 		:	 function(){return custNo;},	//식별값
				'reviewDate'	:	$('#reviewDate').val(),  		//검토일자
				'reviewChargr'	:	$('#reviewChargr').val(),  		//검토확인자
				'chargeYn'		:	$('#chargeYn').val(),  			//유/무상
				'custCheck'		:	$('#custCheck').val(),  		//고객확인
				'paymentProg'	:	$('#paymentProg').val(),  		//의뢰후납품경과
				'confirmYn'		:	$('#confirmYn').val(),  		//완료여부
				'consultCont'	:	$('#consultCont').val(),  		//협의내용
			},
			beforeSend : function() {
				// $('#btnAddConfirm').addClass('d-none');
				// $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success : function(res) {
				let data = res.data;
				$('#btnSave3').addClass('d-none');

				if (res.result == 'ok') {
					// 보기
					$('#custCmplnAdmTable').DataTable().ajax.reload(function() { $('#custCmplnAdmTable tbody tr').eq(tableIdx2).addClass('selected');});
					toastr.success('수정되었습니다.');					
				} else {
					toastr.error(res.message);
				}
			},
			complete : function() {
				$('#btnEdit3').attr("disabled", false);
				$('#btnAdd3').attr('disabled',false);
				uiProc3(true); //검토부서
				btnUiProc(true);
				$('#tab1Nav').removeClass('disabled');
				tabNavRemove();
// 				$('#tab3Nav').removeClass('disabled');
// 				$('#tab4Nav').removeClass('disabled');
// 				$('#tab1Nav').tab('show');
// 				console.log("변경됐으면 나와줘");
// 				$('#form').each(function() {
// 					this.reset();
// 				});
			}
		});
	});

	//검토부서(생산)저장 처리
	$('#btnSave4').on('click',function(){
		var check = true;
		if (!$.trim($('#prodChargr').val())) {
			toastr.warning('생산접수자를 선택해주세요');
			$('#prodChargr').focus();
			return false;
		}
		if (!$.trim($('#itemProdCd').val())) {
			toastr.warning('제품명/모델명을 선택해주세요');
			$('#itemProdCd').focus();
			return false;
		}
		if (!$.trim($('#prodNm').val())) {
			toastr.warning('고객명을 입려해주세요');
			$('#prodNm').focus();
			return false;
		}
		if (!$.trim($('#coProdChargr').val())) {
			toastr.warning('생산업체명을 입려해주세요');
			$('#coProdChargr').focus();
			return false;
		}

		var formData = new FormData(document.getElementById("form4"));
		
		formData.set('prodDate',$('#prodDate').val());
		formData.set('prodChargr',$('#prodChargr').val());
		formData.set('itemProdCd',$('#itemProdCd').val());
		formData.set('itemProdRev',$('#itemProdRev').val());
		formData.set('mfcProdDate',$('#mfcProdDate').val());
		formData.set('prodNm',$('#prodNm').val());
		formData.set('coProdChargr',$('#coProdChargr').val());
		formData.set('coProdChargrMail',$('#coProdChargrMail').val());
		formData.set('prodReqDate',$('#prodReqDate').val());
		formData.set('prodConfirmCont',$('#prodConfirmCont').val());
		formData.set('prodReqCont',$('#prodReqCont').val());

		formData.append('custNo',custNo);
		console.log(formData);
		
		url = '<c:url value="bs/custCmplnAdmUpdate"/>';
		
		$.ajax({
			url : url,
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			success : function(res) {
				if (res.result == 'ok') {					
					if(sideView == 'add'){
						toastr.success("등록되었습니다.");	
						$('#form5').each(function() {
							this.reset();
						});	
						$('#custCmplnAdmTable').DataTable().ajax.reload(function() {});			
					}else{
						toastr.success("수정되었습니다.");
						$('#custCmplnAdmTable').DataTable().ajax.reload(function() { $('#custCmplnAdmTable tbody tr').eq(tableIdx2).addClass('selected');});
						imgRead();
					}
				}else {
					toastr.error(res.message);
				}
			},
			complete : function() {
				uiProc4(true);
				btnUiProc(true);
				$('#btnSave4').addClass('d-none');
				$('#btnAdd4').attr('disabled',false);
			    $('#btnEdit4').attr('disabled',false);
//				$('#btnTypeAdd').attr('disabled',true);
// 				$('#custCmplnAdmTable').DataTable().ajax.reload(function() {});
// 				$('#custCmplnAdmTable').row().select();
				tabNavRemove();
				$('#fileSearch4').addClass('d-none');
				$('#btnFpFileDel4').addClass('d-none');
				$('#fileTag4').removeClass('d-none');
			}
		});
		
	});
	
	//재발방지(품질)저장 처리
	$('#btnSave5').on('click',function(){
		var check = true;

		var formData = new FormData(document.getElementById("form5"));
		
		formData.set('faultyDept',$('#faultyDept').val());		//귀책부서
		formData.set('caReqDate',$('#caReqDate').val());		//시정조치 요구일
		formData.set('caRecepDate',$('#caRecepDate').val());	//시정조치수신일
		formData.set('satisfyYn',$('#satisfyYn').val());		//만족여부
		formData.set('caNoCont',$('#caNoCont').val());			//시정조치No내용

		formData.append('custNo',custNo);
		
		if(sideView == 'add'){
			var url = '<c:url value="bs/relapseUpdate"/>'; 
		}else{
			url = '<c:url value="bs/relapseUpdate"/>';
		}
		
		$.ajax({
			url : url,
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			success : function(res) {
				if (res.result == 'ok') {	
					$('#btnSave5').addClass('d-none');
					$('#custCmplnAdmTable').DataTable().ajax.reload(function() { $('#custCmplnAdmTable tbody tr').eq(tableIdx2).addClass('selected');});	
					toastr.success('수정되었습니다.');
				}else {
					toastr.error(res.message);
				}
			},
			complete : function() {
				$('#btnEdit5').attr("disabled", false);
				$('#btnAdd5').attr('disabled',false);
				uiProc5(true); //검토부서
				btnUiProc(true);
				$('#tab1Nav').removeClass('disabled');
// 				$('#tab3Nav').removeClass('disabled');
// 				$('#tab4Nav').removeClass('disabled');
// 				$('#tab1Nav').tab('show');
				
				$('#fileSearch2').addClass('d-none');
				$('#btnFpFileDel2').addClass('d-none');
				$('#fileTag2').removeClass('d-none');

				$('#fileSearch3').addClass('d-none');
				$('#btnFpFileDel3').addClass('d-none');
				$('#fileTag3').removeClass('d-none');
				tabNavRemove();
				imgRead();				
			}
		});
		
	}); */

	//접수자 팝업 시작
	var custPopUpTable;
	function selectCust() {
//		console.log(custPopUpTable);
		if (custPopUpTable == null || custPopUpTable == undefined) {
			custPopUpTable = $('#custPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				pageLength : 20,
				ajax : {
					url : '/sm/matrlUserDataList2',
					type : 'GET',
					data : {},
				},
				rowId : 'userNumber',
				columns : [
					{data : 'userNm'		},
					{data : 'departmentNm'	},
					{data : 'postNm'		},
					{data : 'chargrDutyNm'	},
					{data : 'workplaceNm'	},
					{data : 'userDesc'		},
				],
				columnDefs : [ {
					"targets" : [ 0, 1, 2, 3, 4, 5 ],
					"className" : "text-center"
				} ],
				order : [ [ 0, 'asc' ] ],
			});
			$('#custPopUpTable tbody').on('click', 'tr', function() {
				var data = custPopUpTable.row(this).data();

				if(activeButton){
					$('input[name=prodChargr]').eq(tableIdx).val(data.userNm);
				}else{
					$('input[name=rcvChargr]').eq(tableIdx).val(data.userNm);
				}
				$('#custPopUpModal').modal('hide');
			});
		} else {
			$('#custPopUpTable').DataTable().ajax.reload(function() {});
		}

		$('#custPopUpModal').modal('show');
	}

	/* //불량확인자 팝업 시작badCheck
	var badCheckPopUpTable;
	function selectBadCheck() {
		if (badCheckPopUpTable == null || badCheckPopUpTable == undefined) {
			badCheckPopUpTable = $('#badCheckPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				pageLength : 20,
				ajax : {
					url : '/sm/matrlUserDataList',
					type : 'GET',
					data : {},
				},
				rowId : 'userNumber',
				columns : [
					{data : 'userNm'		},
					{data : 'departmentNm'	},
					{data : 'postNm'		},
					{data : 'chargrDutyNm'	},
					{data : 'workplaceNm'	},
					{data : 'userDesc'		},
				],
				columnDefs : [ {
					"targets" : [ 0, 1, 2, 3, 4, 5 ],
					"className" : "text-center"
				} ],
				order : [ [ 0, 'asc' ] ],
			});
			$('#badCheckPopUpTable tbody').on('click', 'tr', function() {
				var data = badCheckPopUpTable.row(this).data();
				$('input[name=faultyCheckChargr]').eq(tableIdx).val(data.userNm);
				$('#badCheckPopUpModal').modal('hide');
			});
		} else {
			$('#badCheckPopUpTable').DataTable().ajax.reload(function() {});
		}

		$('#badCheckPopUpModal').modal('show');
	}

	//검토확인자 팝업 시작 Review
	var reviewPopUpTable;
	function selectReview(){
		if (reviewPopUpTable == null || reviewPopUpTable == undefined) {
			reviewPopUpTable = $('#reviewPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				pageLength : 20,
				ajax : {
					url : '/sm/matrlUserDataList',
					type : 'GET',
					data : {},
				},
				rowId : 'userNumber',
				columns : [
					{data : 'userNm'		},
					{data : 'departmentNm'	},
					{data : 'postNm'		},
					{data : 'chargrDutyNm'	},
					{data : 'workplaceNm'	},
					{data : 'userDesc'		},
				],
				columnDefs : [ {
					"targets" : [ 0, 1, 2, 3, 4, 5 ],
					"className" : "text-center"
				} ],
				order : [ [ 0, 'asc' ] ],
			});
			$('#reviewPopUpTable tbody').on('click', 'tr', function() {
				var data = reviewPopUpTable.row(this).data();
				$('input[name=reviewChargr]').eq(tableIdx).val(data.userNm);
				$('#reviewPopUpModal').modal('hide');
			});
		} else {
			$('#reviewPopUpTable').DataTable().ajax.reload(function() {});
		}

		$('#reviewPopUpModal').modal('show');
	} */

	//제품명/모델명 팝업 시작 product
	var productPopUpTable;
	function selectProductName() {
		if (productPopUpTable == null || productPopUpTable == undefined) {

			productPopUpTable = $('#productPopUpTable').DataTable({
				dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
						+ "<'row'<'col-sm-12'tr>>"
						+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
				language : lang_kor,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				lengthChange : false,
				//serverSide : true,
				pageLength : 20,
				ajax : {
					url : '<c:url value="bm/goodsCodeDataList"/>',
					type : 'GET',
					data : {},
				},
				rowId : 'goodsCd',
				columns : [
					{render : function(data, type, row,
								meta) {
							return meta.row+ meta.settings._iDisplayStart+ 1;}
					},
					{data : 'goodsCd'		},
					{data : 'goodsNm'		},
					{data : 'gubunNm'	},
					{data : 'model'		} 
				],
				columnDefs : [ {
					"defaultContent" : "-","targets" : "_all","className" : "text-center"
				} ],
				order : [ [ 0, 'asc' ] ],
				buttons : [],
			});

			$('#productPopUpTable tbody').on('click', 'tr', function() {

				var data = productPopUpTable.row(this).data();

				if(activeButton){
					$('input[name=itemProdCd]').eq(tableIdx).val(data.goodsNm);
					$('input[name=itemProdRev]').eq(tableIdx).val(data.model); 
				}else{
					$('input[name=itemCd]').eq(tableIdx).val(data.goodsNm);
					$('input[name=itemRev]').eq(tableIdx).val(data.model); 
				}
				$('#productPopUpModal').modal('hide');
			});
		} else {
			$('#productPopUpTable').DataTable().ajax.reload(function() {});
		}
		$('#productPopUpModal').modal('show');
	};

	
	//날짜
	var html1 = '<div class="row">';
	html1 += '&nbsp;<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="rcvDateOutFrom" name="rcvDateOutFrom" disabled/>';
	html1 += '<button onclick="fnPopUpCalendar(rcvDateOutFrom,rcvDateOutFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="rcvDateOutFromCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;~ &nbsp;<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="rcvDateOutTo" name="rcvDateOutTo" disabled/>';
	html1 += '<button onclick="fnPopUpCalendar(rcvDateOutTo,rcvDateOutTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="rcvDateOutToCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnOutRetv">조회</button>'
	html1 += '</div>';

	$('#custCmplnAdmTable_length').html(html1);
	$('#rcvDateOutFrom').val(serverDateFrom);
	$('#rcvDateOutTo').val(serverDateTo);

	$('#btnOutRetv').on('click', function() {
		rcvDateOutFromCal = $('#rcvDateOutFrom').val();
		rcvDateOutToCal = $('#rcvDateOutTo').val();
		
/* 		console.log("rcvDateOutFromCal	:"+rcvDateOutFromCal);
		console.log("rcvDateOutToCal	:"+rcvDateOutToCal); */

		$('#custCmplnAdmTable').DataTable().ajax.reload(function() {});
		$('#form').each(function() {
			this.reset();
		});
	});
	
	//일반정보(영업)
	function uiProc(flag) {
		$('#cmplnDate').attr('disabled', flag);
// 		$('#itemRev').attr('disabled', flag);
		$('#mfcDate').attr('disabled', flag);
		$('#custNm').attr('disabled', flag);
		$('#coChargr').attr('disabled', flag);
		$('#coChargrMail').attr('disabled', flag);
		$('#faultyCheckFn').attr('disabled', flag);
		$('#complReqDate').attr('disabled', flag);
		$('#custConfirmCont').attr('disabled', flag);
		$('#custReqCont').attr('disabled', flag);
	}

	/* //검토부서(품질)
	function uiProc2(flag) {
		$('#faultyRheckDate').attr('disabled', flag);
		$('#faultyCheckChargr').attr('disabled', flag);
		$('#coErrorYn').attr('disabled', flag);
		$('#inspectPassDate').attr('disabled', flag);
		$('#faultyCheckCont').attr('disabled', flag);
	}

	//검토부서(영업)
	function uiProc3(flag) {
		$('#reviewDate').attr('disabled', flag);
		$('#reviewChargr').attr('disabled', flag);
		$('#chargeYn').attr('disabled', flag);
		$('#custCheck').attr('disabled', flag);
		$('#paymentProg').attr('disabled', flag);
		$('#confirmYn').attr('disabled', flag);
		$('#consultCont').attr('disabled', flag);
	}

	//검토부서(생산)
	function uiProc4(flag) {
		$('#prodDate').attr('disabled', flag);
// 		$('#itemRev').attr('disabled', flag);
		$('#mfcProdDate').attr('disabled', flag);
		$('#prodNm').attr('disabled', flag);
		$('#coProdChargr').attr('disabled', flag);
		$('#coProdChargrMail').attr('disabled', flag);
		$('#faultyCheckFn').attr('disabled', flag);
		$('#prodReqDate').attr('disabled', flag);
		$('#prodConfirmCont').attr('disabled', flag);
		$('#prodReqCont').attr('disabled', flag);
	}

	//재발방지(품질)
	function uiProc5(flag) {
		$('#faultyDept').attr('disabled', flag);
		$('#caReqDate').attr('disabled', flag);
		$('#caRecepDate').attr('disabled', flag);
		$('#satisfyYn').attr('disabled', flag);
		$('#caNo').attr('disabled', flag);
		$('#caNoCont').attr('disabled', flag);
	} */

	//검사 버튼
// 	function uiProc5(flag) {
// 		$('button[name=btnPrcssCdCorp]').attr('disabled', flag);
// 		$('button[name=btnEquipCdCorp]').attr('disabled', flag);
// 	}
	
	//테이블
	function tabNav(){
// 		$('#tab1Nav').addClass('disabled');
		/* $('#tab2Nav').addClass('disabled');
		$('#tab3Nav').addClass('disabled');
		$('#tab4Nav').addClass('disabled');
		$('#tab5Nav').addClass('disabled'); */
	}
	//테이블
	function tabNavRemove(){
		$('#tab1Nav').removeClass('disabled');
		/* $('#tab2Nav').removeClass('disabled');
		$('#tab3Nav').removeClass('disabled');
		$('#tab4Nav').removeClass('disabled');
		$('#tab5Nav').removeClass('disabled'); */
	}

	function fileDelete() {
		if ($('#fpValue1').text()=='' || $('#fpValue1').text()=="파일을 선택해주세요") {
			toastr.warning('삭제할 항목이 없습니다.');
			return false;
		}
		
		$.ajax({
			url : '<c:url value="bs/custCmplnAdmDelete"/>',
			type : 'POST',
			data : {
				'custNo' : function() {return custNo;},
				'faultyCheckFn' : faultyCheckFn
			},
			success : function(res) {
				if (res.result == 'ok') {
					toastr.success('삭제되었습니다.');
// 					$('#custCmplnAdmTable').DataTable().ajax.reload(function() {
// 						 $('#custCmplnAdmTable tbody tr').eq(tableIdx2).addClass('selected');
// 						 console.log("실행됨");
// 					});
// 					$('#fileNm1').text("");
					$('#fpHref1').attr("href", "");
					$('#fpValue1').text('');
					$('#fpFn1').text('');
// 					imgRead();
					
				} else {
					toastr.error(res.message);
				}
			}
		});
	}

/* 	function fileDelete2() {
		if ($('#fpValue2').text()=='' || $('#fpValue2').text()=="파일을 선택해주세요") {
			toastr.warning('삭제할 항목이 없습니다.');
			return false;
		}
		$.ajax({
			url : '<c:url value="bs/custCmplnAdmDelete2"/>',
			type : 'POST',
			data : {
				'custNo' : function() {return custNo;},
			},
			success : function(res) {
				if (res.result == 'ok') {
					toastr.success('삭제되었습니다.');
					$('#fpHref2').attr("href", "");
					$('#fpValue2').text('');
					$('#fpFn2').text('');
// 					imgRead();
					
				} else {
					toastr.error(res.message);
				}
			}
		});
	}

	function fileDelete3() {
		if ($('#fpValue3').text()=='' || $('#fpValue3').text()=="파일을 선택해주세요") {
			toastr.warning('삭제할 항목이 없습니다.');
			return false;
		}
		$.ajax({
			url : '<c:url value="bs/custCmplnAdmDelete3"/>',
			type : 'POST',
			data : {
				'custNo' : function() {return custNo;},
			},
			success : function(res) {
				if (res.result == 'ok') {
					toastr.success('삭제되었습니다.');
					$('#fpHref3').attr("href", "");
					$('#fpValue3').text('');
					$('#fpFn3').text('');
// 					imgRead();
					
				} else {
					toastr.error(res.message);
				}
			}
		});
	} */
	
	function imgRead(){
		$.ajax({
			url : '<c:url value="bs/custCmplnAdmRead"/>',
			type : 'GET',
			data : {
				'custNo' : custNo
			},
			success : function(res) {
				let data = res.data;
				faultyCheckFn = data.faultyCheckFn;
				if (res.result == 'ok') {
					sideView = 'edit';
					$('#fpFn1').text(data.faultyCheckFn); 
					$('#fpHref1').attr('href','bs/downloadFile1?faultyCheckFn='+data.faultyCheckFn);
					(data.faultyCheckFn == null || data.faultyCheckFn == "") ? $('#fpValue1').text("파일을 선택해주세요") : $('#fpValue1').text(data.faultyCheckFn);

					$('#fpFn2').text(data.caPlan);    
					$('#fpHref2').attr('href','bs/downloadFile2?custNo='+data.custNo);
					(data.caPlan == null || data.caPlan == "") ? $('#fpValue2').text("파일을 선택해주세요") : $('#fpValue2').text(data.caPlan);
					
					$('#fpFn3').text(data.caNo);    
					$('#fpHref3').attr('href','bs/downloadFile3?custNo='+data.custNo);
					(data.caNo == null || data.caNo == "") ? $('#fpValue3').text("파일을 선택해주세요") : $('#fpValue3').text(data.caNo);

					$('#fpFn4').text(data.prodCheckFn);    
					$('#fpHref4').attr('href','bs/downloadFile4?custNo='+data.custNo);
					(data.caNo == null || data.caNo == "") ? $('#fpValue4').text("파일을 선택해주세요") : $('#fpValue4').text(data.caNo);
				} else {
					toastr.error(res.message);
				}
			}
		});
	}

	function btnUiProc(flag){
		$("#btnRcvChargr").attr('disabled', flag);
		$("#btnItemCd").attr('disabled', flag);
		$("#btnFaultyCheckChargr").attr('disabled', flag);
		$("#btnReviewChargr").attr('disabled', flag);
		$("#btnProdChargr").attr('disabled', flag);
		$("#btnItemProdCd").attr('disabled', flag);
		$("#btnFaultyDept").attr('disabled', flag);
	}
</script>

</body>
</html>