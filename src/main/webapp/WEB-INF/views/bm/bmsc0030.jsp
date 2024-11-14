<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">

	<!-- 삭제 확인 모달 시작-->
	<div class="modal fade" id="printModal" tabindex="-1" role="dialog" aria-labelledby="printModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="margin-right: 100vh;">
			<div class="modal-content"  style="width: 100vh;">
				<div class="modal-header">
					<h5 class="modal-title" id="printModalLabel">바코드 프린트 양식</h5>
				</div>
				<div class="modal-body" id="printDiv">
					<table class="table table-sm table-bordered" id="printTable">
						<thead>
							<tr>
								<th style="width: 100px;">설비코드</th>
								<th style="width: 70px;">설비명</th>
								<th style="width: 60px;">사용여부</th>
								<th>바코드</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 삭제 확인 모달 종료 -->
	
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">설비정보관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list"
				style="width: 71%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="equipCodeAdmTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 50px">설비코드</th>
									<th style="min-width: 48px">설비분류</th>
									<th style="min-width: 35px">설비명</th>
									<th style="min-width: 35px">그룹명</th>
									<th style="min-width: 105px">모델명</th>
									<th style="min-width: 25px">전압</th>
									<th style="min-width: 65px">공압</th>
									<th style="min-width: 48px">제작업체</th>
									<th style="min-width: 48px">구입업체</th>
									<th style="min-width: 63px">전화번호</th>
									<th style="min-width: 48px">구매일자</th>
									<!-- 여기서 +3px만 되어도 스크롤바 생김 최대+2 가능-->
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 28%;">
				<div class="card" id="formBox">
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()"><i class="mdi mdi-close"></i></a>
						</div>
						<button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
						<button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
						
						<button type="button" class="btn btn-success float-left" id="btnPrint">바코드 프린트</button>
					</div>
					<form id="form">
						<div class="table-responsive">
							<table class="table table-sm table-bordered mb-2">
								<colgroup>
									<col width="20%">
									<col width="27%">
									<col width="25%">
									<col width="28%">
								</colgroup>
								<tr>
									<th>*설비코드</th>
									<td><input type="text" class="form-control" id="equipCd" name="equipCd" maxlength="20"></td>
									<th>*설비명</th>
									<input type="hidden" class="form-control" id="tempEquipNm" name="tempEquipNm">
									<td><input type="text" class="form-control" id="equipNm" name="equipNm" maxlength="50"></td>
								</tr>
								<tr>
									<th>*설비그룹</th>
									<td><select class="custom-select" id="equipGroup"></select></td>	
									<th>*설비분류</th>
									<td><select class="custom-select" id="equipCtrgy"></select></td>
								</tr>
								<tr>
									<th>모델명</th>
									<td><input type="text" class="form-control" id="modelNm" name="modelNm" maxlength="25"></td>
									<th>제작업체</th>
									<input type="hidden" class="form-control"	id="mfcDealCorpCd" name="mfcDealCorpCd">
									<td>
										<div class="input-sub m-0">
											<input type="text" class="form-control" id="mfcDealCorpNm" name="mfcDealCorpNm" disabled>
											<button type="button" class="btn btn-primary input-sub-search" id="btnSelMfcDealCorp" onClick="selectDealCorp('M')" disabled>
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>									
								</tr>
								<tr>
								<tr>
									<th>구매일</th>
									<td>
										<div class="form-group input-sub m-0">
											<input class="form-control" type="text" id="buyDate" name="buyDate" maxlength="10" disabled />
											<button onclick="fnPopUpCalendar(buyDate,buyDate,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button" disabled>
												<span class="oi oi-calendar"></span>
											</button>
										</div>
									</td>
									<th>구입업체</th>
									<input type="hidden" id="buyDealCorpCd" name="buyDealCorpCd">
									<td>
										<div class="input-sub m-0">
											<input type="text" class="form-control" id="buyDealCorpNm" name="buyDealCorpNm" disabled>
											<button type="button" class="btn btn-primary input-sub-search" id="btnSelBuyDealCorp" onClick="selectDealCorp('B')" disabled>
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
								</tr>
								<tr>
									<th>전압</th>
									<td><input type="text" class="form-control" id="voltage" name="voltage" maxlength="10"></td>
									<th>공압</th>
									<td><input type="text" class="form-control" id="pressure" name="pressure" maxlength="64"></td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td><input type="text" class="form-control" id="telNo" name="telNo" maxlength="20"></td>
									<th>팩스번호</th>
									<td><input type="text" class="form-control" id="faxNo" name="faxNo" maxlength="20"></td>
								</tr>
								<tr>
									<th>설치장소</th>
									<td><select class="custom-select" id="installLocation"></select></td>
									<th>*Capa(용량)</th>
									<td><input type="text" class="form-control number-float0" id="capa" name="capa" maxlength="10"></td>
								</tr>
								<tr>
									<th>etc1</th>
									<td><input type="text" class="form-control" id="etc1" name="etc1" maxlength="64"></td>
									<th>etc2</th>
									<td><select class="custom-select" id="etc2"></select></td>
								</tr>
								<tr>
									<th>설비 라인</th>
									<td><select class="custom-select" id="equipLineCd" name="equipLineCd"></select></td>
									<th>*사용여부</th>
									<td><select class="custom-select" id="useYnCd" name="useYnCd"></select></td>
								</tr>
								<tr>
									<th>가상호기 여부</th>
									<td><select class="custom-select" id="virtualEquip" name="virtualEquip"></select></td>
									<th>*기본조회여부</th>
									<td><select class="custom-select" id="selectYn" name="selectYn"></select></td>
								</tr>
								<tr>
									<th>*열개수</th>
									<td><input type="text" class="form-control" id="equipCapa" name="equipCapa" maxlength="1"></td>
									<th>*TAC TIME</th>
									<td><input type="text" class="form-control" id="equipTacTime" name="equipTacTime" maxlength="5"></td>
								</tr>
								
								<tr class="d-none" id="labelGubun">
									<th>라벨용<br>설비명</th>
									<td><input type="text" class="form-control" id="fakeEquipNm" name="fakeEquipNm"></td>
									<th>라벨용<br>구분</th>
									<td><input type="text" class="form-control" id="fakeDateCd" name="fakeDateCd"></td>
								</tr>
								
								<tr>
								<th>비고</th>
									<td colspan="3"><input type="text" class="form-control"	id="dealCorpDesc" name="dealCorpDesc" style="min-width:100%" maxlength="256" disabled></td>
								
								</tr>
							</table>
						</div>
					</form>
				</div>
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled>
					<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>처리중</button>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 구입업체 모달 시작-->
<!-- <button type="button" class="btn btn-primary"  data-toggle="modal" data-target=".bd-example-modal-lg">제품코드조회</button> -->
<div class="modal fade bd-example-modal-lg" id="dealCorpAdmAdmModal" tabindex="-1" role="dialog" aria-labelledby="dealCorpAdmAdmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="dealCorpAdmAdmPopUpLabel">제조조건 계획 정보</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      <div class="modal-body">
	      	<hr class="text-secondary">
	      	       
                <table id="equipCondCommonAdmTable" class="table table-bordered">                
                    <thead class="thead-light">
                    <tr>
						<th style="min-width: 50px">거래처코드</th>
						<th style="min-width: 50px">거래처명</th>
						<th style="min-width: 50px">이니셜</th>
						<th style="min-width: 50px">대표자</th>
						<th style="min-width: 50px">국가명</th>
						<th style="min-width: 50px">사업자번호</th>
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
<!-- 구입업체 모달 종료-->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'bmsc0030';
	let currentHref = 'bmsc0030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","설비정보관리");
	let sideView = 'add';
	uiProc(true);
	buyDate = null;
	
	let factoryCode = "<%=factoryCode%>";
	
	//공통코드 처리 시작
	var installLocationCode = new Array(); // 설치장소
	<c:forEach items="${installLocation}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	installLocationCode.push(json);
	</c:forEach>
	
	var equipCtrgyCode = new Array(); // 설비분류
	<c:forEach items="${equipCtrgy}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	equipCtrgyCode.push(json);
	</c:forEach>

	var equipGroupCode = new Array(); // 설비분류
	<c:forEach items="${equipGroup}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	equipGroupCode.push(json);
	</c:forEach>
		
	var useYnCode = new Array(); // 사용여부
	<c:forEach items="${useYnCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	useYnCode.push(json);
	</c:forEach>

	var equipLineCode = new Array(); // 설비 라인
	<c:forEach items="${equipLineCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	equipLineCode.push(json);
	</c:forEach>

	var virtualEquipCode = new Array(); // 가상호기
	<c:forEach items="${virtualEquipCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	virtualEquipCode.push(json);
	</c:forEach>

	var dualEquipSet = new Array(); // 가상호기
	<c:forEach items="${dualEquipSet}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	dualEquipSet.push(json);
	</c:forEach>

	var selectYn = new Array(); // 조회여부
	<c:forEach items="${selectYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	selectYn.push(json);
	</c:forEach>
	//공통코드 처리 종료  

	$("#dealCorpNm").attr("disabled", true);
	
	if( factoryCode == "002" ) {
		$('#labelGubun').removeClass('d-none');
	}
	

	// 목록
	$.fn.dataTable.ext.errMode = 'none';
	let equipCodeAdmTable = $('#equipCodeAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : false,
		pageLength : 20,
		//ordering: false,
		ajax : {
			url : '<c:url value="bm/equipCodeAdmDataList"/>',
			type : 'GET',
			data : {
				'menuAuth'	:	menuAuth,
				'useYnCd'	: 	'Y'
				},
		},
		rowId : 'equipCd',
		columns : 
			[ 
				{data : 'equipCd'}, 
				{data : 'equipCtrgyNm'},
				{data : 'equipNm'},
				{data : 'equipGroupNm'},
				{data : 'modelNm'},
				{data : 'voltage'},
				{data : 'pressure'},
				{data : 'mfcDealCorpNm'},
				{data : 'buyDealCorpNm'},
				{data : 'telNo'},
				{ data: 'buyDate',
					render: function(data, type, row) {      
						if(data == "" || data == null || data =='invalid date') {
							return "-" ;
						} else {
							return moment(data.buyDate).format('YYYY-MM-DD');
						}
					}
				},
		],
        order: [
            [ 2, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '설비정보관리',
            },
            {
                extend: 'excel',
                title: '설비정보관리',
            },
            {
                extend: 'print',
                title: '설비정보관리',
            }
        ],
	});

	
	// 보기
	$('#equipCodeAdmTable tbody').on('click','tr',function() {
				if ($(this).hasClass('selected')) {
					//$(this).removeClass('selected');
				} else {
					$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
					$(this).addClass('selected');
				}

				equipCd = equipCodeAdmTable.row(this).data().equipCd;
				console.log("equipCd = " + equipCd);
				$('#formBox').removeClass('d-none');
				$('#btnSave').addClass('d-none'); // 저장버튼
				$('#btnEdit').attr('disabled', false); //수정버튼
				//선택 행 데이터 불러오기
				let val = new Array();
				for (i = 0; i < 10; i++) {
					val[i] = $(this).closest('tr').find('td:eq(' + i + ')')
							.text();
				}
				$.ajax({
					url : '<c:url value="bm/equipCodeAdmView"/>',
					type : 'GET',
					data : {
						'menuAuth'	:	menuAuth,
						'equipCd' : val[0],
						'buyDealCorpCd' : val[7],
					},
					success : function(res) {
						let data = res.data;
						sideView = 'edit';

						$('#form input[name="equipCd"]').val(data.equipCd);
						$('#tempEquipNm').val(data.equipNm);	//modelNo 수정시 변경 감지
						$('#form input[name="equipNm"]').val(data.equipNm);
						$('#form input[name="equipCtrgy"]').val(data.equipCtrgy);
						$('#form input[name="modelNm"]').val(data.modelNm);
						$('#form input[name="mfcDealCorpCd"]').val(data.mfcDealCorpCd);
						$('#form input[name="mfcDealCorpNm"]').val(data.mfcDealCorpNm);						
						$('#form input[name="buyDealCorpCd"]').val(data.buyDealCorpCd);
						$('#form input[name="buyDealCorpNm"]').val(data.buyDealCorpNm);
						if(data.buyDate == "" || data.buyDate == null || data.buyDate =='invalid date') {
							$('#form input[name="buyDate"]').val("");
						} else {
							$('#form input[name="buyDate"]').val(moment(data.buyDate).format('YYYY-MM-DD'));
						}
						$('#form input[name="voltage"]').val(data.voltage);
						$('#form input[name="pressure"]').val(data.pressure);
						$('#form input[name="telNo"]').val(data.telNo);
						$('#form input[name="faxNo"]').val(data.faxNo);
						$('#form input[name="installLocation"]').val(data.installLocation);
						$('#form input[name="capa"]').val(data.capa);
						$('#form input[name="etc1"]').val(data.etc1);
						$('#form input[name="useYnCd"]').val(data.useYnCd);
						$('#form input[name="dealCorpDesc"]').val(data.dealCorpDesc);
						$('#form input[name="regId"]').val(data.regId);
						$('#form input[name="regDate"]').val(moment(data.regDate).format('YYYY-MM-DD'));
						$('#form input[name="updId"]').val(data.updId);
						$('#form input[name="updDate"]').val(moment(data.updDate).format('YYYY-MM-DD'));
						$('#form input[name="equipCapa"]').val(data.equipCapa);
						$('#form input[name="equipTacTime"]').val(data.equipTacTime == "" || data.equipTacTime == null ? 0 : data.equipTacTime);
						
						$('#form input[name="fakeEquipNm"]').val(data.fakeEquipNm);
						$('#form input[name="fakeDateCd"]').val(data.fakeDateCd);

						//화면처리
						uiProc(true);
						$('#mfcDealCorpNm').attr('disabled', true);
						$('#buyDealCorpNm').attr('disabled', true);
						
						//선택박스 처리
						selectBoxAppend(equipGroupCode, "equipGroup", data.equipGroup, "");
						selectBoxAppend(equipCtrgyCode, "equipCtrgy", data.equipCtrgy, "");
						selectBoxAppend(useYnCode, "useYnCd", data.useYnCd, "");
		                if (data.installLocationCode == "" ) {
		                	selectBoxAppend(installLocationCode, "installLocation", "", "2");
		                } else {
							selectBoxAppend(installLocationCode, "installLocation", data.installLocation, "2");
						}
		                if (data.equipLineCd == "" || data.equipLineCd == null) {
		                	selectBoxAppend(equipLineCode, "equipLineCd", "", "2");
						} else {
							selectBoxAppend(equipLineCode, "equipLineCd", data.equipLineCd, "");
						}
						if (data.virtualEquip == "" || data.virtualEquip == null) {
		                	selectBoxAppend(virtualEquipCode, "virtualEquip", "", "2");
						} else {
							selectBoxAppend(virtualEquipCode, "virtualEquip", data.virtualEquip, "");
						}
						if (data.etc2 == "" || data.etc2 == null) {
		                	selectBoxAppend(dualEquipSet, "etc2", "", "2");
						} else {
							selectBoxAppend(dualEquipSet, "etc2", data.etc2, "");
						}
						if (data.selectYn == "" || data.selectYn == null) {
		                	selectBoxAppend(selectYn, "selectYn", "", "2");
						} else {
							selectBoxAppend(selectYn, "selectYn", data.selectYn, "");
						}
					}
				});
			});

	// 등록폼
	$('#btnAdd').on('click', function() {
		sideView = 'add';
		$('#form').each(function() {
			this.reset();
		});

		//화면처리        
		uiProc(false);
		//선택박스처리
		$('#equipTacTime').val(0);
		selectBoxAppend(installLocationCode, "installLocation", "", "2");
		selectBoxAppend(equipGroupCode, "equipGroup", "", "2");
		selectBoxAppend(equipCtrgyCode, "equipCtrgy", "", "2");
		selectBoxAppend(useYnCode, "useYnCd", "001", "2");
		selectBoxAppend(equipLineCode, "equipLineCd", "", "2");
		selectBoxAppend(virtualEquipCode, "virtualEquip", "", "2");
		selectBoxAppend(dualEquipSet, "etc2", "", "2");
		selectBoxAppend(selectYn, "selectYn", "", "2");
		$('#viewBox').addClass('d-none');
		$('#formBox').removeClass('d-none');
		$('#btnEdit').attr('disabled', true);
		$('#btnSave').removeClass('d-none');
	});


	var changeEquipNm = null;	//수정 후 바뀐 equipNm
	var modify = null;			//1이면 변경, 0이면 변경X
	// 저장 처리
	$('#btnSave').on('click',function() {
		if (!$.trim($('#equipCd').val())) {
			toastr.warning('설비코드를 입력해 주세요.');
			$('#equipCd').focus();
			return false;
		} if (!$.trim($('#equipNm').val())) {
			toastr.warning('설비명을 입력해 주세요.');
			$('#equipNm').focus();
			return false;
		} if ($("#equipGroup option:selected").val() == "") {
			$('#equipGroup').focus();
			toastr.warning('설비그룹을 선택해 주세요.');
			return false;			
		} if ($("#equipCtrgy option:selected").val() == "") {
			toastr.warning('설비분류를 선택해 주세요.');
			$('#equipCtrgy').focus();
			return false;
		//} else if (!$.trim($('#modelNm').val())) {
		//	toastr.warning('모델명을 입력해 주세요.');
		//	$('#modelNm').focus();
		//	return false;
		//} else if (!$.trim($('#mfcDealCorpCd').val())) {
		//	toastr.warning('제작업체를 검색해 주세요.');
		//	$('#btnSelMfcDealCorp').focus();
		//	return false;
		//} else if (!$.trim($('#buyDate').val())) {
		//	toastr.warning('구매일을 선택해 주세요.');
		//	$('#buyDateCalendar').focus();
		//	return false;
		//} else if (!$.trim($('#buyDealCorpCd').val())) {
		//	toastr.warning('구입업체를 검색해 주세요.');
		//	$('#btnSelBuyDealCorp').focus();
		//	return false;
		//} else if (!$.trim($('#voltage').val())) {
		//	toastr.warning('전압을 입력해 주세요.');
		//	$('#voltage').focus();
		//	return false;
		//} else if (!$.trim($('#pressure').val())) {
		//	toastr.warning('공압을 입력해 주세요.');
		//	$('#pressure').focus();
		//	return false;
		//} else if ($("#installLocation option:selected").val() == "") {
		//	toastr.warning('설치장소를 선택해 주세요.');
		//	$('#installLocation').focus();
		//	return false;
		} if (!$.trim($('#capa').val())) {
			toastr.warning('Capa(용량)를 입력해 주세요.');
			$('#capa').focus();
			return false;
		//} if ($("#mfcDealCorpCd").val() == null && $("#mfcDealCorpNm").val() != null) {
		//	toastr.warning('제작업체를 검색해주세요.(직접입력 X)');
		//	$('#btnSelMfcDealCorp').focus();
		//	return false;
		//}  if ($("#mfcDealCorpCd").val() == null && $("#mfcDealCorpNm").val() != null) {
		//	toastr.warning('구입업체를  검색해주세요.(직접입력 X)');
		//	$('#btnSelBuyDealCorp').focus();
		//	return false;
		} if ($("#selectYn option:selected").val() == "") {
			toastr.warning('기본조회여부를 선택해 주세요.');
			$('#selectYn').focus();
			return false;
		}

        if($('#mfcDealCorpNm').val() == "") {
        	$('#mfcDealCorpCd').val(null);
		}
        if($('#buyDealCorpNm').val() == "") {
        	$('#buyDealCorpCd').val(null);
		}
        if ($("#equipCapa").val() == "") {
			toastr.warning('열개수를 입력해 주세요.');
			$('#equipCapa').focus();
			return false;
		}

		var url = '<c:url value="bm/equipCodeAdmCreate"/>';
		if (sideView == "edit") {
        	if ( $('#tempEquipNm').val() != $('#equipNm').val() ){
        		changeEquipNm = $('#equipNm').val();	//수정 후 바뀐 ModelNo
        		modify = "1";
			} else {
				modify = "0";
			}
			url = '<c:url value="bm/equipCodeAdmUpdate"/>';
		}
		$.ajax({
			url : url,
			type : 'POST',
			data : {
				'menuAuth'			: menuAuth,
				'equipCd' 			: $('#equipCd').val(),
				'equipNm' 			: $('#equipNm').val(),
				'equipGroup' 		: $('#equipGroup option:selected').val(),
				'equipCtrgy' 		: $('#equipCtrgy option:selected').val(),
				'modelNm' 			: $('#modelNm').val(),
				'mfcDealCorpCd' 	: $('#mfcDealCorpCd').val(),
				'buyDealCorpCd' 	: $('#buyDealCorpCd').val(),
				'buyDealCorpNm' 	: $('#buyDealCorpNm').val(),
				'buyDate' 			: $('#buyDate').val(),
				'voltage'			: $('#voltage').val(),
				'pressure' 			: $('#pressure').val(),
				'telNo' 			: $('#telNo').val(),
				'faxNo'				: $('#faxNo').val(),
				'installLocation' 	: $('#installLocation option:selected').val(),
				'capa' 				: $('#capa').val(),
				'etc1' 				: $('#etc1').val(),
				'etc2'				: $('#etc2 option:selected').val(),
				'manufactrCd' 		: '001',
				'equipLineCd'	 	: $('#equipLineCd option:selected').val(),
				'useYnCd' 			: $('#useYnCd option:selected').val(),
				'virtualEquip'		: $('#virtualEquip option:selected').val(),
				'dealCorpDesc' 		: $('#dealCorpDesc').val(),
				'equipCapa' 		: $('#equipCapa').val(),
				'equipTacTime' 		: $('#equipTacTime').val(),
				'fakeEquipNm' 		: $('#fakeEquipNm').val(),
				'fakeDateCd' 		: $('#fakeDateCd').val(),
				//'regId' 			: 'reg_id',
				//'updId' 			: 'upd_id',
				'modify'			:	modify,
				'selectYn'          : $('#selectYn option:selected').val(),
			},
			beforeSend : function() {
				// $('#btnAddConfirm').addClass('d-none');
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					// 보기
					$('#matrlCd').val(data.matrlCd);
					$('#matrlCdTable').DataTable().ajax .reload(function() {});
					uiProc(true);
					$('#btnSave').addClass('d-none');
					if (sideView == "edit") {
						toastr.success('수정되었습니다.');
					} else {
						toastr.success('등록되었습니다.');
					}
					sideView = 'edit';
				} else if(res.result == 'existEquipCd') {
					toastr.error('중복된 설비코드가 있습니다. 확인바랍니다', '', {timeOut: 5000});
				} else if(res.result == 'existEquipNm') {
					toastr.error('중복된 설비명이 있습니다. 확인바랍니다', '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
				$('#tempEquipNm').val(changeEquipNm);
			},
			complete : function() {
				$('#equipCodeAdmTable').DataTable().ajax.reload();
				$('#btnAddConfirm').removeClass('d-none');
				$('#btnAddConfirmLoading').addClass('d-none');
				$('#btnSelDealCorp').attr('disabled', true);
				$('#mfcDealCorpNm').attr('disabled', true);
				$('#buyDealCorpNm').attr('disabled', true);

				buyDate = null;
			}
		});
	});

	// 수정폼
	$('#btnEdit').on('click', function() {
		if (sideView != 'edit') {
			toastr.warning("수정할 목록을 선택해 주세요!");
			return false;
		}
		uiProc(false);
		//수정관련 기능(설비코드는 수정 불가)
		$('#equipCd').attr('disabled', true);
		$("#mfcDealCorpNm").attr("disabled", false);	
		$("#buyDealCorpNm").attr("disabled", false);	
		$('#viewBox').addClass('d-none');
		$('#formBox').removeClass('d-none');
		$('#btnSave').removeClass('d-none');
	});

	function uiProc(flag) {
		$('#fakeEquipNm').attr('disabled',flag);
		$('#fakeDateCd').attr('disabled',flag);
		$('#equipCapa').attr("disabled", flag);
		$('#equipTacTime').attr('disabled',flag);
		$("#equipCd").attr("disabled", flag);
		$("#equipNm").attr("disabled", flag);
		$("#equipGroup").attr("disabled", flag);		
		$("#equipCtrgy").attr("disabled", flag);
		$("#modelNm").attr("disabled", flag);
		$('#btnSelMfcDealCorp').attr('disabled', flag);	
		$('#btnSelBuyDealCorp').attr('disabled', flag);
		$("#buyDate").attr("disabled", flag);
		$("#buyDateCalendar").attr("disabled", flag);
		$("#pitch").attr("disabled", flag);
		$("#voltage").attr("disabled", flag);
		$("#pressure").attr("disabled", flag);
		$("#telNo").attr("disabled", flag);
		$("#faxNo").attr("disabled", flag);
		$("#installLocation").attr("disabled", flag);
		$("#capa").attr("disabled", flag);
		$("#etc1").attr("disabled", flag);
		$("#etc2").attr("disabled", flag);
		$("#useYnCd").attr("disabled", flag);
		$('#equipLineCd').attr("disabled",flag);
		$("#virtualEquip").attr("disabled", flag);
		$("#dealCorpDesc").attr("disabled", flag);
		$("#regId").attr("disabled", flag);
		$("#regDate").attr("disabled", flag);
		$("#updId").attr("disabled", flag);
		$("#updDate").attr("disabled", flag);
		$('#btnSelDealCorp').attr('disabled', flag);
		$('#btnCheck').attr("disabled",flag);
		$('#selectYn').attr("disabled",flag);
	}

	//거래처정보조회 팝업 시작
	var sFlag;
   	var dealCorpPopUpTable;
   	function selectDealCorp(flag)
   	{
   	   	sFlag = flag;
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	:	menuAuth,
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'dealCorpCd',
		        columns: [
		            { data: 'dealCorpCd' },
		            { data: 'dealCorpNm' },
		            { data: 'initial' },
		            { data: 'presidentNm' },
		            { data: 'country' },
		            { data: 'corpNo' },
		        ],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		    });

		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable.row( this ).data();
		    	if(sFlag == 'M') {
					$('#mfcDealCorpCd').val(data.dealCorpCd);
					$('#mfcDealCorpNm').val(data.dealCorpNm);			    	
			    } else {
					$('#buyDealCorpCd').val(data.dealCorpCd);
					$('#buyDealCorpNm').val(data.dealCorpNm);
				}
                $('#dealCorpPopUpModal').modal('hide');
		    });
		} else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload();
		}
		$('#dealCorpPopUpModal').modal('show');		
   	}   	
	//거래처정보조회 팝업 종료
	
	let printTable;
	
	//바토드 양식 프린트
	$('#btnPrint').on('click', function(){
// 		$('#printModal').modal('show');

		$('#my-spinner').show();

		//print 할 값 불러오기
		if(printTable == null || printTable == undefined)	{
			printTable = $('#printTable').DataTable({
				dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
		        language: lang_kor,
		        lengthChange : false,
		        paging: false,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        searching: false,
		        async: false,
		        ajax: {
		            url: '<c:url value="/bm/equipCodeAdmDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	:	menuAuth,
		            	'useYnCd'	: 	'Y'
		            },
		        },
		        rowId: 'dealCorpCd',
		        columns: [
		              { data: 'equipCd' }
		            , { data: 'equipNm' }
		            , { data: 'useYnCd', 
		            		render: function(data, type, row, meta) {
			            		if(data == "001"){
				            		return "사용";
			            		} else {
			            			return "미사용";
				            	}
							}
			          }
		            , { data: 'equipCd',
			            	render: function(data, type, row, meta) {
			            		var rtn = "<svg id='equipCdBarcode"+meta.row+"'></svg>"
			            		return rtn;
							}
					  }
		        ],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		        drawCallback: function() {
		            var api = this.api();
	
		            for(var i=0; i<api.data().count(); i++){
		            	JsBarcode("#equipCdBarcode"+i, api.row(i).data().equipCd, {
		                	format: "code128",
		                	height: 40,
		                	fontSize : 13,
		            	});
					}
	
		            $('#printTable').attr("style", "");
		    		
		    		$('#printTable thead tr th').attr("style", "font-size: 22px !important; border: 1px solid black !important; color: black !important;");
		    		$('#printTable tbody tr td').attr("style", "font-size: 22px !important; border: 1px solid black !important; color: black !important;");
	
		    		$('#printTable thead tr th').eq(0).attr('style', 'font-size: 22px !important; border: 1px solid black !important; width: 23vh !important; color: black !important;');
		    		$('#printTable thead tr th').eq(1).attr('style', 'font-size: 22px !important; border: 1px solid black !important; width: 15vh !important; color: black !important;');
		    		$('#printTable thead tr th').eq(2).attr('style', 'font-size: 22px !important; border: 1px solid black !important; width: 10vh !important; color: black !important;');
	
		    		console.log(api.data().count());
		    		
		    		if(api.data().count() != 0){
		    			printTimeOut();
		    		}
				}
		    });
		    
		} else {
			$('#printTable').DataTable().ajax.reload();
		}
	    
		function printTimeOut(){
			setTimeout(function(){
				$('#my-spinner').hide();
				$('#printDiv').print();
			}, 1000);
		}

	});
	

</script>

</body>
</html>
