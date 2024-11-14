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
                <li class="breadcrumb-item">
                  <a href="#">시스템관리</a>
                </li>
                <li class="breadcrumb-item active">사용자권한관리 </li>
               </ol>
              </nav>
             </header> 
          <!-- #main============================================================== -->
		<div class="container-fluid" id="main">
    	<div class="row table-wrap-hid">	
    	   <!--======================== .left-list ========================-->
   			<div class="left-list left-30" id="left-30" style="width:30%;">
            	<div class="card">                  
	                <div class="table-responsive" id="userDiv">
	                	<table id="userTable" class="table table-bordered" style="text-align:center">
	                        <thead class="thead-light">
		                        <tr>
		                       	  <th> ID		 </th>	
		                       	  <th> 사용자이름	</th>
		                       	  <th> 부서명		 </th>                                            
	                              <th> 직위 		</th>                         
	                            </tr>
	                        </thead>
	                    </table>
	                </div>
	            </div>
	        </div>
	        <!-- /.page-section -->	  	
	    	<!-- 사이드 페이지 -->
			<div class="right-list right-70" style="width:39%;">
	        	<div class="card" id="formBox">  
					<div id="menuTree" >
					</div>
					<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button type="button" class="btn btn-primary d-none float-right" id="btnDelete" style="margin-right: 5px;">초기화</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled> </button>					
					</div>
				</div>
			</div>
		</div>	
	</div>
</div>

<!-- 권한 리스트목록 보기 -->
<div class="modal fade bd-example-modal-lg" id="userPopUpListModal" tabindex="-1" role="dialog" aria-labelledby="userAuthPopUpModalLabel" aria-hidden="true">
	<div class="row">
	   <div class="modal-dialog modal-lg">
	      <div class="modal-content" style="width: 100%; margin-left: 10%; margin-top: 0%;" id="userListPopUpContent">
	         <div class="modal-header" style="padding-bottom:0px;">
	            <h5 class="modal-title" id="userlistPopUpLabel">권한 목록 조회</h5>
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	               <span aria-hidden="true">&times;</span>
	            </button>
	         </div>
	         <div class="modal-body">
	            <hr class="text-secondary">
	            <table id="userPopUpListTable" class="table table-bordered" style="padding-bottom: 0px; width: 60vh;">
	               <thead class="thead-light">
	                  <tr>
	                     <th>성명</th>
	                     <th>부서</th>
	                     <th>직위</th>
	                     <th>권한명</th>
	                  </tr>
	               </thead>
	            </table>
	            <hr class="text-secondary">
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	         </div>
	      </div>
	   </div>
	
		<!-- 선택 유저 권한 조회이기는 하나 사용 X -->
		<div class="modal-dialog modal-lg" style="width: 85vh; display: none;" id="userAuthModal">
			<div class="modal-content" style="width: 60%; margin-top: 20%;" id="userAuthContent">
				<div class="modal-header">
					<h5 class="modal-title" id="">권한 정보 목록</h5>
						<label style="font-size: 22px;font-weight: 300;line-height: 30px; margin-left: 20px;" id="workerHistoryLabel"></label> 
				
				</div>
				
				 <div class="modal-body">
				 	<!-- 이전 작업자테이블 조회 -->
				 	<table class="table table-sm table-bordered" id="userAuthPopUpTable">
				 		<thead>
				 			<tr>
				 				<th>성명</th>
				 				<th>부서</th>
				 				<th>직위</th>
				 				<th>권한명</th>
				 			</tr>
				 		</thead>
				 	</table>	
				 	<!-- 이전 작업자테이블 조회 -->
				 </div>
				 <hr>
			</div>
		</div>
		<!-- 이전 작업자 조회 끝 -->

	</div>
</div>
	

<%@include file="../layout/bottom.jsp" %>

<script>   
    		
	let menuAuth = 'smsc0050';
	let currentHref = 'smsc0050';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","사용자권한관리");
	
	//공통코드 처리 시작
	let userAuthMainCategory = new Array(); // 사용자권한 대분류
	<c:forEach items="${userAuthMainCategory}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	userAuthMainCategory.push(json);
	</c:forEach>

	let userAuthSubCategory = new Array(); // 사용자권한 소분류
	<c:forEach items="${userAuthSubCategory}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	userAuthSubCategory.push(json);
	</c:forEach>
	
	var userNumber = 'kkkk';
	var departmentCd = 'kkk';
    
    $(document).ready(function (){
    	 $.ajax({
    	 		url: '<c:url value="/sm/authDataList"/>',
    	  	 	type: 'POST',
    	   		data: {
    	   			'menuAuth'	 	: 		menuAuth,
    	   		},
    			success: function(result){
    				if( result.result == "ok" ){
        	      		$('#menuTree').jstree({
        	      			core : { data: menuSelect(result)},
        	      			checkbox : {
        	      				"keep_selected_style" : false
        	      			},
        	      			plugins : ["themes", "html_data", "checkbox" ]
        	      		});
        			} else {
            			toastr.error(result.message, '', {timeOut: 5000});
            		}
    	  		}
    		});    		
    });

	// 사용자목록
    let userTable = $('#userTable').DataTable({
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange : true,
        pageLength: 20,
        ajax : {
			url : '<c:url value="/sm/matrlUserDataList"/>',
			type : 'GET',
			data : {
				'menuAuth'	: 	menuAuth,
			},
	
		},
        columns: [
           	{ data: 'userId' },
            { data: 'userNm' },            
            { data: 'departmentNm'},
            { data: 'postNm'}
            
           
        ],        
        order: [
            [ 0, 'asc' ]
        ],       
        buttons: [
            'copy', 'excel', 'pdf'
        ],
        drawCallback: function () {
          $('input[type=search]').attr("style","width:150px");
        },
    });
    let html1 = '<div class="row">';
	html1 += '<button type="button" class="btn btn-primary float-right ml-2" id="btnUserAuthList">사용자 권한 목록 보기</button>';
	html1 += '</div>';
	$('#userTable_length').html(html1);
	// 사용자목록 상세 정보 보기
	$('#userTable tbody').on('click', 'tr', function () {		
        if ( $(this).hasClass('selected') ) { //select취소될때.
            $(this).removeClass('selected');
            $('#btnSave').addClass('d-none');
            $('#btnDelete').addClass('d-none');
            $ ('#menuTree').jstree("uncheck_node", $('#menuTree').jstree("get_checked",true));
           
        }
        else { //select될때
        	$('#userTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            $ ('#menuTree').jstree("uncheck_node", $('#menuTree').jstree("get_checked",true));
          
            departmentCd = 'kkk';
            userNumber = userTable.row('.selected').data().userNumber;
   		    $('#btnSave').removeClass('d-none');
   			$('#btnDelete').removeClass('d-none');
			$.ajax({
		     		url: '<c:url value="/sm/authDataList"/>',
		      	 	type: 'POST',
		       		data: {
		       			'menuAuth'	: 	menuAuth,
		       			//'departmentCd' : function(){return departmentCd;},
		       			'userNumber' : function(){return userNumber;}
		       		},
		    		success: function(result){
	    				if( result.result == "ok" ){
				      		$('#menuTree').jstree({
				      			core : { data: menuSelect(result)},
				      			checkbox : {
				      				"keep_selected_style" : false
				      			},
				      			plugins : ["themes", "html_data", "checkbox" ]
				      		});
				      		$.each(result.check, function(idx, item){
				      			
				      			$('#menuTree').jstree('select_node', item.userAuthCode);
				      			//console.log(item.menuId);
				    		});
	        			} else {
	            			toastr.error(result.message);
	        			}
		      		}
		    });
        }
   	});
   	
	$('#btnSave').on('click',function(){ //저장 버튼 클릭시
		var baseCd = new Array();		
		var baseCdNm = new Array();		
		var dataArray = new Array();		
		$('#my-spinner').show();
		$.each($("#menuTree").jstree("get_checked",true),function(index){
			//console.log($('#menuTree').jstree(true).get_parent(this));
				
			var rowData = new Object();
			baseCd[index] = this.id;	
			rowData.baseCd = baseCd[index];
			
			baseCdNm[index] = this.text;
			rowData.baseCdNm = baseCdNm[index];
			
			//rowData.departmentCd = departmentCd;
			rowData.userNumber = userNumber;
			//rowData.useYnCd = 'Y';
			
			
			dataArray.push(rowData);
		});	
		//console.log(dataArray);
		$.ajax({		    	
	        url: '<c:url value="/sm/userAuthSave"/>',
	        type: 'POST',
	        datatype: 'json',
	        data: JSON.stringify(dataArray),
	        contentType : "application/json; charset=UTF-8",
	        success: function(result){
	        	if(result.result == "ok"){
	        		$('#my-spinner').hide();
	        		toastr.success('저장 되었습니다.');       		
	        	}
	        	else{
	        		$('#my-spinner').hide();
	        		toastr.error(result.message, '', {timeOut: 5000});
	        	}
	        	
	        }
		});	   	
	});	
	
	$('#btnDelete').on('click',function(){ //삭제 버튼 클릭시			
		$.ajax({		    	
	        url: '<c:url value="/sm/deleteUserAuth"/>',
	        type: 'POST',
	        datatype: 'json',
	        data: {
	        	'menuAuth'	: 	menuAuth,		        	
	        	'userNumber' : userTable.row('.selected').data().userNumber
	        },
	        success: function(result){
	        	if(result.result == "ok"){	        		
	        		$('#menuTree').jstree("uncheck_node", $('#menuTree').jstree("get_checked",true));	      			
	     			toastr.success('초기화 되었습니다.');
	        	}
	        	else{
	        		toastr.error(result.message);
	        	}
	        }
		});	 

	});	
    let userPopUpListTable = null;
    let userAuthPopUpTable = null;
	let authUserNumber = null;
    let userAuthCode = null;
	//유저권한 리스트
	$('#btnUserAuthList').on('click',function(){		
		userAuthCode = '';
		$('#userAuthModal').attr('style','width: 85vh; display: none;');
		$('#userListPopUpContent').attr('style','width: 100%; margin-left: 10%; margin-top: 0%;');
		if(userPopUpListTable == null || userPopUpListTable == undefined)	{
			userPopUpListTable = $('#userPopUpListTable').DataTable({
				dom: "<'row'<'col-sm-12 col-md-7'l><'col-sm-12 col-md-3'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B", 
				
		        language: lang_kor,
		        lengthChange: true,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        pageLength: 20,
		        ajax: {
		            url: '<c:url value="/sm/userAuthList"/>',
		            type: 'GET',
		            data: {
			            'userAuthCode' : function(){ return userAuthCode;},
		            },
		        },
		        rowId: '',
		        columns: [
		        	{ data : 'userName'		}, 
					{ data : 'departmentNm'		},
					{ data : 'spot'	}, 
					{ data : 'userAuthCodeName' },
		        ],
		        columnDefs: [
		        	{ "targets": [0,1,2,3],  "className": "text-center"}
		        ],
		        order: [	
		            [ 0, 'asc' ]
		        ],
		        buttons: [],
		    });
		} else{
			$('#userPopUpListTable').DataTable().ajax.reload();
		}
		$('#userPopUpListModal').modal('show');	
		let html2 = '';
		html2 += '<label class="input-label-sm ml-2 mr-2">권한명</label>';
		html2 += '<select class="custom-select custom-select-sm" id="qutyCd" style="min-width:150px;">';
		html2 += '<option value=>전체</option>';
		for (var i=0; i<userAuthSubCategory.length; i++) {
			html2 += '<option value="'+userAuthSubCategory[i].baseCd +'">'+userAuthSubCategory[i].baseCdNm+'</option>';
		}
		html2 += '</select>';
		html2 += '<button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button>';
		$('#userPopUpListTable_length').html(html2);
		
		$('#qutyCd').change(function(){
	   		userAuthCode = $('#qutyCd').val();
		});
		$('#btnRetv').on('click',function(){
  		 	$('#userPopUpListTable').DataTable().ajax.reload();
		});
	});
	
	
	function menuSelect(result){
		 
		var parentData = new Array();
		var childData = new Array();
		var data = new Array();
		var index=0;
		$.each(result.parent, function(idx, item){
			parentData[idx] = {id:item.baseCd, parent: '#', text:item.baseCdNm, state: {
	            opened: false,
	            selected: false
	        }};	
			data[index] = parentData[idx];
			index++;			
		});
		$.each(result.child, function(idx, item){
			childData[idx] = {id:item.baseCd, parent: item.etc1, text:item.baseCdNm};		
			data[index] = childData[idx];			
			index++;
		});		
		
		//console.log(data);
		
		return data;
	}
	
	

// 	function selectBoxAppend(obj, id, sVal, flag)
// 	{
// 		$('#'+ id).empty();

// 		if(flag=='1') {
// 			$('#'+ id).append($("<option>"+ "전체" +"</option>"));
// 	   	} else if(flag=='2') {
// 	   		$('#'+ id).append($("<option>"+ "선택" +"</option>"));
// 	   	}
	   		
// 		for(key in obj) {
// 			var option;
// 			if(obj[key].baseCd == sVal ) {
// 				option = $("<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>");
// 			} else {
// 				option = $("<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>");
// 			}	
// 			$('#'+ id).append(option);
// 		}

// 	}
   	   	
   	
   	
</script>

</body>
</html>
