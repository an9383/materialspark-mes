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
				<li class="breadcrumb-item active">출하검사현황(상세)</li>
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
		                        <th>생산일</th>
		                        <th>생산작업자</th>
		                        <th>검사자</th>
		                        <th>설비명</th>
		                        <th>주재료</th>
		                        <th>필름Lot</th>
		                        <th>개별트레이번호</th>
		                        <th>트레이번호</th>
		                        <th>제품</th>
		                        <th>재질</th>
		                        <th>출하검사 구분</th>
		                        <th>불량상태</th>
		                        <th>설비</th>
		                        <th>작지번호</th>
		                        <th>생산lotNo</th>
		                        <th>등록일</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
				
				<!-- .table-responsive -->
				<div class="d-none" style="/* position: fixed;left: 500px;bottom: 40px; */width: 480px;" id="infoDiv">
					<table class="table table-bordered ml-3">
						<thead class="thead-light">
							<tr>
		                        <th>전체 출하 검사</th>
		                        <th>Major 부적합 건수</th>
		                        <th>Minor 부적합 건수</th>
		                        <th>총 부적합 건수</th>
		                        <th>뷸량률</th>
							</tr>
						</thead>
						<tbody>
							<tr style="background: #5ac0ff;color: black;">
								<td id="totalCount">...</td>
								<td id="majorCount">...</td>
								<td id="minorCount">...</td>
								<td id="totalFaultyCount">...</td>
								<td id="faultyPercent">...</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- /.table-responsive -->
				
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc0200';
	let currentHref = 'qmsc0200';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "출하검사현황(상세)");
	
	let serverDateFrom 	= "${serverDateFrom}";
	let chooseDate1 	= "${serverDateFrom}";
	let chooseDate2 	= "${serverDate}";
	let reInspStatusArr = ['001', '003'];
	let dateCheck = '001';
	let inspStatus = '';
	let equipCd = '';
	let factoryCode = "<%=factoryCode%>";

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
    
    let faultyStatusCode = new Array(); // 투입자재 불량여부
    <c:forEach items="${faultyStatusCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		faultyStatusCode.push(json);
    </c:forEach>
    
    var pageCountArray=new Array();	//pageCount
    <c:forEach items="${pageCount}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		pageCountArray.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    
    
	pageCountArray.sort(function(a, b) {
	  return a.baseCd - b.baseCd;
	});
	
	let pageCd = new Array();
	let pageNm = new Array();
	
	for(var i=0; i<=pageCountArray.length; i++){
		if(i==0) {
			pageCd.push(-1);
			pageNm.push("묶음보기(전체)");
		} else {
			pageCd.push(pageCountArray[(i-1)].baseCd);
			pageNm.push(pageCountArray[(i-1)].baseCdNm);
		}
	}
	
	
	$('#my-spinner').show();
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let stateTable = $('#stateTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		 dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B", 
        /* language: lang_kor,
        paging: true,
        info: true,
        processing: true,
        autoWidth: false,
        pageLength: 20, */
        
        language: lang_kor,
        paging: true,
        info: true,
        processing: true,
        autoWidth: false,
		scrollX: true,
        scrollY : "66vh",
        scrollCollapse: true,
        lengthChange : true,
        lengthMenu : [ pageCd, pageNm ],
        
        ajax: {
            url: '<c:url value="/qm/shipInspStatusDetailList"/>',
            type: 'GET',
            data: {//            
            	//'reInspStatusArr'	:	function() { return reInspStatusArr; },
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },
				'dateCheck'			:	function() { return dateCheck; },
				'equipCd'			:	function() { return equipCd; },
				'inspStatus'		:	function() { return inspStatus; },
				'matrlLotNo'		:	function() { return $('#matrlLotNo').val(); },
				'filmLotNo'			:	function() { return $('#filmLotNo').val(); },
				'labelLotNoSeq'		:	function() { return $('#trayNo').val(); },
				'faultyStatus'		:	function() { return $('#faultyStatus option:selected').val(); },
            },
        },
        rowId: 'workOrdNo',
        columns: [
        	{
        		data: 'productDate',
        		render : function(data, type, row, meta){
        			if(data != null & data != ''){
        				return moment(data).format('YYYY-MM-DD');
        			} else {
        				return '';
        			}
        		}
        	},
        	{ data: 'trayWorkerIdNm'	},
        	{ data: 'inspChargrNm'	},
        	{ data: 'equipNm'		},
        	{ data: 'matrlLotNo'	},
        	{ data: 'filmLotNo'		},
        	{ data: 'trayNo'		},
        	{ data: 'labelLotNoSeq'	},
        	{ data: 'goodsNm'		},
        	{ data: 'qutyNm'		},
        	{
        		data: 'reInspStatus',
				'className' : 'text-center',
				render: function(data, type, row) {
					if(data == '001'){
						return '출하검사';
					} else if(data == '003'){
						return '출하재검사';
					}
					
				}
			
        	},
        	{ data: 'faultyStatusNm'},
        	{ data: 'equipNm'		},
        	{ data: 'workOrdNo'		},
        	{ data: 'workOrdLotNo'	},
        	{ data: 'updDate'},
        ],
        columnDefs: [
        	{ targets: "_all", className: 'text-center' }
        ],
        order: [
             [ 0, 'asc' ], [ 6, 'asc' ], [ 7, 'asc' ]
        ],
        buttons: ['copy', 'excel', 'print'],
        rowCallback: function (row, data) {
			if (data.trayNo.includes("_M") || data.trayNo.includes("_V") || data.trayNo.includes("_MV")) {
				$(row).addClass('skyYellow');
			}
			if (data.disStatus == "001") {
				$(row).addClass('whiteRed');
			}
		},
	});
	
	$('#infoDiv').insertAfter('.btn.btn-secondary.buttons-print');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[0]).attr('style', 'height: 25px;');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[1]).attr('style', 'height: 25px;');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[2]).attr('style', 'height: 25px;');
	

	stateTable.on('draw.dt', function(){
		$('#my-spinner').hide();
	});

	var html1 = '<div class="row">';
	html1 += '<select class="custom-select mr-2" id="dateCheck" style="width:80px;">';
	html1 += '<option value="001">생산일</option>';
	html1 += '<option value="002">검사일</option>';
	html1 += '</select>';
	html1 += '<div class="form-group input-sub m-0 row">';
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
	html1 += '</div>&nbsp;&nbsp;';
	
	html1 += '<div class="multipleSelection pos-real mr-2">';
	//html1 += '<label class="input-label-sm ml-1">설비명</label>';
	html1 += '<select class="custom-select custom-select1" id="equipCd"></select>';
	html1 += '<select class="custom-select custom-select1 ml-2" id="faultyStatus"></select>';
	html1 += '</div>';
	
	html1 += '<label class="input-label-sm ml-1 d-none">검사상태</label><select class="custom-select d-none" id="inspStatusSelect" style="width:80px;"></select>';
	
	//html1 += '&nbsp;&nbsp;<label class="input-label-sm ml-1">자재LOT</label>';
	//html1 += '<div class="form-group-100 mr-4">';
	html1 += '<input type="text" class="form-control" style="width:150px;" id="matrlLotNo" placeholder="LOT 번호를 입력해주세요.">';
	html1 += '<input type="text" class="form-control ml-2" style="width:150px;" id="filmLotNo" placeholder="필름 번호를 입력해주세요.">';
	html1 += '<input type="text" class="form-control ml-2" style="width:150px;" id="trayNo" placeholder="트레이 번호를 입력해주세요.">';
	//html1 += '</div>';

	html1 += '&nbsp;<button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button>';
	html1 += '&nbsp;<button type="button" class="btn btn-success ml-2 d-none" id="btnResetRetv">검색 조건 초기화</button>';
	
	/* html1 += '<div class="d-none" style="position: fixed;top: 8.5%;left: 66%;background-color: lightpink;display: flex;flex-direction: column;color: black;font-size: 15px; padding: 0px 15px 0px 15px;" id="infoDiv" title="요약정보" >';
	html1 += '<label id="totalCount">전체 출하 검사 Lot : ...</label>';
	html1 += '<div> <label id="majorCount">major 부적합 건수 : ...</label> <label class="ml-3" id="totalFaultyCount">총 부적합 건수 : ...</label> </div>';
	html1 += '<div> <label id="minorCount">minor 부적합 건수 : ...</label> <label class="ml-3" id="faultyPercent">불량률 : ...</label> </div>';
	html1 += '</div>'; */
	
	html1 += '</div>';

	$('#stateTable_length').find('select[name=stateTable_length]').eq(0).attr('id', 'pageCount'); //묶음보기 기능 추가
	
	$('#stateTable_length').append(html1);

	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	selectBoxAppend(inspStatusCode, "inspStatusSelect", "" , "1");  
	selectBoxAppend_NameAdd(equipCode, "equipCd", "", "1", "설비");
	selectBoxAppend_NameAdd(faultyStatusCode, "faultyStatus", "", "1", "불량");
	
	$("#pageCount").insertAfter("#btnRetv");
	$("#pageCount").removeClass('custom-select custom-select-sm form-control form-control-sm');
	$("#pageCount").addClass('custom-select ml-2');
	
	//페이지 카운트 변경 시
	$(document).on('click','#pageCount',function(e){
		var dateCheckFix	= $('#dateCheck option:selected').val();
		var equipCdFix		= $('#equipCd option:selected').val();
		var faultyStatusFix	= $('#faultyStatus option:selected').val();
		
		$(document).on('change','#pageCount',function(e){
			//selectBoxAppend(inspStatusCode, "inspStatusSelect",  , "1");
			$('#dateCheck').val(dateCheckFix);
			selectBoxAppend_NameAdd(equipCode, "equipCd", equipCdFix, "1", "설비");
			selectBoxAppend_NameAdd(faultyStatusCode, "faultyStatus", faultyStatusFix, "1", "불량"); po/changeGoodsProductFaultyType
		});
	});
	
	//조회 버튼 클릭
	$('#btnRetv').on('click', function() {
    	chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		dateCheck	= $('#dateCheck').val();
  		inspStatus	= $('#inspStatusSelect').val();
  		equipCd 	= $('#equipCd').val();
  		
  		$('#stateTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});

	//초기화 조회 버튼 클릭
	$('#btnResetRetv').on('click', function() {
    	chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		inspStatus	= ""; 
  		equipCd		= "";

  		$('#inspStatusSelect').val("");
  		$('#equipCd').val("");
  		$('#matrlLotNo').val("");
  		 
  		$('#stateTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});
	
	
	/* stateTable.on('draw.dt', function(){
		if(factoryCode == "003") {
			summaryInformation();
		}
	});
	
	if(factoryCode == "003") {
		$('#infoDiv').removeClass('d-none');
	} */
	
	//요약정보 표시
	function summaryInformation() {
		
// 		console.time("sudel");
		//필요한 값만 담아주기
		var sudelArray = new Array();
		$.each(stateTable.data(),function(idx, itm){
		    var obj = new Object();
		    obj.labelLotNo = itm.labelLotNoSeq;
		    obj.faultyGubun = itm.faultyGubun;
		    
		    sudelArray.push(obj);
		});
		//필요한 값만 담아주기

		//중복제거
		var result = sudelArray.filter(function(item1, idx1) {
		    return sudelArray.findIndex(function(item2, idx2) {
		        return item1.labelLotNo == item2.labelLotNo
		    }) == idx1;
		});
		//중복제거
		
		//개수 구하기
		let majorCount = 0;
		let minorCount = 0;
		let totalCount = result.length;
		let totalFaultyCount = 0;
		
		for(var i=0; i<totalCount; i++) {
		    if( result[i].faultyGubun == "001" ) {
		        majorCount++;
		    } else if( result[i].faultyGubun == "002" ) { 
		        minorCount++;
		    }
		}
		
		totalFaultyCount = majorCount + minorCount;
		
		//개수 구하기
// 		console.timeEnd("sudel");
		
		/* console.time("sudel");
		let data		= stateTable.data().sort((a, b) => a.labelLotNoSeq - b.labelLotNoSeq);
		let dataCheck	= '';
		
		let majorCount = 0;
		let minorCount = 0;
		let totalCount = 0;
		for(var i=0; i<data.length; i++) {
			if( data[i].labelLotNoSeq != dataCheck ) {
				dataCheck = data[i].labelLotNoSeq;
				
				if( data[i].faultyGubun == "001" ) {
			        majorCount++;
			    } else if( data[i].faultyGubun == "002" ) { 
			        minorCount++;
			    }
				totalCount++;S
			}
		}
		console.timeEnd("sudel"); */
		
		//화면단 표시
		/* $('#totalCount').text('전체 출하 검사 Lot : ' + addCommas(totalCount) +'건');
		$('#majorCount').text('Major 부적합 건수 : ' + addCommas(majorCount) +'건');
		$('#minorCount').text('Minor 부적합 건수 : ' + addCommas(minorCount) +'건');
		$('#totalFaultyCount').text('총 부적합 건수 : ' + addCommas( totalFaultyCount ) +'건'); */
		
		$('#totalCount').text(addCommas(totalCount) +'건');
		$('#majorCount').text(addCommas(majorCount) +'건');
		$('#minorCount').text(addCommas(minorCount) +'건');
		$('#totalFaultyCount').text(addCommas( totalFaultyCount ) +'건');
		
		$('#faultyPercent').text(( ( totalFaultyCount / totalCount ) *100 ).toFixed(2) +'%');
		//화면단 표시
	}
   
</script>

</body>
</html>
