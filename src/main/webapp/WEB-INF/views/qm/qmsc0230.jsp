<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">이상발생보고</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table id="stateTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>				
								<th style="min-width:10px" class="text-center" rowspan="">
									<input type="checkbox" id="checkAll" name="checkAll" style="min-width: 10px; width: 20px; height: 20px;">
								</th>			
		                        <th rowspan="" style="min-width: 70px"  class="text-center">이상발생번호</th>
		                        <th rowspan="" style="min-width: 70px"  class="text-center">이상발생내용</th>
		                        <th rowspan="" style="min-width: 70px"  class="text-center">폐기구분</th>
		                        <th rowspan="" style="min-width: 70px"  class="text-center">생산일</th>
		                        <th rowspan="" style="min-width: 70px"  class="text-center">검사일</th>
		                        <th rowspan="" style="min-width: 80px"  class="text-center">생산작업자</th>
		                        <th rowspan="" style="min-width: 50px"  class="text-center">검사자</th>		         
		                        <th rowspan="" style="min-width: 50px"  class="text-center">설비명</th>
		                        <th rowspan="" style="min-width: 100px" class="text-center">트레이번호</th>
		                        <th rowspan="" style="min-width: 100px" class="text-center">이상 발생 수량</th>
		                        <th rowspan="" style="min-width: 100px" class="text-center">담당 부서</th>		                        
		                        <th rowspan="" style="min-width: 100px" class="text-center">담당자</th>
		                        <th rowspan="" style="min-width: 100px" class="text-center">격리 여부</th>
		                        <th rowspan="" style="min-width: 100px" class="text-center">종결 문서</th>
		                        <th rowspan="" style="min-width: 100px" class="text-center">해당 불량 발생 수량</th>
		                        <th rowspan="" style="min-width: 100px" class="text-center">누적 횟수</th>
		                        
							</tr>							
						</thead>						
					</table>
				</div>
			<!-- /.table-responsive -->		
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->
<!-- 폐기지정 확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="disPoseCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="disPoseCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>폐기지정 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label style="font-size: 15px;font-weight: 600;">폐기지정 하시겠습니까?</label>				
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-danger touch6" id="btnModalDisPose" >폐기지정</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 폐기지정 확인 모달 종료-->

<!-- 폐기지정취소 확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="disPoseCancelCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="disPoseCancelCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>폐기지정취소 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label style="font-size: 15px;font-weight: 600;">폐기지정취소 하시겠습니까?</label>				
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-success touch6" id="btnModalDisPoseCancel" >폐기지정취소</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 폐기지정취소 확인 모달 종료-->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc0230';
	let currentHref = 'qmsc0230';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "이상발생보고");
	
	let serverDateFrom 	= "${serverDateFrom}";
	let chooseDate1 	= "${serverDateFrom}";
	let chooseDate2 	= "${serverDate}";
	let reInspStatusArr = ['001', '003'];
	let dateCheck = '001';
	let inspStatus = '';
	let equipCd = '';
	let tableIdx = 0;
	let factoryCode = "<%=factoryCode%>";
	let matrlLotNo = null;
	let disposeGubun = '';
	
	//공통코드 처리 시작
    let equipCode = new Array(); // 설비코드
    <c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";	
		equipCode.push(json);
    </c:forEach>
    
    let inspStatusCode = new Array(); // 검사상태
    <c:forEach items="${inspStatus}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		inspStatusCode.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    var goodsFaultyBigNameCd=new Array();	//엣지검사 대분류
    <c:forEach items="${goodsFaultyBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyBigNameCd.push(json);
    </c:forEach>
    
	var systemCommonCode=new Array();	//외관검사 소분류
    <c:forEach items="${systemCommonCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";
		json.etc4="${info.etc4}";
		json.etc5="${info.etc5}";		
		systemCommonCode.push(json);
    </c:forEach>

	var departmentCode=new Array();	//부서
    <c:forEach items="${departmentCode}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";	
		departmentCode.push(json);
    </c:forEach>

	var abnormalPrcssCode=new Array();	//이상발생 공정
    <c:forEach items="${abnormalPrcssCode}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";		
		abnormalPrcssCode.push(json);
    </c:forEach>

	var isolationCode =new Array();	//OK / NG   
	var json=new Object();
	json.baseCd="001";
	json.baseCdNm="YES";		
	isolationCode.push(json);
	json=new Object();
	json.baseCd="002";
	json.baseCdNm="NO";		
	isolationCode.push(json);    

	var disposeGubunCode =new Array();	//OK / NG   
	var json=new Object();
	json.baseCd="002";
	json.baseCdNm="이상발생";		
	disposeGubunCode.push(json);
	json=new Object();
	json.baseCd="003";
	json.baseCdNm="폐기지정";		
	disposeGubunCode.push(json); 

	//$('#my-spinner').show();

	selectBoxAppend(isolationCode, "isolationYn", "", "");
	selectBoxAppend(abnormalPrcssCode, "abnormalPrcss", "", "");
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	var stateTable = $('#stateTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-11 col-md-9'l><'col-sm-13 col-md-3'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        language: lang_kor,
        paging: true,
        info: true,
        processing: true,
        autoWidth: false,       
        pageLength: -1,
        info: true,
        processing: true,
        autoWidth: false,
        scrollY: "54vh",
       
        lengthChange : true,
        
        ajax: {
            url: '<c:url value="/qm/goodsDisposeList"/>',
            type: 'GET',
            data: {
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },			
				'dateCheck'			:	function() { return dateCheck; },
				'equipCd'			:	function() { return equipCd; },
				'matrlLotNo'		:	function() { return matrlLotNo;},
				'disposeGubun'		:	function() { return disposeGubun;},
				
            },          
        },
        rowId: 'idx',
        columns: [        
        	{
	    		render: function(data, type, row, meta) {
					return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width: 20px; height: 20px;">';
	    		}
			},
        	{ data: 'abnormalNo', 'className' : 'text-center' },
        	{ data: 'abnormalDesc', 'className' : 'text-center' },
        	{ data: 'disposeGubunNm', 'className' : 'text-center' },
        	{
        		data: 'productDate',
        		render : function(data, type, row, meta){
        			if(data != null & data != ''){
        				return moment(data).format('YYYY-MM-DD');
        			} else {
        				return '';
        			}
        		},
				'className' : 'text-center'
        	},
        	{
        		data: 'inspctDate',
        		render : function(data, type, row, meta){
        			if(data != null & data != ''){
        				return moment(data).format('YYYY-MM-DD');
        			} else {
        				return '';
        			}
        		},
				'className' : 'text-center'
        	},
        	{ data: 'workChargrNm', 'className' : 'text-center' },
        	{ data: 'inspctChargrNm', 'className' : 'text-center' },
        	{ data: 'equipNm', 'className' : 'text-center' },
        	{ data: 'labelLotNoSeq', 'className' : 'text-center' },
        	{ data: 'abnormalCnt' },
        	{ data: 'departmentNm', 'className' : 'text-center' },
        	{ data: 'managerNm', 'className' : 'text-center' },
        	{ data: 'isolationYnNm', 'className' : 'text-center' },
        	{ data: 'fileNm', 'className' : 'text-center',
        		render : function(data, type, row, meta){
        			if(data != null & data != ''){
            			var html = '';
        				//html += '<div class="form-group" id="fileTag" name="fileTag" style="height: 20px; vertical-align:middle;">';
						html += '<a id="fpHref'+meta.row+'" href="qm/downloadDisposeFile?abnormalNo='+row['abnormalNo']+'&fileNm='+row['fileNm']+'"><span style="font-size: 14px;" id="fpFn"></span> <span style="font-size: 10px; vertical-align: bottom;" id="imageFileSize">'+data+'</span></a>';
						//html += '</div>';
						return html;
        			} else {
        				return '';
        			}
        		},


             },
        	{ data: 'faultyCnt' },
        	{ data: 'accCnt' },       	

        	
        ],
        rowsGroup: [ [1], [2], [12], [13], [14], [16] ],        
        columnDefs: [
        	{ targets: [10,15,16], render: $.fn.dataTable.render.number( ',' ) },            	
            { targets: [10,15,16], className: 'text-right' }, 
            { "targets": [0], "orderable" : false },
        ],
        order: [
             [ 4, 'asc' ], [ 9, 'asc' ]
        ],
        buttons: ['copy', 'excel', 'print'],
        drawCallback: function () {
        //	$('#stateTable tfoot').remove();			
        //
        //	let sumInsp				= $('#stateTable').DataTable().column(15,{ page: 'all'} ).data().sum();
		//	let sumOutput			= $('#stateTable').DataTable().column(16,{ page: 'all'} ).data().sum();
		//	let sumFaulty			= $('#stateTable').DataTable().column(17,{ page: 'all'} ).data().sum();
		//	let sumSample   		= $('#stateTable').DataTable().column(19,{ page: 'all'} ).data().sum();
		//	let sumThreeTrayWeight	= $('#stateTable').DataTable().column(20,{ page: 'all'} ).data().sum();
		//	
		//	$('#sumInsp').html(addCommas(sumInsp));
        //    $('#sumOutput').html(addCommas(sumOutput));
        //    $('#sumFaulty').html(addCommas(sumFaulty));
        //    $('#sumSample').html(addCommas(sumSample));
        //    $('#sumThreeTrayWeight').html(addCommas(sumThreeTrayWeight.toFixed(3)));
        //    
        //
		//	
		//	$('#gubunFaultySum1').html(addCommas(gubunFaultySum1/3));
		//	$('#gubunFaultySum2').html(addCommas(gubunFaultySum2/3));			

        	$('input[name=checkAll]').on('click', function(){
				if($('input[name=checkAll]').eq(length-1).prop("checked")) { 	
					$("input[type=checkbox]:checkbox:not(:disabled)").prop("checked", true); 
				} else { 
					$("input[type=checkbox]").prop("checked",false);
				}
		    });
          
  
        }
	});
	
	$('#infoDiv').insertAfter('.btn.btn-secondary.buttons-print');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[0]).attr('style', 'height: 25px;');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[1]).attr('style', 'height: 25px;');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[2]).attr('style', 'height: 25px;');

	stateTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		stateTable.columns.adjust();
	});	
	
	var html1 = '<div class="row">';
	html1 += '<select class="custom-select mr-2" id="dateCheck" style="width:100px;">';
	html1 += '<option value="003">이상발생일</option>';
	html1 += '<option value="001">생산일</option>';
	html1 += '<option value="002">검사일</option>';	
	html1 += '</select>';
	
	//기간
	html1 += '<div class="row" id="inputPeriod">';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input type="date" class="form-control" style="width:97px;" id="chooseDateFrom" name="chooseDateFrom" />';
	html1 += '</div>';
	
	html1 += '<label class="input-label-sm ml-2">~</label>';
	
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input type="date" class="form-control" style="width:97px;" id="chooseDateTo" name="chooseDateTo" />';
	html1 += '</div>&nbsp;&nbsp;';
	html1 += '</div>';

	html1 += '<div class="multipleSelection pos-real mr-2">';
	html1 += '<label class="input-label-sm ml-1">폐기구분</label>';
	html1 += '<select class="custom-select custom-select1 w-120" id="disposeGubun">';
	html1 += '</select>';
	html1 += '</div>';
	
	html1 += '<div class="multipleSelection pos-real mr-2">';
	html1 += '<label class="input-label-sm ml-1">설비명</label>';
	html1 += '<select class="custom-select custom-select1 w-120" id="equipCd">';
	html1 += '</select>';
	html1 += '</div>';
	
	//html1 += '<label class="input-label-sm ml-1">검사상태</label><select class="custom-select" id="inspStatusSelect" style="width:80px;"></select>';
	
	html1 += '&nbsp;&nbsp;<label class="input-label-sm ml-1">자재LOT</label>';
	html1 += '<div class="form-group-100 mr-4">';
	html1 += '<input type="text" class="form-control" id="matrlLotNo" style="min-width:130px;">';
	html1 += '</div>';

	html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
	html1 += '&nbsp;<button type="button"  class="btn btn-danger ml-2" id="btnDispose">폐기대상지정</button>';
	html1 += '&nbsp;<button type="button"  class="btn btn-success ml-2" id="btnDisCancel">폐기지정취소</button>';
	//html1 += '&nbsp;<button type="button"  class="btn btn-success ml-2" id="btnExcelDownload">excel</button>';
	//html1 += '&nbsp;<button type="button" class="btn btn-warning ml-2" id="btnWarning">이상발생</button>';
	
	html1 += '</div>';
	
	$('#stateTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	 selectBoxAppend(inspStatusCode, "inspStatusSelect", "" , "1");  
	 selectBoxAppend(equipCode, "equipCd", "" , "1");
	 selectBoxAppend(disposeGubunCode, "disposeGubun", "" , "1");
	 
	//조회 버튼 클릭
	$('#btnRetv').on('click', function() {
		
		
		dateCheck = $('#dateCheck').val();		
		chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();		
  		matrlLotNo = $('#matrlLotNo').val();  		
  		equipCd		= $('#equipCd').val();
  		disposeGubun = $('#disposeGubun').val();
  		
  		$('#stateTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});

   	
  	//담당 조회
   	var userPopUpTable;
   	function selectChargr()
   	{
		if(userPopUpTable == null || userPopUpTable == undefined)	{
			userPopUpTable = $('#userPopUpTable').DataTable({		        
				language: lang_kor,
		        lengthChange : false,
		        destroy:true,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
				//ordering: false,
				ajax : {
					url : '<c:url value="/sm/matrlUserDataList"/>',
					type : 'GET',
					data : { 
							'menuAuth' : menuAuth,
						}
				},
				rowId : 'userNm',
				columns : 
					
					[ 
						{data : 'userNm'}, 
						{data : 'departmentNm'},
						{data : 'postNm'},
						{data : 'chargrDuty'},
						{data : 'teamNm'},				
						{data : 'workplaceNm'}					
					
				],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		       
			});
			$('#userPopUpTable tbody').on('click', 'tr', function () {

		    	var data = userPopUpTable.row( this ).data();
		    	$('#manager').val(data.userNumber);
		    	$('#managerNm').val(data.userNm);									
				$('#userPopUpModal').modal('hide');			
		    });
			
			
		}
		$('#userPopUpModal').modal('show');
			
   	}

   	$('#btnDispose').on('click', function() {
   		var checkbox = $("input[name=chk]:checked");
   		var checkboxCnt = 0;	
   		var errorFlag = false;	
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {	
			var tr 			= checkbox.parent().parent().eq(i);			
			var td 			= tr.children();
			var rowData 	= new Object();
			
			var data = $('#stateTable').DataTable().row(tr).data();
			if(data.disposeGubun == "003"){
				errorFlag = true;
				return false;
			} 		
			checkboxCnt += 1;
		});		
		
		if(errorFlag){
			toastr.warning("이미 폐기지정된 트레이가 있습니다.");
			$('#my-spinner').hide();
			return false;
		}
		if( checkboxCnt == 0){
			toastr.warning("선택된 트레이가 없습니다.");
			$('#my-spinner').hide();
			return false;
		}
   		$('#disPoseCheckPopUpModal').modal('show');

	});

	$('#btnModalDisPose').on('click', function() {
   		
   		var dataArray = new Array();
		var checkbox = $("input[name=chk]:checked");
		var checkboxCnt = 0;
		
		var errorFlag = false;
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			var tr 			= checkbox.parent().parent().eq(i);			
			var td 			= tr.children();
			var rowData 	= new Object();
			
			var data = $('#stateTable').DataTable().row(tr).data();
			
			rowData.labelLotNo 	= data.labelLotNoSeq;				

			dataArray.push(rowData);
			checkboxCnt += 1;
		});				

		if( checkboxCnt == 0){
			toastr.warning("선택된 트레이가 없습니다.");
			$('#my-spinner').hide();
			return false;
		}
        $.ajax({
            url: '<c:url value="/qm/goodsDisposeAppoint"/>',
            type: 'POST',
            dataType: 'json',
            async: false,
            data : JSON.stringify(dataArray),
            contentType : "application/json; charset=UTF-8",          
            success: function (res) {              
                if (res.result == 'ok') {
                	toastr.success("폐기지정 취소 되었습니다.");
            		$('#stateTable').DataTable().ajax.reload( function () {});
            		$("#checkAll").prop("checked", false);            		
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#disPoseCheckPopUpModal').modal('hide');
            	$('#my-spinner').hide();
            	
            }
        });
	});

  	$('#btnDisCancel').on('click', function() {
  		var checkbox = $("input[name=chk]:checked");
   		var checkboxCnt = 0;		
   		var errorFlag = false;
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {			
			var tr 			= checkbox.parent().parent().eq(i);			
			var td 			= tr.children();
			var rowData 	= new Object();
			
			var data = $('#stateTable').DataTable().row(tr).data();
			if(data.disposeGubun == "002"){
				errorFlag = true;
				return false;
			} 		
			checkboxCnt += 1;
		});		
		
		if(errorFlag){
			toastr.warning("폐기지정되지 않은 트레이가 있습니다.");
			$('#my-spinner').hide();
			return false;
		}
		if( checkboxCnt == 0){
			toastr.warning("선택된 트레이가 없습니다.");
			$('#my-spinner').hide();
			return false;
		}
   		$('#disPoseCancelCheckPopUpModal').modal('show');

  	});
  	
  	$('#btnModalDisPoseCancel').on('click', function() {	
   		var dataArray = new Array();
		var checkbox = $("input[name=chk]:checked");
		var checkboxCnt = 0;
		var errorFlag = false;
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			var tr 			= checkbox.parent().parent().eq(i);			
			var td 			= tr.children();
			var rowData 	= new Object();
			
			var data = $('#stateTable').DataTable().row(tr).data();

			rowData.labelLotNo 	= data.labelLotNoSeq;				

			dataArray.push(rowData);
			checkboxCnt += 1;
		});		

		if( checkboxCnt == 0){
			toastr.warning("선택된 트레이가 없습니다.");
			$('#my-spinner').hide();
			return false;
		}

		
        $.ajax({
            url: '<c:url value="/qm/goodsDisposeCancel"/>',
            type: 'POST',
            dataType: 'json',
            async: false,
            data : JSON.stringify(dataArray),
            contentType : "application/json; charset=UTF-8",          
            success: function (res) {              
                if (res.result == 'ok') {
                	toastr.success("폐기지정 취소 되었습니다.");
            		$('#stateTable').DataTable().ajax.reload( function () {});
            		$("#checkAll").prop("checked", false);            		
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#disPoseCancelCheckPopUpModal').modal('hide');
            	$('#my-spinner').hide();
            	
            }
        });

	});
	

 
   	
	
	
</script>

</body>
</html>