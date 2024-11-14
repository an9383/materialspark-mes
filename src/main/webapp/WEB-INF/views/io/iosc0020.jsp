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
				<li class="breadcrumb-item"><a href="#">입출고관리</a></li>
				<li class="breadcrumb-item active">자재 입고(바코드)</li>
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
					<table id="matrlInOutWhsTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th class="text-center">가입고일</th>
								<th class="text-center" style="min-width:40px;">비고</th>
								<th class="text-center">승인상태</th>
								<th class="text-center">자재상태</th>
								<th class="text-center">자재코드 </th>
								<th class="text-center">자재명</th>
								<!-- <th class="text-center">S-LOT </th> -->
								<th class="text-center">LOT NO </th>
								<th class="text-center">바코드 </th>
								<th class="text-center">가입고량 </th>
								<th class="text-center">입고량 </th>
								<th class="text-center">차이</th>
								<th class="text-center">공급업체 </th>
								<th class="text-center">입고일 </th>
								<th class="text-center">수입검사일 </th>
								<th class="text-center">Location </th>                                                                                          
								<th class="text-center">선입선출</th>
								<th class="text-center">유수명 기간</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="8" style="text-align: center">합계</td>																		
								<td id="sumInWhsQty" style="text-align: right">0</td>	
								<td id="sumInspectQty" style="text-align: right">0</td>	
								<td id="sumDiffQty" style="text-align: right">0</td>	
								<td colspan="6"></td>
							</tr>
						</tfoot>
					</table>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc0020';
	let currentHref = 'iosc0020';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자재 입고(바코드)");
	
	//오늘날짜 yyyy-mm-dd String 출력
	function getFormatDate(today){
	    var year = today.getFullYear();              //yyyy
	    var month = (1 + today.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = today.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;
	}

	//yyyy-mm-dd String-> Date로 변환
	function to_date(date_str)
	{
	    var yyyyMMdd = String(date_str);
	    var sYear = yyyyMMdd.substring(0,4);
	    var sMonth = yyyyMMdd.substring(5,7);
	    var sDate = yyyyMMdd.substring(8,10);	
	    return new Date(Number(sYear), Number(sMonth)-1, Number(sDate));
	}

	//yyyy-mm-dd에 개월수 더하기
	function add_months(dt, n) 
	{
		return new Date(dt.setMonth(dt.getMonth() + n));      
	}
	
	//오늘날짜 yyyy-mm-dd String 출력
	var todayString = getFormatDate(new Date());
	
	//yyyy-mm-dd String-> Date로 변환
	var todayDate = to_date(todayString);

	//공통코드 처리 시작
	var approvalCode=new Array();	//승인여부
    <c:forEach items="${approvalCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCode.push(json);
    </c:forEach>

	var locationCode=new Array();	//location
    <c:forEach items="${locationCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		locationCode.push(json);
    </c:forEach>

    var matrlCdList=new Array();	//matrlCdList
    <c:forEach items="${matrlCdList}" var="info">
		var json=new Object();
		json.baseCd="${info.matrlCd}";
		json.baseCdNm="${info.matrlNm}";
		matrlCdList.push(json);
    </c:forEach>
    
	var fifoCheckCode=new Array();	//선입선출 체크
	<c:forEach items="${matrlFifoCheck}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		fifoCheckCode.push(json);
	</c:forEach>
    //공통코드 처리 종료  
                             
    let viewIdx;
    let sideView = 'add';
	var inWhsDateCal =  "${serverDate}"; 
	var approvalCd =  "";   
	var matrlCd =  "";
	var json = new Object();
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let matrlInOutWhsTable = $('#matrlInOutWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
			 "<'row'<'col-sm-12'tr>>" +
			 "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/io/matrlInOutWhsPreDataList"/>',
            type: 'GET',
            data: {
	           	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDate'		: 		function() { return inWhsDateCal.replace(/-/g, ''); },	//검색기준을 가입고일 에서 입고일로 변경 2020. 10. 07
	           	'approvalCd'	: 		function() { return approvalCd; },
	           	'matrlCd'		: 		function() { return matrlCd; }
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'lotNo',
        columns: [
        	{
                data: 'preInWhsDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            { data: 'inWhsDesc' },
            { data: 'approvalNm' },
            { data: 'statusNm' },
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            //{ data: 'srLot' },
            { data: 'lotNo' },
            { data: 'barcodeNo' },
            { data: 'preInWhsQty',
              	 render: function(data, type, row) {					
    					return parseFloat(data).toFixed(2);
                    }        
   			},
            { data: 'inspectQty',
            	 render: function(data, type, row) {					
  					return parseFloat(data).toFixed(2);
                  }        
            },
            { data: 'diffQty' ,
            	 render: function(data, type, row) {					
 					return parseFloat(data).toFixed(2);
                 }   	
            },
            { data: 'spplyDealCorpNm' },
            {
                data: 'inWhsDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            {
                data: 'inspctDate',
                render: function(data, type, row) {					
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            {
                data: 'locationCd',
           		render: function(data, type, row, meta) {
               		var html;
           			if(row['approvalCd'] == '001') {
               			html = 	selectBoxHtml(locationCode, 'locationCd', data, row, meta);
           			} else {
               			html = "";
               		}
               		return html;
           		}
            },
			{
                data: 'fifoCheck',
           		render: function(data, type, row, meta) {
               		var html;
               		if(row['approvalCd'] == '001') {
               			html = selectBoxHtml(fifoCheckCode, 'fifoCheck', data, row, meta);
	       			} else {
	           			html = "";
	           		}
               		return html;
           		}
            },
            {
                data: 'endLifeCycle',
           		render: function(data, type, row, meta) {
           			var todayString = getFormatDate(new Date());
           			var todayDate = to_date(todayString);
					//오늘날짜 + 5개월이 > 자재 입고일 + 유수명(월) 이면 빨간색!
               		if( Date.parse(add_months(todayDate, 5)) > Date.parse(to_date(row['endLifeCycle'])))	{
               			var html = "<p style='color:red; margin-bottom:0px;'>" + data +"</p>";
                   	} else {
                   		var html = "<p style='margin-bottom:0px;'>" + data +"</p>";
					}
               		return html;
           		}
            },
            //{
            //    data: 'endLifeCycle',
           	//	render: function(data, type, row, meta) {
            //
            //   		if()
            //   		var html = "<p style='color:blue; margin-bottom:0px;'>" + data +"</p>";
            //   		return html;
           	//	}
            //},
        ],
        columnDefs: [
           	{ targets: [8,9,10] , render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [8,9,10], className: 'text-right' }, 
        ],
        order: [
            [ 1, 'asc' ]
        ],
		drawCallback: function () {
			var sumInWhsQty = $('#matrlInOutWhsTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sumInspectQty = $('#matrlInOutWhsTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sumDiffQty = $('#matrlInOutWhsTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			$('#sumInWhsQty').text(addCommas(sumInWhsQty.toFixed(2)));
			$('#sumInspectQty').text(addCommas(sumInspectQty.toFixed(2)));
			$('#sumDiffQty').text(addCommas(sumDiffQty.toFixed(2)));
        },
        buttons: [
            {
                extend: 'copy',
                title: '자재입고(바코드)',
                exportOptions: {
                    format: {
                        body: function (data, column, row, node) {
                            // if it is select
                            if (row == 13) {
                                return $(data).find("option:selected").text()
                            } else return data
                        }
                    }
                }
            },
            {
                extend: 'excel',
                title: '자재입고(바코드)',
                exportOptions: {
                    format: {
                        body: function (data, column, row, node) {
                            // if it is select
                            if (row == 13) {
                                return $(data).find("option:selected").text()
                            } else return data
                        }
                    }
                }
            }, 
            {
                extend: 'print',
                title: '자재입고(바코드)',
                exportOptions: {
                    format: {
                        body: function (data, column, row, node) {
                            // if it is select
                            if (row == 13) {
                                return $(data).find("option:selected").text()
                            } else return data
                        }
                    }
                }
            },
        ],
    });
    
    var buttonCommon = {
            exportOptions: {
                format: {
                    body: function (data, column, row, node) {
                        // if it is select
                        if (column == 14) {
                            return $(data).find("option:selected").text()
                        } else return data
                    }
                }
            }
        };
    
    var sysdate = "${serverTime}";    
	var html1 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="preInWhsDate" name="preInWhsDate" />';
		html1 += '<button onclick="fnPopUpCalendar(preInWhsDate,preInWhsDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
    	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">승인여부</label><select  class="custom-select" id="approvalCd" ></select>&nbsp;';
    	html1 += '&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>';
    	html1 += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">자재명</label><select  class="custom-select" id="matrlCd" style="min-width:100px;"></select></div>';
	$('#matrlInOutWhsTable_length').html(html1);
	
	$('#preInWhsDate').val(inWhsDateCal);
	selectBoxAppend(approvalCode, "approvalCd", "", "1");
	selectBoxAppend(matrlCdList, "matrlCd", "", "1");

	//창고위치 변경
	$('#matrlInOutWhsTable').on('change', 'select#locationCd', function() {
        var colIndex = +$(this).data('col');
         var row = $(this).closest('tr')[0];
         var data = matrlInOutWhsTable.row(row).data();
         var lotNo = matrlInOutWhsTable.row(row).data().lotNo;
         var locationCd = $(this).find(':selected').val();

         if(locationCd == null || locationCd == '' || locationCd == undefined) {
        	 toastr.warning('Location 선택해 주세요.');
        	 return false;
         }

         $.ajax({
             url: '/io/matrlInOutUpdateLocation',
             type: 'POST',
             data: {
            	'menuAuth'	 	: 		menuAuth,
             	'lotNo'       	:        lotNo,
             	'locationCd'  	:        locationCd,
             },
             beforeSend: function() {
                // $('#btnAddConfirm').addClass('d-none');
                // $('#btnAddConfirmLoading').removeClass('d-none');
             },
             success: function (res) {
                 let data = res.data;
         
                 if (res.result == 'ok') {
                     // 보기
                     //$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
	               	 toastr.success('창고위치 수정되었습니다.');
                 } else {
                	 toastr.error(res.message, '', {timeOut: 5000});
                 }
             },
             complete:function(){
                // $('#btnAddConfirm').removeClass('d-none');
                // $('#btnAddConfirmLoading').addClass('d-none');
             }
         });
	});	

	//FIFO Check 변경
	$('#matrlInOutWhsTable').on('change', 'select#fifoCheck', function() {
		var colIndex = +$(this).data('col');
		var row = $(this).closest('tr')[0];
		var data = matrlInOutWhsTable.row(row).data();
		var lotNo = matrlInOutWhsTable.row(row).data().lotNo;
		var fifoCheck = $(this).find(':selected').val();
         if(fifoCheck == null || fifoCheck == '' || fifoCheck == undefined) {
        	 toastr.warning('fifoCheck 선택해 주세요.');
        	 return false;
         }
        
         $.ajax({
             url: '/io/matrlInOutUpdateFifoCheck',
             type: 'POST',
             data: {
            	'menuAuth'	 	:		menuAuth,
             	'lotNo'       	:		lotNo,                  
             	'fifoCheck'  	:		fifoCheck,
             	
             },
             beforeSend: function() {
                // $('#btnAddConfirm').addClass('d-none');
                // $('#btnAddConfirmLoading').removeClass('d-none');
             },
             success: function (res) {
                 let data = res.data;
                 if (res.result == 'ok') {
                     // 보기
                     //$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
	               	 toastr.success('선입선출 수정되었습니다.');
                 } else {
                	 toastr.error(res.message, '', {timeOut: 5000});
                 }
             },
             complete:function(){
                // $('#btnAddConfirm').removeClass('d-none');
                // $('#btnAddConfirmLoading').addClass('d-none');
             }
         });
	});
	
    // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }

	});	
        
	function locateChange() {
        var colIndex = +$(this).data('col');
        var row = $(this).closest('tr')[0];
        var data = matrlInOutWhsTable.row(row).data();
        data[colIndex] = this.value
        data[colIndex-1] = $(this).find(':selected').text();
	}

	//조회버튼 클릭
    $('#btnRetv').on('click', function() {
		inWhsDateCal =  $('#preInWhsDate').val();
		approvalCd =  $('#approvalCd').val();
		matrlCd =  null;
		//matrlCd =  $('#matrlCd').val();
		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});

		$.ajax({
            url: '/io/matrlCdInOutList',
            type: 'GET',
            data: {
           		'menuAuth'	 	: 		menuAuth,
	           	'inWhsDate'		: 		function() { return inWhsDateCal.replace(/-/g, ''); },	//검색기준을 가입고일 에서 입고일로 변경 2020. 10. 07
	           	'approvalCd'	: 		function() { return approvalCd; },
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {	
                    $('#matrlCd').empty();
                    var matrlCdList = new Array();	//matrlCdList
                    for(var i=0; i<data.length; i++){
                    	var json=new Object();
                    	json.baseCd=data[i].matrlCd;
                    	json.baseCdNm=data[i].matrlNm;
                    	matrlCdList.push(json);
                    }
                    selectBoxAppend(matrlCdList, "matrlCd", "", "1");
                } else {
               	 toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            }
        });
    });

   	//자재명 변경감지
    $('#matrlCd').on('change', function() {
		inWhsDateCal =  $('#preInWhsDate').val();
		approvalCd =  $('#approvalCd').val();
		matrlCd =  $('#matrlCd').val();
		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});

		//$.ajax({
        //    url: '/io/matrlCdInOutList',
        //    type: 'GET',
        //    data: {
        //   		'menuAuth'	 	: 		menuAuth,
	    //       	'inWhsDate'		: 		function() { return inWhsDateCal.replace(/-/g, ''); },	//검색기준을 가입고일 에서 입고일로 변경 2020. 10. 07
	    //       	'approvalCd'	: 		function() { return approvalCd; },
        //    },
        //    success: function (res) {
        //        let data = res.data;
        //        if (res.result == 'ok') {	
        //            $('#matrlCd').empty();
        //            var matrlCdList = new Array();	//matrlCdList
        //            for(var i=0; i<data.length; i++){
        //            	var json=new Object();
        //            	json.baseCd=data[i].matrlCd;
        //            	json.baseCdNm=data[i].matrlNm;
        //            	matrlCdList.push(json);
        //            }
        //            selectBoxAppend(matrlCdList, "matrlCd", matrlCd, "1");
        //        } else {
        //       	 toastr.error(res.message, '', {timeOut: 5000});
        //        }
        //    },
        //    complete:function(){
        //    }
        //});
    });
    
</script>

</body>
</html>
