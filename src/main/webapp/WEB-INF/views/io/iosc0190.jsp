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
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">출하검사성적서조회</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list" style="z-index: 0;">
			<!-- <div class="left-list left-60" id="left-list" style="width: 59%;"> -->
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button type="button" class="btn btn-primary input-sub-search" id="left-width-btn2" onclick="openrNav2();" >
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="productShipmentViewTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th class="text-center">마감일</th>
									<th class="text-center">납기일</th>
									<th class="text-center">PO Number</th>
									<th class="text-center">오더구분</th>
									<th class="text-center">거래처</th>
									<th class="text-center">등록번호(PO)</th>
									<th class="text-center">제품</th>
									<th class="text-center">재질</th>
									<th class="text-center">두께</th>
									<th class="text-center">폭</th>
									<th class="text-center">길이</th>
									<th class="text-center">피치</th>
									<th class="text-center">출고BOX</th>
									<th class="text-center">출고수량</th>
								</tr>
							</thead>
						</table>
					</div><!-- /.table-responsive -->
				</div>
			</div><!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			
			
			<div class="right-list right-sidebar right-sidebar-fix" id="rfSidenav" style="width:65%; padding-bottom:0px; z-index: 1;">
			<!-- <div class="right-list right-40" id="myrSidenav" style="width: 40%; padding-bottom: 0px;"> -->
				<div class="card" id="formBox">

					<div class="mb-2 ml-3" style="display: flex;justify-content: space-between;">
						<div class="row float-right alert-primary">
							<h6 class="p-1 mr-3 mb-0">합계</h6>
							<h5 class="mr-3 mb-0" id="box"></h5>
							<h5 class="mb-0" id="pcs"></h5>
							
							<button type="button" class="btn btn-success ml-5" id="btnReportsAllDown">성적서 다운(전체)</button>
							<button type="button" class="btn btn-success ml-5" id="btnReportsDivideDown">성적서 다운(분할)</button>
						</div>
						
						<div class="rightsidebar-close">
                           	<a href="javascript:void(0)" id="left-expand2" class="closebtn float-right" onclick="closerNav2();">
                           		<i class="mdi mdi-close"></i>
                           	</a>
						</div>
					</div>
					
					<!-- dtl테이블 -->
					<!-- table-responsive -->
					<div class="" style="max-height:700px; overflow-x: auto;">
						<table id="shipReportsDtlTable" class="table table-bordered">
							
							<thead class="thead-light">
								<tr>
									<th rowspan="3">LotNo</th>
									<th rowspan="3">Q'ty(pcs)</th>
									<th rowspan="3">DATA</th>
									
									<th colspan="5">Width</th>
									<th colspan="2">Thickness</th>
									<th colspan="2">Length</th>
									
									<th rowspan="2">Gap of Layer</th>
									<th rowspan="2">Edge<br>Press</th>
									<th rowspan="2">Folding<br>endurance</th>
									<th rowspan="2">Thickness<br>of Plating</th>
									<th rowspan="2">Appearance</th>
									<th rowspan="2">Adhesion<br>(Dipping test)</th>
									<th rowspan="2">Burr</th>
									<th rowspan="2">Bending Test</th>
								</tr>
								
								<tr>
									<th>Insulation</th>
									<th>Conductor</th>
									<th>Margin</th>
									<th>Welding part</th>
									<th>WP Deviation</th>
									<th>Conductor</th>
									<th>Con.with Ins</th>
									<th>Ins. On  con</th>
									<th>Pitch</th>
								</tr>
								
								<tr>
									<th>10.0±0.5</th>
									<th>45.0±0.2</th>
									<th>2.0±0.5</th>
									<th>5.5±0.5</th>
									<th>Max0.3</th>
									<th>0.200±0.015</th>
									<th>0.500±0.030</th>
									<th>49.0±0.5</th>
									<th>46.5±0.5</th>
									<th>Max0.5</th>
									<th>OK/NO</th>
									<th>More than<br>6 times</th>
									<th>2.5㎛±0.7㎛</th>
									<th>OK / NG</th>
									<th>OK / NG</th>
									<th>0.015<br>OK / NG</th>
									<th>Max 0.5↓<br>OK / NG</th>
								</tr>	
							</thead>
						</table>	
					</div>
					<!-- dtl테이블 -->
				</div>
			</div>
			
			
			
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->



<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc0190';
	let currentHref = 'iosc0190';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","출하검사성적서조회");

	let viewIdx;	
	let switchType; // 교체 방식 (검사반품/일반)
	let isBoxNoScan = false; // NewBoxNo 스캔 여부
	
	let serverDateFrom	= "${serverDateFrom}";
	let serverDateTo	= "${serverDateTo}";
	
	let chooseDateFrom	= serverDateFrom;
	let chooseDateTo	= serverDateTo;
	let factoryCode		= "<%=factoryCode%>";
	
	let poSeq			= 0;
	
  	//공통코드 처리 시작
    var matrlCode=new Array();
    <c:forEach items="${matrlNm}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlCode.push(json);
    </c:forEach>
    
    var dealCorpCode=new Array();
    <c:forEach items="${dealCorpAdm}" var="info">
		var json=new Object();
		json.baseCd="${info.dealCorpCd}";
		json.baseCdNm="${info.dealCorpNm}";
		dealCorpCode.push(json);
    </c:forEach>
	//공통코드 처리 종료
	
	
	//메인 목록 조회
    $.fn.dataTable.ext.errMode = 'none';
	let productShipmentViewTable = $('#productShipmentViewTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-5'l><'col-sm-12 col-md-4'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-3'i><'col-sm-12 col-md-3'p><'col-sm-12 col-md-6'>>B",
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: true,
        pageLength: 20,
        buttons: true,

        ajax: {
            url: '<c:url value="/io/shipReportsList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
	           	'chooseDateFrom'	:		function() { return chooseDateFrom.replace(/-/g, ''); },
            	'chooseDateTo'		:		function() { return chooseDateTo.replace(/-/g, ''); },
            	'qutyCd'	    	:	    function() { return $("#matrlCd option:selected").val(); } ,
            	'dealCorpCd'	    :	    function() { return $("#dealCorpCd option:selected").val(); } ,
            },
        },
        rowId: '',
        columns: [
            { data: 'deliveryDate',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                }
            },
            { data: 'deadLine',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                }
            },
            { data: 'poNo' },   
            { data: 'poGubunNm' },
            { data: 'dealCorpNm' }, 
            { data: 'poSeq'},                    
            { data: 'goodsNm'  },
            { data: 'qutyNm'  },
            { data: 'thickness' },
            { data: 'depth'  },
            { data: 'length'  },
            { data: 'pitch'  },
            { data: 'boxCount'  },
            { data: 'outputQty'  },              
        ],
        columnDefs: [
        	{ targets: [11,12,13] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [11,12,13], className: 'text-right' },
        ],
        buttons: [
            {
                extend: 'copy',
                title: '출하검사성적서조회',
            },
            {
                extend: 'excel',
                title: '출하검사성적서조회',
            },
            {
                extend: 'print',
                title: '출하검사성적서조회',
            }
        ],
    });
	
	let html1 = '<div class="row">&nbsp;<label class="input-label-sm">납기일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input type="date" class="form-control" style="min-width:100%;" id="chooseDateFromCal">';
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
		html1 += '<div class="form-group input-sub m-0 row">';
		html1 += '<input type="date" class="form-control" style="min-width:100%;" id="chooseDateToCal">';
		html1 += '</div>';
		
		html1 += '<select class="custom-select ml-2" id="matrlCd"></select>';
		html1 += '<select class="custom-select ml-2" id="dealCorpCd"></select>';
		
		html1 += '&nbsp; <button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
		html1 += '</div>';
	$('#productShipmentViewTable_length').html(html1);
	$('#chooseDateFromCal').val(serverDateFrom);
	$('#chooseDateToCal').val(serverDateTo);
	
	selectBoxAppend(matrlCode, "matrlCd", "" , "1");
	selectBoxAppend(dealCorpCode, "dealCorpCd", "", "1");
	
	//메인 테이블 클릭 시
    $('#productShipmentViewTable tbody').on('click', 'tr', function () {
    	
    	if($('#productShipmentViewTable tbody').text() == '데이터가 없습니다.'){
			return false;
		}
    	
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#productShipmentViewTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            
            poSeq	= productShipmentViewTable.row(this).data().poSeq;
            //poGroup	= productShipmentViewTable.row(this).data().poGroup;
            
            $('#my-spinner').show();
            $('#shipReportsDtlTable').DataTable().ajax.reload(function(){
            	
            	//기종별에 따른 기준 목록 조회
            	let model	= shipReportsDtlTable.data()[0].model;
                let goodsNm	= $('#productShipmentViewTable').DataTable().rows( '.selected' ).data()[0].goodsNm;
                
                $.ajax({
        			url: '<c:url value="/io/standardAppointedList"/>',
        			type: 'GET',
        			data:  {
        				'model' 			: function() { return model;		},
        				'goodsNm' 			: function() { return goodsNm;		},
        			},
        			success: function (res) {
        				let data = res.data;
        				$($('#shipReportsDtlTable thead tr')[2]).find('th').text("...");
        				
       	        		shipReportsDtlTable.column( 15 ).visible( true );
       	        		
        				//불러온 조건으로 헤더 조건 조정
        				for( var i=0; i<data.length; i++ ) {
        					$($('#shipReportsDtlTable thead tr')[2]).find('th')[i].innerText = data[i];
        				}
        				
        				//도금인 경우에만 해당 컬럼 사용
	       	         	if ( $('#productShipmentViewTable').DataTable().rows( '.selected' ).data().length != 0 ) {
	       	         		if( $('#productShipmentViewTable').DataTable().rows( '.selected' ).data()[0].goodsCd.substring(0, 1) == "N" ) {
	       	             		shipReportsDtlTable.column( 15 ).visible( true );
	       	             	} else {
	       	             		shipReportsDtlTable.column( 15 ).visible( false );
	       	             	}        		
	       	         	}
        				
        			}
                });
    			//기종별에 따른 기준 목록 조회
    			
            	$('#my-spinner').hide();
            });
        }
    });
	
	//서브 테이블 조회
	let shipReportsDtlTable = $('#shipReportsDtlTable').DataTable({
    	dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
    	"<'row'<'col-sm-12'tr>>" +
    	"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        //autoWidth: false,
        //scrollX : true,
        lengthChange: false,
        searching: false,
		//scrollY: "58vh",
		//scrollCollapse: true,
		
        ajax: {
            url: '<c:url value="/io/shipReportsDtlList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	: menuAuth,
            	'poSeq' 	: function() { return poSeq; }
             },             
        },
        rowId: '',
        columns: [
        	{ data: 'customerLotNo'				},
        	{ data: 'outputCnt'					},
        	{ data: 'data'						},
        	{ data: 'ppfDepthLeftAlwnce'		},
        	{ data: 'metalDepthAlwnce'			},
        	{ data: 'ppfWingLeftAlwnce'			},
        	{ data: 'wpLeftAlwnce'				},
        	{ data: 'wpDeviation'				},
        	{ data: 'metalThicknessAlwnce'		},
        	{ data: 'thCenterAlwnce'			},
        	{ data: 'filmAlwnce'				},
        	{ data: 'pitchLeftAlwnce'			},
        	{ data: 'gapOfLayer'				},
        	{ data: 'edgePress'					},
        	{ data: 'foldingEndurance'			},
        	{ data: 'thicknessQty'				},
        	
        	{ data: 'resvData'					},
        	{ data: 'resvData'					},
        	{ data: 'resvData'					},
        	{ data: 'resvData'					},
        ],
        columnDefs: [
        	{ targets: [1] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [1,3,4,5,6,7,8,9,10,11,12,14,15], className: 'text-right' },
        	{ targets: "_all", className: 'text-center' },
        ],
        buttons: [
            {
                extend: 'copy',
                title: '출하검사성적서조회',
            },
            {
                extend: 'excel',
                title: '출하검사성적서조회',
            },
            {
                extend: 'print',
                title: '출하검사성적서조회',
            }
        ],
        drawCallback : function( settings ) { //데이터 테이블 모두 호출후 실행 유사 complete       		
        	$('#box').text($('#shipReportsDtlTable').DataTable().data().count() + " BOX");
    		
        	if( isNaN( calc() ) ){
        		$('#pcs').text("0" + " PCS");        		
        	} else{
        		$('#pcs').text(addCommas(calc()) + " PCS"); 
        	}
       	}
    });
	
	//조회 버튼 클릭 시
    $('#btnRetv').on('click', function() {
		let dateFrom	= new Date($('#chooseDateFromCal').val());
		let dateTo 		= new Date($('#chooseDateToCal').val());
		let dateDiff	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 365) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		
    	chooseDateFrom	=  $('#chooseDateFromCal').val();
    	chooseDateTo	=  $('#chooseDateToCal').val();
    	
		$('#productShipmentViewTable').DataTable().ajax.reload( function () {});
		$('#shipReportsDtlTable').DataTable().clear().draw();
    });
	
	//성적서 다운(전체) 버튼 클릭 시
    $('#btnReportsAllDown').on('click', function() {
    	reportExcelDown("001");
    });
	
  //성적서 다운(분할) 버튼 클릭 시
    $('#btnReportsDivideDown').on('click', function() {
    	reportExcelDown("002");
    });
	
	//엑셀 만들고 다운 받는 함수
	function reportExcelDown(gubun) {
		
		if( $('#productShipmentViewTable').DataTable().rows( '.selected' ).data()[0] == null ) {
			toastr.warning("메인 테이블을 먼저 선택해 주세요.");
			return false;
		}
    	
    	let dealCorpNm		= $('#productShipmentViewTable').DataTable().rows( '.selected' ).data()[0].dealCorpNm;
    	let qutyNm			= $('#productShipmentViewTable').DataTable().rows( '.selected' ).data()[0].qutyNm;
    	let deliveryDate	= moment($('#productShipmentViewTable').DataTable().rows( '.selected' ).data()[0].deliveryDate).format("YYYY-MM-DD");;
    	let totalOutQty		= parseInt( $('#productShipmentViewTable').DataTable().rows( '.selected' ).data()[0].outputQty ).toLocaleString();
    	
    	//성적서 다운받는 ajax
    	$.ajax({
			url: '<c:url value="/io/reportExcelProduce"/>',
			type: 'GET',
			datatype: 'json',
			data:  {
				'menuAuth'			: menuAuth,
				'poSeq' 			: function() { return poSeq;		},
				'dealCorpNm' 		: function() { return dealCorpNm;	},
				'qutyNm' 			: function() { return qutyNm;		},
				'totalOutQty' 		: function() { return totalOutQty;	},
				'deliveryDate' 		: function() { return deliveryDate;	},
				'excelFormGubun'	: function() { return gubun;		},
			},
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
				
				let data = res.data
				
			    if (res.result == 'ok') {
			        location.href = 'io/reportExcelDownload?id=출하검사성적서(머티)';
			    	toastr.success("성적서가 다운로드되었습니다.");
			    } else {
					toastr.error("오류가 발생하였습니다. - 출하검사성적서조회/Excel-001");
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
        });
		
	}
	
	//PCS 계산
    function calc() {
		var sum=0;
		$('#shipReportsDtlTable tbody tr').each(function(){
		 	sum =  parseInt(($(this).find('td').eq(1).text()).replace(/,/g, '')) + sum;			
		});
		return sum;
	}
	
    
</script>

</body>
</html>
