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
            <li class="breadcrumb-item">
              <a href="#">제품입출고관리</a>
            </li>
            <li class="breadcrumb-item active">PO 기준 미출고 현황</li>
           </ol>
          </nav>
         </header>       
          <!-- #main============================================================== -->
          <!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list" id="left-list">
                     <!-- .table-responsive -->
                     <div class="table-responsive">
                              <table id="purchaseOutputInfoTable" class="table table-bordered">
                                 <thead class="thead-light">
                                    <!--==========table thead 추가==========-->
		                        <tr>
		                            <th class="text-center">마감일</th>
		                            <th class="text-center">납기일</th>
		                            <th class="text-center">거래처</th>
		                            <th class="text-center">담당</th>
		                            <th class="text-center">PO Number</th>
		                            <th class="text-center">제품명</th>
		                            <th class="text-center">재질</th>
		                            <th class="text-center">규격</th>
		                            <th class="text-center">두께</th>
		                            <th class="text-center">폭</th>		                      
		                            <th class="text-center">길이</th>
		                            <th class="text-center">피치</th>
		                            <th class="text-center">요청량</th>
		                            <th class="text-center">기출고량</th>
		                            <th class="text-center">미출고량</th>		                            			                            	                            
		                            <th class="text-center">등록 번호</th>
		                            <!-- <th class="text-center">출고처</th> -->
		                            <th class="text-center">비고</th>
		                        </tr>
		                        </thead>
	                    </table>
                     </div>
                     <!-- /.table-responsive -->
                    </div>

                  </div><!-- /.left-list -->
              </div><!-- /.row -->
            </div><!-- / #main  -->
        </div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>


<script>
    
	let menuAuth = 'iosc0050';
	let currentHref = 'iosc0050';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","PO 기준 미출고 현황");

    let viewIdx;
    let sideView = 'add';
	var poDate =  "${serverDate}";
	var poDateFrom =  "${serverDateFrom}";
	var poDateTo =  "${serverDateTo}";
	var poGubunCd =  ""; 
	var outputGubun = '2';

	//공통코드 시작
    var poGubunCode=new Array();
    <c:forEach items="${poGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		poGubunCode.push(json);
    </c:forEach>

    var outputGubunCode = new Array();
	var json=new Object();
	json.baseCd="1";
	json.baseCdNm="출고완료";
	outputGubunCode.push(json);
	json=new Object();
	json.baseCd="2";
	json.baseCdNm="미출고";
	outputGubunCode.push(json);
  	//공통코드 종료

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputInfoTable = $('#purchaseOutputInfoTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
       //scrollY : 500,
       //responsive: true,
        ajax: {
            url: '<c:url value="/bs/purchaseOutputList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'poDateFrom': function() { return poDateFrom.replace(/-/g, ''); },
	           	'poDateTo': function() { return poDateTo.replace(/-/g, ''); },
	           	'outputGubun': function() { return outputGubun; },
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
					return moment(data).format('YYYY-MM-DD') ;
	    		}
            },
            { data: 'deadLine', 
	    		render: function(data, type, row) {			    			
					return moment(data).format('YYYY-MM-DD') ;
	    		}
            },
            { data: 'dealCorpNm' },
            { data: 'poAttn' },
            { data: 'poNo' },
            { data: 'goodsNm' },
            { data: 'qutyNm' },
            { data:  'model'},
            { data: 'thickness' },          
            { data: 'depth' },            
            { data: 'length' }, 
            { data: 'pitch' }, 
            { data: 'poQty' },
            { data: 'outputQty' },                        
            { data: 'remainQty' },
            { data: 'poSeq' },
            //{ data: 'poDate',
	    	//	render: function(data, type, row) {			    			
			//		return moment(data).format('YYYY-MM-DD') ;
	    	//	}
            //},
            //{ data: 'deliveryDealCorpNm' }, 
            { data: 'poDesc' },                         
        ],
        columnDefs: [
        	{ targets: [8,9,10,11,12,13,14] , render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [8,9,10,11,12,13,14], className: 'text-right' }, 
        ],
        order: [
            [ 0, 'desc' ],
            [ 4, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품출고요청',
            },
            {
                extend: 'excel',
                title: '제품출고요청',
            },
            {
                extend: 'print',
                title: '제품출고요청',
            },
        ],
    });

    var html1 = '<div class="row">&nbsp;<label class="input-label-sm">마감일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate" name="chooseDate" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate,chooseDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="preInWhsDateCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 		
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateToCal,chooseDateToCal,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm">기간선택</button>';
	
    var html2 =  '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">오더여부</label><select  class="custom-select" id="poGubunCd" ></select>&nbsp; &nbsp;&nbsp;&nbsp;<label class="input-label-sm">출고구분</label><select  class="custom-select" id="outputGubun" ></select>&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>';
    
	$('#purchaseOutputInfoTable_length').html(html1 + html2);
	$('#chooseDate').val(poDateFrom);
	$('#chooseDateToCal').val(poDateTo);
	selectBoxAppend(poGubunCode, "poGubunCd", "", "1");
	selectBoxAppend(outputGubunCode, "outputGubun", "2", "1");
	   
    // 보기
    $('#purchaseOutputInfoTable tbody').on('click', 'tr', function () {

        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#purchaseOutputInfoTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#btnRetv').on('click', function() {
    	poDateFrom =  $('#chooseDate').val();
    	poDateTo =  $('#chooseDateToCal').val();
		poGubunCd =  $('#poGubunCd').val();   
		outputGubun = $('#outputGubun').val();
		if(dateCalc(poDateFrom,poDateTo) < 365){
			$('#purchaseOutputInfoTable').DataTable().ajax.reload( function () {});
		} else{
			toastr.warning("조회기간은 1년을 초과할 수 없습니다.");
		}
		
		
    });	

	//기간조회~
	$('#btnTerm').on('click',function() {
		datePickFun();
	});

	
	$('#datePick').on('click',function() {
		var id ='';
		
		$.each($('.calender ul li'), function(){
			if( $(this).hasClass('clicked') ){
				id = $(this).attr('id');
			}
		});			
		datePick(id, 'chooseDate', 'chooseDateToCal',  $('#select-year').val());
	});
        
	function dateCalc(poDateFrom,poDateTo){
	
		var stDate = new Date(poDateFrom);
		var endDate = new Date(poDateTo);		
		 
		var btMs = endDate.getTime() - stDate.getTime() ;
		var btDay = btMs / (1000*60*60*24) ;
		console.log(btDay);
		return btDay;

	}

</script>

</body>
</html>
