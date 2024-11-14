<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/topPda.jsp"%>
<style>
body {
	overflow: hidden;
}
</style>
<!-- .app -->
<div class="app pda_mo_wrap" style="display: flex; flex-direction: column; height: 100%;">
	<header class="pda_mo_hd">
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc0030"><p class="mo_main_title">제품입고</p></a>
	</header>
	<!--====-sortbox-->
	<div class="mo_sortbox">
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">입고일</div>
			<div class="form-group input-sub col-9 m-0 p-0">
				<input class="form-control-md" type="text" id="chooseDate" disabled />
				<button onclick="fnPopUpCalendar(chooseDate,chooseDate,'yyyy-mm-dd');" class="btn btn-secondary input-sub-search-md" type="button" id="btnCalendar">
					<span class="oi oi-calendar"></span>
				</button>
			</div>
		</div>
		
		<!-- 3공장 창고 번호 스캔 하는 부분 -->
		<div class="col-12 row p-1" style="display:none;" id="hiddenToggle1">
			<div class="col-3 mo_sort_title">창고지정(스캔)</div>
			<div class="form-group input-sub col-9 m-0 p-0 row"">
				<input type="text" class="form-control-md" id="codeNum" inputmode="none">
			</div>
		</div>
		
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">창고지정</div>
			<div class="form-group input-sub col-9 m-0 p-0">
				<select class="custom-select custom-select-md" id="location" disabled></select>
			</div>
		</div>
		
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">Box No</div>
			<div class="form-group input-sub col-9 m-0 p-0">
				<input type="text" class="form-control-md" id="boxNo" inputmode="none">
			</div>
		</div>
	</div>
	<!--==버튼영역-->
	<div class="mo_btnbox pl-2 pr-2">
		<div class="float-left">
			<button type="button" class="btn btn-danger float-right" id="btnLineClear" disabled>라인삭제</button>
			<button type="button" class="btn btn-danger float-right mr-2" id="btnAllClear" disabled>전체삭제</button>
		</div>
		<div class="float-right">
			<button type="button" class="btn btn-secondary float-right" id="btnCancel">취소</button>
			<button type="button" class="btn btn-secondary float-right d-none" id="btnNew">새로 등록</button>
			<button type="button" class="btn btn-primary float-right mr-2" id="btnSave" disabled>저장</button>
		</div>
	</div>
	<br>
	<!--end버튼영역-->
	<!--end-sortbox-->
	<main style="height: calc(100vh - 50px); overflow: auto;">
		<div class="container-fluid bg_wh" id="main" style="height: 100%; display: flex; flex-direction: column;">
			<div class="card mo_card" style="OVERFLOW-Y: auto; width: 100%;">
				<div class="table-responsive">
					<table id="GoodsProductInfoTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 30px">순번</th>
								<th style="min-width: 40px">제품코드</th>
								<th style="min-width: 80px">제품명</th>
								<th style="min-width: 80px">박스번호</th>
								<th style="min-width: 50px">포장 수량</th>
								<th style="min-width: 50px">입고 수량</th>
								<th style="min-width: 80px">위치</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</main>
	<footer class="p-2" style="margin-top: auto;">
		<div class="mo_sumbox">
			<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
			<div class="row float-right">
				<div class="mo_roll mr-4">
					<!-- <label>합계</label><span class="mo_sum_font_lg" id="rowCount">0</span> <label>Roll</label> -->
				</div>
				
				<div class="mo_kg d-none" id="scanCheckBoxDiv">
					<div class="custom-control custom-control-inline custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="checkGubun" disabled>
						<label class="custom-control-label" for="checkGubun">스캔</label>
					</div>
				</div>
				
				<div class="mo_kg">
					<!-- <input type="checkbox" id="checkRestock" style="zoom:1.6; margin-top:2px; margin-right:3px;">
					<label>재입고</label> -->
					<div class="custom-control custom-control-inline custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="checkRestock">
						<label class="custom-control-label" for="checkRestock">재입고</label>
					</div>
				</div>
				<div class="mo_kg">
					<span class="mo_sum_font_lg" id="count">0</span><label>개수</label>
				</div>
			</div>
		</div>
	</footer>
</div>
<!-- /.app -->
<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp" %>
<%@include file="../layout/bottom.jsp" %>

<script>

	$(document).attr("title", "제품입고");
	let menuAuth = 'pdsc0030';
	var serverDate = "${serverDate}"
	var goodsCd = null;
	var goodsNm = null;
	var boxNo = null;
	var packCnt = null;
	var remainCnt = null;
	var locationCd = null;
	var locationNm = null;
	var count = 0;

	let factoryCode = "<%=factoryCode%>";


	if(factoryCode == '001' || factoryCode == '002') {
		$('#location').attr('disabled', false);
		$('#scanCheckBoxDiv').addClass('d-none');
	} else if(factoryCode == '003') {
		$('#location').attr('disabled', false);
		$('#scanCheckBoxDiv').removeClass('d-none');
	} else {
		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
	}

	//공통코드 처리 시작
	var locationCode = new Array(); // 설치장소
	<c:forEach items="${locationCode}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	json.etc2 = "${info.etc2}";
	locationCode.push(json);
	</c:forEach>
	//공통코드 처리 끝
	
	$(document).ready(function(){ 
		$('#checkGubun').attr('disabled',false);
	});

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ구분체크시 분류선택 히든처리ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ //
	$('#checkGubun').change(function(){
		if ($('#checkGubun').prop('checked')) {
			$('#codeNum').val("");
			$('#boxNo').val("");
			$('#hiddenToggle1').show();
			selectBoxAppend(locationCode, "location", "", "2");
			$('#codeNum').focus();
		} else {
			$('#boxNo').val("");
			$('#hiddenToggle1').hide();
			//창고지정 초기화
			selectBoxAppend(locationCode, "location", "", "2");
		}
	});
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ구분체크시 분류선택 히든처리ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ //
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ구분체크 후 입력박스의 값 입력 후 엔터를 눌렀을 때ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ //
	let codeNumVal ='';
	$("#codeNum").keydown(function() {
		if(event.keyCode == 13){
			var toastindex = 0;
			codeNumVal = $('#codeNum').val();

			if( codeNumVal == "" ) {
				toastr.warning("올바르지 않은 코드입니다.", '', {timeOut : 5000});
				return false;
			}
			
			//location_공통코드 조건 처리
			<c:forEach items="${locationCode}" var="info">
				if("${info.baseCd}" == codeNumVal){
					toastindex = 1;
					$('#codeNum').val("");
					$('#location').val(codeNumVal);
					$('#boxNo').val("");
				}
			</c:forEach>		
			
			if(toastindex != 1 ) {
				toastr.warning("올바르지 않은 코드입니다.", '', {timeOut : 5000});
				selectBoxAppend(locationCode, "location", "", "2");
			} else {
				$('#boxNo').focus();
				event.preventDefault();	//enterEventend
			}
		}
	});
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ창고 지정 분류 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ //
	

	selectBoxAppend(locationCode, "location", "", "2");
	$('#chooseDate').val(serverDate);
	$('#boxNo').focus();

	$("#location").change(function() {
		$('#boxNo').focus();
	});

	$.fn.dataTable.ext.errMode = 'none';
	let GoodsProductInfoTable = $('#GoodsProductInfoTable').on('error.dt', function(e, settings, techNote, message) {
			if (techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut : 5000	});
				location.href = "/";
			}
		}).DataTable({
		language : lang_kor,
		paging : false,
		info : false,
		ordering : true,
		processing : true,
		autoWidth : false,
		scrollX : false,
		lengthChange : false,
		searching : false,
		pageLength : 20,
		ajax : {
			url : '<c:url value="/tm/preGoodsOutputEmptyList"/>',
			type : 'GET',
			data : {
				'menuAuth' : menuAuth,
			},
		//         success : function(res) {
		//             console.log(res);
		//             rightSide = false;
		//         }
		},
		rowId : '',
		columns : [ {
			render : function(data, type, row, meta) {
				var rowNo = meta.row + 1;
				if (rowNo == 1) {
					//$('#btnSave').attr('disabled', false);
				}
				return meta.row + 1;
			}
		}, {
			data : 'goodsCd',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return goodsCd;
				}
			}
		}, {
			data : 'goodsNm',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return goodsNm;
				}
			}
		}, {
			data : 'boxNo',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return boxNo;
				}
			}
		}, {
			data : 'packCnt',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return packCnt;
				}
			}
		}, {
			data : 'remainCnt',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return remainCnt;
				}
			}
		}, {
			data : 'locationNm',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;

				} else {
					return locationNm;
				}
			}
		}, ],
		columnDefs : [ {
			"className" : "text-center",
			"targets" : "_all"
		} ],
		order : [ [ 0, 'desc' ] ],
		buttons : [],
		createdRow : function(row, data, dataIndex) {
			$(row).attr('data-location-cd', locationCd);
		},
		drawCallback : function() {
			$('.mo_card tbody').css('font-size', '10px');
		},
	});

	//$('#GoodsProductInfoTable').css('font-size', '12px' );

	var lineCheck = false;
	$('#GoodsProductInfoTable tbody').on( 'click', 'tr', function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			lineCheck = false;
		} else {
			$('#GoodsProductInfoTable').DataTable().$('tr.selected')
					.removeClass('selected');
			$(this).addClass('selected');
			lineCheck = true;
		}
	});

	$("#boxNo").keypress( function(e) {
		//alert(e.which);
		if (e.which == 13) {
			//키보드입력 말고 바코드로 스캔시 풀어주기
			if (!$.trim($('#boxNo').val())) {
				toastr.warning('바코드를 스캔해주세요!');
				$('#boxNo').focus();
				return false;
			}
			if ($("#chooseDate").val() == null || $("#chooseDate").val() == "") {
				$('#boxNo').focus();
				$("#chooseDate").focus();
				toastr.warning("입고일을 선택해주세요!");
				return false
			}
			
			//if( factoryCode == '003' ){
				if ($("#location").val() == null || $("#location").val() == "") {
					$('#boxNo').val("");
					toastr.warning("입고위치를 선택해주세요!");
					$("#location").focus();
					return false
				}				
			//}

			if ($('#boxNo').val().trim().length != "13" && $('#boxNo').val().trim().length != "15") {
				toastr.warning('제품 바코드가 아닙니다. 확인해주세요');
				$('#boxNo').select();
				return false;
			}

			var cval = compareBarcodeNo($('#boxNo').val().trim());
			if (cval == false) {
				toastr.warning('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', { timeOut : 5000 });
				$('#boxNo').select();
				return false;
			}

			let restock = 'no';
			//체크되어있으면 재입고 가능
			if ($('#checkRestock').prop('checked')) {
				restock = 'yes';
			}

			$.ajax({
				url : '<c:url value="/pd/goodsProductInfoData"/>',
				type : 'GET',
				data : {
					'menuAuth'	: menuAuth,
					'boxNo'		: $('#boxNo').val().trim(),
					'restock'	: restock,
					'baseCd'	: $("#location option:selected").val(),
				},
				beforeSend : function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success : function(res) {
					let data = res.data;
					
					if (res.result == 'ok') { //제품상태 포장, 제품입고

						/* if( factoryCode == "001" || factoryCode == "002" ){
							let tempLocationCd = res.locationCd;
							
							if ($('#GoodsProductInfoTable').DataTable().data().count() == 0) {
								$('#location').val(tempLocationCd);
							} else {
								if ($('#location').val() != tempLocationCd) {
									toastr.warning('ModelNo가 같은 제품끼리 입고 하실 수 있습니다!', '', {timeOut : 5000});
									return false;
								}
							}
						} */
						
						boxNo		= data.boxNo;
						goodsCd		= data.goodsCd;
						goodsNm		= data.goodsNm;
						packCnt		= data.packCnt;
						remainCnt	= data.remainCnt;
						locationCd	= $("#location option:selected").val();
						locationNm	= $("#location option:selected").text();
						
						$('#GoodsProductInfoTable').DataTable().row.add({}).draw(false);
						$('#btnSave').attr('disabled', false);
						$('#btnCalendar').attr('disabled', true);
						$('#btnLineClear').attr('disabled', false);
						$('#btnAllClear').attr('disabled', false);
						$('#location').attr('disabled', true);
						
						$('#boxNo').val(null);
						$('#boxNo').focus();
						
						count += 1;
						
						$('#count').text(count);
						toastr.success('추가되었습니다.');
						
					} else if (res.result == 'fail') { //제품 출하
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#boxNo').select();
					} else if (res.result == 'error') { // BoxNo 조회 에러
						toastr.error(res.message, '', { timeOut : 5000 });
						$('#boxNo').select();
					}
				},
				complete : function() {
					//$('#btnAddConfirm').removeClass('d-none');
					//$('#btnAddConfirmLoading').addClass('d-none');
				}
			});
		}
	});

	// 저장 처리
	$('#btnSave').on('click', function() {
		if (!$.trim($('#chooseDate').val())) {
			toastr.warning('입고일을 선택해주세요.');
			return false;
		}
		if ($("#location").val() == null || $("#location").val() == "") {
			$("#boxNo").val("");
			toastr.warning("입고위치를 선택해주세요!");
			$("#location").focus();
			return false
		}

		$('#my-spinner').show();

		createBarcodeNo();

		$.ajax({
			url : '<c:url value="/pd/updateProductLocation"/>',
			type : 'POST',
			data : JSON.stringify(boxNoList),
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			beforeSend : function() {
				//  $('#btnAddConfirm').addClass('d-none');
				//  $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					$('#btnAllClear').attr('disabled', true);
					$('#btnLineClear').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
					$('#boxNo').attr('disabled', true);
					$('#location').attr('disabled', true);
					toastr.success('제품입고 위치 저장 성공하였습니다.');
					$('#btnCancel').addClass('d-none');
					$('#btnNew').removeClass('d-none');
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {
						timeOut : 5000
					});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {
						timeOut : 5000
					});
				}
			},
			complete : function() {
				$('#my-spinner').hide();
			}
		});
	});

	var boxNoList;
	function createBarcodeNo() {
		boxNoList = new Array();
		var idx = 0;
		$('#GoodsProductInfoTable tbody tr').each(function() {
			var boxNo = $(this).find('td').eq(3).html();
			var locationCd = ($(this).data('location-cd'));
			//var locationCd = $("#location").val();
			var goodsInDate = $("#chooseDate").val().replace(/-/g, '');
			var rowData = new Object();
			rowData.menuAuth = menuAuth;
			rowData.boxNo = boxNo;
			rowData.locationCd = locationCd;
			rowData.goodsInDate = goodsInDate;
			boxNoList.push(rowData);
		});
		console.log(boxNoList);
		return idx;
	}

	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#GoodsProductInfoTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		$('#location').val('');
		$('#boxNo').val('');
		$('#boxNo').focus();
		count = 0;
		$('#count').text(count);
	});

	//라인 삭제
	$('#btnLineClear').on(
			'click',
			function() {
				if (lineCheck == true) {
					$('#GoodsProductInfoTable').DataTable().rows('.selected')
							.remove().draw();
					$("#boxNo").val("");
					$("#boxNo").focus();
					var rowCnt = $('#GoodsProductInfoTable').DataTable().data()
							.count();
					if (rowCnt == 0) {
						$('#location').val('');
						$('#btnSave').attr('disabled', true);
						$('#btnAllClear').attr('disabled', true);
						$('#btnLineClear').attr('disabled', true);
					}
					count -= 1;
					$('#count').text(count);
				} else {
					toastr.warning('삭제할 라인을 선택하세요.');
				}
			});

	//취소 버튼
	$('#btnCancel').on('click', function() {
		$('#btnCalendar').attr('disabled', false);

		if( factoryCode == "003" ) {
			$('#location').attr('disabled', false);
		}
		
		$('#btnSave').attr('disabled', true);
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#GoodsProductInfoTable').DataTable().clear().draw();
		$('#boxNo').val('');
		$('#boxNo').focus();
		$('#chooseDate').val(serverDate);
		selectBoxAppend(locationCode, "location", "", "2");
		count = 0;
		$('#count').text(count);
	});

	//저장 완료 후 새로등록
	$('#btnNew').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		
		//if( factoryCode == "003" ) {
			$('#location').attr('disabled', false);
		//}
		
		$('#boxNo').attr('disabled', false);
		$('#GoodsProductInfoTable').DataTable().clear().draw();
		$('#boxNo').val('');
		$('#btnCalendar').focus();
		$('#chooseDate').val(serverDate);
		selectBoxAppend(locationCode, "location", "", "2");
		$('#btnNew').addClass('d-none');
		$('#btnCancel').removeClass('d-none');
		count = 0;
		$('#count').text(count);
	});

	//중복 예외처리 사용예정
	function compareBarcodeNo(boxNo) {
		var result = true;
		$('#GoodsProductInfoTable tbody tr').each(function() {
			var tboxNo = $(this).find('td').eq(3).html();
			if (boxNo == tboxNo) {
				result = false;
				return result;
			}
		});
		return result;
	}

	//모바일 자판 On/Off
	$('#btnKeyboard').on('click', function() {
		var inputmode = $('#boxNo').attr('inputmode');
		if (inputmode == 'none') {
			$('#btnKeyboard').text("자판 On");
			$('#boxNo').attr('inputmode', 'text');
		} else if (inputmode == 'text') {
			$('#btnKeyboard').text("자판 Off");
			$('#boxNo').attr('inputmode', 'none');
		}
	});

	function selectBoxAppend(obj, id, sVal, flag) {
		$('#' + id).empty();

		if (flag == '1') {
			$('#' + id).append($("<option value=''>" + "전체" + "</option>"));
		} else if (flag == '2') {
			$('#' + id).append($("<option value=''>" + "선택" + "</option>"));
		}

		for (key in obj) {
			var option;
			if (obj[key].baseCd == sVal) {
				option = $("<option value=" + obj[key].baseCd + " name=" + obj[key].etc2 + " selected>"
						+ obj[key].baseCdNm + "</option>");
			} else {
				option = $("<option value=" + obj[key].baseCd + " name=" + obj[key].etc2 + ">"
						+ obj[key].baseCdNm + "</option>");
			}
			$('#' + id).append(option);
		}

	}
</script>

</body>
</html>