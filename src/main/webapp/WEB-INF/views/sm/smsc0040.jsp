<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>


<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
                <li class="breadcrumb-item">
                  <a href="#">시스템관리</a>
                </li>
                <li class="breadcrumb-item active">시스템 관리</li>
               </ol>
              </nav>
             </header> 
          <!-- #main============================================================== -->
		<div class="container-fluid" id="main">
    	<div class="row table-wrap-hid">	
    	   <!--======================== .left-list ========================-->
   			<div class="left-list" id="left-30" style="width:100%;">
            	<div class="card">                  
                	<div class="table-responsive">
						<table class="table table-bordered" id="pageSettingTable">
							<thead class="thead-light">
								<tr>
									<th>대메뉴</th>
									<th>소메뉴</th>
									<th>기능</th>
									<th>상태 확인</th>
									<th>버튼</th>
								</tr>
							</thead>
							<tbody>
								<!-- singleTon -->
								<tr>
									<td class="text-center">입출고관리</td>
									<td class="text-center">자재 입고현황관리</td>
									<td class="text-center">가입고 등록</td>
									<td class="text-center" id="useMatrlInout" style="font-weight:bold;"></td>
									<td>
										<button type="button" class="btn btn-primary" id="btnUseMatrlInout" onclick="pageSettingReset('useMatrlInout')" disabled>초기화</button>
									</td>
								</tr>
								<tr>
									<td class="text-center">공정실적관리(POP)</td>
									<td class="text-center">생산실적라벨발행</td>
									<td class="text-center">제품 포장</td>
									<td class="text-center" id="useGoodsPacking" style="font-weight:bold;"></td>
									<td>
										<button type="button" class="btn btn-primary" id="btnUseGoodsPacking" onclick="pageSettingReset('useGoodsPacking')" disabled>초기화</button>
									</td>
								</tr>
								<tr>
									<td class="text-center">공정실적관리(POP)</td>
									<td class="text-center">작업지시선택</td>
									<td class="text-center">트레이 생산 기능</td>
									<td class="text-center" id="useTrayProduce" style="font-weight:bold;"></td>
									<td>
										<button type="button" class="btn btn-primary" id="btnUseTrayProduce" onclick="pageSettingReset('useTrayProduce')" disabled>초기화</button>
									</td>
								</tr>
								
								<tr>
									<td class="text-center">공정실적관리(POP)</td>
									<td class="text-center">작업지시선택</td>
									<td class="text-center">트레이 생산 기능(배열)</td>
									<td class="text-center" id="useTrayProduceArray" style="font-weight:bold;">
										<button type="button" class="btn btn-primary" id="btnUseTrayProduceArrayList">보기</button>
									</td>
									<td>
										<button type="button" class="btn btn-primary" id="btnUseTrayProduceArray" onclick="pageSettingReset('useTrayProduceArray')">초기화</button>
									</td>
								</tr>
								<!-- singleTon -->

								<!-- Lock -->
								<tr>
									<td class="text-center">공정실적관리(POP)</td>
									<td class="text-center">생산실적라벨발행</td>
									<td class="text-center">제품 포장 기능 잠금</td>
									<td class="text-center" id="lockGoodsPacking" style="font-weight:bold;"></td>
									<td>
										<button type="button" class="btn btn-primary" id="btnLockGoodsPacking" onclick="pageSettingReset('lockGoodsPacking')">잠금 & 해제</button>
									</td>
								</tr>
								<tr>
									<td class="text-center">공정실적관리(POP)</td>
									<td class="text-center">작업지시선택</td>
									<td class="text-center">트레이 생산 기능</td>
									<td class="text-center" id="lockTrayProduce" style="font-weight:bold;"></td>
									<td>
										<button type="button" class="btn btn-primary" id="btnLockTrayProduce" onclick="pageSettingReset('lockTrayProduce')">잠금 & 해제</button>
									</td>
								</tr>
								<!-- Lock -->
							</tbody>
						</table>
	                </div>
	            </div>
	        </div>
	        <!-- /.page-section -->	  	
		</div>	
	</div>
</div>

<!-- 트레이 생산 기능(배열)확인 모달 시작 -->
<div class="modal fade" id="useTrayProduceArrayTablePopupModal" tabindex="-1" role="dialog" aria-labelledby="useTrayProduceArrayTablePopupModalLabel" aria-hidden="true" style="background-color: #2a2a2a2f;">
	<div class="modal-dialog">
		<div class="modal-content" style="position: absolute; left: 50%; transform: translate(-50%, -0%);">
			<div class="modal-header mb-2">
				<h5 class="modal-title" id="">트레이 생산 기능(배열) 확인</h5>
				<button type="button" class="btn btn-primary ml-5 touch6" id="btnTrayReload">자동 새로고침</button>
				<label class="d-none ml-3" style="line-height: 30px;" id="checkCount">(0/50)</label>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table table-sm table-bordered" style="font-size: 13px;text-align: center;" id="useTrayProduceArrayTable">
					<colgroup>
						<col width="5%">
						<col width="20%">
						<col width="5%">
						<col width="20%">
						<col width="5%">
						<col width="20%">
						<col width="5%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>index</th>
							<th>value</th>
							<th>index</th>
							<th>value</th>
							<th>index</th>
							<th>value</th>
							<th>index</th>
							<th>value</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 트레이 생산 기능(배열)확인 모달 끝 -->

<%@include file="../layout/bottom.jsp" %>

<script>   
    		
	let menuAuth	= 'smsc0040';
	let currentHref = 'smsc0040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","시스템 관리");

	let useMatrlInout			= "${useMatrlInout}";
	let useGoodsPacking			= "${useGoodsPacking}";
	let useTrayProduce			= "${useTrayProduce}";
	let useTrayProduceArray		= "${useTrayProduceArray}";
	
	let lockGoodsPacking		= "${lockGoodsPacking}";
	let lockTrayProduce			= "${lockTrayProduce}";

	
	let checkValue = "002";	//새로고침 상태 값 확인(001: 자동 / 002: 수동)
	let checkCount = 0;

	//가입고 등록
	if (useMatrlInout == 'true') {
		$('#useMatrlInout').text('사용(포장 중)');
		$('#useMatrlInout').attr('style', 'color: red;');
		$('#btnUseMatrlInout').attr('disabled', false);
	} else if (useMatrlInout  == 'false') {
		$('#useMatrlInout').text('미사용');
		$('#useMatrlInout').attr('style', 'color: green;');
		$('#btnUseMatrlInout').attr('disabled', true);
	} else {
		toastr.warning('가입고 등록 기능 상태값 오류!', '', {timeOut: 5000});
	}

	//제품포장 등록
	if (useGoodsPacking == 'true') {
		$('#useGoodsPacking').text('사용(포장 중)');
		$('#useGoodsPacking').attr('style', 'color: red;');
		$('#btnUseGoodsPacking').attr('disabled', false);
	} else if (useGoodsPacking  == 'false') {
		$('#useGoodsPacking').text('미사용');
		$('#useGoodsPacking').attr('style', 'color: green;');
		$('#btnUseGoodsPacking').attr('disabled', true);
	} else {
		toastr.warning('제품 포장 기능 상태값 오류!', '', {timeOut: 5000});
	}

	//트레이 생산 기능
	if (useTrayProduce == 'true') {
		$('#useTrayProduce').text('사용(포장 중)');
		$('#useTrayProduce').attr('style', 'color: red;');
		$('#btnUseTrayProduce').attr('disabled', false);
	} else if (useTrayProduce  == 'false') {
		$('#useTrayProduce').text('미사용');
		$('#useTrayProduce').attr('style', 'color: green;');
		$('#btnUseTrayProduce').attr('disabled', true);
	} else {
		toastr.warning('트레이 생산 기능 상태값 오류!', '', {timeOut: 5000});
	}

	//트레이 상태 확인 보기 버튼 클릭 시(트레이 생산 기능 배열)
	$('#btnUseTrayProduceArrayList').on('click', function(){
		$('#useTrayProduceArrayTablePopupModal .modal-content').outerWidth(window.innerWidth - 920);
		$('#useTrayProduceArrayTablePopupModal').modal('show');
		trayTableReload();
	});

	//자동 새로고침
	$('#btnTrayReload').on('click', function(){
		checkCount = 0;
		$('#checkCount').text('(0/50)');
		if( $(this).text() == '자동 새로고침' ){
			$(this).text('정지');
			$('#checkCount').removeClass('d-none');
			checkValue = "001";
			autoTrayTableRefresh();
		} else {
			$('#checkCount').addClass('d-none');
			$('#my-spinner').show();
			checkValue = "002";
		}
	});




	//트레이 생산 기능
	if (useTrayProduce == 'true') {
		$('#useTrayProduce').text('사용(포장 중)');
		$('#useTrayProduce').attr('style', 'color: red;');
		$('#btnUseTrayProduce').attr('disabled', false);
	} else if (useTrayProduce  == 'false') {
		$('#useTrayProduce').text('미사용');
		$('#useTrayProduce').attr('style', 'color: green;');
		$('#btnUseTrayProduce').attr('disabled', true);
	} else {
		toastr.warning('트레이 생산 기능 상태값 오류!', '', {timeOut: 5000});
	}
	
	//제품포장 잠금
	if (lockGoodsPacking == 'true') {
		$('#lockGoodsPacking').text('잠금(제품포장 기능 사용 불가)');
		$('#lockGoodsPacking').attr('style', 'color: red;');
	} else if (lockGoodsPacking  == 'false') {
		$('#lockGoodsPacking').text('해제(제품포장 기능 사용 가능)');
		$('#lockGoodsPacking').attr('style', 'color: green;');
	} else {
		toastr.warning('제품 포장 잠금 상태값 오류!', '', {timeOut: 5000});
	}

	//트레이 생산 기능 잠금
	if (lockTrayProduce == 'true') {
		$('#lockTrayProduce').text('잠금(트레이 생산 기능 사용 불가)');
		$('#lockTrayProduce').attr('style', 'color: red;');
	} else if (lockTrayProduce  == 'false') {
		$('#lockTrayProduce').text('해제(트레이 생산 기능 사용 가능)');
		$('#lockTrayProduce').attr('style', 'color: green;');
	} else {
		toastr.warning('트레이 생산 기능 잠금 상태값 오류!', '', {timeOut: 5000});
	}
	

	//초기화버튼 클릭 시
	function pageSettingReset(pageSettingReset) {
		$.ajax({
			url : '<c:url value="/sm/pageSettingReset"/>',
			type : 'POST',
			data : {
				'menuAuth'	 		: 	menuAuth,
				'pageSettingReset'	:	function() { return pageSettingReset; },
			},
			success : function(res) {
				let data = res.data;
				if (res.result == "ok") {
					$('#my-spinner').show();
					toastr.success(res.message, '', {timeOut: 1000});
					setTimeout(function(){
						window.location.reload();
					}, 1100);
				} else if (res.result == "fail") {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == "error") {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
            complete:function() {
            }
		});
	}



	//트레이 모달 닫힘
	$('#useTrayProduceArrayTablePopupModal').on('hidden.bs.modal', function (e) {
		$('#my-spinner').show();
		checkValue = "002";
		checkCount = 0;
		$('#checkCount').addClass('d-none');
		setTimeout(function() {
			$('#my-spinner').hide();
		},3000)
	});


	//자동 새로고침
	function autoTrayTableRefresh(){
		if( checkValue == "001" ) {
			if( checkCount == 50 ) {
				$('#btnTrayReload').text('자동 새로고침');
				checkValue = "002";
				$('#checkCount').addClass('d-none');
			} else {
				setTimeout(function() {
					trayTableReload();
					autoTrayTableRefresh();
					checkCount++;
					$('#checkCount').text('('+checkCount+'/50)');
				}, 3000);
			}
			
		} else {
			$('#btnTrayReload').text('자동 새로고침');
			$('#my-spinner').hide();
		}
	}

	//트레이 테이블 리로드
	function trayTableReload(){
		$.ajax({
			url: '<c:url value="po/productionPerfTraySingleTonCheck"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'	 	: 	menuAuth,
			},
			success: function (res) {
				let array = res.array;
				if (res.result == 'ok') {

					if( checkValue == "002" ){
						toastr.success("조회되었습니다!");
					}
					//console.table(array);
					let html1 = '';
					for(var i=0; i < array.length/4; i++){
						html1 += '<tr>';
						
						html1 +='<td style="background: #d3d3d37a;">'+ i +'</td>';
						html1 += array[i] == null ? '<td>'+ array[i] +'</td>' : '<td style="background: lightgreen;">'+ array[i] +'</td>';

						html1 += '<td style="background: #d3d3d37a;">'+ (i+array.length/4) +'</td>';
						html1 += array[(i+array.length/4)] == null ? '<td>'+ array[(i+array.length/4)] +'</td>' : '<td style="background: lightgreen;">'+ array[(i+array.length/4)] +'</td>';

						html1 += '<td style="background: #d3d3d37a;">'+ (i+array.length/2) +'</td>';
						html1 += array[(i+array.length/2)] == null ? '<td>'+ array[(i+array.length/2)] +'</td>' : '<td style="background: lightgreen;">'+ array[(i+array.length/2)] +'</td>';

						html1 += '<td style="background: #d3d3d37a;">'+ (i+array.length/4*3) +'</td>';
						html1 += array[(i+array.length/4*3)] == null ? '<td>'+ array[(i+array.length/4*3)] +'</td>' : '<td style="background: lightgreen;">'+ array[(i+array.length/4*3)] +'</td>';

						html1 += '</tr>';
					}
					
					$('#useTrayProduceArrayTable tbody').empty();
					$('#useTrayProduceArrayTable tbody').append(html1);
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){}
		});
	}

</script>

</body>
</html>
