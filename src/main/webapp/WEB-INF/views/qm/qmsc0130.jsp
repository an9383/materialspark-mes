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
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<%
					if(factoryCode.equals("001")) {
				%>
						<li class="breadcrumb-item active">일일업무실적보고</li>
				<%	
					} else if(factoryCode.equals("002")) {
				%>
						<li class="breadcrumb-item active">일일업무실적보고</li>
				<%
					} else if(factoryCode.equals("003")) {
				%>
						<li class="breadcrumb-item active">일일업무실적보고</li>
				<%	
					}
				%>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table id="appearInspctTable" class="table table-bordered" style="margin-bottom: 5px;">
						<thead class="thead-light">
							<tr>
								<th class="text-center" style="min-width:130px; height:36px;">제품</th>
								<th class="text-center" style="min-width:200px;">규격</th>
								<th class="text-center" style="min-width:80px;">재질</th>
								<th class="text-center" style="min-width:100px;">항목</th>
								<th class="text-center" style="min-width:100px;" id="quarter1">분기1</th>
								<th class="text-center" style="min-width:100px;" id="quarter2">분기2</th>
								<th class="text-center" style="min-width:100px;" id="quarter3">분기3</th>
								<th class="text-center" style="min-width:100px;" id="month1">개월1</th>
								<th class="text-center" style="min-width:100px;" id="month2">개월2</th>
								<th class="text-center" style="min-width:100px;" id="month3">개월3</th>
								<th class="text-center" style="min-width:100px;" id="week1">주1</th>
								<th class="text-center" style="min-width:100px;" id="week2">주2</th>
								<th class="text-center" style="min-width:100px;" id="week3">주3</th>
								<th class="text-center" style="min-width:80px;" id="day1">일자1</th>
								<th class="text-center" style="min-width:80px;" id="day2">일자2</th>
								<th class="text-center" style="min-width:80px;" id="day3">일자3</th>
								<th class="text-center" style="min-width:80px;" id="day4">일자4</th>
								<th class="text-center" style="min-width:80px;" id="day5">일자5</th>
								<th class="text-center" style="min-width:80px;" id="day6">일자6</th>
								<th class="text-center" style="min-width:80px;" id="day7">일자7</th>
								<th class="text-center" style="min-width:80px;" id="day8">일자8</th>
								<th class="text-center" style="min-width:80px;" id="day9">일자9</th>
								<th class="text-center" style="min-width:80px;" id="day10">일자10</th>
								<th class="text-center" style="min-width:80px;" id="day11">일자11</th>
								<th class="text-center" style="min-width:80px;" id="day12">일자12</th>
								<th class="text-center" style="min-width:80px;" id="day13">일자13</th>
								<th class="text-center" style="min-width:80px;" id="day14">일자14</th>
							</tr>
						</thead>
					</table>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<!-- 도움말 모달 시작 -->
<!-- 
<div class="modal fade" id="advicePopupModal" tabindex="-1" role="dialog" aria-labelledby="advicePopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:550px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="advicePopupModalLabel">품질관리 통계 도움말</h5>
			</div>
			<div class="modal-body">
			<div class="row">
				<p>
					<span style="font-size:15px; font-weight:bold; color:blue;">2021-11-29</span>
					<span style="font-size:15px; font-weight:bold;">일자를 기준으로 생산실적 입력기준이 주재료(MetalLot)로 변경되었습니다. 이로인해 품질검사 통계 기준이 선택하신 일자에 따라 시스템상 조회기준이 달라집니다.</span>
				</p>
				<h6 style="color:blue;">2021-11-29</h6>
				<h6>일자를 기준으로 생산실적 입력기준이 주재료(MetalLot)로 변경되었으며 이로인해 품질검사 통계 기준이 선택하신 일자에 따라 시스템상 조회기준이 달라집니다.</h6>
			</div>
				
				<p style="margin-bottom: 0px;">*2021-11-28일자까지 조회시 작업지시를 기준으로 조회됩니다.</p>
				<p style="margin-bottom: 0px;">*2021-11-29일부터는 2021-11-29 ~ 선택 일자까지 생산실적을 기준으로 조회됩니다.</p>
				<p style="margin-bottom: 0px;"><span style="font-weight:bold; color:red;">ex1)</span>2021-11-25 선택 후 조회 시 작업지시 기준으로 조회</p>
				<p style="margin-bottom: 0px;"><span style="font-weight:bold; color:red;">ex2)</span>2021-12-03 선택 후 조회 시 2021-11-29 ~ 2021-12-03 일까지 생산실적전표 기준으로 조회</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnDeleteWorkOrdCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
 -->
<!-- 도움말 모달 끝 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let getParam = "<c:out value="${param.id}"/>";
	let menuAuth = 'qmsc0130';
	let currentHref = 'qmsc0130';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != "") {
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	
	var factoryCode = "<%=factoryCode%>";
	if (factoryCode == '001') {
		$(document).attr("title","일일 업무실적보고 ");		
	} else if(factoryCode == '002') {
		$(document).attr("title","일일 업무실적보고 ");
	} else if(factoryCode == '003') {
		$(document).attr("title","일일 업무실적보고");
	}
	
	$('#my-spinner').show();
	
	//공통코드 처리 시작
	var goodsCode = new Array(); // 제품코드
    <c:forEach items="${goodsCode}" var="info">
		var json=new Object();
		json.baseCd="${info.goodsCd}";
		json.baseCdNm="${info.goodsNm}";
		goodsCode.push(json);
    </c:forEach>

    var equipCode = new Array(); // 설비코드
    <c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";
		json.selectYn="${info.selectYn}";
		equipCode.push(json);
    </c:forEach>
    //공통코드 처리 종료 
	
	var equipList = '';
	for (var i=0; i<equipCode.length; i++) {
		equipList += "/" + equipCode[i].baseCd;
	}
	var goodsList = '';
	for (var j=0; j<goodsCode.length; j++) {
		goodsList += "/" + goodsCode[j].baseCd;
	}

	//var goodsCd = '';
	var qutyCd = '';
	var yesterday =  "${yesterday}"
	var chooseDateTo = yesterday;
	
	readHeader();
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let appearInspctTable = $('#appearInspctTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-8'f><'col-sm-12 col-md-4'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",         
        language: lang_kor,
        paging: false,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
      	//header 고정
		scrollY: '65vh',
		scrollX: true,
		fixedColumns: {
			leftColumns: 4
		},
        pageLength: 20,
        ajax: {
            url: '<c:url value="/qm/goodsInspectDailyWorkContent"/>',
            type: 'GET',
            data: {
            	'menuAuth'			:		menuAuth,
	           	'appearInspctDate'	:		function() { return chooseDateTo.replace(/-/g, ''); },
				'equipCd'			:		function() { return equipList },
	           	'goodsCd'			:		function() { return goodsList },
	           	//'goodsCd'			:		function() { return goodsCd },
	           	'qutyCd'			:		function() { return qutyCd },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        //rowId: 'workOrdNo',
        columns: [
        	{ data: 'goodsNm',
				render: function(data, type, row) {
					if (data != null) {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'model',
				render: function(data, type, row) {
					if (data != null) {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'qutyNm',
				render: function(data, type, row) {
					if (data != null) {
						return data;
					} else {
						return '전체';
					}
				}
			},
			{ data: 'itemNm' },
			{ data: 'quarter1',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'quarter2',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'quarter3',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'month1',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'month2',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'month3',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'week1',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'week2',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'week3',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day1',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day2',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day3',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day4',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day5',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day6',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day7',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day8',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day9',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day10',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day11',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day12',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day13',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
			{ data: 'day14',
				render: function(data, type, row) {
					//if( row["gubun"] == "운영계획수량" ){
					if (data != null) {
						if(row["itemNm"] == "양품률"){
							return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data.toFixed(1)) + ' %</p>';
						} else {
							return addCommas(data);
						}
					} else {
						return '0';
					}
				}
			},
        ],
        columnDefs: [
        	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26] , render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26], className: 'text-right' }, 
        ],
        order: [
            //[ 1, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '일일 업무실적보고 ',
            },
            {
                extend: 'excel',
                title: '일일 업무실적보고 ',
            },
            {
                extend: 'print',
                title: '일일 업무실적보고 ',
            }
        ],
		drawCallback:function(){
			$('#appearInspctTable').rowspan(0);
			$('#appearInspctTable').rowspan(1);
			$('#appearInspctTable').rowspan(2);
			$('#my-spinner').hide();
		}
    });
   
	var html1 = '<div class="row flex-nowrap">';
		html1 += '&nbsp<label class="input-label-sm" style="margin-right:3px;">외관검사일</label><div class="form-group input-sub row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal" name="chooseDateToCal" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateToCal,chooseDateToCal,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		
		html1 += '<div class="multipleSelection pos-real mr-2">';
		html1 += '<div class="selectBox selectBox1" onclick="showEquipCdCheckboxes()">';
		html1 += '<select class="custom-select custom-select1 w-120" id="selectEquipList">';
		html1 += '<option>설비 목록</option>';
		html1 += '</select>';
		html1 += '<div class="overSelect"></div>';
		html1 += '</div>';
		html1 += '<div id="checkBoxes1" class="checkBoxes1 selectBoxOverFlow" style="height:300px;">';
		html1 += '</div>';
		html1 += '</div>';

		//html1 += '<label class="input-label-sm ml-2" style="margin-right:5px;"">제품</label><select class="custom-select" id="goodsCd" style="width:120px;"></select>';
		html1 += '<div class="multipleSelection pos-real">';
		html1 += '<div class="selectBox selectBox1" onclick="showGoodsCdCheckboxes()">';
		html1 += '<select class="custom-select custom-select1 w-150" id="selectEquipList">';
		html1 += '<option>제품 목록</option>';
		html1 += '</select>';
		html1 += '<div class="overSelect"></div>';
		html1 += '</div>';
		html1 += '<div id="checkBoxes2" class="checkBoxes2 selectBoxOverFlow" style="height:300px;">';
		html1 += '</div>';
		html1 += '</div>';
		
		html1 += '<label class="input-label-sm ml-2 mr-2">재질</label>';
		html1 += '<select class="custom-select custom-select-sm" id="qutyCd" style="width:70px;">';
		html1 += '<option value=>전체</option>';
		html1 += '<option value="001">AL</option>';
		html1 += '<option value="002">Nicu</option>';
		html1 += '</select>';
		html1 += '<button type="button" class="btn btn-primary ml-2 mr-5" id="btnRetv">조회</button>';
		//html1 += '<button type="button" class="btn btn-danger ml-5" id="btnAdviceModal">도움말</button>';
	$('#appearInspctTable_filter').html(html1);
	$('#chooseDateToCal').val(chooseDateTo);
	//selectBoxAppend(goodsCode, "goodsCd", '', "1");
	
	var html2 = '';
	html2 += '<label for="equipCdListCheckAll" style="margin-right: 0px;"><input type="checkbox" style="margin-right:6px;" id="equipCdListCheckAll" checked/>전체 선택/해제</label>';
	for (var i=0; i<equipCode.length; i++) {
		html2 += '<label for="' + equipCode[i].baseCd + '" style="margin-right: 0px;"><input type="checkbox" value="' + equipCode[i].baseCd + '" style="margin-right:6px;" id="' + equipCode[i].baseCd + '" checked/>' + equipCode[i].baseCdNm + '</label>';
	}

	var html3 = '';
	html3 += '<label for="goodsCdListCheckAll" style="margin-right: 0px;"><input type="checkbox" style="margin-right:6px;" id="goodsCdListCheckAll" checked/>전체 선택/해제</label>';
	for (var j=0; j<goodsCode.length; j++) {
		html3 += '<label for="' + goodsCode[j].baseCd + '" style="margin-right: 0px;"><input type="checkbox" value="' + goodsCode[j].baseCd + '" style="margin-right:6px;" id="' + goodsCode[j].baseCd + '" checked/>' + goodsCode[j].baseCdNm + '</label>';
	}

	$('#checkBoxes1').html(html2);
	for (var i=0; i<equipCode.length; i++) {
		if( equipCode[i].selectYn == "Y" ){
			$('#' + equipCode[i].baseCd).prop("checked", true);
		} else{
			$('#' + equipCode[i].baseCd).prop("checked", false); 
		}
	}
	$('#checkBoxes2').html(html3);

	/* $(document).ready(function(){ 
		$('#btnRetv').trigger('click'); 
	}); */

	/* 
    // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });	 */

	var quarter1 = '';
    var quarter2 = '';
    var quarter3 = '';
    var month1 = '';
    var month2 = '';
    var month3 = '';
    var week1 = '';
    var week2 = '';
    var week3 = '';
    var day1 = '';
    var day2 = '';
    var day3 = '';
    var day4 = '';
    var day5 = '';
    var day6 = '';
    var day7 = '';
    var day8 = '';
    var day9 = '';
    var day10 = '';
    var day11 = '';
    var day12 = '';
    var day13 = '';
    var day14 = '';

    //$('#qutyCd, #goodsCd').change(function() {
    $('#qutyCd').change(function() {
		equipList = '';
		for (var i=0; i<equipCode.length; i++) {
			if($('#' + equipCode[i].baseCd).is(":checked") == true) {
				equipList += '/' + $('#' + equipCode[i].baseCd).val();
			}
		}
    	goodsList = '';
		for (var j=0; j<goodsCode.length; j++) {
			if ($('#' + goodsCode[j].baseCd).is(":checked") == true) {
				goodsList += '/' + $('#' + goodsCode[j].baseCd).val();
			}
		}
    	
    	if (equipList == '') {
    		toastr.warning('설비를 선택해 주세요!', '', {timeOut: 5000});
        	if (equipCdListshow == true) {
        		showEquipCdCheckboxes();
            }
			return false;
        }
    	if (goodsList == '') {
    		toastr.warning('제품을 선택해 주세요!', '', {timeOut: 5000});
        	if (goodsCdListShow == true) {
        		showGoodsCdCheckboxes();
            }
			return false;
        }
    	
    	$('#my-spinner').show();
    	chooseDateTo = $('#chooseDateToCal').val();
    	if (equipCdListshow == false){
    		showEquipCdCheckboxes();
        }
    	if (goodsCdListShow == false){
    		showGoodsCdCheckboxes();
        }
        
    	readHeader();
    	//goodsCd =  $('#goodsCd option:selected').val();
    	qutyCd = $('#qutyCd option:selected').val();
		$('#appearInspctTable').DataTable().ajax.reload( function () {});
    });
    
	$('#btnRetv').on('click', function() {
    	equipList = '';
    	for (var i=0; i<equipCode.length; i++) {
    		if ($('#' + equipCode[i].baseCd).is(":checked") == true) {
    			equipList += '/' + $('#' + equipCode[i].baseCd).val();
        	}
    	}
    	goodsList = '';
		for (var j=0; j<goodsCode.length; j++) {
			if ($('#' + goodsCode[j].baseCd).is(":checked") == true) {
				goodsList += '/' + $('#' + goodsCode[j].baseCd).val();
			}
		}
		
    	if (goodsList == '') {
    		toastr.warning('제품을 선택해 주세요!', '', {timeOut: 5000});
        	if (goodsCdListShow == true) {
        		showGoodsCdCheckboxes();
            }
			return false;
        }
    	if (equipList == '') {
    		toastr.warning('설비를 선택해 주세요!', '', {timeOut: 5000});
        	if (goodsCdListShow == true) {
        		showCheckboxes();
            }
			return false;
        }
    	
    	$('#my-spinner').show();
    	
    	if (equipCdListshow == false) {
    		showEquipCdCheckboxes();
        }
    	if (goodsCdListShow == false) {
    		showGoodsCdCheckboxes();
        }
    	readHeader();
    	chooseDateTo = $('#chooseDateToCal').val();
    	//goodsCd =  $('#goodsCd option:selected').val();
    	qutyCd = $('#qutyCd option:selected').val();
		$('#appearInspctTable').DataTable().ajax.reload( function () {});
    });

    function readHeader() {
    	$.ajax({
			url: '<c:url value="/qm/goodsInspectDailyWorkHeader"/>',
			type: 'GET',
			dataType: 'json',
			async: false,
			data : {
				'chooseDateTo'	:	function() { return chooseDateTo; },
			},	          
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					//console.log(data);
					for (var i=0; i<data.length; i++) {
						if(data[i].headerGubun == 'QUARTER1' && data[i].headerType == 'MIN') {
							quarter1 = data[i].headerQuarter + "분기<br>" + data[i].headerMonth + '월 ~ ';
						} else if(data[i].headerGubun == 'QUARTER2' && data[i].headerType == 'MIN') {
							quarter2 = data[i].headerQuarter + "분기<br>" + data[i].headerMonth + '월 ~ ';
						} else if(data[i].headerGubun == 'QUARTER3' && data[i].headerType == 'MIN') {
							quarter3 = data[i].headerQuarter + "분기<br>" + data[i].headerMonth + '월 ~ ';
						} else if(data[i].headerGubun == 'QUARTER1' && data[i].headerType == 'MAX') {
							quarter1 += data[i].headerMonth + '월';
						} else if(data[i].headerGubun == 'QUARTER2' && data[i].headerType == 'MAX') {
							quarter2 += data[i].headerMonth + '월';
						} else if(data[i].headerGubun == 'QUARTER3' && data[i].headerType == 'MAX') {
							quarter3 += data[i].headerMonth + '월';

						} else if(data[i].headerGubun == 'MONTH1' && data[i].headerType == 'MIN') {
							month1 = data[i].headerMonth + "월<br>총계";
						} else if(data[i].headerGubun == 'MONTH2' && data[i].headerType == 'MIN') {
							month2 = data[i].headerMonth + "월<br>총계";
						} else if(data[i].headerGubun == 'MONTH3' && data[i].headerType == 'MIN') {
							month3 = data[i].headerMonth + "월<br>총계";
						//} else if(data[i].headerGubun == 'MONTH1' && data[i].headerType == 'MAX') {
						//	monthr1 += data[i].headerMonth + "월<br>총계";
						//} else if(data[i].headerGubun == 'MONTH2' && data[i].headerType == 'MAX') {
						//	month2 += data[i].headerMonth + "월<br>총계";
						//} else if(data[i].headerGubun == 'MONTH3' && data[i].headerType == 'MAX') {
						//	month3 += data[i].headerMonth + "월<br>총계";

						} else if(data[i].headerGubun == 'WEEK1' && data[i].headerType == 'MIN') {
							week1 = data[i].headerIsoWeek + "주차<br>" + data[i].headerMonth + ". " + parseInt(right(data[i].headerDate, 2)) + " ~ ";
						} else if(data[i].headerGubun == 'WEEK2' && data[i].headerType == 'MIN') {
							week2 = data[i].headerIsoWeek + "주차<br>" + data[i].headerMonth + ". " + parseInt(right(data[i].headerDate, 2)) + " ~ ";
						} else if(data[i].headerGubun == 'WEEK3' && data[i].headerType == 'MIN') {
							week3 = data[i].headerIsoWeek + "주차<br>" + data[i].headerMonth + ". " + parseInt(right(data[i].headerDate, 2)) + " ~ ";
						} else if(data[i].headerGubun == 'WEEK1' && data[i].headerType == 'MAX') {
							week1 += data[i].headerMonth + "." + parseInt(right(data[i].headerDate, 2));
						} else if(data[i].headerGubun == 'WEEK2' && data[i].headerType == 'MAX') {
							week2 += data[i].headerMonth + "." + parseInt(right(data[i].headerDate, 2));
						} else if(data[i].headerGubun == 'WEEK3' && data[i].headerType == 'MAX') {
							week3 += data[i].headerMonth + "." + parseInt(right(data[i].headerDate, 2));


						//headerDayOfWeek = 1이면 일요일, 7이면 토요일
						} else if(data[i].headerGubun == 'DAY1') {
							day1 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day1').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day1').css("color","blue");
							} else {
								$('#day1').css("color","black");
							}
							
						} else if(data[i].headerGubun == 'DAY2') {
							day2 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day2').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day2').css("color","blue");
							} else {
								$('#day2').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY3') {
							day3 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day3').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day3').css("color","blue");
							} else {
								$('#day3').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY4') {
							day4 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day4').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day4').css("color","blue");
							} else {
								$('#day4').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY5') {
							day5 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day5').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day5').css("color","blue");
							} else {
								$('#day5').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY6') {
							day6 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day1').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day6').css("color","blue");
							} else {
								$('#day6').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY7') {
							day7 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day7').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day7').css("color","blue");
							} else {
								$('#day7').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY8') {
							day8 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day8').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day8').css("color","blue");
							} else {
								$('#day8').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY9') {
							day9 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day9').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day9').css("color","blue");
							} else {
								$('#day9').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY10') {
							day10 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day10').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day10').css("color","blue");
							} else {
								$('#day10').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY11') {
							day11 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day11').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day11').css("color","blue");
							} else {
								$('#day11').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY12') {
							day12 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day12').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day12').css("color","blue");
							} else {
								$('#day12').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY13') {
							day13 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day13').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day13').css("color","blue");
							} else {
								$('#day13').css("color","black");
							}
						} else if(data[i].headerGubun == 'DAY14') {
							day14 = data[i].headerMonth + ". " + data[i].headerDay;
							if (data[i].headerDayOfWeek == 1) {
								$('#day14').css("color","red"); }
							else if (data[i].headerDayOfWeek == 7) {
								$('#day14').css("color","blue");
							} else {
								$('#day14').css("color","black");
							}
						}
					}
					$('#quarter1').html(quarter1);
					$('#quarter2').html(quarter2);
					$('#quarter3').html(quarter3);
					$('#month1').html(month1);
					$('#month2').html(month2);
					$('#month3').html(month3);
					$('#week1').html(week1);
					$('#week2').html(week2);
					$('#week3').html(week3);
					$('#day1').html(day1);
					$('#day2').html(day2);
					$('#day3').html(day3);
					$('#day4').html(day4);
					$('#day5').html(day5);
					$('#day6').html(day6);
					$('#day7').html(day7);
					$('#day8').html(day8);
					$('#day9').html(day9);
					$('#day10').html(day10);
					$('#day11').html(day11);
					$('#day12').html(day12);
					$('#day13').html(day13);
					$('#day14').html(day14);
				} else if (res.result == 'fail') {
					//toastr.error(res.warning, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#btnAddConfirm').removeClass('d-none');
				$('#btnAddConfirmLoading').addClass('d-none');
			}
		});
	}

	$('#appearInspctTable tbody').on('click', 'tr', function () {
		if ( $(this).hasClass('selected') ) {
		    $(this).removeClass('selected');
		} else {
			$('#appearInspctTable').DataTable().$('tr.selected').removeClass('selected');
		    $(this).addClass('selected');
		}
	});
	
	$('#equipCdListCheckAll').on('click', function () {
		if($('#equipCdListCheckAll').is(":checked") == true) {
			for (var i=0; i<equipCode.length; i++) {
				$('#' + equipCode[i].baseCd).prop("checked", true); 
			}
		} else {
			for (var i=0; i<equipCode.length; i++) {
				$('#' + equipCode[i].baseCd).prop("checked", false); 
			}
		}
	});

	$('#goodsCdListCheckAll').on('click', function () {
		if($('#goodsCdListCheckAll').is(":checked") == true) {
			for (var i=0; i<equipCode.length; i++) {
				$('#' + goodsCode[i].baseCd).prop("checked", true); 
			}
		} else {
			for (var i=0; i<equipCode.length; i++) {
				$('#' + goodsCode[i].baseCd).prop("checked", false); 
			}
		}
	});
	
	//설비목록 checkBox
	var equipCdListshow = true;
	function showEquipCdCheckboxes() {
		var equipCdCheckBox = document.getElementById("checkBoxes1");
		if (equipCdListshow) {
			equipCdCheckBox.style.display = "block";
			equipCdListshow = false;
		} else {
			equipCdCheckBox.style.display = "none";
			equipCdListshow = true;
		}
	}

	//제품코드 checkBox
	var goodsCdListShow = true;
	function showGoodsCdCheckboxes() {
		var goodsCdCheckBox = document.getElementById("checkBoxes2");
		if (goodsCdListShow) {
			goodsCdCheckBox.style.display = "block";
			goodsCdListShow = false;
		} else {
			goodsCdCheckBox.style.display = "none";
			goodsCdListShow = true;
		}
	}
	
	
	//$('#btnAdviceModal').on('click', function () {
	//	$('#advicePopupModal').modal('show');
	//});
	
</script>

</body>
</html>
