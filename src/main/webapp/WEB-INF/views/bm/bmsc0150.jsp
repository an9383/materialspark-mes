<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%	pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">
	<!-- Modal Start-->
	<div class="modal fade" id="layerPopUpModal" tabindex="-1"
		role="dialog" aria-labelledby="layerPopUpLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="layerPopUpLabel">기초코드등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<hr class="text-secondary">
					<table class="table table-sm table-bordered" id="layerPopUpTable">
					</table>
					<hr class="text-secondary">
				</div>
				<div class="modal-footer">
					<input type="hidden" class="form-control" id="puFlag" name="puFlag">
					<!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> -->
					<button type="button" class="btn btn-primary" id="layerPopUpSave">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End-->

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">외관&출하 검사 코드(068)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-30" id="left-30">
				<div class="card">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table class="table table-bordered" id="systemCommonCd">
							<thead class="thead-light">
								<tr>
									<th style="width: 70px">사용여부</th>
									<th style="width: 50px">코드</th>
									<th style="width: 80px">코드명</th>
									<th style="width: 40px">약칭</th>
									<th style="width: 50px">발생 구분</th>			<!-- 발생 구분(원자재/공정성) -->
									<th style="width: 50px">순번</th>				<!-- 순번 -->
									<th style="width: 50px">불량 구분</th>			<!-- 불량 구분(Major/Minor) -->
									<th style="width: 50px">재검 구분</th>			<!-- 재검 구분(부분재검/전수재검) -->
									<th style="width: 50px">검사 방법</th>			<!-- 검사 방법(재검사/재작업) -->
									<th style="width: 80px">동일불량 합격 수량(개)</th>	<!-- 동일불량 합격 수량 -->
									<th style="width: 80px">이종 불량 합격 수량(개)</th>	<!-- 이종 불량 합격 수량 -->
									<th style="width: 50px">체크8</th>
									<th style="width: 50px">체크9</th>
									<th style="width: 50px">체크10</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- .right-sidebar -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'bmsc0150';
	let currentHref = 'bmsc0150';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');  
	$(document).attr("title","와관&출하 검사 코드");

	//공통코드 처리 시작   	
	var useYnCode=new Array(); // 상태여부
    <c:forEach items="${useYnCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		useYnCode.push(json);
    </c:forEach>
    //공통코드 처리 종료 
        	
	//시스템공통코드 상세조회
	let baseGroupCd = "068";
	$.fn.dataTable.ext.errMode = 'none';
	let systemCommonCd = $('#systemCommonCd').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B", 		
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        //scrollX : true,
        pageLength: 20,	
		'ajax': {
				url: '<c:url value="bm/systemCommonCodeDataList"/>',
				type: 'GET',
				data: {
					'menuAuth'	 : menuAuth,
					'baseGroupCd': function() { return baseGroupCd; }
				},
			},
			columns: [
				{ data: 'useYnNm'		},
	  			{ data: 'baseCd'		},
	  			{ data: 'baseCdNm'		},
	  			{ data: 'baseCdAbbr'	},
	  			{ data: 'etc1',
				    render: function(data, type, row) {					
						if(data == "" || data == null) {
							return "-";
						} else {
							return data == "001" ? "원자재성 불량" : data == "002" ? "공정성 불량" : data;
						} 
				    }
	  			},  //발생 구분(원자재/공정성)
	  			{ data: 'etc2' },  //순번
	  			{ data: 'etc3',
				    render: function(data, type, row) {					
						if(data == "" || data == null) {
							return "-";
						} else {
							return data == "001" ? "Major" : data == "002" ? "Minor" : data;
						} 
				    }
	  			},  //불량 구분(Major/Minor)
	  			{ data: 'etc4',
				    render: function(data, type, row) {					
						if(data == "" || data == null) {
							return "-";
						} else {
							return data == "001" ? "출하재검" : data == "002" ? "부분재검" : data == "003" ? "전수재검" : data;
						} 
				    }
	  			},  //재검 구분(출하재검/부분재검/전수재검)
	  			{ data: 'etc5',
				    render: function(data, type, row) {					
						if(data == "" || data == null) {
							return "-";
						} else {
							return data == "001" ? "재검사" : data == "002" ? "재작업" : data;
						} 
				    }
	  			},  //검사 방법(재검사/재작업)
	  			{ data: 'etc6' },  // 합격 수량
	  			{ data: 'etc7' },  //이종 불량 합격 수량
	  			{ data: 'etc8' },
	  			{ data: 'etc9' },
	  			{ data: 'etc10' }
	  		],
	  		order: [
	  			[ 1, 'asc' ],
	  		],
	  		buttons: [
	            {
	                extend: 'copy',
	                title: '시스템 기초 코드 - 상세',
	            },
	            {
	                extend: 'excel',
	                title: '시스템 기초 코드 - 상세',
	            },
	            {
	                extend: 'print',
	                title: '시스템 기초 코드 - 상세',
	            },
	        ],  		
	});
	
	var htmlCd = '<button class="btn btn-primary float-left mr-2" type="button" id="baseCdAdd">등록</button>&nbsp;<button class="btn btn-primary float- mr-2" type="button" id="baseCdEdit">수정</button>';
	$('#systemCommonCd_length').html(htmlCd);
	
	// 시스템코드선택
	$('#systemCommonCd tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#systemCommonCd').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
   	});
		
   $('#baseCdAdd').click(function () {
   		addHtml("cdAdd");
   		$('#puBaseGroupCd').val(baseGroupCd);
   		selectBoxAppend(useYnCode, "puUseYnCd", "001", "2");
   		$('#layerPopUpLabel').text('코드등록');
   		$('#layerPopUpModal').modal('show');
   		
   		//기초코드상세 코드 조회
   		$.ajax({
        	url: '<c:url value="bm/readCommonSeq"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	            'baseGroupCd' : baseGroupCd,
            },
            success: function (res) {
                let data = res.data;
                let message = res.message;
                if(res.result == 'ok'){
					$('#puBaseCd').val(data.baseCd);
                }
                else if (res.result == 'fail') {
                	toastr.error(message, '', {timeOut: 5000});
				}
            }
        });
   		$('#layerPopUpModal').modal('show');
   	});

   	$('#baseCdEdit').click(function () {
   		var dataGrp = baseGroupCd;
   		if(dataGrp == null || dataGrp == undefined ) {
   			toastr.warning("수정할 기초코드들 먼저 선택해 주세요.");
   			return;
   		}
   		var data = systemCommonCd.row('.selected').data();
   		if(data == null || data == undefined ) {
   			toastr.warning("수정할 코드들 선택해 주세요.");
   		} else {
	   		addHtml("cdEdit");
	   		$('#puBaseGroupCd').val(dataGrp.baseGroupCd);	   		
	   		$('#puBaseCd').val(data.baseCd);	
	   		$('#puBaseCdNm').val(data.baseCdNm); 	
	   		$('#puBaseCdAbbr').val(data.baseCdAbbr);
	   		$('#puEtc1').val(data.etc1); 		
	   		$('#puEtc2').val(data.etc2); 		
	   		$('#puEtc3').val(data.etc3); 		
	   		$('#puEtc4').val(data.etc4); 		
	   		$('#puEtc5').val(data.etc5); 		
	   		$('#puEtc6').val(data.etc6); 		
	   		$('#puEtc7').val(data.etc7); 		
	   		$('#puEtc8').val(data.etc8); 		
	   		$('#puEtc9').val(data.etc9); 		
	   		$('#puEtc10').val(data.etc10);
	        $("#puBaseCd").attr("disabled",true); 
	   		selectBoxAppend(useYnCode, "puUseYnCd", data.useYnCd, "");	   		
	   		$('#layerPopUpLabel').text('코드수정');
	   		$('#layerPopUpModal').modal('show');
   		}
   	});
   	  	
   	//모달 저장 버튼 클릭 시
   	$('#layerPopUpSave').click(function () {
   	 	baseCdProc(puFlag);
   	}); 
	
	//시스템공통코드 등록,수정
	function baseCdProc(puFlag)
	{
	    if ( baseGroupCd == "" || baseGroupCd == null ) {
	        toastr.warning('기초코드를 확인해 주세요.');
	        return false;
	    }
	    if ( !$.trim($('#puBaseCd').val()) ) {
	        toastr.warning('코드를 입력해 주세요.');
	        $('#puBaseCd').focus();
	        return false;
	    }
	    if ( !$.trim($('#puBaseCdNm').val()) ) {
	        toastr.warning('코드명을 입력해 주세요.');
	        $('#puBaseCdNm').focus();
	        return false;
	    }
	   	if( $("#puUseYnCd option:selected").val() == "" ) {   
	        toastr.warning('사용여부 선택해 주세요.');
	        $('#puUseYnCd').focus();
	        return false;
	    }
	    
	    var cdUrl;
	    var cdMsg;
	    if(puFlag == "cdAdd") {
	    	cdUrl = '<c:url value="bm/systemCommonCodeCreate"/>';
	    	cdMsg = '세부코드가 등록 되었습니다.';
	    } else {
	    	cdUrl = '<c:url value="bm/systemCommonCodeUpdate"/>';
	    	cdMsg = '세부코드가 수정 되었습니다.';
	    }
	    $.ajax({
	        url: cdUrl,
	        type: 'POST',
	        data: {
	        	'menuAuth'	 : menuAuth,
				'baseGroupCd' 	: baseGroupCd,
				'baseCd' 		: $('#puBaseCd').val(),
				'baseCdNm' 		: $('#puBaseCdNm').val(),
				'baseCdAbbr' 	: $('#puBaseCdAbbr').val(),
				'etc1' 			: $('#puEtc1').val(),
				'etc2' 			: $('#puEtc2').val(),
				'etc3' 			: $('#puEtc3').val(),
				'etc4' 			: $('#puEtc4').val(),
				'etc5' 			: $('#puEtc5').val(),
				'etc6' 			: $('#puEtc6').val(),
				'etc7' 			: $('#puEtc7').val(),
				'etc8' 			: $('#puEtc8').val(),
				'etc9' 			: $('#puEtc9').val(),
				'etc10' 		: $('#puEtc10').val(),
				'useYnCd' 		: $("#puUseYnCd option:selected").val(),
	        },
	        beforeSend: function() {
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
	            	toastr.success(cdMsg);
	            	$('#layerPopUpModal').modal('hide');
	            	$('#systemCommonCd').DataTable().ajax.reload(); //등록 후 테이블 리로드
	            } else if(res.result == 'exist') {
	            	toastr.warning("이미 등록되어 있는 코드번호 입니다.");
	            	$('#layerPopUpModal').modal('hide');
	            	$('#systemCommonCd').DataTable().ajax.reload(); //등록 후 테이블 리로드		            	
	            } else {
	            	toastr.error(res.message, '', {timeOut: 5000});
	            }
	        },
	        complete:function(){
	            
	        }
	    });
	}	 

   	function addHtml(flag)
   	{
   	   	var html;
   	   	if(flag == "groupCdAdd" || flag == "groupCdEdit") { //기초코드수정
			html = '<tr>';
			html += '<td class="align-middle" style="width: 80px">기초코드</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseGroupCd" name="puBaseGroupCd" disabled></td>';	
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle"  style="width: 80px">*기초코드명</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseGroupCdNm"  name="puBaseGroupCdNm" maxlength="25"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle"  style="width: 80px">*사용여부</td>';
			html += '<td style="width: 100px"><select class="custom-select" id="puUseYnCd"></select></td>';
			html += '</tr>';			
			$('#layerPopUpTable').html(html);
			$('#puFlag').val(flag);
   	   	} else { // 코드수정
			html = '<tr>';
			html += '<td class="align-middle" style="width: 80px">*코드</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCd"  name="puBaseCd" maxlength="3"></td>';	
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">*코드명</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCdNm"  name="puBaseCdNm" maxlength="25"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">코드약칭</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puBaseCdAbbr"  name="puBaseCdAbbr" maxlength="64"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">발생 구분</td>';
			//html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc1"  name="puEtc1"></td>';
			
			//발생구분
			html += '<td style="width: 100px"><select class="custom-select" id="puEtc1"><option value="001">원자재성 불량</option><option value="002">공정성 불량</option></select></td>';
			
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">순번</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc2"  name="puEtc2"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">불량 구분</td>';
			//html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc3"  name="puEtc3"></td>';
			
			//불량 구분
			html += '<td style="width: 100px"><select class="custom-select" id="puEtc3"><option value="001">Major</option><option value="002">Minor</option></select></td>';
			
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">재검 구분</td>';
			//html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc4"  name="puEtc4"></td>';
			
			//재검 구분
			html += '<td style="width: 100px"><select class="custom-select" id="puEtc4"><option value="001">출하재검</option><option value="002">부분재검</option><option value="003">전수재검</option></select></td>';
			
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">검사 방법</td>';
			//html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc5"  name="puEtc5"></td>';
			
			//검사 방법
			html += '<td style="width: 100px"><select class="custom-select" id="puEtc5"><option value="001">재검사</option><option value="002">재작업</option></select></td>';
			
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">동일불량 합격 수량(개)</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc6"  name="puEtc6"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">이종 불량 합격 수량(개)</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc7"  name="puEtc7"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크8</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc8"  name="puEtc8"></td>';
			html += '</tr>';						
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크9</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc9"  name="puEtc9"></td>';
			html += '</tr>';																	
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">체크10</td>';
			html += '<td style="width: 100px"><input type="text" class="form-control" id="puEtc10"  name="puEtc10"></td>';
			html += '</tr>';
			html += '<tr>';
			html += '<td class="align-middle" style="width: 80px">*사용여부</td>';
			html += '<td style="width: 100px"><select class="custom-select" id="puUseYnCd"></select></td>';
			html += '<input type="hidden" id="puBaseGroupCd"  name="puBaseGroupCd">';
			html += '</tr>';
			$('#layerPopUpTable').html(html);
			$('#puFlag').val(flag);
   	   	}			
   	}

   	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});
   	
</script>

</body>
</html>
