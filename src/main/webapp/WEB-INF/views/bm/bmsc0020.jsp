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
				<li class="breadcrumb-item active">거래처정보관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 71%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="dealCorpTable" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>거래처코드</th>
									<th>거래처명</th>
									<th>이니셜</th>
									<th>대표자</th>
									<th>국가명</th>
									<th>사업자번호</th>
									<th>법인번호</th>
									<th>업태</th>
									<th>종목</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
                  <div class="right-list right-sidebar" id="myrSidenav" style="width:28%;">
                      <div class="card" id="formBox">
                        <div class="card-body col-sm-12">
	                        <div class="rightsidebar-close">
								<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()"><i class="mdi mdi-close"></i></a>
							</div>
                            <button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
                            <button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
                        </div>
                        <form id="form">
						<div class="table-responsive">
							<table class="table table-bordered">     
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								<col width="30%">	                            
	                        </colgroup>
	                        <tr>
								<th>거래처코드</th>
								<td><input type="text" class="form-control" id="dealCorpCd" name="dealCorpCd"></td>
								<th>*거래처명</th>
								<td><input maxlength="25" type="text" class="form-control" id="dealCorpNm"  name="dealCorpNm" maxlength="25"></td>	                            
	                        </tr>
	                        <tr>
	                            <th>*이니셜</th>
	                            <td><input maxlength="25" type="text" class="form-control" id="initial"  name="initial" maxlength="25"></td>	                        
	                            <th>대표자</th>
	                            <td><input maxlength="10" type="text" class="form-control" id="presidentNm"  name="presidentNm" maxlength="10"></td>
	                        </tr>
	                        <tr>
	                            <th>국가명</th>
	                            <td><input maxlength="25" type="text" class="form-control" id="country"  name="country" maxlength="10"></td>
	                            <th>사업자번호</th>
	                            <td><input maxlength="20" type="text" class="form-control" id="corpNo"  name="corpNo" maxlength="20"></td>
	                        </tr>
	                        <tr>
	                            <th>법인번호</th>
	                            <td><input maxlength="20" type="text" class="form-control" id="registNo"  name="registNo"></td>
	                            <th>업태</th>
	                            <td><input maxlength="10" type="text" class="form-control" id="bizCond"  name="bizCond"></td>
	                        </tr>
	                        <tr>
	                            <th>우편번호</th>
	                            <td><input maxlength="6" type="text" class="form-control" id="addrNo"  name="addrNo" maxlength="6"></td>
	                            <th>업종</th>
	                            <td><input maxlength="10" type="text" class="form-control" id="bizType"  name="bizType"></td>
	                        </tr>
	                        <tr>
	                            <th rowspan="2">주소</th>
	                            <td colspan="3"><input maxlength="64" type="text" style="max-width:100%" class="form-control" id="addrBase"  name="addrBase" maxlength="64"></td>
	                       </tr>
	                       <tr>
	                            <td colspan="3"><input maxlength="64" type="text" style="max-width:100%" class="form-control" id="addrDtl"  name="addrDtl" maxlength="64"></td>
	                       </tr>
	                        <tr>
	                            <th>전화번호</th>
	                            <td><input maxlength="20" type="text" class="form-control" id="telNo"  name="telNo" maxlength="20"></td>
	                            <th>팩스번호</th>
	                            <td><input maxlength="20" type="text" class="form-control" id="faxNo"  name="faxNo"></td>
	                        </tr>
	                        <tr>
	                            <th>과세</th>
	                            <td><input maxlength="10" type="text" class="form-control" id="tax"  name="tax"></td>
	                            <th>E-mail</th>
	                            <td><input maxlength="64" type="text" class="form-control" id="emailAddr"  name="emailAddr"></td>
	                        </tr>
	                        <tr>
	                            <th>업무담당</th>
	                            <td><input maxlength="10" type="text" class="form-control" id="officeChrger"  name="officeChrger"></td>
	                            <th>영업담당</th>
	                            <td><input maxlength="10" type="text" class="form-control" id="bizChrger"  name="bizChrger"></td>
	                        </tr>
	                        <tr>
	                        	<input type="hidden" class="form-control" id="dealGubun"  name="dealGubun">
	                            <th>*거래구분</th>
	                            <td colspan="3">
                    				<input type="checkbox"  id="sales"  name="sales">매출 
                    				<input type="checkbox"  id="purchase"  name="purchase">매입
                    				<input type="checkbox"  id="inwhs"  name="inwhs">입고
                    				<input type="checkbox"  id="outwhs"  name="outwhs">출고
                    				<input type="checkbox"  id="materials"  name="materials">자재
                    				<input type="checkbox"  id="etcetc"  name="etcetc">기타
	                            </td>
	                        </tr>	                        
	                        <tr>
	                            <th>*사용여부</th>
	                            <td><select class="custom-select" id="useYnCd" ></select></td>
								<th>비고</th>
	                            <td><input maxlength="256" type="text" class="form-control" id="dealCorpDesc"  name="dealCorpDesc"></td>	                            
	                        </tr>
	                        <tr class="d-none" id="dealCorpInfoTr">
	                        	<th>거래처정보</th>
	                            <td><select class="custom-select" id="dealCorpInfo" ></select></td>
	                            <th></th>
	                            <td></td>
	                        </tr>	                        	                        		                        	                        		                        	                        	                        
                               <!--==========/table 내용 추가==========-->
                            </table>
						</div>
					</form>
				</div>
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled="">
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
				</div>
			</div><!-- ===/.right-sidebar 등록,수정===  -->
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'bmsc0020';
	let currentHref = 'bmsc0020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","거래처정보관리");
	
    let viewIdx;
    let sideView = 'add';
    $("#dealCorpCd").attr("disabled",true);
	uiProc(true);

    //공통코드 처리 시작
    var useYnCode=new Array();
    <c:forEach items="${useYnCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		useYnCode.push(json);
    </c:forEach>
    
    var dealCorpInfoCode=new Array();
    <c:forEach items="${dealCorpInfoCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		dealCorpInfoCode.push(json);
    </c:forEach>
	//공통코드 처리 종료
	
	let factoryCode = "<%=factoryCode%>";
	
	if( factoryCode == "003" ) {
		$('#dealCorpInfoTr').removeClass('d-none');
	}

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let dealCorpTable = $('#dealCorpTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6 wj-100'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: false,
        pageLength: 20,
        //scrollY : 500,
       //responsive: true,
        ajax: {
            url: '<c:url value="/bm/dealCorpDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth' 	: menuAuth,
            	'useYnCd'	: 'Y'
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'dealCorpCd',
        columns: [
            { data: 'dealCorpCd' },
            { data: 'dealCorpNm' },
            { data: 'initial' },
            { data: 'presidentNm' },
            { data: 'country' },
            { data: 'corpNo' },
            { data: 'registNo' },
            { data: 'bizCond' }, 
            { data: 'bizType' }                                              
        ],
        columnDefs: [
            {
                //'targets': [0],
                //'orderable': false,
                //'searchable': false,
            },
        ],
        order: [
            [ 0, 'desc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '거래처정보관리',
            },
            {
                extend: 'excel',
                title: '거래처정보관리',
            },
            {
                extend: 'print',
                title: '거래처정보관리',
            }
        ],
    });

    // 보기
    $('#dealCorpTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#dealCorpTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
                
    	dealCorpCd = dealCorpTable.row( this ).data().dealCorpCd;
        //console.log("dealCorpCd = " + dealCorpCd);
        $('#btnSave').addClass('d-none');  // 저장버튼
        $.ajax({
            url: '<c:url value="/bm/dealCorpData"/>',
            type: 'GET',
            data: {
            	'menuAuth'	: menuAuth,                
                'dealCorpCd': dealCorpCd
            },
            success: function (res) {
                let data = res.data;
      			let statusYn = res.statusYn;
      			sideView = 'edit';
      			
                // 보기
                $('#dealCorpCd').val(data.dealCorpCd);
                $('#dealCorpNm').val(data.dealCorpNm);
                $('#initial').val(data.initial);
                $('#presidentNm').val(data.presidentNm);
                $('#country').val(data.country);
                $('#corpNo').val(data.corpNo);
                $('#registNo').val(data.registNo);
                $('#bizCond').val(data.bizCond);
                $('#bizType').val(data.bizType);
                $('#addrNo').val(data.addrNo);
                $('#addrBase').val(data.addrBase);
                $('#addrDtl').val(data.addrDtl);
                $('#telNo').val(data.telNo);
                $('#faxNo').val(data.faxNo);
                $('#emailAddr').val(data.emailAddr);
                $('#tax').val(data.tax);
                $('#officeChrger').val(data.officeChrger);
                $('#bizChrger').val(data.bizChrger);
                $('#dealGubun').val(data.dealGubun);
                $('#useYnCd').val(data.useYnCd);
                $('#dealCorpDesc').val(data.dealCorpDesc);
                $('#dealCorpInfo').val(data.dealCorpInfo);
                
				//checkbox처리
                sales = data.dealGubun.substring(0,1);
                purchase = data.dealGubun.substring(1,2);
                inwhs = data.dealGubun.substring(2,3);
                outwhs = data.dealGubun.substring(3,4);
                materials = data.dealGubun.substring(4,5);
                etcetc = data.dealGubun.substring(5,6);
                if(sales == "1") {
                	$('#sales').prop("checked", true);
                } else {
                	$('#sales').prop("checked", false);
				}
                if(purchase == "1") {
                	$('#purchase').prop("checked", true);
                } else {
                	$('#purchase').prop("checked", false);
				}
                if(inwhs == "1") {
                	$('#inwhs').prop("checked", true);
                } else {
                	$('#inwhs').prop("checked", false);
				}
                if(outwhs == "1") {
                	$('#outwhs').prop("checked", true);
                } else {
                	$('#outwhs').prop("checked", false);
				}
                if(materials == "1") {
                	$('#materials').prop("checked", true);
                } else {
                	$('#materials').prop("checked", false);
				}
                if(etcetc == "1") {
                	$('#etcetc').prop("checked", true);
                } else {
                	$('#etcetc').prop("checked", false);
				}

                uiProc(true);
                selectBoxAppend(useYnCode, "useYnCd", data.useYnCd , "");
                if( factoryCode == "003" ) {
                	selectBoxAppend(dealCorpInfoCode, "dealCorpInfo", data.dealCorpInfo , "2");
                }
            }
        });
    });

    // 등록폼
    $('#btnAdd').on('click', function() {
        sideView = 'add';
        $('#form').each(function(){
            this.reset();
        });

        uiProc(false); 
        selectBoxAppend(useYnCode, "useYnCd", "001", "2");
        if( factoryCode == "003" ) {
        	selectBoxAppend(dealCorpInfoCode, "dealCorpInfo", "" , "2");
        }
        $('#btnSave').removeClass('d-none');  // 등록버튼
    });

    // 저장 처리
    $('#btnSave').on('click', function() {
       
        if ( !$.trim($('#dealCorpNm').val()) ) {
            toastr.warning('거래처명을 입력해주세요.');
            $('#dealCorpNm').focus();
            return false;
        }
        if ( !$.trim($('#initial').val()) ) {
            toastr.warning('이니셜을 입력해주세요.');
            $('#initial').focus();
            return false;
        }
        //if ( !$.trim($('#presidentNm').val()) ) {
        //    toastr.warning('대표자명을 입력해 주세요.');
        //    $('#presidentNm').focus();
        //    return false;
        //}
        //if ( !$.trim($('#country').val()) ) {
        //    toastr.warning('국가명을 입력해 주세요.');
        //    $('#country').focus();
        //    return false;
        //}
        //if ( !$.trim($('#corpNo').val()) ) {
        //    toastr.warning('사업자번호를 입력해 주세요.');
        //    $('#corpNo').focus();
        //    return false;
        //}
        //if ( !$.trim($('#addrNo').val()) ) {
        //    toastr.warning('우편번호를 입력해 주세요.');
        //    $('#addrNo').focus();
        //    return false;
        //}
        //if ( !$.trim($('#addrBase').val()) ) {
        //    toastr.warning('주소를 입력해 주세요.');
        //    $('#addrBase').focus();
        //    return false;
        //}       
        //if ( !$.trim($('#telNo').val()) ) {
        //    toastr.warning('전화번호를 입력해 주세요.');
        //    $('#telNo').focus();
        //    return false;
        //}  
		if ($('#sales').prop("checked") == false && $('#purchase').prop("checked") == false &&$('#inwhs').prop("checked") == false &&$('#outwhs').prop("checked") == false &&$('#materials').prop("checked") == false){
			$('#sales').focus();
			toastr.warning('거래구분을 체크해주세요.(다중체크 가능)');
			//var e = $.Event('keypress');
		    //$('#lb').trigger(e);
			return false;
		}
		
		if ( !$.trim($('#dealCorpInfo option:selected').val()) ) {
            toastr.warning('거래처정보를 선택해주세요.');
            $('#dealCorpInfo').focus();
            return false;
        }

        var sales = "0";
        if($('#sales').prop("checked") == true) {
        	sales = "1";
        }
        var purchase = "0";
        if($('#purchase').prop("checked") == true) {
        	purchase = "1";
        }        
        var inwhs = "0";
        if($('#inwhs').prop("checked") == true) {
        	inwhs = "1";
        }        
        var outwhs = "0";
        if($('#outwhs').prop("checked") == true) {
        	outwhs = "1";
        }        
        var materials = "0";
        if($('#materials').prop("checked") == true) {
        	materials = "1";
        } 
        var etcetc = "0";
        if($('#etcetc').prop("checked") == true) {
        	etcetc = "1";
        }
        
        $('#dealGubun').val(sales+purchase+inwhs+outwhs+materials+etcetc);

        if ( $("#useYnCd option:selected").val() == "" ) {
            toastr.warning('사용여부를 선택해주세요.');
            $('#useYnCd').focus();
            return false;
        }
          
        var url = '/bm/dealCorpCreate';        
        if( sideView == "edit" ) {
            url = '/bm/dealCorpUpdate'
        }

        $.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'		: 		menuAuth,
            	'dealCorpCd'   	:        $('#dealCorpCd').val(),                
            	'dealCorpNm'   	:        $('#dealCorpNm').val(),
	            'initial'       :        $('#initial').val(),
	            'presidentNm'   :        $('#presidentNm').val(),
	            'country'       :        $('#country').val(),
	            'corpNo'        :        $('#corpNo').val(),
	            'registNo'      :        $('#registNo').val(),
	            'bizCond'       :        $('#bizCond').val(),
	            'bizType'       :        $('#bizType').val(),
	            'addrNo'        :        $('#addrNo').val(),
	            'addrBase'      :        $('#addrBase').val(),
	            'addrDtl'       :        $('#addrDtl').val(),
	            'telNo'         :        $('#telNo').val(),
	            'faxNo'         :        $('#faxNo').val(),
	            'emailAddr'     :        $('#emailAddr').val(),
	            'tax'           :        $('#tax').val(),
	            'officeChrger'  :        $('#officeChrger').val(),
	            'bizChrger'     :        $('#bizChrger').val(),
	            'dealGubun'     :        $('#dealGubun').val(),
	            'useYnCd'       :        $("#useYnCd option:selected").val(),
	            'dealCorpInfo'  :        $("#dealCorpInfo option:selected").val(),
	            'dealCorpDesc' 	:        $('#dealCorpDesc').val(),
	           // 'regId'			:		'reg_id',
	           // 'updId'			:		'upd_id'
            },
            beforeSend: function() {
               // $('#btnAddConfirm').addClass('d-none');
               // $('#btnAddConfirmLoading').removeClass('d-none');
            },
            success: function (res) {
                let data = res.data;

                if (res.result == 'ok') {
                    // 보기
					$('#dealCorpCd').val(data.dealCorpCd);
                    $('#dealCorpTable').DataTable().ajax.reload( function () {});
                    uiProc(true);
                    $('#btnSave').addClass('d-none');
                   if( sideView == "edit" ) {
                	   toastr.success('수정되었습니다.');
                    } else {
                        toastr.success('등록되었습니다.');
                    }
                   
                   	sideView = 'edit';
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
                $('#btnAddConfirm').removeClass('d-none');
                $('#btnAddConfirmLoading').addClass('d-none');
            }
        });
    });

    // 수정폼
    $('#btnEdit').on('click', function() {
        //alert(sideView);        
        if(sideView != 'edit') {
        	toastr.warning("수정할 목록을 선택해 주세요!");
            return false;
        }

		uiProc(false);
        $('#btnSave').removeClass('d-none');
    });

   	function uiProc(flag)
   	{
        //$("#dealCorpCd").attr("disabled",flag);
        $("#dealCorpNm").attr("disabled",flag);                
        $("#initial").attr("disabled",flag);               
        $("#presidentNm").attr("disabled",flag);                 
        $("#country").attr("disabled",flag);   
        $("#corpNo").attr("disabled",flag);
        $("#registNo").attr("disabled",flag);
        $("#bizCond").attr("disabled",flag);
        $("#bizType").attr("disabled",flag);
        $("#addrNo").attr("disabled",flag);  
        $("#addrBase").attr("disabled",flag); 
        $("#addrDtl").attr("disabled",flag);
        $("#telNo").attr("disabled",flag);
        $("#faxNo").attr("disabled",flag);
        $("#emailAddr").attr("disabled",flag);  
        $("#tax").attr("disabled",flag);
        $("#officeChrger").attr("disabled",flag);
        $("#bizChrger").attr("disabled",flag);                                
        $("#dealGubun").attr("disabled",flag);                                                               
        $("#useYnCd").attr("disabled",flag);
        $("#dealCorpInfo").attr("disabled",flag);
        $("#dealCorpDesc").attr("disabled",flag);       
        $("#sales").attr("disabled",flag);
        $("#purchase").attr("disabled",flag);
        $("#inwhs").attr("disabled",flag);
        $("#outwhs").attr("disabled",flag);
        $("#materials").attr("disabled",flag);
        $("#etcetc").attr("disabled",flag);
   	}

</script>

</body>
</html>
