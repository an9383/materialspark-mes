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
				<li class="breadcrumb-item active">초중말물검사현황</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="table-responsive" style="padding-bottom: 10px;">
					<table id="stateTable" class="table table-bordered" style="width: 150%;">
						<thead class="thead-light">
							<tr>
								<th rowspan="3" style="vertical-align:middle; min-width:120px;">작업지시</th>
								<th rowspan="3" style="vertical-align:middle; min-width:50px;">호기</th>
								<th rowspan="3" style="vertical-align:middle; min-width:70px;">생산일자</th>
								<th rowspan="3" style="vertical-align:middle; min-width:100px;">주재료</th>
								<th rowspan="3" style="vertical-align:middle; min-width:80px;">제품명</th>
								<th rowspan="3" style="vertical-align:middle; min-width:50px;">재질</th>
		                        <th rowspan="3" style="vertical-align:middle; min-width:55px;">측정시간</th>
		                        
		                        <th colspan="13">MES 연동 치수</th>
		                        <th colspan="7">Manual 측정 치수</th>		                       
							</tr>
							<tr>
								<!-- <th style="vertical-align:middle;" id="lgSkGubun">SK on</th> -->
								<th style="vertical-align:middle;min-width:100px;" id="metalDepthCondNm0">Metal 폭</th>
								<th style="vertical-align:middle;min-width:100px;" id="pitchLeftCondNm0">Metal 총길이</th>
								<th style="vertical-align:middle;min-width:100px;" id="ppfDepthLeftCondNm0">Film 폭 (좌)</th>
								<th style="vertical-align:middle;min-width:100px;" id="ppfDepthCenterCondNm0">Film 폭 (중)</th>
								<th style="vertical-align:middle;min-width:100px;" id="ppfDepthRightCondNm0">Film 폭 (우)</th>
								<th style="vertical-align:middle;min-width:100px;" id="filmCondNm0">Film 총길이</th>
								<th style="vertical-align:middle;min-width:100px;" id="wpLeftCondNm0">Welding Part (좌)</th>
								<th style="vertical-align:middle;min-width:100px;" id="wpCenterCondNm0">Welding Part (중)</th>
								<th style="vertical-align:middle;min-width:100px;" id="wpRightCondNm0">Welding Part (우)</th>
								<th style="vertical-align:middle;min-width:100px;" id="wpDeviationCondNm0">Welding Part 좌/우 편차</th>
								<th style="vertical-align:middle;min-width:100px;" id="x1X2CondNm0">대각선 길이 편차 (X1 – X2)</th>
								<th style="vertical-align:middle;min-width:100px;" id="ppfWingLeftCondNm0">날개 Margin (좌)</th>
								<th style="vertical-align:middle;min-width:100px;" id="ppfWingRightCondNm0">날개 Margin (우)</th>
								<th style="vertical-align:middle;min-width:100px;" id="metalThicknessCondNm0">Metal 두께</th>
								<th style="vertical-align:middle;min-width:100px;" id="thEdgeCondNm0">총 두께 (Edge 좌)</th>
								<th style="vertical-align:middle;min-width:100px;" id="thCenterCondNm0">총 두께 (Center)</th>
								<th style="vertical-align:middle;min-width:100px;" id="thEdgeRightCondNm0">총 두께 (Edge 우)</th>
								<th style="vertical-align:middle;min-width:100px;" id="burrCondNm0">Metal Burr</th>
								<th style="vertical-align:middle;min-width:100px;" id="gapOfLayerCondNm0">Layer</th>
								<th style="vertical-align:middle;min-width:100px;" id="bendingCondNm0">Bending</th>																							
							</tr>
							<tr>
								<!-- <th id="lgSkGubun1">LGES</th> -->
								<th id="metalDepthCondNm1">d</th>
								<th id="pitchLeftCondNm1">L</th>
								<th id="ppfDepthLeftCondNm1">l1</th>
								<th id="ppfDepthCenterCondNm1">l2</th>
								<th id="ppfDepthRightCondNm1">l3</th>
								<th id="filmCondNm1">W</th>
								<th id="wpLeftCondNm1">S1</th>
								<th id="wpCenterCondNm1">S2</th>
								<th id="wpRightCondNm1">S3</th>
								<th id="wpDeviationCondNm1">S1-S3</th>
								<th id="x1X2CondNm1">X1-X2</th>
								<th id="ppfWingLeftCondNm1">M1</th>
								<th id="ppfWingRightCondNm1">M2</th>
								<th id="metalThicknessCondNm1">t</th>
								<th id="thEdgeCondNm1">T1</th>
								<th id="thCenterCondNm1">T2</th>
								<th id="thEdgeRightCondNm1">T3</th>
								<th id="burrCondNm1">Burr</th>
								<th id="gapOfLayerCondNm1">g</th>
								<th id="bendingCondNm1">b</th>																							
							</tr>
						</thead>
					</table>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc3140';
	let currentHref = 'qmsc3140';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","초중말물 검사 현황");
	
	var serverDateFrom 	= "${serverDateFrom}";
	var chooseDate1 	= "${serverDateFrom}";
	var chooseDate2 	= "${serverDate}";
	let factoryCode 	= "<%=factoryCode%>";

	//공통코드 시작
	var goodsCode = new Array(); // 제품코드
    <c:forEach items="${goodsCode}" var="info">
		var json=new Object();
		json.baseCd="${info.goodsCd}";
		json.baseCdNm="${info.goodsNm}";
		goodsCode.push(json);
    </c:forEach>

    var equipCode = new Array(); // 설비코드
    <c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";
		equipCode.push(json);
    </c:forEach>
	//공통코드 끝
	
	if( factoryCode == "003" ) {
		$('#gubunEdge').text("Edge(좌)");
		$('#gubunEdge2').text("Edge(우)");
	} else {
		$('#gubunEdge').text("Edge");
		$('#gubunEdge2').text("Edge2");
	}
	
	var equipList = '';
	var goodsCd = '';
	let tempRowId = '';
	for (var i=0; i<equipCode.length; i++) {
		equipList += "/" + equipCode[i].baseCd;
	}
	let listGubun = '001';
	let ngGubun = '001';

	$('#my-spinner').show();
	
	let termArray = new Array();
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let stateTable = $('#stateTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: false,
        processing: true,
        autoWidth: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/qm/stateList_F3"/>',
            type: 'GET',
            data: {
            	'menuAuth'			:	menuAuth,
//             	'ordDate'			:	function() { return serverDateFrom.replace(/-/g, ''); },
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },
				'equipCd'			:	function() { return equipList; },
	           	'goodsCd'			:	function() { return goodsCd; },
	           	'listGubun'			:	function() { return listGubun; },
	           	'ngGubun'			:	function() { return ngGubun; },
            },
        },
        rowId: 'workOrdNo',       
        columns: [
        	{ data: 'workOrdNo' 			},			
			{ data: 'equipNm'   	},
			{ data: 'ordDate',
	            render: function(data, type, row, meta) {
	    			if (data != null && data != '') {
		    				
		    				return moment(data).format('YYYY-MM-DD');
	        		}else {
	    				return '';
	            	}
    	    	}
	    	},
        	{ data: 'lotNo'		 			},
            { data: 'goodsNm' 				},
            { data: 'qutyNm' 				},
            { data: 'stepCd',
        		render: function(data, type, row) {
        			if (data=='000') {
		            	return '조건'
        			} else if (data=='001') {
		            	return '초물'
	            	} else if (data=='002') {
	            		return '중물'
	            	} else if (data=='003') {
	            		return '말물'
		            }
            	}
            },
            { data: 'metalDepthAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][0] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'pitchLeftAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][1] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'ppfDepthLeftAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][2] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'ppfDepthCenterAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][3] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'ppfDepthRightAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][4] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	    				
	            	}
	    			
    	    	}
	        },
            { data: 'filmAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][5] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'wpLeftAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][6] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'wpCenterAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][7] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'wpRightAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][8] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'wpDeviationAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][9] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'x1X2Alwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][10] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'ppfWingLeftAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][11] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'ppfWingRightAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][12] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },                  
            { data: 'metalThicknessAlwnce',
            	 render: function(data, type, row, meta) {
 	    			if (row['statusErrorYn'][13] == "Y") {
 		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
 		    				return rtn;
 	        		}else {
 	    				return data;
 	            	}
     	    	}
            },
	        
            { data: 'thEdgeAlwncePlus',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][14] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'thCenterAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][15] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</label>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'thEdgeRightAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][16] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</span>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'burrMetalAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][17] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</span>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'gapOfLayer',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][18] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</span>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            { data: 'bendingAlwnce',
	            render: function(data, type, row, meta) {
	    			if (row['statusErrorYn'][19] == "Y") {
		    				var rtn='<label style="background : red; color : white; width : 100%;">'+data+'</span>';
		    				return rtn;
	        		}else {
	    				return data;
	            	}
    	    	}
	        },
            //{ data: 'wpLeftAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'wpRightAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'pitchLeftAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'pitchRightAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'ppfWingLeftAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'ppfWingRightAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'ppfDepthLeftAlwnce',	
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'ppfDepthRightAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'filmAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'metalDepthAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'metalThicknessAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'thCenterAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'thEdgeAlwncePlus',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'burrMetalAlwnce',
			//	render: function(data, type, row) {
			//		return parseFloat(parseFloat(data).toFixed(3));
			//	}
			//},
            //{ data: 'burrRcutAlwnce',
			//	render: function(data, type, row) {
			//		if (data == 0){
			//			return 0;
			//		} else {
			//			return parseFloat(parseFloat(data).toFixed(3));
			//		}
			//	}
			//},
            //{ data: 'burrRedgeAlwnce',
			//	render: function(data, type, row) {
			//		if (data == 0){
			//			return 0;
			//		} else {
			//			return parseFloat(parseFloat(data).toFixed(3));
			//		}
			//	}
			//},
        ],
		rowsGroup: [
			0, 1, 2, 3, 4, 5
		],
//         columnDefs: [
//         	//{ targets: [9] , render: $.fn.dataTable.render.number( ',' ) },
//         	//{ targets: [9], className: 'text-right' }, 
//         ],
//         order: [
//             //[ 1, 'asc' ]
//         ],
        buttons: ['copy',
        	{
	        	extend: 'excelHtml5',
	            title: '초중물검사현황',
	            exportOptions: {
	                columns: ':visible' // 숨긴 열 제외한 현재 보이는 열만 내보내도록 설정
	            },
	            //excelCss
			    customize: function ( xlsx ) {
			    	let sheet = xlsx.xl.worksheets['sheet1.xml'];
			    	
			    	//$('row[r=2] c', sheet).remove();	//(C)가있어 cell이 선택되서 열 텍스트를 삭제하는 코드이고
			    	//$('row[r=2]', sheet).remove();		//(C)가없어 cell이 선택안되서 행을 삭제하는 코드이다.
			    	//sheet.getElementsByTagName('sheetData')[0].getElementsByTagName('row')[1].remove()
			    	
			    	$('row[r=2]', sheet).remove();
			    	
					$('row[r=3] c', sheet).attr( 's', '2' );
					$('row[r=4] c', sheet).attr( 's', '2' );
					
					
			    	termArray = new Array();
			    	
			    	if( factoryCode == 001 || factoryCode == 002 ) {
			    	
				    	//엑셀 행 반복 시작
				    	$('row', sheet).each( function (k, v, index) {
				    		
							let termObj		= new Object();
							let termText	= $('c[r^="G"]', this).text();
							
							//G(조건)인 경우 조건 데이터 담아주기
							if( $('c[r^="G"]', this).text() == "조건" ) {
								
								termArray = new Array();	//새로운 조건이 들어왔다는 것으로 간주하여, 초기화 후 새로운 조건을 담아준다.
								
								//H~Z까지의 조건데이터를 담음
								for (let i = 72; i <= 90; i++) {
								    //console.log(String.fromCharCode(i));
								    termObj[String.fromCharCode(i)] = $('c[r^="'+String.fromCharCode(i)+'"]', this).text();
								}
								//H~Z까지의 조건데이터를 담음
								
								termArray.push(termObj);	//배열에 오브젝트 삽입
							} else if( termText == "초물" || termText == "중물" || termText == "말물" ) {
								//조건이 아닌 경우 색상 표시
								
								//H~Z까지(현재는 Z까밖에 안나와서 상관없지만, AA, AB, AC...는 구현이 안됨 ) 하려고 하면 for문 하나 더 사용해서 구현해줘야함.(단 90개가 MAX임)
								for (let i = 72; i <= 90; i++) {
								    //console.log(String.fromCharCode(i));
								    
									let data		= termArray[0][String.fromCharCode(i)]
										data		= data == "" ? "" : data.replace("-","").replace("[","").replace("]","").replace("+","").split(' ');
									let cellData	= $('c[r^="'+String.fromCharCode(i)+'"]', this).text();
									
									if( data != "" ) {
										
										let max = parseFloat(data[1]) + parseFloat(data[2]);
										let min = parseFloat(data[1]) - parseFloat(data[0]);
										
										//조건에 맞는 값인지 판단 시작
										if( min > cellData ) {
											//O
											$('c[r^="'+String.fromCharCode(i)+'"]', this).attr( 's', '11' );
										} else if( max < cellData ) {
											//O
											$('c[r^="'+String.fromCharCode(i)+'"]', this).attr( 's', '11' );
										} else {
											//X
										}
										//조건에 맞는 값인지 판단 종료
									}
								}
								//H~Z까지
							}
						});
				    	//엑셀 행 반복 종료
			    	}
			    	//공장 구분
			    },
	            //excel customize
	            
	            
	            customizeData: function(data) {
					   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				 	//첫 번째 tr
				 	let arrayTr1 = colspanGroupArray('stateTable', 0, 'th', $('#stateTable thead tr').eq(0).find('th').length, 7, 'Y');
				 	//두 번째 tr
				 	let arrayTr2 = colspanGroupArray('stateTable', 1, 'th', $('#stateTable thead tr').eq(1).find('th').length, 7, 'empty');
				 	//세 번째 tr
				   	//let arrayTr3 = colspanGroupArray('stateTable', 2, 'th', $('#stateTable thead tr').eq(2).find('th').length, 5, 'empty');
					
					//첫 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow1 = alignToTableSize( data.header.length, arrayTr1  );
					//두 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					//let arrayRow2 = alignToTableSize( data.header.length, arrayTr2  );
					//세 번째 행에 헤더 부분 이미 header 개수만큼되어있음.
					   
				    //거꾸로 감, 제일 위에가 제일 밑으로 감
			        let desc = [
			        	//arrayRow2	//두 번째 행
				        arrayRow1	//첫 번째 행
					];

			        data.body.unshift(arrayTr2);		//헤더 맨 아래 부분 (세 번째 행)
			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }
	            
	            
        	},
        	'print']
//         drawCallback: function () {
            /*var api = this.api();
            var stateMax = new Array();
            var stateMin = new Array();
            
            for(var i=0; i < api.data().length; i++){
               var array = new Array();
               array.push(api.data()[i].wpLeftAlwnce);
               array.push(api.data()[i].wpRightAlwnce);
               array.push(api.data()[i].pitchLeftAlwnce);
               array.push(api.data()[i].pitchRightAlwnce);
               array.push(api.data()[i].ppfWingLeftAlwnce);
               array.push(api.data()[i].ppfWingRightAlwnce);
               array.push(api.data()[i].ppfDepthLeftAlwnce);
               array.push(api.data()[i].ppfDepthRightAlwnce);
               array.push(api.data()[i].filmAlwnce);
               array.push(api.data()[i].metalDepthAlwnce);
               array.push(api.data()[i].metalThicknessAlwnce);
               array.push(api.data()[i].thCenterAlwnce);
               array.push(api.data()[i].thEdgeAlwncePlus);
               array.push(api.data()[i].burrMetalAlwnce);
               array.push(api.data()[i].burrRcutAlwnce);
               array.push(api.data()[i].burrRedgeAlwnce);
              
               if(api.data()[i].stepCd == '000') {
					stateMax = new Array();
					stateMin = new Array();
               //}
               //if(api.data()[i].stepCd == '000') {
                   for(var j=0; j<16; j++) {
                      var stateSum = array[j].replace("-",'').replace("[",'').replace("]",'').replace("+",'');
                      stateSum = stateSum.split(' ');
                      stateMax.push(parseFloat(stateSum[1]) + parseFloat(stateSum[2]));	//최대값 
                      stateMin.push(parseFloat(stateSum[1]) - parseFloat(stateSum[0]));	//최소값
                   }
	            }
               if (api.data()[i].stepCd != '000') {
                   for (var j=0; j<16; j++) {
			            var X = array[j];
			            if (X > stateMax[j]) {
				            $('#stateTable tbody tr').eq(i).find('td').eq(j+6).attr('style','background : red; color : white');
		              	} else if (X<stateMin[j]) {
		              		$('#stateTable tbody tr').eq(i).find('td').eq(j+6).attr('style','background : red; color : white');
			            } else {
				            $('#stateTable tbody tr').eq(i).find('td').eq(j+6).attr('style','');
						}
					}
				}
			}*/
			
// 			$('#stateTable').rowspan(0);
// 			$('#stateTable').rowspan(1);
// 			$('#stateTable').rowspan(2);
// 			$('#stateTable').rowspan(3);
// 			$('#stateTable').rowspan(4);
// 			$('#stateTable').rowspan(5);
			
// 		}
	});
	
	stateTable.on('draw.dt', function(){
		$('#my-spinner').hide();
// 		console.timeEnd('time');
	});

	$('#stateTable tbody').on('click', 'tr', function(){
		$('#stateTable').DataTable().$('td.selected').removeClass('selected');
		for(var i=5; i<=25; i++){
			$(this).find('td').eq(i).addClass('selected');
		}
	});

	//숨길 컬럼_초물 중물 종물
	/* if( factoryCode == '002' || factoryCode == '003') {
		stateTable.column( 20 ).visible( false );
	} */
	


	var html1 = '<div class="row">';
	html1 += '<label class="input-label-sm ml-1">작지일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '<label class="input-label-sm ml-2">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateTo" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="btnChooseDateCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	

	html1 += '<div class="multipleSelection pos-real ml-2">';
	html1 += '<div class="selectBox selectBox1" onclick="showCheckboxes()">';
	html1 += '<select class="custom-select custom-select1 w-120" id="selectEquipList">';
	html1 += '<option>설비 목록</option>';
	html1 += '</select>';
	html1 += '<div class="overSelect"></div>';
	html1 += '</div>';
	html1 += '<div id="checkBoxes" class="checkBoxes1 selectBoxOverFlow" style="height:300px;">';
	html1 += '</div>';
	html1 += '</div>';
	html1 += '<label class="input-label-sm ml-2" style="margin-right:5px;"">제품</label><select class="custom-select" id="goodsCd" style="width:120px;"></select>';
	html1 += '<label class="input-label-sm ml-2" style="margin-right:5px;"">조건제외</label><input type="checkbox" id="listGubun" class="form-control" style="width:30px;">';
	if (factoryCode == '003') {
		html1 += '<label class="input-label-sm ml-2" style="margin-right:5px;"">NG값 조회</label><input type="checkbox" id="ngGubun" class="form-control" style="width:30px;">';
	}

	html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
	html1 += '</div>';
	
	$('#stateTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	selectBoxAppend(goodsCode, "goodsCd", '', "1");
			
	var html2 = '';
	html2 += '<label for="checkAll" style="margin-right: 0px;"><input type="checkbox" style="margin-right:6px;" id="checkAll" checked/>전체 선택/해제</label>';
	for (var i=0; i<equipCode.length; i++) {
		html2 += '<label for="' + equipCode[i].baseCdNm + '" style="margin-right: 0px;"><input type="checkbox" value="' + equipCode[i].baseCd + '" style="margin-right:6px;" id="' + equipCode[i].baseCdNm + '" checked/>' + equipCode[i].baseCdNm + '</label>';
	}

	$('#checkBoxes').html(html2);
	
// 	$('#date').val(serverDateFrom);

	/*$('#btnView').on('click', function() {
		$('#my-spinner').show();
		serverDateFrom = $('#date').val();	
		$('#stateTable').DataTable().ajax.reload();	
		console.time('sudel');	  
	});*/

	$('#btnRetv').on('click', function() {
		let dateFrom 	= new Date($('#chooseDateFrom').val());
		let dateTo 		= new Date($('#chooseDateTo').val());
		let dateDiff 	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		
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
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}

		equipList = '';
		for (var i=0; i<equipCode.length; i++) {
    		if($('#' + equipCode[i].baseCdNm).is(":checked") == true){
    			equipList += '/' + $('#' + equipCode[i].baseCdNm).val();
        	}
    	}
    	if (equipList == '') {
    		toastr.warning('설비를 선택해 주세요!', '', {timeOut: 5000});
        	if (show == true){
        		showCheckboxes();
            }
			return false;
        }
		
  		chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		userNumber	= $('#preWorkCharger').val();
  		goodsCd		=  $('#goodsCd option:selected').val();
  		if($('#listGubun').is(":checked") == true) {
  			listGubun = '002';
  	  	} else{
  	  		listGubun = '001';
  	  	}
  	  	
  		if($('#ngGubun').is(":checked") == true) {
  			ngGubun = '002';
  	  	} else{
  	  		ngGubun = '001';
  	  	}
  		
  	
    	if (show == false){
    		showCheckboxes();
        }
    	
  		$('#stateTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
//   		console.time('time');
	});

	$('#checkAll').on('click', function () {
    	if($('#checkAll').is(":checked") == true) {
    		for (var i=0; i<equipCode.length; i++) {
      			$('#' + equipCode[i].baseCdNm).prop("checked", true); 
        	}
    	} else {
    		for (var i=0; i<equipCode.length; i++) {
      			$('#' + equipCode[i].baseCdNm).prop("checked", false); 
        	}
        }
    });
	
	var show = true;
	function showCheckboxes() {
		var checkboxes = 
            document.getElementById("checkBoxes");
        if (show) {
            checkboxes.style.display = "block";
            show = false;
        } else {
            checkboxes.style.display = "none";
            show = true;
        }
    }

    $("#listGubun").on('click', function() {
    	if($("#listGubun").prop("checked")) {
        	if($("#ngGubun").prop("checked")) {
            	toastr.warning("NG값 조회가 이미 선택되어있습니다.");
            	$("#listGubun").prop("checked", false);
        	}
    	}
    });

    $("#ngGubun").on('click', function() {
    	if($("#ngGubun").prop("checked")) {
        	if($("#listGubun").prop("checked")) {
            	toastr.warning("NG값 조회가 이미 선택되어있습니다.");
            	$("#ngGubun").prop("checked", false);
        	}
    	}
    });
    
    
    
    
    
    
    
    
    
    
	//colspan 배열에 담기
	function colspanGroupArray( tableName, row, tDivision, trSize, notExistColspanValue, ghostYn) {
	 	//tableName: 테이블 명
	 	//row: 계산하고자 하는  행(0번 부터)
	 	//tDivision: th or td 선택자
	 	//trSize: 계산하고자하는 행 크기
	 	//notExistColspanValue: 계산하고자 하는 행에 calspan이 존재하지 않는 컬럼 개수(앞에서 값으로만 판단, 중간 값은 사용 못함)
	 	//ghostYn: rowspan으로 합쳐진 값이 존재하는지 여부( Y, N ) / 추가로 empty는 colspan, rowspan없이 쭉 이어진 값 

	 	let dt;
	 	let temporaryArray = new Array();
	 	let exceptionArray = new Array();	//empty에서만 사용
  		let temporaryObj = new Object();
    	let temporaryColspanSum = 0; 
	 	
	 	if( ghostYn == 'Y'){
	 		for(var i = 0; i < trSize; i++) {
	 			dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq(i);
		   	    temporaryObj = new Object();
		   	    if( i < notExistColspanValue ){
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = i;
		   	        colspanSum = i;
		   	    } else {
		   	        if( i == notExistColspanValue ) {
		   	            colspanSum += 1;
		   	        }
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = colspanSum;
		   	        colspanSum += parseInt(  dt.attr('colspan') );
		   	    }
		   	 temporaryArray.push(temporaryObj);
		   	}
	 		return temporaryArray;
		} else if( ghostYn == 'N' ) {
			for(var i=0; i < ( trSize + notExistColspanValue ); i++) {
	 			dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( (i-notExistColspanValue)  );
		   	    temporaryObj = new Object();
		   	    if( i < notExistColspanValue ){
		   	        temporaryObj.name = '';
		   	        temporaryObj.colspan = i;
		   	        colspanSum = i;
		   	    } else {
		   	        if( i == notExistColspanValue ) {
		   	            colspanSum += 1;
		   	        }
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = colspanSum;
		   	        colspanSum += parseInt(  dt.attr('colspan') );
		   	    }
		   	 temporaryArray.push(temporaryObj);
		   	}
			return temporaryArray;
		} else if( ghostYn == 'empty' ) {
			for(var i=0; i < ( trSize + notExistColspanValue ); i++) {
				dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( (i-notExistColspanValue)  );
				if( i < notExistColspanValue ){
					exceptionArray[i] = '';
			    } else {
			    	exceptionArray[i] = dt.text();
			    }
			}
			return exceptionArray;
		} else {
			toastr.error("시스템 오류가 발생했습니다. - excelGhostError-A001");
			return false;
		}
	}
	
	//가공하고자 하는 행에 헤더 부분 header개수만큼 늘리기 끝
	function alignToTableSize( allDatalength, receivedArray ){
		//colspan된 배열을 가지고, 만들고자하는 길이 만클 데이터를 가공하는 곳
		//allDatalength: 전체 데이터 길이(이 개수만큼 배열이 생성됨)
		//receivedArray: 가공하고자하는 배열 값
		
		let temporaryIsCheck = true;	// brek 역할
		let temporaryArrayRow = new Array();
		
		for(var i=0; i<allDatalength; i++){
			temporaryIsCheck = true;
			
		    for(var j=0; j<receivedArray.length; j++){
		        switch (i){
		        case receivedArray[j].colspan:
		        	temporaryArrayRow.push(receivedArray[j].name);
		        temporaryIsCheck = false;
		            break;
		        default:
		            break;
		        }
		        
		    }
		    if(temporaryIsCheck){
		    	temporaryArrayRow.push(' ');
		    }
		}
		return temporaryArrayRow;
	}
   
</script>

</body>
</html>
