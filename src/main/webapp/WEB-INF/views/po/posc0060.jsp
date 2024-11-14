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
					<li class="breadcrumb-item"><a href="#">공정실적관리(POP)</a></li>
					<li class="breadcrumb-item active">비가동사유등록</li>
				</ol>
			</nav>
		</header>
		<!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list left-60" id="left-60" style="width:13%;">
                      <div class="card">
                        <!-- .table-responsive -->
                          <div class="table-responsive">
		                    <table id="equipCodeAdmTable" class="table table-bordered">
		                        <thead class="thead-light">
			                        <tr>
										<th style="min-width: 50px" >설비명</th>
		                            </tr>
		                        </thead>
                              </table>
                          </div>
						 <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                   <div class="right-list left-60" id="left-60" style="width:40%;">
						<div class="card">
		                  <div class="mt-2">
	                          <div class="row">
									&nbsp;<label class="input-label-sm">등록일</label>
	                                 <div class="form-group input-sub m-0 row">
	                                 <input class="form-control" style="width:97px;" type="text" id="downtimeRegDate" name="downtimeRegDate" />
	                                 <button onclick="fnPopUpCalendar(downtimeRegDate,downtimeRegDate,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="preInWhsDateCalendar" type="button">
	                                 <span class="oi oi-calendar"></span>
	                                 </button>
	                              </div>
	                              &nbsp;&nbsp;&nbsp;<label class="input-label-sm">주야구분</label><select class="custom-select" id="DayNightCd" style="width:60px;"></select>
	                              &nbsp;<button type="button" class="btn btn-primary float-right mr-2" id="btnRetv" >조회</button>
	                           </div>
                        	</div>
							<!-- .table-responsive -->
						<br>
						<form id="form">
						 <table class="table table-bordered" id="equipDowntimeAdmTable">
						 	 <thead class="thead-light">
								<tr>
									<th>구분</th>
									<th>시작시간</th>
									<th>종료시간</th>
									<th>중단시간(분)</th>
								</tr>
							</thead>
								<tr id="001">
									<th>설비문제</th>	
									<td><input type="text" class="form-control" id="equipStartTime" style="text-align:center; width:100%;  height:40px;" name="equipStartTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>	
									<td><input type="text" class="form-control" id="equipEndTime" style=" width:100%; text-align:center; height:40px;" name="equipEndTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>
									<td><input type="text" class="form-control" id="equipStopTime" style=" width:100%; text-align:center; height:40px;"  name="equipStopTime"  value="" maxlength="4" placeholder="minute" disabled></td>					
								</tr>
								<tr id="002">
									<th>자재부족</th>
									<td><input type="text" class="form-control" id="matrlStartTime" style=" width:100%; text-align:center; height:40px;" name="matrlStartTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>	
									<td><input type="text" class="form-control" id="matrlEndTime" style=" width:100%; text-align:center; height:40px;" name="matrlEndTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>
									<td><input type="text" class="form-control" id="matrlStopTime" style=" width:100%; text-align:center; height:40px;" name="matrlStopTime"  value="" maxlength="4" placeholder="minute" disabled></td>										
								</tr>
								<tr id="003">
									<th>계획정지</th>			
									<td><input type="text" class="form-control" id="planStartTime" style=" width:100%; text-align:center; height:40px;" name="planStartTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>	
									<td><input type="text" class="form-control" id="planEndTime" style=" width:100%; text-align:center; height:40px;" name="planEndTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>
									<td><input type="text" class="form-control" id="planStopTime" style=" width:100%; text-align:center; height:40px;" name="planStopTime"  value="" maxlength="4" placeholder="minute" disabled></td>				
								</tr>
								<tr id="004">
									<th>인원부족</th>	
									<td><input type="text" class="form-control" id="humanStartTime" style=" width:100%; text-align:center; height:40px;" name="humanStartTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>	
									<td><input type="text" class="form-control" id="humanEndTime" style=" width:100%; text-align:center; height:40px;" name="humanEndTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>
									<td><input type="text" class="form-control" id="humanStopTime" style=" width:100%; text-align:center; height:40px;" name="humanStopTime"  value="" maxlength="4" placeholder="minute" disabled></td>								
								</tr>
								<tr id="005">
									<th>기타</th>								
									<td><input type="text" class="form-control" id="startTime" style=" width:100%; text-align:center; height:40px;" name="startTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>	
									<td><input type="text" class="form-control" id="endTime" style=" width:100%; text-align:center; height:40px;" name="endTime"  value="" maxlength="5" placeholder="HH:MM" disabled></td>
									<td><input type="text" class="form-control" id="stopTime" style=" width:100%; text-align:center; height:40px;" name="stopTime"  value="" maxlength="4" placeholder="minute" disabled></td>						
								</tr>
								
							</table>							
						</form>					
						 <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
                    <div class="right-list left-60" id="left-60" style="width:40%;">
						<div class="card" id="formBox">
							<!-- ----- 공정불량 상세정보 시작-----  -->
								<div class="card-body col-sm-12 p-2">
									<button type="button" class="btn btn-primary float-right mr-2" id="btnSave" disabled >저장</button>
								</div>
								<div class="table-responsive">
								<table class="table table-bordered text-center" id="codeTable">
									<colgroup><col width="15%"></colgroup>
									<colgroup><col width="14%"></colgroup>
									<colgroup><col width="70%"></colgroup>		
									<thead class="thead-light">															
									<tr>										
										<th>순번</th>
				                        <th>체크</th>
				                        <th class="text-center">사유</th>				                       
									</tr>
									</thead>									
								</table>
								</div>
						
							<!-- ----- 공정불량 상세정보 끝 ----- -->							
						</div>
					</div><!-- .right-sidebar -->
				</div><!-- /.row -->
			</div><!-- / #main  -->
		</div><!-- /.page-wrapper -->
		<!-- 저장 여부 모달 -->
<div class="modal fade" id="saveBtnModal" tabindex="-1" role="dialog" aria-labelledby="saveBtnModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel">주의</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h6>정말 저장 하시겠습니까?</h6> 
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" id="saveBtnModalY" data-dismiss="modal">예</button>
      	<button type="button" class="btn btn-danger" id="saveBtnModalN" data-dismiss="modal">아니요</button>
      </div>
    </div>
  </div>
</div>
		
<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'posc0060';
	let currentHref = 'posc0060';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","비가동사유등록");

	var serverDate =  "${serverDate}";
	var chooseDate = serverDate;
	var equipCd = null;
	var downtimeCd = null;
	var baseGroupCd = null;
	var startTime = null;
	var endTime = null;
	var stopTime = null;
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	
	//공통코드 처리 시작
	var dayNightCd = new Array(); // 주야 그룹
    <c:forEach items="${dayNightCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		dayNightCd.push(json);
    </c:forEach>
    
    var equipGroupCode = new Array(); // 설비분류
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    selectBoxAppend(dayNightCd, "DayNightCd", "", "");
    
	// 목록
	$.fn.dataTable.ext.errMode = 'none';
	let equipCodeAdmTable = $('#equipCodeAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<''l>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        language: lang_kor,
        paging: true,
        info: false,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        searching: false,
        pageLength: 11,
        ajax: {
            url: '<c:url value="bm/equipCodeAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'equipGroup' : function() { return equipGroup; }
            },
        },
        rowId: 'equipCd',
		columns: [
			{ data: 'equipNm' },
		],
		order: [
			[ 0, 'asc' ],
		],
	    drawCallback: function( settings ) {
	    	$('#equipCodeAdmTable tbody tr td').css('height','40px');
	    }
    });

	$.fn.dataTable.ext.errMode = 'none';
	let codeTable = $('#codeTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        language: lang_kor,
        paging: true,
        info: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        searching: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="bm/systemCommonCodeDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,      
            	'baseGroupCd': function(){return baseGroupCd;}
            },
        },
		columns: [
			{ 
				render: function(data, type, row, meta) {	    			
					return meta.row + 1;
    			}
			},
			{
				render: function(data, type, row, meta) {						
					return  '<input type="checkbox" name= "chk">';
    			}
			 },
			{ data : 'baseCdNm'}
		],
		order: [
			[ 0, 'asc' ],
		],
	  columnDefs: [
           { targets: 2, className: 'text-left' }         
        ],
	    drawCallback: function( settings ) {
	    	$('#codeTable tbody tr td').css('height','40px');
	    }
    });

 	var html1 = '&nbsp;<label class="input-label-sm">설비그룹 </label><select  class="custom-select" id="equipGroupCd" ></select>';
    $('#equipCodeAdmTable_length').html(html1);
    selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");

	 $("#preInWhsDateCalendar").on('click',function() {
		 $('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
		 $('#equipDowntimeAdmTable').find("tr.tableSelected").removeClass('tableSelected');
		 $('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
		 $('#codeTable').DataTable().clear().draw();
		 equipCd = null;
	 });
    
    $("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});	 
	 	equipCd = null;
	 	$('#form').each(function(){
			 this.reset();
		});		
	 	$('#codeTable').DataTable().ajax.reload(function() {});
	});

    $('#preInWhsDateCalendar').click(function() {
    	$('#form').each(function(){
   		 this.reset();
   		});
    });
	
    $("#btnRetv").on('click',function() {
    	if( equipCd == null ){
			toastr.warning('설비명을 선택해주세요.');
			return false;
		}
	 	 $.ajax({
   	    	url: '<c:url value="po/equipDowntimeAdmDataList"/>',
   	        type: 'GET',
   	        data: {
   	        	'menuAuth'	 	: 		menuAuth,
   	        	'equipCd'			:	equipCd,
   	        	'downtimeRegDate'	:	$('#downtimeRegDate').val().replace(/-/g, ''),
   	        	'dayNightCd'		:   $("#DayNightCd option:selected").val(),
   	        },
   	        success: function (res) {
   	            var data = res.data;
	   	         $('#form').each(function(){
					 this.reset();				 
				});	
   	       		$.each(data, function(index, item){
					if(item.downtimeCd=="001" && item.startTime != null){								
						$('#equipStartTime').val(item.startTime);
						$('#equipEndTime').val(item.endTime);
						$('#equipStopTime').val(item.stopTime);
					} else if(item.downtimeCd=="002" && item.startTime != null){
						$('#matrlStartTime').val(item.startTime);
						$('#matrlEndTime').val(item.endTime);
						$('#matrlStopTime').val(item.stopTime);
					} else if(item.downtimeCd=="003" && item.startTime != null){
						$('#planStartTime').val(item.startTime);
						$('#planEndTime').val(item.endTime);
						$('#planStopTime').val(item.stopTime);
					} else if(item.downtimeCd=="004" && item.startTime != null){
						$('#humanStartTime').val(item.startTime);
						$('#humanEndTime').val(item.endTime);
						$('#humanStopTime').val(item.stopTime);
					} else if(item.downtimeCd=="005" && item.startTime != null){
						$('#startTime').val(item.startTime);
						$('#endTime').val(item.endTime);
						$('#stopTime').val(item.stopTime);
					}
   	         	});
      	       	baseGroupCd = null;
      	       	$('#btnSave').attr('disabled',true);
      	        $('#equipDowntimeAdmTable tbody tr').removeClass('tableSelected');
      	        $('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
      	        $('#codeTable').DataTable().ajax.reload(function() {});
      	        chooseDate = $('#downtimeRegDate').val();
   	        }
		});
	});
    
	$('#downtimeRegDate').val(chooseDate);
	
    $('#equipCodeAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {          
        }	
        else {
        	$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');           
            equipCd = equipCodeAdmTable.row( this ).data().equipCd;
			$('#form').each(function(){
				 this.reset();				 
			});			
			$('#equipDowntimeAdmTable tbody tr').removeClass('selected');
			
			baseGroupCd = null;
			chooseDate = $('#downtimeRegDate').val();
			$('#codeTable').DataTable().ajax.reload(function() {});
		
			$.ajax({
	   	    	url: '<c:url value="po/equipDowntimeAdmDataList"/>',
	   	        type: 'GET',
	   	        data: {
	   	        	'menuAuth'	 	: 		menuAuth,
	   	        	'equipCd'			:	equipCd,
	   	        	'downtimeRegDate'	:	$('#downtimeRegDate').val().replace(/-/g, ''),
	   	        	'dayNightCd'		:   'D',
	   	        },
	   	        success: function (res) {
	   	            var data = res.data;
		   	         $('#form').each(function(){
						 this.reset();				 
					});	
	   	       		$.each(data, function(index, item){
		   	       		if(item.downtimeCd=="001" && item.startTime != null){								
							$('#equipStartTime').val(item.startTime);
							$('#equipEndTime').val(item.endTime);
							$('#equipStopTime').val(item.stopTime);
						} else if(item.downtimeCd=="002" && item.startTime != null){
							$('#matrlStartTime').val(item.startTime);
							$('#matrlEndTime').val(item.endTime);
							$('#matrlStopTime').val(item.stopTime);
						} else if(item.downtimeCd=="003" && item.startTime != null){
							$('#planStartTime').val(item.startTime);
							$('#planEndTime').val(item.endTime);
							$('#planStopTime').val(item.stopTime);
						} else if(item.downtimeCd=="004" && item.startTime != null){
							$('#humanStartTime').val(item.startTime);
							$('#humanEndTime').val(item.endTime);
							$('#humanStopTime').val(item.stopTime);
						} else if(item.downtimeCd=="005" && item.startTime != null){
							$('#startTime').val(item.startTime);
							$('#endTime').val(item.endTime);
							$('#stopTime').val(item.stopTime);
						}
	   	         	});
		      	       	baseGroupCd = null;
		      	       	$('#btnSave').attr('disabled',true);
		      	        $('#downtimeRegDate').val(chooseDate);
		      	        $('#equipDowntimeAdmTable tbody tr').removeClass('tableSelected');
		      	        $('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
		      	        $('#codeTable').DataTable().ajax.reload(function() {});

	   	        }
	         });
        }
    });
	
	$('#equipDowntimeAdmTable tbody').on('click', 'tr', function () {
		if( equipCd == null ){
			toastr.warning('설비명을 선택해주세요.');
			return false;
		}
		else{
			if ( $(this).hasClass('tableSelected') ) {
			
			}
	        else {			
	        	$('#equipDowntimeAdmTable tbody tr').removeClass('tableSelected');
	        	$(this).addClass('tableSelected');      
	        	
	        	$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);	
				$(this).find('td').find('input').prop('disabled',false);
				
	        	startTime = $(this).find('td').find('input').eq(0).val();				
				endTime = $(this).find('td').find('input').eq(1).val();				
				stopTime = $(this).find('td').find('input').eq(2).val();
				downtimeCd = $(this).closest('tr').attr('id');			
				$('#btnSave').attr('disabled',false);
				
				baseGroupCd = '012';
				$('#codeTable').DataTable().ajax.reload(function() {
					$.ajax({
						url: '<c:url value="po/equipDowntimeAdmRead"/>',
			   	        type: 'GET',
			   	        data: {
			   	        	'menuAuth'	 	: 		menuAuth,
			   	        	'equipCd'			:	equipCd,
			   	        	'downtimeRegDate'	:	$('#downtimeRegDate').val().replace(/-/g, ''),
			   	        	'dayNightCd'		:   $("#DayNightCd option:selected").val(),
			   	        	'downtimeCd'		:   downtimeCd
			   	        },
			   	        success: function (res) {
			   	        	var data = res.data;
			   	        	if (res.result == "ok"){
				   	        	if(data != null){
					   	        	if(data.code1 == "Y"){
					   	        		$('input[type=checkbox]').eq(0).attr("checked", true);
					   	        	}
					   	        	if(data.code2 == "Y"){
					   	        		$('input[type=checkbox]').eq(1).attr("checked", true);
					   	        	}
					   	        	if(data.code3 == "Y"){
					   	        		$('input[type=checkbox]').eq(2).attr("checked", true);
					   	        	}
					   	        	if(data.code4 == "Y"){
					   	        		$('input[type=checkbox]').eq(3).attr("checked", true);
					   	        	}
					   	        	if(data.code5 == "Y"){
					   	        		$('input[type=checkbox]').eq(4).attr("checked", true);
					   	        	}
					   	        	if(data.code6 == "Y"){
					   	        		$('input[type=checkbox]').eq(5).attr("checked", true);
					   	        	}
					   	        	if(data.code7 == "Y"){
					   	        		$('input[type=checkbox]').eq(6).attr("checked", true);
					   	        	}
				   	        	}
				   	        } else {
				   	        	toastr.error(res.message, '', {timeOut: 5000});
							}
			   	        }
					});
				});
	        }
		}
	});
	
	/* $('#btnEdit').on('click',function(){
		$('#'+ downtimeCd).find('td').find('input').attr('disabled',false);
	}); */
	
	$('#btnSave').on('click', function(){
		var code = null;
		var code1Stat = null;
		var code2Stat = null;
		var code3Stat = null;
		var code4Stat = null;
		var code5Stat = null;
		var code6Stat = null;
		var code7Stat = null;
		
		/* $('#saveBtnModal').modal('show');
		$('#saveBtnModalN').on('click',function(){
			$('#saveBtnModal').modal('hide');
			return false;
		});
		
		$('#saveBtnModalY').on('click',function(){
			
			$('#saveBtnModal').modal('hide');
		*/
		
		if ( $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(0).val() == "" ) {
	        toastr.warning('시작시간을 입력해주세요');
	        $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(0).focus();
			return false;
		}
		if ( $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(1).val() == "" ) {
	        toastr.warning('종료시간을 입력해주세요');
	        $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(1).focus();
			return false;
		}
		if ( $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(2).val() == "" ) {
	        toastr.warning('중단시간(분)을 입력해주세요');
	        $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(2).focus();
			return false;
		}

		$("#equipDowntimeAdmTable").find(".selected").find('input').eq(0).val()
		
		
			$("[name='chk']:checked").each(function(){
				code = $(this).closest('tr').find('td').eq(0).html();
				
				if(code == 1){
					code1Stat = 'Y';
				} else if(code == 2){
					code2Stat = 'Y';
				} else if(code == 3){
					code3Stat = 'Y';
				} else if(code == 4){
					code4Stat = 'Y';
				} else if(code == 5){
					code5Stat = 'Y';
				} else if(code == 6){
					code6Stat = 'Y';
				} else if(code == 7){
					code7Stat = 'Y';
				}
			});

			//alert($('#downtimeRegDate').val().replace(/-/g, ''));
			
		    $.ajax({
	    	    	url: '<c:url value="po/equipDowntimeAdmCreate"/>',
	    	        type: 'POST',
	    	        data: {
	    	        	'menuAuth'	 		: 	menuAuth,
	    	        	'equipCd'			:	equipCd,
	    	        	'downtimeRegDate'	:	function() { return $('#downtimeRegDate').val().replace(/-/g, ''); },
	    	        	'dayNightCd'		:   $("#DayNightCd option:selected").val(),
	    	        	'downtimeCd'  		:   downtimeCd,
	    	        	'startTime'			:	$('#'+downtimeCd).find('td').find('input').eq(0).val(),
	   	        		'endTime'			:	$('#'+downtimeCd).find('td').find('input').eq(1).val(),
	        			'stopTime'			:	$('#'+downtimeCd).find('td').find('input').eq(2).val(),
	    	        	'code1'  			:   code1Stat,
	    	        	'code2'  			:   code2Stat,
	    	        	'code3'  			:   code3Stat,
	    	        	'code4'  			:   code4Stat,
	    	        	'code5'  			:   code5Stat,
	    	        	'code6'  			:   code6Stat,
	    	        	'code7'  			:   code7Stat
	    	        },
	    	        success: function (res) {
	    	            var data = res.data;
	    	       		if(res.result == "ok"){
	    	       			toastr.success("저장되었습니다.");
	    	       			$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
	    	       			$('#equipDowntimeAdmTable tbody tr').removeClass('tableSelected');
	    	       			baseGroupCd = null;
	    	       			//$('#codeTable').DataTable().ajax.reload(function() {});
	    	       		} else{
	    	       			toastr.error(res.message, '', {timeOut: 5000});
	    	       		}
	    	        }
	          });
		//}); 
	});
   	
</script>
</body>
</html>
