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
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">3Tray중량관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 66%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"  class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="threeTrayManageAdmTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>날짜</th>
									<th>사용여부</th>
									<th>코드</th>
									<!-- <th>기종코드</th> -->
									<th>코드명</th>
									<th>재질구분</th>
									<th>기준값</th>
									<th>기준(+)</th>
									<th>기준(-)</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
				<!-- <button type="button" class="btn btn-success float-right">Excel</button> -->
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 33%;">
				<div class="card" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right d-none" onclick="closerNav()">
								<i class="mdi mdi-close"></i>
							</a>
						</div>
						<button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
						<button type="button" class="btn btn-primary float-right mr-1"	id="btnAdd">등록</button>
						
						<button type="button" class="btn btn-primary float-LEFT" id="btnFetch">불러오기</button>
					</div>
					
					<!--/오른쪽 등록 부분 상단 버튼 영역-->
					<form id="form">
						<div class="table-responsive">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>코드</th>
										<td>
											<input type="text" class="form-control" id="baseCd" disabled>
										</td>
										
										<th>날짜</th>
										<td>
											<input type="date" class="form-control" id="trayWeightDate" disabled>
										</td>
									</tr>
									<tr>
										<th>기종</th>
										<td>
											<select class="custom-select" style="width:150px;" id="gijongCd" disabled></select>
										</td>
										<th>재질</th>
										<td>
											<select class="custom-select" style="width:150px;" id="qutyCd" disabled>
												<option value="">선택</option>
												<option value="A">AL</option>
												<option value="N">NC</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>기준</th>
										<td>
											<input type="text" class="form-control" id="referenceValue" disabled>
										</td>
										<th>기준(+)</th>
										<td>
											<input type="text" class="form-control" id="referencePlus" disabled>
										</td>
									</tr>
									<tr>
										<th>기준(-)</th>
										<td>
											<input type="text" class="form-control" id="referenceMinus" disabled>
										</td>
										<th>사용여부</th>
										<td>
											<select class="custom-select" style="width:150px;" id="useYnCd" disabled></select>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>
				</div>
				<div class="mt-2">
					<!-- 저장 -->
					<button type="button" class="btn btn-primary float-right mr-1 d-none" id="btnSave">저장</button>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 삭제 확인 모달 시작-->
<div class="modal fade" id="threeTrayFetchPopupModal" tabindex="-1" role="dialog" aria-labelledby="threeTrayFetchPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">일자별 데이터 불러오기</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body mt-2">
				<hr class="text-secondary">
				<div style="display: flex;align-items: center;">
					<label class="mr-2">불러올 날짜: </label>
					<select class="custom-select" style="height: 27px;font-size: 13px;" id="savedDate"></select>
				</div>
				
				<div class="mt-2" style="display: flex;align-items: center;">
					<label class="mr-2">입력할 날짜: </label>
					<input type="date" class="form-control touch5" id="insertDate">
				</div>
				
				<br>
				<label>*불러올 날짜 : 해당 날짜에 저장되어있는 데이터를 불러옵니다.</label>
				<label>*입력할 날짜 : 선택한 날짜에 부른 날짜에 데이터를 저장합니다.</label>
				<label>*입력할 날짜에 데이터가 이미 있는경우 생성할 수 없습니다.</label>
				<label style="color: blue;">*해당 기능은 이미 저장되어있는 데이터를 일괄로 저장할 때 사용합니다.</label>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnFetchSave" data-dismiss="modal" style="min-width:70px;">저장</button>
			</div>
		</div>
	</div>
</div>
<!-- 삭제 확인 모달 종료 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "66%"
			}, 200);
			$("#myrSidenav").animate({
				width : "33%"
			}, 200);
		}
	
		state = !state;
	});

	let menuAuth = 'bmsc0160';
	let currentHref = 'bmsc0160';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","3Tray중량관리");
	
	//변수 들
	let serverDate	= "${serverDate}";
	let trayWeightDate	= moment("${maxDate}").format("YYYY-MM-DD");
	console.log(trayWeightDate);
	let sideView		= "";
	

	//공통코드 처리 시작
	let gijongCode = new Array();		//location
    <c:forEach items="${gijongCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		gijongCode.push(json);
    </c:forEach>
    
    let useYnCode = new Array();		//location
    <c:forEach items="${useYnCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		useYnCode.push(json);
    </c:forEach>
    
    let dateListCode = new Array();		//location
    <c:forEach items="${dateList}" var="info">
		var json=new Object();
		json.baseCd = moment("${info.trayWeightDate}").format("YYYY-MM-DD");
		json.baseCdNm = moment("${info.trayWeightDate}").format("YYYY-MM-DD");
		dateListCode.push(json);
    </c:forEach>
	//공통코드 처리 종료
	
	selectBoxAppend(gijongCode, "gijongCd", "", "2");		//기종
	selectBoxAppend(useYnCode, "useYnCd", "", "2");			//재질
	
	 
	//목록
	$.fn.dataTable.ext.errMode = 'none';
	let threeTrayManageAdmTable = $('#threeTrayManageAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		 dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange: true,
        pageLength: -1,
        scrollX: true,
        scrollY : "66vh",
		ajax : {
			url : '<c:url value="/bm/threeTrayManageList"/>',
			type : 'GET',
			data : {
				'menuAuth'	 		: 	function(){ return menuAuth; },
				'trayWeightDate'	:	function(){ return trayWeightDate.replace(/-/g, ''); },
			},
		},
		rowId : 'idx',
		columns : [
				{ data : 'trayWeightDate',
					render: function(data){
					return moment(data).format('YYYY-MM-DD');
				}
				},
				{ data : 'useYnNm'			},
				{ data : 'baseCd'			},
				//{ data : 'gijongCd'			},
				{ data : 'gijongNm'			},
				{ data : 'qutyNm'			},
				{ data : 'referenceValue'	},
				{ data : 'referencePlus'	},
				{ data : 'referenceMinus'	},
			],
		columnDefs : [ {
			"defaultContent": "-", "targets": "_all",	"className": "text-center"
		}],
		order : [ [ 2, 'asc' ] ],
		buttons: [ 'copy', 'excel', 'print' ],
	});
	
	let html1 = '<div class="row">';
		html1 += '<label class="input-label-sm">날짜</label>';
		//html1 += '<input type="date" class="form-control" style="width: 20%;" id="chooseDate">';
		html1 += '<select class="custom-select" style="height: 27px;font-size: 13px;" id="chooseDate"></select>';
		html1 += '<button type="button" class="btn btn-primary float-right ml-2" id="btnRetv">조회</button>'
		html1 += '</div>';
	
	$('#threeTrayManageAdmTable_length').empty();
	$('#threeTrayManageAdmTable_length').append(html1);
	
	selectBoxAppend(dateListCode, "chooseDate", "", "");
	$('#chooseDate').val(trayWeightDate);
	
	//메인 테이블 클릭 시
	$('#threeTrayManageAdmTable tbody').on('click', 'tr', function() {
		if ( $(this).hasClass('selected') ) {
			
		} else {
			$('#threeTrayManageAdmTable').DataTable().$('tr.selected').removeClass('selected');$(this).addClass('selected');
		}
		
		$("form *").find("input, select").prop("disabled", true);
		form.reset();
		$('#btnSave').addClass('d-none');
		
		let baseCd = threeTrayManageAdmTable.row(this).data().baseCd;
		
		//상세조회
		$.ajax({
        	url: '<c:url value="bm/threeTrayManageRead"/>',
            type: 'GET',
            data: {
            	'menuAuth'			: menuAuth,
	            'trayWeightDate'	: function() { return trayWeightDate.replace(/-/g, ''); },
	            'baseCd'			: function() { return baseCd; },
            },
            success: function (res) {
                let data = res.data;
                if(res.result == 'ok') {
					$('#baseCd').val(data.baseCd);
					$('#trayWeightDate').val(moment(data.trayWeightDate).format("YYYY-MM-DD"));
					$('#gijongCd').val(data.gijongCd);
					$('#qutyCd').val(data.qutyCd);
					$('#referenceValue').val(data.referenceValue);
					$('#referencePlus').val(data.referencePlus);
					$('#referenceMinus').val(data.referenceMinus);
					$('#useYnCd').val(data.useYnCd);
					
					
                } else if (res.result == 'fail') {
                	toastr.error(res.message, '', {timeOut: 5000});
				}
            }
        });
		//상세조회
	});
	
	//조회버튼 클릭 시
	$('#btnRetv').on('click', function() {
		trayWeightDate = $('#chooseDate').val();
		$("form *").find("input, select").prop("disabled", true);
		form.reset();
		$('#btnSave').addClass('d-none');
		$('#threeTrayManageAdmTable').DataTable().ajax.reload();
	});
	
	//불러오기 버튼 클릭했을 때
	$('#btnFetch').on('click', function() {
		
		//저장된 날짜 데이터 조회
   		$.ajax({
        	url: '<c:url value="bm/threeTrayManageList"/>',
            type: 'GET',
            data: {
            	'menuAuth'			: menuAuth,
            },
            success: function (res) {
                let data = res.data;
                if(res.result == 'ok') {
                	
                	let sudel			= new Set(data.map(data => moment(data.trayWeightDate).format("YYYY-MM-DD")));
                	let selectBox		= document.getElementById('savedDate');
                	let options			= Array.from(sudel).map(sudel => '<option value=' + sudel.replace(/-/g, '') + '>' + sudel + '</option>');
                	selectBox.innerHTML	= options.join('');

                	let dates		= Array.from(sudel).sort();
                	let lastDate	= dates[dates.length - 1];
                	
                	if (lastDate && moment(lastDate).format("YYYY-MM-DD") === lastDate) {
                	  selectBox.value = lastDate.replace(/-/g, '');
                	}
                	
                	//입력할 날짜 선택 못하는 날짜 지정해주는 부분
                	var inputDate = document.getElementById("insertDate");

                	inputDate.addEventListener("input", (event) => {
						var selectedDate = new Date(event.target.value).toISOString().slice(0, 10);
						if (Array.from(sudel).includes(selectedDate)) {
							toastr.warning("이미 저장되어있는 날짜입니다.<br>다른 일자를 선택해주세요.");
							event.target.value = "";
							//inputDate.style.cursor = 'not-allowed;';
						}
					});
                	
                } else if (res.result == 'fail') {
                	toastr.error(res.message, '', {timeOut: 5000});
				}
            }
        });
		//저장된 날짜 데이터 조회
		
		$('#threeTrayFetchPopupModal').modal('show');
	});
	
	//일괄 처리 저장 버튼 클릭 시
	$('#btnFetchSave').on('click', function() {
		
		if( $('#savedDate').val() == "" ) {
        	toastr.warning("불러올 날짜를 선택해주세요.");
        	$('#savedDate').focus();
        	return false;
        }
		if( $('#insertDate').val() == "" ) {
        	toastr.warning("입력할 날짜를 선택해주세요.");
        	$('#insertDate').focus();
        	return false;
        }
		
		//일괄저장 처리
   		$.ajax({
        	url:  '<c:url value="bm/threeTrayManageBatchCreate"/>',
            type: 'POST',
            data: {
            	'menuAuth'			: menuAuth,
            	'oldTrayWeightDate'	: function(){ return $('#savedDate').val().replace(/-/g, '');	},
            	'trayWeightDate'	: function(){ return $('#insertDate').val().replace(/-/g, '');	},
            },
            success: function (res) {
                let data = res.data;
                if(res.result == 'ok') {
					toastr.success("일괄 저장 처리 되었습니다.");
					sudel("chooseDate");
                } else if (res.result == 'fail') {
                	toastr.error(res.message, '', {timeOut: 5000});
				}
            }
        });
		//일괄저장 처리
	});
	
	
	//등록버튼 클릭 했을 때
	$('#btnAdd').on('click', function() {
		
		$("form *").find("input, select").prop("disabled", false);	//form disabled flase
		form.reset();												//form데이터 전체 초기화
		$('#baseCd').attr('disabled', true);
		$('#useYnCd').val("001");
		$('#trayWeightDate').val(serverDate);
		
		$('#baseCd').val("");
		
		//코드(SEQ) 조회
   		/* $.ajax({
        	url: '<c:url value="bm/threeTrayManageBaseCdSeq"/>',
            type: 'GET',
            data: {
            	'menuAuth'			: menuAuth,
            	'trayWeightDate'	: function() { return trayWeightDate.replace(/-/g, ''); },
            },
            success: function (res) {
                let data = res.data;
                if(res.result == 'ok') {
					$('#baseCd').val(data.baseCd);
                } else if (res.result == 'fail') {
                	toastr.error(res.message, '', {timeOut: 5000});
				}
            }
        }); */
   		//코드(SEQ) 조회
   		
   		sideView = "add";
   		
   		$('#btnSave').removeClass('d-none');
	});
	
	//수정버튼 클릭 했을 때
	$('#btnEdit').on('click', function() {
		
		$("form *").find("input, select").prop("disabled", false);	//form disabled flase
		$('#baseCd').attr('disabled', true);
		$('#trayWeightDate').attr('disabled', true);
		
		sideView = "edit";
		
		$('#btnSave').removeClass('d-none');
	});
	
	//저장 버튼 클릭 했을 때
	$('#btnSave').on('click', function() {
		
		/* if( $('#baseCd').val() == "" ) {
        	toastr.warning("등록 버튼을 다시 클릭해주세요");
        	$('#baseCd').focus();
        	return false;
        } */
		if( $('#trayWeightDate').val() == "" ) {
        	toastr.warning("날짜를 선택해주세요");
        	$('#trayWeightDate').focus();
        	return false;
        }
		if( $('#gijongCd option:selected').val() == "" ) {
        	toastr.warning("기종을 선택해주세요.");
        	$('#gijongCd').focus();
        	return false;
        }
		if( $('#qutyCd option:selected').val() == "" ) {
			toastr.warning("재질을 선택해주세요.");
        	$('#qutyCd').focus();
        	return false;
        }
		if( $('#referenceValue').val() == "" ) {
        	toastr.warning("기준 값을 입력해주십시오.");
        	$('#referenceValue').focus();
        	return false;
        }
		if( $('#referencePlus').val() == "" ) {
        	toastr.warning("기준(+)값을 입력해주십시오.");
        	$('#referencePlus').focus();
        	return false;
        }
		if( $('#referenceMinus').val() == "" ) {
        	toastr.warning("기준(-)값을 입력해주십시오.");
        	$('#referenceMinus').focus();
        	return false;
        }
		if( $('#useYnCd').val() == "" ) {
        	toastr.warning("사용여부를 선택해주세요.");
        	$('#useYnCd').focus();
        	return false;
        }
		
		let url = "";
		if( sideView == "add" ) {
			url = '<c:url value="bm/threeTrayManageCreate"/>';
		} else if( sideView == "edit" ) {
			url = '<c:url value="bm/threeTrayManageUpdate"/>';	
		}
		
		//저장 처리
   		$.ajax({
        	url: url,
            type: 'POST',
            data: {
            	'menuAuth'			: menuAuth,
            	'baseCd'			: function(){ return $('#baseCd').val()			},
            	'oldTrayWeightDate'	: function(){ return $('#chooseDate').val() == null ? $('#chooseDate').val() : $('#chooseDate').val().replace(/-/g, ''); },
            	'trayWeightDate'	: function(){ return $('#trayWeightDate').val().replace(/-/g, ''); },
            	'gijongCd'			: function(){ return $('#gijongCd ').val()		},
            	'qutyCd'			: function(){ return $('#qutyCd').val()			},
            	'referenceValue'	: function(){ return $('#referenceValue').val()	},
            	'referencePlus'		: function(){ return $('#referencePlus').val()	},
            	'referenceMinus'	: function(){ return $('#referenceMinus').val()	},
            	'useYnCd'			: function(){ return $('#useYnCd').val()		},
            },
            success: function (res) {
                let data = res.data;
                if(res.result == 'ok') {
					$('#baseCd').val(data.baseCd);
					
					if( sideView == "add" ) {
						toastr.success("저장 되었습니다.");
					} else if( sideView == "edit" ) {
						toastr.success("수정 되었습니다.");	
					}
					
					sudel("chooseDate");
					
					$("form *").find("input, select").prop("disabled", true);
					form.reset();
					$('#btnSave').addClass('d-none');
					$('#threeTrayManageAdmTable').DataTable().ajax.reload();
                } else if (res.result == 'fail') {
                	toastr.error(res.message, '', {timeOut: 5000});
				}
            }
        });
		//저장 처리
	});
	
	
	
	//sudel("chooseDate");
	//저장되어있는 날짜 불러오기
	function sudel(idName) {
		
		//저장된 날짜 데이터 조회
   		$.ajax({
        	url: '<c:url value="bm/threeTrayWeightDate"/>',
            type: 'GET',
            data: {
            	'menuAuth'			: menuAuth,
            },
            success: function (res) {
                let data = res.data;
                
                if(res.result == 'ok') {

                	let lastDate = "";
                	dateListCode = new Array();
                	data.forEach(function(info) {
                	    var json = new Object();
                	    json.baseCd = moment(info.trayWeightDate).format("YYYY-MM-DD");
                	    json.baseCdNm = moment(info.trayWeightDate).format("YYYY-MM-DD");
                	    dateListCode.push(json);
                	    
                	    lastDate = moment(info.maxTrayWeightDate).format("YYYY-MM-DD");
                	});
					
					selectBoxAppend(dateListCode, "chooseDate", lastDate, "");
					trayWeightDate = lastDate;
					
					$('#btnRetv').click();
                	
                	/* let sudel			= new Set(data.map(data => moment(data.trayWeightDate).format("YYYY-MM-DD")));
                	let selectBox		= document.getElementById(idName);
                	let options			= Array.from(sudel).map(sudel => '<option value=' + sudel.replace(/-/g, '') + '>' + sudel + '</option>');
                	selectBox.innerHTML	= options.join('');

                	let dates		= Array.from(sudel).sort();
                	let lastDate	= dates[dates.length - 1];
                	
                	if( data.length != 0 ){
                		trayWeightDate = lastDate;                		
                	}
                	
                	if (lastDate && moment(lastDate).format("YYYY-MM-DD") === lastDate) {
                	  selectBox.value = lastDate.replace(/-/g, '');
                	} */
                	
                } else if (res.result == 'fail') {
                	toastr.error(res.message, '', {timeOut: 5000});
				}
            }
        });
		//저장된 날짜 데이터 조회
	}
	
	
</script>

</body>
</html>
