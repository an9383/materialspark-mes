<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">자재코드관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn2" onclick="openrNav2()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="matrlCdTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>자재시퀀스</th>
									<th>자재코드</th>
									<th>자재명</th>
									<th>이니셜</th>
									<th>재질</th>
									<th>구분(연질/경질)</th>
									<th>면취(압연)</th>
									<th>두께</th>
									<th>폭</th>
									<th>너비</th>
									<th>길이</th>
									<th>피치</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->

			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar right-sidebar-fix"
				id="rfSidenav" style="width: 33%;">
				<div class="card" id="formBox">
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand2" class="closebtn float-right" onclick="closerNav2()"><i class="mdi mdi-close"></i></a>
						</div>
						<button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
						<button class="btn btn-warning d-none" id="btnEditConfirmLoading" type="button" disabled></button>
						<button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
						<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled></button>
					</div>
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
									<th>자재코드</th>
									<input type="hidden" class="form-control" id="matrlSeq" name="matrlSeq">
									<td><input type="text" class="form-control" id="matrlCd" name="matrlCd"></td>
									<th>*자재명</th>
									<td><input type="text" class="form-control" id="matrlNm" name="matrlNm" maxlength="50"></td>
								</tr>
								<tr>
									<th>*이니셜</th>
									<td><input type="text" class="form-control" id="matrlInitial" name="matrlInitial" maxlength="25"></td>
									<th>*재질</th>
									<td><select class="custom-select" id="qutyCd"></select></td>
								</tr>
								<tr>
									<th><span class="d-none hiddenStar">*</span>구분(연질/경질)</th>
									<td><select class="custom-select" id="gubunCd"></select></td>
									<th>면취(압연)</th>
									<td><select class="custom-select" id="chamferYnCd"></select></td>
								</tr>
								<tr>
									<th><span class="d-none hiddenStar">*</span>두께</th>
									<td><input type="text" class="form-control number-float2" id="thickness" name="thickness" maxlength="10"></td>
									<th><span class="d-none hiddenStar">*</span>표면처리</th>
									<td><select class="custom-select" id="surfaceTrtmtCd"></select></td>
								</tr>
								<tr>
									<th><span class="d-none hiddenStar">*</span>폭</th>
									<td><input type="text" class="form-control number-float1" id="depth" name="depth" maxlength="10"></td>
									<th><span class="d-none hiddenStar">*</span>너비</th>
									<td><input type="text" class="form-control number-float1" id="width" name="width" maxlength="10"></td>
								</tr>
								<tr>
									<th><span class="d-none hiddenStar">*</span>길이</th>
									<td><input type="text" class="form-control number-float1" id="length" name="length" maxlength="10"></td>
									<th><span class="d-none hiddenStar">*</span>피치</th>
									<td><input type="text" class="form-control number-float1" id="pitch" name="pitch" maxlength="10"></td>
								</tr>
								<tr>
									<th>생산단위</th>
									<td><select class="custom-select" id="productUnitCd"></select></td>
									<th>재고단위</th>
									<td><select class="custom-select" id="tmUnitCd"></select></td>
								</tr>
								<tr>
									<th>입고처</th>
									<input type="hidden" class="form-control" id="dealCorpCd" name="dealCorpCd">
									<td>
										<div class="input-sub m-0">
											<input type="text" class="form-control" id="dealCorpNm" name="dealCorpNm">
											<button type="button"
												class="btn btn-primary input-sub-search" id="btnSelDealCorp" onClick="selectDealCorp()">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
									<th>*유수명주기(개월)</th>
									<td><input type="number"  max="999" min="0" maxlength="5" step="1" class="form-control number-float0" id="lifeCycle" name="lifeCycle" maxlength="10"></td>
								</tr>
								<tr>
									<th>체크1(출력)</th>
									<td><input type="text" class="form-control" id="etc1" name="etc1" maxlength="64"></td>
									<th>체크2</th>
									<td><input type="text" class="form-control" id="etc2" name="etc2" maxlength="64"></td>
								</tr>
								<tr>
									<th>*사용여부</th>
									<td><select class="custom-select" id="useYnCd"></select></td>
									<th>*자재구분</th>
									<td><select class="custom-select" id="matrlGubunCd"></select></td>
								</tr>
								<tr>
									<th>*적정재고</th>
									<td><input type="number" step="0.1" style="max-width:100%;" class="form-control number-float1" id="optimumStock" name="optimumStock" maxlength="10"></td>
									<th>비고</th>
									<td><input type="text" style="max-width:100%;" class="form-control" id="matrlDesc" name="matrlDesc" maxlength="256"></td>
								</tr>
								<tr>
									<th>샘플여부</th>
									<td><select class="custom-select" id="matrlSampleYn"></select></td>
									<th>*기본조회여부</th>
									<td><select class="custom-select" id="matrlSelectYn" name="matrlSelectYn"></select></td>
								</tr>
								<tr>
									<th>*결함구분</th>
									<td><select class="custom-select" id="defectCd"></select></td>
									<th>원롤구분</th>
									<td><select class="custom-select" id="rollGubun"></select></td>
								</tr>
								<tr class="d-none" id="fifoCheckTr_F3">
									<th>*선입선출 여부</th>
									<td>
										<select class="custom-select" id="selFifoCheck" disabled>
											<option value="001">적용</option>
											<option value="002">미적용</option>
										</select>
									</td>
									<th></th>
									<td></td>
								</tr>
							</table>
						</div>
					</form>
				</div>
				<!--저장 버튼-->
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
				</div>
				<!--/저장 버튼-->
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

	let menuAuth = 'bmsc0060';
	let currentHref = 'bmsc0060';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자재코드관리");
	
	let viewIdx;
	let sideView = 'add';
	let thickness = '';
	let depth = '';
	let length = '';
	let width = '';
	let pitch = '';
	
	let factoryCode = "<%=factoryCode%>";
	
	if( factoryCode == "003" ) {
		$("#fifoCheckTr_F3").removeClass("d-none");
	}
	
	uiProc(true);

	//공통코드 처리 시작
	var qutyCode = new Array(); // 재질
	<c:forEach items="${qutyCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	qutyCode.push(json);
	</c:forEach>

	var gubunCode = new Array(); // 구분(연질/결질)
	<c:forEach items="${gubunCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	gubunCode.push(json);
	</c:forEach>
	
	var matrlGubunCode = new Array(); // 자재구분
	<c:forEach items="${matrlGubunCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	matrlGubunCode.push(json);
	</c:forEach>

	var chamferYnCode = new Array(); // 면취(압연)
	<c:forEach items="${chamferYnCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	chamferYnCode.push(json);
	</c:forEach>

	var surfaceTrtmtCode = new Array(); // 표면처리
	<c:forEach items="${surfaceTrtmtCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	surfaceTrtmtCode.push(json);
	</c:forEach>

	var productUnitCode = new Array(); // 생산단위
	<c:forEach items="${productUnitCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	productUnitCode.push(json);
	</c:forEach>

	var tmUnitCode = new Array(); // 재고단위
	<c:forEach items="${tmUnitCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	tmUnitCode.push(json);
	</c:forEach>

	var useYnCode = new Array(); // 상태유무
	<c:forEach items="${useYnCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	useYnCode.push(json);
	</c:forEach>

	var matrlSampleYn = new Array(); // 샘플여부
	<c:forEach items="${sampleYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	matrlSampleYn.push(json);
	</c:forEach>

    var pageCountArray=new Array();	//pageCount
    <c:forEach items="${pageCount}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		pageCountArray.push(json);
    </c:forEach>

    let matrlSelectYn = new Array(); // 기본조회여부
	<c:forEach items="${matrlSelectYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	matrlSelectYn.push(json);
	</c:forEach>

    let defectCode = new Array(); // 자재결함구분
	<c:forEach items="${defectCode}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	defectCode.push(json);
	</c:forEach>

	let rollGubunCode = new Array();
	var json = new Object();
	json.baseCd = '001';
	json.baseCdNm = '원롤';
	rollGubunCode.push(json);
	json = new Object();
	json.baseCd = '002';
	json.baseCdNm = '가공롤';
	rollGubunCode.push(json);
	//공통코드 처리 종료  

	$("#matrlCd").attr("disabled", true); 
	$("#dealCorpNm").attr("disabled", true);

	var selectUseYn = '001';

	var pageCd = new Array();
	var pageNm = new Array();
	
	for(var i=0; i<=pageCountArray.length; i++){
		if(i==0){
			pageCd.push(-1);
			pageNm.push("묶음보기(전체)");
		}else{
			pageCd.push(pageCountArray[(i-1)].baseCd);
			pageNm.push(pageCountArray[(i-1)].baseCdNm);
		}
	}
	
	// 목록
	$.fn.dataTable.ext.errMode = 'none';
	let matrlCdTable = $('#matrlCdTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-1'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>B",
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
//         autoWidth: false,
//         scrollX : false,
//         lengthChange: true,
//         pageLength: 20,

        autoWidth: false,
		scrollX: true,
        scrollY : "63vh",
        scrollCollapse: true,
        lengthChange : true,
        lengthMenu : [ pageCd, pageNm ],
        
        ajax: {
            url: '<c:url value="/bm/matrlCdDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 :	  menuAuth,
            	'useYnCd'	 : 	   'Y',
            	'selectUseYn' : function(){return selectUseYn;}
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'matrlSeq',
        columns: [
            { data: 'matrlSeq' },            
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'matrlInitial' },
            { data: 'qutyNm' },
            { data: 'gubunNm' },
            { data: 'chamferYnNm' },
            { data: 'thickness' },
            { data: 'depth' }, 
            { data: 'width' },
            { data: 'length' },                       
            { data: 'pitch' }                                              
        ],
        columnDefs: [
        	{ "targets": [0], "visible" : false },
        ],
        order: [
            [ 1, 'asc' ]
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

	$('#matrlCdTable_paginate').addClass("float-left");
	// 보기
    $('#matrlCdTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#matrlCdTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    	matrlSeq = matrlCdTable.row( this ).data().matrlSeq;
        //console.log("matrlSeq = " + matrlSeq);
        $('#btnSave').addClass('d-none');  // 저장버튼
        $.ajax({
            url: '<c:url value="/bm/matrlCdData"/>',
            type: 'GET',
            data: {
            	'menuAuth'	:  menuAuth,
                'matrlSeq': matrlSeq
            },
            success: function (res) {
                let data = res.data;
      			sideView = 'edit';
                // 보기
                $('#matrlSeq').val(data.matrlSeq);
				$('#matrlCd').val(data.matrlCd);
				$('#matrlNm').val(data.matrlNm);
				$('#matrlInitial').val(data.matrlInitial);
				$('#thickness').val(data.thickness);
				$('#depth').val(data.depth);
				$('#length').val(data.length);
				$('#width').val(data.width);
				$('#pitch').val(data.pitch);
				$('#dealCorpCd').val(data.dealCorpCd);
				$('#dealCorpNm').val(data.dealCorpNm);
				$('#lifeCycle').val(data.lifeCycle);
				$('#etc1').val(data.etc1);
				$('#etc2').val(data.etc2);
				$('#matrlDesc').val(data.matrlDesc);
				$('#optimumStock').val(data.optimumStock);
				
				$('#selFifoCheck').val(data.matrlFifoCheck);
				
				//console.log(data.surfaceTrtmtCd);

				//화면처리
                uiProc(true);

				//선택박스 처리
				selectBoxAppend(qutyCode, "qutyCd", data.qutyCd, "");
                if( data.gubunCd == "" ) {
                	selectBoxAppend(gubunCode, "gubunCd", "", "2");
				}	else {
					selectBoxAppend(gubunCode, "gubunCd", data.gubunCd, "2");
				}
                if( data.chamferYnCd == "" ) {
                	selectBoxAppend(chamferYnCode, "chamferYnCd", "", "2");
				}	else {
					selectBoxAppend(chamferYnCode, "chamferYnCd", data.chamferYnCd, "2");
				}
                if( data.productUnitCd == "" ) {
                	selectBoxAppend(productUnitCode, "productUnitCd", "", "2");
				}	else {
					selectBoxAppend(productUnitCode, "productUnitCd", data.productUnitCd, "2");
				}
                if( data.tmUnitCd == "" ) {
                	selectBoxAppend(tmUnitCode, "tmUnitCd", "", "2");
				}	else {
					selectBoxAppend(tmUnitCode, "tmUnitCd", data.tmUnitCd, "2");
				}
                if( data.surfaceTrtmtCd == "" ) {
                	selectBoxAppend(surfaceTrtmtCode, "surfaceTrtmtCd", "", "2");
				}	else {
					selectBoxAppend(surfaceTrtmtCode, "surfaceTrtmtCd", data.surfaceTrtmtCd, "2");
				}
                if( data.matrlGubunCd == "" ) {
                	selectBoxAppend(matrlGubunCode, "matrlGubunCd", "", "2");
				}	else {
					selectBoxAppend(matrlGubunCode, "matrlGubunCd", data.matrlGubunCd, "2");
				}
                selectBoxAppend(useYnCode, "useYnCd", data.useYnCd, "2");

                if( data.matrlSampleYn == "" ) {
                	selectBoxAppend(matrlSampleYn, "matrlSampleYn", "", "2");
				}	else {
					selectBoxAppend(matrlSampleYn, "matrlSampleYn", data.matrlSampleYn, "2");
				}
                if( data.matrlSelectYn == "" ) {
                	selectBoxAppend(matrlSelectYn, "matrlSelectYn", "", "2");
				}	else {
					selectBoxAppend(matrlSelectYn, "matrlSelectYn", data.matrlSelectYn, "2");
				}
                if ($("#qutyCd option:selected").val() == "001" || $("#qutyCd option:selected").val() == "002" ) {
        			$('.hiddenStar').removeClass('d-none');
        		} else {
        			$('.hiddenStar').addClass('d-none');
            	}
                if( data.defectCd == "" ) {
                	selectBoxAppend(defectCode, "defectCd", "", "2");
				}	else {
					selectBoxAppend(defectCode, "defectCd", data.defectCd, "2");
				}
                if( data.rollGubun == "" ) {
                	selectBoxAppend(rollGubunCode, "rollGubun", "", "2");
				}	else {
					selectBoxAppend(rollGubunCode, "rollGubun", data.rollGubun, "2");
		
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

		$('.hiddenStar').addClass('d-none');
		
		//화면처리        
		uiProc(false);
		//선택박스처리
		selectBoxAppend(qutyCode, "qutyCd", "", "2");
		selectBoxAppend(gubunCode, "gubunCd", "", "2");
		selectBoxAppend(chamferYnCode, "chamferYnCd", "", "2");
		selectBoxAppend(surfaceTrtmtCode, "surfaceTrtmtCd", "", "2");
		selectBoxAppend(productUnitCode, "productUnitCd", "", "2");
		selectBoxAppend(tmUnitCode, "tmUnitCd", "", "2");
		selectBoxAppend(useYnCode, "useYnCd", "001", "2");
		selectBoxAppend(matrlGubunCode, "matrlGubunCd", "", "2");
		selectBoxAppend(matrlSampleYn, "matrlSampleYn", "", "2");
		selectBoxAppend(defectCode, "defectCd", "", "2");
		selectBoxAppend(rollGubunCode, "rollGubun", "", "2");
		
		$('#optimumStock').val('0');
		$('#btnSave').removeClass('d-none');
	});

	$('#qutyCd').change(function() {
		if ($("#qutyCd option:selected").val() == "001" || $("#qutyCd option:selected").val() == "002" ) {
			$('.hiddenStar').removeClass('d-none');
		} else {
			$('.hiddenStar').addClass('d-none');
		}
	});
	
	// 저장 처리
	$('#btnSave').on('click', function() {
		if (!$.trim($('#matrlNm').val())) {
			toastr.warning('자재명을 입력해주세요.');
			$('#matrlNm').focus();
			return false;
		}
		if (!$.trim($('#matrlInitial').val())) {
			toastr.warning('이니셜을 입력해주세요.');
			$('#matrlInitial').focus();
			return false;
		}
		if ($("#qutyCd option:selected").val() == "") {
			toastr.warning('재질을 선택해 주세요.');
			$('#qutyCd').focus();
			return false;
		}

		if ($("#qutyCd option:selected").val() == "001" || $("#qutyCd option:selected").val() == "002" ) {
			if ($("#gubunCd option:selected").val() == "") {
				toastr.warning('재질이 AL/Nicu 이면 구분(연질/경질)은 필수 입력항목입니다.');
				$('#gubunCd').focus();
				return false;
			}
			if (!$.trim($('#thickness').val())) {
				toastr.warning('재질이 AL/Nicu 이면 두께는 필수 입력항목입니다.');
				$('#thickness').focus();
				return false;
			}
			if ($("#surfaceTrtmtCd option:selected").val() == "") {
				toastr.warning('재질이 AL/Nicu 이면 표면처리는 필수 입력항목입니다.');
				$('#surfaceTrtmtCd').focus();
				return false;
			}
			if (!$.trim($('#depth').val())) {
				toastr.warning('재질이 AL/Nicu 이면 폭은 필수 입력항목입니다.');
				$('#depth').focus();
				return false;
			}
			if (!$.trim($('#width').val())) {
				toastr.warning('재질이 AL/Nicu 이면 너비는 필수 입력항목입니다.');
				$('#width').focus();
				return false;
			}
			if (!$.trim($('#length').val())) {
				toastr.warning('재질이 AL/Nicu 이면 길이는 필수 입력항목입니다.');
				$('#length').focus();
				return false;
			}
			if (!$.trim($('#pitch').val())) {
				toastr.warning('재질이 AL/Nicu 이면 피치는 필수 입력항목입니다.');
				$('#pitch').focus();
				return false;
			}
		}
		//if ($("#chamferYnCd option:selected").val() == "") {
		//	toastr.warning('면취(압연) 유무를 선택해 주세요.');
		//	$('#chamferYnCd').focus();
		//	return false;
		//}
		//if ($("#productUnitCd option:selected").val() == "") {
		//	toastr.warning('생산단위를 선택해 주세요.');
		//	$('#productUnitCd').focus();
		//	return false;
		//}
		//if ($("#tmUnitCd option:selected").val() == "") {
		//	toastr.warning('재고단위를 선택해 주세요.');
		//	$('#tmUnitCd').focus();
		//	return false;
		//}
		//if (!$.trim($('#dealCorpCd').val())) {
		//	toastr.warning('입고처를 검색해 주세요.');
		//	$('#btnSelDealCorp').focus();
		//	return false;
		//}
		if (!$.trim($('#lifeCycle').val())) {
			toastr.warning('유수명주기를 입력해 주세요.');
			$('#lifeCycle').focus();
			return false;
		}
		if ($("#useYnCd option:selected").val() == "") {
			toastr.warning('사용여부를 선택해 주세요.');
			$('#useYnCd').focus();
			return false;
		}
		if($("#matrlGubunCd option:selected").val()==""){
			toastr.warning('자재구분을 선택해주세요.');
			$('#matrlGubunCd').focus();
			return false;
		}
		if($("#optimumStock").val() == ""){
			toastr.warning('적정재고를 입력해주세요.');
			$('#optimumStock').focus();
			return false;
		}
		if($('#matrlSelectYn option:selected').val() == ''){
			toastr.warning('기본조회여부를 선택해주세요.');
			$('#matrlSelectYn').focus();
			return false;
		}
		if ($("#defectCd option:selected").val() == "") {
			toastr.warning('자재결함구분을 선택해 주세요.');
			$('#defectCd').focus();
			return false;
		}
		thickness = $('#thickness').val();
		depth = $('#depth').val();
		length = $('#length').val();
		width = $('#width').val();
		pitch = $('#pitch').val();
		
		if($('#thickness').val().match('um') == null && $('#matrlInitial').val().substr(0,1) == 'F')
		{
			thickness = $('#thickness').val().replace(/[^0-9.]/g, "").concat('um');	
			$('#thickness').val(thickness);	
		} else if ( $('#thickness').val().match('mm') == null && $('#matrlInitial').val().substr(0,1) != 'F' ) {
			thickness = $('#thickness').val().replace(/[^0-9.]/g, "").concat('mm')
			$('#thickness').val(thickness);	
		}
		
		if($('#depth').val().match('mm') == null)
		{
			depth = $('#depth').val().concat('mm');		
			$('#depth').val(depth);		
		}
		
		if($('#length').val().match('m') == null)
		{
			length = $('#length').val().concat('m');
			$('#length').val(length);		
		}

		if($('#width').val().match('mm') == null)
		{
			width = $('#width').val().concat('mm');		
			$('#width').val(width);		
		}

		if($('#pitch').val().match('mm') == null)
		{
			pitch = $('#pitch').val().concat('mm');		
			$('#pitch').val(pitch);		
		}
		
		var url;
		if( factoryCode != "003" ) {
			url = '/bm/matrlCdCreate';
		} else {
			
			//자재 코드 예외처리
			let initialCheck = $('#matrlCd').val().replaceAll(' ', '').substring(0, 1);
			if ( initialCheck != 'A' && initialCheck != 'F' && initialCheck != 'N' ) {
				toastr.warning('자재코드 첫 번째 글자는 A, F, N으로 시작해야합니다.');
				$('#matrlCd').focus();
				return false;
			}
			
			//3공장 자재코드 수동 입력으로 변경
			url = '/bm/matrlCdCreate_F3';
		}
		
		if (sideView == "edit") {
			url = '/bm/matrlCdUpdate'
		}

		$.ajax({
			url : url,
			type : 'POST',
			data : {
				'menuAuth' 			: menuAuth,
				'matrlSeq' 			: $('#matrlSeq').val(),
				'matrlCd' 			: $('#matrlCd').val().replaceAll(' ', ''),
				'matrlNm' 			: $('#matrlNm').val(),
				'matrlInitial'		: $('#matrlInitial').val(),
				'matrlGubunCd'		: $('#matrlGubunCd option:selected').val(),
				'qutyCd' 			: $('#qutyCd option:selected ').val(),
				'thickness' 		: thickness,
				'depth' 			: depth,
				'length' 			: length,
				'width' 			: width,
				'pitch' 			: pitch,
				'gubunCd' 			: $('#gubunCd option:selected ').val(),
				'chamferYnCd' 		: $('#chamferYnCd option:selected ').val(),
				'surfaceTrtmtCd' 	: $('#surfaceTrtmtCd option:selected ').val(),
				'productUnitCd' 	: $('#productUnitCd option:selected ').val(),
				'tmUnitCd' 			: $('#tmUnitCd option:selected ').val(),
				'dealCorpCd' 		: $('#dealCorpCd').val(),
				'lifeCycle' 		: $('#lifeCycle').val(),
				'etc1' 				: $('#etc1').val(),
				'etc2' 				: $('#etc2').val(),
				'matrlSampleYn'		: $('#matrlSampleYn option:selected').val(),
				'useYnCd' 			: $('#useYnCd option:selected ').val(),
				'matrlDesc' 		: $('#matrlDesc').val(),
				'optimumStock' 		: $('#optimumStock').val(),
				'matrlSelectYn'     : $('#matrlSelectYn option:selected').val(),
				'defectCd'     		: $('#defectCd option:selected').val(),
				'rollGubun'     	: $('#rollGubun option:selected').val(),
				'matrlFifoCheck'    : $('#selFifoCheck option:selected').val(),
 			},
			beforeSend : function() {
				// $('#btnAddConfirm').addClass('d-none');
				// $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success : function(res) {
				let data = res.data;

				if (res.result == 'ok') {
					// 보기
					$('#matrlCd').val(data.matrlCd);
					$('#matrlCdTable').DataTable().ajax.reload(function() {});
					uiProc(true);
					$('#btnSave').addClass('d-none');
					if (sideView == "edit") {
						toastr.success('수정되었습니다.');
					} else {
						toastr.success('등록되었습니다.');
					}
					sideView = 'edit';
				} else if(res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete : function() {
				$('#btnAddConfirm').removeClass('d-none');
				$('#btnAddConfirmLoading').addClass('d-none');
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
		$("#matrlInitial").attr("disabled", true);
		$('#btnSave').removeClass('d-none');
	});
			
	function uiProc(flag) {
		$("#matrlNm").attr("disabled", flag);
		$("#matrlInitial").attr("disabled", flag);
		$("#matrlGubunCd").attr("disabled",flag);
		$("#qutyCd").attr("disabled", flag);
		$("#thickness").attr("disabled", flag);
		$("#depth").attr("disabled", flag);
		$("#length").attr("disabled", flag);
		$("#width").attr("disabled", flag);
		$("#pitch").attr("disabled", flag);
		$("#gubunCd").attr("disabled", flag);
		$("#chamferYnCd").attr("disabled", flag);
		$("#surfaceTrtmtCd").attr("disabled", flag);
		$("#productUnitCd").attr("disabled", flag);
		$("#tmUnitCd").attr("disabled", flag);
		$("#btnSelDealCorp").attr("disabled", flag);
		$("#lifeCycle").attr("disabled", flag);
		$("#etc1").attr("disabled", flag);
		$("#etc2").attr("disabled", flag);
		$("#matrlSampleYn").attr("disabled",flag);
		$("#useYnCd").attr("disabled", flag);
		$("#matrlDesc").attr("disabled", flag);
		$("#btnSelDealCorp").attr("disabled", flag);
		$("#optimumStock").attr("disabled", flag);
		$("#matrlSelectYn").attr("disabled", flag);
		$("#defectCd").attr("disabled", flag);
		$("#rollGubun").attr("disabled", flag);
		$("#selFifoCheck").attr("disabled", flag);
		
		//3공장인 경우 자재 코드 수동입력
		if( factoryCode == "003" && sideView == "add" ) {
			$("#matrlCd").attr("disabled", flag);
		} else if( factoryCode == "003" && sideView == "edit" ) {
			$("#matrlCd").attr("disabled", true);
		}
		
	}

	var dealCorpPopUpTable;
   	function selectDealCorp()
   	{
   		dealCorpPopUpTable = null;
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        destroy:true,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 :  menuAuth,
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
				$('#dealCorpCd').val(data.dealCorpCd);
				$('#dealCorpNm').val(data.dealCorpNm);
                $('#dealCorpPopUpModal').modal('hide');
		    });
		}
		
		$('#dealCorpPopUpModal').modal('show');
   	}

	var html1 = '<div class="row">';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">사용여부</label><select  class="custom-select" id="selectUseYn" >';
		html1 +='<option value="">전체</option>';
		html1 +='<option value="001" selected>사용 </option>';
		html1 +='<option value="002">미사용</option> </select>&nbsp;';
		html1 += '</div>';
	$('#matrlCdTable_length').append(html1);

	$('#matrlCdTable_length').find('select[name=matrlCdTable_length]').eq(0).attr('id', 'pageCount');
	$("#pageCount").insertAfter("#selectUseYn");
	$('#matrlCdTable_length').find('label').eq(0).remove();
	$("#pageCount").removeClass('custom-select custom-select-sm form-control form-control-sm');
	$("#pageCount").addClass('custom-select ml-2');
	
	$('#selectUseYn').on('change', function(){
		selectUseYn = $('#selectUseYn').val();
		$("#matrlCdTable").DataTable().ajax.reload();
	});

	//dataTable lengthChange
	$(document).on('click','#pageCount',function(e){
		var selectUseYn	= $('#selectUseYn option:selected').val();
		
		$(document).on('change','#pageCount',function(e){
			$('#selectUseYn').val(selectUseYn);
		});
	});
	
	
</script>

</body>
</html>
