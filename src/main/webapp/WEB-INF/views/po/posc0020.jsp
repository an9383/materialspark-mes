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
					<li class="breadcrumb-item active">생산실적수집</li>
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
										<th style="min-width: 50px">설비명</th>
		                            </tr>
		                        </thead>
                              </table>
                          </div>
						 <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
                   <div class="right-list right-70" id="myrSidenav" style="width:86%;">
                        <form id="form">
                          <div class="table-responsive">
	                    	<table id="workOrderTable" class="table table-bordered">
		                        <thead class="thead-light">
		                        <tr>
	                              <th style="width: 50px" class="text-center"> 제품(기종) </th>
	                              <th style="width: 50px" class="text-center"> 재질 </th>
	                              <th style="width: 120px"class="text-center"> 규격 </th>
	                              <th style="width: 60px" class="text-center"> 표면처리 </th>
	                              <th style="width: 50px" class="text-center"> 거래처 </th>
	                              <th style="width: 80px" class="text-center"> LOT NO </th>
	                              <th style="width: 80px" class="text-center"> 작지번호 </th>
	                              <th style="width: 50px" class="text-center"> 상태 </th>
	                              <th style="width: 50px" class="text-center"> 투입중량 </th>
	                              <th style="width: 50px" class="text-center"> 생산중량1 </th>
	                              <th style="width: 50px" class="text-center"> 생산중량2 </th>
	                              <th style="width: 50px" class="text-center"> 생산수량 </th>	                              	                              
	                              <th style="width: 50px" class="text-center"> 근무조 </th>
	                              <th style="width: 50px" class="text-center"> 담당 </th>
	                            </tr>
		                        </thead>
                            </table>
                         </div>
                        </form>
              </div><!-- /.row -->
            </div><!-- / #main  -->
        </div><!-- /.page-wrapper -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'posc0020';
	let currentHref = 'posc0020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","생산실적수집");

	uiProc(true);	
	
	//공통코드 처리 시작
	var workTeamCode = new Array(); // 설치장소
    <c:forEach items="${workTeamCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		workTeamCode.push(json);
    </c:forEach>

	var equipGroupCode = new Array(); // 설비분류
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>

	var ordGubunCode = new Array(); // 설비분류
    <c:forEach items="${ordGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubunCode.push(json);
    </c:forEach>    
    //공통코드 처리 종료  
    
    // 목록
	var equipCd;		//설비코드 전역변수 선언(작업지시 계획조회, 제조조건 계획 조회 시 사용)    
    //var equipGroup="";
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
    var ordDateCal =  "${serverDate}";
	var ordGubunCd; 

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
	    "drawCallback": function( settings ) {
	    	$('#equipCodeAdmTable tbody tr td').css('height','40px');
	    }
    });
    
	var html1 =  '&nbsp;<label class="input-label-sm">설비그룹</label><select  class="custom-select" id="equipGroupCd" ></select>';
	$('#equipCodeAdmTable_length').html(html1)
	selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");

	$("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
    	ordGubunCd =  $('#ordGubunCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});
	 	$('#workOrderTable').DataTable().clear().draw();
	 	$('#workOrderMatrlTable').DataTable().clear().draw();
	 	equipCd = "";
	 	uiProc(true);
	});

    $('#equipCodeAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }	
        else {
        	$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        uiProc(true);
    	equipCd = equipCodeAdmTable.row( this ).data().equipCd;
    	ordDateCal = $("#ordDate").val();
    	$('#workOrderTable').DataTable().ajax.reload( function () {}); 
    });

    $.fn.dataTable.ext.errMode = 'none';
	let workOrderTable = $('#workOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
		searching: false,
		autoWidth: false,
        ajax: {
            url: '<c:url value="po/workOrderDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
                'equipCd' : function() { return equipCd; }, 
            	'ordDate' : function() { return ordDateCal.replace(/-/g, ''); },
            	'ordGubun' : function() { return ordGubunCd; },        	
            },
// 			success: function (res) {
// 				let data = res.data;
// 				if (res.result != 'ok') {
// 					//toastr.error(res.message);
// 				}
// 			},
// 			complete:function(res){
// 				let data = res.data;
// 				if (res.result != 'ok') {
// 					toastr.error(res.message);
// 				}				
// 			}             
        },
        rowId: 'equipCd',
		columns: [
			{ data: 'goodsNm' },
			{ data: 'qutyNm' },
			{ data: 'model' },
			{ data: 'surfaceTrtmtNm' },
			{ data: 'dealCorpNm' },
			{ data: 'ordLotNo' },
			{ data: 'workOrdNo' },
			{ data: 'workStatusNm' },
			{ data: 'targetWeight',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
			{ data: 'outputWeight1',
	    		render: function(data, type, row, meta) {
		    		var outputWeight1 = data;
		    		if(data == null || data == "") outputWeight1 = "0";
		    		if(row['workStatusCd'] == 'S' ) {
		    			return '<input type="number" min="0" max="' + row['targetWeight'] + '" step="0.1" class="form-control number-float1" id="outputWeight1" name="outputWeight1" value="'+ parseFloat(outputWeight1).toFixed(1) +'" onpaste="return false;" oncopy="return false;">';
		    		} else {
		    			return parseFloat(outputWeight1).toFixed(1);
				    }		
	    		}				
			},
			{ data: 'outputWeight2',
	    		render: function(data, type, row, meta) {
		    		var outputWeight2 = data;
		    		if(data == null || data == "") outputWeight2 = "0";		    		
		    		if(row['workStatusCd'] == 'S' ) {
			    		var html = '<input type="hidden" class="form-control" id="gravity" name="gravity" value="'+row['gravity']+'">';
			    			html += '<input type="number" min="0" max="' + row['targetWeight'] + '" step="0.1"  class="form-control number-float1" id="outputWeight2" name="outputWeight2" value="'+ parseFloat(outputWeight2).toFixed(1) +'" onpaste="return false;" oncopy="return false;">';
			    			return html;
 		    			//return '<input type="text" class="form-control" id="outputWeight2" name="outputWeight2" value="'+outputWeight2+'">';
		    		} else {
		    			return  parseFloat(outputWeight2).toFixed(1);
				    }
	    		}				
			},
			{ data: 'outputCnt'},
			{ data: 'workTeamNm' },			
			{ data: 'mainWorkChargrNm',
	    		render: function(data, type, row, meta) {
		    		var mainWorkChargrNm = data;
		    		if(row['subWorkChargrNm'] != null) mainWorkChargrNm =mainWorkChargrNm +"," + row['subWorkChargrNm'];	
					return mainWorkChargrNm ;
	    		}				
			},	
		],
		columnDefs: [
        	{ targets: [8,9,10,11], render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [8,9,10,11], className: 'text-right' },
        	{ targets: [0,1,2,3,4,5,6,7,12,13], className: 'text-center' },
        ],		
		order: [
			[ 0, 'asc' ],
		],
	    "drawCallback": function( settings ) {
	    	//$('#workOrderTable tbody tr td').css('height','50px');
	    	$('#workOrderTable_paginate').html("&nbsp;");
	    	$('#workOrderTable tbody tr td').css('height','40px');
	    }
    });

	var html3 = '<div class="row">&nbsp;<label class="input-label-sm">작지일</label><div class="form-group input-sub m-0 row">';
		html3 += '<input class="form-control" style="width:97px;" type="text" id="ordDate" name="ordDate" />';
		html3 += '<button onclick="fnPopUpCalendar(ordDate,ordDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="ordDateCalendar" type="button">';
		html3 += '<span class="oi oi-calendar"></span>';
		html3 += '</button>'; 
		html3 += '</div>';
		html3 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">주야</label><select  class="custom-select" id="ordGubunCd" ></select>&nbsp;  <button type="button" class="btn btn-primary" id="btnWorkOrdRetv">조회</button></div>';
		
	$('#workOrderTable_length').html(html3);
	$('#ordDate').val(ordDateCal);
	selectBoxAppend(ordGubunCode, "ordGubunCd", "", "1");
	$('#workOrderTable_paginate').html("&nbsp;");
	
	var workOrdNo;
	var workOrdIndex; 
    $('#workOrderTable tbody').on('click', 'tr', function () {
        
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }	
        else {
        	$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            workOrdNo = workOrderTable.row( this ).data().workOrdNo;
            workOrdIndex = workOrderTable.row( this ).index()+1;
        	uiProc(false);              
        }
    });

	
    $('#btnWorkOrdRetv').on('click', function() {
        if(equipCd != null && equipCd != "" ) {
	    	ordDateCal =  $('#ordDate').val();
	    	ordGubunCd =  $('#ordGubunCd option:selected').val();
			$('#workOrderTable').DataTable().ajax.reload( function () {});
        } else {
        	toastr.warning("설비정보를 선택해 주세요");
        }
    });

	$('#workOrderTable').on('keyup', 'input#outputWeight1', function(e) {
		//alert("workOrderTable = "+e.which);

		if(e.which == 13) {
			 var $row = $(this).closest( "tr" );
             var outputWeight1 = $row.find('#outputWeight1').val().replace(/[^\.0-9]/g,"");
             $row.find('#outputWeight1').val(outputWeight1);
             $row.find('#outputWeight2').select();
    	 //alert("outputWeight1 = "+outputWeight1);	
		}

		var outputWeight1 = $row.find('#outputWeight1').val().replace(/[^\.0-9]/g,""); 
        var outputWeight2 = $row.find('#outputWeight2').val().replace(/[^\.0-9]/g,""); 
        
		var targetWeight =  $row.find('td').eq(8).html(); 
        var outputWeight = parseFloat(outputWeight1) + parseFloat(outputWeight2);
		
		var gravity = $row.find('#gravity').val(); 
		
        var outputCnt = parseInt(parseFloat(outputWeight)/parseFloat(gravity)*1000);
        var targetCnt = parseInt(parseFloat(targetWeight)/parseFloat(gravity)*1000);
        
        var workOrdNo = $row.find('td').eq(6).html();
        $row.find('td').eq(11).text(addCommas(outputCnt));
        
//        var colIndex = +$(this).data('col');
//          var row = $(this).closest('tr')[0];
//          var data = matrlInOutWhsTable.row(row).data();
//          var lotNo = matrlInOutWhsTable.row(row).data().lotNo;2
//          var locationCd = $(this).find(':selected').val();
    });	

	$('#workOrderTable').on('keyup', 'input#outputWeight2', function(e) {
		//alert("workOrderTable = "+e.which);
		if(e.which == 13) {
			 var $row = $(this).closest( "tr" );
             var outputWeight1 = $row.find('#outputWeight1').val().replace(/[^\.0-9]/g,""); 
             var outputWeight2 = $row.find('#outputWeight2').val().replace(/[^\.0-9]/g,""); 
             $row.find('#outputWeight2').val(outputWeight2);
             if(outputWeight1 == null || outputWeight1 == "") {
            	 toastr.warning('생산중량1을 입력해 주세요.');
            	 $row.find('#outputWeight1').select();
            	 return false;
             }
             if(outputWeight2 == null || outputWeight2 == "") {
            	 toastr.warning('생산중량2를 입력해 주세요.');
            	 $row.find('#outputWeight2').select();
            	 return false;
             }

             var targetWeight =  $row.find('td').eq(8).html(); 
             var outputWeight = parseFloat(outputWeight1) + parseFloat(outputWeight2);
             
             //if(parseFloat(outputWeight) > parseFloat(targetWeight)) {
             if(parseFloat(outputWeight) > 100) {
            	 toastr.warning('생산중량 합계가 100kg을 초과할 수 없습니다.<br/> 생산중량을 다시 입력해 주세요.');
            	 $row.find('#outputWeight1').val('0'); 
            	 $row.find('#outputWeight2').val('0'); 
            	 $row.find('#outputWeight1').select();
            	 return false;
             }
             //if(parseFloat(outputWeight) > parseFloat(targetWeight) ) {
            //	 toastr.warning('생상중량 합계가 투입중량을 초과할 수 없습니다.<br/> 확인해주세요.');
            //	 $row.find('#outputWeight1').focus();
            //	 return false;
             //}

             var gravity = $row.find('#gravity').val(); 
             var outputCnt = parseInt(parseFloat(outputWeight)/parseFloat(gravity)*1000);
             var targetCnt = parseInt(parseFloat(targetWeight)/parseFloat(gravity)*1000);
             var workOrdNo = $row.find('td').eq(6).html();
             $row.find('td').eq(11).text(addCommas(outputCnt));
	    	 //alert("targetWeight = "+targetCnt + " ," +outputCnt + " ," +workOrdNo);

             $.ajax({
                 url: '<c:url value="/po/updateWorkOrderResult"/>',
                 type: 'POST',
                 data: {
                	 'menuAuth'	 	: 		menuAuth,
                 	'workOrdNo'   	:       workOrdNo,
                 	'outputWeight1'	: 		outputWeight1,
                 	'outputWeight2'	: 		outputWeight2,                
                 	'outputCnt'   	:       outputCnt,
     	            'targetCnt'     :       targetCnt,
     	            //'workStatusCd'  :       'E',	컨트롤단에서 설정
                 },
                 beforeSend: function() {
                    // $('#btnAddConfirm').addClass('d-none');
                    // $('#btnAddConfirmLoading').removeClass('d-none');
                 },
                 success: function (res) {
                     let data = res.data;
                     if (res.result == 'ok') {
                    	 $('#workOrderTable').DataTable().ajax.reload( function () {});
                   	   	toastr.success('수정되었습니다.');
                     } else {
                    	 toastr.error(res.message, '', {timeOut: 5000});
                     }
                 },
                 complete:function(){
                     $('#btnAddConfirm').removeClass('d-none');
                     $('#btnAddConfirmLoading').addClass('d-none');
                 }
             });
		}		
    });	
    
	//제조조건 계획정보 모달 시작
   	var equipCondCommonAdmTable;
   	var equipCondIdx;
   	function selectEquipCondCommonList(idx)
   	{
   		equipCondIdx = idx;
		if(equipCondCommonAdmTable == null || equipCondCommonAdmTable == undefined)	{

			//해당설비 제조조건 계획List 검색
			equipCondCommonAdmTable = $('#equipCondCommonAdmTable').DataTable({
	        language: lang_kor,
	        paging: true,
	        info: true,
	        ordering: true,
	        processing: true,
	        autoWidth: false,
	        lengthChange: false,
	        pageLength: 20,
	        "destroy": true,
			'ajax': {
					url: '<c:url value="em/manufacturerPlanListRead"/>',
					type: 'GET',
					data: {
						'menuAuth'	 	: 		menuAuth,
						'equipCd': function() { return equipCd; }
					},
				},
				rowId: 'equipCondSeq',
				columns: [
					{ data: 'equipNm' },
					{ data: 'goodsNm' },
					{ data: 'model' },
					{ data: 'condRegDate' },
		  		],
		  		order: [
		  			[ 1, 'desc' ],
		  		],
		    });

			$('#equipCondCommonAdmTable tbody').on('click', 'tr', function () {
				data = equipCondCommonAdmTable.row( this ).data();
				//goodsCd = equipCondCommonAdmTable.row( this ).data().goodsCd;
				//goodsNm = equipCondCommonAdmTable.row( this ).data().goodsNm;
				//equipCondSeq = equipCondCommonAdmTable.row( this ).data().equipCondSeq;
				$('#goodsCd'+equipCondIdx).val(data.goodsCd);
				$('#goodsNm'+equipCondIdx).val(data.goodsNm);
				$('#equipCondSeq'+equipCondIdx).val(data.equipCondSeq);
				$('#qutyNm'+equipCondIdx).text(data.qutyNm);
				$('#surfaceTrtmtNm'+equipCondIdx).text(data.surfaceTrtmtNm);
				$('#model'+equipCondIdx).text(data.model);					
				$('#equipCondCommonAdmModal').modal('hide');
				
		    });
		}
		else {
			$('#equipCondCommonAdmTable').DataTable().ajax.reload();
		}
		
		$('#equipCondCommonAdmModal').modal('show');
   	}
	//제조조건 계획정보 모달 시작 종료
  	
	//거래처정보조회 팝업 시작
   	var dealCorpPopUpTable;
   	var dealCorpIdx;
   	function selectDealCorp(idx)
   	{
   	   	dealCorpIdx = idx; 
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
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
		        rowId: 'dealCorpCd',
		        columns: [
		            { data: 'dealCorpCd' },
		            { data: 'dealCorpNm' },
		            { data: 'initial' },
		            { data: 'presidentNm' },
		            { data: 'country' },
		            { data: 'corpNo' },
		        ],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 1, 'asc' ]
		        ],

		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });

		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
			    
		    	var data = dealCorpPopUpTable.row( this ).data();
				$('#dealCorpCd'+dealCorpIdx).val(data.dealCorpCd);
				$('#dealCorpNm'+dealCorpIdx).val(data.dealCorpNm);
                $('#dealCorpPopUpModal').modal('hide');
		    });
		}
		
		$('#dealCorpPopUpModal').modal('show');		
   	}   	
 	//거래처정보조회 팝업 종료    
  	
   	//담당자조회 팝업 시작
   	var userPopUpTable;
   	var userFlag;
   	var userIdx;
   	function selectWorkCharger(flag, idx)
   	{
   		userFlag = flag;
   		userIdx = idx;
		if(userPopUpTable == null || userPopUpTable == undefined)	{
			userPopUpTable = $('#userPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/sm/matrlUserDataList"/>',
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
		        rowId: 'userNumber',
		        columns: [
						{ data : 'userNm'}, 
						{ data : 'departmentNm'	}, 
						{ data : 'postNm' }, 
						{ data : 'chargrDutyNm'	}, 
						{ data : 'teamNm' }, 
						{ data : 'workplaceNm' },
		        ],
		        columnDefs: [
		        	//{ "targets": [0], "visible" : true },
		        	{ "targets": [0,1,2,3,4],  "className": "text-center"}
		        ],
		        order: [
		            [ 0, 'desc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#userPopUpTable tbody').on('click', 'tr', function () {
			    
		    	var data = userPopUpTable.row( this ).data();
				if(userFlag == 'main') {
	                $('#mainWorkChargr'+userIdx).val(data.userNumber);
	                $('#mainWorkChargrNm'+userIdx).val(data.userNm);					
				} else {
	                $('#subWorkChargr'+userIdx).val(data.userNumber);
	                $('#subWorkChargrNm'+userIdx).val(data.userNm);					
				}

                $('#userPopUpModal').modal('hide');
		    });
		}
		    

		$('#userPopUpModal').modal('show');	
   	}
  	//담당자조회 팝업 종료

   	function uiProc(flag)
   	{
        $("#barcodeNo").attr("disabled",flag);                
        $("#btnDelete").attr("disabled",flag); 
        $("#btnSave").attr("disabled",flag);       
        $("#barcodeNo").val("");
   	}

   	$(document).on('click','.number-float1', function(event) {
   		$(this).select();
   	});
   	
    //숫자만 입력, 길이, 소수점 한자리까지 제한
    //ajax로 추가되는 부분이라 document로 해줘야 스크립트 먹힘
    $(document).on('keyup','.number-float1', function(event) {
		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
			$('.number-float1').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			return false;
		}
 		//if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 		//	$(this).val("0");
		//	toastr.warning('최대 크기를 초과하였습니다.');
		//	return false;
		//}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최소 크기를 초과하였습니다.');
			return false;
		}

 		var _pattern2 = /^\d*[.]\d{2}$/;
        if (_pattern2.test( $(this).val())) {
        	toastr.warning("소수점 첫째 자리까지 입력 가능합니다.");
            $(this).val("0");
            return false;
        }
        
 		if($(this).val().split('.').length >= 3) {
			toastr.warning('소수점기호는 한번만 입력 가능합니다.');
			$(this).val("0");
			return false;
		} 		
  	});
</script>
</body>
</html>
