<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>
<style>
 body{
  overflow:hidden;
 }
</style>
<!-- .app -->
<div class="app pda_mo_wrap" style="display: flex;flex-direction: column;height: 100%;">
	<header class="pda_mo_hd">
		<a href="<c:url value="/tmsc0100"/>" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/tmsc0090"><p class="mo_main_title">재고이동</p></a>
	</header>
			<!--====-sortbox-->
			<div class="mo_sortbox">
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">창고</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="hidden" class="form-control" id="locCd" style="min-width:100%;">
						<input type="hidden" class="form-control" id="locNo" style="min-width:100%;">
						<input type="text" class="form-control-md" id="locNm" style="min-width:100%;" disabled>
						<button type="button" class="btn btn-primary input-sub-search-md" id="btnLocationCd" onClick="selectLocationCd()">
							<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
						</button>
					</div>
				</div>
				<div class="row">
					<div class="col-12 row p-1">
						<div class="col-3 mo_sort_title">구역</div>
						<div class="form-group input-sub col-4 m-0 p-0">
							<input type="hidden" class="form-control" id="areaCd" style="min-width:100%;">
							<input type="text" class="form-control-md" id="areaNm" readonly placeholder="창고선택">
						</div>
						<div class="col-1 mo_sort_title" style="text-align:center;">위치</div>
						<div class="form-group input-sub col-4 m-0 p-0">
							<input type="text" class="form-control-md" id="floorNm" readonly placeholder="창고선택">
							<input type="hidden" class="form-control" id="floorCd" style="min-width:100%;">
						</div>
					</div>
					<div class="col-12 row p-1">
						<div class="col-3 mo_sort_title">Barcode NO</div>
						<div class="form-group input-sub col-9 m-0 p-0">
							<input type="text" class="form-control-md" id="barcodeNo" inputmode="none">
						</div>
					</div>
				</div>
			</div>
			<!--==버튼영역-->
			<div class="mo_btnbox pl-2 pr-2">
				<div class="float-left">
					<button type="button" class="btn btn-warning float-right" id="btnReset">초기화</button>
				</div>
				<div class="float-right">
					<button type="button" class="btn btn-primary float-right mr-2" id="btnSave" disabled>재고이동</button>
				</div>
			</div>
			<br>
			<!--==end==버튼영역-->
			<!--==end==-sortbox-->
	<main style="height: calc(100vh - 50px);overflow:auto;">
		<div class="container-fluid bg_wh" id="main" style="height: 100%;display: flex;flex-direction: column;">
			<!--table-->
			<!-- .table-responsive -->
			<div class="card" style="OVERFLOW-Y:auto; width:100%;">
				<div class="table-responsive">
					<table id="barcodeDtlTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 100px">Barcode NO</th>
								<th style="min-width: 80px">차종</th>
								<th style="min-width: 80px">품명</th>
								<th class="text-center-th" style="min-width: 45px">재고수량</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<!--==end==card-->
			<!--==end==table-->
		</div>
		<!-- 창고정보 모달 시작-->
		<div class="modal fade" id="locationPopupModal" tabindex="-1" role="dialog" aria-labelledby="locationPopupLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="locationPopupLabel">창고정보조회</h5>	
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="table-responsive" style="height:490px">
							<table class="table table-sm table-bordered">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
								<tr>
									<th>창고</th>
									<td>
										<select class="custom-select" id="selectLocationCd" style="max-width:100%;"></select>
									</td>
									<th>구역</th>
									<td>
										<select class="custom-select" id="selectAreaCd" style="max-width:100%;">
											<option value="">창고 선택</option>
										</select>
									</td>
								</tr>
							</table>
							<table id="locationPopupTable" class="table table-sm table-bordered">
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th>창고명</th>
										<th>구역명</th>
										<th>위치명</th>
										<th>비고</th>
										<th>사용여부</th>
									</tr>
								</thead>
							</table>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 창고정보 모달 종료-->
	</main>
	<footer class="p-2" style="margin-top: auto;">
			<div class="mo_sumbox">
				<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
				<div class="row float-right">
					<div class="mo_roll mr-4">
						<!-- <label>합계</label><span class="mo_sum_font_lg" id="rowCount">0</span> <label>Roll</label> -->
					</div>
					<div class="mo_kg">
						<span class="mo_sum_font_lg" id="countBarcodeDtlTable">0</span> <label>개수</label>
					</div>
				</div>
			</div>
	</footer>
</div>
<!-- /.app -->
<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp" %>

<script>

	$(document).attr("title","재고이동");
	let menuAuth = 'tmsc0090';
	var serverDate = "${serverDate}"
	let sessionData = "${prcssGubun}";


	
	var barcodeNo = null;
	var partCd = null;
	var partRev = null;
	var partNm = null;
	var partSpec = null;
	var inWhsQty = null;
	var baseInfoCd = null;
	var etc3 = null;
	var areaCd = null;
	var count = 0;
	
	//$('#inWhsDate').val(serverDate);
	$('#btnSelEquipCode').focus();
	var serverMonthTo = serverDate.substring(0, 7);
	
	//공통코드 처리 시작	
 	var locationCdCode = new Array(); 
	<c:forEach items="${locationCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseNm = "${info.baseNm}";
	locationCdCode.push(json);
	</c:forEach> 
	//공통코드 처리 끝

	selectBoxAppend(locationCdCode , "selectLocationCd",'', "2");

	// 박스 전체 체크
	$('#checkAll').on('click',function() {
		if($(this).is(':checked')) {
			$('input[name=insertCheck]').prop('checked',true);
		} else {
			$('input[name=insertCheck]').prop('checked',false);
		}
	})
	
	$.fn.dataTable.ext.errMode = 'none';
	let barcodeDtlTable = $('#barcodeDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'><'col-sm-12 col-md-7'>>",
	    language: lang_kor,
	    paging: false,
	    info: true,
	    ordering: true,
	    processing: true,
	    autoWidth: false,
	    scrollX : false,
	    lengthChange: false,
	    searching: false,
	    pageLength: 20,            
		ajax : {
			url : '<c:url value="tm/locationGroupStockQtyList"/>',
			type : 'GET',
			data : {
				'barcodeNo'  : function(){return $('#barcodeNo').val()},
				'mainGubun'	 : function(){return '001'},
				
			},
		},
	    rowId: '',
	    columns: [
	    	{ data : 'barcodeNo', orderable: false },
	    	{ data : 'itemModelNm', orderable: false },
	    	{ data : 'spNm', orderable: false },
	    	{ data : 'realQty', 'className' : 'text-right', orderable: false,
				render: function(data, type, row, meta) {
					return addCommas(Math.floor(data));	
	    		}
			},
			{ data : 'metaRow', 'className' : 'd-none' }, // 바코드 스캔 시 맨 위에 행이 추가되도록 구현 
	    ],
	    columnDefs: [],
	    order: [ [4, 'desc'] ], // 바코드 스캔 시 맨 위에 행이 추가되도록 구현
	    buttons: [],
		drawCallback: function () {
			 //$('.mo_card tbody').css('font-size','10px');
		},
	});
	
	// barcodeDtlTable 테이블 행 카운트
	barcodeDtlTable.on('draw.dt', function() {
		let info = barcodeDtlTable.page.info();
		$('#countBarcodeDtlTable').text(info.recordsTotal);
	});

	var lineCheck = false;
    $('#barcodeDtlTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            lineCheck = false;
        }	
        else {
        	$('#barcodeDtlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            lineCheck = true;
        }
    });

	$('#btnReset').on('click',function() {
		// 보기					
		$('#barcodeDtlTable').DataTable().clear().draw();
		$('#btnSave').attr('disabled', true);
		//창고정보
		$('#locNm').val('');
		$('#locCd').val('');
		$('#locNo').val('');
		//구역정보
		$('#areaNm').val('');
		$('#areaCd').val('');
		//위치정보
		$('#floorNm').val('');
		$('#floorCd').val('');
		$('#barcodeNo').val('');
	});
    
	//바코드 스캔시
	$("#barcodeNo").keypress(function(e) {
		var check = true;

		if (e.which == 13) {

			if (!$.trim($('#locCd').val())) {
				toastr.warning('창고를 지정해 주세요.');
				$('#barcodeNo').focus();
				check = false;
				return false;
			}
			
			if (!$.trim($('#barcodeNo').val())) {
				toastr.warning('바코드를 스캔해주세요.');
				$('#barcodeNo').focus();
				check = false;
				return false;
			}

			if($('#barcodeDtlTable').DataTable().rows().count()!=0) {
				$('#barcodeDtlTable tbody tr').each(function(index, item) {
					if(barcodeDtlTable.row(index).data().barcodeNo==$('#barcodeNo').val()){
						$('#barcodeNo').focus();
						$('#barcodeNo').select();
						toastr.warning("이미 추가된 바코드입니다. 확인해주세요.");
						check = false;
						return false;
					}
				});
			} 
			
			if (check) {
			 	$.ajax({
			 		url: '<c:url value="tm/locationGroupStockBarcodeList"/>',
	                type: 'GET',
	                async : false,
	                data: {
	                	'mainGubun' : "001",
	                	'barcodeNo'  :  $('#barcodeNo').val(),
	                },
	                success: function (res) {
	                    if (res.result == 'ok') {
	                    	let data = res.data;
							for(let i = 0; i<data.length; i++) {
								var barcodeNo = data[i].barcodeNo;
		                    	var itemSeq = data[i].itemSeq;
		                    	var spCd = data[i].itemCd;
		                    	var spNm = data[i].itemNm;
		                    	var spType = data[i].itemGubun;
		                    	var itemModelNm = data[i].itemModelNm;
		                    	var realQty = data[i].realQty;
		                    	var locationNo = data[i].locationNo;
		                    	var locationCd = data[i].locationCd;
		                    	var locationNm = data[i].locationNm;
		                    	var areaNm = data[i].areaNm;
		                    	var floorNm = data[i].floorCd;

		                    	let scanCheck = true;

		                    	//제품인 경우 창고는 제품창고만 가능
		                    	if(spType=="001" && $('#locCd').val()=="001"){
		                    		toastr.warning("제품은 원재료창고로 이동 할 수 없습니다. 창고를 다시 선택해주세요.");
		                    		scanCheck = false;
			                    }else if(spType=="004" && $('#locCd').val()=="002"){
		                    		toastr.warning("원자재는 제품창고로 이동 할 수 없습니다. 창고를 다시 선택해주세요.");
		                    		scanCheck = false;
			                    }

			                    if(scanCheck){
			                    	let metaRow = $('#barcodeDtlTable').DataTable().rows().count() > 0 ? 
			                    			Math.max.apply(Math, $('#barcodeDtlTable').DataTable().rows().data().toArray().map(function(row) { return row.metaRow; })) + 1
				                    	: 0;
				                    	
			                        $('#barcodeDtlTable').DataTable().row.add({
				    	    			'barcodeNo'		: barcodeNo,
				    	    			'itemSeq'		: itemSeq,
				    	    			'spCd'			: spCd,
				    	    			'spNm'			: spNm,
				    	    			'itemModelNm'	: itemModelNm,
				    	    			'spType'		: spType,
				    	    			'realQty'		: realQty,
				    	    			'locationNo'	: locationNo,
				    	    			'locationCd'	: locationCd,
				    	    			'locationNm'	: locationNm,
				    	    			'areaNm'		: areaNm,
				    	    			'floorNm'		: floorNm,
				    	    			'metaRow'		: metaRow, //추가한 행이 맨 위에 생성되도록 구현
				    				}).draw(false);
			                        $('#btnSave').attr('disabled', false);
			                        toastr.success("추가되었습니다.");
			                        $('#barcodeNo').focus(); 
									$('#barcodeNo').select();
				                }

			                }
		                  
						} else {
		                	if (res.result == 'empty') {
								toastr.warning("등록되지 않은 바코드입니다. 확인해주세요.");
							} else {
								toastr.warning(res.message,'',
									{timeOut : 5000}
								);
							}
			            }
		             },
		             complete:function(){
		             }
		        });
			}
		}
	});


	// 저장 처리
	$('#btnSave').on('click',function() {
		
		var dataArray = new Array();		
		var check=true;  	

		/* if(!$('input[name=insertCheck]').is(':checked')) {
			toastr.warning('등록할 데이터를 체크해주세요.');
			$('#my-spinner').hide();
			check=false;
			return false;
		} */
		
		$('#barcodeDtlTable tbody tr').each(function(index, item){
			//if($(this).find("input[name=insertCheck]").is(':checked')) {
				var rowData = new Object();

				//이동 전 창고
				rowData.outLocationNo = barcodeDtlTable.row( this ).data().locationNo;
				rowData.outLocationCd = barcodeDtlTable.row( this ).data().locationCd;
				
				//이동 후 창고
				rowData.locationNo = $('#locNo').val();
				rowData.locationCd = $('#locCd').val();

				rowData.barcodeNo = barcodeDtlTable.row( this ).data().barcodeNo;
				rowData.spCd = barcodeDtlTable.row( this ).data().itemSeq;
				rowData.spType = barcodeDtlTable.row( this ).data().spType;
				rowData.spQty = barcodeDtlTable.row( this ).data().realQty;
				
				dataArray.push(rowData);
				console.log(rowData)
			//}
		});
		
		if(check == true){
			$.ajax({
				url : '<c:url value="tm/stockMovement"/>',
				type : 'POST',
				datatype: 'json',
				data: JSON.stringify(dataArray),
				contentType : "application/json; charset=UTF-8",
				async : false,
				beforeSend : function() {
					//처리중..
					$('#my-spinner').show();
				},
				success : function(res) {				
					if (res.result == 'ok') {
						
						// 보기					
						$('#barcodeDtlTable').DataTable().clear().draw();
						$('#btnSave').attr('disabled', true);
						//창고정보
						$('#locNm').val('');
						$('#locCd').val('');
						$('#locNo').val('');
						//구역정보
						$('#areaNm').val('');
						$('#areaCd').val('');
						//위치정보
						$('#floorNm').val('');
						$('#floorCd').val('');
						toastr.success('저장되었습니다.');
						$('#barcodeNo').val("");
					} else {
						toastr.error(res.message);
					}
				},
				complete : function() {
					//처리완료..
					$('#my-spinner').hide();
				}
			});
		}
	});
	
	
	//창고정보조회 팝업 시작
	var locationPopupTable;
	function selectLocationCd() {
		if (locationPopupTable == null || locationPopupTable == undefined) {
			locationPopupTable = $('#locationPopupTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				searching:false,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				pageLength : 13,
				ajax : {
					url : 'bm/locationAdmList',
					type : 'GET',
					data : {
						'mainGubun'	: function() {return '001'},
						'locCd' 	: function() {return $('#selectLocationCd').val()},
						'areaCd'	: function() {return $('#selectAreaCd').val()},
					}
				},
				columns : [ {
					data : 'locNm'
				}, {
					data : 'areaNm'
				}, {
					data : 'floorNm'
				}, {
					data : 'locDesc'
				}, {
					data : 'useYnNm'
				},  ],
				columnDefs : [ {
					"targets" : '_all',"className" : "text-center"
				} ],
				order : [ [ 0, 'asc' ] ],
			});
			$('#locationPopupTable tbody').on('click', 'tr', function() {
				var data = locationPopupTable.row(this).data();

				console.log(data.locNo)
				console.log(data.locNm)
				console.log(data.locCd)
				console.log(data.areaNm)
				console.log(data.areaCd)
				console.log(data.floorNm)
				//창고정보
				$('#locNm').val(data.locNm);
				$('#locCd').val(data.locCd);
				$('#locNo').val(data.locNo);
				//구역정보
				$('#areaNm').val(data.areaNm);
				$('#areaCd').val(data.areaCd);
				//위치정보
				$('#floorNm').val(data.floorNm);
				$('#barcodeNo').focus();
				$('#locationPopupModal').modal('hide');
			});
		} else {
			$('#locationPopupTable').DataTable().ajax.reload(function() {});
		}

		$('#locationPopupModal').modal('show');
		selectBoxAppend(locationCdCode , "locationCd",'', "2");
	}

	//창고 선택
	$('#selectLocationCd').on('change',function(){
		if($(this).val()!=null && $(this).val()!=""){
			$.ajax({
				url  : '<c:url value="bm/locationAdmList"/>',
				type : 'GET',
				data : {
					'mainGubun' : function(){ return "001"; },
					'locCd' 	: function(){ return $('#selectLocationCd option:selected').val() }
				},
				success : function(res){
					let areaData = res.data;
					var areaCdCode = new Array(); 
					
					for(var i=0; i<areaData.length; i++){
						var json = new Object();
						json.baseCd = areaData[i].areaCd;
						json.baseNm = areaData[i].areaNm;
						areaCdCode.push(json);
					}
					
					// 중복 값 제거하기
					let uniqueData = [];

					areaCdCode.forEach(function(element) {
						let elementStr = JSON.stringify(element);
					  	// 배열에 해당 요소가 없으면 추가한다
					  	if (!uniqueData.some(function(item) {
					    	return JSON.stringify(item) === elementStr;
					  	})) {
					   		uniqueData.push(element);
						}
					});
					
					selectBoxAppend(uniqueData, 'selectAreaCd','', '2');
				}
			})
			$('#selectAreaCd option:eq(0)').attr('selected','selected');
			$('#locationPopupTable').DataTable().ajax.reload( function () {});
		}else{
			$('#selectAreaCd option').remove();
			$('#selectAreaCd').append('<option value="">창고선택</option>');
		}
	});

	//구역 선택
	$('#selectAreaCd').on('change',function(){
		$('#locationPopupTable').DataTable().ajax.reload( function () {});
	});
	
  	//모바일 자판 On/Off
	$('#btnKeyboard').on('click', function() {
		var inputmode = $('#barcodeNo').attr('inputmode');
		if ( inputmode == 'none') {
			$('#btnKeyboard').text("자판 On");
			$('#barcodeNo').attr('inputmode', 'text');
		} else if ( inputmode == 'text' ) {
			$('#btnKeyboard').text("자판 Off");
			$('#barcodeNo').attr('inputmode', 'none');
		}
	});
	
</script>

</body>
</html>
