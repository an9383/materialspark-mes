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
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">수주등록</li>
			</ol>
		</nav>
	</header>

	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar-fix" id="left-list"
				style="width: 100%;">
				<div class="card-header card-tab">
					<!-- .nav-tabs tablist -->
					<ul class="nav nav-tabs card-header-tabs">
						<li class="nav-item"><a class="nav-link active show"
							id="tab1Nav" data-toggle="tab" href="#tab1">신규등록</a></li>
						<li class="nav-item"><a class="nav-link" id="tab2Nav"
							data-toggle="tab" href="#tab2">내부등록</a></li>
					</ul>
					<!-- /.nav-tabs -->
				</div>
				<br>
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn2" onclick="openrNav2()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<div id="table1" style="height: 350px; margin-bottom: 15px;">
						<div class="table-responsive">
							<table id="bizOrderOutTable" class="table table-bordered">
								<colgroup>
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>수주번호</th>
										<th>접수일</th>
										<th>접수자</th>
										<th>발주번호</th>
										<th>발주처</th>
										<th>국내/국외</th>
										<th>구분</th>

									</tr>
								</thead>
							</table>
						</div>
					</div>
					<div id="table2" style="height: 350px; margin-bottom: 15px;"
						class="d-none">
						<div class="table-responsive">
							<table id="bizOrderInTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th>수주번호</th>
										<th>접수일</th>
										<th>접수자</th>
										<th>발주번호</th>
										<th>발주처</th>
										<th>의뢰인</th>
										<th>구분</th>

									</tr>
								</thead>
							</table>
						</div>
					</div>
					<div class="table-responsive" style="height: 300px">
						<div class="card-body col-sm-12 pb-1">
							<button type="button" class="btn btn-primary float-left mr-1"
								id="btnDtlAdd">추가</button>
							<button class="btn btn-warning d-none" id="btnEditConfirmLoading"
								type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status"
									aria-hidden="true"></span> 처리중
							</button>
							<button type="button" class="btn btn-primary float-left mr-1"
								id="btnDtlEdit">수정</button>
							<button class="btn btn-warning d-none" id="btnEditConfirmLoading"
								type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status"
									aria-hidden="true"></span> 처리중
							</button>
							<button type="button" class="btn btn-warning float-left mr-1"
								id="btnDtlDel">삭제</button>
							<button class="btn btn-warning d-none" id="btnEditConfirmLoading"
								type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status"
									aria-hidden="true"></span> 처리중
							</button>
						</div>
						<table id="bizOrderDtlTable" class="table table-bordered">
							<colgroup>
								<col width="13%">
								<col width="15%">
								<col width="7%">
								<col width="10%">
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th>수주상세번호</th>
									<th>품명(Type)</th>
									<th>주문수량</th>
									<th>단가</th>
									<th>금액</th>
									<th>출하요청일</th>
									<th>미납수량</th>
									<th>완료수량</th>
									<th>비고</th>
								</tr>
							</thead>
						</table>
					</div>

				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar right-sidebar-fix"
				id="rfSidenav" style="width: 35%;">
				<div class="card-body col-sm-12">
					<div class="rightsidebar-close">
						<a href="javascript:void(0)" id="left-expand2"
							class="closebtn float-right" onclick="closerNav2()"><i
							class="mdi mdi-close"></i></a>
					</div>
					<button type="button" class="btn btn-primary float-right mr-1"
						id="btnEdit">수정</button>
					<button class="btn btn-warning d-none" id="btnEditConfirmLoading"
						type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status"
							aria-hidden="true"></span> 처리중
					</button>
					<button type="button" class="btn btn-primary float-right mr-1"
						id="btnAdd">등록</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
						type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status"
							aria-hidden="true"></span> 처리중
					</button>

				</div>
				<!--/오른쪽 등록 부분 상단 버튼 영역-->
				<div id="form1">
					<form id="formOut">
						<div class="table-responsive">
							<table class="table table-sm table-bordered mb-2"
								id="bizOrderOutDtlTable">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
								<tr>
									<th class="text-center">수주번호</th>
									<td><input class="form-control" type="text"
										class="form-control" name="contNo" disabled></td>
									<th class="text-center">발주번호</th>
									<td><input class="form-control" type="text" id="poNo"
										class="form-control" name="poNo"></td>
									
								</tr>
								<tr>
									<th class="text-center">접수일</th>
									<td>
										<div class="form-group input-sub m-0 row">
											<input class="form-control" type="text" id="rcvDate"
												name="rcvDate" disabled />
											<button
												onclick="fnPopUpCalendar(rcvDate,rcvDate,'yyyy-mm-dd')"
												class="btn btn-secondary input-sub-search"
												name="rcvDateCalendar" type="button" disabled>
												<span class="oi oi-calendar"></span>
											</button>
										</div>
									</td>
									<th class="text-center">발주처</th>
									<td>
										<div class="input-sub m-0">
											<input type="hidden" class="form-control" id="ordCorpCd"
												name="ordCorpCd"> <input type="text"
												class="form-control" id="ordCorpNm" name="ordCorpNm"
												disabled>
											<button type="button"
												class="btn btn-primary input-sub-search" name="btnOrdCorpCd"
												onClick="selectOrdCorpCd()">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
								</tr>
								<tr>
									<th class="text-center">출하요청일</th>
									<td>
										<div class="form-group input-sub m-0 row">
											<input class="form-control" type="text" id="shipReqDate"
												name="shipReqDate" disabled />
											<button
												onclick="fnPopUpCalendar(shipReqDate,shipReqDate,'yyyy-mm-dd')"
												class="btn btn-secondary input-sub-search"
												name="shipReqDateCalendar" type="button" disabled>
												<span class="oi oi-calendar"></span>
											</button>
										</div>
									</td>
									<th class="text-center">접수자</th>
									<td>
										<div class="input-sub m-0">
											<input type="hidden" class="rcvChargr" id="rcvChargr"
												name="rcvChargr"> <input type="text"
												class="form-control" id="rcvChargrNm" name="rcvChargrNm"
												disabled>
											<button type="button"
												class="btn btn-primary input-sub-search" name="btnRcvChargr"
												onClick="selectRcvChargr()">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
								</tr>
								<tr>
									<th class="text-center">국내/국외</th>
									<td><select class="custom-select" id="inexGubunOut"></select></td>
									<th class="text-center">구분</th>
									<td><select class="custom-select" id="contGubunOut"></select></td>
								</tr>

								<tr>
									<th class="text-center">사용여부</th>
									<td><select class="custom-select" id="useYnOut"></select></td>
									<th></th>
									<td></td>
								</tr>
							</table>
						</div>
					</form>
				</div>
				<!--/오른쪽 등록 부분 상단 버튼 영역-->
				<div id="form2" class="d-none">
					<form id="formIn">
						<div class="table-responsive">
							<table class="table table-sm table-bordered mb-2"
								id="bizOrderInDtlTable">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
								<tr>
									<th class="text-center">수주번호</th>
									<td><input class="form-control" type="text"
										class="form-control" id="contNoIn" name="contNoIn" disabled></td>
									<th class="text-center">발주번호</th>
									<td><input class="form-control" type="text" id="poNoIn"
										class="form-control" name="poNoIn" disabled></td>
								</tr>
								<tr>
									<th class="text-center">접수일</th>
									<td>
										<div class="form-group input-sub m-0 row">
											<input class="form-control" type="text" id="rcvDateIn"
												name="rcvDateIn" disabled />
											<button
												onclick="fnPopUpCalendar(rcvDateIn,rcvDateIn,'yyyy-mm-dd')"
												class="btn btn-secondary input-sub-search"
												name="rcvDateCalendarIn" type="button" disabled>
												<span class="oi oi-calendar"></span>
											</button>
										</div>
									</td>
									<th class="text-center">발주처</th>
									<td>
										<div class="input-sub m-0">
											<input type="hidden" class="form-control" id="ordCorpCdIn"
												name="ordCorpCdIn"> <input type="text"
												class="form-control" id="ordCorpNmIn" name="ordCorpNmIn"
												disabled>
											<button type="button"
												class="btn btn-primary input-sub-search"
												name="btnOrdCorpCdIn" onClick="selectOrdCorpCd()">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
								</tr>
								<tr>
									<th class="text-center">출하요청일</th>
									<td>
										<div class="form-group input-sub m-0 row">
											<input class="form-control" type="text" id="shipReqDateIn"
												name="shipReqDateIn" disabled />
											<button
												onclick="fnPopUpCalendar(shipReqDateIn,shipReqDateIn,'yyyy-mm-dd')"
												class="btn btn-secondary input-sub-search"
												name="shipReqDateCalendarIn" type="button" disabled>
												<span class="oi oi-calendar"></span>
											</button>
										</div>
									</td>
									<th class="text-center">접수자</th>
									<td>
										<div class="input-sub m-0">
											<input type="hidden" class="rcvChargr" id="rcvChargrIn"
												name="rcvChargrIn"> <input type="text"
												class="form-control" id="rcvChargrNmIn" name="rcvChargrNmIn"
												disabled>
											<button type="button"
												class="btn btn-primary input-sub-search"
												name="btnRcvChargrIn" onClick="selectRcvChargr()">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
								</tr>
								<tr>
									<th class="text-center">의뢰인</th>
									<td><input class="form-control" id="contClientIn"
										name="contClientIn" style="max-width: 100%;" /></td>
									<th class="text-center">구분</th>
									<td><select class="custom-select" id="contGubunIn"></select></td>
								</tr>
								<tr>
									<th class="text-center">확정여부</th>
									<td><select class="custom-select" id="confirmYnIn"></select></td>
									<th class="text-center">사용여부</th>
									<td><select class="custom-select" id="useYnIn"></select></td>
								</tr>
							</table>
						</div>
					</form>
				</div>
				<button type="button" class="btn btn-primary float-right d-none"
					id="btnSave">저장</button>
				<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
					type="button" disabled>
					<span class="spinner-border spinner-border-sm" role="status"
						aria-hidden="true"></span> 처리중
				</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal Start-->
<div class="modal fade" id="bizOrderDtlPopupModal" tabindex="-1"
	role="dialog" aria-labelledby="bizOrderDtlPopupLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bizOrderDtlPopupLabel">수주상세등록</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="form">
					<div class="table-responsive">
						<table id="bizOrderDtlPopupTable"
							class="table table-sm table-bordered">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
							</colgroup>
							<tr>
								<th>수주상세번호</th>
								<td><input class="form-control" type="text" id="contDtlNo"
									name="contDtlNo" disabled /></td>
								<th class="text-center">*품명(Type)</th>
								<td>
									<div class="input-sub m-0">
										<input type="hidden" class="form-control" name="itemCd">
										<input type="hidden" class="form-control" name="itemRev">
										<input type="text" class="form-control" name="itemNm" disabled>
										<button type="button" class="btn btn-primary input-sub-search"
											name="btnItemCd" onClick="selectItemCd()">
											<span class="oi oi-magnifying-glass"></span>
										</button>
									</div>
								</td>
							</tr>
							<tr>
								<th class="text-center">*주문수량</th>
								<td><input type="text" class="form-control comma"
									name="ordCnt" style="text-align: right;" maxlength="8"></td>
								<th class="text-center">*단가</th>
								<td><input type="text" class="form-control comma"
									name="unitCost2" style="text-align: right;" maxlength="8"></td>
							</tr>
							<!-- <tr class="d-none">
								<th class="text-center d-none">미납수량</th>
								<td><input class="form-control d-none" type="text" class="form-control" name="delayCnt" disabled></td>
								<th class="text-center d-none">완료수량</th>
								<td><input class="form-control d-none" type="text" class="form-control" name="shipCnt" disabled></td>
							</tr> -->
							<tr>
								<th>비고</th>
								<td colspan="3"><input class="form-control"
									style="min-width: 100%" type="text" id="ordDtlDesc"
									name="ordDtlDesc" /></td>
							</tr>
						</table>
					</div>
				</form>
				<div class="modal-footer">
					<input type="hidden" class="form-control" id="puFlag" name="puFlag">
					<button type="button" class="btn btn-primary " id="btnDtlSave">저장</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End-->
</div>
<!-- Modal Start-->
<div class="modal fade" id="bizOrderInDtlPopupModal" tabindex="-1"
	role="dialog" aria-labelledby="bizOrderInDtlPopupLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bizOrderInDtlPopupLabel">수주상세등록</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="form6">
					<div class="table-responsive">
						<table id="bizOrderInDtlPopupTable"
							class="table table-sm table-bordered">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
							</colgroup>
							<tr>
								<th>수주상세번호</th>
								<td><input class="form-control" type="text"
									name="contDtlNo" disabled /></td>
								<th class="text-center">*품명(Type)</th>
								<td>
									<div class="input-sub m-0">
										<input type="hidden" class="form-control" name="itemRev">
										<input type="hidden" class="form-control" name="itemCd">
										<input type="text" class="form-control" name="itemNm" disabled>
										<button type="button" class="btn btn-primary input-sub-search"
											name="btnItemCd" onClick="selectItemCd()">
											<span class="oi oi-magnifying-glass"></span>
										</button>
									</div>
								</td>
							</tr>
							<tr>
								<th class="text-center">*주문수량</th>
								<td><input class="form-control comma" type="text"
									name="ordCnt" style="text-align: right;"
									maxlength="8"></td>
								<th class="text-center">*단가</th>
								<td><input type="text" class="form-control comma"
									name="unitCost2" style="text-align: right;" maxlength="8"></td>
							</tr>
							<tr>
								<th class="text-center">특이사항</th>
								<td colspan="3"><input class="form-control" type="text" style="max-width:100%" name="bizDtlDesc"></td>
							</tr>
							<tr class="d-none">
								<th class="text-center d-none">미납수량</th>
								<td><input class="form-control d-none" type="text"
									class="form-control" name="delayCnt"></td>
								<th class="text-center d-none">완료수량</th>
								<td><input class="form-control d-none" type="text"
									class="form-control" name="shipCnt"></td>
							</tr>
							<tr>
								<th>비고</th>
								<td colspan="3"><input class="form-control"
									style="min-width: 100%" type="text" name="ordDtlDesc" /></td>
							</tr>
						</table>
					</div>
				</form>
				<div class="modal-footer">

					<button type="button" class="btn btn-primary" id="btnDtlSave2">저장</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal End-->

<!-- Modal Start-->
<div class="modal fade bd-example-modal-lg" id="itemMotorPopUpModal" tabindex="-1" role="dialog" aria-labelledby="itemMotorPopUpLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="itemMotorPopUpLabel">품명조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="itemMotorPopUpTable" class="table table-bordered">
					<colgroup>
							<col width="5%">
							<col width="10%">
							<col width="31%">
							<col width="7%">
							<col width="5%">
							<col width="30%">
							<col width="12%">
					</colgroup>
					<thead class="thead-light">
	                    <tr>
                            <th>No.</th>
                            <th>CODE</th>
                            <th>ITEM</th>
                            <th>구분</th>
                            <th>Rev</th>
                            <th>SERIES</th>
                            <th>단가</th>
                        </tr>
                    </thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
			
				<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>		
<!-- Modal End-->
<%@include file="../layout/bottom.jsp" %>
<script>
	let currentHref = "bssc0020";
	let currentPage = $('.' + currentHref).attr('id');
	
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');    
	$(document).attr("title","수주등록"); 
	
	let viewIdx;
	let sideView = 'add';
	let sideDtlView = 'add';
	var serverDateFrom =  "${serverDateFrom}";
	var serverDateTo =  "${serverDateTo}";
	var bizGubun = '001';
	var contNo = null;
	var ordCorpCd = null;
	var inexGubun = null;
	var contGubun = null;
	var contGubunNm = null;
	var itemCd = null;
	var contDtlNo = null;
	var contSeq = null;
	var dtlOrdCnt = null;
	var lotNo = null;
	var ordDtlDesc = null;
	var activeTab = "신규등록";
	var rcvDateInFromCal = serverDateFrom;
	var rcvDateInToCal = serverDateTo;
	var rcvDateOutFromCal = serverDateFrom;
	var rcvDateOutToCal = serverDateTo;
	var shipReqDate = "${shipReqDate}";
	
	uiProc(true);
	uiProc2(true);

	//공통코드 처리 시작
	var useYnCode = new Array(); // 사용여부
	<c:forEach items="${useYn}" var="info">
	var json1 = new Object();
	json1.baseCd = "${info.baseCd}";
	json1.baseNm = "${info.baseNm}";
	useYnCode.push(json1);
	</c:forEach>

	var inexGubunCode = new Array(); // 국내/국외
	<c:forEach items="${inexGubun}" var="info">
	var json1 = new Object();
	json1.baseCd = "${info.baseCd}";
	json1.baseNm = "${info.baseNm}";
	inexGubunCode.push(json1);
	</c:forEach>
	
	var contGubunCode = new Array(); // 수주구분
	<c:forEach items="${contGubun}" var="info">
	var json1 = new Object();
	json1.baseCd = "${info.baseCd}";
	json1.baseNm = "${info.baseNm}";
	contGubunCode.push(json1);
	</c:forEach>
	
	var itemGubunCode = new Array(); // 스페셜/표준
	<c:forEach items="${itemGubun}" var="info">
	var json1 = new Object();
	json1.baseCd = "${info.baseCd}";
	json1.baseNm = "${info.baseNm}";
	itemGubunCode.push(json1);
	</c:forEach>

	var confirmYnCode = new Array(); // 사용여부
	<c:forEach items="${confirmYn}" var="info">
	var json1 = new Object();
	json1.baseCd = "${info.baseCd}";
	json1.baseNm = "${info.baseNm}";
	confirmYnCode.push(json1);
	</c:forEach>
	//공통코드 처리 종료   

	//선택박스처리(외부)
	selectBoxAppend(useYnCode, "useYnOut", "", "");  //사용여부
	selectBoxAppend(inexGubunCode, "inexGubunOut", "", "");  //국내/국외
	selectBoxAppend(contGubunCode, "contGubunOut", "", "");  //수주구분
	selectBoxAppend(itemGubunCode, "itemGubunOut", "", "2");  //스페셜/표준
	selectBoxAppend(confirmYnCode, "confirmYnOut", "", "2");  //확정여부

	//선택박스처리(내부)
	selectBoxAppend(useYnCode, "useYnIn", "", "");  //사용여부
	selectBoxAppend(contGubunCode, "contGubunIn", "", "");  //수주구분
	selectBoxAppend(confirmYnCode, "confirmYnIn", "", "2");  //확정여부

	$("input[name=rcvDate]").val(serverDateTo);
	$("input[name=shipReqDate]").val(shipReqDate);
	
	$('a[data-toggle="tab"]').on('shown.bs.tab',function(e){
		activeTab = $(e.target).text();
		console.log(activeTab);
	});
	console.log(activeTab);

	$('#saveBtnModalY').on('click', function() {
		$('#formIn').each(function() {
			this.reset();
		});

		$('#formOut').each(function() {
			this.reset();
		});
		
		uiProc(true);
		uiProc2(true);
		$('#btnSave').addClass('d-none');
		$('#btnEdit').attr('disabled', false);
	});
	
	

	//외부등록 탭 클릭시
	$('#tab1Nav').on('click',function(){
		uiProc(true);
		$('#formOut').each(function(){
        	this.reset();
    	});
    	sideView = 'add';
		$('#btnSave').addClass('d-none');
		$('#table1').removeClass('d-none');
		$('#table2').addClass('d-none');
		$('#form1').removeClass('d-none');
		$('#form2').addClass('d-none');

		$("input[name=rcvDate]").val(serverDateTo);
		$("input[name=shipReqDate]").val(shipReqDate);
		
		bizGubun = '001';
		contNo = null;
		$('#bizOrderOutTable').DataTable().ajax.reload( function () {});
		$('#bizOrderDtlTable').DataTable().ajax.reload( function () {});
	});

	//내부등록 탭 클릭시
	$('#tab2Nav').on('click',function(){
		uiProc2(true);
		$('#formIn').each(function(){
        	this.reset();
    	});
		sideView = 'add';
		$('#btnSave').addClass('d-none');
		$('#table1').addClass('d-none');
		$('#table2').removeClass('d-none');
		$('#form1').addClass('d-none');
		$('#form2').removeClass('d-none');

		$("input[name=rcvDateIn]").val(serverDateTo);
		$("input[name=shipReqDateIn]").val(shipReqDate);
		
		bizGubun = '002';
		contNo = null;
		$('#bizOrderInTable').DataTable().ajax.reload( function () {});
		$('#bizOrderDtlTable').DataTable().ajax.reload( function () {});
	});

	//영업주문관리 목록조회(외부)
	let bizOrderOutTable = $('#bizOrderOutTable').DataTable({
		dom:  "<'row'<'col-sm-5 col-md-3'l><'col-sm-12 col-md-4'f>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-2'i><'col-sm-12 col-md-5'p>>",
		language : lang_kor,		
		paging : true,
		searching : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : true,
		pageLength : 10,
		//ordering: false,
		ajax : {
			url : '<c:url value="bs/bizOrderAdmList"/>',
			type : 'GET',
			data : {
				'bizGubun': function(){return bizGubun;},
				'startDate' : function(){return rcvDateOutFromCal.replace(/-/g,'');},
				'endDate' : function(){return rcvDateOutToCal.replace(/-/g,'');}
			},
		},
		rowId : 'contNo',
		columns : [ 
				{data : 'contNo'},
				{data : 'rcvDate',
					render: function(data, type, row, meta) {
						return moment(data).format("YYYY-MM-DD");
					}
				}, 
				{data : 'rcvChargrNm'},
				{data : 'poNo'},
				{data : 'ordCorpNm'},
				{data : 'inexGubunNm'},				
				{data : 'contGubunNm'},				
		],
		columnDefs: [
        	{"className": "text-center", "targets": "_all"},
        ],
	    order: [
	        [ 0, 'desc' ]
	    ],
	    
	    
	});

	//영업주문관리 목록조회(내부)
	let bizOrderInTable = $('#bizOrderInTable').DataTable({
		language : lang_kor,		
		paging : true,
		searching : false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : true,
		pageLength : 10,
		//ordering: false,
		ajax : {
			url : '<c:url value="bs/bizOrderAdmList"/>',
			type : 'GET',
			data : {
				'bizGubun': function(){return bizGubun;},
				'startDate' : function(){return rcvDateInFromCal.replace(/-/g,'');},
				'endDate' : function(){return rcvDateInToCal.replace(/-/g,'');}
			},
		},
		rowId : 'contNo',
		columns : [ 
			{data : 'contNo'},
			{data : 'rcvDate',
				render: function(data, type, row, meta) {
					return moment(data).format("YYYY-MM-DD");
				}
			}, 
			{data : 'rcvChargrNm'},
			{data : 'poNo'},
			{data : 'ordCorpNm'},
			{data : 'contClient'},				
			{data : 'contGubunNm'},				
		],
		columnDefs: [
        	{"className": "text-center", "targets": "_all"},
        ],
	    order: [
	    	[ 0, 'desc' ]
	    ],
	    
	});

	//영업주문관리 외부 목록 클릭시
	$('#bizOrderOutTable tbody').on('click','tr', function(){

		if ($('#btnSave').attr('class') == 'btn btn-primary float-right') {
			$('#saveBtnModal').modal('show');
			console.log("등록중입니다.");
			return false;
		}
		
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			
		} else {
			$('#bizOrderOutTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		$('#btnSave').addClass('d-none');
		contNo = bizOrderOutTable.row(this).data().contNo;
		ordCorpCd =  bizOrderOutTable.row(this).data().ordCorpNm; //발주처명
		inexGubun =  bizOrderOutTable.row(this).data().inexGubunNm; //국내/국외명
		contGubunNm = bizOrderOutTable.row(this).data().contGubunNm;  //구분명
		contGubun = bizOrderOutTable.row(this).data().contGubun;    //구분
		sideDtlView="";

        $.ajax({
            url: '<c:url value="/bs/bizOrderAdmRead"/>',
            type: 'GET',
            data: {
               'bizGubun' : function(){return bizGubun;},
               'contNo' : function(){return contNo;}
            },
            success: function (res) {
                let data = res.data;
      			
      			if(res.result == 'ok') {
      				sideView = 'edit';
      				uiProc(true);
                    $('#formOut input[name=contNo]').val(data.contNo);
                    $('#formOut input[name=rcvDate]').val(moment(data.rcvDate).format("YYYY-MM-DD"));
                    $('#formOut input[name=poNo]').val(data.poNo);
                    $('#formOut input[name=rcvChargr]').val(data.rcvChargr);
                    $('#formOut input[name=rcvChargrNm]').val(data.rcvChargrNm);
                    $('#formOut input[name=ordCorpCd]').val(data.ordCorpCd);
                    $('#formOut input[name=ordCorpNm]').val(data.ordCorpNm);
                    $('#formOut input[name=shipReqDate]').val(moment(data.shipReqDate).format("YYYY-MM-DD"));
					

                	//선택박스처리(외부)
                	selectBoxAppend(useYnCode, "useYnOut", data.useYn, "");  //사용여부
                	selectBoxAppend(inexGubunCode, "inexGubunOut", data.inexGubun, "");  //국내/국외
                	selectBoxAppend(contGubunCode, "contGubunOut", data.contGubun, "");  //수주구분
                	//selectBoxAppend(itemGubunCode, "itemGubunOut", data.itemGubun, "2");  //스페셜/표준
                	selectBoxAppend(confirmYnCode, "confirmYnOut", data.confirmYn, "2");  //확정여부
      			} else {
      				toastr.error(res.message);
      			}
            }
        });
        
	
		
		$('#bizOrderDtlTable').DataTable().ajax.reload( function () {});
		console.log(contNo);
	});

	
	//영업주문관리 내부 목록 클릭시
    $('#bizOrderInTable tbody').on('click','tr', function(){

    	if ($('#btnSave').attr('class') == 'btn btn-primary float-right') {
			$('#saveBtnModal').modal('show');
			console.log("등록중입니다.");
			return false;
		}
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			
		} else {
			$('#bizOrderInTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		
		$('#btnSave').addClass('d-none');
		contNo = bizOrderInTable.row(this).data().contNo;
 		ordCorpCd =  bizOrderInTable.row(this).data().ordCorpNm; //발주처명
		inexGubun = '-'; //국내/국외명
		contGubunNm = bizOrderInTable.row(this).data().contGubunNm;  //구분명
		contGubun = bizOrderInTable.row(this).data().contGubun;    //구분
		itemCd = bizOrderInTable.row(this).data().itemNm;			//품명 
		sideDtlView="";
		
		 $.ajax({
	            url: '<c:url value="/bs/bizOrderAdmRead"/>',
	            type: 'GET',
	            data: {
	               'bizGubun' : function(){return bizGubun;},
	               'contNo' : function(){return contNo;}
	            },
	            success: function (res) {
	                let data = res.data;
	      			
	      			if(res.result == 'ok') {
	      				sideView = 'edit';
	      				uiProc2(true);

	      			    $('#formIn input[name=contNoIn]').val(data.contNo);
	                    $('#formIn input[name=rcvDateIn]').val(moment(data.rcvDate).format("YYYY-MM-DD"));
	                    $('#formIn input[name=poNoIn]').val(data.poNo);
	                    $('#formIn input[name=rcvChargrIn]').val(data.rcvChargr);
	                    $('#formIn input[name=rcvChargrNmIn]').val(data.rcvChargrNm);
	                    $('#formIn input[name=ordCorpCdIn]').val(data.ordCorpCd);
	                    $('#formIn input[name=ordCorpNmIn]').val(data.ordCorpNm);
	                    $('#formIn input[name=shipReqDateIn]').val(moment(data.shipReqDate).format("YYYY-MM-DD"));
	                    $('#formIn input[name=contClientIn]').val(data.contClient);
						
	                    
	                	//선택박스처리(외부)
	                	selectBoxAppend(useYnCode, "useYnIn", data.useYn, "");  //사용여부	                	
	                	selectBoxAppend(contGubunCode, "contGubunIn", data.contGubun, "");  //수주구분	         
	                	selectBoxAppend(confirmYnCode, "confirmYnIn", data.confirmYn, "2");  //확정여부
	                	
	               
	      			} else {
	      				toastr.error(res.message);
	      			}
	            }
	        });
	        
		$('#bizOrderDtlTable').DataTable().ajax.reload( function () {});
		console.log(contNo);
	});

  	
	//영업주문상세 목록조회(외부/내부)
	let bizOrderDtlTable = $('#bizOrderDtlTable').DataTable({
		language : lang_kor,	
		destroy : true,	
		paging : true,
		searching : false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : false,
		pageLength : 6,
		//ordering: false,
		ajax : {
			url : '<c:url value="bs/bizOrderDtlList"/>',
			type : 'GET',
			data : {
				'contNo': function(){return contNo;},
				'bizGubun': function(){return bizGubun;}
			},
		},
		rowId : '',
		columns : [ 
				{data : 'contDtlNo'},
				{data : 'itemNm'},
				{data : 'dtlOrdCnt'},
				{data : 'unitCost',
					render: function(data, type, row, meta) {
						if(data!=null){
							return addCommas(Math.floor(data));
						}else{
							return '-';
						}
					}
				},
				{data : 'totalAmt',
					render: function(data, type, row, meta) {
						return addCommas(row['dtlOrdCnt']*row['unitCost']);
					}
				},
				{data : 'shipReqDate',
					render: function(data, type, row, meta) {
						return moment(data).format("YYYY-MM-DD");
					}
				}, 
				{data : 'delayCnt',
					render: function(data, type, row, meta) {
						return '<span style="color:red; font-weight:bold;">'+addCommas(data)+'</span>';
					}},
				{data : 'shipCnt',
					render: function(data, type, row, meta) {
						return '<span style="color:blue; font-weight:bold;">'+addCommas(data)+'</span>';
					}
				},
				{data : 'ordDtlDesc'}
	
		],
		columnDefs: [
			{ targets: [2,3,4,6,7] , render: $.fn.dataTable.render.number( ',' ), className : 'text-right' },
		//	{"className": "text-right", "targets": [4,5]},
        	{"className": "text-center", "targets": "_all"},
        ],
	    order: [
	    	[ 0, 'desc' ]
	    ],
	    
	});


	$('#bizOrderDtlTable tbody').on('click','tr',function(){
		sideDtlView = 'edit';
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			
		} else {
			$('#bizOrderDtlTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		contDtlNo = bizOrderDtlTable.row(this).data().contDtlNo;
		dtlOrdCnt = bizOrderDtlTable.row(this).data().dtlOrdCnt;		
		lotNo = bizOrderDtlTable.row(this).data().lotNo;
		ordDtlDesc = bizOrderDtlTable.row(this).data().ordDtlDesc;	
		
	});


	//영업주문관리(외부 일자)
	var sysdate = "${serverTime}";
	   
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
    
   
	$('#bizOrderOutTable_length').html(html1);
	$('#rcvDateOutFrom').val(serverDateFrom);
	$('#rcvDateOutTo').val(serverDateTo);

	 //영업주문관리(내부 일자)
	 var html1 = '<div class="row">';
	    html1 += '&nbsp;<div class="form-group input-sub m-0 row">';
	    html1 += '<input class="form-control" style="width:97px;" type="text" id="rcvDateInFrom" name="rcvDateInFrom" disabled/>';
	    html1 += '<button onclick="fnPopUpCalendar(rcvDateInFrom,rcvDateInFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="rcvDateInFromCalendar" type="button">';
	    html1 += '<span class="oi oi-calendar"></span>';
	    html1 += '</button>'; 
	    html1 += '</div>';
	    html1 += '&nbsp;~ &nbsp;<div class="form-group input-sub m-0 row">';
	    html1 += '<input class="form-control" style="width:97px;" type="text" id="rcvDateInTo" name="rcvDateInTo" disabled/>';
	    html1 += '<button onclick="fnPopUpCalendar(rcvDateInTo,rcvDateInTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="rcvDateInToCalendar" type="button">';
	    html1 += '<span class="oi oi-calendar"></span>';
	    html1 += '</button>'; 
	    html1 += '</div>';   
	    html1 += '&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnInRetv">조회</button>'
	    html1 += '</div>';
   
  
	$('#bizOrderInTable_length').html(html1);
	$('#rcvDateInFrom').val(serverDateFrom);
	$('#rcvDateInTo').val(serverDateTo);

	$('#btnOutRetv').on('click',function(){
		rcvDateOutFromCal = $('#rcvDateOutFrom').val();
		rcvDateOutToCal = $('#rcvDateOutTo').val();
		
		$('#bizOrderOutTable').DataTable().ajax.reload(function() {});
   		$('#bizOrderDtlTable').DataTable().clear().draw();
   		$('#formOut').each(function(){
           	this.reset();
       	});
      
	});

	 
	$('#btnInRetv').on('click',function(){
		rcvDateInFromCal = $('#rcvDateInFrom').val();
		rcvDateInToCal = $('#rcvDateInTo').val();

		$('#bizOrderInTable').DataTable().ajax.reload(function() {});
		$('#bizOrderDtlTable').DataTable().clear().draw();
		$('#formIn').each(function(){
        	this.reset();
    	});
	});

	

	//등록버튼
	$('#btnAdd').on('click',function(){
		sideView = 'add';
		
		$('#btnSave').removeClass('d-none',false);
		$('#formOut').each(function(){
        	this.reset();
    	});
		$('#formIn').each(function(){
        	this.reset();
    	});

    	$.ajax({
			url : '<c:url value="bs/getContNo"/>',
			type : 'GET',
			data : {
				'bizGubun'  : function(){return bizGubun;}
			},
			success : function(res){
				if(bizGubun == "001"){
					$('input[name=contNo]').val(res.data);
				}else{
					$('input[name=contNoIn]').val(res.data);
				}
			}
        });
		uiProc(false);
		uiProc2(false);
		
		$("input[name=rcvDate]").val(serverDateTo);
		$("input[name=shipReqDate]").val(shipReqDate);

		$("input[name=rcvDateIn]").val(serverDateTo);
		$("input[name=shipReqDateIn]").val(shipReqDate);

		$('#btnEdit').attr('disabled',true);
		
	});

	//수정버튼
	$('#btnEdit').on('click',function(){
		if(sideView != 'edit'){
			toastr.warning("수정할 항목을 선택해주세요.");
			return false;
		}
		uiProc(false);
		uiProc2(false);
		$('#formOut input[name=contNo]').attr('disabled',true);
		$('#formIn input[name=contNo]').attr('disabled',true);

		$('#btnSave').removeClass('d-none');
		sideView = 'edit';
	});

	//수주 등록
	$('#btnSave').on('click',function(){
		console.log(activeTab)
		if(activeTab == "신규등록"){

			//입력값 검사
			if (!$.trim($('#formOut input[name=contNo]').val())) {
				toastr.warning('수주번호를 입력해주세요.');
				$('input[name=contNo]').focus();
				return false;
			}

			/* if (!$.trim($('#formOut input[name=poNo]').val())) {
				toastr.warning('발주번호를 입력해주세요.');
				$('input[name=ordNo]').focus();
				return false;
			} */

			if (!$.trim($('#formOut input[name=ordCorpNm]').val())) {
				toastr.warning('발주처를 선택해주세요.');
				$('button[name=btnOrdCorpCd]').focus();
				return false;
			}
			
			if (!$.trim($('#formOut input[name=rcvChargrNm]').val())) {
				toastr.warning('접수자를 선택해주세요.');
				$('button[name=btnRcvChargr]').focus();
				return false;
			}

			
			if (!$.trim($('#formOut input[name=shipReqDate]').val())) {
				toastr.warning('출하요청일을 선택해주세요.');
				$('input[name=shipReqDate]').focus();
				return false;
			}
			
			if (!$.trim($('#contGubunOut option:selected').val())) {
				toastr.warning('구분을 선택해주세요.');
				$('#contGubunOut').focus();
				return false;
			}
		

			var url = '<c:url value="/bs/bizOrderAdmCreate"/>';

			if (sideView == "edit") {
				url = '<c:url value="/bs/bizOrderAdmUpdate"/>';
			}

			$.ajax({
				url : url,
				type : 'POST',
				data : {
					'bizGubun'      : 		function(){return bizGubun;},
					'contNo'		:		$('#formOut input[name=contNo]').val(),
					'rcvDate'		:		$('#formOut input[name=rcvDate]').val().replace(/-/g,''),
					'poNo'			:		$('#formOut input[name=poNo]').val(),
					'rcvChargr'		:		$('#formOut input[name=rcvChargr]').val(),
					'ordCorpCd'		:		$('#formOut input[name=ordCorpCd]').val(),
					'shipReqDate'	:		$('#formOut input[name=shipReqDate]').val().replace(/-/g,''),
					'inexGubun'		:		$('#inexGubunOut option:selected').val(),
					'contGubun'		:		$('#contGubunOut option:selected').val(),					
					'confirmYn'		:		$('#confirmYnOut option:selected').val(),
					'ordRegDate'	:		$('#rcvDate').val().replace(/-/g,""),
					'useYn'			:		$('#useYnOut option:selected').val(),
				},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						// 보기
						$('#bizOrderOutTable').DataTable().ajax.reload(function() {});
						uiProc(true);
						$('#btnSave').addClass('d-none');
						
						if (sideView == "edit") {
							toastr.success('수정되었습니다.');
							$('#bizOrderDtlTable').DataTable().ajax.reload(function() {});
						}else {
							toastr.success('등록되었습니다.');
						}
						
						$('#btnEdit').attr('disabled',false);
						sideView = 'add';
					}else if(res.result == "exist"){
						toastr.error("이미 등록된 수주번호입니다. 확인해주세요.");
						$('#formOut input[name=contNo]').focus();
					}else {
						toastr.error(res.message);
					}
				},
				complete : function() {
					$('#baseInfoFtTable').DataTable().ajax.reload();
					$('#btnAddConfirm').removeClass('d-none');
					$('#btnAddConfirmLoading').addClass('d-none');
				}
			});
		}else if(activeTab == "내부등록"){
			//입력값 검사
				//입력값 검사
			if (!$.trim($('#formIn input[name=contNoIn]').val())) {
				toastr.warning('수주번호를 입력해주세요.');
				$('input[name=contNoIn]').focus();
				return false;
			}

			if (!$.trim($('#formIn input[name=rcvChargrNmIn]').val())) {
				toastr.warning('접수자를 선택해주세요.');
				$('button[name=btnRcvChargrIn]').focus();
				return false;
			}

			if (!$.trim($('#formIn input[name=ordCorpNmIn]').val())) {
				toastr.warning('발주처를 선택해주세요.');
				$('button[name=btnOrdCorpCdIn]').focus();
				return false;
			}
			
			if (!$.trim($('#formIn input[name=shipReqDateIn]').val())) {
				toastr.warning('출하요청일을 선택해주세요.');
				$('input[name=shipReqDateIn]').focus();
				return false;
			}
		
			var url = '<c:url value="/bs/bizOrderAdmCreate"/>';

			if (sideView == "edit") {
				url = '<c:url value="/bs/bizOrderAdmUpdate"/>';
			}

			$.ajax({
				url : url,
				type : 'POST',
				data : {
					'bizGubun'      : 		function(){return bizGubun;},
					'contNo'		:		$('#formIn input[name=contNoIn]').val(),
					'rcvDate'		:		$('#formIn input[name=rcvDateIn]').val().replace(/-/g,''),
					'poNo'			:		$('#formIn input[name=poNoIn]').val(),
					'rcvChargr'		:		$('#formIn input[name=rcvChargrIn]').val(),
					'ordCorpCd'		:		$('#formIn input[name=ordCorpCdIn]').val(),
					'shipReqDate'	:		$('#formIn input[name=shipReqDateIn]').val().replace(/-/g,''),					
					'contGubun'		:		$('#contGubunIn option:selected').val(),					
					'confirmYn'		:		$('#confirmYnIn option:selected').val(),			
					'ordRegDate'	:		$('#rcvDateIn').val().replace(/-/g,""),
					'useYn'			:		$('#useYnIn option:selected').val(),
					'contClient'	:     	$('#formIn input[name=contClientIn]').val(),					
				},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						// 보기
						$('#bizOrderInTable').DataTable().ajax.reload(function() {});
						uiProc2(true);
						$('#btnSave').addClass('d-none');
						
						if (sideView == "edit") {
							toastr.success('수정되었습니다.');
							$('#bizOrderDtlTable').DataTable().ajax.reload(function() {});
						} else {
							toastr.success('등록되었습니다.');
						}
						$('#btnEdit').attr('disabled',false);
						sideView = 'add';
					}else if(res.result == "exist"){
						toastr.error("이미 등록된 수주번호입니다. 확인해주세요.");
						$('#formOut input[name=contNo]').focus();
					}else {
						toastr.error(res.message);
					}
				},
				complete : function() {
					$('#baseInfoFtTable').DataTable().ajax.reload();
					$('#btnAddConfirm').removeClass('d-none');
					$('#btnAddConfirmLoading').addClass('d-none');
				}
			});
		}
		
	});

	//영업주문상세 버튼
	$('#btnDtlAdd').on('click',function(){
		if(sideView != 'edit'){
			toastr.warning("영업주문관리 항목을 선택해주세요.");
			return false;
		}
		$('#form').each(function(){
        	this.reset();
    	});  
		$('#form6').each(function(){
        	this.reset();
    	});    	
		sideDtlView = 'add';    	
		  
		//작업지시번호 
		$.ajax({
			url : '<c:url value="bs/getWorkOrdNo" />',
			type : 'GET',
			data : {
				'contNo'   : contNo,
				'bizGubun' : bizGubun
				},
			success : function(res){
				if(res.result == "ok"){
				$('#contDtlNo').val(res.data);
				$('#form6 input[name=contDtlNo]').val(res.data);
				}
			}
		});
		if(activeTab == "신규등록"){
			$('#bizOrderDtlPopupModal').modal('show');	
		} else{
			$('#bizOrderInDtlPopupModal').modal('show');	
		}
		
			
		//$('#itemGubunOut').val(contGubun);
		$('#itemCd').val(itemCd);
		uiProc3(false);
		uiProc4(false);
	});

	//영업주문상세 수정버튼
	$('#btnDtlEdit').on('click',function(){
		
		if(sideView != 'edit'){
			toastr.warning("영업주문관리 항목을 선택해주세요.");
			return false;
		}
		if(sideDtlView != 'edit'){
			toastr.warning("수정할 항목을 선택해주세요.");
			return false;
		}
		
		if(activeTab == "신규등록"){
			$('#bizOrderDtlPopupModal').modal('show');	
		} else{
			$('#bizOrderInDtlPopupModal').modal('show');	
		}
	

		$.ajax({
			url : '<c:url value="bs/bizOrderDtlRead"/>',
			type : 'GET',
			data : {
				'bizGubun'      : 		function(){return bizGubun;},
				'contDtlNo'		: 		function(){return contDtlNo;},									
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					if(activeTab == "신규등록"){
						$('#form input[name=contDtlNo]').val(data.contDtlNo);
						$('#form input[name=itemCd]').val(data.itemCd);
						$('#form input[name=itemNm]').val(data.itemNm);
						$('#form input[name=itemRev]').val(data.itemRev);
						$('#form input[name=ordCnt]').val(addCommas(data.dtlOrdCnt));
						$('#form input[name=delayCnt]').val(data.delayCnt);
						$('#form input[name=shipCnt]').val(data.shipCnt);
						$('#form input[name=ordDtlDesc]').val(data.ordDtlDesc);
						selectBoxAppend(itemGubunCode, "itemGubunOut", data.itemGubun, "2");  //스페셜/표준		
						$('#form button[name=btnItemCd]').attr('disabled',true);		
					} else{
						$('#form6 input[name=contDtlNo]').val(data.contDtlNo);
						$('#form6 input[name=bizOrdDtl]').val(data.bizDtlDesc);
						$('#form6 input[name=itemCd]').val(data.itemCd);
						$('#form6 input[name=itemNm]').val(data.itemNm);
						$('#form6 input[name=itemRev]').val(data.itemRev);
						$('#form6 input[name=ordCnt]').val(addCommas(data.dtlOrdCnt));					
						$('#form6 input[name=delayCnt]').val(data.delayCnt);
						$('#form6 input[name=shipCnt]').val(data.shipCnt);
						$('#form6 input[name=ordDtlDesc]').val(data.ordDtlDesc);
							
						$('#form6 button[name=btnItemCd]').attr('disabled',true);		
					}
					
					
				}else {
					toastr.error(res.message);
				}
			},
		});

		
	

	});

	//영업주문상세 삭제버튼
	$('#btnDtlDel').on('click',function(){
		if(sideView != 'edit'){
			toastr.warning("영업주문관리 항목을 선택해주세요.");
			return false;
		}
		if(sideDtlView != 'edit'){
			toastr.warning("삭제할 항목을 선택해주세요.");
			return false;
		}
		if(!$('#bizOrderOutTable tbody tr').hasClass('selected') && !$('#bizOrderInTable tbody tr').hasClass('selected')){
			toastr.warning("삭제할 항목을 선택해주세요.");
			return false;
		}
		if(!$('#bizOrderDtlTable tbody tr').hasClass('selected')){
			toastr.warning("삭제할 항목을 선택해주세요.");
			return false;
		}
		
		
		$.ajax({
			url : '<c:url value="bs/bizOrderDtlDelete" />',
			type : 'POST',
			data : {
				'contDtlNo' : function(){return contDtlNo;},
				'bizGubun' : function(){return bizGubun;},
			
				},
			success : function(res){
				if (res.result == 'ok') {
					// 보기
					$('#bizOrderDtlTable').DataTable().ajax.reload(function() {});
					
					toastr.success('삭제되었습니다.');
					
				}
			}
		});
	});

	//영업주문상세 저장버튼
	$('#btnDtlSave').on('click',function(){

		var check=true;  	

		if(!$.trim($('input[name=itemNm]').val())){
			toastr.warning('품명을 선택해주세요.');
			$('button[name=btnItemCd]').focus();
			check = false;
			return false;
		}
		
		if(!$.trim($('input[name=ordCnt]').val())){
			toastr.warning('주문수량을 입력해주세요.');
			$('input[name=ordCnt]').focus();
			check = false;
			return false;
		}

		if(!$.trim($('input[name=unitCost2]').val())){
			toastr.warning('단가를 입력해주세요.');
			$('input[name=unitCost2]').focus();
			check = false;
			return false;
		}
		

		var url = '<c:url value="/bs/bizOrderDtlCreate"/>';

		if (sideDtlView == "edit") {
			url = '<c:url value="/bs/bizOrderDtlUpdate"/>';
		}

		if(check ==true){
			$.ajax({
				url : url,
				type : 'POST',
				data : {
					'contNo'		:		function(){return contNo;},
					'contDtlNo'		:		$('#form input[name=contDtlNo]').val(),					
					'dtlOrdCnt'		:		$('#form input[name=ordCnt]').val().replace(/,/g,''),
					'itemCd'		:		$('#form input[name=itemCd]').val(),
					'itemRev'		:		$('#form input[name=itemRev]').val(),
					'bizGubun'      : 		function(){return bizGubun;},					
					//'delayCnt'		:		$('#form input[name=delayCnt]').val(),
					//'shipCnt'		:		$('#form input[name=shipCnt]').val(),				
					'contSeq'		: 		function(){return contSeq;},		
					/* 'itemVoltage'	:		$('#form input[name=itemVoltage]').val(),
					'itemOutput'	:		$('#form input[name=itemOutput]').val(),
					'itemSize'		:		$('#form input[name=itemSize]').val(),*/
					'unitCost'		:		$('#form input[name=unitCost2]').val().replace(/,/g,''), 
					'ordDtlDesc'	:       $('#ordDtlDesc').val(),
					'bizDtlDesc'	:		$('#form input[name=bizOrdDtl]').val(),
					'shipReqDate'   :		$('#shipReqDate').val().replace(/-/g,""),
					'contGubun'     :       $('#contGubunOut option:selected').val()
				},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						// 보기
						$('#bizOrderDtlTable').DataTable().ajax.reload(function() {});
						if (sideDtlView == "edit") {
							toastr.success('수정되었습니다.');
						} else {
							toastr.success('등록되었습니다.');
						}
						sideDtlView = 'add';
						$('#bizOrderDtlPopupModal').modal('hide');
					} else if(res.result == "excess"){
						toastr.error("주문수량값을 초과하였습니다. 확인해주세요.");
						$('#dtlOrdCnt').focus();
					} else {
						toastr.error(res.message);
						$('#bizOrderDtlPopupModal').modal('hide');
					}
				},
				complete : function() {
					$('#baseInfoFtTable').DataTable().ajax.reload();
					$('#btnAddConfirm').removeClass('d-none');
					$('#btnAddConfirmLoading').addClass('d-none');
				
				}
			});
		}
	});

	//영업주문상세 저장버튼
	$('#btnDtlSave2').on('click',function(){

		var check=true;  	

		if(!$.trim($('#form6 input[name=itemNm]').val())){
			toastr.warning('품명을 선택해주세요.');
			$('button[name=btnItemCd]').focus();
			check = false;
			return false;
		}
		
		if(!$.trim($('#form6 input[name=ordCnt]').val())){
			toastr.warning('주문수량을 입력해주세요.');
			$('input[name=ordCnt]').focus();
			check = false;
			return false;
		}


		if(!$.trim($('input[name=unitCost2]').val())){
			toastr.warning('단가를 입력해주세요.');
			$('input[name=unitCost2]').focus();
			check = false;
			return false;
		}

		var url = '<c:url value="/bs/bizOrderDtlCreate"/>';

		if (sideDtlView == "edit") {
			url = '<c:url value="/bs/bizOrderDtlUpdate"/>';
		}

		if(check==true){
			$.ajax({
				url : url,
				type : 'POST',
				data : {
					'contNo'		:		function(){return contNo;},
					'contDtlNo'		:		$('#form6 input[name=contDtlNo]').val(),								
					'dtlOrdCnt'		:		$('#form6 input[name=ordCnt]').val().replace(/,/g,''),					
					'itemCd'		:		$('#form6 input[name=itemCd]').val(),
					'bizGubun'      : 		function(){return bizGubun;},
					'bizDtlDesc'     : 		$('#form6 input[name=bizOrdDtl]').val(),
					//'delayCnt'		:		$('#form6 input[name=delayCnt]').val(),
					//'shipCnt'		:		$('#form6 input[name=shipCnt]').val(),		
					'unitCost'		:		$('#form6 input[name=unitCost2]').val().replace(/,/g,''), 		
					'contSeq'		: 		function(){return contSeq;},		
					'itemRev'		:		$('#form6 input[name=itemRev]').val(),                  
					'ordDtlDesc'	:       $('#form6 input[name=ordDtlDesc]').val(),
					'shipReqDate'		:		$('#shipReqDateIn').val().replace(/-/g,""),
					'contGubun'  	:       $('#contGubunIn option:selected').val()
				},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						// 보기
						$('#bizOrderDtlTable').DataTable().ajax.reload(function() {});
						if (sideDtlView == "edit") {
							toastr.success('수정되었습니다.');
						} else {
							toastr.success('등록되었습니다.');
						}
						sideDtlView = 'add';
						$('#bizOrderInDtlPopupModal').modal('hide');
					} else if(res.result == "excess"){
						toastr.error("주문수량값을 초과하였습니다. 확인해주세요.");
						$('#dtlOrdCnt').focus();
					} else {
						toastr.error(res.message);
						$('#bizOrderInDtlPopupModal').modal('hide');
					}
				},
				complete : function() {
					$('#baseInfoFtTable').DataTable().ajax.reload();
					$('#btnAddConfirm').removeClass('d-none');
					$('#btnAddConfirmLoading').addClass('d-none');
				
				}
			});
		}
	});
	
	//접수자 팝업 시작
	var userPopUpTable;
	function selectRcvChargr() {
		if (userPopUpTable == null || userPopUpTable == undefined) {
			userPopUpTable = $('#userPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				pageLength : 15,
				ajax : {
					url : '/sm/matrlUserDataList',
					type : 'GET',
					data : {
						
					}
				},
				rowId : 'userNumber',
				columns : [ {
					data : 'userNm'
				}, {
					data : 'departmentNm'
				}, {
					data : 'postNm'
				}, {
					data : 'chargrDutyNm'
				}, {
					data : 'workplaceNm'
				}, {
					data : 'userDesc'
				}, ],
				columnDefs : [ {
					"targets" : [ 0, 1, 2, 3, 4, 5 ],
					"className" : "text-center"
				} ],
				order : [ [ 0, 'asc' ] ],
			});
			$('#userPopUpTable tbody').on('click', 'tr', function() {
				var data = userPopUpTable.row(this).data();
				if(activeTab == "신규등록"){
					$('#formOut input[name=rcvChargr]').val(data.userNumber);
					$('#formOut input[name=rcvChargrNm]').val(data.userNm);
				}else if(activeTab == "내부등록"){
					$('#formIn input[name=rcvChargrIn]').val(data.userNumber);
					$('#formIn input[name=rcvChargrNmIn]').val(data.userNm);
				}
				
				$('#userPopUpModal').modal('hide');
			});
		} else {
			$('#userPopUpTable').DataTable().ajax.reload(function() {});
		}

		$('#userPopUpModal').modal('show');
	}
	
	//발주처 팝업 시작
   	var dealCorpPopUpTable;
   	function selectOrdCorpCd()
   	{	   	
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
				dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
				language : lang_kor,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				lengthChange: false,
				serverSide : true,
				scrollX : false,
		        pageLength: 15,
				ajax : {
					url : '<c:url value="bm/dealCorpDataList"/>',
					type : 'GET',
					data : {},
				},
				rowId : 'dealCorpCd',
				columns : [{
					data : 'dealCorpCd'
				},{
					data : 'dealCorpNm'
				},{
					data : 'presidentNm'
				},{
					data : 'corpNo'
				}
				],
				columnDefs : [ {
					"defaultContent": "-", "targets": "_all",	"className": "text-center"
				}],
				order : [ [ 0, 'asc' ] ],
				buttons : [],
		    });

		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable.row( this ).data();
		    	if(activeTab == "신규등록"){
					$('#formOut input[name=ordCorpCd]').val(data.dealCorpCd);
					$('#formOut input[name=ordCorpNm]').val(data.dealCorpNm);
				}else if(activeTab == "내부등록"){
					$('#formIn input[name=ordCorpCdIn]').val(data.dealCorpCd);
					$('#formIn input[name=ordCorpNmIn]').val(data.dealCorpNm);
				}
				
                $('#dealCorpPopUpModal').modal('hide');
	
				});
		}else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload(function() {});
		}
		$('#dealCorpPopUpModal').modal('show');		
   	} 
   	
	//품명 팝업 시작
   	var itemMotorPopUpTable;
   	function selectItemCd()
   	{	   	
		if(itemMotorPopUpTable == null || itemMotorPopUpTable == undefined)	{
			itemMotorPopUpTable = $('#itemMotorPopUpTable').DataTable({
				dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
				language : lang_kor,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				lengthChange: false,
		        pageLength: 15,
				ajax : {
					url : '<c:url value="itemMotorList"/>',
					type : 'GET',
					data : {
						'itemGubun' : function(){return contGubun;}
						},
				},
				rowId : 'dealCorpCd',
				columns : [{
					render: function(data, type, row, meta) {		
						return meta.row + meta.settings._iDisplayStart + 1 ;
	    			}
				},{
					data : 'itemCd'
				}, {
					data : 'itemNm'
				}, {
					data : 'itemGubunNm'
				}, {
					data : 'itemRev'
				}, {
					data : 'itemSeries'
				}, {
					data : 'unitCost'
				}
				],
				columnDefs : [ 
					{ targets: [6] , render: $.fn.dataTable.render.number( ',' ), className : 'text-right' },
			        {"defaultContent": "-", "targets": "_all",	"className": "text-center"}
			       ],
				order : [ [ 0, 'asc' ] ],
				buttons : [],
		    });

		    $('#itemMotorPopUpTable tbody').on('click', 'tr', function () {
		    	var data = itemMotorPopUpTable.row( this ).data();
			 	if(activeTab == "신규등록"){
					$('input[name=itemCd]').val(data.itemCd);
					$('input[name=itemNm]').val(data.itemNm);
					$('input[name=itemRev]').val(data.itemRev);
					$('input[name=unitCost2]').val(addCommas(data.unitCost));
				}else if(activeTab == "내부등록"){
					$('input[name=itemCd]').val(data.itemCd);
					$('input[name=itemNm]').val(data.itemNm);
					$('input[name=itemRev]').val(data.itemRev);
					$('input[name=unitCost2]').val(addCommas(data.unitCost));
				}
                $('#itemMotorPopUpModal').modal('hide');
	
				});
		}else{
			$('#itemMotorPopUpTable').DataTable().ajax.reload(function() {});
		}
		$('#itemMotorPopUpModal').modal('show');		
   	} 


	//수주상세등록 컴마생성
	$('.comma').on('keyup',function(event){
		
		$('#form input[name=ordCnt]').val(addCommas(uncomma($('#form input[name=ordCnt]').val())));

		$('#form6 input[name=ordCnt]').val(addCommas(uncomma($('#form6 input[name=ordCnt]').val())));

		$('#form input[name=unitCost2]').val(addCommas(uncomma($('#form input[name=unitCost2]').val())));

		$('#form6 input[name=unitCost2]').val(addCommas(uncomma($('#form6 input[name=unitCost2]').val())));
		
		//$('input[name=unitCost]').val(addCommas(uncomma($('input[name=unitCost]').val())));

		//var ordCntData = $('input[name=ordCnt]').val()==""?0:uncomma($('input[name=ordCnt]').val());
		//var unitCostData = $('input[name=unitCost]').val()==""?0:uncomma($('input[name=unitCost]').val());
		
		//var totalAmtData = addCommas(parseInt(unitCostData)*parseInt(ordCntData));
		
		//$('input[name=totalAmt]').val(totalAmtData);
	});
	

   	
   	
	function uiProc(flag) {
		//$("#formOut input[name=contNo]").attr("disabled", flag);
		$("#formOut input[name=poNo]").attr("disabled", flag);
		$("#formOut input[name=ordCnt]").attr("disabled", flag);
		$("button[name=rcvDateCalendar]").attr("disabled", flag);
		$("button[name=shipReqDateCalendar]").attr("disabled", flag);

		$("button[name=btnRcvChargr]").attr("disabled", flag);
		$("button[name=btnOrdCorpCd]").attr("disabled", flag);
		

		$("#inexGubunOut").attr('disabled',flag);
		$("#contGubunOut").attr('disabled',flag);
		
		$("#confirmYnOut").attr('disabled',flag);
		$("#useYnOut").attr('disabled',flag);
	}

	function uiProc2(flag) {
		//$("#formIn input[name=contNoIn]").attr("disabled", flag);
		$("#formIn input[name=poNoIn]").attr("disabled", flag);
		$('#formIn input[name=contClientIn]').attr("disabled",flag);
		$('#formIn input[name=ordCntIn]').attr("disabled",flag);
		$('#formIn input[name=bizOrdDtlIn]').attr("disabled",flag);
		//$("#formIn input[name=delayCnt]").attr("disabled", flag);
		//$("#formIn input[name=shipCnt]").attr("disabled", flag);
		
		$("button[name=btnRcvChargrIn]").attr("disabled", flag);
		$("button[name=btnOrdCorpCdIn]").attr("disabled", flag);
		$("button[name=btnItemCdIn]").attr("disabled", flag);
		$('button[name=rcvDateCalendarIn]').attr("disabled",flag);
		$('button[name=shipReqDateCalendarIn]').attr("disabled",flag);

		
		$("#contGubunIn").attr('disabled',flag);
		$("#confirmYnIn").attr('disabled',flag);
		$("#useYnIn").attr('disabled',flag);
		
	}

	function uiProc3(flag) {
		$("#form input[name=contNo]").attr("disabled", flag);
		$("#form input[name=poNo]").attr("disabled", flag);
		$("#form input[name=ordCnt]").attr("disabled", flag);
		$("#form input[name=itemVoltage]").attr("disabled", flag);
		$("#form input[name=itemOutput]").attr("disabled", flag);
		$("#form input[name=itemSize]").attr("disabled", flag);
		$("#form input[name=unitCost2]").attr("disabled", flag);
		//$("#form input[name=totalAmt]").attr("disabled", flag);
		$("#form input[name=delayCnt]").attr("disabled", flag);
		$("#form input[name=shipCnt]").attr("disabled", flag);
		$("#form button[name=btnItemCd]").attr("disabled", flag);
	
		$("#itemGubunOut").attr('disabled',flag);
	}

	function uiProc4(flag) {
		$("#form6 input[name=contNo]").attr("disabled", flag);
		$("#form6 input[name=poNo]").attr("disabled", flag);
		$("#form6 input[name=ordCnt]").attr("disabled", flag);
	
		$("#form6 input[name=delayCnt]").attr("disabled", flag);
		$("#form6 input[name=shipCnt]").attr("disabled", flag);
		$("#form6 button[name=btnItemCd]").attr("disabled", flag);
		$("#form input[name=unitCost2]").attr("disabled", flag);
		
	}
	
	
</script>

   	

</body>
</html>
