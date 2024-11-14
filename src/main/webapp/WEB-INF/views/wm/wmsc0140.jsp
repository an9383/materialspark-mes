<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@ include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">설비별 투입 중량</li>
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
					<table id="inputWeightTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th class="text-center">설비명</th>
								<th class="text-center">제품명</th>
								<th class="text-center">작지일</th>
								<th class="text-center">작지번호</th>
								<th class="text-center">LotNo</th>
								<th class="text-center">자재명</th>
								<th class="text-center">투입 중량</th>
								<th class="text-center">양품 중량</th>
								<th class="text-center">불량 중량</th>
								<th class="text-center">재투입 여부</th>
								<th class="text-center">자재 교체위치</th>
								<th class="text-center">불량 상태</th>
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

	let menuAuth = 'wmsc0140';
	let currentHref = 'wmsc0140';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","설비별 투입 중량");

	let chooseDate1 	= "${serverDateFrom}"; 
	let chooseDate2 	= "${serverDate}"; 
    let excludingFilm 	= "excludingFilm";

	//공통코드 처리
	var equipCode = new Array(); // 설비코드
	<c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";
		equipCode.push(json);
	</c:forEach>
	//공통코드 처리 종료  
	
	
    //설비별 투입 중량 조회
    $.fn.dataTable.ext.errMode = 'none';
	let inputWeightTable = $('#inputWeightTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>" +
			 "<'row'<'col-sm-12'tr>>" +
			 "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 21,
        ajax: {
            url: '<c:url value="/wm/inputWeightList"/>',
            type: 'GET',
            data: {
	           	'menuAuth'	 		: menuAuth,
	           	'excludingFilm'		: function() { return excludingFilm },
	           	'chooseDateFrom'	: function() { return chooseDate1.replace(/-/g, ''); },
	           	'chooseDateTo'		: function() { return chooseDate2.replace(/-/g, ''); },
            },
        },
        rowId: 'lotNo',
        columns: [
			{ data : 'equipNm'			}
        	, { data : 'goodsNm'		}
        	, { data : 'ordDate',
        		render: function(data, type, row) {
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
            }
        	, { data : 'workOrdNo'		}
        	, { data : 'lotNo'			}
        	, { data : 'matrlNm'		}
        	, { data : 'inspectQty'		}
        	, { data : 'fairQty'		}
        	, { data : 'faultyQty'		}
        	, { data : 'remakeYnNm'		}
        	, { data : 'changeLocation'	}
        	, { data : 'faultyStatusNm'	}
        ],
        columnDefs: [
           	{ targets: [6,7,8] , render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [6,7,8], className: 'text-right' },
        ],
        //order: [
        //    [ 1, 'desc' ]
        //],
		drawCallback: function () {},
		buttons: [
            {
                extend: 'copy',
                title: '설비별 투입 중량',
            },
            {
                extend: 'excel',
                title: '설비별 투입 중량',
            },
            {
                extend: 'print',
                title: '설비별 투입 중량',
            }
        ],
    });

	//보기 
   	$('#inputWeightTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#inputWeightTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	});
    
    var sysdate = "${serverTime}";
    var html1 = '<div class="row">';
		html1 += '&nbsp;<label class="input-label-sm">작지일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDate1endar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDate2endar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		
		html1 += '<div class="multipleSelection pos-real ml-3 d-none">';
		html1 += '<div class="selectBox selectBox1" onclick="showCheckboxes()">';
		html1 += '<select class="custom-select custom-select1 w-120" id="selectEquipList">';
		html1 += '<option>설비 목록</option>';
		html1 += '</select>';
		html1 += '<div class="overSelect"></div>';
		html1 += '</div>';
		html1 += '<div id="checkBoxes" class="checkBoxes1 selectBoxOverFlow" style="height: 300px;display: block;position: fixed;top: 142px;left: 496px;">';
		html1 += '</div>';
		html1 += '</div>';
		
		html1 += '&nbsp; <button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button>';
		html1 += '<input type="checkbox" class="input-label-sm ml-2" style="width: 20px; height: 20px;" id="checkExcludingFilm" checked>'; 
		html1 += '<label class="input-label-sm" for="checkExcludingFilm">필름 미포함</label>';
		html1 += '</div>';
		
	$('#inputWeightTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	
	var html2 = '';
		html2 += '<label for="checkAll" style="margin-right: 0px;"><input type="checkbox" style="margin-right:6px;" id="checkAll" checked/>전체 선택/해제</label>';
	for (var i=0; i<equipCode.length; i++) {
		html2 += '<label for="' + equipCode[i].baseCdNm + '" style="margin-right: 0px;"><input type="checkbox" value="' + equipCode[i].baseCd + '" style="margin-right:6px;" id="' + equipCode[i].baseCdNm + '" checked/>' + equipCode[i].baseCdNm + '</label>';
	}

	$('#checkBoxes').html(html2);
	document.getElementById("checkBoxes").style.display = "none";
	

	var show = true;
    function showCheckboxes() {
        var checkboxes = document.getElementById("checkBoxes");
        if (show) {
            checkboxes.style.display = "block";
            show = false;
        } else {
            checkboxes.style.display = "none";
            show = true;
        }
    }

    //전체 선택
    $('#checkAll').on('click', function () {
    	if($('#checkAll').is(":checked") == true) {
    		for (var i=0; i<equipCode.length; i++) {
      			$('#' + equipCode[i].baseCdNm).prop("checked", true); 
        	}
    	}else {
    		for (var i=0; i<equipCode.length; i++) {
      			$('#' + equipCode[i].baseCdNm).prop("checked", false); 
        	}
        }
    });

    $('#checkExcludingFilm').on('click', function () {
    	if( $('#checkExcludingFilm').is(":checked") == true ) {
    		excludingFilm = "excludingFilm";
    	} else {
    		excludingFilm = null;
        }
    	$('#inputWeightTable').DataTable().ajax.reload(function() {});
    });
    
	//조회버튼 클릭
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDate1endar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDate1endar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDate1endar').focus();
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
			if (show == true) {
				showCheckboxes();
			}
			return false;
		}
		
		document.getElementById("checkBoxes").style.display = "none";
		show = true;
		  
		chooseDate1 	=  $('#chooseDateFrom').val();
		chooseDate2 	=  $('#chooseDateTo').val();
		$('#inputWeightTable').DataTable().ajax.reload(function() {});
    });

</script>

</body>
</html>