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
					<li class="breadcrumb-item"><a href="#">공정실적관리(POP)</a></li>
					<li class="breadcrumb-item active">공정이동관리(초중종물 등록)</li>
				</ol>
			</nav>
		</header>
		<!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list left-60" id="left-60" style="width:13%;">
                      <div class="card">
                        <!-- .table-responsive -->
                          <div class="table-responsive">
		                    <table id="equipCodeAdmTable" class="table table-bordered">
		                        <thead class="thead-light">
			                        <tr>
										<th style="min-width: 50px" >설비명</th>
		                            </tr>
		                        </thead>
                              </table>
                          </div>
						 <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                  
                   <div class="left-list left-60" id="left-60" style="width:37%;">
                      <div class="card">
                        <!-- .table-responsive -->
                          <div class="table-responsive">
		                    <table id="workOrderStepTable" class="table table-bordered">
		                        <thead class="thead-light">
			                        <tr>
										<th style="min-width: 25px">재질</th>
										<th style="min-width: 85px">LOT NO</th>
										<th style="min-width: 40px">근무조</th>
										<th style="min-width: 50px">메인담당</th>
										<th style="min-width: 50px">서브담당</th>
										<th style="min-width: 30px">주/야</th>
		                            </tr>
		                        </thead>
                              </table>
                          </div>
						 <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
                    <div class="right-list right-40" id="myrSidenav" style="width:48%;">
                      <div class="card" id="formBox">                                    
					<div class="card-body col-sm-12 p-2"">
						<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnSave" disabled>저장</button>
						<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnEdit" disabled>수정</button>
					</div>
	            	<!-- 상세정보 -->
					<div id="viewBox">
						<table class="table table-bordered">
							<colgroup><col width="15%"></colgroup>
							<colgroup><col width="10%"></colgroup>
							<colgroup><col width="20%"></colgroup>
							<colgroup><col width="13%"></colgroup>
							<colgroup><col width="13%"></colgroup>
							<colgroup><col width="20%"></colgroup>
							<tr>
								<th rowspan="3">위치</th>
		                        <th rowspan="3">시료</th>
		                        <th rowspan="3">조건</th>
		                        <th colspan="3">측정시간</th>
							</tr>
							<tr>
								<th>초물</th>
		                        <th>중물</th>
		                        <th>종물</th>
							</tr>
							<tr>
								<td><input type="time" maxlength="5" class="form-control text-center firstStep" id="firstRegTime" placeholder="HH:MM"></td>
		                        <td><input type="time" maxlength="5" class="form-control text-center secondStep" id="secondRegTime" placeholder="HH:MM"></td>
		                        <td><input type="time" maxlength="5" class="form-control text-center thridStep" id="thirdRegTime" placeholder="HH:MM" disabled></td>
							</tr>
							<tr>
								<input type="hidden" id="workOrdNo">
								<input type="hidden" id="equipCondSeq">
								<input type="hidden" id="firstStepSearch">
								<input type="hidden" id="secondStepSearch">
								<input type="hidden" id="thirdStepSearch">
								<th rowspan="2">Welding Part</th>
								<th>(좌)</th>
								<th><span class="cond" id="wpLeftCond"></span></th>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstWpLeftAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondWpLeftAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdWpLeftAlwnce" min="0" disabled></td>
							</tr>
							<tr>
								<th>(우)</th>
								<th><span id="wpRightCond"></span></th>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstWpRightAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondWpRightAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdWpRightAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2">Pitch</th>
								<th>(좌)</th>
								<th><span class="cond" id="pitchLeftCond"></span></th>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstPitchLeftAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondPitchLeftAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdPitchLeftAlwnce" min="0" ></td>
							</tr>                                                                                       
							<tr>
								<th>(우)</th>
								<th><span class="cond" id="pitchRightCond"></span></th>                                                                         
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstPitchRightAlwnce" min="0"  ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondPitchRightAlwnce" min="0"  ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdPitchRightAlwnce" min="0"  ></td>
							</tr>
							<tr>
								<th rowspan="2">P.P Film 날개</th>
								<th>(좌)</th>
								<th><span class="cond" id="ppfWingLeftCond"></span></th>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstPpfWingLeftAlwnce" min="0"  ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondPpfWingLeftAlwnce" min="0"  ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdPpfWingLeftAlwnce" min="0"  ></td>
							</tr>
							<tr>
							<th>(우)</th>
								<th><span class="cond" id="ppfWingRightCond"></span></th>                                                                         
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstPpfWingRightAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondPpfWingRightAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdPpfWingRightAlwnce" min="0" ></td>
							</tr>
							<tr>                                
								<th rowspan="2">P.P Film 폭</th>
								<th>(좌)</th>
								<th><span class="cond" id="ppfDepthLeftCond"></span></th>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstPpfDepthLeftAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondPpfDepthLeftAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdPpfDepthLeftAlwnce" min="0" ></td>
							</tr>
							<tr>                                                                                        
								<th>(우)</th>
								<th><span class="cond" id="ppfDepthRightCond"></span></th>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstPpfDepthRightAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondPpfDepthRightAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdPpfDepthRightAlwnce" min="0" ></td>
							</tr>
							<tr>                                
								<th>Film</th>
								<th>총길이</th>
								<th><span class="cond" id="filmCond"></span></th>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstFilmAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondFilmAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdFilmAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2">METAL</th>
								<th>폭</th>
								<th><span class="cond" id="metalDepthCond"></span></th>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstMetalDepthAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondMetalDepthAlwnce" min="0" ></td>
								<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdMetalDepthAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th>두께</th>
								<th><span class="cond" id="metalThicknessCond"></span></th>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstMetalThicknessAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondMetalThicknessAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdMetalThicknessAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2">총두께</th>
								<th>Center</th>
								<th><span class="cond" id="thCenterCond"></span></th>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstThCenterAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondThCenterAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdThCenterAlwnce" min="0" ></td>
							</tr>                                                                                       
							<tr>
								<th>Edge</th>
								<th><span class="cond" id="thEdgeCond"></span></th>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstThEdgeAlwncePlus" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondThEdgeAlwncePlus" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdThEdgeAlwncePlus" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="3">Burr (MAX)</th>
								<th>Metal</th>
								<th><span class="cond" id="burrCond"></span></th>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstBurrMetalAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondBurrMetalAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdBurrMetalAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th>R-Cut</th>
								<th><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstBurrRcutAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondBurrRcutAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdBurrRcutAlwnce" min="0"></td>
							</tr>
							<tr>
								<th>R끝단</th>
								<th><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep" id="firstBurrRedgeAlwnce" min="0"></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep" id="secondBurrRedgeAlwnce" min="0"></td>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep" id="thirdBurrRedgeAlwnce" min="0"></td>
							</tr>
							<tr>
								<th colspan="5" style="text-align:right">초,중,종 물의 W.P(좌)+P.P폭(좌) 평균값 </th>
								<td><input maxlength="8" min="0" max="1000" type="number" step="0.01" class="form-control number-float2" id="average" min="0" disabled></td>
							</tr>
						</table>
					</div>
					<!-- 상세정보 끝-->
				</div>
			<!--// 등록, 수정 -->
			</div><!-- .right-sidebar -->
		</div><!-- /.row -->
    </div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'posc0040';
	let currentHref = 'posc0040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","공정이동관리(초중종물등록)");

	$('#myrSidenav').css('padding-bottom','0px');
	var serverDateFrom =  "${serverDateFrom}";
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	viewForm(true);
	
	//공통코드 처리 시작
	var equipGroupCode = new Array(); // 기계 그룹
    <c:forEach items="${equipGruop}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    var wpLeft1 = 0;
    var ppLeft1 = 0;
    var wpLeft2 = 0;
    var ppLeft2 = 0;
    var wpLeft3 = 0;
    var ppLeft3 = 0;
    
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let equipCodeAdmTable = $('#equipCodeAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
    	dom: "<'row'<''l>>" +
 		"<'row'<'col-sm-12'tr>>" +
 		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        language: lang_kor,
        paging: true,
        info: false,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        searching: false,
        pageLength: 11,
        ajax: {
            url: '<c:url value="bm/equipCodeAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'equipGroup' : function() { return equipGroup; },
            },
        },
		columns: [
			{ data: 'equipNm' },
		],
		order: [
			[ 0, 'asc' ],
		],
	    drawCallback: function( settings ) {
	    	$('#equipCodeAdmTable tbody tr td').css('height','40px');
	    	
	    }
    });
	
  	var html1 = '&nbsp;<label class="input-label-sm touch6">설비그룹 </label><select class="custom-select custom-select-lg" id="equipGroupCd" ></select>';
    $('#equipCodeAdmTable_length').html(html1);
    selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");
	
	var chooseDate = null;
	var equipCd = null;
    $('#equipCodeAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }	
        else {
        	$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            chooseDate = $('#date').val();
            equipCd = equipCodeAdmTable.row( this ).data().equipCd;
            $('#workOrderStepTable').DataTable().ajax.reload( function () {});
            //alert(chooseDate);
            viewClear();
            viewForm(true);
        }
    });

    $.fn.dataTable.ext.errMode = 'none';
	let workOrderStepTable = $('#workOrderStepTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        language: lang_kor,
        paging: true,
        info: false,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        pageLength: 20,
    });

	var html3 = '<div class="row">&nbsp;<label class="input-label-sm">등록일</label><div class="form-group input-sub m-0 row">';
	html3 += '<input class="form-control" style="width:120px;" type="date" id="date" name="ordDate" />';
	html3 += '<button onclick="fnPopUpCalendar(date,date,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="btnRetv" type="button">';
	html3 += '<span class="oi oi-calendar"></span>';
	html3 += '</button>'; 
	html3 += '</div>';
	html3 += '&nbsp;<button type="button" class="btn btn-primary touch6" id="btnWorkOrdRetv">조회</button></div>';
	
	$('#workOrderStepTable_length').html(html3);
	$('#date').val(serverDateFrom);
	
    workOrderStepTable = $('#workOrderStepTable').DataTable({
        language: lang_kor,
        paging: true,
        info: false,
        destroy: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        pageLength: 20,
        ajax: {
        	url: '<c:url value="po/workOrderStepDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'equipCd'		:		function() { return equipCd; },
            	'ordDate'		:		function() { return $('#date').val().replace(/-/g, ''); },
            },
        },
        columns: [
			{ data: 'qutyNm' },
			{ data: 'ordLotNo' },
  			{ data: 'workTeamNm' },
  			{ data: 'mainWorkChargrNm' },
  			{ data: 'subWorkChargrNm' },
  			{ data: 'ordGubunNm' },
        ],
	    drawCallback: function( settings ) {

	    	var html3 = '<div class="row">&nbsp;<label class="input-label-sm touch6">등록일</label><div class="form-group input-sub m-0 row">';
			html3 += '<input class="form-control touch6" style="width:120px;" type="text" id="date" name="date" />';
			html3 += '<button onclick="fnPopUpCalendar(date,date,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="ordDateCalendar" type="button"style="width:30px; height:30px;">';
			html3 += '<span class="oi oi-calendar" style="font-size: 15px;"></span>';
			html3 += '</button>'; 
			html3 += '</div>';
			html3 += '&nbsp;<button type="button" class="btn btn-primary touch6" id="btnWorkOrdRetv">조회</button></div>';
	    	$('#workOrderStepTable_length').html(html3);
	    	$('.dataTables_filter').addClass("touch6");
	    	
	    	//alert(chooseDate);
	    	if ( chooseDate == null ) {
	    		$('#date').val(serverDateFrom);
	    		//alert("1");
		    } else {
		    	$('#date').val(chooseDate);
		    	//alert("2");
			}
	    }
    });
   

    $("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});
		$('#workOrderStepTable').DataTable().clear();
        equipCd = "";
        ordDate = "";
    	viewClear();
    	viewForm(true);
	});   

    $(document).on('click','#btnWorkOrdRetv', function(event) {
        $('#workOrdNo').val(workOrdNo);
        $('#equipCondSeq').val(equipCondSeq);
        chooseDate = $('#date').val();
        viewClear();
        viewForm(true);
        $('#workOrderStepTable').DataTable().ajax.reload( function () {});
    });
    
	// 작업지시 선택시 치수조건 검색
	var workOrdNo = null;
	var equipCondSeq = null;
	$('#workOrderStepTable tbody').on('click', 'tr', function () {
		$('.number-float3').css('color', 'black');
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#workOrderStepTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            
            workOrdNo = workOrderStepTable.row( this ).data().workOrdNo;
            equipCondSeq = workOrderStepTable.row( this ).data().equipCondSeq;
            $('#workOrdNo').val(workOrdNo);
            $('#equipCondSeq').val(equipCondSeq);
            viewClear();
            viewForm(true);

	   	    $.ajax({
	   	    	url: '<c:url value="po/workOrderStepData"/>',
	   	        type: 'GET',
	   	        data: {
	   	        	'menuAuth'	 	: 		menuAuth,
		   	        'workOrdNo'		: workOrdNo,
	   				'equipCondSeq' 	: equipCondSeq,
	   	        },
	   	        success: function (res) {
	   	         	let condStepData = res.condStepData;
					let firstStepData = res.firstStepData;
					let secondStepData = res.secondStepData;
					let thirdStepData = res.thirdStepData;

					//치수 조건
	   	            if (res.result == 'ok') {
	   	            	$('#wpLeftCond').text('-'+condStepData.wpLeftAlwnceMinus + ' [' + condStepData.wpLeftCond + '] +' + condStepData.wpLeftAlwncePlus);
	   	            	$('#wpRightCond').text('-'+condStepData.wpRightAlwnceMinus + ' [' + condStepData.wpRightCond + '] +' + condStepData.wpRightAlwncePlus);
	   	            	$('#pitchLeftCond').text('-'+condStepData.pitchLeftAlwnceMinus + ' [' + condStepData.pitchLeftCond + '] +' + condStepData.pitchLeftAlwncePlus);
	   	            	$('#pitchRightCond').text('-'+condStepData.pitchRightAlwnceMinus + ' [' + condStepData.pitchRightCond + '] +' + condStepData.pitchRightAlwncePlus);
	   	            	$('#ppfWingLeftCond').text('-'+condStepData.ppfWingLeftAlwnceMinus + ' [' + condStepData.ppfWingLeftCond + '] +' + condStepData.ppfWingLeftAlwncePlus);
	   	            	$('#ppfWingRightCond').text('-'+condStepData.ppfWingRightAlwnceMinus + ' [' + condStepData.ppfWingRightCond + '] +' + condStepData.ppfWingRightAlwncePlus);
	   	            	$('#ppfDepthLeftCond').text('-'+condStepData.ppfDepthLeftAlwnceMinus + ' [' + condStepData.ppfDepthLeftCond + '] +' + condStepData.ppfDepthLeftAlwncePlus);
	   	            	$('#ppfDepthRightCond').text('-'+condStepData.ppfDepthRightAlwnceMinus + ' [' + condStepData.ppfDepthRightCond + '] +' + condStepData.ppfDepthRightAlwncePlus);
	   	            	$('#filmCond').text('-'+condStepData.filmAlwnceMinus + ' [' + condStepData.filmCond + '] +' + condStepData.filmAlwncePlus);
	   	            	$('#metalDepthCond').text('-'+condStepData.metalDepthAlwnceMinus + ' [' + condStepData.metalDepthCond + '] +' + condStepData.metalDepthAlwncePlus);
	   	            	$('#metalThicknessCond').text('-'+condStepData.metalThicknessAlwnceMinus + ' [' + condStepData.metalThicknessCond + '] +' + condStepData.metalThicknessAlwncePlus);
	   	            	$('#thCenterCond').text('-'+condStepData.thCenterAlwnceMinus + ' [' + condStepData.thCenterCond + '] +' + condStepData.thCenterAlwncePlus);
	   	            	$('#thEdgeCond').text('-'+condStepData.thEdgeAlwnceMinus + ' [' + condStepData.thEdgeCond + '] +' + condStepData.thEdgeAlwncePlus);
	   	            	$('#burrCond').text('-'+condStepData.burrAlwnceMinus + ' [' + condStepData.burrCond + '] +' + condStepData.burrAlwncePlus);


						$('#thirdWpLeftAlwnce').attr("minVal", (parseFloat(condStepData.wpLeftCond) - parseFloat(condStepData.wpLeftAlwnceMinus)).toFixed(3) );
						$('#thirdWpLeftAlwnce').attr("maxVal", (parseFloat(condStepData.wpLeftCond) + parseFloat(condStepData.wpLeftAlwncePlus)).toFixed(3) );

						$('#thirdWpRightAlwnce').attr("minVal", (parseFloat(condStepData.wpRightCond) - parseFloat(condStepData.wpRightAlwnceMinus)).toFixed(3) );
						$('#thirdWpRightAlwnce').attr("maxVal", (parseFloat(condStepData.wpRightCond) + parseFloat(condStepData.wpRightAlwncePlus)).toFixed(3) );

						$('#thirdPitchLeftAlwnce').attr("minVal", (parseFloat(condStepData.pitchLeftCond) - parseFloat(condStepData.pitchLeftAlwnceMinus)).toFixed(3) );
						$('#thirdPitchLeftAlwnce').attr("maxVal", (parseFloat(condStepData.pitchLeftCond) + parseFloat(condStepData.pitchLeftAlwncePlus)).toFixed(3) );

						$('#thirdPitchRightAlwnce').attr("minVal", (parseFloat(condStepData.pitchRightCond) - parseFloat(condStepData.pitchRightAlwnceMinus)).toFixed(3) );
						$('#thirdPitchRightAlwnce').attr("maxVal", (parseFloat(condStepData.pitchRightCond) + parseFloat(condStepData.pitchRightAlwncePlus)).toFixed(3) );

						$('#thirdPpfWingLeftAlwnce').attr("minVal", (parseFloat(condStepData.ppfWingLeftCond) - parseFloat(condStepData.ppfWingLeftAlwnceMinus)).toFixed(3) );
						$('#thirdPpfWingLeftAlwnce').attr("maxVal", (parseFloat(condStepData.ppfWingLeftCond) + parseFloat(condStepData.ppfWingLeftAlwncePlus)).toFixed(3) );

						$('#thirdPpfWingRightAlwnce').attr("minVal", (parseFloat(condStepData.ppfWingRightCond) - parseFloat(condStepData.ppfWingRightAlwnceMinus)).toFixed(3) );
						$('#thirdPpfWingRightAlwnce').attr("maxVal", (parseFloat(condStepData.ppfWingRightCond) + parseFloat(condStepData.ppfWingRightAlwncePlus)).toFixed(3) );

						$('#thirdPpfDepthLeftAlwnce').attr("minVal", (parseFloat(condStepData.ppfDepthLeftCond) - parseFloat(condStepData.ppfDepthLeftAlwnceMinus)).toFixed(3) );
						$('#thirdPpfDepthLeftAlwnce').attr("maxVal", (parseFloat(condStepData.ppfDepthLeftCond) + parseFloat(condStepData.ppfDepthLeftAlwncePlus)).toFixed(3) );

						$('#thirdPpfDepthRightAlwnce').attr("minVal", (parseFloat(condStepData.ppfDepthRightCond) - parseFloat(condStepData.ppfDepthRightAlwnceMinus)).toFixed(3) );
						$('#thirdPpfDepthRightAlwnce').attr("maxVal", (parseFloat(condStepData.ppfDepthRightCond) + parseFloat(condStepData.ppfDepthRightAlwncePlus)).toFixed(3) );

						$('#thirdFilmAlwnce').attr("minVal", (parseFloat(condStepData.filmCond) - parseFloat(condStepData.filmAlwnceMinus)).toFixed(3) );
						$('#thirdFilmAlwnce').attr("maxVal", (parseFloat(condStepData.filmCond) + parseFloat(condStepData.filmAlwncePlus)).toFixed(3) );

						$('#thirdMetalDepthAlwnce').attr("minVal", (parseFloat(condStepData.metalDepthCond) - parseFloat(condStepData.metalDepthAlwnceMinus)).toFixed(3) );
						$('#thirdMetalDepthAlwnce').attr("maxVal", (parseFloat(condStepData.metalDepthCond) + parseFloat(condStepData.metalDepthAlwncePlus)).toFixed(3) );

						$('#thirdMetalThicknessAlwnce').attr("minVal", (parseFloat(condStepData.metalThicknessCond) - parseFloat(condStepData.metalThicknessAlwnceMinus)).toFixed(3) );
						$('#thirdMetalThicknessAlwnce').attr("maxVal", (parseFloat(condStepData.metalThicknessCond) + parseFloat(condStepData.metalThicknessAlwncePlus)).toFixed(3) );

						$('#thirdThCenterAlwnce').attr("minVal", (parseFloat(condStepData.thCenterCond) - parseFloat(condStepData.thCenterAlwnceMinus)).toFixed(3) );
						$('#thirdThCenterAlwnce').attr("maxVal", (parseFloat(condStepData.thCenterCond) + parseFloat(condStepData.thCenterAlwncePlus)).toFixed(3) );

						$('#thirdThEdgeAlwncePlus').attr("minVal", (parseFloat(condStepData.thEdgeCond) - parseFloat(condStepData.thEdgeAlwnceMinus)).toFixed(3) );
						$('#thirdThEdgeAlwncePlus').attr("maxVal", (parseFloat(condStepData.thEdgeCond) + parseFloat(condStepData.thEdgeAlwncePlus)).toFixed(3) );

						$('#thirdBurrMetalAlwnce').attr("minVal", (parseFloat(condStepData.burrCond) - parseFloat(condStepData.burrAlwnceMinus)).toFixed(3) );
						$('#thirdBurrMetalAlwnce').attr("maxVal", (parseFloat(condStepData.burrCond) + parseFloat(condStepData.burrAlwncePlus)).toFixed(3) );
						
	   	            	//초물
		   	            if( res.firstStepData != null ){
		   	            	$('#firstStepSearch').val("success");

		   	            	if ( firstStepData.regTime == null || firstStepData.regTime == "" ) {
								let Now = new Date();
								$('#firstRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
			   	            } else {
			   	            	$('#firstRegTime').val(firstStepData.regTime);
							}
		   	            	wpLeft1 = firstStepData.wpLeftAlwnce;
		   	            	ppLeft1 = firstStepData.ppfDepthLeftAlwnce;
							$('#firstWpLeftAlwnce').val(firstStepData.wpLeftAlwnce);
							$('#firstWpRightAlwnce').val(firstStepData.wpRightAlwnce);
							$('#firstPitchLeftAlwnce').val(firstStepData.pitchLeftAlwnce);
							$('#firstPitchRightAlwnce').val(firstStepData.pitchRightAlwnce);
							$('#firstPpfWingLeftAlwnce').val(firstStepData.ppfWingLeftAlwnce);
							$('#firstPpfWingRightAlwnce').val(firstStepData.ppfWingRightAlwnce);
							$('#firstPpfDepthLeftAlwnce').val(firstStepData.ppfDepthLeftAlwnce);
							$('#firstPpfDepthRightAlwnce').val(firstStepData.ppfDepthRightAlwnce);
							$('#firstFilmAlwnce').val(firstStepData.filmAlwnce);
							$('#firstMetalDepthAlwnce').val(firstStepData.metalDepthAlwnce);
							$('#firstMetalThicknessAlwnce').val(firstStepData.metalThicknessAlwnce);
							$('#firstThCenterAlwnce').val(firstStepData.thCenterAlwnce);
							$('#firstThEdgeAlwncePlus').val(firstStepData.thEdgeAlwncePlus);
							$('#firstBurrMetalAlwnce').val(firstStepData.burrMetalAlwnce);
							$('#firstBurrRcutAlwnce').val(firstStepData.burrRcutAlwnce);
							$('#firstBurrRedgeAlwnce').val(firstStepData.burrRedgeAlwnce);
						} else {
							$('#firstStepSearch').val("fail");
							wpLeft1 = 0;
							ppLeft1 = 0;
						}

	   	            	//중물
						if( res.secondStepData != null ){
		   	            	$('#secondStepSearch').val("success");
		   	            	if ( secondStepData.regTime == null || secondStepData.regTime == "" ) {
								let Now = new Date();
								$('#secondRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
			   	            } else {
			   	            	$('#secondRegTime').val(secondStepData.regTime);
							}
		   	            	wpLeft2 = secondStepData.wpLeftAlwnce;
		   	            	ppLeft2 = secondStepData.ppfDepthLeftAlwnce;
							$('#secondWpLeftAlwnce').val(secondStepData.wpLeftAlwnce);
							$('#secondWpRightAlwnce').val(secondStepData.wpRightAlwnce);
							$('#secondPitchLeftAlwnce').val(secondStepData.pitchLeftAlwnce);
							$('#secondPitchRightAlwnce').val(secondStepData.pitchRightAlwnce);
							$('#secondPpfWingLeftAlwnce').val(secondStepData.ppfWingLeftAlwnce);
							$('#secondPpfWingRightAlwnce').val(secondStepData.ppfWingRightAlwnce);
							$('#secondPpfDepthLeftAlwnce').val(secondStepData.ppfDepthLeftAlwnce);
							$('#secondPpfDepthRightAlwnce').val(secondStepData.ppfDepthRightAlwnce);
							$('#secondFilmAlwnce').val(secondStepData.filmAlwnce);
							$('#secondMetalDepthAlwnce').val(secondStepData.metalDepthAlwnce);
							$('#secondMetalThicknessAlwnce').val(secondStepData.metalThicknessAlwnce);
							$('#secondThCenterAlwnce').val(secondStepData.thCenterAlwnce);
							$('#secondThEdgeAlwncePlus').val(secondStepData.thEdgeAlwncePlus);
							$('#secondBurrMetalAlwnce').val(secondStepData.burrMetalAlwnce);
							$('#secondBurrRcutAlwnce').val(secondStepData.burrRcutAlwnce);
							$('#secondBurrRedgeAlwnce').val(secondStepData.burrRedgeAlwnce);

						} else {
							$('#secondStepSearch').val("fail");
							wpLeft2 = 0;
							ppLeft2 = 0;
						}

	   	            	//종물
						if( res.thirdStepData != null ){
							$('#thirdStepSearch').val("success");
							if ( thirdStepData.regTime == null || thirdStepData.regTime == "" ) {
								let Now = new Date();
								$('#thirdRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
			   	            } else {
			   	            	$('#thirdRegTime').val(thirdStepData.regTime);
							}
							wpLeft3 = thirdStepData.wpLeftAlwnce;
		   	            	ppLeft3 = thirdStepData.ppfDepthLeftAlwnce;
							$('#thirdRegTime').val(thirdStepData.regTime);
							$('#thirdWpLeftAlwnce').val(thirdStepData.wpLeftAlwnce);
							$('#thirdWpRightAlwnce').val(thirdStepData.wpRightAlwnce);
							$('#thirdPitchLeftAlwnce').val(thirdStepData.pitchLeftAlwnce);
							$('#thirdPitchRightAlwnce').val(thirdStepData.pitchRightAlwnce);
							$('#thirdPpfWingLeftAlwnce').val(thirdStepData.ppfWingLeftAlwnce);
							$('#thirdPpfWingRightAlwnce').val(thirdStepData.ppfWingRightAlwnce);
							$('#thirdPpfDepthLeftAlwnce').val(thirdStepData.ppfDepthLeftAlwnce);
							$('#thirdPpfDepthRightAlwnce').val(thirdStepData.ppfDepthRightAlwnce);
							$('#thirdFilmAlwnce').val(thirdStepData.filmAlwnce);
							$('#thirdMetalDepthAlwnce').val(thirdStepData.metalDepthAlwnce);
							$('#thirdMetalThicknessAlwnce').val(thirdStepData.metalThicknessAlwnce);
							$('#thirdThCenterAlwnce').val(thirdStepData.thCenterAlwnce);
							$('#thirdThEdgeAlwncePlus').val(thirdStepData.thEdgeAlwncePlus);
							$('#thirdBurrMetalAlwnce').val(thirdStepData.burrMetalAlwnce);
							$('#thirdBurrRcutAlwnce').val(thirdStepData.burrRcutAlwnce);
							$('#thirdBurrRedgeAlwnce').val(thirdStepData.burrRedgeAlwnce);
						} else {
							$('#thirdStepSearch').val("fail");
							wpLeft3 = 0;
							ppLeft3 = 0;
						}

	   	            	//조회된 값이 없을때 평균값도 공백으로
	   	            	if (res.firstStepData == null && res.secondStepData == null && res.thirdStepData == null ) {
	   	            		$("#average").val("");
		   	            } else {
		   	            	average();	//초중종물의 WP(좌) PP폭(좌) 의 평균값 계산
						}
					}
					else {
						toastr.error("치수 조건을 조회오류가 발생하였습니다.", '', {timeOut: 5000});
	  	        	    //$('#searchData').val("fail");
					}
	   	        },
	   	        complete:function(){
	   	        	$('#btnEdit').attr('disabled', false);
	   	        	$('#btnSave').attr('disabled', true);
				}
			});
        }
   	});

    $('#btnEdit').on('click', function() {
    	if ( $('#firstStepSearch').val() == "fail" ){
    		viewSetData();
		}
    	$('#btnSave').attr('disabled', false);
    	viewForm(false);
    	$('.number-float3').css('color', 'black');
    	btnSaveClick = false;
    	let Now = new Date();
		//if( ($('#firstRegTime').val()=="") || ($('#firstRegTime').val()==null)){
		//	$('#firstRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		//}
        //
		//if( ($('#secondRegTime').val()=="") || ($('#secondRegTime').val()==null)){
		//	$('#secondRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		//}
		if( ($('#thirdRegTime').val()=="") || ($('#thirdRegTime').val()==null)){
			$('#thirdRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		}

		$('#thirdWpLeftAlwnce').select();
    });

    var url = null;
    var btnSaveClick = false;	//저장처리 클릭 여부 확인
    var arr = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];
    //저장처리
    $('#btnSave').on('click', function() {
        //입력값이 조건(+,-)안에 포함되는지 검사. 포함되지 않는다면 빨간색으로 표시
		for ( var i=0; i<14; i++) {
			if ( i == 0 ){
				if ( parseFloat($('#thirdWpLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdWpLeftAlwnce').val()) && parseFloat($('#thirdWpLeftAlwnce').val()) <= parseFloat($('#thirdWpLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdWpLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 1 ) {
				if ( parseFloat($('#thirdWpRightAlwnce').attr("minVal")) <= parseFloat($('#thirdWpRightAlwnce').val()) && parseFloat($('#thirdWpRightAlwnce').val()) <= parseFloat($('#thirdWpRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdWpRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 2 ) {
				if ( parseFloat($('#thirdPitchLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchLeftAlwnce').val()) && parseFloat($('#thirdPitchLeftAlwnce').val()) <= parseFloat($('#thirdPitchLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdPitchLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 3 ) {
				if ( parseFloat($('#thirdPitchRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchRightAlwnce').val()) && parseFloat($('#thirdPitchRightAlwnce').val()) <= parseFloat($('#thirdPitchRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdPitchRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 4 ) {
				if ( parseFloat($('#thirdPpfWingLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingLeftAlwnce').val()) && parseFloat($('#thirdPpfWingLeftAlwnce').val()) <= parseFloat($('#thirdPpfWingLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdPpfWingLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 5 ) {
				if ( parseFloat($('#thirdPpfWingRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingRightAlwnce').val()) && parseFloat($('#thirdPpfWingRightAlwnce').val()) <= parseFloat($('#thirdPpfWingRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdPpfWingRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 6 ) {
				if ( parseFloat($('#thirdPpfDepthLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthLeftAlwnce').val()) && parseFloat($('#thirdPpfDepthLeftAlwnce').val()) <= parseFloat($('#thirdPpfDepthLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdPpfDepthLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 7 ) {
				if ( parseFloat($('#thirdPpfDepthRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthRightAlwnce').val()) && parseFloat($('#thirdPpfDepthRightAlwnce').val()) <= parseFloat($('#thirdPpfDepthRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdPpfDepthRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 8 ) {
				if ( parseFloat($('#thirdFilmAlwnce').attr("minVal")) <= parseFloat($('#thirdFilmAlwnce').val()) && parseFloat($('#thirdFilmAlwnce').val()) <= parseFloat($('#thirdFilmAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdFilmAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 9 ) {
				if ( parseFloat($('#thirdMetalDepthAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalDepthAlwnce').val()) && parseFloat($('#thirdMetalDepthAlwnce').val()) <= parseFloat($('#thirdMetalDepthAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdMetalDepthAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 10 ) {
				if ( parseFloat($('#thirdMetalThicknessAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalThicknessAlwnce').val()) && parseFloat($('#thirdMetalThicknessAlwnce').val()) <= parseFloat($('#thirdMetalThicknessAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdMetalThicknessAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 11 ) {
				if ( parseFloat($('#thirdThCenterAlwnce').attr("minVal")) <= parseFloat($('#thirdThCenterAlwnce').val()) && parseFloat($('#thirdThCenterAlwnce').val()) <= parseFloat($('#thirdThCenterAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdThCenterAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 12 ) {
				if ( parseFloat($('#thirdThEdgeAlwncePlus').attr("minVal")) <= parseFloat($('#thirdThEdgeAlwncePlus').val()) && parseFloat($('#thirdThEdgeAlwncePlus').val()) <= parseFloat($('#thirdThEdgeAlwncePlus').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdThEdgeAlwncePlus').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 13 ) {
				if ( parseFloat($('#thirdBurrMetalAlwnce').attr("minVal")) <= parseFloat($('#thirdBurrMetalAlwnce').val()) && parseFloat($('#thirdBurrMetalAlwnce').val()) <= parseFloat($('#thirdBurrMetalAlwnce').attr("maxVal")) ) {
					arr[i] = true;
				} else {
					$('#thirdBurrMetalAlwnce').css('color', 'red');
					arr[i] = false;
				}
			}
        }

        //범위가 벗어난 곳이 있는지 확인 후 안내메세지 출력
        var j = 0;	//조건범위 이탈 수량
		for ( var i=0; i<14; i++) {
			if ( arr[i] == false ) {
				j++;
			}
		}

        //범위가 벗어난곳이 없고, 저장버튼을 처음누르는 것이면 저장처리
		if ( j != 0 && btnSaveClick == false ){
			toastr.warning("조건을 벗어난 부분이 " + j + "군데 있습니다. 확인해 주세요!", '', {timeOut: 5000});
			btnSaveClick = true;
		} else {
			
			$('#my-spinner').show();
			
			if( $('#firstStepSearch').val() == "fail" ){
	        	url = "/po/insertWorkOrderStepData"
	    	}
	        else if( $('#firstStepSearch').val() == "success" ){
	        	url = "/po/updateWorkOrderStepData"
	    	}
	    	$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 	: 		menuAuth,
	   	        	'workOrdNo'					: $('#workOrdNo').val(),
	   	        	
	   	        	'firstRegTime'				: $('#firstRegTime').val(),
		   	        'firstWpLeftAlwnce'			: $('#firstWpLeftAlwnce').val(),
	   	    		'firstWpRightAlwnce'		: $('#firstWpRightAlwnce').val(),
		    		'firstPitchLeftAlwnce'		: $('#firstPitchLeftAlwnce').val(),
		    		'firstPitchRightAlwnce'		: $('#firstPitchRightAlwnce').val(),
	    			'firstPpfWingLeftAlwnce'	: $('#firstPpfWingLeftAlwnce').val(),
		    		'firstPpfWingRightAlwnce'	: $('#firstPpfWingRightAlwnce').val(),
	    			'firstPpfDepthLeftAlwnce'	: $('#firstPpfDepthLeftAlwnce').val(),
		    		'firstPpfDepthRightAlwnce'	: $('#firstPpfDepthRightAlwnce').val(),
	    			'firstFilmAlwnce'			: $('#firstFilmAlwnce').val(),
		    		'firstMetalDepthAlwnce'		: $('#firstMetalDepthAlwnce').val(),
	    			'firstMetalThicknessAlwnce'	: $('#firstMetalThicknessAlwnce').val(),
		    		'firstThCenterAlwnce'		: $('#firstThCenterAlwnce').val(),
	    			'firstThEdgeAlwncePlus'		: $('#firstThEdgeAlwncePlus').val(),
		    		'firstBurrMetalAlwnce'		: $('#firstBurrMetalAlwnce').val(),
		    		'firstBurrRcutAlwnce'		: $('#firstBurrRcutAlwnce').val(),
		    		'firstBurrRedgeAlwnce'		: $('#firstBurrRedgeAlwnce').val(),
	        
		    		'secondRegTime'				: $('#secondRegTime').val(),
					'secondWpLeftAlwnce'		: $('#secondWpLeftAlwnce').val(),
		    		'secondWpRightAlwnce'		: $('#secondWpRightAlwnce').val(),
					'secondPitchLeftAlwnce'		: $('#secondPitchLeftAlwnce').val(),
		    		'secondPitchRightAlwnce'	: $('#secondPitchRightAlwnce').val(),
					'secondPpfWingLeftAlwnce'	: $('#secondPpfWingLeftAlwnce').val(),
		    		'secondPpfWingRightAlwnce'	: $('#secondPpfWingRightAlwnce').val(),
					'secondPpfDepthLeftAlwnce'	: $('#secondPpfDepthLeftAlwnce').val(),
		    		'secondPpfDepthRightAlwnce'	: $('#secondPpfDepthRightAlwnce').val(),
					'secondFilmAlwnce'			: $('#secondFilmAlwnce').val(),
		    		'secondMetalDepthAlwnce'	: $('#secondMetalDepthAlwnce').val(),
		    		'secondMetalThicknessAlwnce': $('#secondMetalThicknessAlwnce').val(),
		    		'secondThCenterAlwnce'		: $('#secondThCenterAlwnce').val(),
					'secondThEdgeAlwncePlus'	: $('#secondThEdgeAlwncePlus').val(),
		    		'secondBurrMetalAlwnce'		: $('#secondBurrMetalAlwnce').val(),
					'secondBurrRcutAlwnce'		: $('#secondBurrRcutAlwnce').val(),
		    		'secondBurrRedgeAlwnce'		: $('#secondBurrRedgeAlwnce').val(),
	        
		    		'thirdRegTime'				: $('#thirdRegTime').val(),
					'thirdWpLeftAlwnce'			: $('#thirdWpLeftAlwnce').val(),
		    		'thirdWpRightAlwnce'		: $('#thirdWpRightAlwnce').val(),
					'thirdPitchLeftAlwnce'		: $('#thirdPitchLeftAlwnce').val(),
		    		'thirdPitchRightAlwnce'		: $('#thirdPitchRightAlwnce').val(),
					'thirdPpfWingLeftAlwnce'	: $('#thirdPpfWingLeftAlwnce').val(),
		    		'thirdPpfWingRightAlwnce'	: $('#thirdPpfWingRightAlwnce').val(),
		    		'thirdPpfDepthLeftAlwnce'	: $('#thirdPpfDepthLeftAlwnce').val(),
		    		'thirdPpfDepthRightAlwnce'	: $('#thirdPpfDepthRightAlwnce').val(),
					'thirdFilmAlwnce'			: $('#thirdFilmAlwnce').val(),
		    		'thirdMetalDepthAlwnce'		: $('#thirdMetalDepthAlwnce').val(),
					'thirdMetalThicknessAlwnce'	: $('#thirdMetalThicknessAlwnce').val(),
		    		'thirdThCenterAlwnce'		: $('#thirdThCenterAlwnce').val(),
					'thirdThEdgeAlwncePlus'		: $('#thirdThEdgeAlwncePlus').val(),
		    		'thirdBurrMetalAlwnce'		: $('#thirdBurrMetalAlwnce').val(),
					'thirdBurrRcutAlwnce'		: $('#thirdBurrRcutAlwnce').val(),
		    		'thirdBurrRedgeAlwnce'		: $('#thirdBurrRedgeAlwnce').val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
						if( $('#firstStepSearch').val() == "fail" ){
							toastr.success("저장 되었습니다.");
	   	            		$('#firstStepSearch').val("success");
		   	      		} else if( $('#firstStepSearch').val() == "success" ){
		   	        		toastr.success("수정 되었습니다.");
		   	      		}
						//저장*수정 시 평균값 계산
						wpLeft1 = $('#firstWpLeftAlwnce').val();
						wpLeft2 = $('#secondWpLeftAlwnce').val();
						wpLeft3 = $('#thirdWpLeftAlwnce').val();
						ppLeft1 = $('#firstPpfDepthLeftAlwnce').val();
						ppLeft2 = $('#secondPpfDepthLeftAlwnce').val();
						ppLeft3 = $('#thirdPpfDepthLeftAlwnce').val();
						average();
					}
	   	            else if (res.result == 'fail') {
	   	            	toastr.error(res.message, '', {timeOut: 5000});
	   	            }
	   	        },
	   	        complete:function(){
	   	        	viewForm(true);
	   	        	$("#btnSave").attr("disabled",true);
	   	        	$('#my-spinner').hide();
	   	        }
	   	    });
		}
    });

    //새로 등록시 값 0세팅
    function viewSetData()	{
    	//$(".number-float1, .number-float3").val("0");
    	$(".number-float3").val("0");
    }
    
	//View 초기화
  	function viewClear()
	{
  		//$(".cond, .number-float1, .number-float3").val(null);
		$(".cond, .number-float3").val(null);
    	$('#firstRegTime').val("");
    	$('#secondRegTime').val("");
    	$('#thirdRegTime').val("");
    	$("#average").val("");
	}

	function viewForm(flag)	{
		//$(".firstStep, .secondStep, .thridStep").attr("disabled",flag);
		$(".thridStep").attr("disabled",flag);
	}
	$(".firstStep, .secondStep, .thridStep").attr("disabled",true);

	$("#thirdWpLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdWpRightAlwnce").select();
		}
	});

	$("#thirdWpRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPitchLeftAlwnce").select();
		}
	});

	$("#thirdPitchLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPitchRightAlwnce").select();
		}
	});

	$("#thirdPitchRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfWingLeftAlwnce").select();
		}
	});

	$("#thirdPpfWingLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfWingRightAlwnce").select();
		}
	});

	$("#thirdPpfWingRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfDepthLeftAlwnce").select();
		}
	});

	$("#thirdPpfDepthLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfDepthRightAlwnce").select();
		}
	});

	$("#thirdPpfDepthRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdFilmAlwnce").select();
		}
	});

	$("#thirdFilmAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdMetalDepthAlwnce").select();
		}
	});

	$("#thirdMetalDepthAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdMetalThicknessAlwnce").select();
		}
	});

	$("#thirdMetalThicknessAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdThCenterAlwnce").select();
		}
	});

	$("#thirdThCenterAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdThEdgeAlwncePlus").select();
		}
	});

	$("#thirdThEdgeAlwncePlus").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrMetalAlwnce").select();
		}
	});
	
	$("#thirdBurrMetalAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrRcutAlwnce").select();
		}
	});

	$("#thirdBurrRcutAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrRedgeAlwnce").select();
		}
	});

	$("#thirdBurrRedgeAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#btnSave").focus();
		}
	});

	function average()	{
		var temp = ((parseFloat(wpLeft1) + parseFloat(wpLeft2) + parseFloat(wpLeft3) + parseFloat(ppLeft1) + parseFloat(ppLeft2) + parseFloat(ppLeft3)) / 3).toFixed(1);
		$("#average").val(temp);
	}
	
</script>
</body>
</html>
