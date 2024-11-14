<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">모니터링 공지사항</li>
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
						<table id="monitoringNoticeTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width:50px">순번</th>
									<th style="min-width:300px">공지사항</th>
									<th style="min-width:70px">등록자</th>
									<th style="min-width:70px">등록일자</th>
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
						<button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
						<button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
					</div>
					<form id="form" enctype="multipart/form-data">
						<div class="table-responsive">
							<table class="table table-bordered mb-2">
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
								<tr>
									<th>공지사항</th>
									<input type="hidden" class="form-control" id="idx" name="idx" value="0">									
									<td>
										<div class="form-group m-0">
											<input class="form-control" type="text" style="min-width:100%;" id="content" name="content" maxlength="256" disabled/>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</form>
					<div class="mt-2">
						<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					</div>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'bmsc0130';
	let currentHref = 'bmsc0130';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","모니터링 공지사항"); 

	var idx = '';
    let sideView = 'add';
	uiProc(true);
	
//   	//공통코드 처리 시작
//     var postedCode=new Array();
//     <c:forEach items="${posted}" var="info">
// 		var json=new Object();
// 		json.baseCd="${info.baseCd}";
// 		json.baseCdNm="${info.baseCdNm}";
// 		postedCode.push(json);
//     </c:forEach>
// 	//공통코드 처리 종료
// 	selectBoxAppend(postedCode, "posted", "" , "2");  
      
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let monitoringNoticeTable = $('#monitoringNoticeTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/bm/monitoringNoticeList"/>',
            type: 'GET',
            data: {
            	'menuAuth' : menuAuth ,            	
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'idx',
        columns: [
            { data: 'idx', 'className':'text-center' },
//             { data: 'startDate', 'className':'text-center',
// 				render: function(data, type, row) {      
// 					if(data == "" || data == null || data =='invalid date') {
// 						return "-" ;
// 					} else {
// 						return moment(data).format('YYYY-MM-DD');
// 					}
// 				}
// 			},
            { data: 'content' },
            { data: 'userNm', 'className':'text-center' },
            { data: 'regDate' },
        ],
        columnDefs: [
            {                
            },
        ],
        order: [
            [ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '모니터링 공지사항',
            },
            {
                extend: 'excel',
                title: '모니터링 공지사항',
            },
            {
                extend: 'print',
                title: '모니터링 공지사항',
            }
        ],
    });

    $('#monitoringNoticeTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#monitoringNoticeTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        idx = monitoringNoticeTable.row( this ).data().idx;
        $('#btnSave').addClass('d-none');  //저장버튼
        
        $.ajax({
            url: '<c:url value="/bm/monitoringNoticeRead"/>',
            type: 'GET',
            data: {
                'menuAuth'	:	menuAuth,
                'idx'		:	function() { return idx; },
            },
            success: function (res) {
                let data = res.data;               
                sideView = 'edit';
                // 보기
                $('#idx').val(data.idx);
                $('#content').val(data.content);
				//화면처리
                uiProc(true);             
                //선택박스 처리               
                //selectBoxAppend(postedCode, "posted", data.posted , "");  			
            }
        });
    });

    // 등록폼
    $('#btnAdd').on('click', function() {
        sideView = 'add';
        $('#form').each(function(){
            this.reset();
        });
        
		//화면처리
        uiProc(false);    
        //선택박스 처리
        //selectBoxAppend(postedCode, "posted", "" , "2");  	
        $('#btnSave').removeClass('d-none');  // 저장버튼
    });

    // 수정폼
    $('#btnEdit').on('click', function() {
        if(sideView != 'edit') {
        	toastr.warning("수정할 목록을 선택해 주세요!");
            return false;
        }
		uiProc(false);
        $('#btnSave').removeClass('d-none');
    });    


    // 등록 처리
    $('#btnSave').on('click', function() {
        if (!$.trim($('#content').val())) {
            toastr.warning('공지사항을 입력해 주세요.');
            $('#content').focus();
            return false;
        }
        
        var url = '<c:url value="/bm/monitoringNoticeCreate"/>';
        if( sideView == "edit" ) {        	
        	url = '<c:url value="/bm/monitoringNoticeUpdate"/>';
        }
        
        $.ajax({
			url: url,
			type: 'POST',
			data: {
				'menuAuth'		: 		menuAuth ,
				'idx'   		:		$('#idx').val(),                 
				'content'   	:		$('#content').val(),                
			},
			beforeSend: function() {
			  //  $('#btnAddConfirm').addClass('d-none');
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					$('#idx').val(data.idx);
					uiProc(true);
					$('#btnSave').addClass('d-none');
					$('#monitoringNoticeTable').DataTable().ajax.reload( function () {});
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
        $("#content").attr("disabled", flag);                
   	}

</script>

</body>
</html>
