<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">

	<!-- 저장 확인 모달(공통) 시작-->
	<div class="modal fade" id="menuChangeWayModal" tabindex="-1" role="dialog" aria-labelledby="menuChangeWayModalLabel" aria-hidden="true">
		<div class="modal-dialog">
	   		<div class="modal-content" style="width: 80vh;">
	     		<div class="modal-header">
	        		<h5 class="modal-title" id="menuChangeWayModalLabel">메뉴 순서 변경 방법</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">&times;</span>
			        </button>
	      		</div>
	      		<br>
			    <div class="modal-body">
<!-- 					<h6 id="menuChangeWayModal_h6">상위 메뉴들의 순서를 변경하시겠습니까?</h6> -->
			      	<div style="display: flex;flex-wrap: nowrap;">
				      	<table class="table table-bordered mr-2">
				      		<thead>
				      			<tr>
				      				<th>메뉴 ID</th>
				      				<th>메뉴명</th>
				      			</tr>
				      		</thead>
				      		<tbody>
				      			<tr style="background-color: #0275d8; color: white;">
				      				<td class="text-center" style="border: 4px solid red;">M00200</td>
				      				<td class="text-center">경영정보관리</td>
				      			</tr>
				      			<tr>
				      				<td class="text-center">M00210</td>
				      				<td class="text-center">영업관리</td>
				      			</tr>
				      		</tbody>
				      	</table>
				      	
				      	<label style="display: flex;align-items: center;font-size: 25px;"> → </label>
				      	
				      	<table class="table table-bordered ml-2">
				      		<thead>
				      			<tr>
				      				<th>메뉴 ID</th>
				      				<th>메뉴명</th>
				      			</tr>
				      		</thead>
				      		<tbody>
				      			<tr>
				      				<td class="text-center">M00210</td>
				      				<td class="text-center">영업관리</td>
				      			</tr>
				      			<tr style="background-color: #0275d8; color: white;">
				      				<td class="text-center" style="border: 4px solid red;">M00200</td>
				      				<td class="text-center">경영정보관리</td>
				      			</tr>
				      		</tbody>
				      	</table>
			      	</div>
			      	
			      	<div style="display: flex;flex-direction: column;">
				      	<label style="font-size: 14px;">- 빨간색(메뉴 ID)부분을 잡고 원하는 위치로 드래그 해 이동하세요.</label>
				      	<label style="font-size: 14px;">- 상위 메뉴, 하위 메뉴 모두 동일하게 적용됩니다.</label>
			      		<label class="mt-2" style="color: red;">* 변경되고 저장된 데이터는 복원할 수 없습니다.</label>
			      	</div>
			      	
				</div>
	      		<div class="modal-footer">
			      	<button type="button" class="btn btn btn-secondary" data-dismiss="modal" style="min-width:70px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 저장 확인 모달(공통) 종료 -->

	<!-- 저장 확인 모달(공통) 시작-->
	<div class="modal fade" id="menuIndexChangeModal" tabindex="-1" role="dialog" aria-labelledby="menuIndexChangeModalLabel" aria-hidden="true">
		<div class="modal-dialog">
	   		<div class="modal-content">
	     		<div class="modal-header">
	        		<h5 class="modal-title" id="menuIndexChangeModalLabel">메뉴 순서 저장 확인</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">&times;</span>
			        </button>
	      		</div>
	      		<br>
			    <div class="modal-body">
					<h6 id="menuIndexChangeModal_h6">상위 메뉴들의 순서를 변경하시겠습니까?</h6>
			      	<p>경고! 변경한 데이터는 복구 할 수 없습니다!</p>
				</div>
	      		<div class="modal-footer">
			      	<button type="button" class="btn btn-primary" id="btnMenuIndexChangeSave" data-dismiss="modal" style="min-width:70px;">변경</button>
			      	<button type="button" class="btn btn btn-secondary" id="btnmenuIndexChangeCancel" data-dismiss="modal" style="min-width:70px;">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 저장 확인 모달(공통) 종료 -->

	<!-- Modal Start-->
	<div class="modal fade" id="layerPopUpModal" tabindex="-1"
		role="dialog" aria-labelledby="layerPopUpLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="layerPopUpLabel">사용자 메뉴 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<hr class="text-secondary">
					<table class="table table-sm table-bordered" id="layerPopUpTable" style="text-align: center">
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
                <li class="breadcrumb-item">
                  <a href="#">시스템관리</a>
                </li>
                <li class="breadcrumb-item active">메뉴관리</li>
               </ol>
              </nav>
             </header> 
    
	<div class="container-fluid" id="main">
    	<div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
   			<div class="left-list left-30" id="left-30" style="width:25%;">
            	<div class="card">                  
                	<div class="table-responsive">
	                	<table id="upperMenuTable" class="table table-bordered" style="text-align:center">
	                        <thead class="thead-light">
		                        <tr>
		                          <th style="max-width:100px;">IDX</th> 
	                              <th style="max-width:100px;">메뉴ID</th> 
	                              <th style="max-width:100px;">메뉴명 </th>                            
	                            </tr>
	                        </thead>
	                    </table>
	                </div>
	            </div>
	        </div>
	        <!-- /.page-section -->
	  	
	    <!-- 사이드 페이지 -->
			<div class="right-list right-70" id="myrSidenav" style="width:74%;">
	        	<div class="card" id="formBox">  
					<div class="table-responsive">
				    	<table id="subMenuTable" class="table table-bordered" style="text-align:center">
							<thead class="thead-light">
								<tr>
									<th> IDX </th>
								    <th> 메뉴ID </th> 
								    <th> 상위메뉴 </th> 
								    <th> 메뉴명 </th>
								    <th> 메뉴경로</th>   									    
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

<script>   

	let menuAuth = 'smsc0020';
	let currentHref = 'smsc0020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","메뉴관리");
	   
    // 상위목록
    $.fn.dataTable.ext.errMode = 'none';
	let upperMenuTable = $('#upperMenuTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        pageLength: 20,
        'ajax': {
            url: '<c:url value="/sm/menuInfoDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },        
        columns: [
        	{ data: 'idx' 	 },
            { data: 'menuId' },
            { data: 'menuNm' }
        ],        
        order: [
            [ 0, 'asc' ]
        ],       
        rowReorder: {
            dataSrc: 'idx'
        },
        "columnDefs": [
            { "visible": false, "targets": 0 }
         ],
        buttons: [
            'copy', 'excel', 'pdf'
        ],
    });
    
    var htmlMenu  = '<button class="btn btn-primary float-left mr-2" type="button" id="upperMenuAdd">등록';
    	htmlMenu += '</button>&nbsp;<button class="btn btn-primary float-left mr-2" type="button" id="upperMenuEdit">수정</button>';
    	htmlMenu += '</button>&nbsp;<button class="btn btn-primary float-left mr-2" type="button" id="upperMenuSave" onClick="menuIndexCheck('+"upperMenuTable"+')">저장</button>';
	$('#upperMenuTable_length').html(htmlMenu);
	$('#upperMenuTable_filter').html('<label>검색 : <input type="search" class="form-control form-control-sm" placeholder="" aria-controls="systemCommonGroupCd" style="width:110px"> </label>');
	
	 // 하위목록    
     var menuId= "0";     

	$.fn.dataTable.ext.errMode = 'none';
 	let subMenuTable = $('#subMenuTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        pageLength: 20,
   	    'ajax': {
			url: '<c:url value="/sm/subMenuInfoDataList"/>',
			type: 'GET',
			data: {
				'menuAuth'	 	: 		menuAuth,
				'menuId': function() { return menuId; },
			}
		},        
		columns: [
			{ data: 'idx'			},
			{ data: 'menuId'		},
			{ data: 'upperMenuId'	}, 
			{ data: 'menuNm'		},
			{ data: 'menuPath'		}  
		],        
		order: [
			[ 0, 'asc' ]
		],
   	    rowReorder: {
            dataSrc: 'idx'
        },
        "columnDefs": [
            { "visible": false, "targets": 0 }
		],
	});
   
	
    var htmlSubMenu  = '<button class="btn btn-primary float-left mr-2" type="button" id="subMenuAdd">등록';
    	htmlSubMenu += '</button>&nbsp;<button class="btn btn-primary float-left mr-2" type="button" id="subMenuEdit">수정</button>';
    	htmlSubMenu += '</button>&nbsp;<button class="btn btn-primary float-left mr-2" type="button" id="menuChangeWay">순서 변경 방법</button>';
    	htmlSubMenu += '</button>&nbsp;<button class="btn btn-primary float-left mr-2" type="button" id="subMenuSave" onClick="menuIndexCheck('+"subMenuTable"+')">서브 저장</button>';
	$('#subMenuTable_length').html(htmlSubMenu);
	

	//상위메뉴 등록버튼
   	$('#upperMenuAdd').click(function () {
   		addHtml("upperMenuAdd", "");   		
   		seq();
   		$('#puUpperMenuNm').val();
   		$('#layerPopUpLabel').text('메인메뉴 등록');
   		$('#layerPopUpModal').modal('show');

   	});

	//상위메뉴 수정버튼
   	$('#upperMenuEdit').click(function () {
   		var data = upperMenuTable.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("수정할 메뉴를 선택해 주세요.");
   		} else {
	   		addHtml("upperMenuEdit", data);
	   		$('#puUpperMenuId').val(data.menuId);	
	   		$('#puUpperMenuNm').val(data.menuNm);	   	 
	   		$('#layerPopUpLabel').text('메인메뉴 수정');
	   		$('#layerPopUpModal').modal('show');
   	   	}
   	});  
   	
   //하위메뉴 등록버튼
	$('#subMenuAdd').click(function () {
   		var data = upperMenuTable.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("등록할 메뉴목록를 선택해 주세요.");
   		} else {   		
   			
	   		addHtml("subMenuAdd");	   		
	   		seq();	
	   		$('#puSubUpperMenuId').val(data.menuId);	   		   		
	   		
	   		$('#layerPopUpLabel').text('메뉴등록');
	   		$('#layerPopUpModal').modal('show');
   		}
   	});
   
	//하위메뉴 수정버튼
   	$('#subMenuEdit').click(function () {
   		var dataGrp = upperMenuTable.row('.selected').data();
   		if(dataGrp == null || dataGrp == undefined ) {
   			toastr.warning("수정할 메인 메뉴을 선택해 주세요.");
   			return;
   		}    		
   		var data = subMenuTable.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("수정할  서브 메뉴을 선택해 주세요.");
   		} else {
   	   		  	   		   	   	
	   		addHtml("subMenuEdit");
   	   		$('#puSubMenuId').val(data.menuId);
	   		$('#puSubUpperMenuId').val(data.upperMenuId);
	   		$('#puSubMenuNm').val(data.menuNm);
	   		$('#puSubMenuPath').val(data.menuPath);	    		
	   				
	   		$('#layerPopUpLabel').text('메뉴수정');
	   		$('#layerPopUpModal').modal('show');
   		}	
   	});   	
   	  	
   	//저장버튼 클릭시
	$('#layerPopUpSave').click(function () {
   	   	var puFlag = $('#puFlag').val();

   	   	if(puFlag == "upperMenuAdd" || puFlag == "upperMenuEdit") {
   	   		upperMenuProc(puFlag);
   	   	} else {
   	   		subMenuProc(puFlag);
   	   	}
   		//$('#layerPopUpModal').modal('hide');
   	}); 
   	
	
	
	// 메인메뉴 상세 정보 보기
	$('#upperMenuTable tbody').on('click', 'tr', function () {

        if ( $(this).hasClass('selected') ) {
//             $(this).removeClass('selected');
        }
        else {
        	$('#upperMenuTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        		
        menuId = upperMenuTable.row( this ).data().menuId;
// 	    console.log("menuId = " + menuId);
   		$('#subMenuTable').DataTable().ajax.reload( function () {});
   	});
       

	// 서브메뉴 선택
	$('#subMenuTable tbody').on('click', 'tr', function () {

        if ( $(this).hasClass('selected') ) {
//             $(this).removeClass('selected');
        }
        else {
        	$('#subMenuTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
   	});
	
	
  //메인메뉴 등록
	function upperMenuProc(puFlag)
	{
	    if ( !$.trim($('#puUpperMenuId').val()) ) {
	        toastr.warning('메뉴ID를 입력해 주세요.');
	        $('#puUpperMenuId').focus();
	        return false;
	    }
	
	    if ( !$.trim($('#puUpperMenuNm').val()) ) {
	        toastr.warning('메뉴명을 입력해 주세요.');
	        $('#puUpperMenuNm').focus();
	        return false;
	    }	
	    
	    var upperMenuURL = "";
	    var upperMenuMsg = "";
	    if(puFlag == "upperMenuAdd") {
	    	upperMenuURL = '<c:url value="/sm/menuInfoCreate"/>';	    	
	    	upperMenuMsg = '메인메뉴가 등록 되었습니다.';	    
	    } else {
	    	upperMenuURL = '<c:url value="/sm/menuInfoUpdate"/>';
	    	upperMenuMsg = '메인메뉴가 수정 되었습니다.';
	    }
	    
	    $.ajax({
	        url: upperMenuURL,
	        type: 'POST',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	            'menuId': $('#puUpperMenuId').val(),
	            'menuNm': $('#puUpperMenuNm').val(),	            
	            'regId': 'reg_id',
	            'updId': 'upd_id'
	        },
	        beforeSend: function() {
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
	            	toastr.success(upperMenuMsg);
		            $('#upperMenuTable').DataTable().ajax.reload(); //등록 후 테이블 리로드	            	
	            	$('#layerPopUpModal').modal('hide');
	            } else {
	            	toastr.error(res.message, '', {timeOut: 5000});
	            }
	        },
	        complete:function(){

	        }
	    });
	}

	//서브메뉴 등록,수정
	function subMenuProc(puFlag)
	{
	    if ( !$.trim($('#puSubMenuId').val()) ) {
	        toastr.warning('메뉴ID를 확인해 주세요.');
	        $('#puSubMenuId').focus();
	        return false;
	    }

	    if ( !$.trim($('#puSubUpperMenuId').val()) ) {
	        toastr.warning('상위메뉴를 입력해 주세요.');
	        $('#puSubUpperMenuId').focus();
	        return false;
	    }
	    		
	    if ( !$.trim($('#puSubMenuNm').val()) ) {
	        toastr.warning('메뉴명을 입력해 주세요.');
	        $('#puSubMenuNm').focus();
	        return false;
	    }
	    
	    if ( !$.trim($('#puSubMenuPath').val()) ) {
	        toastr.warning('메뉴경로를 입력해 주세요.');
	        $('#puSubMenuPath').focus();
	        return false;
	    }	
	  
	    
	    var subMenuURL;
	    var subMenuMsg;
	    if(puFlag == "subMenuAdd") {
	    	subMenuURL = '<c:url value="/sm/menuInfoCreate"/>';
	    	subMenuMsg = '서브메뉴가 등록 되었습니다.';	    	
	    } else {
	    	subMenuURL = '<c:url value="/sm/menuInfoUpdate"/>';
	    	subMenuMsg = '서브메뉴가 수정 되었습니다.';
	    }
	    $.ajax({
	        url: subMenuURL,
	        type: 'POST',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
				'menuId' 	  : $('#puSubMenuId').val(),
				'upperMenuId' : $('#puSubUpperMenuId').val(),
				'menuNm' 	  : $('#puSubMenuNm').val(),
				'menuPath' 	  : $('#puSubMenuPath').val(),
				'regId'		  : 'reg_id'
	        },
	        beforeSend: function() {
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
	            	toastr.success(subMenuMsg);
	            	$('#layerPopUpModal').modal('hide');
	            	$('#subMenuTable').DataTable().ajax.reload(); //등록 후 테이블 리로드
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
   	   	if(flag == "upperMenuAdd" || flag == "upperMenuEdit") { //upperMenu수정
			html = '<tr>';
			html += '<td class="align-middle" style="width: 80px">메뉴ID</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puUpperMenuId"  name="puMenuId" disabled></td>';	
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle"  style="width: 80px">*메뉴명</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puUpperMenuNm"  name="puMenuNm"></td>';
			html += '</tr>';					
			$('#layerPopUpTable').html(html);
			$('#puFlag').val(flag);
   	   	} else { // subMenu수정
			html = '<tr>';
			html += '<td class="align-middle" style="width: 80px">메뉴ID</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puSubMenuId"  name="puSubMenuId" disabled></td>';	
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">상위메뉴</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puSubUpperMenuId"  name="puSubUpperMenuId" disabled></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">*메뉴명</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puSubMenuNm"  name="puSubMenuNm"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">*메뉴경로</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puSubMenuPath"  name="puSubMenuPath"></td>';			
			html += '<input type="hidden" id="puSubUpperMenuId"  name="puSubUpperMenuId">';
			html += '</tr>';
			$('#layerPopUpTable').html(html);
			$('#puFlag').val(flag);
   	   	}			
   	}
   	
   	
   	function seq(){ //메뉴ID생성 시퀀스
   		$.ajax({
   			url: '/sm/menuIdCreate',
	        type: 'POST',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
			},
	        success: function (res) {
	        	$('#puSubMenuId').val(res.data.menuId);
	        	$('#puUpperMenuId').val(res.data.menuId);
	        }
   		});
   	}

	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});
   	
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


	//----------------------메뉴 순서 변경 및 지정하는 부분----------------------//
	
	let idxRelation_table; 		//DOM 선택 자
	let idxRelation_tableName;	//테이블 이름
	let idxRelation_tableData;	//tableData

	//저장 버튼 클릭 시
	function menuIndexCheck(value) {

		idxRelation_table 		= value;
		idxRelation_tableName	= value.context[0].nTable.id;
		idxRelation_tableData	= value.data();
		
		if(idxRelation_table.data().count() == 0){
   			toastr.warning('메뉴를 등록하고 시도 해주세요.');
			return false;
   	   	} else {
   	   	   	let title = idxRelation_tableName == "upperMenuTable" ? "상위" : "하위"; 
	   	   	$('#menuIndexChangeModalLabel').text(title+' 메뉴 변경 확인');
			$('#menuIndexChangeModal_h6').text(title+' 메뉴들의 순서를 변경하시겠습니까?');
			$('#menuIndexChangeModal').modal({backdrop: 'static'});
			$('#menuIndexChangeModal').modal('show');
		}
		
	}

	//메뉴 변경 모달 확인
	$('#btnMenuIndexChangeSave').on('click', function(){

		if(idxRelation_table.data().count() == 0){
   			toastr.warning('메뉴를 등록하고 시도 해주세요.');
			return false;
   	   	}

		$('#my-spinner').show();
   	   	
   		let dataArray = new Array();
   			dataArray = idxRelation_tableData.splice(",");

   		let data = JSON.stringify(dataArray);
   		
   		$.ajax({
	      	url: '<c:url value="/sm/reOrderMenuIndexUpdate"/>',
	        type: 'POST',
	        datatype: 'json',
	        data: {
				'dataArray' : function(){ return data; }
	        },
	        success: function(result){
	        	if(result.result == "ok"){
	      			toastr.success('변경되었습니다.');
	      			$('#'+idxRelation_tableName).DataTable().ajax.reload();
	        	} else if(result.result == "fail"){
	        		toastr.error(result.message, '', {timeOut: 5000});
	        	}
	        	else{
	        		toastr.error(result.message, '', {timeOut: 5000});
	        	}
	        },
			complete:function(){
				$('#my-spinner').hide();
			}
   		});
	});

	//메뉴관리 파일 변경 닫혔을 때
	$('#menuIndexChangeModal').on('hidden.bs.modal', function (e) {
		idxRelation_table		= null;
		idxRelation_tableName	= null;
		idxRelation_tableData	= null;
	});



	$('#menuChangeWay').on('click', function(){
		$('#menuChangeWayModal').modal('show');
	});

  //----------------------메뉴 순서 변경 및 지정하는 부분----------------------//

</script>

</body>
</html>
