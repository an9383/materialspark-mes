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
				<li class="breadcrumb-item active">생산지시현황(사출)</li>
			</ol>
		</nav>
	</header>

	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar-fix" id="left-list" style="width: 100%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<div class="table-responsive" >
						<table id="workOrdListTable" class="table table-bordered tr_highlight_row" style="width:100%">
							<thead class="thead-light">
								<tr>
									<th class="text-center"><input type="checkbox" id="checkBoxAll" name="checkBoxAll" style="min-width: 1.1rem;min-height: 1.1rem;"></th>
									<th class="text-center">작업상태</th>
									<th class="text-center">작업지시번호</th>
									<th class="text-center">작업지시일</th>
									<th class="text-center">부작업자</th>
									<th class="text-center">설비명</th>
									<th class="text-center">긴급여부</th>
									<th class="text-center">업체명</th>
									<th class="text-center">차종</th>
									<th class="text-center">품번</th>
									<th class="text-center">품명</th>
									<th class="text-center">원자재명</th>
									<th class="text-center">Cavity</th>
									<th class="text-center">지시수량</th>
									<th class="text-center">생산수량</th>
									<th class="text-center">불량수량</th>
									<th class="text-center">현재고</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../layout/bottom.jsp" %>

<style>
	.tr_highlight_row tr:hover {
		background-color: #ECFFB3;
	}
</style>

<script>
	let currentHref = "wmsc0010";
	let currentPage = $('.' + currentHref).attr('id');

	$('#' + currentPage).closest('.has-child', 'li').addClass('has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "생산지시현황(사출)"); 
	
	let serverDateFrom = "${serverDateFrom}";
	let serverDateTo = "${serverDateTo}";
    let workOrdDateFrom = serverDateFrom;
    let workOrdDateTo = serverDateTo;

	let serverMonthTo = serverDateTo.substring(0, 7);

    let itemGubun = null;
    let workEmerYn = "";

	//공통코드 처리 시작
	let itemGubunCode = new Array(); //품목구분
	<c:forEach items="${itemGubun}" var="info">
	var json1 = new Object();
	json1.baseCd = "${info.baseCd}";
	json1.baseNm = "${info.baseNm}";
	itemGubunCode.push(json1);
	</c:forEach>

	let workEmerYnCode = new Array(); //긴급여부
	<c:forEach items="${workEmerYn}" var="info">
	var json1 = new Object();
	json1.baseCd = "${info.baseCd}";
	json1.baseNm = "${info.baseNm}";
	workEmerYnCode.push(json1);
	</c:forEach>
	//공통코드 처리 종료  
	
	//작업지시 생성 조회
	let workOrdListTable = $('#workOrdListTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-7'l><'col-sm-12 col-md-5'f>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>B>",
		language : lang_kor,
		destroy : true,
		paging : true,
		searching : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : true,
		pageLength : -1,
		scrollY: "70vh",
		ajax : {
			url : '<c:url value="po/workOrdListAllBybomList"/>',
			type : 'GET',
			data : {
				'startDate' : function(){return workOrdDateFrom.replace(/-/g,'')},
				'endDate' : function(){return workOrdDateTo.replace(/-/g,'')},
				'itemGubun' : function(){return itemGubun;},
				'workEmerYn' : function(){return workEmerYn;},
				'mainGubun' : function(){return '001';},
				'tmMon' : function(){return serverMonthTo;}
			},
		},
		rowId : '',
		columns : [
			{//체크박스
				render: function(data, type, row, meta) {
					return '<input type="checkbox" class="checkbox" id="checkLal-'+meta.row+'" name="checkBoxDel" value="" style="min-width: 1.1rem;min-height: 1.1rem;">';
				},
				'className' : 'text-center p-0'
			}, 
			{//작업상태
				data : 'workStatusNm',
				render : function ( data, type, row, meta ) {
					if ( data != null ) {
						if ( data == "대기" ) {
							return '<span style="color: red;">'+data+'</span>';
						} else if ( data == "가동시작" ) {
 							return '<span style="color: blue;">'+data+'</span>';
						} else if ( data == "가동종료" ) {
							return '<span style="color: green;">'+data+'</span>';
						} else if ( data == "작업종료" ) {
							return '<span style="color: black;">'+data+'</span>';
						} else {
							return data;
						}
					} 
				}
			},
			{//작업지시번호
				data : 'workOrdNo'
			},
			{//작업지시일
				data : 'workOrdDate',
				render : function ( data, type, row, meta ) {
					if ( data != null && data != '' ) {
						return moment(data).format('YYYY-MM-DD');
					} else {
						return '';
					}
					
				}
			},
			{//부작업자
				data : 'subWorkChargrNm'
			},
			{//설비명
				data : 'equipNm',
				render : function ( data, type, row, meta ) {
					if ( data != null ) {
						return data;
					} else {
						return '';
					}
				},
			},
			{//긴급여부
				data : 'workEmerYnNm',
				render : function ( data, type, row, meta ) {
					if ( data != null ) {
						if ( data == '긴급' ) {
							return '<span style="color: orange;"><b>'+data+'</b></span>';
						} else {
							return data;
						}
					} else {
						return '';
					}
					
				},
			},
			{//업체명
				data : 'itemCusNm',
				render : function ( data, type, row, meta ) {
					if ( data != null ) {
						return data;
					} else {
						return '';
					}
				},
			},
			{//차종
				data : 'itemModelNm'
			},
			{//품번
				data : 'itemCd'
			},
			{//품명
				data : 'itemNm'
			},
			{//원자재명
				data : 'ebomItemNm'
			},
			{//Cavity
				data : 'equipCavity',
				render : function ( data, type, row, meta ) {
					if ( data != null ) {
						return data;
					} else {
						return '';
					}
				}
			},
			{//지시수량
				data : 'workOrdQty',
				render	: function ( data, type, row, meta ) {
					if ( data != null ) {
						return addCommas(data);
					} else {
						return "0";
					}
				},
				'className' : 'text-right'
			},
			{//생산수량
				data : 'outputQty',
				render	: function ( data, type, row, meta ) {
					if ( data != null ) {
						return addCommas(data);
					} else {
						return "0";
					}
				},
				'className' : 'text-right'
			},
			{//불량수량
				data : 'faultyQty',
				render	: function ( data, type, row, meta ) {
					if ( data != null ) {
						return addCommas(data);
					} else {
						return "0";
					}
				},
				'className' : 'text-right'
			},
			{//현재고
				data : 'tmQty',
				render	: function ( data, type, row, meta ) {
					if ( data != null ) {
						return rmDecimal(data);
					} else {
						return "0";
					}
				},
				'className' : 'text-right'
			},
			{//visible : false 된 것
				data : 'itemSeq'
			},
		],
		columnDefs: [
	           {"targets": "_all", "className": "text-center"},
	           {"targets": [17], "visible": false}
	    ],
		order: [
	    ],
	    buttons: [
	    	'copy', 'excel', 'print'                                
	    ],
	   
	});
	
	//메인 테이블_length 변경
	let html1 = '';
	html1 +=  '<div class="row">&nbsp;&nbsp;';
	html1 += '<label class="input-label-sm">작업지시일자</label>';
	html1 += '<input type="date" class="form-control" id="workOrdDateFrom" value="'+serverDateFrom+'" style="max-width:130px;">&nbsp; ~ &nbsp;';
	html1 += '<input type="date" class="form-control" id="workOrdDateTo" value="'+serverDateTo+'" style="max-width:130px;">&nbsp;&nbsp;&nbsp;&nbsp;';

	html1 += '<label class="input-label-sm">품목구분</label>';
	html1 += '<div class="form-group input-sub m-0">';
	html1 += 	'<select name="itemGubun" id="itemGubun" title="" class="select w80 col-12 custom-select">';
	html1 += 	'</select>';
	html1 += '</div>&nbsp;&nbsp;&nbsp;';

	html1 += '<label class="input-label-sm">긴급여부</label>';
	html1 += '<div class="form-group input-sub m-0">';
	html1 += 	'<select name="workEmerYn" id="workEmerYn" title="" class="select w80 col-12 custom-select">';
	html1 += 	'</select>';
	html1 += '</div>';
	html1 += '<button type="button" class="btn btn-danger ml-3" id="btnDel">삭제</button>';
	html1 += '</div>';

	$('#workOrdListTable_length').html(html1);
	
	$('#workOrdDateFrom').val(serverDateFrom);
    $('#workOrdDateTo').val(serverDateTo);
	selectBoxAppend(itemGubunCode, "itemGubun", "", "1");
	selectBoxAppend(workEmerYnCode, "workEmerYn", "", "1");
    
	//조건 선택시
	$('#workOrdDateFrom, #workOrdDateTo, #itemGubun, #workEmerYn').on('change', function() {
		workOrdDateFrom =  $('#workOrdDateFrom').val().replace(/-/g,'');
		workOrdDateTo =  $('#workOrdDateTo').val().replace(/-/g,'');
		itemGubun =  $('#itemGubun option:selected').val();
		workEmerYn =  $('#workEmerYn option:selected').val();
		
		$('#workOrdListTable').DataTable().ajax.reload(function(){});
    });

	//삭제버튼 클릭시
	$('#btnDel').on('click', function(){
		let delRow = [];
		let delcount = 0;
		let check = true;
		
		//1. 선택한 항목들이 삭제할 수 있는 것인지 확인
		$('#workOrdListTable tbody tr').each(function(index, item){
			if ( $(this).find('td input[name=checkBoxDel]').is(":checked") && check ) {
				let data = workOrdListTable.row(this).data();
				let workStatus = data.workStatusNm; //작업상태
				
				if ( workStatus != '대기' ) {
					toastr.warning("대기중인 작업지시만 삭제할 수 있습니다.");
					$(this).find('td input[name=checkBoxDel]').focus();
					check = false;
				}
			}
		});
		
		//2. 확인한 항목들 삭제
		if (check) {
			$('#workOrdListTable tbody tr').each(function(index, item){
				if ( $(this).find('td input[name=checkBoxDel]').is(":checked") ) {
					let data = workOrdListTable.row(this).data();
					workOrdNo = data.workOrdNo;   //작업세부번호
					
					$.ajax({
						url : '<c:url value="po/workOrderAdmDelete"/>',
						type : 'POST',
						async : false,
						data : {
							'workOrdNo' 	: function(){ return workOrdNo; },
						},
						success : function(res) {
							if ( res.result == "ok" ) {
							} else {
							    toastr.error(res.message);
							}
						}
					});
				}
			});
			
			toastr.success("삭제되었습니다.");
			$('#workOrdListTable').DataTable().ajax.reload(function(){});
		}
	})
	
	
</script>

</body>
</html>
