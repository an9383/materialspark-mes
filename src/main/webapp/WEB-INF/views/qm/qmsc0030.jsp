<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">자주검사관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<!--======================== .left-list ========================-->
		<div class="col-md-12 matrl-top-list">
			<!-- /.card -->
			<div class="card">
				<!--=====================-->
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table class="table table-bordered table-td-center" id="workOrderTable">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="7%">
						<col width="7%">
						<col width="7%">
						<col width="25%">
						<col width="10%">
						<col width="7%">
						<col width="7%">
					</colgroup>
						<thead class="thead-light">
							<tr>
								<th>시작시간</th>
								<th>종료시간</th>
								<th>설비명</th>
								<th>제품명</th>
								<th>재질</th>
								<th>규격</th>
								<th>LOT NO</th>
								<th>작업조</th>
								<th>작업자</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
		<!--======================== .right-sidebar 등록,수정 ========================-->
		<div class="col-md-12 matrl-bottom-list" id="">
			<!-- <h6> 자재 정보 <span id="formText"></span></h6> -->
			<!-- 등록, 수정 -->
			<div class="card" id="formBox">
				<div class="card-body col-sm-12">
					<h6>치수검사</h6>
				</div>
				<form id="form">					
					<div class="table-responsive">
							<table class="table table-bordered" id="sizeCheckTable" style="text-align:center">
							<thead class="thead-light">
							<tr>
								<th style="min-width: 50px">위치</th>
								<th colspan="2">Welding Part</th>
								<th colspan="2">Pitch</th>
								<th colspan="2">P.P Film 날개</th>
								<th colspan="2">P.P Film 폭</th>
								<th 		   >Film</th>
								<th colspan="2">METAL</th>
								<th colspan="2">총두께</th>
								<th colspan="3">Burr(MAX)</th>
							</tr>
							</thead>
							<tr>
								<th style="min-width: 50px">시료</th>
								<th style="min-width: 50px">(좌)</th>
								<th style="min-width: 50px">(우)</th>
								<th style="min-width: 50px">(좌)</th>
								<th style="min-width: 50px">(우)</th>
								<th style="min-width: 50px">(좌)</th>
								<th style="min-width: 50px">(우)</th>
								<th style="min-width: 50px">(좌)</th>
								<th style="min-width: 50px">(우)</th>
								<th style="min-width: 50px">총길이</th>
								<th style="min-width: 50px">폭</th>
								<th style="min-width: 50px">두께</th>
								<th style="min-width: 50px">Center</th>
								<th style="min-width: 50px">Edge</th>
								<th style="min-width: 50px">Metal</th>
								<th style="min-width: 50px">R-Cut</th>
								<th style="min-width: 50px">R끝단</th>																
							</tr>
							<tr>
								<th>조건	</th>								
								<td><span id="wpLeftCond"></span></td>
								<td><span id="wpRightCond"></span></td>
								<td><span id="pitchLeftCond"></span></td>
								<td><span id="pitchRightCond"></span></td>
								<td><span id="ppfWingLeftCond"></span></td>
								<td><span id="ppfWingRightCond"></span></td>
								<td><span id="ppfDepthLeftCond"></span></td>
								<td><span id="ppfDepthRightCond"></span></td>
								<td><span id="filmCond"></span></td>
								<td><span id="metalDepthCond"></span></td>
								<td><span id="metalThicknessCond"></span></td>
								<td><span id="thCenterCond"></span></td>
								<td><span id="thEdgeCond"></span></td>
								<td colspan="3"><span id="burrCond"></span></td>
							</tr>
							<tr>
								<th>초물</th>
								<td><span id="firstWpLeftAlwnce"></span></td>
								<td><span id="firstWpRightAlwnce"></span></td>
								<td><span id="firstPitchLeftAlwnce"></span></td>
								<td><span id="firstPitchRightAlwnce"></span></td>
								<td><span id="firstPpfWingLeftAlwnce"></span></td>
								<td><span id="firstPpfWingRightAlwnce"></span></td>
								<td><span id="firstPpfDepthLeftAlwnce"></span></td>
								<td><span id="firstPpfDepthRightAlwnce"></span></td>
								<td><span id="firstFilmAlwnce"></span></td>
								<td><span id="firstMetalDepthAlwnce"></span></td>
								<td><span id="firstMetalThicknessAlwnce"></span></td>
								<td><span id="firstThCenterAlwnce"></span></td>
								<td><span id="firstThEdgeAlwncePlus"></span></td>
								<td><span id="firstBurrMetalAlwnce"></span></td>
								<td><span id="firstBurrRcutAlwnce"></span></td>
								<td><span id="firstBurrRedgeAlwnce"></span></td>	
							</tr>     
						</table>
					</div>					
				</form>
			</div>
			<div class="mt-2">
				<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
				<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled></button>
			</div>
			<!--// 등록, 수정 -->
		</div>
		<!-- .right-sidebar -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>
	
	let menuAuth = 'qmsc0030';
	let currentHref = 'qmsc0030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자주검사관리");

	var serverDateFrom = "${serverDateFrom}";

	$.fn.dataTable.ext.errMode = 'none';
	let workOrderTable = $('#workOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    language: lang_kor,
	    paging: true,
	    info: true,
	    ordering: true,
	    processing: true,
	    autoWidth: false,
	    lengthChange: true,
	    searching: true,
	    pageLength: 10,
	    ajax: {
	        url: '<c:url value="/qm/workOrderRead2DataList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	        	'ordDate' : function() { return moment(serverDateFrom).format('YYYYMMDD'); },
	        }	        
	    },
		columns: [
			{ data: 'workStartTime',
		   		render: function(data, type, row) {
			   		if (data == '1900-01-01 00:00:00.0' || data == null)
		   				return '-';
			   		else {
			   			return data.substring(0,19);
				   	}
		   		}
            },
            { data: 'workEndTime',
		   		render: function(data, type, row) {
			   		if (row['workStartTime'] == '1900-01-01 00:00:00.0' && data == '1900-01-01 00:00:00.0') {
			   			return '생산 중.';
				   	}
		   			else if (data == '1900-01-01 00:00:00.0' || data == null){
		   				return '-';
				   	}
			   		else {
			   			return data.substring(0,19);
				   	}
		   		}
            },
			{ data: 'equipNm'},
			{ data: 'goodsNm'},
			{ data: 'qutyNm'},
			{ data: 'model'},
			{ data: 'ordLotNo'},
			{ data: 'workTeamNm'},
			{ data: 'userNm'},
		],
		order: [
			//[ 0, 'asc' ],
		],
		columnDefs: [
	           //{ targets: [7], render: $.fn.dataTable.render.number( ',' ) },
	           //{ targets: [7], className: 'text-right' },
	        ],
	});
	
	var html1 =  '<div class="row">&nbsp;<label class="input-label-sm">일자</label><div class="form-group input-sub m-0 row"><input class="form-control" type="text" style="width:97px;" id="date" name="date" /><button onclick="fnPopUpCalendar(date,date,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button"><span class="oi oi-calendar"></span></button></div>&nbsp;<button type="button"  class="btn btn-primary" id="btnView">조회</button></div>';								
	$('#workOrderTable_length').html(html1);
	$('#date').val(serverDateFrom);

	$('#btnView').on('click', function() {
		serverDateFrom = $('#date').val();	
		$('#workOrderTable').DataTable().ajax.reload();		  
	});
	
	var workOrdNo=null;
	var equipCondSeq=null;
	
	$('#workOrderTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');			
		} else {
			$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');		
			workOrdNo = workOrderTable.row(this).data().workOrdNo;
			equipCondSeq = workOrderTable.row(this).data().equipCondSeq;
			$.ajax({
		        url: '<c:url value="/qm/sizeCheckDataList"/>',
		        type: 'GET',
		        data: {
		        	'menuAuth'	 	: 		menuAuth,
		        	'workOrdNo' :  workOrdNo,
		        	'equipCondSeq' : equipCondSeq
		        },
		        success: function(res){
		        	
		        	var sizeData = res.cond; 
		        	var stepData = res.step;
		        	//console.log(stepData);
		        	//console.log(sizeData);
	
					if(res.result == "ok") {
			        	$('#wpLeftCond').text('-'+sizeData.wpLeftAlwnceMinus + ' [' + sizeData.wpLeftCond + '] +' + sizeData.wpLeftAlwncePlus);
		            	$('#wpRightCond').text('-'+sizeData.wpRightAlwnceMinus + ' [' + sizeData.wpRightCond + '] +' + sizeData.wpRightAlwncePlus);
		            	$('#pitchLeftCond').text('-'+sizeData.pitchLeftAlwnceMinus + ' [' + sizeData.pitchLeftCond + '] +' + sizeData.pitchLeftAlwncePlus);
		            	$('#pitchRightCond').text('-'+sizeData.pitchRightAlwnceMinus + ' [' + sizeData.pitchRightCond + '] +' + sizeData.pitchRightAlwncePlus);
		            	$('#ppfWingLeftCond').text('-'+sizeData.ppfWingLeftAlwnceMinus + ' [' + sizeData.ppfWingLeftCond + '] +' + sizeData.ppfWingLeftAlwncePlus);
		            	$('#ppfWingRightCond').text('-'+sizeData.ppfWingRightAlwnceMinus + ' [' + sizeData.ppfWingRightCond + '] +' + sizeData.ppfWingRightAlwncePlus);
		            	$('#ppfDepthLeftCond').text('-'+sizeData.ppfDepthLeftAlwnceMinus + ' [' + sizeData.ppfDepthLeftCond + '] +' + sizeData.ppfDepthLeftAlwncePlus);
		            	$('#ppfDepthRightCond').text('-'+sizeData.ppfDepthRightAlwnceMinus + ' [' + sizeData.ppfDepthRightCond + '] +' + sizeData.ppfDepthRightAlwncePlus);
		            	$('#filmCond').text('-'+sizeData.filmAlwnceMinus + ' [' + sizeData.filmCond + '] +' + sizeData.filmAlwncePlus);
		            	$('#metalDepthCond').text('-'+sizeData.metalDepthAlwnceMinus + ' [' + sizeData.metalDepthCond + '] +' + sizeData.metalDepthAlwncePlus);
		            	$('#metalThicknessCond').text('-'+sizeData.metalThicknessAlwnceMinus + ' [' + sizeData.metalThicknessCond + '] +' + sizeData.metalThicknessAlwncePlus);
		            	$('#thCenterCond').text('-'+sizeData.thCenterAlwnceMinus + ' [' + sizeData.thCenterCond + '] +' + sizeData.thCenterAlwncePlus);
		            	$('#thEdgeCond').text('-'+sizeData.thEdgeAlwnceMinus + ' [' + sizeData.thEdgeCond + '] +' + sizeData.thEdgeAlwncePlus);
		            	$('#burrCond').text('-'+sizeData.burrAlwnceMinus + ' [' + sizeData.burrCond + '] +' + sizeData.burrAlwncePlus);
		            	
	            		$.each(stepData, function(idx, item){
		            			if(idx == 0){			          			
					 	        	$('#firstWpLeftAlwnce').text(item.wpLeftAlwnce);
					 	        	$('#firstWpRightAlwnce').text(item.wpRightAlwnce);
					 	        	$('#firstPitchLeftAlwnce').text(item.pitchLeftAlwnce);
					 	        	$('#firstPitchRightAlwnce').text(item.pitchRightAlwnce);
					 	        	$('#firstPpfWingLeftAlwnce').text(item.ppfWingLeftAlwnce);
					 	        	$('#firstPpfWingRightAlwnce').text(item.ppfWingRightAlwnce);
					 	        	$('#firstPpfDepthLeftAlwnce').text(item.ppfDepthLeftAlwnce);
					 	        	$('#firstPpfDepthRightAlwnce').text(item.ppfDepthRightAlwnce);
					 	        	$('#firstFilmAlwnce').text(item.filmAlwnce);
					 	        	$('#firstMetalDepthAlwnce').text(item.metalDepthAlwnce);
					 	        	$('#firstMetalThicknessAlwnce').text(item.metalThicknessAlwnce);
					 	        	$('#firstThCenterAlwnce').text(item.thCenterAlwnce);
					 	        	$('#firstThEdgeAlwncePlus').text(item.thEdgeAlwncePlus);
					 	        	$('#firstBurrMetalAlwnce').text(item.burrMetalAlwnce);
					 	        	$('#firstBurrRcutAlwnce').text(item.burrRcutAlwnce);
		        	 	        	$('#firstBurrRedgeAlwnce').text(item.burrRedgeAlwnce);
				          		}
	           		 	}); 		
	           		 	
	            		calc('firstWpLeftAlwnce' ,sizeData.wpLeftCond ,sizeData.wpLeftAlwnceMinus ,sizeData.wpLeftAlwncePlus);
		            	calc('firstWpRightAlwnce',sizeData.wpRightCond,sizeData.wpRightAlwnceMinus ,sizeData.wpRightAlwncePlus);
		            	calc('firstPitchLeftAlwnce',sizeData.pitchLeftCond,sizeData.pitchLeftAlwnceMinus,sizeData.pitchLeftAlwncePlus);
		            	calc('firstPitchRightAlwnce',sizeData.pitchRightCond,sizeData.pitchRightAlwnceMinus,sizeData.pitchRightAlwncePlus);
		            	calc('firstPpfWingLeftAlwnce',sizeData.ppfWingLeftCond,sizeData.ppfWingLeftAlwnceMinus,sizeData.ppfWingLeftAlwncePlus);	            	
		            	calc('firstPpfWingRightAlwnce',sizeData.ppfWingRightCond,sizeData.ppfWingRightAlwnceMinus,sizeData.ppfWingRightAlwncePlus);
		            	calc('firstPpfDepthLeftAlwnce',sizeData.ppfDepthLeftCond,sizeData.ppfDepthLeftAlwnceMinus,sizeData.ppfDepthLeftAlwncePlus);
		            	calc('firstPpfDepthRightAlwnce',sizeData.ppfDepthRightCond,sizeData.ppfDepthRightAlwnceMinus,sizeData.ppfDepthRightAlwncePlus);
		            	calc('firstFilmAlwnce',sizeData.filmCond,sizeData.filmAlwnceMinus,sizeData.filmAlwncePlus);
		            	calc('firstMetalDepthAlwnce',sizeData.metalDepthCond,sizeData.metalDepthAlwnceMinus,sizeData.metalDepthAlwncePlus);
		            	calc('firstMetalThicknessAlwnce',sizeData.metalThicknessCond,sizeData.metalThicknessAlwnceMinus,sizeData.metalThicknessAlwncePlus);
		            	calc('firstThCenterAlwnce',sizeData.thCenterCond,sizeData.thCenterAlwnceMinus,sizeData.thCenterAlwncePlus);
		            	calc('firstThEdgeAlwncePlus',sizeData.thEdgeCond,sizeData.thEdgeAlwnceMinus,sizeData.thEdgeAlwncePlus);
		            	calc('firstBurrMetalAlwnce',sizeData.burrCond,sizeData.burrAlwnceMinus,sizeData.burrAlwncePlus);
					}
					else {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				}
			});
		}	
	});

	function calc(id ,text ,minus ,plus){		
		if(parseFloat($('#' + id).text()) >= (parseFloat(text) - parseFloat(minus)) && parseFloat($('#' + id).text()) <= (parseFloat(text) + parseFloat(plus))){
			//console.log($('#' + id).text());
			$('#' + id).css("color","black");	
			
		} else{
			$('#' + id).css("color","red");			
		}
	}
	
</script>
</body>
</html>
