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
				<li class="breadcrumb-item active">불량중량</li>
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
					<table id="badWeightTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th class="text-center">설비명</th>
								<th class="text-center">제품명</th>
								<th class="text-center">재질</th>
								<th class="text-center">작지번호</th>
								<th class="text-center">주재료</th>
								<th class="text-center">작지일</th>
								<th class="text-center" style="min-width:40px;">불량일자</th>
								<th class="text-center">주야구분</th>
								<th class="text-center">불량항목 중분류 </th>
								<th class="text-center">불량항목 소분류</th>
								<th class="text-center">중분류 총횟수 </th>
								<th class="text-center">중분류 총중량(KG) </th>
								<th class="text-center">소분류 총횟수</th>
								<th class="text-center">소분류 중량(KG)</th>
								<th class="text-center">불량 시간</th>
								<th class="text-center">내용</th>
								<th class="text-center">시퀀스</th>
								<th class="text-center">불량 시간 차이</th>
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

	let menuAuth = 'wmsc0110';
	let currentHref = 'wmsc0110';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","불량중량");

	var chooseDate1 =  "${serverDateFrom}"; 
	var chooseDate2 =  "${serverDate}"; 
	
	//공통코드 처리 시작
	var gubunCode=new Array();	//불량구분
    <c:forEach items="${gubunCd}" var="info">
    	var json=new Object();
		json.baseCd="${info.baseGroupCd}";
		json.baseCdNm="${info.baseGroupCdNm}";
		gubunCode.push(json);
    </c:forEach>

	var equipCode = new Array(); // 설비코드
	<c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";
		equipCode.push(json);
	</c:forEach>
	
	//공통코드 처리 종료  
    
    var equipList = '';
	for (var i=0; i<equipCode.length; i++) {
		equipList += "/" + equipCode[i].baseCd;
	}
                             
    let viewIdx;
    let sideView = 'add';
	var inWhsDateCal =  "${serverDate}"; 
	var gubunCd =  "";   
	var gubunCdSmall =  "";   
	var matrlCd =  "";

	var gubuncdVal = '';
	var json = new Object();
	var colorStat = false;
	var equipNm = "";
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let badWeightTable = $('#badWeightTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: false,
        processing: true,
        autoWidth: false,
	
        pageLength: 21,
        ajax: {
            url: '<c:url value="/wm/badWeightList"/>',
            type: 'GET',
            data: {
	           	'menuAuth'	 		: menuAuth,
	           	'equipCd'			: function() { return equipList },
	           	'gubun'				: function() { return gubunCd },
	           	'systemCode'		: function() { return gubunCdSmall },
	           	'chooseDateFrom'	: function() { return chooseDate1.replace(/-/g, ''); },
	           	'chooseDateTo'		: function() { return chooseDate2.replace(/-/g, ''); },
            },
        },
        rowId: 'lotNo',
        columns: [
        	{ data : 'equipNm'		},//설비명
        	{ data : 'goodsNm'		},//제품명
        	{ data : 'qutyNm'},//재질
        	{ data : 'workOrdNo'	},//작지번호
        	{ data : 'lotNo'},//주재료
        	{ render: function(data, type, row) {
					return moment(row['ordDate']).format('YYYY-MM-DD');
				}
			},//작지일
        	{ render: function(data, type, row) {//불량일자
					return moment(row['faultyRegDate']).format('YYYY-MM-DD');
				}
			},
        	{ data : 'dayNightCdNm'	},//주야구분
        	{ data : 'gubunNm'		},//중분류
        	{ data : 'systemCodeNm'	},//소분류
        	{ data : 'prcsCnt'		},
			{ data: 'prcsTotal',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
        	{ data : 'faultyCount'	},
            { data: 'faulty',
		   		render: function(data, type) {
		   			if (data % 1 == 0) {
						return data;
					} else {
						return parseFloat(data).toFixed(3);
					}

		   		}
            },
            { render: function(data, type, row) {
				return moment(row['faultyDatetime']).format('YYYY-MM-DD HH:mm');
				}
			},//불량시간
        	{ data : 'faultyDesc'	},
        	{ data : 'faultySeq'	},
        	/* { 
            	render: function(data, type, row) {
                	if(row['faultyDatetime2'] != null){
	            		console.log();
	            		var date1 = new Date( moment(row['faultyatetime']).format('YYYY-MMDD HH:mm'));
	            		var date2 = new Date(moment(row['faultyDatetime2']).format('YYYY-MM-DD HH:mm'));
	            		var elapsedMSec = date1 - date2; // 9004000
	            		var elapsedSec = elapsedMSec / 1000; // 9004
	            		var elapsedMin = elapsedMSec / 1000 / 60; // 150.0666...
	            		var elapsedHour = elapsedMSec / 1000 / 60 / 60;
	            		var result = elapsedMin / 60;
	            		elapsedMin = elapsedMin % 60;
	            		return result.toFixed(0) + '시간 ' + elapsedMin + '분';
	                } else{
	                	return '';
		            }
        		}  				
  			}, */
        	{ data: 'faultyDatetime',
                render: function (data, type, row, meta ) {

	                  //console.log(Object.keys(meta));
	                  //console.log("row numb: ",meta.row);
	                  //console.log("meta",meta);
	                  //console.log("meta column",meta.column(4));
	                  //console.log("meta settings",meta.settings.aoData[meta.row]);
	                  //console.log("api",meta.settings.oApi._fnGetCellData(1,1));
	                  if (meta.row == 0 || (row['equipNm'] != meta.settings.aoData[meta.row-1]._aData.equipNm) || (row['systemCodeNm'] != meta.settings.aoData[meta.row-1]._aData.systemCodeNm)) {
						return '-'; 
	                  } else {
	                    // make a running total somehow
	                    var date1 = new Date(moment(data).format('YYYY-MM-DD HH:mm'));
	                    var date2 = new Date(moment(meta.settings.aoData[meta.row-1]._aData.faultyDatetime).format('YYYY-MM-DD HH:mm'))
	                    var elapsedMSec = date1 - date2;
	                    var elapsedSec = elapsedMSec / 1000; // 9004
	            		var elapsedMin = elapsedMSec / 1000 / 60; // 150.0666...
	            		var elapsedHour = elapsedMSec / 1000 / 60 / 60;
	            		var result = elapsedMin / 60;
	            		elapsedMin = elapsedMin % 60;
	                    return result.toFixed(0) + '시간 ' + elapsedMin + '분';
	                    //return (Number(meta.settings.aoData[meta.row-1]._aData.c) + Number(data));
	                    //return (Number(meta.settings.aoData[meta.row-1].anCells[3].innerText) + Number(data));
	                  }
	                
                }
              },
        ],
        columnDefs: [
           	{ targets: [10,11,12,13] , render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [11,13], className: 'text-right' },
           	{ targets: [10,12], className: 'text-center' }, 
        ],
        //order: [
        //    [ 1, 'desc' ]
        //],
		drawCallback: function () {
			
			
			$.each($('#badWeightTable tbody tr'),function(index, item, array){
					if($(this).find('td').eq(0).text() != equipNm){
						equipNm = $(this).find('td').eq(0).text();
						colorStat = !colorStat;	 
					}   			
	    			if(colorStat){
	    				$(this).css('background-color','#C8FFFF');
						
	        		} else{
	        			//$(this).css('background-color','#ffffff');
						
	            	}
				
			});
			$('#badWeightTable').rowspan(0);
		},
		buttons: [
            {
                extend: 'copy',
                title: '불량중량',
            },
            {
                extend: 'excel',
                title: '불량중량',
            },
            {
                extend: 'print',
                title: '불량중량',
            }
        ],
    });

	//보기 
   /*  $('#badWeightTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#badWeightTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	}); */
    
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
		
		html1 += '<div class="multipleSelection pos-real ml-3">';
		html1 += '<div class="selectBox selectBox1" onclick="showCheckboxes()">';
		html1 += '<select class="custom-select custom-select1 w-120" id="selectEquipList">';
		html1 += '<option>설비 목록</option>';
		html1 += '</select>';
		html1 += '<div class="overSelect"></div>';
		html1 += '</div>';
		html1 += '<div id="checkBoxes" class="checkBoxes1 selectBoxOverFlow" style="height:300px;">';
		html1 += '</div>';
		html1 += '</div>';
		
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">중분류</label><select  class="custom-select" id="gubunCd" ></select>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">소분류</label><select  class="custom-select" id="gubunCdSmall" ></select>';
		html1 += '&nbsp; <button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button>'
		html1 += '</div>';
		
	$('#badWeightTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	selectBoxAppend(gubunCode, "gubunCd", "", "1");
	selectBoxAppend("", "gubunCdSmall", "", "1");
	var html2 = '';
		html2 += '<label for="checkAll" style="margin-right: 0px;"><input type="checkbox" style="margin-right:6px;" id="checkAll" checked/>전체 선택/해제</label>';
	for (var i=0; i<equipCode.length; i++) {
		html2 += '<label for="' + equipCode[i].baseCdNm + '" style="margin-right: 0px;"><input type="checkbox" value="' + equipCode[i].baseCd + '" style="margin-right:6px;" id="' + equipCode[i].baseCdNm + '" checked/>' + equipCode[i].baseCdNm + '</label>';
	}

	$('#checkBoxes').html(html2);

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
    
    $('#gubunCd').change(function() {
    	$('#btnRetv').trigger('click');
    	gubuncdVal = $('#gubunCd option:selected').val();

    	var locationCodeSmall = new Array(); // 소분류
    	<c:forEach items="${locationCode}" var="info">
    		var json = new Object();
    		if("${info.baseGroupCd}" == gubuncdVal){
    			json.baseCd = "${info.baseCd}";
	    		json.baseCdNm = "${info.baseCdNm}";
	    		locationCodeSmall.push(json);
	    	}
    	</c:forEach>
    	selectBoxAppend(locationCodeSmall, "gubunCdSmall", "", "1");
    });
    $('#gubunCdSmall').change(function() {
    	$('#btnRetv').trigger('click');
    	
    	
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
		  
		gubunCd = $('#gubunCd option:selected').val();
		gubunCdSmall = $('#gubunCdSmall option:selected').val();
		chooseDate1 =  $('#chooseDateFrom').val();
		chooseDate2 =  $('#chooseDateTo').val();
		$('#badWeightTable').DataTable().ajax.reload(function() {});
    });

</script>

</body>
</html>