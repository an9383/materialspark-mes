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
					<li class="breadcrumb-item"><a href="#">설비관리</a></li>
					<li class="breadcrumb-item active">정기검사관리</li>
				</ol>
			</nav>
		</header>
		<!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list left-60" id="left-60" style="width:15%;">
                      <div class="card">
                        <!-- .table-responsive -->
                          <div class="table-responsive">
		                    <table id="equipCodeAdmTable" class="table table-bordered">
		                        <thead class="thead-light">
			                        <tr>
			                        	<th style="min-width: 50px" >설비코드</th>
										<th style="min-width: 50px" >설비명</th>
		                            </tr>
		                        </thead>
                              </table>
                          </div>
						 <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                   <div class="right-list left-60" id="left-60" style="width:34%;">
						<div class="card">
		                  <div class="mt-2">
                           <div class="row">&nbsp;<label class="input-label-sm">등록년월</label>
                                 <div class="form-group input-sub m-0 row">
	                                 <input class="form-control mtz-monthpicker-widgetcontainer" type="text" id="demo-2">
                              	</div>
                           </div>
                        </div>
						<!-- .table-responsive -->
						<br>
						<div class="table-responsive">
	                   		<table id="calTable" class="table table-bordered" >
		                        <thead class="thead-light">
			                        <tr>
			                        	<th style="min-width:30px;">NO</th>
										<th>①</th>
										<th>②</th>
										<th>③</th>
										<th>④</th>
										<th>⑤</th>
										<th>⑥</th>
										<th>⑦</th>
										<th>⑧</th>										
										<th>⑨</th>
										<th>⑩</th>
										<th>⑪</th>
										<th>⑫</th>
										<th>⑬</th>
										<th>⑭</th>
										<th>⑮</th>
										<th>⑯</th>
										<th>⑰</th>
										<th>⑱</th>										
		                            </tr>                    
		                            	
		                        </thead>
	                   		</table>
	                   </div>					
						
						 <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
                    <div class="right-list left-60" id="left-60" style="width:50%;">
						<div class="card" id="formBox">
							<!-- ----- 공정불량 상세정보 시작-----  -->
							<div class="card-body col-sm-12">               
								<button type="button" class="btn btn-primary float-right " id="btnSave" disabled >저장</button>              
	                            <button type="button" class="btn btn-primary float-right mr-1" id="btnEdit">수정</button>
	                            <button class="btn btn-warning d-none" id="btnEditConfirmLoading" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
	                            <button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
	                            <button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
                        		
                        	</div>									
							
								<div class="table-responsive">
								<form id="form">
					
								 <table class="table table-bordered" id="inspctTable" style="text-align:center;">
								 
								 	<thead class="thead-light">
										<tr>
											<th style="width:10px;">NO</th>
											<th>점검범위</th>
											<th>점검부위</th>
											<th>점검기준</th>
											<th>점검방법</th>
											<th>결과</th>
										</tr>
									</thead>
										<tr>
											<th rowspan="2" style="width:10px;">1</th>	
											<td rowspan="8"><p>진접공정</p></td>	
											<td><p>블록수평(앞)</p></td>
											<td><p>수평 값 변화 없을 것</p></td>
											<td><p>① height gauge</p></td>
											<td><select id="inspctItem1Dtl1" class="custom-select"></select></td>				
										</tr>
										<tr>
											<td><p>블록수평(뒤)</p></td>
											<td><p>수평 값 변화 없을 것</p></td>
											<td><p>② height gauge</p></td>
											<td><select id="inspctItem1Dtl2" class="custom-select"></select></td>	
														
										</tr>
										<tr>
											<th rowspan="2" style="width:10px;">2</th>	
											<td rowspan="2"><p>블록 넓이</p></td>
											<td><p>22mm(상부)</p></td>
											<td><p>③ 육안</p></td>
											<td><select id="inspctItem2Dtl1" class="custom-select"></select></td>				
										</tr>
										<tr>
											<td><p>22mm(하부)</p></td>
											<td><p>④ 육안</p></td>
											<td><select id="inspctItem2Dtl2" class="custom-select"></select></td>	
											
										</tr>
										<tr>
											<th rowspan="2" style="width:10px;">3</th>	
											<td rowspan="2"><p>진접 실리콘</p></td>
											<td><p>1일 교체 확인 (상부)</p></td>
											<td><p>⑤ 육안</p></td>
											<td><select id="inspctItem3Dtl1" class="custom-select"></select></td>						
										</tr>
										<tr>
											<td><p>1일 교체 확인 (하부)</p></td>
											<td><p>⑥ 육안</p></td>
											<td><select id="inspctItem3Dtl2" class="custom-select"></select></td>		
										</tr>
										<tr>
											<th rowspan="2" style="width:10px;">4</th>	
											<td rowspan="2"><p>Teflon tape</p></td>
											<td><p>실런트부 자국정도(상부)</p></td>
											<td><p>⑦ 육안</p></td>
											<td><select id="inspctItem4Dtl1" class="custom-select"></select></td>				
										</tr>
										<tr>							
											<td><p>실런트부 자국정도(하부)</p></td>
											<td><p>⑧ 육안</p></td>
											<td><select id="inspctItem4Dtl2" class="custom-select"></select></td>	
													
										</tr>
										<tr>
											<th rowspan="3" style="width:10px;">5</th>
											<td rowspan="3"><p>자재투입부</p></td>	
											<td rowspan="2"><p>원자재(Al Nicu)</p></td>
											<td><p>AL(표면처리상태,규격)</p></td>											
											<td><p>⑨ 육안,버니어</p></td>								
											<td><select id="inspctItem5Dtl1" class="custom-select"></select></td>					
										</tr>
										<tr>
											<td><p>Nicu(규격,표면상태)</p></td>
											<td><p>⑩ 육안,버니어</p></td>								
											<td><select id="inspctItem5Dtl2" class="custom-select"></select></td>											
										</tr>
										<tr>								
											<td><p>Film</p></td>	
											<td><p>총두께(0.102이하사용)</p></td>
											<td><p>⑪ 버니어,M.M</p></td>								
											<td><select id="inspctItem5Dtl3" class="custom-select"></select></td>				
										</tr>
										<tr>
											<th style="width:10px;">6</th>
											<td><p>설정조건</p></td>		
											<td><p>최적 조건<br/>(시간,온도,압력)</p></td>	
											<td><p>J.C 시 공유폴더 규격별 조건 폴더 참조</p></td>	
											<td><p>⑫ 육안</p></td>								
											<td><select id="inspctItem6Dtl1" class="custom-select"></select></td>				
										</tr>
										<tr>
											<th rowspan="2" style="width:10px;">7</th>
											<td rowspan="2"><p>필름공급부</p></td>		
											<td rowspan="2"><p>Suction 이상</p></td>	
											<td><p>기포발생 시 교체(상부)</p></td>	
											<td><p>⑬ 육안</p></td>								
											<td><select id="inspctItem7Dtl1" class="custom-select"></select></td>					
										</tr>
										<tr>								
											<td><p>기포발생 시 교체(하부)</p></td>	
											<td><p>⑭ 육안</p></td>								
											<td><select id="inspctItem7Dtl2" class="custom-select"></select></td>				
										</tr>
										<tr>
											<th rowspan="4" style="width:10px;">8</th>	
											<td rowspan="4"><p>이물질 혼입 방지</p></td>	
											<td rowspan="4"><p>Air 실린더</p></td>																											
											<td><p>1차 Metal(상부)</p></td>
											<td><p>⑮ 육안</p></td>	
											<td><select id="inspctItem8Dtl1" class="custom-select"></select></td>									
										</tr>							
										<tr>								
											<td><p>1차 Metal(하부)</p></td>
											<td><p>⑯ 육안</p></td>	
											<td><select id="inspctItem8Dtl2" class="custom-select"></select></td>				
										</tr>
										<tr>								
											<td><p>1차 Metal(상부)</p></td>
											<td><p>⑰ 육안</p></td>	
											<td><select id="inspctItem8Dtl3" class="custom-select"></select></td>				
										</tr>
										<tr>								
											<td><p>1차 Metal(하부)</p></td>
											<td><p>⑱ 육안</p></td>	
											<td><select id="inspctItem8Dtl4" class="custom-select"></select></td>				
										</tr>
									</table>							
									</form>					
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

	let menuAuth = 'emsc0030';
	let currentHref = 'emsc0030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","정기검사관리");

	var today =  "${serverDate}";
	var lastDay = "${lastDay}";	
	var equipCd = null;	
	var day = null;
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}	
	let sideView = 'add';
	var editAdd = 'add';
	var inspctRegDate="${serverDate}".replace(/-/g, '');
	var inspctMonth= "";
	
	//공통코드 처리 시작
	var inspctResultCode = new Array(); // 정기검사결과 그룹
    <c:forEach items="${inspctResult}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		inspctResultCode.push(json);
    </c:forEach>
    
    var equipGroupCode = new Array(); // 설비분류
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    $("#demo-2").val(today.substring(0,7));
    inspctMonth = $('#demo-2').val().replace(/-/g, '');
    selectBoxReset();
    uiProc(true);
    
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
        pageLength: 20,
        ajax: {
            url: '<c:url value="bm/equipCodeAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
            	'equipGroup' : function() { return equipGroup; }
            },
        },
        rowId: 'equipCd',
		columns: [
			{ data: 'equipCd' },
			{ data: 'equipNm' },
		],
		order: [
			[ 1, 'asc' ],
		],
	    //drawCallback: function( settings ) {
	    //	$('#equipCodeAdmTable tbody tr td').css('height','40px');
	    //}
    });

	$.fn.dataTable.ext.errMode = 'none';
	let calTable = $('#calTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        language: lang_kor,
        destroy:true,
        paging: false,
        info: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        scrollX: true,
        searching: false,   
        ajax: {
            url: '<c:url value="em/equipPrdcInspctDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
            	'equipCd'			:	function() { return equipCd; },   	        	
   	        	'inspctMonth'		 : function() { return inspctMonth; }            	
            },
        },
		columns: [
			{data : 'inspctDay',
				render: function(data, type, row, meta) {	
					return data + '일';										
    			}
			},
			{data : 'inspctItem1Dtl1Nm',
				render: function(data, type, row, meta) {		
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem1Dtl2Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem2Dtl1Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem2Dtl2Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem3Dtl1Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem3Dtl2Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem4Dtl1Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem4Dtl2Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem5Dtl1Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem5Dtl2Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem5Dtl3Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem6Dtl1Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem7Dtl1Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem7Dtl2Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem8Dtl1Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem8Dtl2Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem8Dtl3Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
			{data : 'inspctItem8Dtl4Nm',
				render: function(data, type, row, meta) {
					if(data != null){
						return  data.substring(0,1);
					}
					else {
						return data;
					}
    			}
			},
		],
		order: [
			[ 0, 'asc' ],
		],
	  columnDefs: [
           { targets: "_all", className: 'text-center' }         
        ]
    });        
    
 	var html1 =  ' <div class="row">&nbsp;<label class="input-label-sm">설비그룹</label><select class="custom-select" id="equipGroupCd" ></select></div>'; 	
    $('#equipCodeAdmTable_length').html(html1);
    selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");
    
    $("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});		
	 	equipCd = null;	 	
	 	$('#calTable').DataTable().ajax.reload();
	 	
	});   
    
    $("#demo-2").change(function() {
    	if( equipCd == null ){
			toastr.warning('설비명을 선택해주세요.');
			$("#demo-2").val(today.substring(0,7));
			return false;
		}
    	inspctMonth = $('#demo-2').val().replace(/-/g, '');
    	$('#btnSave').attr('disabled',true);	      	       	
	    $('#calTable').DataTable().ajax.reload(function() {});	 	
	 	
	});   
    
    $('#btnAdd').on('click',function(){
    	//if(sideView != 'edit') {
        //	toastr.warning("등록할 날짜를 선택해 주세요.");
        //    return false;
        //}
    	$('#btnSave').attr('disabled',false);
    	 editAdd='add';
    	 uiProc(false);
    	 selectBoxReset();
    	
    });
    
    $('#btnEdit').on('click',function(){
    	//if(sideView != 'edit') {
        //	toastr.warning("수정할 날짜를 선택해 주세요.");
        //    return false;
        //}
    	$('#btnSave').attr('disabled',false);
    	editAdd = 'edit';
    	uiProc(false);
    });
    
	

    $('#equipCodeAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {          
        }	
        else {
        	$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');           
            equipCd = equipCodeAdmTable.row( this ).data().equipCd;		
            inspctMonth = $('#demo-2').val().replace(/-/g, '');
            $('#btnSave').attr('disabled',true);
            $('#btnAdd').attr('disabled',false);
			$('#btnEdit').attr('disabled',false);
			$('#equipDowntimeAdmTable tbody tr').removeClass('selected');
			$('#calTable').DataTable().ajax.reload(function() {});
			uiProc(true);
			selectBoxReset();
			sideView = 'add';		
        }       
    });
	

	$('#calTable tbody').on('click', 'tr', function () {
		if( equipCd == null ){
			toastr.warning('설비명을 선택해주세요.');
			return false;
		}
		else{
			if ( $(this).hasClass('tableSelected') ) {
			
			}
	        else {			
	        	$('#calTable').DataTable().$('tr.selected').removeClass('selected');
	            $(this).addClass('selected');
				$('#btnSave').attr('disabled',true);		
				uiProc(true);
				day = $('#calTable').DataTable().row(this).index()+1;

				$.ajax({
					url: '<c:url value="em/equipPrdcInspctAdmDataList"/>',
		   	        type: 'GET',
		   	        data: {
		   	        	'menuAuth'	 : menuAuth,
		   	        	'equipCd'			:	function() { return equipCd; },
		   	        	'inspctRegDate'		:	$('#demo-2').val().replace(/-/g, ''),
		   	        	'inspctDay'			:   function() { return parseInt(day); },			   	        	
		   	        },
		   	        success: function (res) {
		   	        	var data = res.data;		   	        	
		   	        	sideView = 'edit';
		   	        	if(data != null){		   	     
		   	        		$('#btnEdit').attr('disabled',false);
		   	        		$('#btnAdd').attr('disabled',true);
		   	        		$("#inspctItem1Dtl1").val(data.inspctItem1Dtl1);
		   	        		$("#inspctItem1Dtl2").val(data.inspctItem1Dtl2);
		   	        		$("#inspctItem2Dtl1").val(data.inspctItem2Dtl1);
		   	        		$("#inspctItem2Dtl2").val(data.inspctItem2Dtl2);
		   	        		$("#inspctItem3Dtl1").val(data.inspctItem3Dtl1);
		   	        		$("#inspctItem3Dtl2").val(data.inspctItem3Dtl2);
		   	        		$("#inspctItem4Dtl1").val(data.inspctItem4Dtl1);
		   	        		$("#inspctItem4Dtl2").val(data.inspctItem4Dtl2);
		   	        		$("#inspctItem5Dtl1").val(data.inspctItem5Dtl1);
		   	        		$("#inspctItem5Dtl2").val(data.inspctItem5Dtl2);
		   	        		$("#inspctItem5Dtl3").val(data.inspctItem5Dtl3);
		   	        		$("#inspctItem6Dtl1").val(data.inspctItem6Dtl1);
		   	        		$("#inspctItem7Dtl1").val(data.inspctItem7Dtl1);
		   	        		$("#inspctItem7Dtl2").val(data.inspctItem7Dtl2);
		   	        		$("#inspctItem8Dtl1").val(data.inspctItem8Dtl1);
		   	        		$("#inspctItem8Dtl2").val(data.inspctItem8Dtl2);
		   	        		$("#inspctItem8Dtl3").val(data.inspctItem8Dtl3);
		   	        		$("#inspctItem8Dtl4").val(data.inspctItem8Dtl4);		   	        		
		   	        	}else{
		   	        		$('#btnEdit').attr('disabled',true);
		   	        		$('#btnAdd').attr('disabled',false);		   	        		
		   	        		selectBoxReset();
		   	        	}
		   	        }
				});
			}
		}
	});	
	
	
	$('#btnSave').on('click', function(){
		
		var url;
		if(editAdd == 'add'){
			url =  '<c:url value="em/equipPrdcInspctAdmCreate"/>';
		} else{
			url =  '<c:url value="em/equipPrdcInspctAdmUpdate"/>';
		}
			
	    $.ajax({
    	    	url: url,
    	        type: 'POST',
    	        data: {
    	        	'menuAuth'	 : menuAuth,
    	        	'equipCd'			:	function() { return equipCd; },
    	        	'inspctRegDate'		:	$('#demo-2').val().replace(/-/g, ''),
	   	        	'inspctDay'			:   function() { return parseInt(day); },
	   	        	'inspctMonth'		:	$('#demo-2').val().replace(/-/g, ''),
    	        	'inspctItem1Dtl1'	:	$("#inspctItem1Dtl1 option:selected").val(),
    	        	'inspctItem1Dtl2'	:   $("#inspctItem1Dtl2 option:selected").val(),
    	        	'inspctItem2Dtl1'	:   $("#inspctItem2Dtl1 option:selected").val(),
    	        	'inspctItem2Dtl2'	:	$("#inspctItem2Dtl2 option:selected").val(),
   	        		'inspctItem3Dtl1'	:	$("#inspctItem3Dtl1 option:selected").val(),
        			'inspctItem3Dtl2'	:	$("#inspctItem3Dtl2 option:selected").val(),
    	        	'inspctItem4Dtl1'	:   $("#inspctItem4Dtl1 option:selected").val(),
    	        	'inspctItem4Dtl2'	:   $("#inspctItem4Dtl2 option:selected").val(),
    	        	'inspctItem5Dtl1'	:   $("#inspctItem5Dtl1 option:selected").val(),
    	        	'inspctItem5Dtl2'	:   $("#inspctItem5Dtl2 option:selected").val(),
    	        	'inspctItem5Dtl3'	:   $("#inspctItem5Dtl3 option:selected").val(),
    	        	'inspctItem6Dtl1'	:   $("#inspctItem6Dtl1 option:selected").val(),
    	        	'inspctItem7Dtl1'	:   $("#inspctItem7Dtl1 option:selected").val(),
    	        	'inspctItem7Dtl2'	:   $("#inspctItem7Dtl2 option:selected").val(),
    	        	'inspctItem8Dtl1'	:   $("#inspctItem8Dtl1 option:selected").val(),
    	        	'inspctItem8Dtl2'	:   $("#inspctItem8Dtl2 option:selected").val(),
    	        	'inspctItem8Dtl3'	:   $("#inspctItem8Dtl3 option:selected").val(),
    	        	'inspctItem8Dtl4'	:   $("#inspctItem8Dtl4 option:selected").val(),

    	      
    	        },
    	        success: function (res) {
    	            var data = res.data;
    	       		if(res.result == "ok"){
    	       			toastr.success("저장되었습니다.");
    	       			$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
    	       			$('#equipDowntimeAdmTable tbody tr').removeClass('tableSelected');	    	       			
    	       			$('#calTable').DataTable().ajax.reload(function() {});
    	       			uiProc(true);
    	       			$('#btnSave').attr('disabled',true);
    	       			
    	       		} else{
    	       			toastr.warning("저장에 실패했습니다.");
    	       			uiProc(true);
    	       			$('#btnSave').attr('disabled',true);
    	       		}
    	        }
          });		
	});
	

	$('#demo-2').monthpicker({pattern: 'yyyy-mm', 
	    selectedYear: 2020,
	    startYear: 1900,
	    finalYear: 2212
	    });		
	
	
	function uiProc(flag){
		  $('#inspctItem1Dtl1').attr('disabled', flag);
		  $('#inspctItem1Dtl2').attr('disabled', flag);
		  $('#inspctItem2Dtl1').attr('disabled', flag);
		  $('#inspctItem2Dtl2').attr('disabled', flag);
		  $('#inspctItem3Dtl1').attr('disabled', flag);
		  $('#inspctItem3Dtl2').attr('disabled', flag);
		  $('#inspctItem4Dtl1').attr('disabled', flag);
		  $('#inspctItem4Dtl2').attr('disabled', flag);
		  $('#inspctItem5Dtl1').attr('disabled', flag);
		  $('#inspctItem5Dtl2').attr('disabled', flag);
		  $('#inspctItem5Dtl3').attr('disabled', flag);
		  $('#inspctItem6Dtl1').attr('disabled', flag);
		  $('#inspctItem7Dtl1').attr('disabled', flag);
		  $('#inspctItem7Dtl2').attr('disabled', flag);
		  $('#inspctItem8Dtl1').attr('disabled', flag);
		  $('#inspctItem8Dtl2').attr('disabled', flag);
		  $('#inspctItem8Dtl3').attr('disabled', flag);
		  $('#inspctItem8Dtl4').attr('disabled', flag);
	}
	
	function selectBoxReset(){
		selectBoxAppend(inspctResultCode, "inspctItem1Dtl1", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem1Dtl2", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem2Dtl1", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem2Dtl2", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem3Dtl1", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem3Dtl2", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem4Dtl1", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem4Dtl2", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem5Dtl1", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem5Dtl2", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem5Dtl3", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem6Dtl1", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem7Dtl1", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem7Dtl2", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem8Dtl1", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem8Dtl2", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem8Dtl3", "001", "");
	    selectBoxAppend(inspctResultCode, "inspctItem8Dtl4", "001", "");	
	}
	
	//콤마 제거
	function commaDelete(data){
		var result=data;
		if(data != null){
			//console.log(data.slice(0, -1));
			for(var i=1; i < data.length+1; i++){
				if(data.substring(data.length-i,data.length-i+1) == ','){
					result = data.slice(0, -i);
				}
				else{
					break;
				}
			}
		}					
		return  result;
	}
	
	
	

</script>
</body>
</html>
