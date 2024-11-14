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
				<li class="breadcrumb-item"><a href="#">자재입출고관리</a></li>
				<li class="breadcrumb-item active">잔량이력관리 조회</li>
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
					<table id="productOutputTable" class="table table-bordered">
						<thead class="thead-light">
							<!--==========table thead 추가==========-->
							<tr>
								<th>잔량등록일</th>
								<th>투입일</th>
								<th>lotNo</th>
								<!-- <th>상태</th> -->
								<th>규격</th>
								<!-- <th>기존 중량</th> -->
								<th>중량</th>
								<th>등록호기</th>
								<th>재투입호기</th>
							</tr>
						</thead>
						
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

	let menuAuth = 'iosc3040';
	let currentHref = 'iosc3040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","잔량이력관리 조회");
	
	let outputHistDateFrom	= "${serverDateFrom}";   
	let outputHistDateTo	= "${serverDate}";
	
	outputHistDateFrom	= outputHistDateFrom.substring(0,7);   
	outputHistDateTo	= outputHistDateTo.substring(0,7);
	
	let sudel = 0;
	
	let lotNo = null;

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let productOutputTable = $('#productOutputTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        //scrollX : false,
        pageLength: 20,
       ajax: {
            url: '<c:url value="/io/remainQtyHistory"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: menuAuth,
	           	'chooseDateFrom'	: function() { return outputHistDateFrom.replace(/-/g, ''); },
	           	'chooseDateTo'		: function() { return outputHistDateTo.replace(/-/g, ''); },
	           	'lotNo'				: function() { return lotNo;} 
            },
        },
        rowId: '',
        columns: [
            { data: 'histDate',
				render: function(data, type, row) {
					if( data != null )
						return moment(data).format("YYYY-MM-DD HH:mm");
				}
            },
            { data: 'regDate',
				render: function(data, type, row) {
					if( data != null )
						return moment(data).format("YYYY-MM-DD HH:mm");
				}
            },
            { data: 'lotNo'				},
            //{ data: 'statusCd'			},
            { data: 'model'				},
            //{ data: 'inWhsQty'			},
            { data: 'remainQty',
            	render: function(data, type, row, meta) {
            		
            		if( data != null && data != "" ) {
            			sudel = data;
            		}
            		
					return sudel;
				}
            },
            { data: 'originalEquipNm'	},
            { data: 'equipNm'			},
        ],
        columnDefs: [ { targets: "_all", "defaultContent": "-" } ],
        order: [],
        buttons: [
            {
                extend: 'copy',
                title: '잔량이력관리',
            },
            {
                extend: 'excel',
                title: '잔량이력관리',
            },
            {
                extend: 'print',
                title: '잔량이력관리',
            },
        ],
		drawCallback: function () {}
    });

	//<label class="input-label-sm">잔량등록일</label>
	var html1 = '<div class="row">';
	html1 += '&nbsp;<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="month" id="chooseDate1" />';
	//html1 += '<button onclick="fnPopUpCalendar(chooseDate1,chooseDate1,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar1" type="button">';
	//html1 += '<span class="oi oi-calendar"></span>';
	//html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="month" id="chooseDate2"/>';
	//html1 += '<button onclick="fnPopUpCalendar(chooseDate2,chooseDate2,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">';
	//html1 += '<span class="oi oi-calendar"></span>';
	//html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary d-none" id="btnTerm">기간선택</button>';
	html1 += 'LotNo 조회 <input class="form-control" type="text" id="lotNoText">';
	html1 += '&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>';
	html1 += '</div>';

	$('#productOutputTable_length').html(html1);
	$('#chooseDate1').val(outputHistDateFrom);
	$('#chooseDate2').val(outputHistDateTo);

    // 보기
    $('#productOutputTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#productOutputTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#btnRetv').on('click', function() {
		let dateFrom	= new Date($('#chooseDate1').val());
		let dateTo		= new Date($('#chooseDate2').val());
		let dateDiff	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
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
		if (dateDiff >= 366) {
			toastr.warning("검색 가능 기간은 최대 1년입니다!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		
    	outputHistDateFrom	=  $('#chooseDate1').val();
    	outputHistDateTo	=  $('#chooseDate2').val();
    	
    	lotNo = $('#lotNoText').val();
		
		$('#productOutputTable').DataTable().ajax.reload( function () {});
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
		
		datePick(id, 'chooseDate1', 'chooseDate2',  $('#select-year').val());
	});
    
</script>

</body>
</html>

