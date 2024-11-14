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
				<li class="breadcrumb-item"><a href="#">시스템관리</a></li>
				<li class="breadcrumb-item active">사용자관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 66%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"  class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="matrlUserTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>사용자번호</th>
									<th>아이디</th>
									<th>성명</th>									
									<th>부서</th>
									<th>직위</th>
									<th>담당</th>
									<th>조편성</th>
									<th>사업장</th>
									<th>입퇴유무</th>									
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
				<!-- <button type="button" class="btn btn-success float-right">Excel</button> -->
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 33%;">
				<div class="card" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()">
							<i class="mdi mdi-close"></i></a>
						</div>
						<button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
						<button class="btn btn-warning d-none" id="btnEditConfirmLoading" type="button" disabled>
							<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
						</button>
						<button type="button" class="btn btn-primary float-right mr-1"	id="btnAdd">등록</button>
						<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled>
							<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
						</button>
					</div>
					<!--/오른쪽 등록 부분 상단 버튼 영역-->
					<form id="form">
						<div class="table-responsive">
							<table class="table table-bordered">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
								<tr>
									<th>*성명</th>
									<td><input type="text" class="form-control" id="userNm"	name="userNm" maxlength="10"></td>
									<th>사용자번호</th>
									<td><input type="text" class="form-control"	id="userNumber" name="userNumber" disabled></td>
								</tr>
								<tr>
									<th>*아이디</th>
									<td>
										<div class="row">
											<input type="text" class="form-control" id="userId"	name="userId" maxlength="20" onpaste="return false;" oncopy="return false;">
											<button type="button" class="btn btn-primary d-none" id="btnCheck">중복</button>
										</div>
									</td>
									<th>*비밀번호</th>
									<td><input type="password" class="form-control" id="userPw"	name="userPw" maxlength="20" onpaste="return false;" oncopy="return false;"></td>
								</tr>
								<tr>
									<th>*사업장</th>
									<td><select class="custom-select" id="workplaceCd"></select></td>
									<th>직위</th>
									<td><select class="custom-select" id="postCd"></select></td>
								</tr>
								<tr>
									<th>*부서</th>
									<td><select class="custom-select" id="departmentCd"></select></td>
									<th>담당</th>
									<td><select class="custom-select" id="chargrDuty"></select></td>
								</tr>
								<tr>
									<th>입사일</th>
									<td>
										<div class="form-group input-sub m-0">
											<input class="form-control" type="text" id="joinDate" name="joinDate" maxlength="10" disabled />
											<button onclick="fnPopUpCalendar(joinDate,joinDate,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="joinDateCalendar" type="button" disabled>
												<span class="oi oi-calendar"></span>
											</button>
										</div>
									</td>
									<th>조편성</th>
									<td><select class="custom-select" id="teamCd"></select></td>
								</tr>
								<tr>
									<th>퇴사일</th>
									<td>
										<div class="form-group input-sub m-0">
										  <input class="form-control" type="text" id="resignDate" name="resignDate" maxlength="10" disabled/>
										  <button onclick="fnPopUpCalendar(resignDate,resignDate,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="resignDateCalendar" type="button" disabled>
										   <span class="oi oi-calendar"></span>
										  </button> 
										</div>									
									</td>								
									<th>입퇴유무</th>
									<td><select class="custom-select" id="empYnCd"></select></td>
								</tr>
								<tr>
									<th>비고</th>
									<td><input type="text" class="form-control" id="userDesc" name="userDesc" maxlength="256"></td>
									<th>*팝업메뉴여부</th>
									<td><select class="custom-select" id="menuPopupYn"></select></td>
								</tr>
								<tr>
									<th>설비그룹</th>
									<td><select class="custom-select" id="equipGroupCd"></select></td>
									<th> 
									<%
										if(factoryCode.equals("003")) {
									%>
										생산팀 메뉴 자동 이동 권한 
									<%
										}
									%>
									</th>
									
									<td>
									 <%
										if(factoryCode.equals("003")) {
									%>
										<select class="custom-select" id="teamPageMoveYn">
											<!-- <option selected>선택</option>
											<option value="001">사용</option>
											<option value="002">미사용</option> -->
										</select>
									<%
										}
									%>
									</td>
								</tr>
							</table>
						</div>
					</form>
				</div>
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
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
				width : "66%"
			}, 200);
			$("#myrSidenav").animate({
				width : "33%"
			}, 200);
		}
	
		state = !state;
	});

	let menuAuth = 'smsc0010';
	let currentHref = 'smsc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","사용자관리");
		
	let viewIdx;
	let sideView = 'add';
	uiProc(true);
	let check = 0;

	//공통코드 처리 시작
	var departmentCode = new Array(); // 부서
	<c:forEach items="${departmentCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	departmentCode.push(json);
	</c:forEach>

	var empYnCode = new Array(); // 입퇴유무
	<c:forEach items="${empYnCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	empYnCode.push(json);
	</c:forEach>

	var chargrDuty = new Array(); // 담당업무
	<c:forEach items="${chargrDuty}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	chargrDuty.push(json);
	</c:forEach>

	var postCode = new Array(); // 직위
	<c:forEach items="${postCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	postCode.push(json);
	</c:forEach>

	var teamCode = new Array(); // 조편성
	<c:forEach items="${teamCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	teamCode.push(json);
	</c:forEach>

	var equipGroupCode = new Array(); // 설비그룹
	<c:forEach items="${equipGroupCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	equipGroupCode.push(json);
	</c:forEach>

	var workplaceCode = new Array(); // 사업장
	<c:forEach items="${workplaceCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	workplaceCode.push(json);
	</c:forEach>
	
	var menuPopupYnCode = new Array(); // 메뉴팝업
	<c:forEach items="${menuPopupYnCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	menuPopupYnCode.push(json);
	</c:forEach>
	
	//공통코드 처리 종료  

	$("#userNumber").attr("disabled", true);
	let	empYnCd = '001'; 
	//목록
	$.fn.dataTable.ext.errMode = 'none';
	let matrlUserTable = $('#matrlUserTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		 dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange: true,
        pageLength: 20,
		ajax : {
			url : '<c:url value="/sm/matrlUserDataList"/>',
			type : 'GET',
			data : {
				'menuAuth'	 	: 		menuAuth,
				'empYnCd'	 	: 		function(){ return empYnCd;},
			},
		/*
		success : function(res) {
		    console.log(res);
		}
		 */
		},
		rowId : 'matrlUser',
		columns : [
				{ data : 'userNumber' },
				{ data : 'userId' },
				{ data : 'userNm' },
				{ data : 'departmentNm' },
				{ data : 'postNm' },
				{ data : 'chargrDutyNm' },
				{ data : 'teamNm' },
				{ data : 'workplaceNm' },
				{ data : 'empYnNm' }
			],
		columnDefs : [ {
			"defaultContent": "-", "targets": "_all",	"className": "text-center"
		}],
		order : [ [ 0, 'asc' ] ],
        buttons: [
            {
                extend: 'copy',
                title: '사용자관리',
            },
            {
                extend: 'excel',
                title: '사용자관리',
            },
            {
                extend: 'print',
                title: '사용자관리',
            }
        ],
	});
	var htmlMenu  = '<label class="input-label-sm ml-2 mr-2">입퇴유무 : </label><select  class="custom-select" id="empYnSelect" ></select>';
	$('#matrlUserTable_length').html(htmlMenu);
	selectBoxAppend(empYnCode,"empYnSelect","001","1");
	
	$('#empYnSelect').on('change',function(){
		empYnCd = $('#empYnSelect').val();		
		if(empYnCd == '' || empYnCd == null){
			empYnCd = 'all';
		}
		$('#matrlUserTable').DataTable().ajax.reload(function() {});
	});
	// 보기
	$('#matrlUserTable tbody').on('click', 'tr', function() {
		let matrlUser = matrlUserTable.row(this).data().userNumber;
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
			$('#btnCheck').addClass('d-none');
		} else {
			$('#matrlUserTable').DataTable().$('tr.selected').removeClass('selected');
			$('#btnCheck').addClass('d-none');
			$(this).addClass('selected');

			$('#form').each(function() {
				this.reset();
			});
			selectBoxAppend(departmentCode, "departmentCd", "", "2");
			selectBoxAppend(empYnCode, "empYnCd", "Y", "2");
			selectBoxAppend(chargrDuty, "chargrDuty", "", "2");
			selectBoxAppend(postCode, "postCd", "", "2");
			selectBoxAppend(teamCode, "teamCd", "", "2");
			selectBoxAppend(workplaceCode, "workplaceCd", "", "2");
			selectBoxAppend(menuPopupYnCode, "menuPopupYn", "", "2");
			selectBoxAppend(menuPopupYnCode, "teamPageMoveYn", "", "");
			selectBoxAppend(equipGroupCode, "equipGroupCd", "", "2");

			$('#btnSave').addClass('d-none'); // 저장버튼
			// 오른 쪽 목록 read
			$.ajax({
				url : '<c:url value="/sm/matrlUserData"/>',
				type : 'GET',
				data : {
					'menuAuth'		:	menuAuth,
					'userNumber' 	:	matrlUser
				},
				success : function(res) {
					let data = res.data;

					if(res.result == "ok"){
						sideView = 'edit';
						
						// 보기
						$('#userNumber').val(data.userNumber);
						$('#userNm').val(data.userNm);
						if(data.joinDate != null && data.joinDate != ''){
						$('#joinDate').val(moment(data.joinDate).format('YYYY-MM-DD'));
						}
						if(data.resignDate != null && data.resignDate != ''){
							$('#resignDate').val(moment(data.resignDate).format('YYYY-MM-DD'));
						}
						
						$('#userId').val(data.userId);
						$('#userPw').val("");
						$('#userDesc').val(data.userDesc);
						//화면처리
						uiProc(true);
						//선택박스 처리
						selectBoxAppend(departmentCode, "departmentCd", data.departmentCd, "");
						selectBoxAppend(menuPopupYnCode, "menuPopupYn", data.menuPopupYn, "");
						selectBoxAppend(menuPopupYnCode, "teamPageMoveYn", data.teamPageMoveYn, "");
						selectBoxAppend(empYnCode, "empYnCd", data.empYnCd, "");
						selectBoxAppend(chargrDuty, "chargrDuty", data.chargrDuty, "");
						selectBoxAppend(postCode, "postCd", data.postCd, "");
						selectBoxAppend(teamCode, "teamCd", data.teamCd, "");
						selectBoxAppend(workplaceCode, "workplaceCd", data.workplaceCd, "");
						selectBoxAppend(equipGroupCode, "equipGroupCd", data.equipGroupCd, "2");
					} else {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				}
			});
			// 오른 쪽 목록 read
		}
		$('#userId').css({'width': '100%'});
		menuId = matrlUserTable.row(this).data().menuId;
// 		console.log("menuId = " + menuId);
	});

	$('#btnCheck').on('click', function() {
		var checkId = $('#userId').val();
		if(KeyString($.trim($('#userId').val()))){
			toastr.warning("아이디는 4글자 이상 20글자 이하의 영어&숫자조합입니다.");
			$('#userId').val("");
			return false;
		}
		$.ajax({
			url : '<c:url value="/sm/checkIdData"/>',
			type : 'POST',
			data : {
				'menuAuth'	 	: 		menuAuth,
				'userId' : checkId
			},
			success : function(res) {
				if(res.result == "ok"){
					if (res.res != null) {
						if (checkId == res.res.userId) {
							toastr.error('이미 사용중인 아이디입니다.', '', {timeOut: 5000}
							);
							$('#userId').val("");
							$('#userId').focus();
							check = 0;
							return false;
						} else {
							toastr.success('사용가능한 아이디입니다.');
							$('#btnCheck').addClass('d-none');
							$("#userId").attr("disabled", true);
							check = 1;
						}
					} else if (res.res == null) {
						toastr.success('사용가능한 아이디입니다.');
						$('#btnCheck').addClass('d-none');
						$("#userId").attr("disabled", true);
						$('#userId').css({'width': '100%'});
						check = 1;
					}
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			}
		});
	});

	// 등록폼
	$('#btnAdd').on('click', function() {
		sideView = 'add';
		check = 0;
		$('#matrlUserTable').find('tr.selected').removeClass('selected');
		$('#userId').css({'width': '66%'});
		$('#form').each(function() {
			this.reset();
		});
		$.ajax({
   			url: '/sm/userNumberCreate',
	        type: 'POST',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
    		},
	        success: function (res) {
		        if (res.result == "ok") {
	        		$('#userNumber').val(res.data.userNumber);
		        } else {
		        	toastr.error(res.message, '', {timeOut: 5000});
				}
	        }
   		});
   		
		//화면처리        
		uiProc(false);
		//선택박스처리
		selectBoxAppend(departmentCode, "departmentCd", "", "2");
		selectBoxAppend(empYnCode, "empYnCd", "Y", "2");
		selectBoxAppend(chargrDuty, "chargrDuty", "", "2");
		selectBoxAppend(postCode, "postCd", "", "2");
		selectBoxAppend(teamCode, "teamCd", "", "2");
		selectBoxAppend(workplaceCode, "workplaceCd", "", "2");
		selectBoxAppend(menuPopupYnCode, "menuPopupYn", "", "2");
		selectBoxAppend(menuPopupYnCode, "teamPageMoveYn", "", "");
		selectBoxAppend(equipGroupCode, "equipGroupCd", "", "2");
		$('#btnSave').removeClass('d-none');
		$('#btnCheck').removeClass('d-none');
	});

	// 저장 처리
	$('#btnSave').on('click', function() {
		//console.log($('#userPw').val());
		if (!$.trim($('#userNm').val())) {
			toastr.warning('성명을 입력해 주세요.');
			$('#userNm').focus();
			return false;
		}
		if (!$.trim($('#userId').val())) {
			toastr.warning('아이디를 입력해주세요.');
			$('#userId').focus();
			return false;
		}
		if (sideView == "add" && check == 0) {
			toastr.warning('아이디 중복체크를 해주세요');
			$('#btnCheck').focus();
			return false;
		}
		if(sideView == "add" && !$.trim($('#userPw').val())){
			toastr.warning("비밀번호를 입력해주세요.");
			$('#userPw').val("");
			$('#userPw').focus();
			return false;
		} 	
		if(sideView == "add" && $.trim($('#userPw').val()).length < 4){
			toastr.warning("비밀번호는 4자리 이상입력해주세요.");
			$('#userPw').val("");
			$('#userPw').focus();
			return false;
		}
		if(sideView == "edit" && ($.trim($('#userPw').val()).length != 0 && $.trim($('#userPw').val()).length < 4)){
			toastr.warning("비밀번호는 4자리 이상입력해주세요.");
			$('#userPw').val("");
			$('#userPw').focus();
			return false;
		}		
		/* if (!$.trim($('#userPw').val())) {
			toastr.warning('비밀번호를 입력해 주세요.');
			$('#userPw').focus();
			$('#userPw').focus();
			return false;
		} */
		if ($("#workplaceCd option:selected").val() == "") {
			toastr.warning('사업장을 선택해 주세요.');
			$('#workplaceCd').focus();
			return false;
		}
		if ($("#departmentCd option:selected").val() == "") {
			toastr.warning('부서를 선택해 주세요.');
			$('#departmentCd').focus();
			return false;
		}

		if( $('#joinDate').val() != "" && $('#resignDate').val() != "") {
			if( $('#joinDate').val() > $('#resignDate').val() ){
				toastr.warning('퇴사일을 입사일 이후로 지정해주세요.');
				$('#resignDate').focus();
				return false;
			}
		}
		
		if ($("#menuPopupYn option:selected").val() == "") {
			toastr.warning('메뉴팝업여부를 선택해 주세요.');
			$('#menuPopupYn').focus();
			return false;
		}
		/* if ($.trim($('#userPw').val())) {
			toastr.warning('비밀번호는 영문+숫자+특수문자로 입력해 주세요.');
			$('#userPw').focus();
			return false;
		} */
		
		//if ($("#postCd option:selected").val() == "") {
		//	toastr.warning('직위를 선택해 주세요.');
		//	$('#postCd').focus();
		//	return false;
		//}
		//if (!$.trim($('#departmentCd option:selected').val())) {
		//	toastr.warning('부서를 선택해 주세요.');
		//	$('#departmentCd').focus();
		//	return false;
		//}
		//if ($("#chargrDuty option:selected").val() == "") {
		//	toastr.warning('담당을 선택해 주세요.');
		//	$('#chargrDuty').focus();
		//	return false;
		//}
		//if (!$.trim($('#joinDate').val())) {
		//	toastr.warning('입사일을 선택해 주세요.');
		//	$('#joinDateCalendar').focus();
		//	return false;
		//}
		//if ($("#teamCd option:selected").val() == "") {
		//	toastr.warning('조편성을 선택해 주세요.');
		//	$('#teamCd').focus();
		//	return false;
		//}
		//if ($("#empYnCd option:selected").val() == "") {
		//	toastr.warning('입퇴유무를 선택해 주세요.');
		//	$('#empYnCd').focus();
		//	return false;
		//}

		var url = '/sm/matrlUserCreate';
		if (sideView == "edit") {
			url = '/sm/matrlUserUpdate'
		}

		$.ajax({
			url : url,
			type : 'POST',
			data : {
				'menuAuth'		: 		menuAuth,
				'userNumber'	:		$('#userNumber').val(),
				'userId'		:		$('#userId').val(),
				'userNm' 		:		$('#userNm').val(),
				'userPw'		:		$('#userPw').val(),
				'departmentCd'	:		$('#departmentCd option:selected').val(),
				'workplaceCd'	:		$('#workplaceCd option:selected').val(),
				'postCd'		:		$('#postCd option:selected').val(),
				'menuPopupYn'	:		$('#menuPopupYn option:selected').val(),
				'chargrDuty'	:		$('#chargrDuty option:selected').val(),
				'joinDate'		:		$('#joinDate').val().replace(/-/g,""),
				'resignDate'	:		$('#resignDate').val().replace(/-/g,""),
				'empYnCd'		:		$('#empYnCd option:selected').val(),
				'teamCd'		:		$('#teamCd option:selected').val(),
				'userDesc'		:		$('#userDesc').val(),
				'equipGroupCd'	:		$('#equipGroupCd option:selected').val(),
				'teamPageMoveYn':       $('#teamPageMoveYn option:selected').val(),
			},
			beforeSend : function() {
				// $('#btnAddConfirm').addClass('d-none');
				// $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success : function(res) {
				let data = res.data;

				if (res.result == 'ok') {
					// 보기
					$('#userNumber').val(data.userNumber);
					$('#matrlUserTable').DataTable().ajax.reload(function() {
					});
					uiProc(true);
					$('#btnSave').addClass('d-none');
					if (sideView == "edit") {
						toastr.success('수정되었습니다.');
					} else {
						toastr.success('등록되었습니다.');
					}					
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete : function() {
				$('#btnAddConfirm').removeClass('d-none');
				$('#btnAddConfirmLoading').addClass('d-none');
				$('#btnCheck').addClass('d-none');
			}
		});
	});

	// 수정폼
	$('#btnEdit').on('click', function() {
		//alert(sideView);        
		if (sideView != 'edit') {
			toastr.warning("수정할 목록을 선택해 주세요!");
			return false;
		}
		uiProc(false);
		$("#userId").attr("disabled", true);
		sideView = 'edit';
		$("#userNumber").attr("disabled", true);
		$('#btnCheck').addClass('d-none');
		$('#btnSave').removeClass('d-none');

	});

	function uiProc(flag) {
		$("#userId").attr("disabled", flag);
		$("#userNm").attr("disabled", flag);
		$("#userPw").attr("disabled", flag);
		$("#postCd").attr("disabled", flag);
		$("#departmentCd").attr("disabled", flag);
		$("#menuPopupYn").attr("disabled", flag);
		$("#chargrDuty").attr("disabled", flag);
		$("#teamCd").attr("disabled", flag);
		$("#joinDate").attr("disabled", flag);
		$("#joinDateCalendar").attr("disabled", flag);		
		$("#resignDate").attr("disabled", flag);
		$("#resignDateCalendar").attr("disabled", flag);		
		$("#empYnCd").attr("disabled", flag);
		$("#userDesc").attr("disabled", flag);
		$("#workplaceCd").attr("disabled", flag);
		$("#equipGroupCd").attr("disabled", flag);
		$("#teamPageMoveYn").attr("disabled", flag);
	}
	
	/* $('#userId').keyup(function (event) {
 		if ( (	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 65 && event.which <= 90) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 20)	) {
			$('userId').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
		}
		else {
			toastr.warning('영문&숫자만 입력가능합니다.');
			$(this).val("");
			event.preventDefault();
			//$(this).val($(this).val().slice(0,-1));
			return false;
		}
	}); */
	
	function KeyString(elm)
	{			
	    var pattern = /^[a-zA-Z0-9+]{4,20}$/;
		var match = pattern.exec(elm);
		var matchStatus = Boolean(match);
		
	    if(!matchStatus)
	    {	        
	        elm='';
	    }
	    
	    return !matchStatus;
	}
	
	//function PassString(elm)
	//{			
	//    var pattern =  /^(?=.*[a-z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{4,20}$/;
	//	var match = pattern.exec(elm);
	//	var matchStatus = Boolean(match);
	//	
	//    if(!matchStatus)
	//    {	        
	//        elm='';
	//    }
	//    
	//    return !matchStatus;
	//}
	
</script>

</body>
</html>
