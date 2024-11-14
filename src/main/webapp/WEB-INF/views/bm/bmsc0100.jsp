<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%	pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">
	<!-- Modal Start-->
	<div class="modal fade" id="layerPopUpModal" tabindex="-1"
		role="dialog" aria-labelledby="layerPopUpLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="layerPopUpLabel">기초코드등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<hr class="text-secondary">
					<table class="table table-sm table-bordered" id="layerPopUpTable">
					</table>
					<hr class="text-secondary">
				</div>
				<div class="modal-footer">
					<input type="hidden" class="form-control" id="puFlag" name="puFlag">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="layerPopUpSave">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End-->

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">공정순서관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-30" id="left-30" style="width: 28%;">
				<div class="card">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table class="table table-bordered" id="processGroupCd">
							<thead class="thead-light">
								<tr>
									<th style="width: 20px" id="useYnCd">사용여부</th>
									<th style="width: 20px" id="baseGroupCd">기초코드</th>
									<th style="width: 100px" id="baseGroupCdNm">기초코드명</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<div class="right-list right-70" id="myrSidenav" style="width: 71%;">
				<div class="card" id="formBox">
					<form id="form">
						<div class="table-responsive">
							<table class="table table-bordered" id="processCd">
								<thead class="thead-light">
									<tr>
										<th style="width: 70px">사용여부</th>
										<th style="width: 50px">코드</th>
										<th style="width: 80px">코드명</th>
										<th style="width: 40px">약칭</th>
										<th style="width: 50px">체크1</th>
										<th style="width: 50px">체크2</th>
										<th style="width: 50px">체크3</th>
										<th style="width: 50px">체크4</th>
										<th style="width: 50px">체크5</th>
										<th style="width: 50px">체크6</th>
										<th style="width: 50px">체크7</th>
										<th style="width: 50px">체크8</th>
										<th style="width: 50px">체크9</th>
										<th style="width: 50px">체크10</th>
									</tr>
								</thead>
							</table>
						</div>
					</form>
				</div>
			</div>
			<!-- .right-sidebar -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'bmsc0100';
	let currentHref = 'bmsc0100';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');  
	$(document).attr("title","공정순서관리");

	//공통코드 처리 시작   	
	var useYnCode=new Array(); // 상태여부
    <c:forEach items="${useYnCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		useYnCode.push(json);
    </c:forEach>
    //공통코드 처리 종료 
        	
   	//시스템공통그룹 전체조회
   	$.fn.dataTable.ext.errMode = 'none';
	let processGroupCd = $('#processGroupCd').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        searching:true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 20,
		ajax: {
			url: '<c:url value="bm/processGroupDataList"/>',
			type: 'GET',
			data: {
				'menuAuth'	 :	menuAuth,
			},
		},
		columns: [
			{ data : 'useYnNm' },
			{ data: 'baseGroupCd' },
			{ data: 'baseGroupCdNm' },
		],
		order: [
			[ 1, 'asc' ],
		],
        buttons: [
            {
                extend: 'copy',
                title: '공정순서 기초코드',
            },
            {
                extend: 'excel',
                title: '공정순서 기초코드',
            },
            {
                extend: 'print',
                title: '공정순서 기초코드',
            }
        ],
         drawCallback : function( settings ) { //데이터 테이블 모두 호출후 실행 유사 complete       
        	//$('#processGroupCd_filter').html('<label>검색 : <input type="search" class="form-control form-control-sm" placeholder="" aria-controls="processGroupCd" style="width:120px"> </label>');	
        	 $('input[type=search]').attr("style", "width:120px;");
       	} 
	});
	
	
	var htmlGroup = '<button class="btn btn-primary float-left mr-2" type="button" id="baseGroupAdd">기초코드등록</button>&nbsp;<button class="btn btn-primary float-left mr-2" type="button" id="baseGroupEdit">수정</button>';
	$('#processGroupCd_length').html(htmlGroup);
	
	//$('#processGroupCd_filter').html('<label>검색 : <input type="search" class="form-control form-control-sm" placeholder="" aria-controls="processGroupCd" style="width:120px"> </label>');
	  		
	//시스템공통코드 상세조회
	var baseGroupCd = "0";
	$.fn.dataTable.ext.errMode = 'none';
	let processCd = $('#processCd').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        //scrollX : true,
        pageLength: 20,	
		'ajax': {
				url: '<c:url value="bm/processCodeDataList"/>',
				type: 'GET',
				data: {
					'menuAuth'	 : menuAuth,
					'baseGroupCd': function() { return baseGroupCd; }
				},
			},
			//rowId: 'baseGroupCd', // id값 할당
			columns: [
				{ data: 'useYnNm' },
	  			{ data: 'baseCd' },
	  			{ data: 'baseCdNm' },
	  			{ data: 'baseCdAbbr' },
	  			{ data: 'etc1' },
	  			{ data: 'etc2' },
	  			{ data: 'etc3' },
	  			{ data: 'etc4' },
	  			{ data: 'etc5' },
	  			{ data: 'etc6' },
	  			{ data: 'etc7' },
	  			{ data: 'etc8' },
	  			{ data: 'etc9' },
	  			{ data: 'etc10' }
	  		],
	  		order: [
	  			[ 1, 'asc' ],
	  		],
	  		buttons: [
	            {
	                extend: 'copy',
	                title: '공정순서 기초코드 - 상세',
	            },
	            {
	                extend: 'excel',
	                title: '공정순서 기초코드 - 상세',
	            },
	            {
	                extend: 'print',
	                title: '공정순서 기초코드 - 상세',
	            },
	        ],  		
	});
	
	var htmlCd = '<button class="btn btn-primary float-left mr-2" type="button" id="baseCdAdd">등록</button>&nbsp;<button class="btn btn-primary float- mr-2" type="button" id="baseCdEdit">수정</button>';
	$('#processCd_length').html(htmlCd);
		
   	$('#baseGroupAdd').click(function () {
   		addHtml("groupCdAdd", "");
   		selectBoxAppend(useYnCode, "puUseYnCd", "001", "2");
   		$('#layerPopUpLabel').text('기초코드등록');
   		$('#layerPopUpModal').modal('show');

   		//기초그룹코드 조회
   		$.ajax({
        	url: '<c:url value="bm/readProcessGroupSeq"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
			},
            success: function (res) {
                let data = res.data;
                let message = res.message;
                if(res.result == 'ok'){
					$('#puBaseGroupCd').val(data.baseGroupCd);
                }
                else if (res.result == 'fail') {
                	toastr.error(message, '', {timeOut: 5000});
				}
            }
        });
   	});

   	$('#baseGroupEdit').click(function () {
   		var data = processGroupCd.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("수정할 기초코드들 선택해 주세요.");
   		} else {
	   		addHtml("groupCdEdit", data);
	   		$('#puBaseGroupCd').val(data.baseGroupCd);
	   		$('#puBaseGroupCdNm').val(data.baseGroupCdNm);
	   		$("#puBaseGroupCd").attr("disabled",true);
	   		selectBoxAppend(useYnCode, "puUseYnCd", data.useYnCd, ""); 
	   		$('#layerPopUpLabel').text('기초코드수정');
	   		$('#layerPopUpModal').modal('show');
   	   	}
   	});  

   	$('#baseCdAdd').click(function () {
   		var data = processGroupCd.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("등록할 기초코드 목록을 먼저 선택해 주세요.");
   		} else {
   	   		let baseGroupCd = data.baseGroupCd;
	   		addHtml("cdAdd");
	   		$('#puBaseGroupCd').val(data.baseGroupCd);
	   		selectBoxAppend(useYnCode, "puUseYnCd", "001", "2");
	   		$('#layerPopUpLabel').text('코드등록');
	   		$('#layerPopUpModal').modal('show');
	   		//기초코드상세 코드 조회
	   		$.ajax({
	        	url: '<c:url value="bm/readProcessCommonSeq"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 : menuAuth,
		            'baseGroupCd' : baseGroupCd,
	            },
	            success: function (res) {
	                let data = res.data;
	                let message = res.message;
	                if(res.result == 'ok'){
						$('#puBaseCd').val(data.baseCd);
	                }
	                else if (res.result == 'fail') {
	                	toastr.error(message, '', {timeOut: 5000});
					}
	            }
	        });
   		}
   	});

   	$('#baseCdEdit').click(function () {
   		var dataGrp = processGroupCd.row('.selected').data();
   		if(dataGrp == null || dataGrp == undefined ) {
   			toastr.warning("수정할 기초코드들 먼저 선택해 주세요.");
   			return;
   		}
   		var data = processCd.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("수정할 코드들 선택해 주세요.");
   		} else {
	   		addHtml("cdEdit");
	   		$('#puBaseGroupCd').val(dataGrp.baseGroupCd);	   		
	   		$('#puBaseCd').val(data.baseCd);	
	   		$('#puBaseCdNm').val(data.baseCdNm); 	
	   		$('#puBaseCdAbbr').val(data.baseCdAbbr);
	   		$('#puEtc1').val(data.etc1); 		
	   		$('#puEtc2').val(data.etc2); 		
	   		$('#puEtc3').val(data.etc3); 		
	   		$('#puEtc4').val(data.etc4); 		
	   		$('#puEtc5').val(data.etc5); 		
	   		$('#puEtc6').val(data.etc6); 		
	   		$('#puEtc7').val(data.etc7); 		
	   		$('#puEtc8').val(data.etc8); 		
	   		$('#puEtc9').val(data.etc9); 		
	   		$('#puEtc10').val(data.etc10);
	        $("#puBaseCd").attr("disabled",true); 
	   		selectBoxAppend(useYnCode, "puUseYnCd", data.useYnCd, "");	   		
	   		$('#layerPopUpLabel').text('코드수정');
	   		$('#layerPopUpModal').modal('show');
   		}
   	});
   	  	
   	$('#layerPopUpSave').click(function () {
   	   	var puFlag = $('#puFlag').val();

   	   	if(puFlag == "groupCdAdd" || puFlag == "groupCdEdit") {
			baseGroupCdProc(puFlag);
   	   	} else {
   	   		baseCdProc(puFlag);
   	   	}
   		//$('#layerPopUpModal').modal('hide');
   	}); 
	
	// 시스템공통그룹 상세 정보 보기
	$('#processGroupCd tbody').on('click', 'tr', function () {

        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#processGroupCd').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            
	        baseGroupCd = processGroupCd.row( this ).data().baseGroupCd;
		    console.log("baseGroupCd = " + baseGroupCd);
	   		$('#processCd').DataTable().ajax.reload( function () {});
        }
   	});
       
	// 시스템코드선택
	$('#processCd tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#processCd').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
   	});
   		
	//시스템공통그룹 등록
	function baseGroupCdProc(puFlag)
	{
	    if ( !$.trim($('#puBaseGroupCd').val()) ) {
	        toastr.warning('기초코드를 입력해 주세요.');
	        $('#puBaseGroupCd').focus();
	        return false;
	    }
	    if ( !$.trim($('#puBaseGroupCdNm').val()) ) {
	        toastr.warning('기초코드명을 입력해 주세요.');
	        $('#puBaseGroupCdNm').focus();
	        return false;
	    }
	   	if( $('#puUseYnCd option:selected').val() == "" ) {   
	        toastr.warning('사용여부 선택해 주세요.');
	        $('#puUseYnCd').focus();
	        return false;
	    }
	    
	    var groupUrl;
	    var groupMsg;
	    if(puFlag == "groupCdAdd") {
	    	groupUrl = '<c:url value="bm/processGroupCreate"/>';
	    	groupMsg = '기초코드가 등록 되었습니다.';
	    } else {
	    	groupUrl = '<c:url value="bm/processGroupUpdate"/>';
	    	groupMsg = '기초코드가 수정 되었습니다.';
	    }
	    
	    $.ajax({
	        url: groupUrl,
	        type: 'POST',
	        data: {
	        	'menuAuth'	 : menuAuth,
	            'baseGroupCd': $('#puBaseGroupCd').val(),
	            'baseGroupCdNm': $('#puBaseGroupCdNm').val(),
	            'useYnCd': $("#puUseYnCd option:selected").val(),
	            'regId': 'reg_id',
	            'updId': 'upd_id'
	        },
	        beforeSend: function() {
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
	            	toastr.success(groupMsg);
		            $('#processGroupCd').DataTable().ajax.reload(); //등록 후 테이블 리로드	            	
	            	$('#layerPopUpModal').modal('hide');
	            } else if(res.result == 'exist') {
	            	toastr.warning("이미 등록되어 있는 코드번호 입니다.");
	            	$('#layerPopUpModal').modal('hide');
	            	$('#processCd').DataTable().ajax.reload(); //등록 후 테이블 리로드		            	
	            } else {
	            	toastr.error(res.message, '', {timeOut: 5000});
	            }
	        },
	        complete:function(){

	        }
	    });
	}

	//시스템공통코드 등록,수정
	function baseCdProc(puFlag)
	{
	    if ( !$.trim($('#puBaseGroupCd').val()) ) {
	        toastr.warning('기초코드를 확인해 주세요.');
	        //$('#puBaseGroupCd').focus();
	        return false;
	    }
	    if ( !$.trim($('#puBaseCd').val()) ) {
	        toastr.warning('코드를 입력해 주세요.');
	        $('#puBaseCd').focus();
	        return false;
	    }
	    if ( !$.trim($('#puBaseCdNm').val()) ) {
	        toastr.warning('코드명을 입력해 주세요.');
	        $('#puBaseCdNm').focus();
	        return false;
	    }
	    //if ( !$.trim($('#puBaseCdAbbr').val()) ) {
	    //    toastr.warning('코드약칭을 입력해 주세요.');
	    //    $('#puBaseCdAbbr').focus();
	    //    return false;	        
	    //}
	   	if( $("#puUseYnCd option:selected").val() == "" ) {   
	        toastr.warning('사용여부 선택해 주세요.');
	        $('#puUseYnCd').focus();
	        return false;
	    }
	    
	    var cdUrl;
	    var cdMsg;
	    if(puFlag == "cdAdd") {
	    	cdUrl = '<c:url value="bm/processCodeCreate"/>';
	    	cdMsg = '세부코드가 등록 되었습니다.';
	    } else {
	    	cdUrl = '<c:url value="bm/processCodeUpdate"/>';
	    	cdMsg = '세부코드가 수정 되었습니다.';
	    }
	    $.ajax({
	        url: cdUrl,
	        type: 'POST',
	        data: {
	        	'menuAuth'	 : menuAuth,
				'baseGroupCd' 	: $('#puBaseGroupCd').val(),
				'baseCd' 		: $('#puBaseCd').val(),
				'baseCdNm' 		: $('#puBaseCdNm').val(),
				'baseCdAbbr' 	: $('#puBaseCdAbbr').val(),
				'etc1' 			: $('#puEtc1').val(),
				'etc2' 			: $('#puEtc2').val(),
				'etc3' 			: $('#puEtc3').val(),
				'etc4' 			: $('#puEtc4').val(),
				'etc5' 			: $('#puEtc5').val(),
				'etc6' 			: $('#puEtc6').val(),
				'etc7' 			: $('#puEtc7').val(),
				'etc8' 			: $('#puEtc8').val(),
				'etc9' 			: $('#puEtc9').val(),
				'etc10' 		: $('#puEtc10').val(),
				'useYnCd' 		: $("#puUseYnCd option:selected").val(),
	        },
	        beforeSend: function() {
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
	            	toastr.success(cdMsg);
	            	$('#layerPopUpModal').modal('hide');
	            	$('#processCd').DataTable().ajax.reload(); //등록 후 테이블 리로드
	            } else if(res.result == 'exist') {
	            	toastr.warning("이미 등록되어 있는 코드번호 입니다.");
	            	$('#layerPopUpModal').modal('hide');
	            	$('#processCd').DataTable().ajax.reload(); //등록 후 테이블 리로드		            	
	            } else {
	            	toastr.error(res.message, '', {timeOut: 5000});
	            }
	        },
	        complete:function(){
	            
	        }
	    });
	}	 

   	function addHtml(flag)
   	{
   	   	var html;
   	   	if(flag == "groupCdAdd" || flag == "groupCdEdit") { //기초코드수정
			html = '<tr>';
			html += '<td class="align-middle" style="width: 80px">기초코드</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseGroupCd" name="puBaseGroupCd" disabled></td>';	
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle"  style="width: 80px">*기초코드명</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseGroupCdNm"  name="puBaseGroupCdNm" maxlength="25"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle"  style="width: 80px">*사용여부</td>';
			html += '<td style="width: 100px"><select class="custom-select" id="puUseYnCd"></select></td>';
			html += '</tr>';			
			$('#layerPopUpTable').html(html);
			$('#puFlag').val(flag);
   	   	} else { // 코드수정
			html = '<tr>';
			html += '<td class="align-middle" style="width: 80px">*코드</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCd"  name="puBaseCd" maxlength="3"></td>';	
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">*코드명</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCdNm"  name="puBaseCdNm" maxlength="25"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">코드약칭</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCdAbbr"  name="puBaseCdAbbr" maxlength="64"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크1</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc1"  name="puEtc1"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크2</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc2"  name="puEtc2"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크3</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc3"  name="puEtc3"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크4</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc4"  name="puEtc4"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크5</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc5"  name="puEtc5"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크6</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc6"  name="puEtc6"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크7</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc7"  name="puEtc7"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크8</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc8"  name="puEtc8"></td>';
			html += '</tr>';						
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크9</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc9"  name="puEtc9"></td>';
			html += '</tr>';																	
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크10</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc10"  name="puEtc10"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">*사용여부</td>';
			html += '<td style="width: 100px"><select class="custom-select" id="puUseYnCd"></select></td>';
			html += '<input type="hidden" id="puBaseGroupCd"  name="puBaseGroupCd">';
			html += '</tr>';
			$('#layerPopUpTable').html(html);
			$('#puFlag').val(flag);
   	   	}			
   	}

   	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});
   	
</script>

</body>
</html>
