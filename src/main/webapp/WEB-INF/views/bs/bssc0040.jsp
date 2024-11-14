<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">수주집계표</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<div class="card" style="margin-bottom: 0px;">
					<div class="row" style="margin-bottom: 5px;">
						&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">마감일</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 150px;" type="month" id="chooseDate1" />							
						</div>
						&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 150px;" type="month" id="chooseDate2" />
							
						</div>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">오더구분</label>
						<select class="custom-select" style="width:70px;" id="orderGubun">
				
						</select>
					</div> 
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">거래처/품목별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">오더구분별</a></li>			
						</ul>
					</div>
					<br>
				<!-- .table-responsive -->
				<div id="View1">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>년월</th>
									<th>거래처</th>
									<th>모델No</th>									
									<th>제품명</th>
									<th>재질</th>								
									<th>수주수량</th>
									<th>수주금액</th>									
									<th>출고수량</th>
									<th>출고금액</th>
									<th>미출고수량</th>
									<th>미출고금액</th>								
									<th>오더구분</th>						
								</tr>
							</thead>
							<tfoot>
								<tr style="background-color:#edacb1; color:red">
									<td colspan="2" style="text-align: center">합계</td>
									<td colspan="3"></td>
									<td colspan="" id="sumInputQty" style="text-align: right">0</td>
									<td colspan="" id="sumInputPrice" style="text-align: right">0</td>
									<td colspan="" id="sumOutputQty" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPrice" style="text-align: right">0</td>
									<td colspan="" id="sumNotOutputQty" style="text-align: right">0</td>
									<td colspan="" id="sumNotOutputPrice" style="text-align: right">0</td>
									<td colspan="1"></td>
									
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<div id="View2" class="d-none">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable2" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>년월</th>
									<th>오더구분</th>
									<th>거래처</th>
									<th>모델No</th>									
									<th>제품명</th>
									<th>재질</th>								
									<th>수주수량</th>	
									<th>수주금액</th>								
									<th>출고수량</th>
									<th>출고금액</th>
									<th>미출고수량</th>
									<th>미출고금액</th>			
								</tr>
							</thead>
							<tfoot>
								<tr style="background-color:#edacb1; color:red">
									<td colspan="3" style="text-align: center">합계</td>
									<td colspan="3"></td>
									<td colspan="" id="sumInputQty2" style="text-align: right">0</td>
									<td colspan="" id="sumInputPrice2" style="text-align: right">0</td>
									<td colspan="" id="sumOutputQty2" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPrice2" style="text-align: right">0</td>
									<td colspan="" id="sumNotOutputQty2" style="text-align: right">0</td>
									<td colspan="" id="sumNotOutputPrice2" style="text-align: right">0</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'bssc0040';
	let currentHref = 'bssc0040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","수주집계표");
    let viewIdx;
    let sideView = 'add';
	var outputHistDate =  "${serverDate}";
	var outputHistDateFrom = "${serverDateFrom}";   
	var outputHistDateTo = "${serverDate}";
	var poGubunCd =  ""; 
	var tapTemp = 1;

	//공통코드 시작
    var poGubunCode=new Array();
    <c:forEach items="${poGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		poGubunCode.push(json);
    </c:forEach>
    
    var pageCountArray=new Array();	//pageCount
    <c:forEach items="${pageCount}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		pageCountArray.push(json);
    </c:forEach>
    
	selectBoxAppend(poGubunCode, "orderGubun", "", "1");
  	//공통코드 종료
	pageCountArray.sort(function(a, b) {
	  return a.baseCd - b.baseCd;
	});
	
	var pageCd = new Array();
	var pageNm = new Array();
	
	for(var i=0; i<=pageCountArray.length; i++){
		if(i==0){
			pageCd.push(-1);
			pageNm.push("All");
		}else{
			pageCd.push(pageCountArray[(i-1)].baseCd);
			pageNm.push(pageCountArray[(i-1)].baseCdNm);
		}
	}
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable = $('#purchaseOutputHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",    
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange : true,
        scrollY : "58vh",
        scrollCollapse: true,
//         pageLength: 16,
        lengthMenu : [ pageCd, pageNm ],
        ajax: {
            url: '<c:url value="/bs/purchaseOrderDealGoods"/>',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'outputHistDateFrom': function() { return outputHistDateFrom.substring(0,7).replace(/-/g, ''); },
	           	'outputHistDateTo': function() { return outputHistDateTo.substring(0,7).replace(/-/g, ''); },
	           	'poGubunCd': function() { return poGubunCd; },                
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'poNo',
        columns: [
            { data: 'deliveryDate',//년월
				render: function(data, type, row) {
						data = data + "01";
						return moment(data).format("YYYY-MM");
										
				}
            },
            { data: 'dealCorpNm', //거래처           	
				render: function(data, type, row) {
					if(row['dealCorpCd']=='99999'){	
						return "<span class='font-blue' >월소계</span>";
					} else{
						return data;
					}
					
				}
			 },
			 { data: 'poCode' },//모델NO
	         { data: 'goodsNm' },//제품명
	         { data: 'qutyNm' },//재질
	         { data: 'poQty' },//수주수량
	         { data: 'totalPrice' }, //수주금액
	         { data: 'outputQty' },//발주(출고)수량
	         { data: 'outputPri' }, //발주(출고)금액
	         { data: 'remainQty' },//미출고량
	         { data: 'notOutputPri'}, //, //미출고금액
	         { data: 'poGubunNm' },//오더구분
        ],
        columnDefs: [
        	{ targets: [5,6,7,8,9,10], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [5,6,7,8,9,10], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '수주집계표(거래처/품목)',
            },
            {
                extend: 'excel',
                title: '수주집계표(거래처/품목)',
            },
            {
                extend: 'print',
                title: '수주집계표(거래처/품목)',
            },
        ],
        drawCallback: function () {
        	$('#purchaseOutputHistTable tfoot').remove();
			//전역변수들
			var sumInputQty = 0 ;
			var sumInputPrice = 0 ;
			var sumOutputQty = 0 ;
			var sumOutputPrice = 0;
			var sumNotOutputQty = 0;
			var sumNotOutputPrice = 0; 
			
			sumInputQty =  ($('#purchaseOutputHistTable').DataTable().column(5,{ page: 'all'} ).data().sum() / 2);
			sumInputPrice =  ($('#purchaseOutputHistTable').DataTable().column(6,{ page: 'all'} ).data().sum() / 2);
			sumOutputQty =  ($('#purchaseOutputHistTable').DataTable().column(7,{ page: 'all'} ).data().sum() / 2);
			sumOutputPrice =  ($('#purchaseOutputHistTable').DataTable().column(8,{ page: 'all'} ).data().sum() / 2);
			sumNotOutputQty =  ($('#purchaseOutputHistTable').DataTable().column(9,{ page: 'all'} ).data().sum() / 2);
			sumNotOutputPrice =  ($('#purchaseOutputHistTable').DataTable().column(10,{ page: 'all'} ).data().sum() / 2);
			
			$('#sumInputQty').text(addCommas(sumInputQty.toFixed(0)));
			$('#sumInputPrice').text(addCommas(sumInputPrice.toFixed(0)));			
			$('#sumOutputQty').text(addCommas(sumOutputQty.toFixed(0)));
			$('#sumOutputPrice').text(addCommas(sumOutputPrice.toFixed(0)));			
			$('#sumNotOutputQty').text(addCommas(sumNotOutputQty.toFixed(0)));
			$('#sumNotOutputPrice').text(addCommas(sumNotOutputPrice.toFixed(0)));

			$('#purchaseOutputHistTable tbody tr').each(function(){
			 	
			 	if($(this).find('td').eq(1).text() == '월소계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}	
			});
        }
    });

	  $.fn.dataTable.ext.errMode = 'none';
		let purchaseOutputHistTable2 = $('#purchaseOutputHistTable2').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
			dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",     
	        language: lang_kor,
	        paging: true,
	        info: true,
	        ordering: false,
	        processing: true,
	        autoWidth: false,
	        scrollX : false,
	        lengthChange : true,
	        scrollY : "58vh",
	        scrollCollapse: true,
	    //    pageLength: 18,
	        lengthMenu : [ pageCd, pageNm ],
	        ajax: {
	            url: '<c:url value="/bs/purchaseOrderOrderGubun"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 : menuAuth,
		           	'outputHistDateFrom': function() { return outputHistDateFrom.substring(0,7).replace(/-/g, ''); },
		           	'outputHistDateTo': function() { return outputHistDateTo.substring(0,7).replace(/-/g, ''); },
		           	'poGubunCd': function() { return poGubunCd; },                
	            },
	            /*
	            success : function(res) {
	                console.log(res);
	            }
	            */
	        },
	        rowId: 'poNo',
	        columns: [
	        	{ data: 'deliveryDate',//년월
					render: function(data, type, row) {
							if( data == '999999'){
								return '';
							}
							else{
								data = data + "01";
								return moment(data).format("YYYY-MM");
							}
											
					}
	            },
	            { data: 'poGubunNm'},//오더구분
	            { data: 'dealCorpNm', //거래처           	
					render: function(data, type, row) {
						if(row['dealCorpCd']=='99999'){	
							return "<span class='font-red' >월소계</span>";
						} else{
							return data;
						}
						
					}
				 },
				 { data: 'poCode' },//모델NO
		         { data: 'goodsNm' },//제품명
		         { data: 'qutyNm' },//재질
		         { data: 'poQty' },//수주수량
		         { data: 'totalPrice' }, //수주금액
		         { data: 'outputQty' },//발주(출고)수량
		         { data: 'outputPri'},  //발주(출고)금액		      
		         { data: 'remainQty'},//미출고량
		         { data: 'notOutputPri'}, //미출고금액

				//{ data: 'deliveryDealCorpNm' },
	                   
	        ],
	        columnDefs: [
	        	{ targets: [6,7,8,9,10,11], render: $.fn.dataTable.render.number( ',' ) },
	        	{ targets: [6,7,8,9,10,11], className: 'text-right-td' },
	        ],
	       
	        buttons: [
	            {
	                extend: 'copy',
	                title: '수주집계표(오더구분별)',
	            },
	            {
	                extend: 'excel',
	                title: '수주집계표(오더구분별)',
	            },
	            {
	                extend: 'print',
	                title: '수주집계표(오더구분별)',
	            },
	        ],
	        drawCallback: function () {
	        	$('#purchaseOutputHistTable2 tfoot').remove();
				//전역변수들
	        	var sumInputQty2 = 0 ;
				var sumInputPrice2 = 0 ;
				var sumOutputQty2 = 0 ;
				var sumOutputPrice2 = 0 ;
				var sumNotOutputQty2 = 0 ;
				var sumNotOutputPrice2 = 0 ;

				sumInputQty2 =  ($('#purchaseOutputHistTable2').DataTable().column(6,{ page: 'all'} ).data().sum() / 2);
				sumInputPrice2 =  ($('#purchaseOutputHistTable2').DataTable().column(7,{ page: 'all'} ).data().sum() / 2);
				sumOutputQty2 =  ($('#purchaseOutputHistTable2').DataTable().column(8,{ page: 'all'} ).data().sum() / 2);
				sumOutputPrice2 =  ($('#purchaseOutputHistTable2').DataTable().column(9,{ page: 'all'} ).data().sum() / 2);
				sumNotOutputQty2 =  ($('#purchaseOutputHistTable2').DataTable().column(10,{ page: 'all'} ).data().sum() / 2);
				sumNotOutputPrice2 =  ($('#purchaseOutputHistTable2').DataTable().column(11,{ page: 'all'} ).data().sum() / 2);
				
				$('#sumInputQty2').text(addCommas(sumInputQty2.toFixed(0)));
				$('#sumInputPrice2').text(addCommas(sumInputPrice2.toFixed(0)));
				$('#sumOutputQty2').text(addCommas(sumOutputQty2.toFixed(0)));
				$('#sumOutputPrice2').text(addCommas(sumOutputPrice2.toFixed(0)));
				$('#sumNotOutputQty2').text(addCommas(sumNotOutputQty2.toFixed(0)));
				$('#sumNotOutputPrice2').text(addCommas(sumNotOutputPrice2.toFixed(0)));
				
				/* console.log(sumInputQty2);
				console.log(sumInputPrice2);
				console.log(sumOutputQty2);
				console.log(sumOutputPrice2);
				console.log(sumNotOutputQty2);
				console.log(sumNotOutputPrice2); */

				$('#purchaseOutputHistTable2 tbody tr').each(function(){
				 	
				 	if($(this).find('td').eq(2).text() == '' && $(this).find('td').eq(3).text() == '') {
						$(this).css('background-color','#aed3ec');
						$(this).css('color','blue');
				 	}	
				});
	        }
	    });

	$('#chooseDate1').val(moment(outputHistDateFrom).format("YYYY-MM"));
	$('#chooseDate2').val(moment(outputHistDateTo).format("YYYY-MM"));
	
    // 보기
    $('#purchaseOutputHistTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#purchaseOutputHistTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#btnRetv').on('click', function() {
    	outputHistDateFrom =  $('#chooseDate1').val();
    	outputHistDateTo=  $('#chooseDate2').val();
		poGubunCd =  $('#orderGubun').val();   
		$('#purchaseOutputHistTable').DataTable().ajax.reload( function () {});
		$('#purchaseOutputHistTable2').DataTable().ajax.reload( function () {});
    });	

	$('#tab1').click(function() {
		$('#View1').removeClass("d-none");
		$('#View2').addClass("d-none");
		tapTemp = 1;
		$('#purchaseOutputHistTable').DataTable().ajax.reload();
	});
	
	$('#tab2').click(function() {
		$('#View1').addClass("d-none");
		$('#View2').removeClass("d-none");
		tapTemp = 2;
		$('#purchaseOutputHistTable2').DataTable().ajax.reload();
	});

	$('#orderGubun').change(function() {
		poGubunCd =  $('#orderGubun').val();
		if (tapTemp == 1) {
			$('#purchaseOutputHistTable').DataTable().ajax.reload();
			$('#purchaseOutputHistTable2').DataTable().clear().draw();
		} else if(tapTemp == 2) {
			$('#purchaseOutputHistTable1').DataTable().clear().draw();
			$('#purchaseOutputHistTable2').DataTable().ajax.reload();
		}
    });

	
	/* $('#purchaseOutputHistTable_length').append(html1);
	$('#chooseDate1').val(outputHistDateFrom);
	$('#chooseDate2').val(outputHistDateTo);
	selectBoxAppend(poGubunCode, "orderGubun", "", "1");
	
	$('#purchaseOutputHistTable_length').find('select[name=purchaseOutputHistTable_length]').eq(0).attr('id', 'pageCount');
	$("#pageCount").insertAfter("#btnRetv");
	$('#purchaseOutputHistTable_length').find('label').eq(0).remove();
	$("#pageCount").removeClass('custom-select custom-select-sm form-control form-control-sm');
	$("#pageCount").addClass('custom-select ml-2'); 
	//dataTable lengthChange
	$(document).on('click','#pageCount',function(e){
		var orderGubunFix	= $('#orderGubun option:selected').val();
		$(document).on('change','#pageCount',function(e){
			selectBoxAppend_NameAdd2(poGubunCode, "orderGubun", orderGubunFix, "1","");
		});
	}); */
</script>

</body>
</html>

