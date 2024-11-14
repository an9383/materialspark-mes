<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">제품코드관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 71%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="goodsCdTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 40px">제품코드</th>
									<th style="min-width: 60px">제품명</th>
									<th style="min-width: 100px">규격</th>
									<th style="min-width: 60px">모델NO</th>
									<th style="min-width: 100px">AL/Nicu</th>
									<th style="min-width: 100px">Film</th>
									<th>면취(압연)</th>
									<th>구분(연질/경질)</th>
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
				<div class="card mb-2" id="formBox">
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()"><i class="mdi mdi-close"></i></a>
						</div>
						<button type="button" class="btn btn-primary float-left" id="btnMatrlAdd" disabled>투입자재 추가</button>
						<button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
						<button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
					</div>
					<form id="form">
						<div class="table-responsive">
							<table class="table table-bordered mb-2">
								<colgroup>
									<col width="20%">
									<col width="27%">
									<col width="25%">
									<col width="28%">
								</colgroup>
								<tr>
									<th>제품코드</th>
									<input type="hidden" class="form-control" id="goodsSeq" name="goodsSeq">
									<td>
										<input type="text" class="form-control" id="goodsCd" name="goodsCd">
									</td>
									<th>*제품명(기종)</th>
									<td>
										<input type="text" class="form-control" id="goodsNm" name="goodsNm" maxlength="25">
									</td>
								</tr>
								<tr>

									<th>*모델NO</th>
									<input type="hidden" class="form-control" id="tempModelNo" name="tempModelNo">
									<td>
										<input type="text" class="form-control" id="modelNo" name="modelNo" maxlength="25">
									</td>
									<th>*단중</th>
									<td>
										<input type="text" class="form-control" id=gravity name="gravity" maxlength="25">
									</td>
								</tr>
								<tr>
									<th>*규격</th>
									<td colspan="3">
										<input type="text" style="max-width: 100%;" class="form-control" id="model" name="model">
									</td>
								</tr>
								<tr>
									<th>*출고처</th>
									<input type="hidden" id="dealCorpCd" name="dealCorpCd">
									<td>
										<div class="input-sub m-0">
											<input type="text" class="form-control" id="dealCorpNm" name="dealCorpNm" maxlength="25">
											<button type="button" class="btn btn-primary input-sub-search" id="btnSelDealCorp" onClick="selectDealCorp()">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
									<th>*재고단위</th>
									<td>
										<select class="custom-select" id="tmUnitCd"></select>
									</td>
								</tr>
								<tr>
									<th>체크1</th>
									<td>
										<input type="text" class="form-control" id="etc1" name="etc1" maxlength="64">
									</td>
									<th>*포장단위</th>
									<td>
										<select class="custom-select" id="packUnitCd"></select>
									</td>
								</tr>
								<tr>
									<th>*사용여부</th>
									<td>
										<select class="custom-select" id="useYnCd"></select>
									</td>
									<th>기종코드</th>
									<td>
										<select class="custom-select" id="gijongCd"></select>
									</td>
								</tr>
								<tr>
									<th>트레이수량</th>
									<td>
										<input type="text" class="form-control" id="productQty" name="productQty" style="text-align: right;" maxlength="10">
									</td>
									<th>TacTime</th>
									<td>
										<input type="text" class="form-control number-float2" id="tecTime" name="tecTime" style="text-align: right;" maxlength="10">
									</td>
								</tr>
								<tr>
									<th>피치</th>
									<td>
										<input type="text" class="form-control number-float1" id="goodsPitch" name="goodsPitch" style="text-align: right;" maxlength="10">
									</td>	
									<th>필름무게</th>
									<td>
										<input type="text" class="form-control number-float8" id="filmWeight" name="filmWeight" style="text-align: right;" maxlength="10">
									</td>							
								</tr>
								<tr>
									<th>LGES코드</th>
									<td>
										<input type="text" class="form-control" id="lgesCode" name="lgesCode" maxlength="15" style="max-width: 100%;">
									</td>
									<th>샘플구분</th>
									<td>
										<select class="custom-select" id="goodsSampleYn"></select>
									</td>
								</tr>
								<tr>
									<th>비고</th>
									<td colspan="3">
										<input type="text" class="form-control" id="goodsDesc" name="goodsDesc" maxlength="256" style="max-width: 100%;">
									</td>
								</tr>
								<tr class="d-none" id="vendor_tr_sld">
									<th>벤더 코드</th>
									<td>
										<input type="text" class="form-control" id="vendorCode" name="vendorCode" maxlength="20" style="max-width: 100%;">
									</td>
									<th></th>
									<td></td>
								</tr>
							</table>

							<h6 class="right-sub-title">AL/Nicu</h6>
							<table class="table table-sm table-bordered mb-2">
								<colgroup>
									<col width="20%">
									<col width="25%">
									<col width="25%">
									<col width="20%">
								</colgroup>
								<tr>
									<th>*자재명</th>
									<input type="hidden" class="form-control" id="alni_matrlCd" name="alni_matrlCd">
									<td colspan="3">
										<div class="input-sub m-0">
											<input type="text" class="form-control" id="alni_matrlNm" name="alni_matrlNm">
											<button type="button" class="btn btn-primary input-sub-search" id="btnSelAlni" onClick="selectMatrlCode('alni');">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
								</tr>
								<tr>
									<th>재질</th>
									<td>
										<input type="text" class="form-control" id="alni_qutyNm" name="alni_qutyNm">
									</td>
									<th>구분(연질/경질)</th>
									<td>
										<input type="text" class="form-control" id="alni_gubunNm" name="alni_gubunNm">
									</td>
								</tr>
								<tr>
									<th>두께</th>
									<td>
										<input type="text" class="form-control" id="alni_thickness" name="alni_thickness">
									</td>
									<th>면취(압연)</th>
									<td>
										<input type="text" class="form-control" id="alni_chamferYnNm" name="alni_chamferYnNm">
									</td>
								</tr>
								<tr>
									<th>폭</th>
									<td>
										<input type="text" class="form-control" id="alni_depth" name="alni_depth">
									</td>
									<th>너비</th>
									<td>
										<input type="text" class="form-control" id="alni_width" name="alni_width">
									</td>
								</tr>
								<tr>
									<th>길이</th>
									<td>
										<input type="text" class="form-control" id="alni_length" name="alni_length">
									</td>
									<th>피치</th>
									<td>
										<input type="text" class="form-control" id="alni_pitch" name="alni_pitch">
									</td>
								</tr>
								<tr>
									<th>표면처리</th>
									<td>
										<input type="text" class="form-control" id="alni_surfaceTrtmtNm" name="alni_surfaceTrtmtNm">
									</td>
									<th>자재코드</th>
									<td>
										<input type="text" class="form-control" id="alni_matrlCode" name="alni_matrlCode" disabled>
									</td>
								</tr>
							</table>
							<h6 class="right-sub-title">Film</h6>
							<table class="table table-sm table-bordered mb-2">
								<colgroup>
									<col width="20%">
									<col width="25%">
									<col width="25%">
									<col width="20%">
								</colgroup>
								<tr>
									<th>*자재명</th>
									<input type="hidden" id="film_matrlCd" name="film_matrlCd">
									<td colspan="3">
										<div class="input-sub m-0">
											<input type="text" class="form-control" id="film_matrlNm" name="film_matrlNm">
											<button type="button" class="btn btn-primary input-sub-search" id="btnSelFilm" onClick="selectMatrlCode('film');">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
								</tr>
								<tr>
									<th>재질</th>
									<td>
										<input type="text" class="form-control" id="film_qutyNm" name="film_qutyNm">
									</td>
									<th>구분(연질/경질)</th>
									<td>
										<input type="text" class="form-control" id="film_gubunNm" name="film_gubunNm">
									</td>
								</tr>
								<tr>
									<th>두께</th>
									<td>
										<input type="text" class="form-control" id="film_thickness" name="film_thickness">
									</td>
									<th>면취(압연)</th>
									<td>
										<input type="text" class="form-control" id="film_chamferYnNm" name="film_chamferYnNm">
									</td>
								</tr>
								<tr>
									<th>폭</th>
									<td>
										<input type="text" class="form-control" id="film_depth" name="film_depth">
									</td>
									<th>너비</th>
									<td>
										<input type="text" class="form-control" id="film_width" name="film_width">
									</td>
								</tr>
								<tr>
									<th>길이</th>
									<td>
										<input type="text" class="form-control" id="film_length" name="film_length">
									</td>
									<th>피치</th>
									<td>
										<input type="text" class="form-control" id="film_pitch" name="film_pitch">
									</td>
								</tr>
								<tr>
									<th>자재코드</th>
									<td>
										<input type="text" class="form-control" id="film_matrlCode" name="film_matrlCode" disabled>
									</td>
									<th></th>
									<td></td>
								</tr>
								<!--==========/table 내용 추가==========-->
							</table>
						</div>
					</form>
				</div>
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled="">
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
<!-- 투입자재 추가  Modal >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>-->
<div class="modal fade bd-example-modal-lg" id="matrlDtlTableModal" tabindex="-1" role="dialog" aria-labelledby="matrlDtlTableModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" style="max-width:70%;">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div> 
			<div class="modal-body">
				<div class="row">
					<div class="col-md-5">
						<h5 class="modal-title" style="padding-left:10px;">자재목록</h5>
						<table id="matrlTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th class="text-center-th">자재코드</th>
									<th class="text-center-th">자재명</th>
									<th class="text-center-th">이니셜</th>
									<th class="text-center-th">재질</th>
									<th class="text-center-th">구분(연질/경질)</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="col-md-7">
						<h5 class="modal-title" id="matrlDtlTableTitle" style="padding-left:10px;"></h5>
						<table id="matrlDtlTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th class="text-center-th">자재코드</th>
									<th class="text-center-th">자재명</th>
									<th class="text-center-th">이니셜</th>
									<th class="text-center-th">재질</th>
									<th class="text-center-th">구분(연질/경질)</th>
									<th class="text-center-th">비고</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer row">
				<p class="mr-a">*추가&삭제는 해당 자재 더블클릭</p>
				<div class="row">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<투입자재 추가  Modal -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'bmsc0010';
	let currentHref = 'bmsc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품코드관리"); 
	
    let sideView = 'add';
    uiInitProc(true);
	uiProc(true);
	$("#dealCorpNm").attr("disabled", true);
	
	let factoryCode = "<%=factoryCode%>";
	
	if( factoryCode == "003" ) {
		$('#vendor_tr_sld').removeClass("d-none");
	}
	
  	//공통코드 처리 시작
    var useYnCode=new Array();
    <c:forEach items="${useYnCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		useYnCode.push(json);
    </c:forEach>
    
    var tmUnitCode=new Array();
    <c:forEach items="${tmUnitCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		tmUnitCode.push(json);
    </c:forEach>

    var packUnitCode=new Array();
    <c:forEach items="${packUnitCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		packUnitCode.push(json);
    </c:forEach>

    var gijongCode=new Array();
    <c:forEach items="${gijongCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		gijongCode.push(json);
    </c:forEach>
    
    var goodsSampleCode=new Array();
    <c:forEach items="${goodsSampleCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsSampleCode.push(json);
    </c:forEach>
	//공통코드 처리 종료
      
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let goodsCodeTable = $('#goodsCdTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/bm/goodsCodeDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth' : menuAuth ,
            	'useYnCd'	: 'Y',
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'goodsCd',
        columns: [
            { data: 'goodsCd', 'className':'text-center' },
            { data: 'goodsNm', 'className':'text-center' },
            { data: 'model' },
            { data: 'modelNo' },
            { data: 'alnicuMatrlNm' },
            { data: 'filmMatrlNm' },
            { data: 'chamferYnNm', 'className':'text-center' },            
            { data: 'gubunNm', 'className':'text-center' },

        ],
        columnDefs: [
            {
                //'targets': [0],
                //'orderable': false,
                //'searchable': false,
            },
        ],
        order: [
            [ 1, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품코드관리',
            },
            {
                extend: 'excel',
                title: '제품코드관리',
            },
            {
                extend: 'print',
                title: '제품코드관리',
            }
        ],
    });

    // 보기
    $('#goodsCdTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#goodsCdTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        
        goodsCd = goodsCodeTable.row( this ).data().goodsCd;
        console.log("goodsCd = " + goodsCd);
        $('#btnSave').addClass('d-none');  // 저장버튼
        $.ajax({
            url: '<c:url value="/bm/goodsCodeData"/>',
            type: 'GET',
            data: {
                'menuAuth' : menuAuth ,
                'goodsCd': goodsCd
            },
            success: function (res) {
                let data = res.data;
                let alnidata = res.alnidata;
                let filmdata = res.filmdata;
                sideView = 'edit';
                // 보기
                $('#goodsSeq').val(data.goodsSeq);
                $('#goodsCd').val(data.goodsCd);
                $('#goodsNm').val(data.goodsNm);
                $('#model').val(data.model);
                $('#modelNo').val(data.modelNo);
                $('#tempModelNo').val(data.modelNo);	//modelNo 수정시 변경 감지
                $('#gravity').val(data.gravity);
                $('#dealCorpNm').val(data.dealCorpNm);
                $('#dealCorpCd').val(data.dealCorpCd);                                                               
                $('#etc1').val(data.etc1);
                $('#tecTime').val(data.tecTime);
                $('#productQty').val(addCommas(data.productQty));	//productQty 추가
                $('#goodsDesc').val(data.goodsDesc);
                $('#vendorCode').val(data.vendorCode);
                
                $('#alni_matrlCd').val(alnidata.matrlCd);
                $('#alni_matrlCode').val(alnidata.matrlCd);
                $('#alni_matrlNm').val(alnidata.matrlNm);
                $('#alni_qutyNm').val(alnidata.qutyNm);
                $('#alni_gubunNm').val(alnidata.gubunNm);
                $('#alni_chamferYnNm').val(alnidata.chamferYnNm);
                $('#alni_thickness').val(alnidata.thickness);
                $('#alni_depth').val(alnidata.depth);
                $('#alni_width').val(alnidata.width);
                $('#alni_length').val(alnidata.length);
                $('#alni_pitch').val(alnidata.pitch);
                $('#alni_surfaceTrtmtNm').val(alnidata.surfaceTrtmtNm);
                $('#film_matrlCode').val(filmdata.matrlCd);
                $('#film_matrlCd').val(filmdata.matrlCd);
                $('#film_matrlNm').val(filmdata.matrlNm);
                $('#film_qutyNm').val(filmdata.qutyNm);
                $('#film_gubunNm').val(filmdata.gubunNm);
                $('#film_chamferYnNm').val(filmdata.chamferYnNm);
                $('#film_thickness').val(filmdata.thickness);
                $('#film_depth').val(filmdata.depth);
                $('#film_width').val(filmdata.width);
                $('#film_length').val(filmdata.length);
                $('#film_pitch').val(filmdata.pitch);  
                $('#goodsPitch').val(data.goodsPitch);
                $('#filmWeight').val(data.filmWeight);
                $('#lgesCode').val(data.lgesCode);
				//화면처리
                uiProc(true);
                $("#dealCorpNm").attr("disabled", true);
                $('#btnMatrlAdd').attr('disabled',false); // 투입자재 추가 버튼
                //선택박스 처리
                selectBoxAppend(packUnitCode, "packUnitCd", data.packUnitCd , "");
                selectBoxAppend(gijongCode, "gijongCd", data.gijongCd , "2");
                selectBoxAppend(tmUnitCode, "tmUnitCd", data.tmUnitCd , ""); 
                selectBoxAppend(useYnCode, "useYnCd", data.useYnCd , "");
                selectBoxAppend(goodsSampleCode, "goodsSampleYn", data.goodsSampleYn, "");
            }
        });
    });

    // 등록폼
    $('#btnAdd').on('click', function() {
        sideView = 'add';
        $('#form').each(function(){
            this.reset();
        });
      	if( false ) {
            //$('#goodsCd').val(data.goodsCd);
            $('#goodsNm').val("DE/SK");
            $('#model').val("0.2*14-PP5.5*45-45.5");
            $('#modelNo').val("162-00036A");
            $('#gravity').val("0.00238");
            $('#etc1').val("체크1");

            $('#goodsDesc').val("비고 제품등록 테스트");
      	}
      	
        $('#alni_matrlCd').val("");
      	$('#film_matrlCd').val("");
      	
		//화면처리
        uiProc(false);
        $('#btnMatrlAdd').attr('disabled',true); // 투입자재 추가 버튼
        //선택박스 처리
        selectBoxAppend(packUnitCode, "packUnitCd", "" , "2");
        selectBoxAppend(gijongCode, "gijongCd", "" , "2");
        selectBoxAppend(tmUnitCode, "tmUnitCd", "" , "2"); 
        selectBoxAppend(useYnCode, "useYnCd", "001" , "");
        selectBoxAppend(goodsSampleCode, "goodsSampleYn", "" , "2");

        $('#productQty').val('0'); //3공장
        $('#tecTime').val('0');
        $('#goodsPitch').val('0'); 
        $('#filmWeight').val('0.00000000');

        $('#btnSave').removeClass('d-none');  // 등록버튼
    });

    // 수정폼
    $('#btnEdit').on('click', function() {
        if(sideView != 'edit') {
        	toastr.warning("수정할 목록을 선택해 주세요!");
            return false;
        }

		uiProc(false);
		//$("#packUnitCd").attr("disabled", true);	//포장단위는 수정 불가능
		$('#btnMatrlAdd').attr('disabled',false);	// 투입자재 추가 버튼
		$("#dealCorpNm").attr("disabled", true);
        $('#btnSave').removeClass('d-none');
    });    


    var changeModelNo = null;	//수정 후 바뀐 modelNo
    var modify = null;			//1이면 변경, 0이면 변경X
    // 등록 처리
    $('#btnSave').on('click', function() {
        if ( !$.trim($('#goodsNm').val()) ) {
            toastr.warning('제품명을 입력해 주세요.');
            $('#goodsNm').focus();
            return false;
        }
        if ( !$.trim($('#modelNo').val()) ) {
            toastr.warning('모델번호를 입력해 주세요.');
            $('#modelNo').focus();
            return false;
        }        
        if ( !$.trim($('#gravity').val()) ) {
            toastr.warning('단중을 입력해 주세요.');
            $('#gravity').focus();
            return false;
        }
        if ( !$.trim($('#model').val()) ) {
            toastr.warning('규격을 입력해 주세요.');
            $('#model').focus();
            return false;
        }
        if ( !$.trim($('#goodsPitch').val()) ) {
            toastr.warning('피치를 입력해 주세요.');
            $('#goodsPitch').focus();
            return false;
        }
        if ( !$.trim($('#filmWeight').val()) ) {
            toastr.warning('필름무게를 입력해 주세요.');
            $('#filmWeight').focus();
            return false;
        }
        /* if ( $("#gijongCd option:selected").val() == "") {
            toastr.warning('기종코드를 선택해 주세요');
            $('#gijongCd').focus();
            return false;
        } */
        if ( !$.trim($('#dealCorpNm').val()) ) {
            toastr.warning('출고처를 선택해 주세요.');
            $('#btnSelDealCorp').focus();
            return false;
        }
        if ( $("#tmUnitCd option:selected").val() == "" ) {
            toastr.warning('재고단위를 선택해 주세요.');
            $('#tmUnitCd').focus();
            return false;
        }              
        if ( $("#packUnitCd option:selected").val() == "" ) {
            toastr.warning('포장단위를 선택해 주세요.');
            $('#packUnitCd').focus();
            return false;
        }
        if ( $("#useYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해 주세요.');
            $('#useYnCd').focus();
            return false;
        }
        if ( $("#goodsSampleYn option:selected").val() == "" ) {
            toastr.warning('샘플구분을 선택해 주세요.');
            $('#goodsSampleYn').focus();
            return false;
        }
        if ( !$.trim($('#alni_matrlCd').val()) ) {
            toastr.warning('Al/Nicu 자재코드 정보를  선택해 주세요.');
            $('#btnSelAlni').focus();
            return false;
        }
        var matrlCd = $('#alni_matrlCd').val().substring(0,1);
        if ( matrlCd != 'A' && matrlCd != 'N' ) {
            toastr.warning('Al/Nicu 선택 시  Al 또는 Nicu 재질 자재코드 정보를  선택해 주세요.');
            return false;
        }
        if ( !$.trim($('#film_matrlCd').val()) ) {
            toastr.warning('Film 자재코드 정보를  선택해 주세요.');
            $('#btnSelFilm').focus();
            return false;
        }
        matrlCd = $('#film_matrlCd').val().substring(0,1);
        if ( matrlCd != 'F') {
            toastr.warning('Film 선택 시  Film 재질 자재코드 정보를  선택해 주세요.');
            $('#btnSelFilm').focus();
            return false;
        }

        


        if($('#dealCorpNm').val() == "") {
        	$('#dealCorpCd').val(null);
		}
        var url = '<c:url value="/bm/goodsCdCreate"/>';

        if( sideView == "edit" ) {
        	if ( $('#tempModelNo').val() != $('#modelNo').val() ){
        		changeModelNo = $('#modelNo').val();	//수정 후 바뀐 ModelNo
        		modify = "1";
			} else {
				modify = "0";
			}
        	url = '<c:url value="/bm/goodsCdUpdate"/>';
        }
        
        $.ajax({
			url: url,
			type: 'POST',
			data: {
				'menuAuth'		: 		menuAuth ,
				'goodsSeq'   	:		$('#goodsSeq').val(),                 
				'goodsCd'   	:		$('#goodsCd').val(),                
				'goodsNm'   	:		$('#goodsNm').val(),
				'gijongCd'		:		$('#gijongCd option:selected').val(),
				'model'      	:		$('#model').val(),
				'modelNo'   	:		$('#modelNo').val(),
				'alnicuMatrlCd' :		$('#alni_matrlCd').val(),
				'filmMatrlCd'   :		$('#film_matrlCd').val(),
				'gravity'      	:		$('#gravity').val(),
				'dealCorpCd'    :		$('#dealCorpCd').val(),
				'tmUnitCd'      :		$("#tmUnitCd option:selected").val(),
				'packUnitCd'    :		$("#packUnitCd option:selected").val(),	            
				'etc1'          :		$('#etc1').val(),
				'productQty'	:		$('#productQty').val().replace(/,/g,''),		//productQty 추가
				'goodsDesc'     :		$('#goodsDesc').val(),
				'vendorCode'     :		$('#vendorCode').val(),
				'useYnCd'       :		$("#useYnCd option:selected").val(),
				'tecTime'		:		$('#tecTime').val(),
				'goodsPitch'	:		$('#goodsPitch').val(),
				'filmWeight'	:		$('#filmWeight').val(),
				'lgesCode'     	:		$('#lgesCode').val(),
				'goodsSampleYn' :		$("#goodsSampleYn option:selected").val(),
				'modify'		:		modify,
			},
			beforeSend: function() {
			  //  $('#btnAddConfirm').addClass('d-none');
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					uiProc(true);
					$('#btnSave').addClass('d-none');
					$('#goodsCd').val(data.goodsCd);
					$('#tempModelNo').val(changeModelNo);
					$('#goodsCdTable').DataTable().ajax.reload( function () {});
					toastr.success(res.message);
					sideView = 'edit';
				} else if (res.result == 'fail' ) {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error' ) {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				//$("#dealCorpNm").attr("disabled", true);
			}
        });
    });

   	function uiProc(flag)
   	{        
        $("#goodsNm").attr("disabled",flag);     
        $('#goodsPitch').attr("disabled",flag);
        $('#filmWeight').attr("disabled",flag);
        $('#tecTime').attr("disabled",flag);    
        $("#model").attr("disabled",flag);               
        $("#presidentNm").attr("disabled",flag);                 
        $("#modelNo").attr("disabled",flag);   
        $("#gravity").attr("disabled",flag);
        $("#tmUnitCd").attr("disabled",flag);
        $("#packUnitCd").attr("disabled",flag);
        $("#etc1").attr("disabled",flag);
        $('#productQty').attr("disabled",flag);		//productQty 추가
        $("#goodsDesc").attr("disabled",flag);
        $("#vendorCode").attr("disabled",flag);
        $("#useYnCd").attr("disabled",flag);
        $("#btnSelAlni").attr("disabled",flag);
        $("#btnSelFilm").attr("disabled",flag);                
        $("#btnSelDealCorp").attr("disabled",flag); 
        $('#gijongCd').attr("disabled",flag);
        $("#lgesCode").attr("disabled",flag);
        $("#goodsSampleYn").attr("disabled",flag);
   	}

   	function uiInitProc(flag)
   	{
        $("#goodsCd").attr("disabled",flag);
        $("#dealCorpNm").attr("disabled",flag);
        
        $("#alni_matrlNm").attr("disabled",flag);                
        $("#alni_qutyNm").attr("disabled",flag);               
        $("#alni_gubunNm").attr("disabled",flag);                 
        $("#alni_thickness").attr("disabled",flag);   
        $("#alni_chamferYnNm").attr("disabled",flag);
        $("#alni_depth").attr("disabled",flag);
        $("#alni_width").attr("disabled",flag);
        $("#alni_length").attr("disabled",flag);
        $("#alni_pitch").attr("disabled",flag);  
        $("#alni_surfaceTrtmtNm").attr("disabled",flag); 

        $("#film_matrlNm").attr("disabled",flag);                
        $("#film_qutyNm").attr("disabled",flag);               
        $("#film_gubunNm").attr("disabled",flag);                 
        $("#film_thickness").attr("disabled",flag);   
        $("#film_chamferYnNm").attr("disabled",flag);
        $("#film_depth").attr("disabled",flag);
        $("#film_width").attr("disabled",flag);
        $("#film_length").attr("disabled",flag);
        $("#film_pitch").attr("disabled",flag);  
        $("#film_surfaceTrtmtNm").attr("disabled",flag);       
   	}   	

   	//자재코드조회 팝업 시작
   	var matrlCdPopUpTable;
   	var qutyTypePopUp;
   	function selectMatrlCode(qutyType)
   	{
   		qutyTypePopUp = qutyType;
   	   	//var url="/cmsc0050?qutyType="+qutyType;
		//window.open(url, "자재코드조회팝업", "width=1200,height=800,left=600");
		matrlCdPopUpTable = null;
		if(matrlCdPopUpTable == null || matrlCdPopUpTable == undefined)	{
		   matrlCdPopUpTable = $('#matrlCdPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        destroy:true,
		        ajax: {
		            url: '<c:url value="/bm/matrlCdDataList"/>',
		            type: 'GET',
		            data: {
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'matrlSeq',
		        columns: [
		            { data: 'matrlCd' },
		            { data: 'matrlNm' },
		            { data: 'matrlInitial' },
		            { data: 'qutyNm' },
		            { data: 'gubunNm' },
		        ],
		        columnDefs: [
		        	{ "targets": [0], "visible" : true },
		        	{"className": "text-center", "targets": "_all"}
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		
		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });

		    $('#matrlCdPopUpTable tbody').on('click', 'tr', function () {
		    	var data = matrlCdPopUpTable.row( this ).data();
                if(qutyTypePopUp == "alni") {
					$('#alni_matrlCd').val(data.matrlCd);
					$('#alni_matrlCode').val(data.matrlCd);
					$('#alni_matrlNm').val(data.matrlNm);
					$('#alni_qutyNm').val(data.qutyNm);
					$('#alni_gubunNm').val(data.gubunNm); 
					$('#alni_chamferYnNm').val(data.chamferYnNm)					             
					$('#alni_thickness').val(data.thickness);
					$('#alni_depth').val(data.depth);
					$('#alni_length').val(data.length);
					$('#alni_width').val(data.width);
					$('#alni_pitch').val(data.pitch);
					$('#alni_surfaceTrtmtNm').val(data.surfaceTrtmtNm);
                } else {
					$('#film_matrlCd').val(data.matrlCd);
					$('#film_matrlCode').val(data.matrlCd);
					$('#film_matrlNm').val(data.matrlNm);
					$('#film_qutyNm').val(data.qutyNm);
					$('#film_gubunNm').val(data.gubunNm);
					$('#film_chamferYnNm').val(data.chamferYnNm)						              
					$('#film_thickness').val(data.thickness);
					$('#film_depth').val(data.depth);
					$('#film_length').val(data.length);
					$('#film_width').val(data.width);
					$('#film_pitch').val(data.pitch);
					$('#film_pitch').val(data.pitch);
				}
                $('#matrlPopUpModal').modal('hide');
		    });
		} else{
				$('#matrlCdPopUpTable').DataTable().ajax.reload();
		}
		$('#matrlPopUpModal').modal('show');		
   	}
  	//자재코드조회 팝업 종료

	//거래처정보조회 팝업 시작
   	var dealCorpPopUpTable = null;
   	function selectDealCorp()
   	{
   	   	//var url="/cmsc0020";
		//window.open(url, "거래처정보조회팝업", "width=1200,height=800,left=600");
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        //destroy:true,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
		            type: 'GET',
		            data: {
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

		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });
		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable.row( this ).data();
				$('#dealCorpCd').val(data.dealCorpCd);
				$('#dealCorpNm').val(data.dealCorpNm);
                $('#dealCorpPopUpModal').modal('hide');
		    });
		} else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload();
		}
		$('#dealCorpPopUpModal').modal('show');
   	}
	//거래처정보조회 팝업 종료  

	
	
	//투입자재 추가 > 투입할 자재목록 테이블
	let matrlTable = $('#matrlTable').DataTable({
        language: lang_kor,
        lengthChange : false,
        paging: true,
        info: true,
        ordering: true,
        processing: false,
        autoWidth: false,
        pageLength: 15,
        select: {
		    style: 'single',
		    toggleable: false,
		    items: 'row',
		    info: false
		},
        ajax: {
            url: '<c:url value="/bm/matrlCdDataList"/>',
            type: 'GET',
            data: {
            },
        },
        rowId: 'matrlSeq',
        columns: [
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'matrlInitial' },
            { data: 'qutyNm' },
            { data: 'gubunNm' },
        ],
        columnDefs: [
        	{ "targets": [0], "visible" : true },
        	{"className": "text-center p-2", "targets": "_all"}
        ],
        order: [
            [ 0, 'asc' ]
        ],

        buttons: [
            'copy', 'excel', 'pdf', 'print'
        ],
    });

	//투입자재 추가 > 투입한 자재목록 테이블
	let matrlDtlTable = $('#matrlDtlTable').DataTable({
        language: lang_kor,
        lengthChange : false,
        paging: true,
        info: true,
        ordering: true,
        processing: false,
        autoWidth: false,
        pageLength: 15,
        select: {
		    style: 'single',
		    toggleable: false,
		    items: 'row',
		    info: false
		},
        ajax: {
            url: '<c:url value="/bm/goodsMatrlDtlListAll"/>',
            type: 'POST',
            data: {
                'goodsCd'	:	function(){ return $('#goodsCd').val(); }
            },
        },
        columns: [
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'matrlInitial' },
            { data: 'qutyNm' },
            { data: 'gubunNm' },
            { data: 'goodsMatrlDesc', className: 'p-1',
           		render : function(data, type, row, meta) {
           			return '<input type="text" class="form-control mw-100" name="goodsMatrlDesc" id="goodsMatrlDesc-' + meta.row + '" value="' + data + '">';
				}
            }
        ],
        columnDefs: [
        	{ "targets": [0], "visible" : true },
        	{"className": "text-center p-2", "targets": "_all"}
        ],
        order: [
            [ 0, 'asc' ]
        ],

        buttons: [
            'copy', 'excel', 'pdf', 'print'
        ],
        drawCallback: function() {
        	//투입자재 수정 > 투입한 자재목록 비고 ENTER
		    $("input[name=goodsMatrlDesc]").keypress(function (e) {
				if (e.which == 13) {
					var dtlInGoodsMatrlDesc = $(this).val();
			    	$.ajax({
			            url: '<c:url value="/bm/goodsMatrlDtlEdit"/>',
			            data: {
			                'goodsCd'			:	$('#goodsCd').val(),
			                'matrlCd'			:	matrlDtlTable.row('.selected').data().matrlCd,
			                'goodsMatrlDesc'	:	dtlInGoodsMatrlDesc
			            },
			            type: 'POST',
			            success: function(res){
			            	if(res.result == 'ok') {
			            		toastr.success("자재가 수정되었습니다.");
			                	$('#matrlDtlTable').DataTable().ajax.reload( function () {});
			            	} else if(res.result == 'error') {
			            		toastr.error(res.message);
			            	}
			         	},
				        error: function(xhr,textStatus,error){
				              console.log("textStatus: "+xhr.status+", error: "+error);
				              toastr.error("예상치 못한 오류가 발생했습니다.");
				        },
			        });
				}
		    });
        }
    });

    //투입자재 추가 > 투입할 자재목록 테이블 dblclick
    $('#matrlTable tbody').on('dblclick','tr',function() {
        var dtlInMatrlCd = matrlTable.row(this).data().matrlCd;
        if(matrlDtlTable.data().toArray().some(el => el.matrlCd == dtlInMatrlCd)) {
            toastr.warning('이미 추가된 자재입니다.');
            return false;
        }
    	$.ajax({
            url: '<c:url value="/bm/goodsMatrlDtlAdd"/>',
            data: {
                'goodsCd'			:	$('#goodsCd').val(),
                'matrlCd'			:	dtlInMatrlCd,
                'goodsMatrlDesc'	:	''
            },
            type: 'POST',
            success: function(res){
            	if(res.result == 'ok') {
            		toastr.success("자재가 추가되었습니다.");
                	$('#matrlDtlTable').DataTable().ajax.reload( function () {});
            	} else if(res.result == 'error') {
            		toastr.error(res.message);
            	}
         	},
	        error: function(xhr,textStatus,error){
	              console.log("textStatus: "+xhr.status+", error: "+error);
	              toastr.error("예상치 못한 오류가 발생했습니다.");
	        },
        });
    });

  	//투입자재 삭제 > 투입한 자재목록 테이블 dblclick
    $('#matrlDtlTable tbody').on('dblclick','tr',function() {
        var dtlInMatrlCd = matrlDtlTable.row(this).data().matrlCd;
    	$.ajax({
            url: '<c:url value="/bm/goodsMatrlDtlDelete"/>',
            data: {
                'goodsCd'			:	$('#goodsCd').val(),
                'matrlCd'			:	dtlInMatrlCd
            },
            type: 'POST',
            success: function(res){
            	if(res.result == 'ok') {
            		toastr.success("자재가 삭제되었습니다.");
                	$('#matrlDtlTable').DataTable().ajax.reload( function () {});
            	} else if(res.result == 'error') {
            		toastr.error(res.message);
            	}
         	},
	        error: function(xhr,textStatus,error){
	              console.log("textStatus: "+xhr.status+", error: "+error);
	              toastr.error("예상치 못한 오류가 발생했습니다.");
	        },
        });
    });

	//투입자재 추가 버튼 click
	$('#btnMatrlAdd').on('click', function() {
		$('#matrlDtlTableTitle').text('추가 투입자재목록 (' + $('#goodsCd').val() + '/' + $('#goodsNm').val() + ')');
		$('#matrlDtlTableModal').modal({backdrop: 'static'});
		$('#matrlDtlTableModal').modal('show');
		$('#matrlDtlTable').DataTable().ajax.reload( function () {});
	});

	var number = "0";
	function rmDecimal(number){
		let tmp = number + "";
		
		//소숫점이 있을 경우
		if(tmp.indexOf(".") != -1){
			number = tmp.replace(/(0+$)/, "");
			
			let numberArr = number.split('.');
			if(numberArr[1]==""){
				number = number.replace('\.','');
			}
		}
		return addCommas(number);
	}
	
	//숫자만 입력하게 처리
	$(document).on('keyup', "#productQty", function(event){
		var preInWhsQtyData = $(this).val();	   
		if (!((event.which >= 96 && event.which <= 105) || (event.which >= 48 && event.which <= 57) || event.which == 110 || event.which == 188 || event.which == 190 || event.which == 8 || event.which == 9)) {

			$('.number-float0').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			}); 
			
			toastr.warning('숫자만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			event.preventDefault();
			return false;
		}
		
		if($(this).val()==""){
			$(this).val("0");
		}
		
		$(this).val(rmDecimal($(this).val().replace(/,/g,'')));

	}); 
	

</script>

</body>
</html>
