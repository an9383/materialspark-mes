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
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc0030"><p class="mo_main_title">제품입고 전 스캔</p></a>
	</header>
	
	<!--====-sortbox-->
	<div class="mo_sortbox">
		<!-- <div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">파레트 번호</div>
			
			<div class="form-group input-sub col-9 m-0 p-0">
				<input type="text" class="form-control-md" style="width: 100%;" id="palletNo" inputmode="none" placeholder="파레트번호를 스캔해주세요.">
			</div>
		</div> -->
		
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">BoxNo</div>
			
			<div class="form-group input-sub col-9 m-0 p-0">
				<input type="text" class="form-control-md" style="width: 100%;" id="boxNo" inputmode="none" placeholder="박스번호를 스캔해주세요.">
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
					<table id="palletBoxFactCheckTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 30px">순번</th>
								<th style="min-width: 40px">박스 번호</th>
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

	$(document).attr("title", "제품입고 전 스캔");
	let menuAuth	= 'pdsc3090';

	$('#boxNo').focus();
	
	let poGroup = "";
	
	
	//mainTable
	$.fn.dataTable.ext.errMode = 'none';
	let palletBoxFactCheckTable = $('#palletBoxFactCheckTable').on('error.dt', function(e, settings, techNote, message) {
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
			{ data : 'boxNo' },
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
	$('#palletBoxFactCheckTable tbody').on( 'click', 'tr', function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#palletBoxFactCheckTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');				
		}
	});
	
	
	//파레트 번호 스캔 시
	/*$("#palletNo").keypress( function(e) {
		if (e.which == 13) {
			
			$.ajax({
				url : '<c:url value="/pd/palletMappingRead"/>',
				type : 'GET',
				data : {
					'menuAuth'	: menuAuth,
					'poGroup'	: function() { return $('#palletNo').val().trim(); },
				},
				success : function(res) {
					let count	= res.poGroupCount;
					let data	= res.data;
					
					if (res.result == 'ok') { //제품상태 포장, 제품입고
						if( count != "" ) {
							
							if( data.goodsStatus == '005' && data.completeYn == "Y" ) {
								$('#palletNo').attr('disabled', true);
								$('#palletNo').focus();
								
								poGroup = $('#palletNo').val().trim();
								$('#palletNo').attr('disabled', true);
								
								$('#boxNo').focus();
								
								toastr.success('스켄되었습니다.');	
							} else if( data.goodsStatus == '004' && data.completeYn == "Y" ) {
								$('#palletNo').attr('disabled', false);
								$('#palletNo').focus();
								
								toastr.warning("해당 파레트는 이미 완료된 출하대기상태입니다.");								
							} else {
								$('#palletNo').attr('disabled', false);
								$('#palletNo').focus();
								
								toastr.warning("완공된 점검대기 상태만 가능합니다.");
							}
						} else {
							$('#palletNo').attr('disabled', false);
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
	*/
	
	//박스 번호 스캔 시
	$("#boxNo").keypress( function(e) {
		if (e.which == 13) {
			
			if( $('#boxNo').val().trim() == "" ) {
				toastr.warning("박스 번호를 스캔해주세요.");
				return false;
			}
			
			if( comparePalletNo($('#boxNo').val().trim()) ) {
				toastr.warning("이미 스캔된 항목입니다.");
				return false;
			}
			
			//박스 정보 스캔 ajax
			$.ajax({
				url : '<c:url value="/pd/goodsProductBeforeScan"/>',
				type : 'GET',
				data : {
					'menuAuth'	: menuAuth,
					'boxNo'		: function() { return $('#boxNo').val().trim(); },
				},
				success : function(res) {
					let data = res.data;
					
					if (res.result == 'ok') { //제품상태 포장, 제품입고
							
						//Table Row Add Code Add
						let data = {
						   "boxNo" : $('#boxNo').val().trim(),
						};
						$('#palletBoxFactCheckTable').DataTable().row.add(data).draw(false);
						//Table Row Add Code Add
						
						$('#btnAllClear').attr('disabled', false);
						$('#btnLineClear').attr('disabled', false);
						$('#btnSave').attr('disabled', false);
						$('#palletNo').attr('disabled', true);
						$('#boxNo').val("");
						$('#boxNo').focus();
						
						toastr.success('스켄되었습니다.');	
					} else if(res.result == 'fail') {
						toastr.warning(res.message, '', { timeOut : 5000 });
					}  else {
						toastr.error(res.message, '', { timeOut : 5000 });
					}
				},
				complete : function() {}
			});
			//박스 정보 스캔 ajax
		}
	});
	
	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#palletBoxFactCheckTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		//$('#palletNo').attr('disabled', false);
		$('#boxNo').attr('disabled', false);
		
		//$('#palletNo').val("");
		$('#boxNo').val("");
		$('#boxNo').focus();
	});
	
	//라인 삭제
	$('#btnLineClear').on('click', function() {
		if( $('#palletBoxFactCheckTable tbody tr').hasClass('selected') == '' ) {
			toastr.warning('삭제할 라인을 선택하세요.');
		}
			
		$('#palletBoxFactCheckTable').DataTable().rows('.selected').remove().draw();
		
		let rowCnt = $('#palletBoxFactCheckTable').DataTable().data().count();
		
		if (rowCnt == 0) {
			$('#btnSave').attr('disabled', true);
			$('#btnAllClear').attr('disabled', true);
			$('#btnLineClear').attr('disabled', true);
		}
		$('#boxNo').focus();
	});
	
	//저장 버튼 클릭했을 때
	$('#btnSave').on('click', function() {
		
		//let data	= palletBoxFactCheckTable.rows('.selected').data();
		let data	= palletBoxFactCheckTable.data();
		let boxNo	= "";
		
		if( $('#palletBoxFactCheckTable tbody tr').text() == '데이터가 없습니다.' ) {
			toastr.warning('파레트 번호를 스캔해주세요.');
		}
		
		if( data.length == 0 ) {
			toastr.warning('파레트 번호를 스캔해주세요.');
		}
		

		//check된 데이터 값 담아주는 부분
		for( var i=0; i<data.length; i++ ) {
			boxNo += ",'"+ data[i].boxNo +"'";
		}
		//check된 데이터 값 담아주는 부분
		
		boxNo = boxNo.substr(1);
		
		//저장처리하는 ajax
		$.ajax({
			url : '<c:url value="/pd/packingWaitingStatusUpdate"/>',
			type : 'POST',
			data : {
				'menuAuth'	: menuAuth,
				'boxNo'		: function() { return boxNo;	},
			},
			success : function(res) {
				let count = res.data;
				if (res.result == 'ok') { //제품상태 포장, 제품입고
					//$('#palletBoxFactCheckTable').DataTable().ajax.reload();
				
					$('#btnAllClear').attr('disabled', true);
					$('#btnLineClear').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
					//$('#palletNo').attr('disabled', true);
					$('#boxNo').attr('disabled', true);
					
					$('#btnCancel').attr('disabled', false);
				
					toastr.success('저장되었습니다.');
				} else if (res.result == 'faile') {
					toastr.warning("파레트번호, 박스번호를 확인해주세요.");
				} else {
					toastr.error(res.message, '', { timeOut : 5000 });
				}
			},
			complete : function() {}
		});
	});
	
	//취소 버튼
	$('#btnCancel').on('click', function() {
		$('#palletBoxFactCheckTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		//$('#palletNo').attr('disabled', false);
		$('#boxNo').attr('disabled', false);
		
		//$('#palletNo').val("");
		$('#boxNo').val("");
		
		$('#boxNo').focus();
	});
	
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
	
	//중복 예외처리 사용예정
	function comparePalletNo(boxNo) {
		var result = false;
		for( var i=0; i<palletBoxFactCheckTable.data().length; i++ ) {
			
			let data = palletBoxFactCheckTable.data()[i];
			
			if( data.boxNo == boxNo ) {
				result = true;
			}
		}
		return result;
	}
	
</script>

</body>
</html>