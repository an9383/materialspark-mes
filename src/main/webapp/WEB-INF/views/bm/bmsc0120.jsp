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
				<li class="breadcrumb-item active">무재해관리</li>
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
						<table id="accidentTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 40px">순번</th>
									<!-- <th style="min-width: 100px">시작일자</th> -->
									<th style="min-width: 100px">공지사항</th>
									<!-- <th style="min-width: 100px">화면게시</th>
									<th style="min-width: 100px">게시시간(초)</th> -->
									<th style="min-width: 100px">등록일자</th>
									<th style="min-width: 100px">등록자</th>
								
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
									<col width="20%">
									<col width="27%">
									<col width="25%">
									<col width="28%">
								</colgroup>
								<tr>
									 <th>시작일자</th>
									<input type="hidden" class="form-control" id="idx" name="idx">									
									<td>
										<div class="form-group input-sub m-0">
											<input class="form-control" type="text" id="startDate" name="startDate" maxlength="10" disabled />
											<button onclick="fnPopUpCalendar(startDate,startDate,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="startDateCalendar" type="button" disabled>
												<span class="oi oi-calendar"></span>
											</button>
										</div>
									</td>
									<th>공지사항</th>									
									<td colspan="3">									
										<input class="form-control" type="text" id="targetDate" name="targetDate" maxlength="10" style="min-width:100%;" disabled />									
									</td>
								</tr>
								<tr>
								<!-- 	<th>화면게시</th>									
									<td>
										<select class="custom-select" id="posted"></select>
									</td>
									<th>게시시간(초)</th>
									<td>
										<input type="text" class="form-control" id="postTime" name="postTime" maxlength="25">
									</td> -->
								</tr>															
							</table>		
							
						</div>
					</form>
					<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled="">
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
					</div>
					<br>
					<br>
				 	<div class="table-responsive">
						<table id="accidentTableImg" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 40px">순번</th>
									<th style="min-width: 100px">이미지명</th>							
								</tr>
							</thead>
						</table>
					</div>
					
					<div>		
					
						<div class="card-body col-sm-12 p-1 mb-2 mt-2">							
						</div>						
						
						<form id="photoForm" enctype="multipart/form-data">
							<div class="table-responsive" style="/*height: 33vh; border-bottom: double 4px black;*/">
								<table class="table table-bordered" id="photoTable">
									<thead>
										<tr>
											<th colspan="2">사진</th>
										</tr>
										<tr>
											<td>
												<div class="custom-file" style="width: 100%;" id="fileSearch" name="fileSearch">				
														<input type="file" id="imgFile" class="custom-file-input" style="min-width: 100%;">
														<label class="custom-file-label" data-count="" id="imageFileNm"></label>
												</div>	
											</td>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</form>
					
					</div>
			
					<button type="button" class="btn btn-primary float-right" id="btnSaveImg">이미지 저장</button>
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

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'bmsc0120';
	let currentHref = 'bmsc0120';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","무재해관리"); 


	var idx = '';
	
    let sideView = 'add';
	uiProc(true);
	
	
  	//공통코드 처리 시작
    var postedCode=new Array();
    <c:forEach items="${posted}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		postedCode.push(json);
    </c:forEach>
  
	//공통코드 처리 종료
	selectBoxAppend(postedCode, "posted", "" , "2");  
      
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let accidentTable = $('#accidentTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/bm/accidentFreeDataList"/>',
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
            /* { data: 'startDate', 'className':'text-center',
				render: function(data, type, row) {      
					if(data == "" || data == null || data =='invalid date') {
						return "-" ;
					} else {
						return moment(data).format('YYYY-MM-DD');
					}
				}
			 }, */
			 {render: function(data, type, row) {      
					return '';
				}
			 },
           /*  { data: 'targetDate' },
            { data: 'postedNm' },
            { data: 'postTime' }, */
            { data: 'regDate' },
            { data: 'userNm', 'className':'text-center' },
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
                title: '무재해관리',
            },
            {
                extend: 'excel',
                title: '무재해관리',
            },
            {
                extend: 'print',
                title: '무재해관리',
            }
        ],
    });

	   // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let accidentTableImg = $('#accidentTableImg').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
    			"<'row'<'col-sm-12'tr>>" +
    			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        language: lang_kor,
        paging: true,
        info: true,
        searching : false,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        pageLength: 7,
        ajax: {
            url: '<c:url value="/bm/accidentFreeImgDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth' : menuAuth ,            	
            },           
        },
        rowId: 'idx',
        columns: [
            { data: 'idx', 'className':'text-center' },         
            { data: 'imgNm', 'className':'text-center' },
         
        ],
        columnDefs: [
            {                
            },
        ],
        order: [
            [ 0, 'asc' ]
        ],
   
    });
    

    // 보기
    $('#accidentTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#accidentTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        
        idx = accidentTable.row( this ).data().idx;     
        $('#btnSave').addClass('d-none');  // 저장버튼
        $.ajax({
            url: '<c:url value="/bm/accidentFreeRead"/>',
            type: 'GET',
            data: {
                'menuAuth' : menuAuth ,
                'idx': function(){return idx}
            },
            success: function (res) {
                let data = res.data;               
                sideView = 'edit';
                // 보기
                $('#idx').val(data.idx);
                $('#startDate').val(moment(data.startDate).format('YYYY-MM-DD'));
                $('#targetDate').val(data.targetDate);
                $('#postTime').val(data.postTime); 
                      
				//화면처리
                uiProc(true);             
                //선택박스 처리               
                selectBoxAppend(postedCode, "posted", data.posted , "");  			
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
        selectBoxAppend(postedCode, "posted", "" , "2");  	
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
        if ( !$.trim($('#startDate').val()) ) {
            toastr.warning('시작일자를 입력해 주세요.');
            $('#startDate').focus();
            return false;
        }
        if ( !$.trim($('#targetDate').val()) ) {
            toastr.warning('목표일수를 입력해 주세요.');
            $('#targetDate').focus();
            return false;
        }        
        if ( !$.trim($('#posted option:selected').val()) ) {
            toastr.warning('게시여부를 선택해 주세요.');
            $('#posted').focus();
            return false;
        }
        if ( !$.trim($('#postTime').val()) ) {
            toastr.warning('게시시간을 입력해 주세요.');
            $('#postTime').focus();
            return false;
        }
        if (isNaN($('#targetDate').val()) ) {
            toastr.warning('목표일수는 숫자만 입력 할 수 있습니다.');
            $('#posted').focus();
            return false;
        }
        if (isNaN($('#postTime').val()) ) {
            toastr.warning('게시시간은 숫자만 입력 할 수 있습니다.');
            $('#postTime').focus();
            return false;
        }



        var url = '<c:url value="/bm/accidentFreeCreate"/>';

        if( sideView == "edit" ) {        	
        	url = '<c:url value="/bm/accidentFreeUpdate"/>';
        }
        
        $.ajax({
			url: url,
			type: 'POST',
			data: {
				'menuAuth'		: 		menuAuth ,
				'idx'   		:		$('#idx').val(),                 
				'startDate'   	:		$('#startDate').val().replace(/-/g,""),                
				'targetDate'   	:		$('#targetDate').val(),
				'posted'		:		$('#posted option:selected').val(),
				'postTime'      :		$('#postTime').val(),				
			},
			beforeSend: function() {
			  //  $('#btnAddConfirm').addClass('d-none');
			},
			success: function (res) {				
				if (res.result == 'ok') {
					uiProc(true);
					$('#btnSave').addClass('d-none');			
					$('#accidentTable').DataTable().ajax.reload( function () {});
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
        $("#startDate").attr("disabled",flag);                
        $("#targetDate").attr("disabled",flag);               
        $("#posted").attr("disabled",flag);                 
        $("#postTime").attr("disabled",flag);                   
        $("#startDateCalendar").attr("disabled",flag); 
        //$('#targetDateCalendar').attr("disabled",flag);
   	}

	//Browse(검색)버튼 클릭 시
	$(document).on('click','.custom-file-label',function(e){
		e.preventDefault();
		$('.custom-file-input').trigger('click');
		return false;
	});

	//class로 값을 찾아서 이미지를 넣어준다. & 이미지 등록
	$(document).on('change','.custom-file-input',function(e){
		e.preventDefault();
		var file = $(this).val();		
		if (!checkImgType(file)) {
			toastr.warning("이미지파일을 선택해 주세요.");
			$(this).val('');
       		return false;
		}
	});

	// 파일 검사 (이미지 파일만)
	var checkImgType = function(filePath) {
	    var fileFormat = filePath.split(".");
	    if ((fileFormat.indexOf("png") > -1) || (fileFormat.indexOf("jpg") > -1) || (fileFormat.indexOf("jpeg") > -1) || (fileFormat.indexOf("tif") > -1) || (fileFormat.indexOf("tiff") > -1) || (fileFormat.indexOf("raw") > -1) || (fileFormat.indexOf("bmp") > -1) || (fileFormat.indexOf("rle") > -1) || (fileFormat.indexOf("heic") > -1)) {
	        return true;
	    } else {
	        return false;
	    }
	}

	   // 등록 처리
    $('#btnSaveImg').on('click', function() {
        
    	var file = $('#imgFile').val();	
    	
    	if (file == null || file =='') {
			toastr.warning("파일을 선택해 주세요.");
			$(this).val('');
       		return false;
		}
    		

        if (!checkImgType(file)) {
			toastr.warning("이미지파일을 선택해 주세요.");
			$(this).val('');
       		return false;
		}

         	
        var	url = '<c:url value="/bm/accidentFreeImgUpload"/>';
        var files = $('#imgFile')[0].files[0];
		var formData = new FormData();
				
		formData.append('img', files);
		
        $.ajax({
			url : url,
			data : formData,
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				if (data.result == "ok") {
					toastr.success('등록되었습니다.');
					
				} else if (data.result == "extensionError") {
					toastr.warning(res.message);
				}else{
					toastr.error(res.message);
				}
				$('#accidentTableImg').DataTable().ajax.reload( function () {});//reload 대체
				$('#imgFile').val("");
				$('.custom-file-label').text('');
			}
		});
    });
	
 
</script>

</body>
</html>
