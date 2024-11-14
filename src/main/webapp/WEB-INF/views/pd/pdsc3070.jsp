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
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc0030"><p class="mo_main_title">파레트라벨 매핑 등록</p></a>
	</header>
	
	<!--====-sortbox-->
	<div class="mo_sortbox">
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">파레트 번호</div>
			
			<div class="form-group input-sub col-9 m-0 p-0">
				<input type="text" class="form-control-md" style="width: 100%;" id="palletNo" inputmode="none" placeholder="파레트번호를 스캔해주세요.">
			</div>
		</div>
		
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">고객사파레트라벨</div>
			
			<div class="form-group input-sub col-9 m-0 p-0">
				<input type="text" class="form-control-md" style="width: 100%;" id="customerPalletNo" inputmode="none" maxlength="30" max="30" placeholder="고객사 파레트 라벨을 스캔해주세요." disabled>
			</div>
		</div>
	</div>
	<!--====-sortbox-->
	
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
	<!--==버튼영역-->
	
	<br>
	
	<!--end버튼영역-->
	<!--end-sortbox-->
	<main style="height: calc(100vh - 50px); overflow: auto;">
		<div class="container-fluid bg_wh" id="main" style="height: 100%; display: flex; flex-direction: column;">
			<div class="card mo_card" style="OVERFLOW-Y: auto; width: 100%;">
				<div class="table-responsive">
					<table id="palletMappingTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 30px">순번</th>
								<th style="min-width: 40px">파레트번호</th>
								<th style="min-width: 80px">고객사파레트라벨번호</th>
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
		</div>
	</footer>
</div>
<!-- /.app -->


<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp" %>
<%@include file="../layout/bottom.jsp" %>

<script>

	$(document).attr("title", "파레트라벨 매핑 등록");
	let menuAuth	= 'pdsc3070';

	$('#palletNo').focus();
	
	//mainTable
	$.fn.dataTable.ext.errMode = 'none';
	let palletMappingTable = $('#palletMappingTable').on('error.dt', function(e, settings, techNote, message) {
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
		processing : true,
		autoWidth : false,
		scrollX : false,
		lengthChange : false,
		searching : false,
		pageLength : 20,
		rowId : '',
		columns : [
			{
				render : function(data, type, row, meta) {
					var rowNo = meta.row + 1;
					return meta.row + 1;
				}
			},
			{ data : 'palletNo' },
			{ data : 'customerPalletNo' },
		],
		columnDefs : [
			{ "className" : "text-center", "targets" : "_all" }
		],
		order : [ [ 0, 'desc' ] ],
		buttons : [],
		drawCallback : function() {
			$('.mo_card tbody').css('font-size', '10px');
		},
	});
	
	//mainTable tr 클릭 시
	$('#palletMappingTable tbody').on( 'click', 'tr', function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#palletMappingTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
	});
	
	
	//파레트 번호 스캔 시
	$("#palletNo").keypress( function(e) {
		if (e.which == 13) {
			
			if( comparePalletNo($('#palletNo').val().trim()) ) {
				toastr.warning("이미 스캔된 항목입니다.");
				return false;
			}
			
			$.ajax({
				url : '<c:url value="/pd/palletMappingRead"/>',
				type : 'GET',
				data : {
					'menuAuth'	: menuAuth,
					'poGroup'	: function() { return $('#palletNo').val().trim(); },
				},
				success : function(res) {
					let count = res.poGroupCount;
					
					if (res.result == 'ok') { //제품상태 포장, 제품입고
						if( count != "" ) {
							$('#palletNo').attr('disabled', true);
							$('#customerPalletNo').attr('disabled', false);
							$('#customerPalletNo').focus();
							$('#palletNo').focus();
							toastr.success('스켄되었습니다.');
						} else {
							$('#palletNo').attr('disabled', false);
							$('#customerPalletNo').attr('disabled', true);
							//$('#palletNo').val("");
							$('#palletNo').focus();
							
							toastr.warning("존재하지 않은 파레트 번호입니다.");
						}
					} else {
						toastr.error(res.message, '', { timeOut : 5000 });
					}
				},
				complete : function() {}
			});
		}
	});
	
	//고객사 파레트 번호 스캔 시
	$("#customerPalletNo").keypress( function(e) {
		if (e.which == 13) {
			//Table Row Add Code Add
			let data = {
			   "palletNo"			: $('#palletNo').val(),
			   "customerPalletNo"	: $('#customerPalletNo').val()
			 }
			$('#palletMappingTable').DataTable().row.add(data).draw(false);
			//Table Row Add Code Add
			
			$('#palletNo').attr('disabled', false);
			$('#customerPalletNo').attr('disabled', true);
			$('#palletNo').val("");
			$('#customerPalletNo').val("");
			
			$('#btnLineClear').attr('disabled', false);
			$('#btnAllClear').attr('disabled', false);
			$('#btnSave').attr('disabled', false);
			
			$('#palletNo').focus();
			
			toastr.success("추가되었습니다.");
		}
	});
	
	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#palletMappingTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		
		$('#palletNo').attr('disabled', false);
		$('#customerPalletNo').attr('disabled', true);
		
		$('#palletNo').focus();
	});
	
	//라인 삭제
	$('#btnLineClear').on('click', function() {
		if( $('#palletMappingTable tbody tr').hasClass('selected') == '' ) {
			toastr.warning('삭제할 라인을 선택하세요.');
		}
			
		$('#palletMappingTable').DataTable().rows('.selected').remove().draw();
		
		let rowCnt = $('#palletMappingTable').DataTable().data().count();
		
		if (rowCnt == 0) {
			$('#btnSave').attr('disabled', true);
			$('#btnAllClear').attr('disabled', true);
			$('#btnLineClear').attr('disabled', true);
		}
		$('#palletNo').focus();
	});
	
	//저장 버튼 클릭했을 때
	$('#btnSave').on('click', function(){
		if( $('#palletMappingTable tbody tr').text() == '데이터가 없습니다.' ) {
			toastr.warning('파레트 번호를 스캔해주세요.');
		}

		let array = new Array();
		let obj = new Object();
		
		//check된 데이터 값 담아주는 부분
		for( var i=0; i<palletMappingTable.data().length; i++ ) {
			
			let data = palletMappingTable.data()[i];
			
			obj = new Object();
			obj.palletNo = data.palletNo;
			obj.customerPalletNo = data.customerPalletNo;
			
			array.push(obj);
		}
		//check된 데이터 값 담아주는 부분
		
		let data = JSON.stringify(array); 
		
		//저장처리하는 ajax
		$.ajax({
			url : '<c:url value="/pd/palletMappingUpdate"/>',
			type : 'POST',
			data : {
				'menuAuth'					: menuAuth,
				'palletMappingDataArray'	: function() { return data; },
			},
			//dataType : "json",
			//contentType : "application/json; charset=UTF-8",
			success : function(res) {
				let count = res.data;
				
				if (res.result == 'ok') { //제품상태 포장, 제품입고
					toastr.success('저장되었습니다.');
				
					$('#btnSave').attr('disabled', true);
					$('#btnAllClear').attr('disabled', true);
					$('#btnLineClear').attr('disabled', true);
					
				} else if (res.result == 'faile') {
					toastr.warning("존재하지 않은 파레트 번호입니다.");
				} else {
					toastr.error(res.message, '', { timeOut : 5000 });
				}
			},
			complete : function() {}
		});
	});
	
	//취소 버튼
	$('#btnCancel').on('click', function() {
		$('#palletMappingTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		
		$('#palletNo').attr('disabled', false);
		$('#customerPalletNo').attr('disabled', true);
		
		$('#palletNo').focus();
	});
	
	//모바일 자판 On/Off
	$('#btnKeyboard').on('click', function() {
		var inputmode = $('#palletNo').attr('inputmode');
		if (inputmode == 'none') {
			$('#btnKeyboard').text("자판 On");
			$('#palletNo').attr('inputmode', 'text');
			$('#customerPalletNo').attr('inputmode', 'text');
		} else if (inputmode == 'text') {
			$('#btnKeyboard').text("자판 Off");
			$('#palletNo').attr('inputmode', 'none');
			$('#customerPalletNo').attr('inputmode', 'none');
		}
	});
	
	//중복 예외처리 사용예정
	function comparePalletNo(palletNo) {
		var result = false;
		for( var i=0; i<palletMappingTable.data().length; i++ ) {
			
			let data = palletMappingTable.data()[i];
			
			if( data.palletNo == palletNo ) {
				result = true;
			}
		}
		return result;
	}
	
</script>

</body>
</html>