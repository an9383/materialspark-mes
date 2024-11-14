<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script src="<c:url value='/resources/assets/vendor/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/bootstrap/js/popper.min.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/bootstrap/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/pace/pace.min.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/stacked-menu/stacked-menu.min.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/perfect-scrollbar/perfect-scrollbar.min.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/parsleyjs/parsley.min.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/parsleyjs/i18n/ko.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/moment/moment-with-locales.min.js'/>"></script>
<script src="<c:url value='/resources/assets/vendor/jQuery.print-master/jQuery.print.js'/>"></script> <!-- print 모듈 -->
<script src="<c:url value='/resources/assets/vendor/JsBarcode/JsBarcode.all.min.js'/>"></script> <!-- JsBarcode 모듈 -->
<script src="<c:url value='/resources/assets/vendor/lodash/lodash.js?ver=1.0'/>"></script> <!-- lodash -->

<script src="<c:url value='/resources/assets/javascript/pages/calendar.js'/>"></script><!--소정추가-->
<script src="<c:url value='/resources/assets/javascript/theme.min.js'/>"></script>

<script src="<c:url value='/resources/assets/stylesheets/js/datatables.min.js?version=1.10.20'/>"></script>
<script src="<c:url value='/resources/assets/stylesheets/js/sum().js?version=1.10.19'/>"></script>
<!-- <script src="https://cdn.datatables.net/plug-ins/1.10.19/api/sum().js"></script> -->
<script src="<c:url value='/resources/assets/stylesheets/js/alertify.min.js?version=1.13.1'/>"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script> -->
<script src="<c:url value='/resources/assets/stylesheets/js/toastr.min.js?version=2.1.4'/>"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script> -->
<script src="<c:url value='/resources/assets/stylesheets/js/dataTables.buttons.min.js?version=1.5.1'/>"></script>
<!-- <script src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script>  -->
<script src="<c:url value='/resources/assets/stylesheets/js/jszip.min.js?version=3.1.3'/>"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script> -->
<script src="<c:url value='/resources/assets/stylesheets/js/pdfmake.min.js?version=0.1.32'/>"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script> -->
<script src="<c:url value='/resources/assets/stylesheets/js/vfs_fonts.js?version=0.1.32'/>"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script> -->
<script src="<c:url value='/resources/assets/stylesheets/js/buttons.html5.min.js?version=1.5.1'/>"></script>
<!-- <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script> -->
<script src="<c:url value='/resources/assets/stylesheets/js/buttons.print.min.js?version=1.5.1'/>"></script>
<!-- <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js"></script> -->
<script src="<c:url value='/resources/assets/stylesheets/js/jstree.min.js?version=3.2.1'/>"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script> -->
<script src="<c:url value='/resources/assets/javascript/pages/jquery.mtz.monthpicker.js'/>"></script>
<!-- <script src="https://cdn.datatables.net/fixedcolumns/4.2.2/js/dataTables.fixedColumns.min.js"></script> -->


<script src="<c:url value='/resources/assets/vendor/datatables/extensions/rowgroup/dataTables.rowGroup.js'/>"></script><!-- datataTables rowGroup 기능 -->



   <style>
        .calender{
            width: 80%;
            margin: 0 auto;
            max-width: 800px;
        }
        .calender ul{
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font: 16px 'Noto Sans KR', sans-serif;
            color: #333;
        }
        .calender ul li{
            background: #fff;
            border: 1px solid #0077FF;
            border-radius: 20px;
            height: 37px;
            line-height: 37px;
            text-align: center;
            width: 80px;
            cursor: pointer;
            box-shadow: 0 3px 6px rgba(0,0,0,16%);
            list-style: none;
        }
        .calender ul li.clicked{
            background: #0077FF;
            color: #fff;
        }
        .calender ul.bottom li{
            width: 52px;
        }
        .calender ul.top li.year{
            border-radius: 10px;
            background: #e9e9e9;
        }
        .calender ul.top li.year select{
            border: 0;
            background: none;
        }
        
        .btn-wrap{
            width: 80%;
            margin: 2rem auto 0;
            display: flex;
            justify-content: center;
        }
        .btn-wrap button{
            border: 0;
            background: none;
            border-radius: 10px;
            border: 1px solid #0077FF;
            width: 100%;
            max-width: 175px;
            height: 37px;
            line-height: 37px;
            text-align: center;
            font-weight: 500;
            font-family: 'Noto Sans KR';
            cursor: pointer;
        }
        .btn-wrap button:first-child{
            margin-right: 50px;
        }
        .toast-title {			
				font-size: 150%;
			}

			.toast-message {			
				font-size: 150%;
			}    		
    </style>

<script>
    // 토스트 메시지가 2초후 사라짐
    toastr.options.timeOut = 2000;

    toastr.options.font = 1;
 
    // moment 언어 설정
    moment.locale('ko');

    //dataTables 한글화
    let lang_kor = {
        "decimal" : "",
        "emptyTable" : "데이터가 없습니다.",
        "info" : "_START_ - _END_ (총 _TOTAL_ 건)",
        "infoEmpty" : "0건",
        "infoFiltered" : "(전체 _MAX_ 건 중 검색결과)",
        "infoPostFix" : "",
        "thousands" : ",",
        "lengthMenu" : "_MENU_ 개씩 보기",
        "loadingRecords" : "로딩중...",
        "processing" : "처리중...",
        "search" : "검색 : ",
        "zeroRecords" : "검색된 데이터가 없습니다.",
        "paginate" : {
            "first" : "첫 페이지",
            "last" : "마지막 페이지",
            "next" : "다음",
            "previous" : "이전"
        },
        "aria" : {
            "sortAscending" : " :  오름차순 정렬",
            "sortDescending" : " :  내림차순 정렬"
        }
    };
    
    var menuPopupYnCodeModal = new Array(); // 메뉴팝업
	<c:forEach items="${menuPopupYnCdModal}" var="info">
	var jsonMenuPopup = new Object();
	jsonMenuPopup.baseCd = "${info.baseCd}";
	jsonMenuPopup.baseCdNm = "${info.baseCdNm}";
	menuPopupYnCodeModal.push(jsonMenuPopup);
	</c:forEach>

	function selectBoxAppend(obj, id, sVal, flag)
	{
		$('#'+ id).empty();

		if(flag == '1') {
			$('#'+ id).append($("<option value=''>"+ "전체" +"</option>"));
	   	} else if(flag == '2') {
	   		$('#'+ id).append($("<option value=''>"+ "선택" +"</option>"));
	   	}
	   		
		for(key in obj) {
			var option;
			if(obj[key].baseCd == sVal ) {
				option = $("<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>");
			} else {
				option = $("<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>");
			}	
			$('#'+ id).append(option);
		}

	}

	function selectBoxHtml(obj, id, sVal, row, meta)
	{
		//$('#'+ id).empty();
		//var shtml = '<select id="'+ id +'" class="mySelect" data-col="' + meta.col + '" onChange="locateChange()"><option value="">선택</option>';
		var shtml = '<select class="custom-select custom-select-sm" id="'+ id +'" data-col="' + meta.col + '" style="width:100px;"><option value="">선택</option>';
		//var shtml = '<select class="mySelect" data-col="' + meta.col + '" ><option value="">선택</option>';
		
		var option;
		for(key in obj) {
			var tmp; 
			if(obj[key].baseCd == sVal ) {
				tmp = "<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>";
			} else {
				tmp = "<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>";
			}	
			option += tmp;
		}
		var ehtml = '</select>';
		return shtml + option + ehtml;
	}	

	//수완 추가
	function selectBoxAppend_NameAdd(obj, id, sVal, flag, name){
		$('#'+ id).empty();

		if(flag == '1') {
			$('#'+ id).append($("<option value=''>"+ ""+name+"(전체)" +"</option>"));
	   	} else if(flag == '2') {
	   		$('#'+ id).append($("<option value=''>"+ ""+name+"(선택)" +"</option>"));
	   	}
	   		
		for(key in obj) {
			var option;
			if(obj[key].baseCd == sVal ) {
				option = $("<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>");
			} else {
				option = $("<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>");
			}	
			$('#'+ id).append(option);
		}
	}
	//종현 추가
	function selectBoxAppend_NameAdd2(obj, id, sVal, flag, name){
		$('#'+ id).empty();

		if(flag == '1') {
			$('#'+ id).append($("<option value=''>"+ ""+name+"전체" +"</option>"));
	   	} else if(flag == '2') {
	   		$('#'+ id).append($("<option value=''>"+ ""+name+"(선택)" +"</option>"));
	   	}
	   		
		for(key in obj) {
			var option;
			if(obj[key].baseCd == sVal ) {
				option = $("<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>");
			} else {
				option = $("<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>");
			}	
			$('#'+ id).append(option);
		}
	}
	//영민 추가 - 자재코드(mastrlCd) selectBox
	function selectMatrlBoxAppend(obj, id, sVal, flag)
	{
		$('#'+ id).empty();

		if(flag == '1') {
			$('#'+ id).append($("<option value=''>" + "전체" + "</option>"));
	   	} else if(flag == '2') {
	   		$('#'+ id).append($("<option value=''>" + "선택" + "</option>"));
	   	}
	   		
		for(key in obj) {
			var option;
			if(obj[key].baseCd == sVal ) {
				option = $("<option value=" + obj[key].matrlCd + " selected>"+obj[key].matrlNm + "</option>");
			} else {
				option = $("<option value=" + obj[key].matrlCd + ">"+obj[key].matrlNm + "</option>");
			}	
			$('#'+ id).append(option);
		}
	}
	
	function myFunction(x) {
		x.classList.toggle("change");
	}
	function openrNav() {
		document.getElementById("myrSidenav").style.display = "block";
		document.getElementById("arrowLeft").style.display = "none";
		document.getElementById("main").style.marginRight = "0";
	}
	function closerNav() {
		document.getElementById("myrSidenav").style.display = "none";
		document.getElementById("arrowLeft").style.display = "block";
		document.getElementById("main").style.marginRight = "10px";
	}
	function myrFunction(x) {
		x.classList.toggle("change");
	}

	function openrNav2() {
		document.getElementById("rfSidenav").style.display = "block";
		document.getElementById("arrowLeft").style.display = "none";
		document.getElementById("main").style.marginRight = "0";
	}
	function closerNav2() {
		document.getElementById("rfSidenav").style.display = "none";
		document.getElementById("arrowLeft").style.display = "block";
		document.getElementById("main").style.marginRight = "10px";
	}

	$(function() {
		var state = true;
		$("#left-width-btn").click(function() {
			{
				$("#left-list").animate({
					width : "71%"
				}, 0);
				$("#arrow-left").animate({
					display : "none"
				}, 0);
			}

			state = !state;
		});

		$("#left-width-btn").click(function() {
			{
				$("#left-list").animate({
					width : "71%"
				}, 0);
				$("#arrow-left").animate({
					display : "none"
				}, 0);
			}

			state = !state;
		});
	});
	$(function() {
		var state = true;
		$("#left-expand").click(function() {
			{
				$("#left-list").animate({
					width : "100%"
				}, 0);
			}
			state = !state;
		});

		$("#left-expand2").click(function() {
			{
				$("#left-list").animate({
					width : "100%"
				}, 0);
			}
			state = !state;
		});

	});

	$.ajaxSetup({
        beforeSend: function(xhr) {
        	xhr.setRequestHeader("AJAX", true);
     	},
        error: function(xhr, status, err) {
            if (xhr.status == 503) {
            	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
	           	location.href = "/";
            } else if (xhr.status == 0) {
            	toastr.error("인터넷에 연결할수 없습니다.", '', {timeOut: 5000});
            	location.reload();
       		} else if (xhr.status == 400) {
	            toastr.error("입력 정보를 확인하여주세요", '', {timeOut: 5000});
	       	} else if (xhr.status == 401) {
	            toastr.error("권한이 없는 엑세스 입니다.", '', {timeOut: 5000});
	       	} else if (xhr.status == 403) {
	            toastr.error("권한이 없는 액세스 입니다.", '', {timeOut: 5000});
	       	} else if (xhr.status == 404) {
	          	toastr.error("페이지를 찾을수 없습니다.", '', {timeOut: 5000});
	       	} else if (xhr.status == 500) {
	            toastr.error("실패하였습니다.", '', {timeOut: 5000});
	       	} else if (err == 'parsererror') {
	            toastr.error("실패하였습니다.", '', {timeOut: 5000});
	       	} else if (err == 'timeout') {
	            toastr.error("요청시간이 초과하였습니다.", '', {timeOut: 5000});
	       	} else if (err == 'abort') {
	            toastr.error("실패하였습니다.", '', {timeOut: 5000});
	       	} else {
	       		location.reload();		       	
	           //alert('Uncaught Error.n' + jqXHR.responseText);
	       	}
	           
//             } else {
//                 alert("예외가 발생했습니다. 관리자에게 문의하세요.["+xhr.status+"]");
//                 location.href = "/";
//             }
        },    	
//        	error: function(jqXHR, exception) {
//            	if (jqXHR.status === 0) {
//                 toastr.error("인터넷에 연결할수 없습니다.");
//            	} 
//            	else if (jqXHR.status == 400) {
//                 toastr.error("입력 정보를 확인하여주세요");
//            	} 
//            	else if (jqXHR.status == 401) {
//                 toastr.error("권한이 없는 엑세스 입니다.");
//            	} 
//            	else if (jqXHR.status == 403) {
//                 toastr.error("권한이 없는 액세스 입니다.");
//            	} 
//            	else if (jqXHR.status == 404) {
//                 toastr.error("페이지를 찾을수 없습니다.");
//            	} 
//            	else if (jqXHR.status == 500) {
//                 toastr.error("실패하였습니다.");
//            	} 
//            	else if (jqXHR.status == 503) {
//                 toastr.error("허용하지 않는 서비스 입니다.");
//            	} 
//            	else if (exception === 'parsererror') {
//                 toastr.error("실패하였습니다.");
//            	} 
//            	else if (exception === 'timeout') {
//                 toastr.error("요청시간이 초과하였습니다.");
//            	} 
//            	else if (exception == 'abort') {
//                 toastr.error("실패하였습니다.");
//            	} 
//            	else {
//                alert('Uncaught Error.n' + jqXHR.responseText);
//            	}
//     	 }
	});
	
	/*
	$.ajax({
	    url: '<c:url value="/asideMenu"/>',
	    type: 'POST',
	    data: {      
	    },    
	    success: function (res) {
	       
	        var upperMenu = "";
	        
	        var menuUpperId= new Array();
	        
	       
	       
	        	 $.each(res.result, function(idx, item){ 
	 	        	
	  	           if(item.menuUpperId == null){
	  	        	   upperMenu += '<li class="menu-item has-child append-data">';
	  	        	   upperMenu += '<a href="#" class="menu-link append-data-a">';
	  	        	   upperMenu += '<span class="menu-icon far fa-file-alt"></span>';	       
	  	        	   upperMenu += '<span class="menu-text">' + item.menuNm +'</span>';
	  	        	   upperMenu += '</a>';
	  	        	   upperMenu += '<ul class="menu" id='+item.menuId +'></ul>';	        	   
					   upperMenu += '</li>';
	  	           } 
	  	        });
	        	 
		        $('#aside').append(upperMenu);
		        
	        	$.each(res.result, function(idx, item){ 
	  		        if(item.menuUpperId != null){
	  		        	var subMenu = "";
	  		        	subMenu += '<li class="menu-item">';
	  		        	subMenu += '<a href="<c:url value="' + item.menuPath + '"/>" id=' + item.menuId + ' class="menu-link" tabindex="-1">'+item.menuNm+'</a>';
	  		        	subMenu += '</li>';
	  		        	
	  		        	$('#'+item.menuUpperId).append(subMenu);
	  		        	
	  		        	
	  	          	}
	  	        });
	        	$(document).on('click','.has-child',function(){
	        		if ( $(this).hasClass('has-open') ) {
	        			$(this).removeClass('has-open');
	        		} else{
	        			$(this).addClass('has-open');
	        		}
	        		
	        		 
	        	});
	    },
	    complete : function(){
	    	
	    }
	});
	*/


	/*
	let current = null;
	let controllerUrl = null;
	let subControllerUrl = null;
	let viewMainTable = null;
	let mainTable = '';
	let formItems = null;				// 메인항목 - 등록, 수정에 보여줄 항목
	let viewItems = null;				// 메인항목 - 보기에 보여줄 항목
	let theadItems = null;				// 메인항목 - 테이블 항목
	let columns = null;					// 메인항목 - 목록, 칼럼(columns)
	let orderLot = null;				// 메인항목 - 목록, 정렬(orderLot)
	let columnDefs = null;				// 메인항목 - 목록, 칼럼상태(columnDefs)
	let subTable = '';
	let subFormItems = null;			// 서브항목 - 등록, 수정에 보여줄 항목
	let subViewItems = null;			// 서브항목 - 보기에 보여줄 항목
	let subTheadItems = null;			// 서브항목 - 테이블 항목
	let subColumns = null;				// 서브항목 - 목록, 칼럼(columns)
	let subOrderLot = null;				// 서브항목 - 목록, 정렬(orderLot)
	let subColumnDefs = null;			// 서브항목 - 목록, 칼럼상태(columnDefs)
	let searchData = null;
	let showAddAfterViewDetail = false;	// 상세보기가 선택된 상태에서 등록을 누른경우, 취소하면 다시 상세보기항목을 보여주기 위해서 사용
	 */

	
	// 보기
	$('#info').on('click', function() {
		$.ajax({
			url : '<c:url value="/sm/info"/>',
			type : 'GET',
			data : {
				
			},
			success : function(res) {
				let data = res.data;

				if(res.result == "ok"){							
					
					// 보기
					$('#userNumberModal').val(data.userNumber);
					$('#userNmModal').val(data.userNm);		
					$('#userIdModal').val(data.userId);
					$('#departmentCdModal').val(data.departmentNm);
					$('#chargrDutyModal').val(data.chargrDutyNm);
					$('#postCdModal').val(data.postNm);
					$('#teamCdModal').val(data.teamNm);
					$('#workplaceCdModal').val(data.workplaceNm);		
					console.log(data.menuPopupYn);
					selectBoxAppend(menuPopupYnCodeModal, "menuPopUpYnModal", data.menuPopupYn, "");	// 보기
					$('#infoPopUpModal').modal('show');	
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			}
		});
	});
	
	// 비밀번호 변경
	$('#passChange').on('click', function() {
		$('#nowPassword').val("");
		$('#changePassword').val("");
		$('#changePassword2').val("");
		$('#nowPassword').attr("disabled",false);
		$('#changePassword').attr("disabled",false);
		$('#changePassword2').attr("disabled",false);
		$('#passChangePopUpModal').modal('show');	
	});
	 
	// 비밀번호 변경
	$('#passChangePopUpSave').on('click', function() {
		if($('#changePassword').val() !=  $('#changePassword2').val()){
			toastr.warning("변경할 비밀번호가 일치하지 않습니다.");
			return false;
		}
		if($('#changePassword').val().length < 4){
			toastr.warning("비밀번호는 4자리 이상으로 입력해주세요");
			return false;
		}
		/* if(PasswordString($.trim($('#changePassword').val()))){
			toastr.warning("비밀번호는 4자리 이상 20자리 이하 특수문자&숫자&영문(대+소문자)조합으로 해주세요");			
			return false;
		} */
		
		$.ajax({
			url : '<c:url value="/sm/passChange"/>',
			type : 'POST',
			data : {
				'nowPass' : $('#nowPassword').val(),
				'changePassword' : $('#changePassword').val(),
			},
			success : function(res) {
				let data = res.data;
				$('#nowPassword').attr("disabled",true);
				$('#changePassword').attr("disabled",true);
				$('#changePassword2').attr("disabled",true);
				if(res.result == "ok"){	
					toastr.success("패스워드가 변경되었습니다.");
					$('#passChangePopUpModal').modal('hide');				
					
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
					$('#passChangePopUpModal').modal('hide');				
				}
			}
		});
	});
	
	// 메뉴팝업 여부 변경
	$('#menuPopupYnPopUpSave').on('click', function() {
		
		$.ajax({
			url : '<c:url value="/sm/menuPopupChange"/>',
			type : 'POST',
			data : {
				'menuPopupYn' : $('#menuPopUpYnModal option:selected').val(),				
			},
			success : function(res) {
				let data = res.data;				
				if(res.result == "ok"){	
					toastr.success("메뉴팝업여부가 변경되었습니다.");
					$('#infoPopUpModal').modal('hide');				
					
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
					$('#infoPopUpModal').modal('hide');				
				}
			}
		});
	});
	 
	// 패스워드 정규식
	function PasswordString(elm)
	{			
	    var pattern =  /^(?=.*[a-z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).{4,20}$/;
		var match = pattern.exec(elm);
		var matchStatus = Boolean(match);
	    if(!matchStatus) {
	        elm='';
	    }
	    
	    return !matchStatus;
	}

	//콤마(,) 삭제
	function uncomma(x) {
	    x = String(x);
	    return x.replace(/[^\d]+/g, '');
	}
	 
	//콤마(,) 생성
	function addCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

	function removeCommas(x) {
		return x.toString().replace(/,/g, '');
    }

	//숫자만 입력, 길이, 정수만 입력
	$('.number-float0').keyup(function (event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109)	) {
			//$('.number-float0').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			
			toastr.warning('양수(+)만 입력해주세요.');
			$(this).val("");
			$(this).val("0");
 			$(this).select();
			event.preventDefault();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}

 		var temp = $(this).val();
 		temp = removeCommas(temp);
		
 		if ($(this).attr("maxlength") < temp.length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat(temp)) {
 			toastr.warning('최대 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat(temp)) {
 			toastr.warning('최소 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
		if ( event.which == 110 || event.which == 190 ) {
			toastr.warning('정수만 입력 가능합니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
		// .개수 세기
		if ( $(this).val().split('.').length > 1  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		var _pattern2 = /^\d*[.]\d{1}$/;
        if (_pattern2.test( temp)) {
        	toastr.warning("정수만 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}

        //$(this).val() = addCommas(temp);
	});
	
	//숫자만 입력, 길이, 소수점 한자리까지 제한
	$('.number-float1').keyup(function (event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109 || event.which == 110 || event.which == 190)	) {
			//$('.number-float1').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
	 		$(this).select();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
			toastr.warning('최대 크기를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}

		// .개수 세기
		if ( $(this).val().split('.').length > 2  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
 		var _pattern1 = /^\d*[.]\d{2}$/;
        if (_pattern1.test( $(this).val())) {
        	toastr.warning("소수점 첫째 자리까지 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
 			return false;
        }       
	});

	//숫자만 입력, 길이, 소수점 두자리까지 제한
	$('.number-float2').keyup(function (event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 190)	) {
			//$('.number-float2').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
 			$(this).select();
			toastr.warning('최대 크기를 초과하였습니다.');
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
 			$(this).select();
			toastr.warning('최소 크기를 초과하였습니다.');
			return false;
		}

		// .개수 세기
		if ( $(this).val().split('.').length > 2  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		
 		var _pattern2 = /^\d*[.]\d{3}$/;
        if (_pattern2.test( $(this).val())) {
        	toastr.warning("소수점 둘째 자리까지 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
        }
	});
	
	//숫자만 입력, 길이, 소수점 세자리까지 제한
	$('.number-float3').keyup(function (event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109 || event.which == 110 || event.which == 190)	) {
			//$('.number-float3').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
			toastr.warning('최대 크기를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}

		// .개수 세기
		if ( $(this).val().split('.').length > 2  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		
 		var _pattern3 = /^\d*[.]\d{4}$/;	//누르고있는 키는 예외처리 안됨
        if (_pattern3.test( $(this).val())) {
        	toastr.warning("소수점 셋째 자리까지 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}
	});

	//숫자입력 글자 수, min, max 제한
	$('.number').keyup(function (event) {
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
			toastr.warning('최대 수치를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
		
		//. 존재 여부 확인
		if($(this).val().indexOf(".") !== -1) {
			//.앞에 숫자 미입력 제한
			if($(this).val().length == 1 ){
				toastr.warning('숫자 입력후 . 을 입력해 주세요.');
				$(this).val("0");
	 			$(this).select();
				return false;
			}
			//.입력 개수 제한
			if($(this).val().split(".").length > 2 ){
				toastr.warning('. 은 한번만 입력해 주세요.');
				$(this).val("0");
	 			$(this).select();
				return false;
			}
			//소수점 자리수 제한
			if ($(this).val().split('.')[1].length > 3) {
				toastr.warning('소수점 세자리까지 입력 가능합니다.');
				$(this).val("0");
	 			$(this).select();
				return false;
			}
		}
	});
	
	//입력창 클릭시 자동 모두선택
	$('.form-control').on('click', function() {
   		$(this).select();
   	});



	var ENG_KEY = "rRseEfaqQtTdwWczxvgkoiOjpuPhynbml"; //소문자로 변경 시 사용
	var KOR_KEY = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅐㅑㅒㅓㅔㅕㅖㅗㅛㅜㅠㅡㅣ";
	var CHO_DATA = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ";
	var JUNG_DATA = "ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ";
	var JONG_DATA = "ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ";
	
   	//영타 -> 한타타로 변환
   	function engTypeToKor(src) {
		var res = "";
		if (src.length == 0)
			return res;
	
		var nCho = -1, nJung = -1, nJong = -1;		// 초성, 중성, 종성
	
		for (var i = 0; i < src.length; i++) {
			var ch = src.charAt(i);
			var p = ENG_KEY.indexOf(ch);
			if (p == -1) {				// 영자판이 아님
				// 남아있는 한글이 있으면 처리
				if (nCho != -1) {
					if (nJung != -1)				// 초성+중성+(종성)
						res += makeHangul(nCho, nJung, nJong);
					else							// 초성만
						res += CHO_DATA.charAt(nCho);
				} else {
					if (nJung != -1)				// 중성만
						res += JUNG_DATA.charAt(nJung);
					else if (nJong != -1)			// 복자음
						res += JONG_DATA.charAt(nJong);
				}
				nCho = -1;
				nJung = -1;
				nJong = -1;
				res += ch;
			} else if (p < 19) {			// 자음
				if (nJung != -1) {
					if (nCho == -1) {					// 중성만 입력됨, 초성으로
						res += JUNG_DATA.charAt(nJung);
						nJung = -1;
						nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
					} else {							// 종성이다
						if (nJong == -1) {				// 종성 입력 중
							nJong = JONG_DATA.indexOf(KOR_KEY.charAt(p));
							if (nJong == -1) {			// 종성이 아니라 초성이다
								res += makeHangul(nCho, nJung, nJong);
								nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
								nJung = -1;
							}
						} else if (nJong == 0 && p == 9) {			// ㄳ
							nJong = 2;
						} else if (nJong == 3 && p == 12) {			// ㄵ
							nJong = 4;
						} else if (nJong == 3 && p == 18) {			// ㄶ
							nJong = 5;
						} else if (nJong == 7 && p == 0) {			// ㄺ
							nJong = 8;
						} else if (nJong == 7 && p == 6) {			// ㄻ
							nJong = 9;
						} else if (nJong == 7 && p == 7) {			// ㄼ
							nJong = 10;
						} else if (nJong == 7 && p == 9) {			// ㄽ
							nJong = 11;
						} else if (nJong == 7 && p == 16) {			// ㄾ
							nJong = 12;
						} else if (nJong == 7 && p == 17) {			// ㄿ
							nJong = 13;
						} else if (nJong == 7 && p == 18) {			// ㅀ
							nJong = 14;
						} else if (nJong == 16 && p == 9) {			// ㅄ
							nJong = 17;
						} else {						// 종성 입력 끝, 초성으로
							res += makeHangul(nCho, nJung, nJong);
							nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
							nJung = -1;
							nJong = -1;
						}
					}
				} else {								// 초성 또는 (단/복)자음이다
					if (nCho == -1) {					// 초성 입력 시작
						if (nJong != -1) {				// 복자음 후 초성
							res += JONG_DATA.charAt(nJong);
							nJong = -1;
						}
						nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
					} else if (nCho == 0 && p == 9) {			// ㄳ
						nCho = -1;
						nJong = 2;
					} else if (nCho == 2 && p == 12) {			// ㄵ
						nCho = -1;
						nJong = 4;
					} else if (nCho == 2 && p == 18) {			// ㄶ
						nCho = -1;
						nJong = 5;
					} else if (nCho == 5 && p == 0) {			// ㄺ
						nCho = -1;
						nJong = 8;
					} else if (nCho == 5 && p == 6) {			// ㄻ
						nCho = -1;
						nJong = 9;
					} else if (nCho == 5 && p == 7) {			// ㄼ
						nCho = -1;
						nJong = 10;
					} else if (nCho == 5 && p == 9) {			// ㄽ
						nCho = -1;
						nJong = 11;
					} else if (nCho == 5 && p == 16) {			// ㄾ
						nCho = -1;
						nJong = 12;
					} else if (nCho == 5 && p == 17) {			// ㄿ
						nCho = -1;
						nJong = 13;
					} else if (nCho == 5 && p == 18) {			// ㅀ
						nCho = -1;
						nJong = 14;
					} else if (nCho == 7 && p == 9) {			// ㅄ
						nCho = -1;
						nJong = 17;
					} else {							// 단자음을 연타
						res += CHO_DATA.charAt(nCho);
						nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
					}
				}
			} else {									// 모음
				if (nJong != -1) {						// (앞글자 종성), 초성+중성
					// 복자음 다시 분해
					var newCho;			// (임시용) 초성
					if (nJong == 2) {					// ㄱ, ㅅ
						nJong = 0;
						newCho = 9;
					} else if (nJong == 4) {			// ㄴ, ㅈ
						nJong = 3;
						newCho = 12;
					} else if (nJong == 5) {			// ㄴ, ㅎ
						nJong = 3;
						newCho = 18;
					} else if (nJong == 8) {			// ㄹ, ㄱ
						nJong = 7;
						newCho = 0;
					} else if (nJong == 9) {			// ㄹ, ㅁ
						nJong = 7;
						newCho = 6;
					} else if (nJong == 10) {			// ㄹ, ㅂ
						nJong = 7;
						newCho = 7;
					} else if (nJong == 11) {			// ㄹ, ㅅ
						nJong = 7;
						newCho = 9;
					} else if (nJong == 12) {			// ㄹ, ㅌ
						nJong = 7;
						newCho = 16;
					} else if (nJong == 13) {			// ㄹ, ㅍ
						nJong = 7;
						newCho = 17;
					} else if (nJong == 14) {			// ㄹ, ㅎ
						nJong = 7;
						newCho = 18;
					} else if (nJong == 17) {			// ㅂ, ㅅ
						nJong = 16;
						newCho = 9;
					} else {							// 복자음 아님
						newCho = CHO_DATA.indexOf(JONG_DATA.charAt(nJong));
						nJong = -1;
					}
					if (nCho != -1)			// 앞글자가 초성+중성+(종성)
						res += makeHangul(nCho, nJung, nJong);
					else                    // 복자음만 있음
						res += JONG_DATA.charAt(nJong);
	
					nCho = newCho;
					nJung = -1;
					nJong = -1;
				}
				if (nJung == -1) {						// 중성 입력 중
					nJung = JUNG_DATA.indexOf(KOR_KEY.charAt(p));
				} else if (nJung == 8 && p == 19) {            // ㅘ
					nJung = 9;
				} else if (nJung == 8 && p == 20) {            // ㅙ
					nJung = 10;
				} else if (nJung == 8 && p == 32) {            // ㅚ
					nJung = 11;
				} else if (nJung == 13 && p == 23) {           // ㅝ
					nJung = 14;
				} else if (nJung == 13 && p == 24) {           // ㅞ
					nJung = 15;
				} else if (nJung == 13 && p == 32) {           // ㅟ
					nJung = 16;
				} else if (nJung == 18 && p == 32) {           // ㅢ
					nJung = 19;
				} else {			// 조합 안되는 모음 입력
					if (nCho != -1) {			// 초성+중성 후 중성
						res += makeHangul(nCho, nJung, nJong);
						nCho = -1;
					} else						// 중성 후 중성
						res += JUNG_DATA.charAt(nJung);
					nJung = -1;
					res += KOR_KEY.charAt(p);
				}
			}
		}
	
		// 마지막 한글이 있으면 처리
		if (nCho != -1) {
			if (nJung != -1)			// 초성+중성+(종성)
				res += makeHangul(nCho, nJung, nJong);
			else                		// 초성만
				res += CHO_DATA.charAt(nCho);
		} else {
			if (nJung != -1)			// 중성만
				res += JUNG_DATA.charAt(nJung);
			else {						// 복자음
				if (nJong != -1)
					res += JONG_DATA.charAt(nJong);
			}
		}
	
		return res;
	}

	function makeHangul(nCho, nJung, nJong) {
		return String.fromCharCode(0xac00 + nCho * 21 * 28 + nJung * 28 + nJong + 1);
	}

	//한타 -> 영타로 변환
	function korTypeToEng(src) {
		var res = "";
		if (src.length == 0)
			return res;
	
		for (var i = 0; i < src.length; i++) {
			var ch = src.charAt(i);
			var nCode = ch.charCodeAt(0);
			var nCho = CHO_DATA.indexOf(ch), nJung = JUNG_DATA.indexOf(ch), nJong = JONG_DATA.indexOf(ch);
			var arrKeyIndex = [-1, -1, -1, -1, -1];
	
			if (0xac00 <= nCode && nCode <= 0xd7a3) {
				nCode -= 0xac00;
				arrKeyIndex[0] = Math.floor(nCode / (21 * 28));			// 초성
				arrKeyIndex[1] = Math.floor(nCode / 28) % 21;			// 중성
				arrKeyIndex[3] = nCode % 28 - 1;						// 종성
			} else if (nCho != -1)			// 초성 자음
				arrKeyIndex[0] = nCho;
			else if (nJung != -1)			// 중성
				arrKeyIndex[1] = nJung;
			else if (nJong != -1)			// 종성 자음
				arrKeyIndex[3] = nJong;
			else							// 한글이 아님
				res += ch;
	
			// 실제 Key Index로 변경. 초성은 순서 동일
			if (arrKeyIndex[1] != -1) {
				if (arrKeyIndex[1] == 9) {					// ㅘ
					arrKeyIndex[1] = 27;
					arrKeyIndex[2] = 19;
				} else if (arrKeyIndex[1] == 10) {			// ㅙ
					arrKeyIndex[1] = 27;
					arrKeyIndex[2] = 20;
				} else if (arrKeyIndex[1] == 11) {			// ㅚ
					arrKeyIndex[1] = 27;
					arrKeyIndex[2] = 32;
				} else if (arrKeyIndex[1] == 14) {			// ㅝ
					arrKeyIndex[1] = 29;
					arrKeyIndex[2] = 23;
				} else if (arrKeyIndex[1] == 15) {			// ㅞ
					arrKeyIndex[1] = 29;
					arrKeyIndex[2] = 24;
				} else if (arrKeyIndex[1] == 16) {			// ㅟ
					arrKeyIndex[1] = 29;
					arrKeyIndex[2] = 32;
				} else if (arrKeyIndex[1] == 19) {			// ㅢ
					arrKeyIndex[1] = 31;
					arrKeyIndex[2] = 32;
				} else {
					arrKeyIndex[1] = KOR_KEY.indexOf(JUNG_DATA.charAt(arrKeyIndex[1]));
					arrKeyIndex[2] = -1;
				}
			}
			if (arrKeyIndex[3] != -1) {
				if (arrKeyIndex[3] == 2) {					// ㄳ
					arrKeyIndex[3] = 0
					arrKeyIndex[4] = 9;
				} else if (arrKeyIndex[3] == 4) {			// ㄵ
					arrKeyIndex[3] = 2;
					arrKeyIndex[4] = 12;
				} else if (arrKeyIndex[3] == 5) {			// ㄶ
					arrKeyIndex[3] = 2;
					arrKeyIndex[4] = 18;
				} else if (arrKeyIndex[3] == 8) {			// ㄺ
					arrKeyIndex[3] = 5;
					arrKeyIndex[4] = 0;
				} else if (arrKeyIndex[3] == 9) {			// ㄻ
					arrKeyIndex[3] = 5;
					arrKeyIndex[4] = 6;
				} else if (arrKeyIndex[3] == 10) {			// ㄼ
					arrKeyIndex[3] = 5;
					arrKeyIndex[4] = 7;
				} else if (arrKeyIndex[3] == 11) {			// ㄽ
					arrKeyIndex[3] = 5;
					arrKeyIndex[4] = 9;
				} else if (arrKeyIndex[3] == 12) {			// ㄾ
					arrKeyIndex[3] = 5;
					arrKeyIndex[4] = 16;
				} else if (arrKeyIndex[3] == 13) {			// ㄿ
					arrKeyIndex[3] = 5;
					arrKeyIndex[4] = 17;
				} else if (arrKeyIndex[3] == 14) {			// ㅀ
					arrKeyIndex[3] = 5;
					arrKeyIndex[4] = 18;
				} else if (arrKeyIndex[3] == 17) {			// ㅄ
					arrKeyIndex[3] = 7;
					arrKeyIndex[4] = 9;
				} else {
					arrKeyIndex[3] = KOR_KEY.indexOf(JONG_DATA.charAt(arrKeyIndex[3]));
					arrKeyIndex[4] = -1;
				}
			}
	
			for (var j = 0; j < 5; j++) {
				if (arrKeyIndex[j] != -1)
					res += ENG_KEY.charAt(arrKeyIndex[j]);
			}
		}
	
		return res;
	}


	var docV = document.documentElement;
	// 전체화면 설정
	function openFullScreenMode() {
	    if (docV.requestFullscreen)
	        docV.requestFullscreen();
	    else if (docV.webkitRequestFullscreen) // Chrome, Safari (webkit)
	        docV.webkitRequestFullscreen();
	    else if (docV.mozRequestFullScreen) // Firefox
	        docV.mozRequestFullScreen();
	    else if (docV.msRequestFullscreen) // IE or Edge
	        docV.msRequestFullscreen();
	}
	
	// 전체화면 해제
	function closeFullScreenMode() {
	    if (document.exitFullscreen)
	        document.exitFullscreen();
	    else if (document.webkitExitFullscreen) // Chrome, Safari (webkit)
	        document.webkitExitFullscreen();
	    else if (document.mozCancelFullScreen) // Firefox
	        document.mozCancelFullScreen();
	    else if (document.msExitFullscreen) // IE or Edge
	        document.msExitFullscreen();
	}

	$(document).on('click','.form-control, .form-control-md', function(event) {
   		$(this).select();
   	});

	function left(s,c){
	  return s.substr(0,c);
	}//left("abcd",2)
	function right(s,c){
	  return s.substr(-c);
	}//right("abcd",2)
	function mid(s,c,l){
	  return s.substring(c,l);
	}//mid("abcd",1,2)
	function copy(s,c,l){
	  return s.substr(c,l);
	}//copy("abcd",1,2)
	
		//같은 값이 있는 열을 병합함
	//사용법 : $('#테이블 ID').rowspan(0);
	$.fn.rowspan = function(colIdx, isStats) {
        return this.each(function(){      
            var that;
            $('tr', this).each(function(row) {
                $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
                    
                    if ($(this).html() == $(that).html()
                        && (!isStats
                                || isStats && $(this).prev().html() == $(that).prev().html()
                                )
                        ) {
                        rowspan = $(that).attr("rowspan") || 1;
                        rowspan = Number(rowspan)+1;
     
                        $(that).attr("rowspan",rowspan);
                        
                        // do your action for the colspan cell here            
                        $(this).hide();
                        
                        //$(this).remove(); 
                        // do your action for the old cell here
                        
                    } else {            
                        that = this;         
                    }          
                    
                    // set the that if not already set
                    that = (that == null) ? this : that;      
                });     
            });    
        });  
    };

	$.fn.rowspan2 = function(colIdx, isStats) {
        return this.each(function(){                 
            var that;
            $('tr', this).each(function(row) {
                
                $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {

                    if($(this).html() != ''){
	                    if ($(this).html() == $(that).html()
	                        && (!isStats
	                                || isStats && $(this).prev().html() == $(that).prev().html()
	                                )
	                        ) {
	                        rowspan = $(that).attr("rowspan") || 1;
	                        rowspan = Number(rowspan)+1;
	     
	                        $(that).attr("rowspan",rowspan);
	                                  
	                        $(this).hide();
	                       
	                    } else {            
	                        that = this;         
	                    }        
                    }  
                    
                    // set the that if not already set
                    that = (that == null) ? this : that;      
                });     
            });    
        });  
    };
     
     
     
	//같은 값이 있는 행을 병합함
    //사용법 : $('#테이블 ID').colspan (0);
    $.fn.colspan = function(rowIdx) {
        return this.each(function(){
            
            var that;
            $('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
                $(this).find('th').filter(':visible').each(function(col) {
                    if ($(this).html() == $(that).html()) {
                        colspan = $(that).attr("colSpan") || 1;
                        colspan = Number(colspan)+1;
                        
                        $(that).attr("colSpan",colspan);
                        $(this).hide(); // .remove();
                    } else {
                        that = this;
                    }
                    
                    // set the that if not already set
                    that = (that == null) ? this : that;
                    
                });
            });
        });
    }

  //오늘버튼
	function datePick(value, from, to, year){

		if(value == 'today'){
			
			todayPick(from, to);
			
		} else if(value == 'yesterday'){
			
			yesterdayPick(from, to);
			
		} else if(value == 'thisWeek'){
			
			thisWeekPick(from, to);
			
		} else if(value == 'lastWeek'){
			
			lastWeekPick(from, to);
			
		} else if(value == 'thisMonth'){
			
			thisMonthPick(from, to);
			
		} else if(value == 'lastMonth'){
			
			lastMonthPick(from, to);
			
		} else if(value == 'untilToday'){
			
			untilTodayPick(from, to);
			
		} else if(value == 'thisYear'){
			
			thisYearPick(from, to);
			
		} else if(value == 'quarter1'){
			
			quarter1Pick(from, to, year);
			
		} else if(value == 'quarter2'){
			
			quarter2Pick(from, to, year);
			
		} else if(value == 'quarter3'){
			
			quarter3Pick(from, to, year);
			
		} else if(value == 'quarter4'){
			
			quarter4Pick(from, to, year);
			
		} else if(value == 'firstHalf'){
			
			firstHalfPick(from, to, year);
			
		} else if(value == 'secondHalf'){
			
			secondHalfPick(from, to, year);
						
		} else if(value == 'lastYear'){

			lastYearPick(from, to, year);
			
		} else if(value == 'lastYear2'){

			lastYear2Pick(from, to, year);
			
		} else if(value == 'jan'){

			janPick(from, to, year);
			
		} else if(value == 'feb'){

			febPick(from, to, year);
			
		} else if(value == 'mar'){
			
			marPick(from, to, year);
			
		} else if(value == 'apr'){

			aprPick(from, to, year);
			
		} else if(value == 'may'){

			mayPick(from, to, year);
			
		} else if(value == 'jun'){

			junPick(from, to, year);
			
		} else if(value == 'jul'){

			julPick(from, to, year);
			
		} else if(value == 'aug'){

			augPick(from, to, year);
			
		} else if(value == 'sep'){

			sepPick(from, to, year);
			
		} else if(value == 'oct'){

			octPick(from, to, year);
			
		} else if(value == 'nov'){

			novPick(from, to, year);
			
		} else if(value == 'dec'){

			decPick(from, to, year);
			
		} else{

			defaultYearPick(from, to, year);
		} 
		
		
	}

	//년도만 선택
	function defaultYearPick(from, to, year){
		var today = new Date();
		var startDay = new Date($('#' + from).val());
		var endDay =  new Date($('#' + to).val());
		
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);	
		}
		
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}	

	
	//오늘
	function todayPick(from, to){
		var today = new Date();
		$('#' + from).val(moment(today).format("YYYY-MM-DD"));
		$('#' + to).val(moment(today).format("YYYY-MM-DD"));
	}	
	
	//전일
	function yesterdayPick(from, to){
		var today = new Date();
		today.setDate(today.getDate() - 1);
		$('#' + from).val(moment(today).format("YYYY-MM-DD"));
		$('#' + to).val(moment(today).format("YYYY-MM-DD"));
	}
	
	 
	//이번 주
	function thisWeekPick(from, to){
		var startDay = new Date();
		
		var endDay = new Date();
		
		startDay = new Date(startDay);
	
		
		var day = startDay.getDay()
		, diff = startDay.getDate() - day + (day == 0 ? -6:1); // adjust when day is sunday
		
		new Date(startDay.setDate(diff));
		
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}

	//지난 주
	function lastWeekPick(from, to){
		var startDay = new Date();
		var endDay = new Date();
		startDay = new Date(startDay);
		var day = startDay.getDay(),
		diff = startDay.getDate() - day + (day == 0 ? -6:1); // adjust when day is sunday
		diff = diff - 7;
		new Date(startDay.setDate(diff));
		new Date(endDay.setDate(diff+6));
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//이번달
	function thisMonthPick(from, to){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//저번달
	function lastMonthPick(from, to){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(startDay.getMonth() - 1);
		
		endDay.setDate(0);
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//오늘까지
	function untilTodayPick(from, to){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setMonth(0);
		startDay.setDate(1);
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//올해
	function thisYearPick(from, to){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setMonth(0);
		startDay.setDate(1);
		endDay.setMonth(12);
		endDay.setDate(0);
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//1/4분기
	function quarter1Pick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);			
		startDay.setMonth(0);
		
		endDay.setDate(1);	
		endDay.setMonth(3);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//2/4분기
	function quarter2Pick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(3);
		
		endDay.setDate(1);	
		endDay.setMonth(6);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//3/4분기
	function quarter3Pick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(6);
		
		endDay.setDate(1);	
		endDay.setMonth(9);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	
	//4/4분기
	function quarter4Pick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(9);
		
		endDay.setDate(1);	
		endDay.setMonth(12);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	
	//상반기
	function firstHalfPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(0);
		
		endDay.setDate(1);	
		endDay.setMonth(6);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	
	//하반기
	function secondHalfPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(6);
		
		endDay.setDate(1);	
		endDay.setMonth(12);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	
	//전년도
	function lastYearPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setFullYear(startDay.getFullYear() - 1);
		startDay.setMonth(0);
		startDay.setDate(1);
		endDay.setFullYear(endDay.getFullYear() - 1);
		endDay.setMonth(12);
		endDay.setDate(0);
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	
	
	//전전년도
	function lastYear2Pick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setFullYear(startDay.getFullYear() - 2);
		startDay.setMonth(0);
		startDay.setDate(1);
		endDay.setFullYear(endDay.getFullYear() - 2);
		endDay.setMonth(12);
		endDay.setDate(0);
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	
	
	//1월
	function janPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(0);
		endDay.setDate(1);				
		endDay.setMonth(1);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//2월
	function febPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(1);		
				
		endDay.setDate(1);	
		endDay.setMonth(2);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//3월
	function marPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(2);
		
		endDay.setDate(1);	
		endDay.setMonth(3);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//4월
	function aprPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(3);		
		
		endDay.setDate(1);	
		endDay.setMonth(4);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//5월
	function mayPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(4);
	
		endDay.setDate(1);	
		endDay.setMonth(5);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//6월
	function junPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(5);
		
		endDay.setDate(1);	
		endDay.setMonth(6);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//7월
	function julPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(6);
		
		endDay.setDate(1);	
		endDay.setMonth(7);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//8월
	function augPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(7);
		
		endDay.setDate(1);	
		endDay.setMonth(8);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//9월
	function sepPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(8);		
		
		endDay.setDate(1);	
		endDay.setMonth(9);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//10월
	function octPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(9);
		
		endDay.setDate(1);	
		endDay.setMonth(10);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//11월
	function novPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(10);
		
		endDay.setDate(1);	
		endDay.setMonth(11);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}
	
	//12월
	function decPick(from, to, year){
		var startDay = new Date();
		var endDay = new Date();
		startDay.setDate(1);
		startDay.setMonth(11);
		
		endDay.setDate(1);	
		endDay.setMonth(12);
		endDay.setDate(0);
		if(year != "" && year != null){
			startDay.setFullYear(year);
			endDay.setFullYear(year);
		}
		$('#' + from).val(moment(startDay).format("YYYY-MM-DD"));
		$('#' + to).val(moment(endDay).format("YYYY-MM-DD"));
	}

	function datePickFun(){

		var dt = new Date();
        var year = "";
        var com_year = dt.getFullYear();
        $('#select-year option').remove();        
		for(var y = (com_year-3); y <= (com_year+3); y++){
			$('#select-year').append("<option value='" + y + "'>" + y + "년" + "</option>");
		}
		$.each($('.calender ul li'), function(){
			if( $(this).hasClass('clicked') ){
				$(this).removeClass('clicked');
			}
		});
		 $('#select-year').val(com_year);
		
		$('#dateSelectModal').modal('show');

	}


	$('.calender ul li').on('click',function() {
		console.log($(this).attr("id"));
		if($(this).attr('id') != 'selectDiv'){			
			$.each($('.calender ul li'), function(){			
				
				if( $(this).hasClass('clicked') ){
					$(this).removeClass('clicked');
				}
				
			});
		}
		if($(this).attr('id') != 'selectDiv'){	
			if(!$(this).hasClass('clicked')){
				$(this).addClass('clicked');
			}		
		}

	});

  	//keypress
  	function keypress(id, keycode){
  		var press = jQuery.Event("keypress");
  		press.ctrlKey = false;
  		press.which = keycode;
  		$("#"+id).trigger(press);
  	}

  	$('#M00312').on('click',function(e){
	     e.preventDefault()
	     location.href = '<c:url value="bssc0020?id=M00312"/>'
	});
  	$('#M00315').on('click',function(e){
  	     e.preventDefault()
  	     location.href = '<c:url value="bssc0060?id=M00315"/>'
  	});
  	$('#M00316').on('click',function(e){
 	     e.preventDefault()
 	     location.href = '<c:url value="bssc0070?id=M00316"/>'
 	});
  	$('#M00333').on('click',function(e){
 	     e.preventDefault()
 	     <%
 	    String factoryCode4 = session.getAttribute("factoryCode").toString();
			if(factoryCode4.equals("003")) {
		%>
		location.href = '<c:url value="wmsc3070?id=M00333"/>'
		<%	
			} else if(factoryCode4.equals("001") || factoryCode4.equals("002")) {
		%>
		location.href = '<c:url value="wmsc0070?id=M00333"/>'
		<%
			} 
		%>
 	});
  	$('#M00338').on('click',function(e){
 	     e.preventDefault()
 	     location.href = '<c:url value="wmsc0100?id=M00338"/>'
 	});
  	$('#M00354').on('click',function(e){
 	     e.preventDefault()
 	     location.href = '<c:url value="qmsc0130?id=M00354"/>'
 	});
  	$('#M00352').on('click',function(e){
 	     e.preventDefault()
 	    	<%
				if(factoryCode4.equals("003")) {
			%>
 	     	location.href = '<c:url value="qmsc0090?id=M00352"/>'
 	    	<%	
				} else if(factoryCode4.equals("001") || factoryCode4.equals("002")) {
			%>
			location.href = '<c:url value="qmsc2090?id=M00352"/>'
			<%
				} 
			%>
 	});
  	$('#M00350').on('click',function(e){
 	     e.preventDefault()
 	     	<%
 	     		if(factoryCode4.equals("003")){
 	     	%>
 	     	location.href = '<c:url value="qmsc3100?id=M00350"/>'
 	 	    <%
 	     		} else if(factoryCode4.equals("001") || factoryCode4.equals("002")){
 	     	%>
 	     	location.href = '<c:url value="qmsc0100?id=M00350"/>'
 	 	    <%
 	     		}
 	     	%>
 	});
 	$('#M00324').on('click',function(e){
	     e.preventDefault()
	     location.href = '<c:url value="brsc0020?id=M00324"/>'
	});
 	$('#M00392').on('click',function(e){
	     e.preventDefault()
	     location.href = '<c:url value="brsc0030?id=M00392"/>'
	});
</script>