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
				<li class="breadcrumb-item active">수주현황</li>
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
					<table id="purchaseOutputHistTable" class="table table-bordered">
						<thead class="thead-light">
							<!--==========table thead 추가==========-->
							<tr>
								<th>납기일</th>
								<th>거래처</th>
								<th>금액</th>
								<th>모델No</th>
								<th>PO Number</th>
								<th>제품명</th>
								<th>재질</th>
								<th>두께</th>
								<th>폭</th>
								<th>넓이</th>
								<th>길이</th>
								<th>피치</th>
								<th>오더량</th>
								<th>기출고량</th>
								<th>출고량</th>
								<th>미출고량</th>
								<th>출고일</th>
								<th>오더구분</th>
								<!-- <th>출고처</th> -->
								<th>비고</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="2" style="text-align: center">합계</td>
								<td colspan="" id="sumTotalPrice" style="text-align: right">0</td>
								<td colspan="9"></td>
								<td colspan="" id="sumPoQty" style="text-align: right">0</td>
								<td colspan="" id="sumPreOutputQty" style="text-align: right">0</td>
								<td colspan="" id="sumOutputQty" style="text-align: right">0</td>
								<td colspan="" id="sumRemainQty" style="text-align: right">0</td>
								<td colspan="3"></td>
							</tr>
						</tfoot>
					</table>
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

	let menuAuth = 'bssc0030';
	let currentHref = 'bssc0030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","수주현황");
    let viewIdx;
    let sideView = 'add';
	var outputHistDate =  "${serverDate}";
	var outputHistDateFrom = "${serverDateFrom}";   
	var outputHistDateTo = "${serverDate}";
	var poGubunCd =  ""; 

	//공통코드 시작
    var poGubunCode=new Array();
    <c:forEach items="${poGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		poGubunCode.push(json);
    </c:forEach>
  	//공통코드 종료

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable = $('#purchaseOutputHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        scrollX : false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/bs/purchaseOutputHistList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'outputHistDateFrom': function() { return outputHistDateFrom.replace(/-/g, ''); },
	           	'outputHistDateTo': function() { return outputHistDateTo.replace(/-/g, ''); },
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
            { data: 'deliveryDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
            },
            { data: 'dealCorpNm' },
            { data: 'totalPrice' },
            { data: 'poCode' },//->모델No
            { data: 'poNo' },
            { data: 'goodsNm' },
            { data: 'qutyNm' },
            { data: 'thickness',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'depth',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'width',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'length',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'pitch',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'poQty' },        
            { data: 'preOutputQty' },              
            { data: 'outputQty' },  
            { data: 'remainQty' },                                   
            { data: 'outputHistDate',
	    		render: function(data, type, row) {			    			
					return moment(data).format('YYYY-MM-DD') ;
	    		}
            },
            { data: 'poGubunNm' },
			//{ data: 'deliveryDealCorpNm' },
            { data: 'poDesc' },                         
        ],
        columnDefs: [
        	{ targets: [2,7,8,9,10,11,12,13,14,15], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,7,8,9,10,11,12,13,14,15], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ],
            [ 4, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '수주현황',
            },
            {
                extend: 'excel',
                title: '수주현황',
            },
            {
                extend: 'print',
                title: '수주현황',
            },
        ],
        drawCallback: function () {
			//전역변수들
			var sumTotalPrice = $('#purchaseOutputHistTable').DataTable().column(2,{ page: 'all'} ).data().sum();
			var sumPoQty = $('#purchaseOutputHistTable').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sumPreOutputQty = $('#purchaseOutputHistTable').DataTable().column(13,{ page: 'all'} ).data().sum();	
			var sumOutputQty = $('#purchaseOutputHistTable').DataTable().column(14,{ page: 'all'} ).data().sum();					
			var sumRemainQty = $('#purchaseOutputHistTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			
			
			$('#sumTotalPrice').text(addCommas(sumTotalPrice.toFixed(0)));
			$('#sumPoQty').text(addCommas(sumPoQty.toFixed(0)));
			$('#sumPreOutputQty').text(addCommas(sumPreOutputQty.toFixed(0)));
			$('#sumOutputQty').text(addCommas(sumOutputQty.toFixed(0)));
			$('#sumRemainQty').text(addCommas(sumRemainQty.toFixed(0)));
        }
    });

	var html1 = '<div class="row">';
	html1 += '&nbsp;<label class="input-label-sm">납기일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate1" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate1,chooseDate1,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar1" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate2"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate2,chooseDate2,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';	
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">오더구분</label><select  class="custom-select" id="poGubunCd"></select>&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>';
	html1 += '</div>';

	$('#purchaseOutputHistTable_length').html(html1);
	$('#chooseDate1').val(outputHistDateFrom);
	$('#chooseDate2').val(outputHistDate);
	selectBoxAppend(poGubunCode, "poGubunCd", "", "1");

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
		let dateFrom = new Date($('#chooseDate1').val());
		let dateTo = new Date($('#chooseDate2').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		
    	outputHistDateFrom =  $('#chooseDate1').val();
    	outputHistDateTo=  $('#chooseDate2').val();
		poGubunCd =  $('#poGubunCd').val();   
		$('#purchaseOutputHistTable').DataTable().ajax.reload( function () {});
    });	

</script>

</body>
</html>

