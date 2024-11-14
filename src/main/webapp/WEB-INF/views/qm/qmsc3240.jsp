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
				<li class="breadcrumb-item">품질관리<a href="#"></a></li>
				<li class="breadcrumb-item active">신뢰성 결과 조회(15시간)</li>
			</ol>
		</nav>
		<div style="white-space: nowrap;position: absolute;top: 9.5%;right: 1.1%;background-color: lightpink;display: flex;flex-direction: column;color: black;
								font-size: 15px;padding: 0px 15px 0px 15px;" class="ml-2">
			<label style="font-size:11px;">48HR - 80도, 10,000ppm, 1.7N/mm / 24HR - 80도, 10,000ppm, 1.0N/mm / 15HR - 90도, 20,000ppm , 1.7N/mm</label>
		</div>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width:100%;">
				<div class="card">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<!-- <div class="row" style="margin-bottom:5px;">
							<label class="input-label-sm">등록년도</label>
							<div class="form-group input-sub m-0 row">
								<select class="custom-select" style="width: 150px;" id="chooseDate1">
								</select>
							</div>
							<button type="button" class="btn btn-primary ml-2" id="btnSearch">조회</button>
							
						</div> -->
						<table id="uploadTable" class="table table-bordered">
							<thead class="thead-light">
			             	   <tr>
			                	   <th class="text-center align-middle" rowspan="2" colspan="1">근무조</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">생산일</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">생산일 주/야</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">시험일</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">시험일 주/야</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">작업자</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">기종</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">재질</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">LINE</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">M교체</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">METAL LOT</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">하부</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">상부</th>
			                       <th class="text-center align-middle" rowspan="2" colspan="1">결과값</th>
			                       <th class="text-center align-middle" colspan="2">사이드</th>
			                       <th class="text-center align-middle" colspan="2">12시간 후 재박리</th>
			                   </tr>
			                   <tr>
			                       <th>좌</th>
			                       <th>우</th>
			                       <th>하부</th>
			                       <th>상부</th>
			                   </tr>
                        	</thead>
	                    </table>
			     	</div>
			 		<!-- /.table-responsive -->
				</div>
			</div><!-- /.left-list -->
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc3240';
	let currentHref = 'qmsc3240';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","신뢰성 결과 조회(15시간)");
	var serverDate =  "${serverDate}";
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	var chooseDate = serverDate;
	var equipCondSeq = null;
	var excelDownAll = 'false';
	
	//공통코드 처리 시작
	var equipGroupCode = new Array(); // 설치장소
    <c:forEach items="${equipGroupCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    let equipCode = new Array(); // 설비코드
    <c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipNm}";
		json.baseCdNm="${info.equipNm}";	
		json.baseCd = json.baseCdNm.replaceAll('-','');
		json.baseCdNm = json.baseCdNm.replaceAll('-','');
		equipCode.push(json);
    </c:forEach>
    let gijongList = new Array(); // 기종
    <c:forEach items="${gijongList}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdNm}";
		json.baseCdNm="${info.baseCdNm}";	
		gijongList.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    //변수들
    let equipNm = '';
	let dateGubun = '001';
    let gijongNm = '';
    let metalLotNo = '';
    let resultNg = '';
    let chooseDateFrom = moment().format("YYYY-MM-DD");
    let chooseDateTo = moment().add(1, 'd').format('YYYY-MM-DD');
    //업로드 목록
    $.fn.dataTable.ext.errMode = 'none';
	let uploadTable = $('#uploadTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-7'l><'col-sm-12 col-md-5'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>B",    
	    language: lang_kor,
	    paging: true,
	    info: true,
	    ordering: false,
	    processing: true,
	    autoWidth: false,
	    scrollX : false,
	    scrollY : "67vh",
	    lengthChange : true,
	    pageLength: -1,
	    ajax: {
	        url: '<c:url value="/qm/reliabilityResultShillingList"/>',
	        type: 'GET',
	        data: {
		        'equipNm' : function(){ return equipNm; },
		        'dateGubun' : function(){ return dateGubun; },
		        'gijongNm' : function(){ return gijongNm; },
		        'shillingGubun' : function(){ return '003'; },
		        'chooseDateFrom' : function(){ return chooseDateFrom;},
		        'chooseDateTo' : function(){ return chooseDateTo;},
		        'metalLotNo' : function(){ return metalLotNo;},
		        'resultNg'	: function(){ return resultNg;},
	        },
	    },
	    rowId: 'idx',
	    columns: [
	    	{ data: 'teamCd'}, //근무조
	    	{ data: 'productDate',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != '') {
		    			return moment(data).format('YYYY-MM-DD');
	    			} else {
		    			return '-';
	    			}
	    		}
		    }, //생산일
	    	{ data: 'productDateDN'}, //생산일 주야구분
	    	{ data: 'testDate',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != '') {
		    			return moment(data).format('YYYY-MM-DD');
	    			} else {
		    			return '-';
	    			}
	    		}
    		}, //시험일
	    	{ data: 'testDateDN'}, //시험일 주야구분
	    	{ data: 'workerNm'}, //작업자
	    	{ data: 'gijongNm'}, //기종
	    	{ data: 'qutyNm'}, //재질
	    	{ data: 'equipNm'}, //라인
	    	{ data: 'changeM'}, //M교체
	    	{ data: 'metalLotNo'}, //메탈로트
	    	{ data: 'bottomVal'}, //하부
	    	{ data: 'topVal'}, //상부
	    	{ data: 'shillingResult',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != '') {
		    			if(data == 'OK'){
		    				return '<div style="color:blue;">합격</div>';
		    			} else if(data == 'NG'){
		    				return '<div style="color:red;">불합격</div>';
			    		}
	    			} else {
		    			return '-';
	    			}
	    		}
		    }, //결과값
	    	{ data: 'sideLeft'}, //사이드 좌
	    	{ data: 'sideRight'}, //사이드 우
	    	{ data: 'afterBottom'}, //12시간후 하부
	    	{ data: 'afterTop'}, //12시간후 상부
	    ],
	    columnDefs: [
	    	{ targets: [], render: $.fn.dataTable.render.number( ',' ) },
	    	{ targets: [], className: 'text-right-td' },
	    ],
	   
	    buttons: [
	
	    ],
	   /*  order: [
			[ 0, 'asc' ],
		], */
	    drawCallback: function () {
	
	    }
	});
	
	var html1 ='<div class="row" style="margin-bottom:5px;">';
	html1 += '<select class="custom-select" style="" id="dateGubun" ><option value="001">생산일</option><option value="002">시험일</option></select>'
	html1 +='<label class="input-label-sm">기준</label>';
	html1 +='<div class="form-group row">';
	html1 +='<input style="width:110px;min-width:110px;font-size: 11px;" class="form-control" type="date" id="startDate">&nbsp~&nbsp';				
	html1 +='<input style="width:110px;min-width:110px;font-size: 11px;" class="form-control" type="date" id="endDate">';	
	html1 += '<label class="input-label-sm ml-2">설비명</label>';
	html1 += '<select class="custom-select custom-select1" id="equipCd">';
	html1 += '</select>';
	html1 += '<label class="input-label-sm ml-2">기종</label>';
	html1 += '<select class="custom-select custom-select1" id="gijongNm">';
	html1 += '</select>';
	html1 += '<label class="input-label-sm ml-2">불합격</label>';
	html1 += '<select class="custom-select custom-select1" id="resultNg">';
	html1 += '<option value="Y" selected>조회</option>';
	html1 += '<option value="N">미조회</option>';
	html1 += '</select>';
	html1 +='</div>';
	html1 += '<input type="text" id="metalLotNo" class="form-control ml-2" placeholder="METAL LOT 검색">'
	html1 += '<button type="button" class="btn btn-primary ml-2" id="btnSearch">조회</button>';
	html1 +='</div>';
	$('#uploadTable_length').html(html1);
	selectBoxAppend(equipCode, "equipCd", "" , "1");
	selectBoxAppend(gijongList, "gijongNm", "" , "1");
	$('#endDate').val(moment().add(1, 'd').format('YYYY-MM-DD'));
	$('#startDate').val(moment().format("YYYY-MM-DD"));

	$('#btnSearch').on('click',function(){
		equipNm = $('#equipCd').val();
		dateGubun = $('#dateGubun').val();
		gijongNm = $('#gijongNm').val();
		chooseDateFrom = $('#startDate').val().replaceAll('-','');
		chooseDateTo = $('#endDate').val().replaceAll('-','');
		metalLotNo = '%'+$('#metalLotNo').val()+'%';
		resultNg = $('#resultNg').val();
		uploadTable.ajax.reload();
	});
	
	/* $(document).ready(function(){
		setDateBox();
	}); 
   // select box 연도 , 월 표시
   function setDateBox(){
       var dt = new Date();
       var year = "";
       var com_year = dt.getFullYear();
       for(var y = (com_year-3); y <= (com_year+5); y++){
           $("#chooseDate1").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
       }

       $("#chooseDate1").val(com_year);
   } */
	
</script>
</body>
</html>