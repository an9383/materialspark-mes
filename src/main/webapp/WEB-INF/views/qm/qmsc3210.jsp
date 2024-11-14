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
				<li class="breadcrumb-item active">신뢰성 결과 등록(실링)</li>
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
						<div class="row" style="margin-bottom:5px;">
							<label class="input-label-sm">등록년도</label>
							<div class="form-group input-sub m-0 row">
								<select class="custom-select" style="width: 150px;" id="chooseDate1">
								</select>
							</div>
							<button type="button" class="btn btn-primary ml-2" id="btnSave">저장</button>
							<button type="button" class="btn btn-primary ml-2" id="btnExplanation">실링 업로드 방법</button>
							<a href="resources/file/SLD.xlsx">
								<button type="button" class="btn btn-secondary ml-2 float-right" id="excelFileDownload" style="border: solid 1px blue;">기본 양식 다운로드</button>
							</a>
							<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="">
								<label for="btnExcelUpload" class="btn btn-success float-right ml-2"> 엑셀업로드 </label>
								<input type="file" class="btn btn-success" id="btnExcelUpload" name="excelfile" style="display: none">
							</form>
							
						</div>
						<table id="uploadTable" class="table table-bordered">
							<thead class="thead-light">
			             	   <tr>
			                	   <th class="text-center align-middle" rowspan="2" colspan="1">구분</th>
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
	
	
<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="uploadModalLabel" aria-hidden="true">
	<div class="modal-dialog">
   		<div class="modal-content">
     		<div class="modal-header">
        		<h5 class="modal-title" id="uploadModalLabel">실링 업로드 방법</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		        	<span aria-hidden="true">&times;</span>
		        </button>
      		</div>
      		<br>
		    <div class="modal-body">
		      	<div style="display: flex;flex-direction: column;">
			      	<label style="font-size: 14px;">- 기본 양식 다운로드 버튼을 통해 받은 엑셀 파일의 형식으로 사용해야 합니다.</label>
			      	<label style="font-size: 14px;">- 해당 생산 년/월/일에 이미 값이 등록된 경우 저장할 때 해당 값은 삭제되고<br>&nbsp;&nbsp;업로드한 값이 저장됩니다.</label>
			      	<label style="font-size: 14px;">- 엑셀의 첫 번째 시트 - 일일(24시간) 실링</label>
			      	<label style="font-size: 14px;">- 엑셀의 두 번째 시트 - 2일(48시간) 실링</label>
			      	<label style="font-size: 14px;">- 엑셀의 세 번째 시트 - 15시간 실링</label>
			      	<label style="font-size: 14px;">※위 형식으로 시트에서 값을 가져오기에 해당 시트에 값이 존재해야 합니다.</label>
		      		<label class="mt-2" style="color: red;font-size: 14px;">* 기본 양식(행, 시트의 위치)과 다를 경우 업로드가 불가능합니다.</label>
		      		<label style="color: red;font-size: 14px;">* 상부, 하부값으로 올바르지 않은 값이 있을 경우 업로드가 불가능합니다.<br>&nbsp;&nbsp;&nbsp;상부, 하부값을 입력하지 않은 행은 업로드되지 않습니다.</label>
		      		<label style="color: red;font-size: 14px;">ex) .2.153 , .5342 </label>
		      	</div>
			</div>
      		<div class="modal-footer">
		      	<button type="button" class="btn btn btn-secondary" data-dismiss="modal" style="min-width:70px;">닫기</button>
			</div>
		</div>
	</div>
</div>	
	
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc3210';
	let currentHref = 'qmsc3210';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","신뢰성 결과 등록(실링)");
	var serverDate =  "${serverDate}";
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	var chooseDate = serverDate;
	var equipNm = "empty";
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
    //공통코드 처리 종료  
    
    //업로드 목록
    $.fn.dataTable.ext.errMode = 'none';
	let uploadTable = $('#uploadTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'>>" +
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
	    lengthChange : false,
	    pageLength: -1,
	    /* ajax: {
	        url: '<c:url value="/br/readRawMatrlInOutList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 : menuAuth,     	
	        },
	       
	    }, */
	    rowId: 'idx',
	    columns: [
	    	{ data: 'shillingGubun'}, //구분
	    	{ data: 'teamCd'}, //근무조
	    	{ data: 'productDate'}, //생산일
	    	{ data: 'productDateDN'}, //생산일 주야구분
	    	{ data: 'testDate'}, //시험일
	    	{ data: 'testDateDN'}, //시험일 주야구분
	    	{ data: 'workerNm'}, //작업자
	    	{ data: 'gijongNm'}, //기종
	    	{ data: 'qutyNm'}, //재질
	    	{ data: 'equipNm'}, //라인
	    	{ data: 'changeM'}, //M교체
	    	{ data: 'metalLotNo'}, //메탈로트
	    	{ data: 'bottomVal'}, //하부
	    	{ data: 'topVal'}, //상부
	    	{ data: 'shillingResult'}, //실링 결과값
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
	
	
/* 	var html1 ='<div class="row" style="margin-bottom:5px;">';
	html1 +='<label class="input-label-sm">기간</label>';
	html1 +='<div class="form-group input-sub m-0 row">';
	html1 +='<select class="custom-select" style="width: 150px;" id="chooseDate1" ></select>';				
	html1 +='</div>';
	html1 += '<button type="button" class="btn btn-primary ml-2" id="btnSave">저장</button>';
	html1 += '<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="">'
	html1 += '<label for="btnExcelUpload" class="btn btn-success float-right ml-2"> 엑셀업로드 </label><input type="file" class="btn btn-success" id="btnExcelUpload" name="excelfile" style="display: none" />';
	html1 += '</form>';
	html1 +='</div>';
	$('#uploadTable_length').html(html1); */

	$('#btnExcelUpload').change(function(){
		let formData = new FormData($('#fileUploadForm')[0]);
		let str = $('#btnExcelUpload').val();
		//엑셀 형태인 경우
		if (str.substring(str.lastIndexOf(".")+1)=="xls" || str.substring(str.lastIndexOf(".")+1) == "xlsx") {
			$.ajax({
		    	type: "POST",
		    	enctype: 'multipart/form-data',
		    	data: formData,
		    	url:'<c:url value="bm/reliabilityCheckExcelUpload"/>',
		    	processData: false,
		    	contentType: false,
		    	cache: false,
		    	beforeSend: function() {
	                $('#my-spinner').show();
	            },
		    	success: function (res) {
		    		if (res.result == 'ok') {
		    			url 		= res.data.url;
		    			let data 	= res.data;


		    			$.ajax({
		    		        url: '<c:url value="/bm/reliabilityCheckDataList_F3"/>',
		    		        type: 'GET',
		    		        data: {
		    		        	'menuAuth'	 	: 		menuAuth,
		    		        	'filename'		:		url,
		    		        },
		    		        success: function (res) {
			    		        
		    		        	let filterData = _.remove(res.data, v => v.productDate != '' && v.productDate != null 
				    		        								&& v.topVal != '' && v.topVal != null 
				    		        								&& v.bottomVal != '' && v.bottomVal != null);
		    		        	$('#btnExcelUpload').val('');
								if(res.result == 'ok'){
									uploadTable = $('#uploadTable').DataTable({
						    		    language: lang_kor,
						    		    searching: false,
						    		    destroy: true,
						    		    paging: false,
						    		    info: true,		    
						    		    ordering: true,
						    		    processing: true,
						    		    autoWidth: false,
						    		    pageLength: -1,
						    		    scrollX : false,
						    		    scrollY : "67vh",
						    		    data: filterData,
						    		    columns: [
						    		    	{ data: 'shillingGubun',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			if(data == '001'){
															return '48시간';
								    		    		} else if(data == '002'){
															return '24시간';
								    		    		} else if(data == '003'){
															return '15시간';
								    		    		}
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	
						    		    	{ data: 'teamCd',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'productDate',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return moment($('#chooseDate1').val() + data.slice(0,4)).format('YYYY-MM-DD');
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ 
						    		    		render: function(data, type, row, meta) {	
						    		    			if(row['productDate'] != null && row['productDate'] != '') {
							    		    			return row['productDate'].substr(-2,1);
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'testDate',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return moment($('#chooseDate1').val() + data.slice(0,4)).format('YYYY-MM-DD');
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	  
						    		    	{ 
						    		    		render: function(data, type, row, meta) {	
						    		    			if(row['testDate'] != null && row['testDate'] != '') {
							    		    			return row['testDate'].substr(-2,1);
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	
						    		    	{ data: 'workerNm',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'gijongNm',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'qutyNm',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'equipNm',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'changeM',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'metalLotNo',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'bottomVal',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	
						    		    	{ data: 'topVal',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 

						    		    	{ 
						    		    		render: function(data, type, row, meta) {	
						    		    			if(row['bottomResult'] == 'OK' && row['topResult'] == 'OK') {
						    		    				return '<div style="color:blue;">합격</div>';
						    		    			} else if(row['bottomResult'] == 'NG' || row['topResult'] == 'NG') {
						    		    				return '<div style="color:red;">불합격</div>';
						    		    			} else {
							    		    			return '판정불가';
						    		    			}
						    		    		}
						    		    	},	
						    		    	{ data: 'sideLeft',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'sideRight',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	{ data: 'afterBottom',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	  
						    		    	{ data: 'afterTop',
						    		    		render: function(data, type, row, meta) {	
						    		    			if(data != null && data != '') {
							    		    			return data;
						    		    			} else {
							    		    			return '-';
						    		    			}
						    		    		}
						    		    	},	 
						    		    	  
						    		    ],
						    		    order : [
										],
						    		    columnDefs: [
						    		    ],
						    		    initComplete: function( settings, json ) {
						    		    }
							        });
								}else if(res.result == 'fail'){
									toastr.warning(res.message, '', {timeOut: 5000});
									$('#btnExcelUpload').val('');
								}else{
									toastr.error(res.message, '', {timeOut: 5000});
									$('#btnExcelUpload').val('');
								}
								$('#my-spinner').hide();
							}
		    		    });
		    		    
		    		} else if (res.result == 'fail') {
		    			toastr.warning(res.message, '', {timeOut: 5000});
		    		} else if (res.result == 'error') {
		    			toastr.error(res.message, '', {timeOut: 5000});
		    		}
				},
			});
		} else if(str.substring(str.lastIndexOf(".")+1)=="ods" ){
			toastr.warning(".ods파일을 .xlsx 또는 .xls로 <br>저장하고 업로드해주세요.");
			return false;
		} else {
			toastr.warning("Excel파일을 선택해 주세요.");
			return false;
		}
	});

	//저장처리
	$('#btnSave').on('click',function(){
		let insertList = [];
		$('#my-spinner').show();
		if($('#uploadTable tbody tr').length - $('#uploadTable tbody tr').find('.dataTables_empty').length == 0){
			toastr.warning('엑셀파일을 업로드해주세요.');
			$('#my-spinner').hide();
			return false;
		} else {		
			$('#uploadTable tbody tr').each(function(index){
				let obj = {};
				let data = uploadTable.row(index).data();
				let node = uploadTable.row(index).node();

				obj.shillingGubun = data.shillingGubun;
				obj.shillingResult = data.bottomResult == 'OK' && data.topResult == 'OK' 
									? 'OK' : 'NG';
				obj.teamCd = data.teamCd;

				let productDate = null;
				let productDateDN = null;
				if(data.productDate != null && data.productDate != ''){
					productDate = $(node).find('td').eq(2).text().replaceAll('-','');
					productDateDN = $(node).find('td').eq(3).text();
				}
				obj.productDate = productDate
				obj.productDateDN = productDateDN;

				let testDate = null;
				let testDateeDN = null;
				if(data.testDate != null && data.testDate != ''){
					testDate = $(node).find('td').eq(4).text().replaceAll('-','');
					testDateDN = $(node).find('td').eq(5).text();
				}
				obj.testDate = testDate;
				obj.testDateDN = testDateDN;

				obj.workerNm = data.workerNm;
				obj.gijongNm = data.gijongNm;
				obj.qutyNm = data.qutyNm;
				obj.equipNm = data.equipNm;
				obj.changeM = data.changeM;
				obj.metalLotNo = data.metalLotNo;
				obj.bottomVal = data.bottomVal;
				obj.topVal = data.topVal;
				obj.sideLeft = data.sideLeft;
				obj.sideRight = data.sideRight;
				obj.afterBottom = data.afterBottom;
				obj.afterTop = data.afterTop;
				insertList.push(obj);
			});
		}
		let deleteList = [];
		deleteList = _.remove(_.uniqBy(_.map(insertList,'productDate')),null);
		
		$('#my-spinner').hide();
		console.log(insertList);
		console.log(deleteList);
		$.ajax({
			url: '<c:url value="/qm/reliabilityResultShillingCreate"/>',
            type: 'POST',
            //async: false,
            data: {    
            	'insertList'	:	function(){return JSON.stringify(insertList);},
            	'deleteList'	:	function(){return deleteList;},
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('저장되었습니다.');
					uploadTable.clear().draw();
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
	
	$(document).ready(function(){
		setDateBox();
	}); 

	$('#btnExplanation').on('click',function(){
		$('#uploadModal').modal('show');
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
   }
	
</script>
</body>
</html>