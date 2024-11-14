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
					<li class="breadcrumb-item"><a href="#">설비연동</a></li>
					<li class="breadcrumb-item active">생산실적</li>
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
		                    <table id="equipCodeAdmTable" class="table table-bordered">
		                        <thead class="thead-light">
			                        <tr>
										<th style="min-width: 50px" class="text-center">생산일</th>
										<th style="min-width: 25px" class="text-center">주야</th>
										<th style="min-width: 40px" class="text-center">설비명</th>
										<th style="min-width: 50px" class="text-center">거래처</th>
										<th style="min-width: 40px" class="text-center">제품</th>
										<th style="min-width: 40px" class="text-center">재질</th>
										<th style="min-width: 100px"class="text-center">규격</th>
										<th style="min-width: 100px"class="text-center">Lot No</th>
										<th style="min-width: 55px" class="text-center">목표 수량</th>
										<th style="min-width: 65px" class="text-center">설비 생산량</th>
										<th style="min-width: 65px" class="text-center">달성률(%)</th>
										<th style="min-width: 80px" class="text-center">Film</th>
										<th style="min-width: 60px" class="text-center">면취(압연)</th>
										<th style="min-width: 85px" class="text-center">구분(연질,경질)</th>
										<th style="min-width: 50px" class="text-center">작업조</th>
										<th style="min-width: 40px" class="text-center">작업자</th>
										<th style="min-width: 80px" class="text-center">작지번호</th>
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

	let menuAuth = 'eisc0020';
	let currentHref = 'eisc0020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","생산실적");

	var serverDate =  "${serverDate}";
	var preInWhsDate =  serverDate;

	//공통코드 시작
    var dayNightCode=new Array();
    <c:forEach items="${dayNightCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		dayNightCode.push(json);
    </c:forEach>
  	//공통코드 종료
  	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let equipCodeAdmTable = $('#equipCodeAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/wm/readActualOutputDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'ordDate': function() { return preInWhsDate.replace(/-/g, ''); },
	           	'ordGubun': function() { return $('#dayNightCd').val(); },
            },
        },
        rowId: 'workOrdNo',
        columns: [
        	{ 
		data: 'ordDate',
		render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
				} 
			},
			{ data: 'ordGubun',
	    		render: function(data, type, row, meta) {	
	    			if(data == "D") {
	    				return "주간";
	    			} else if(data == "N") {
						return "야간";
	    			}
	    		}
	    	},
        	{ data: 'equipNm' },		//설비명
        	{ data: 'dealCorpNm' },		//거래처
        	{ data: 'goodsNm' },		//제품명
        	{ data: 'qutyNm' },			//재질
        	{ data: 'model' },			//규격
        	{ data: 'ordLotNo' },		//lotNo
        	{ data: 'targetCnt' },		//목표수량
        	{ data: 'outputCnt' },		//생산수량
        	{ data: 'outputCnt',	//달성률
	    		render: function(data, type, row, meta) {
		    		return ((parseFloat(data)/parseFloat(row['targetCnt']))*100).toFixed(2) + " %";
	    		}
	    	},
        	{ data: 'filmNm'},			//Film
        	{ data: 'chamferYnNm'},		//면취
        	{ data: 'gubunNm'},			//구분
        	{ data: 'workTeamNm'},		//작업조명
        	{ data: 'userNm'},			//작업자명
        	{ data: 'workOrdNo'},		//작지번호
        ],
        columnDefs: [
        	{ targets: [8,9,10], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [8,9,10], className: 'text-right' },
        ],
        buttons: [
            {
                extend: 'copy',
                title: '생산실적관리',
            },
            {
                extend: 'excel',
                title: '생산실적관리',
            },
            {
                extend: 'print',
                title: '생산실적관리',
            },
        ],
    });

	var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
	html1 += '<label class="input-label-sm">&nbsp;기간</label><input class="form-control" style="width:97px;" type="text" id="chooseDate" name="preInWhsDate" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate,chooseDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">주야구분</label><select  class="custom-select" id="dayNightCd" ></select>&nbsp;  <button type="button" class="btn btn-primary" id="btnRetv">조회</button></div>';

	$('#equipCodeAdmTable_length').html(html1);
	$('#chooseDate').val(serverDate);
	selectBoxAppend(dayNightCode, "dayNightCd", "", "1");
  	//달력 값 변경 시 자동검색
  	//$('#preInWhsDate').bind('input', function() {
  	//	preInWhsDate = $('#preInWhsDate').val();
	//	$('#equipCodeAdmTable').DataTable().ajax.reload();
  	//});
  	
  	$('#btnRetv').on('click', function() {
  	  	preInWhsDate = $('#chooseDate').val();
  		$('#equipCodeAdmTable').DataTable().ajax.reload();
	});
  	
  	$('#equipCodeAdmTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});

	function calculatorDay(date){ 
		return date.replace(/-/g, '');
	}
	
</script>
</body>
</html>
