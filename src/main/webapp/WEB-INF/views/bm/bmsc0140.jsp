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
				<li class="breadcrumb-item"><a href="#">기준정보관리</a></li>
				<li class="breadcrumb-item active">고객사별단가등록</li>
			</ol>
		</nav>
	</header>
		<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list"
				style="width: 56%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="goodsCdTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 40px">제품코드</th>
									<th style="min-width: 60px">제품명</th>
									<th style="min-width: 100px">규격</th>
									<th style="min-width: 60px">모델NO</th>
									<th style="min-width: 100px">AL/Nicu</th>
									<th style="min-width: 100px">Film</th>
									<th>면취(압연)</th>
									<th>구분(연질/경질)</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->

			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav"
				style="width: 43%;">
				<div class="card mb-2" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12 p-1">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand"
								class="closebtn float-right" onclick="closerNav()"><i
								class="mdi mdi-close"></i></a>
						</div>
					</div>
						<div id="tab9">
							<div class="card-body col-sm-12 p-1 mb-2">
								<button type="button" class="btn btn-warning float-right mr-1"
									id="btnPriceDel">삭제</button>
								<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
									type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
								<button type="button" class="btn btn-primary float-right mr-1"
									id="btnPriceconfirm">수정</button>
								<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
									type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
								<button type="button" class="btn btn-primary float-right mr-1"
									id="btnPriceAdd">등록</button>
								<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
									type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
							</div>
							
							<!--/오른쪽 등록 부분 상단 버튼 영역-->
								<div class="table-responsive">
									<table class="table table-bordered" id="priceTable">
										<colgroup>
											<col width="6%">
											<col width="18%">
											<col width="18%">
											<col width="10%">
											<col width="15%">
											<col width="32%">
										</colgroup>
										<thead class="thead-light">
											<tr>
												<th>No.</th>
												<th>고객사명</th>
												<th>단가 적용일</th>
												<th>화폐단위</th>
												<th class="text-center">단가</th>
												<th>비고</th>
											</tr>
										</thead>
										<tbody id="dataList3"></tbody>
										<tbody id="dataInsert3"></tbody>
									</table>
								</div>
						</div>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
	<!-- 단가 등록 모달 시작-->
	<div class="modal fade bd-example-modal-lg" id="custCorpPriceMadal" tabindex="-1"
			role="dialog" aria-labelledby="inModalLabel5" data-backdrop="static" data-keyboard="false" aria-hidden="true" >
			<div class="modal-dialog modal-lg"  style="top:30%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" onClick="priceClose()" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form id="form9" method="post" enctype="multipart/form-data">
					<div class="modal-body">
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane fade active show" id="tab9">
								<table class="table table-bordered" id="custCorpPrice">
								<colgroup>
	                            <col width="10%">
	                            <col width="40%">
	                            <col width="10%">
	                            <col width="40%">	                            
	                        </colgroup>
									<tr>
										<th>*거래처명</th>
										<td>
											<div class="subinput m-0">
												<input type="hidden" class="form-control" id="dealCorpCd1" name="dealCorpCd1"> 
												<input type="text" class="form-control" id="dealCorpNm1" name="dealCorpNm1" style="max-width: 86%;float:left;" disabled>
												<button type="button" class="btn btn-primary subinput-search" id="btndealCorpNm1" name="btndealCorpNm1" style="float:right;" onClick="selectdealCorpNm1()" disabled>
													<span class="oi oi-magnifying-glass"></span>
												</button>
											</div>
										</td>
										<th>*단가적용일</th>
										<td>
											<input type="date" class="form-control" id="unitRegDate1" name="unitRegDate1" style="max-width: 100%" disabled>
										</td>
									</tr>
									<tr>
										<th>*단가</th>
										<td>
											<input type="text" class="form-control" id="unitCost1" name="unitCost1" value="0" maxlength="10" style="text-align: right; min-width:100%;">
										</td>
										<th>*화폐단위</th>
										<td>
											<select class="custom-select" id="moneyUnitCd" style="max-width: 100%"></select>
										</td>
									</tr>
									<tr>
										<th>비고</th>
										<td >
											<input type="text" class="form-control" id="unitDesc1" name="unitDesc1" maxlength="20" style="max-width: 100%;">
										</td>
									</tr>
								</table>	
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" id="btnApply5">저장</button>
								</div>	
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		
	</div>
</div>
<!-- /.page-wrapper -->
<!-- 거래처 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="dealCorpPopUpModal5" tabindex="-1" role="dialog" aria-labelledby="dealCorpPopUpModal5Label" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="dealCorpPopUpModal5">거래처정보조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="dealCorpPopUpTable5" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th>거래처코드</th>
							<th>거래처명</th>
							<th>이니셜</th>
							<th>대표자</th>
							<th>국가명</th>
							<th>사업자번호</th>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 거래처 모달 종료-->

<%@include file="../layout/bottom.jsp" %>


<script>
	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "53%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}

		state = !state;
	});

	let menuAuth = "bmsc0140";
	let currentHref = "bmsc0140";
	let currentPage = $('.' + currentHref).attr('id');

	$('#' + currentPage).closest('.has-child', 'li').addClass(
			'has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","고객사별단가등록"); 
	
	let sideView = 'add';

	var serverDate = "${serverDate}";
	var userNm = "${userNm}";
	
	let goodsCd = null;
	var goodsSeq = null;
	var index = 0;

	var dealCorpCd1 = null;
	var dealCorpNm1 = null;
	var unitRegDate1 = null;
	var moneyUnitCd1 = null;
	var unitCost1 = null;
	var unitDesc1 = null;

	//공통코드 시작
	var moneyUnitCode=new Array();
    <c:forEach items="${moneyUnitCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		moneyUnitCode.push(json);
    </c:forEach>
    //공통코드 종료

	$('#btnPriceDel').attr("disabled", true);
	$('#btnPriceconfirm').attr("disabled", true);
	$('#btnPriceAdd').attr("disabled", true);
	
	//모달 창 예 클릭 시
	$('#saveBtnModalY').on('click', function() {
		$('#btnSave').addClass('d-none');
		$('#btnRevAdd').attr('disabled', false);
		$('#btnEdit').attr('disabled', false);
		$('#btnCall').attr('disabled', false);
	
		$('#priceTable tbody').empty();
		
		$('#priceTable').DataTable().ajax.reload(function() {});
	});
		
	// 목록
    $.fn.dataTable.ext.errMode = 'none';
	let goodsCodeTable = $('#goodsCdTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/bm/goodsCodeDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth' : menuAuth ,
            	'useYnCd'	: 'Y',
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'goodsCd',
        columns: [
            { data: 'goodsCd', 'className':'text-center' },
            { data: 'goodsNm', 'className':'text-center' },
            { data: 'model' },
            { data: 'modelNo' },
            { data: 'alnicuMatrlNm' },
            { data: 'filmMatrlNm' },
            { data: 'chamferYnNm', 'className':'text-center' },            
            { data: 'gubunNm', 'className':'text-center' },

        ],
        columnDefs: [
            {
                //'targets': [0],
                //'orderable': false,
                //'searchable': false,
            },
        ],
        order: [
            [ 1, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품코드관리',
            },
            {
                extend: 'excel',
                title: '제품코드관리',
            },
            {
                extend: 'print',
                title: '제품코드관리',
            }
        ],
    });

	 // 보기
    $('#goodsCdTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#goodsCdTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }

		goodsCd = $('#goodsCdTable').DataTable().row(this).data().goodsCd;
		goodsSeq = $('#goodsCdTable').DataTable().row(this).data().goodsSeq;

//		callView='';

		//선택 행 데이터 불러오기
 		$.ajax({
			url : '<c:url value="bm/custCorpPriceRead"/>',
			type : 'GET',
			data : {
				'goodsCd' : function() {return goodsCd;},
				'goodsSeq' : function() {return goodsSeq;}
			},
			success : function(res) {
				let data = res.data;
				
				sideView = 'edit';

				$('#btnPriceDel').attr('disabled', false);
				$('#btnPriceconfirm').attr('disabled', false);
				$('#btnPriceAdd').attr('disabled', false);
				
				$('#priceTable').DataTable().ajax.reload();
			}
		});

	});
	
	// 단가등록 목록조회
	let priceTable = $('#priceTable').DataTable({
		
		language : lang_kor,
		paging : true,
		searching : true,
		info : true,
		ordering : false,
		processing : true,
		autoWidth : false,
		lengthChange : false,
		pageLength : 20,
		ajax : {
			url : '<c:url value="bm/custCorpPriceList"/>',
			type : 'GET',
			data : {
				'goodsCd' : function(){return goodsCd;},
				'goodsSeq': function(){return goodsSeq;},
			}
		},
		columns : [
			{
				render : function(data, type, row, meta) {
					return meta.row
							+ meta.settings._iDisplayStart
							+ 1;
				},
				'className' : 'text-center'
			},
			{
				data : 'dealCorpNm',
				'className' : 'text-center'
			},
			{
				render : function(data, type, row) {
					return moment(row['unitRegDate']).format(
							'YYYY-MM-DD');
				},
				'className' : 'text-center'
			},
			{
				data : 'moneyUnitNm',
				'className' : 'text-center'
			},
			{
				render : function(data, type, row) {
					return rmDecimal(row['unitCost'])
				},
				'className' : 'text-right'
			},
			{
				data : 'unitDesc',
				'className' : 'text-center'
			}
		],
		order : [ [ 1, 'asc' ] ]

	});

	//단가등록 상세조회
	$('#priceTable tbody').on('click', 'tr',function() {
		
		if ($(this).hasClass('selected')) {
			
		} else {
			$('#priceTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		priceTableIdx = $('#priceTable').DataTable().row(this).index();
		
		dealCorpNm1 = priceTable.row(this).data().dealCorpNm;
		dealCorpCd1 = priceTable.row(this).data().dealCorpCd;
		unitRegDate1 = priceTable.row(this).data().unitRegDate;
		moneyUnitCd1 = priceTable.row(this).data().moneyUnitCd;
		unitCost1 = priceTable.row(this).data().unitCost;
		unitDesc1 = priceTable.row(this).data().unitDesc;
		
		sideView = 'edit';

	});
	
	
	//단가등록 등록버튼
	$('#btnPriceAdd').on('click', function() {
		sideView = 'add';
		$('#dealCorpNm1').val('');
		$('#dealCorpCd1').val('');
		$('#unitRegDate1').val(serverDate);
		$('#unitCost1').val('0');
		$('#unitDesc1').val('');

		$('#priceTable').DataTable().$('tr.selected').removeClass('selected');
		
		$('#btndealCorpNm1').attr('disabled', false);
		$('#unitRegDate1').attr('disabled', false);
		
		$('#custCorpPriceMadal').modal('show');
	});

	//단가등록 수정버튼
	$('#btnPriceconfirm').on('click', function() {
		if (sideView != 'edit') {
			toastr.warning("수정할 항목을 선택해주세요.");
			return false;
		}

		$('#btndealCorpNm1').attr('disabled', true);
		$('#unitRegDate1').attr('disabled', true);
		
		$('#dealCorpCd1').val(dealCorpCd1);
		$('#dealCorpNm1').val(dealCorpNm1);
		$('#unitCost1').val(rmDecimal(unitCost1));
		$('#moneyUnitCd').val(moneyUnitCd1);
		$('#unitDesc1').val(unitDesc1);

		if(unitRegDate1 == 'undefined' || unitRegDate1 == null || unitRegDate1 == ''){
			$('#unitRegDate1').val('');
		}else{
			$('#unitRegDate1').val(moment(unitRegDate1).format('YYYY-MM-DD'));
		}
		$('#custCorpPriceMadal').modal('show');
	});

	//단가등록 삭제버튼
	$('#btnPriceDel').on('click', function() {
		if (sideView != 'edit') {
			toastr.warning("삭제할 항목을 선택해주세요.");
			return false;
		}

		$.ajax({
			url : '<c:url value="/bm/custCorpPriceDelete"/>',
			type : 'POST',
			data : {
				'goodsCd'	 	: 	function(){return goodsCd;},
				'goodsSeq'	 	:	function(){return goodsSeq;},
				'dealCorpCd' 	:	function(){return dealCorpCd1;},
				'unitRegDate'	:	function(){return unitRegDate1;},
				'moneyUnitCd'	:	function(){return moneyUnitCd1;},
			},
			success : function(res) {
				if(res.result=="ok"){
					toastr.success("삭제되었습니다.");
					$('#priceTable').DataTable().ajax.reload(function(){});
				}
			}
		});
	});

	//거래처명 팝업 시작
   	var dealCorpPopUpTable5;
   	function selectdealCorpNm1() {	   	
		if(dealCorpPopUpTable5 == null || dealCorpPopUpTable5 == undefined)	{
			dealCorpPopUpTable5 = $('#dealCorpPopUpTable5').DataTable({
				language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
		            },
				},
				 rowId: 'dealCorpCd',
			        columns: [
			            { data: 'dealCorpCd' },
			            { data: 'dealCorpNm' },
			            { data: 'initial' },
			            { data: 'presidentNm' },
			            { data: 'country' },
			            { data: 'corpNo' },
			        ],
			        columnDefs: [
		            	{"className": "text-center", "targets": "_all"},
			        ],
			        order: [
			            [ 1, 'asc' ]
			        ],
				buttons : [],
		    });

		    $('#dealCorpPopUpTable5 tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable5.row( this ).data();
		    	$('input[name=dealCorpCd1]').val(data.dealCorpCd);
		    	$('input[name=dealCorpNm1]').val(data.dealCorpNm);
                $('#dealCorpPopUpModal5').modal('hide');
	
				});
		}
			$('#dealCorpPopUpTable5').DataTable().ajax.reload(function() {});

		$('#dealCorpPopUpModal5').modal('show');		
   	} 
   	selectBoxAppend(moneyUnitCode, "moneyUnitCd", "", "2");
   	
	//거래처 모달 저장 처리
   	$('#btnApply5').on('click', function() {
			
			if ($("#dealCorpNm1").val() == '') {
				toastr.warning('거래처 명을 선택해주세요.');
				$('#btndealCorpNm1').focus();
				return false;
			} 
		
			if ($("td input[name=unitRegDate1]").val() == "") {
				toastr.warning('단가등록일을 입력해 주세요.');
				$(this).find("input[name=unitRegDate1]").focus();
				return false;
			}
		
			var itemUnitHistCost = $('#unitCost1').val();
		
			if (itemUnitHistCost.replace(/,/g, '') == '0') {
				toastr.warning('단가를 입력해주세요.');
				$('#unitCost1').val('0');
				$('#unitCost1').focus();
				return false;
			}

			if($('select[name=moneyUnitCd]').val() == ''){
				toastr.warning('화폐 단위를 선택해주세요.');
				$('select[name=moneyUnitCd]').focus();
				return false;
			}
			
			var url = '<c:url value="/bm/custCorpPriceCreate"/>';

			if (sideView == "edit") {
				url = '<c:url value="/bm/custCorpPriceUpdate"/>';
			}
			
			$.ajax({
				url : url,
				type : 'POST',
				data : {
					 'goodsCd'		: goodsCd
					,'goodsSeq'		: goodsSeq
					,'dealCorpCd'	: $('#dealCorpCd1').val()
					,'unitRegDate'	: $('#unitRegDate1').val().replace(/-/g,'')
					,'moneyUnitCd'	: $('#moneyUnitCd').val()
					,'unitCost'		: $('#unitCost1').val().replace(/,/g,'')
					,'unitDesc'		: $('#unitDesc1').val()
				},
				success : function(res) {
					let data = res.data;
					
					if (res.result == 'ok') {
						
						if (sideView == "edit") {
							toastr.success('수정되었습니다.');
						}else {
							toastr.success('등록되었습니다.');
						}
						sideView = 'add';
					
					} else if(res.result == 'no') {
						toastr.warning('등록된 단가가 있습니다.');
						
					}else {
						toastr.error(res.message);
					}
				
				},
				complete : function() {
					$('#custCorpPriceMadal').modal('hide');
					$('#priceTable').DataTable().$('tr.selected').removeClass('selected');
					$('#priceTable').DataTable().ajax.reload();
				}
			});
		//}); 
   });

	$('#unitCost').on('keyup',function(){
		$('#unitCost').val(addCommas(uncomma($(this).val())));
	})

	function priceClose() {
		$('#custCorpPriceMadal').modal('hide');
	}

	//숫자만 입력하게 처리
	$(document).on('keyup', "#unitCost1", function(evt){
		 //입력 정규식 0~9 .
    	reg = /[^0-9.]/gi;
    	let costUnit = $(this).val().replace(/,/g, '');
    	if (reg.test(costUnit)) {
    		toastr.warning("숫자만 입력해 주세요.")
    		costUnit = costUnit.replace(reg, '');
    		$("#unitCost1").val("0");
    		$(this).select();
    		return false;
    	}

    	if ($(this).val() == "00") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
		
        var charCode = (evt.which) ? evt.which : event.keyCode;
		//toastr.warning(charCode);
		if ( !(	(charCode > 47 && charCode < 58) || (charCode > 95 && charCode < 106) || ( charCode == 8 || event.which == 9 || event.which == 13 || event.which == 16 || charCode == 46 || charCode == 110 || charCode == 190)	)	){
			toastr.warning("숫자만 입력해 주세요.")
			$(this).val("0");
			$(this).select();
			return false;
		}

		// 소수점(.)이 두번 이상 나오지 못하게
		var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
		if (_pattern0.test(costUnit)) {
			//toastr.warning(". 입력")
		} else {
			if ( charCode == 110 || charCode == 190 ) {
				toastr.warning(".는 한번만 입력 가능합니다.")
				$(this).val("0");
				$(this).select();
				return false;
            }
		}
		
		// 소수점 둘째자리까지만 입력가능
		var _pattern2 = /^\d*[.]\d{3}$/; // 현재 value값이 소수점 셋째짜리 숫자이면 더이상 입력 불가
		if (_pattern2.test(costUnit)) {
			toastr.warning("소수점 둘째자리까지 입력가능합니다.")
			$(this).val("0");
			$(this).select();
			return false;
		}
		
		$(this).val(addCommas(costUnit));

	}); 
	

	var number = "0";
	function rmDecimal(number){
		let tmp = number + "";
		
		//소숫점이 있을 경우
		if(tmp.indexOf(".") != -1){
			number = tmp.replace(/(0+$)/, "");
			
			let numberArr = number.split('.');
			if(numberArr[1]==""){
				number = number.replace('\.','');
			}
		}
		return addCommas(number);
	} 
	
</script>

</body>
</html>
