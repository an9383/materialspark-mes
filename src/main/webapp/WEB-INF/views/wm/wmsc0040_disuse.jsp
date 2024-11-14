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
					<li class="breadcrumb-item"><a href="#">생산관리</a></li>
					<li class="breadcrumb-item active">생산현황조회</li>
				</ol>
			</nav>
		</header>
		<!-- #main============================================================== -->
		<div class="container-fluid" id="main">
			<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width:99%;">
				<div class="card">
				<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="totalActualOutputDataList" class="table table-bordered">
							<thead class="thead-light">
							    <tr>
									<th style="min-width: 35px" class="text-center">설비명</th>
									<th style="min-width: 50px" class="text-center">거래처</th>
									<th style="min-width: 40px" class="text-center">제품</th>
									<th style="min-width: 25px" class="text-center">재질</th>
									<th style="min-width: 120px"class="text-center">규격</th>
									<th style="min-width: 55px" class="text-center">A목표수량</th>
									<th style="min-width: 45px" class="text-center">A생산량</th>
									<th style="min-width: 70px" class="text-center">A달성율(%)</th>
									<th style="min-width: 57px" class="text-center">B목표수량</th>
									<th style="min-width: 45px" class="text-center">B생산량</th>
									<th style="min-width: 70px" class="text-center">B달성율(%)</th>
									<th style="min-width: 57px" class="text-center">C목표수량</th>
									<th style="min-width: 45px" class="text-center">C생산량</th>
									<th style="min-width: 70px" class="text-center">C달성율(%)</th>
									<th style="min-width: 70px" class="text-center">합계 목표수량</th>
									<th style="min-width: 70px" class="text-center">합계 생산량</th>
									<th style="min-width: 80px" class="text-center">합계 달성율(%)</th>
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

	let menuAuth = 'wmsc0040';
	let currentHref = 'wmsc0040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","생산현황조회");

	//공통코드 처리 시작   	
	var equipGroupCode=new Array(); // 설비그룹
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    
    var qutyCdCode=new Array(); // 재질
    <c:forEach items="${qutyCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		qutyCdCode.push(json);
    </c:forEach>
    //공통코드 처리 종료
	
	var chooseDate1 =  "${serverDateFrom}";
	var chooseDate2 =  "${serverDateTo}";
	var equipGroup = null;
	var qutyCd = null;
    
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let totalActualOutputDataList = $('#totalActualOutputDataList').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: true,
        pageLength: 20,
        ajax: {
   	        url: '<c:url value="/wm/readTotalActualOutputDataList"/>',
   	        type: 'GET',
   	        data: {
   	        	'menuAuth'	 	: 		menuAuth,
   	           	'chooseDate1': function() { return chooseDate1; },
   	           	'chooseDate2': function() { return chooseDate2; },
   	         	'equipGroup': function() { return equipGroup; },
   	         	'qutyCd': function() { return qutyCd; },
   	        },
   	    },
   	    columns: [
   	    	{ data: 'equipNm'},
   	    	{ data: 'dealCorpNm'},
   	    	{ data: 'goodsNm'},
   	    	{ data: 'qutyNm'},
   	    	{ data: 'model'},
   	    	{ data: 'targetAsum'},
   	    	{ data: 'outputAsum'},
            { data: 'percentA',
            	render: function(data, type, row) {					
					return data + " %";
                } 
            },
   	    	{ data: 'targetBsum'},
   	    	{ data: 'outputBsum'},
   	     	{ data: 'percentB',
            	render: function(data, type, row) {					
					return data + " %";
                } 
            },
   	    	{ data: 'targetCsum'},
   	    	{ data: 'outputCsum'},
   	     	{ data: 'percentC',
            	render: function(data, type, row) {					
					return data + " %";
                } 
            },
   	    	{ data: 'totalTarget'},
   	    	{ data: 'totalOutput'},
   	    	{ data: 'totalPercent',
            	render: function(data, type, row) {					
					return data + " %";
                } 
            },
   	    ],
        columnDefs: [
        	{ targets: [5,6,7,8,9,10,11,12,13,14,15,16], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [5,6,7,8,9,10,11,12,13,14,15,16], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '생산현황조회',
            },
            {
                extend: 'excel',
                title: '생산현황조회',
            },
            {
                extend: 'print',
                title: '생산현황조회',
            }
        ],
    });

	var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
	html1 += '&nbsp;<label class="input-label-sm">생산기간</label><input class="form-control" style="width:97px;" type="text" id="chooseDate3"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate3,chooseDate3,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateCalendar1" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate4"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate4,chooseDate4,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">설비그룹</label><select  class="custom-select" id="equipGroupCd" sytle="width:55px;" ></select>&nbsp;';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">재질</label><select  class="custom-select" id="qutyCd" sytle="width:55px;" ></select>&nbsp;';
	html1 += '<button type="button" class="btn btn-primary" id="btnRetv">조회</button></div>';
	$('#totalActualOutputDataList_length').html(html1);
	selectBoxAppend(equipGroupCode, "equipGroupCd", "", "2");
	selectBoxAppend(qutyCdCode, "qutyCd", "", "2");
	$('#chooseDate3').val(chooseDate1);
	$('#chooseDate4').val(chooseDate2);

  	$('#equipCodeAdmTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});
  	
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDate3').val());
		let dateTo = new Date($('#chooseDate4').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDate3').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDate3').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDate3').focus();
			return false;
		}
		
    	chooseDate1 = $('#chooseDate3').val().replace(/-/g, '');
    	chooseDate2 = $('#chooseDate4').val().replace(/-/g, '');
    	equipGroup = $('#equipGroupCd').val();
    	qutyCd = $('#qutyCd').val();
		$('#totalActualOutputDataList').DataTable().ajax.reload();
	});

	/* 
    function dateAddDel(sDate, nNum, type) {
        var yy = parseInt(sDate.substr(0, 4), 10);
        var mm = parseInt(sDate.substr(5, 2), 10);
        var dd = parseInt(sDate.substr(8), 10);
        
        if (type == "d") {
            d = new Date(yy, mm - 1, dd + nNum);
        }
        else if (type == "m") {
            d = new Date(yy, mm - 1, dd + (nNum * 31));
        }
        else if (type == "y") {
            d = new Date(yy + nNum, mm - 1, dd);
        }
     
        yy = d.getFullYear();
        mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
        dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
     
        return '' + yy + '-' +  mm  + '-' + dd;
    }
    //사용예시
	dateAddDel('2017-09-25', -7, 'd');	//일자 빼기
	dateAddDel('2017-09-25', -1, 'm'); 	//월 빼기
	dateAddDel('2017-09-25', -1, 'y');	//년 빼기
	*/
     
</script>

</body>
</html>
