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
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">설비 가동/비가동 관리</li>
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
					<table id="operationTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th> 주야 </th>
								<th> 설비명 </th>
								<th> 상태 </th>
								<th> 가동 시작시간 </th>
								<th> 가동 종료시간 </th>
								<th> 기동시간(분) </th>
								<th> 비가동 시작시간 </th>
								<th> 비가동 종료시간 </th>
								<th> 비가동(분) </th>
								<th> 비가동구분 </th>
								<th> 사유 </th>
								<th> 작업조 </th>
								<th> 작업자 </th>								                                                                                    
							</tr>
						</thead>
					</table>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'wmsc0050';
	let currentHref = 'wmsc0050';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","설비가동/비가동관리");
 
	//공통코드 처리 시작
	
    //공통코드 처리 종료  
                             
    let viewIdx;
    let sideView = 'add';
	var downtimeRegDate =  "${serverDate}"; 
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let operationTable = $('#operationTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        pageLength: 15,
        ajax: {
            url: '<c:url value="/wm/operationDataList"/>',
            type: 'GET',
            data: {
	           	//'inWhsDate': $('#inWhsDate').val()
	           	'menuAuth'	 	: 		menuAuth,
	           	'downtimeRegDate': function() { return downtimeRegDate.replace(/-/g, ''); },	           
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: '',
        columns: [
            {
            	 render: function(data, type, row) {					
 					if(row['dayNightNm'] != "") {
 						return row['dayNightNm']
 					} else {
 						return row['ordGubunNm'];
 					} 
                 } 
            },         
            { data: 'equipNm' },            
            //가동상태
            { data: 'equipStatus' },
            //가동시작시간
            { data:'workStartTime',
            	 render: function(data, type, row) {	
            		 if(data == "Invalid date" || data == null){
            			 return "";
            		 }
  					return moment(data).format("YYYY-MM-DD hh:mm");
                  } 
            },            	
            //가동종료시간
            { data:'workEndTime',
            	render: function(data, type, row) {
            		if(data == "Invalid date" || data == null){
           			 return "";
           		 }
  					return moment(data).format("YYYY-MM-DD hh:mm");
                } 
            },            
            //가동시간
            { data: 'workTime'},
            { data: 'startTime' },
            { data: 'endTime' },          
            { data: 'stopTime' ,
            	render: function(data, type, row) {	
            		if(data == "0" || data == null){
            			return "";
            		}
  					return data;
                } 
            },
            { data: 'downtimeNm' },                       
            { data: 'code' },
            //작업조
            { data: 'workTeamNm'  },
            //작업자
            { data: 'mainWorkChargrNm' },
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
                title: '생산관리/설비가동&비가동관리',
                exportOptions: {
                    format: {
                        body: function (data, column, row, node) {
                            // if it is select
                            if (row == 13) {
                                return $(data).find("option:selected").text()
                            } else return data
                        }
                    }
                }
            },
            {
                extend: 'excel',
                title: '생산관리/설비가동&비가동관리',
                exportOptions: {
                    format: {
                        body: function (data, column, row, node) {
                            // if it is select
                            if (row == 13) {
                                return $(data).find("option:selected").text()
                            } else return data
                        }
                    }
                }
            }, 
            {
                extend: 'print',
                title: '생산관리/설비가동&비가동관리',
                exportOptions: {
                    format: {
                        body: function (data, column, row, node) {
                            // if it is select
                            if (row == 13) {
                                return $(data).find("option:selected").text()
                            } else return data
                        }
                    }
                }
            },
        ],    });

    
    var sysdate = "${serverTime}";
    //var html1 =  '가입고일 &nbsp;<input type="date" style="width:130px" id="preInWhsDate" value="" placeholder="yyyy-MM-dd">';
    
	var html1 = '<div class="row">&nbsp;<label class="input-label-sm">일자</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="downtimeRegDateCal" name="downtimeRegDateCal" />';
		html1 += '<button onclick="fnPopUpCalendar(downtimeRegDateCal,downtimeRegDateCal,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="preInWhsDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
    	html1 += '&nbsp; <button type="button" class="btn btn-primary" id="btnRetv">조회</button></div>';
    
	$('#operationTable_length').html(html1);

	$('#downtimeRegDateCal').val(downtimeRegDate);
	//selectBoxAppend(approvalCode, "approvalCd", "", "1");
	
    $('#btnRetv').on('click', function() {
    	downtimeRegDate=$('#downtimeRegDateCal').val();
		$('#operationTable').DataTable().ajax.reload( function () {});
    });	


</script>

</body>
</html>
