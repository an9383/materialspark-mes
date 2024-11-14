<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
    <!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding" style="margin-right: 4.2%;">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">파레트라벨출력</li>
			</ol>
		</nav>
		<div style="background-color: white;width: 55%;line-height: 30px;display: flex;justify-content: space-evenly;align-items: center;">
			<button type="button" class="btn btn-success ml-2 mr-2 touch6" id="btnPrint">대기라벨</button>
			<button type="button" class="btn btn-success ml-2 mr-2 touch6" id="btnWaitPrint" style="background-color: green;">출하라벨</button>
			<button type="button" class="btn btn-primary touch6 mr-2 " id="btnNewPalletAdd">신규 파레트 추가</button>
			<button type="button" class="btn btn-primary touch6 mr-2" id="btnBoxAdd">박스 추가</button>
			<button type="button" class="btn btn-primary touch6 mr-2" id="btnCompleteStatuse">완공 상태</button>
			<button type="button" class="btn btn-primary touch6 mr-2" id="btnLocation">제품 입고</button>
			<button type="button" class="btn btn-danger touch6 mr-2" id="btnPalletDelete">파레트 삭제</button>
			<button type="button" class="btn btn-danger touch6  mr-1" id="btnCancel" disabled>출하 취소</button>
		</div>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 62%;">
				<div class="card">
				
					<div class="row" style="display: flex;/*align-items: center;*/">
						<label style="margin: 5px 7px 0px 12px;">납기일</label>
						<input type="date" class="form-control touch6" style="width: 150px;" max="9999-12-30" id="chooseDateFromCal">
						<label style="margin: 5px 7px 0px 7px;">~</label>
						<input type="date" class="form-control touch6" style="width: 150px;" max="9999-12-31" id="chooseDateToCal">
						
						<button type="button" class="btn btn-primary ml-2 touch6" id="btnRetv">조회</button>

						<label class="ml-2 d-none" style="line-height: 15px;">출력<br>여부</label>
						<select class="custom-select custom-select-md ml-1 d-none" style="width: 80px;" id="printWether">
							<option value="" selected>전체</option>
							<option value="N">미출력</option>
							<option value="Y">출력</option>
						</select>
						
						<label class="ml-3" style="line-height: 15px;">완공<br>여부</label>
						<select class="custom-select custom-select-md ml-1" style="width: 68px;" id="selCompleteYn">
							<option value="" selected>전체</option>
							<option value="N">미료</option>
							<option value="Y">완공</option>
						</select>
						<select class="custom-select custom-select-md ml-3 mr-3" style="width: 95px;" id="selGoodsStatus"></select>
						
						<input type="text" class="form-control float-right touch6 ml-5" placeholder="파레트 번호 스캔" id="scanPalletNo">
						<button type="button" class="btn closeBtn" style="line-height: 0px;font-size: 25px;" onclick="scanReset();">✕</button>
					</div>
					
					<!-- .table-responsive -->
					<!-- table_ADM -->
					<table id="palletTable" class="table table-bordered" style="min-width: 1300px;">
						<thead class="thead-light">
							<tr>
								<th>완공여부</th>
								<th>상태</th>
								<th>창고</th>
								<th>거래처</th>
								<th>등록번호</th>
								<th>PO Number</th>
								<th>모델번호</th>
								<th>파레트번호</th>
								<th>오더구분</th>
								<th>제품</th>
								<th>재질</th>
								<th>출고BOX</th>
								<th class="text-center">출고수량</th>
								<th>납기일</th>
								<th>출고일</th>
								<th>입고일</th>
								<th>고객사 파레트 번호</th>
							</tr>
						</thead>
					</table>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-40" id="myrSidenav" style="width: 37%; padding-bottom: 0px;">
				<div class="card" id="formBox">
					<div style="height: 30px;" id="btnDiv">
						<button type="button" class="btn btn-danger touch6 mr-1" id="btnBoxDelete">박스 삭제</button>
						<button type="button" class="btn btn-danger touch6 mr-1" id="btnDisMove">폐기 이동</button>
						<button type="button" class="btn btn-primary touch6 mr-2 float-right" id="btnGoodsDescSave">비고 저장</button>
						<button type="button" class="btn btn-primary touch6 mr-2 float-right" id="btnEdit">고객사 LotNo 수정</button>
						<button type="button" class="btn btn-warning touch6 mr-2 float-right" id="btnSwitching" disabled>교체</button>
						<button type="button" class="btn btn-warning touch6 mr-2 float-right" id="btnReturn" disabled>반품</button>
					</div>
					<form id="form">
						<div class="table-responsive">
							<!-- table_DTL -->
							<table id="palletDtlTable" class="table table-bordered">
								<thead class="thead-light">
			                    	<tr>
										<th style="min-width:40px" class="text-center">
											<input type="checkbox" style="width:20px; height:20px" id="checkAll" name="checkAll">
										</th>
										<th class="text-center" style="min-width:50px">순번</th>	    
										<th class="text-center" style="min-width:180px">고객사<br>LotNo</th>	                       
										<th class="text-center" style="min-width:150px">포장 NO</th>
										<th class="text-center" style="min-width:80px">제품<br>상태</th>
										<th class="text-center" style="min-width:70px">불량<br>상태</th>
										<th class="text-center" style="min-width:70px">출고량</th>
										<th class="text-center" style="min-width:280px">비고</th>
									</tr>
								</thead>
							</table>
						</div>
					</form>
				</div>
				<!--// 등록, 수정 -->
			</div>
			<!-- .right-sidebar -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div><!-- /.page-wrapper -->


<!-- 트레이 번호(poGroup) 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="newPalletPopUpModal" tabindex="-1" role="dialog" aria-labelledby="newPalletPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id="palletPopUpLabel">신규 파레트 추가</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
			
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
				<!-- 포장 일 -->
				<!-- <div class="row p-1">
					<div class="col-2">포장일</div>
					<div class="input-sub">
						<input type="date" class="form-control-md" style="width: 175%;" id="chooseDate" max="9999-12-31"/>
					</div>
				</div> -->
				<!-- 포장 일 -->
				
				<!-- PO Number -->
				<!-- <div class="row p-1">
					<div class="col-2">PO Number : </div>
					<div class="input-sub">
						<input type="hidden" 	class="form-control" 	id="poGubunCd"	name="poGubunCd">
						<input type="hidden" 	class="form-control" 	id="goodsCd" 	name="goodsCd">
						<input type="hidden"	class="form-control" 	id="poSeq"		name="poSeq"		disabled>
						<input type="hidden"	class="form-control" 	id="poModelNo"	name="poModelNo"	disabled>
						<input type="text"		class="form-control-md" id="poNo"		name="poNo"			disabled>
						
						<button type="button"	class="btn btn-primary input-sub-search-md" id="btnSelpoSeqCode" onClick="selectPoCode()">
							<span class="oi oi-magnifying-glass"></span>
						</button>
					</div>
				</div> -->
				<!-- PO Number -->
				
				
				
				
				
				
				<div class="p-1" style="display: flex;align-items: center;">
					<!-- 포장 일 -->
					<label class="col-1">포장일</label>
					<input type="date" class="form-control-md" id="chooseDate" max="9999-12-31"/>
					<!-- 포장 일 -->
					
					<!-- PO Number -->
					<label style="flex: 0 0 16%;max-width: 13%; padding-left: 10px;">PO Number : </label>
					<div class="input-sub">
						<input type="hidden"	class="form-control" 	id="dealCorpCd"		name="dealCorpCd">
						<input type="hidden"	class="form-control" 	id="deliveryDate"	name="deliveryDate">
						<input type="hidden" 	class="form-control" 	id="poGubunCd"		name="poGubunCd">
						<input type="hidden" 	class="form-control" 	id="goodsCd" 		name="goodsCd">
						<input type="hidden"	class="form-control" 	id="poSeq"			name="poSeq"		disabled>
						<input type="hidden"	class="form-control" 	id="poModelNo"		name="poModelNo"	disabled>
						<input type="text"		class="form-control-md" id="poNo"			name="poNo"			disabled>
						
						<!-- <button type="button"class="btn btn-primary input-sub-search-md" id="btnSelpoSeqCode" onClick="selectPoCode()">
							<span class="oi oi-magnifying-glass"></span>
						</button> -->
						
						<button type="button"class="btn btn-primary" style="position: absolute; top: 0; right: 0px; height: 1.9rem; width: 50px;" id="btnSelpoSeqCode" onClick="selectPoCode('000')">SK</button>
						<button type="button"class="btn btn-primary" style="position: absolute; top: 0; right: -60px; height: 1.9rem; width: 50px;" id="btnPoLgesCode" onClick="selectPoCode('002')">LG</button>
						
					</div>
					<!-- PO Number -->
				</div>
				
				
				<!-- 파레트 신규&기존 구쥰 -->
				<div class="row p-1 d-none">
					<div class="col-2">
						<label>파레트 번호</label>
						<input type="checkbox" class="" id="addPallet" style="width:15px; height:15px;" disabled>
					</div>
					<div class="input-sub">
						<input type="text" class="form-control-md" id="poGroup" name="poGroup" disabled>
					</div>
				</div>
				<!-- 파레트 신규&기존 구쥰 -->
				
				<!-- BoxNo & CustomerLotNo-->
				<div class="row p-1">
				
					<div class="col-1">Box No</div>
					<div class="row">
						<input type="text" class="form-control-md" id="boxNo" placeholder="BoxNo를 먼저스캔해주세요.">
					</div>
				</div>
				<!-- BoxNo & CustomerLotNo -->
				
				<!-- BoxNo & CustomerLotNo-->
				<div class="row p-1">
					<div class="col-1">고객사 번호</div>
					<div class="row">
						<input type="text" class="form-control-md" style="width: 50%;" id="secondCustomerLotNo" maxlength="80" max="80" placeholder="고객사 LotNo1 스캔해주세요." disabled>
						<input type="text" class="form-control-md ml-2" style="width: 50%;" id="secondCustomerLotNo2" maxlength="80" max="80" placeholder="고객사 LotNo2 스캔해주세요." disabled>
						<input type="text" class="form-control-md ml-2" style="width: 50%;" id="secondCustomerLotNo3" maxlength="80" max="80" placeholder="고객사 LotNo3 스캔해주세요." disabled>
					</div>
					
					<button type="button" class="btn btn-primary touch6 ml-3" id="barcodeAdd">추가</button>
				</div>
				
				<div class="float-left mt-3">
					<button type="button" class="btn btn-danger float-right touch6" id="btnLineClear" disabled>라인삭제</button>
					<button type="button" class="btn btn-danger float-right touch6 mr-3" id="btnAllClear" disabled>전체삭제</button>
				</div>
				
			</div>
			
			<!-- 박스 추가되는 테이블 -->
			<div class="table-responsive" style="padding: 0px 10px 0px 10px; /* height:50vh; overfloow-y:auto; */">
				<table id="goodsProductInfoTable" class="table table-bordered table-td-center">
					<thead class="thead-light">
						<tr>
							<th style="min-width: 30px">순번</th>
							<th style="min-width: 40px">제품코드</th>
							<th style="min-width: 80px">제품명</th>
							<th style="min-width: 80px">박스번호</th>
							<th style="min-width: 50px">포장 수량</th>
							<th style="min-width: 50px">입고 수량</th>
							<th style="min-width: 80px">고객사LotNo1</th>
							<th style="min-width: 80px">고객사LotNo2</th>
							<th style="min-width: 80px">고객사LotNo3</th>
						</tr>
					</thead>
				</table>
				
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-primary touch6" id="btnNPASave" >저장</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 트레이 번호(poGroup) 모달 종료-->


<!-- PO 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="poPopUpModal" tabindex="-1" role="dialog" aria-labelledby="equipPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id="poPopUpLabel">주문관리조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<div class="table-responsive">
					<table id="poPopUpTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 70px">납기일</th>
								<th style="min-width: 140px">PO Number</th>
								<th style="min-width: 100px">제품명</th>
								<th style="min-width: 90px">오더량</th>
								<th style="min-width: 90px">미출고량</th>
								<th style="min-width: 90px">코드</th>
								<th style="min-width: 90px">고객사</th>
							</tr>
						</thead>
					</table>
				</div>
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
			</div>
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-secondary touch5" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- PO 모달 종료-->

<!-- 완공상태 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="completeStatusePopUpModal" tabindex="-1" role="dialog" aria-labelledby="completeStatusePopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>완공상태</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
			
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
				<!-- 완공&미료 버튼 -->
				<div class="col-12 row p-1">
					<div class="col-3">
						<div class="mo_sort_title ml-1">
							<label style="font-size: 20px;line-height: 10px;background-color: lightpink;">완공취소</label>
						</div>
					</div>
					<div class="form-group input-sub col-3 m-0 p-0">
						<input type="radio" class="" style="width:100%; height:28px; accent-color: #ff4242;" id="completeN" name="completeYn" value="N">
					</div>
					
					<div class="col-2">
						<div class="mo_sort_title ml-1">
							<label style="font-size: 20px;line-height: 10px;background-color: #b7e3ff;">완공</label>
						</div>
					</div>
					<div class="form-group input-sub col-3 m-0 p-0">
						<input type="radio" class="" style="width:100%; height:28px;" id="completeY" name="completeYn" value="Y">
					</div>
				</div>
				<!-- 완공&미료 버튼 -->

				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
				<label>*창고 지정하게되면 출하 대기 상태로 변경됩니다.</label>
				<br>
				<label>*완공 취소 시 미료상태로 변경됩니다.</label>
				<br>
				<label>*완공 후 위치 지정할 수 있습니다.</label>
				
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-primary touch6" id="btnCSChangeSave" >변경</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 완공상태 모달 종료-->

<!-- 창고지정 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="locationPopUpModal" tabindex="-1" role="dialog" aria-labelledby="locationPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>제품 입고</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
			
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
				<!-- 창고 번호 선택 하는 부분 -->
				
				<div class="col-12 row p-1">
					<label class="col-4 mo_sort_title">최초제품입고일</label>	
					<div class="form-group input-sub col-8 m-0 p-0">
						<input type="date" class="form-control-md" id="locationInputDate" max="9999-12-31"/>
					</div>
				</div>
					
				<div class="col-12 row p-1">
					<div class="col-4 mo_sort_title">창고 지정</div>
					<div class="form-group input-sub col-8 m-0 p-0">
						<select class="custom-select custom-select-md" style="font-size: 18px;" id="location"></select>
					</div>
				</div>
				<!-- 창고 번호 선택 하는 부분 -->

				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
				<label>*창고 지정  후 완공 취소 시 창고 번호는 삭제 됩니다.</label>
				<br>
				<label>*창고지정 시 출하대기 상태로 변경됩니다.</label>
				<br>
				<label>*창고 지정 시 최초로 날짜가 들어갑니다. 그 후 날짜 수정은 불가합니다.</label>
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-primary touch6" id="btnLSave" >저장</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 창고지정 모달 종료-->

<!-- 삭제 확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="palletDeleteCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="palletDeleteCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>파레트(전체)삭제 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
				<label style="font-size: 15px;font-weight: 600;">삭제 하시겠습니까?</label>
				
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label>*파레트와 관련된 박스 전부 삭제됩니다.</label>
				<br>
				<label>*삭제된 데이터는 복구할 수 없습니다.</label>
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-danger touch6" id="btnModalPalletDelete" >삭제</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 삭제 확인 모달 종료-->

<!-- 박스 삭제 확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="boxDeleteCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="boxDeleteCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>박스삭제 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label style="font-size: 15px;font-weight: 600;">삭제 하시겠습니까?</label>
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label>*삭제된 데이터는 복구할 수 없습니다.</label>
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-danger touch6" id="btnModalBoxDelete" >삭제</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 박스 삭제 확인 모달 종료-->

<!-- 박스 삭제 확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="boxDisposeCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="boxDisposeCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>폐기이동 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label style="font-size: 15px;font-weight: 600;">이동 하시겠습니까?</label>			
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-danger touch6" id="btnModalBoxDispose" >이동</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 박스 삭제 확인 모달 종료-->

<!-- 박스 삭제 확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="boxReturnCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="boxReturnCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>박스 반품 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label style="font-size: 15px;font-weight: 600;">반품처리 하시겠습니까?</label>
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label>*반품된 박스는 복구할 수 없습니다.</label>
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-warning touch6" id="btnModalBoxReturn" >반품</button>
				<button type="button" class="btn btn-secondary touch6 d-none" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 박스 삭제 확인 모달 종료-->

<!-- 고객사 LotNo 수정 모달 시작 -->
<div class="modal fade bd-example-modal-lg" id="customerLotNoEditPopUpModal" tabindex="-1" role="dialog" aria-labelledby="customerLotNoEditPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:70vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>고객사 LotNo 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
				
				<label style="font-size: 15px;" id="nowBoxNoLabel"></label>
				<br>
				<label style="font-size: 15px;" id="nowCustomerLotNoLabel"></label>
					
				<br><br>
				<h6>변경 고객사 LotNo 입력</h6>
				
				<div class="row">
					<input type="text" class="form-control-md" style="width: 50%;" id="customerLotNoEdit" maxlength="80" max="80" placeholder="고객사 LotNo1 스캔해주세요.">
					<input type="text" class="form-control-md ml-2" style="width: 50%;" id="customerLotNo2Edit" maxlength="80" max="80" placeholder="고객사 LotNo2 스캔해주세요." disabled>
					<input type="text" class="form-control-md ml-2" style="width: 50%;" id="customerLotNo3Edit" maxlength="80" max="80" placeholder="고객사 LotNo3 스캔해주세요." disabled>
				</div>
				
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<label>*변경 시 이전 고객사 LotNo는 찾을 수 없습니다.</label>
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;">
				<button type="button" class="btn btn-primary touch6" id="btnModalCustomerLotNoChange" >변경</button>
<!-- 				<button type="button" class="btn btn-secondary touch6" data-dismiss="modal">닫기</button> -->
			</div>
		</div>
	</div>
</div>
<!-- 고객사 LotNo 수정 모달 종료 -->

<!-- 박스 교체 모달-->
<div class="modal fade bs-example-modal-lg shadow-lg" id="boxChangeModal" tabindex="-1" role="dialog" aria-labelledby="boxChangeModalModalLabel" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content" style="width: 70vh;">
            <div class="modal-header">
           		<h5 class="modal-title" id="boxChangeHeader">박스 교체 확인</h5>
            </div>
            <div class="modal-body">
            	<br>
            	
            	<button type="button" class="btn btn-primary mb-2 touch6 d-none" style="position: absolute;right: 4%; bottom: 88%;" id="btnBoxChangEdit">수정</button>
            	
            	<table class="table table-sm table-bordered">
            		<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
							
			 		<thead>
			 			<tr>
			 				<th>교체 전(BoxNo)</th>
			 				<th>교체 후(BoxNo)</th>
			 			</tr>
			 		</thead>
			 		<tbody>
            			<tr> 
            				<td class=" text-center" id="beforeBoxNo" style="font-size: 18px; font-weight: 100;"></td>
            				<td>
            					<input type="text" class="form-control touch6" style="font-size: 18px; font-weight: 100; text-align: center; min-width:100%" id="afterBoxNo" placeholder="바코드를 스캔해주세요.">
            				</td>
            			</tr>
            		</tbody>
			 	</table>
            	
            	<h6>기존 BoxNo가 교체됩니다. 계속 진행하시겠습니까?</h6>
				<label>*교체 후(BoxNo)가 다른 파레트에 포장되어있으면 교체가 불가합니다.</label>
				<br>
				<label>*교체 후(BoxNo)가 불량인 경우 교체가 불가합니다.</label>
				<br>
				<label>*기존 고객사 번호는 동일하게 가져갑니다.</label>
		    </div>
            <div class="modal-footer" id="" style="justify-content:space-between;">
            	<button type="button" class="btn btn-secondary touch6" style="width: 16%;" data-dismiss="modal">닫기</button>
            	<button type="button" class="btn btn btn-primary touch6" style="width: 16%;" id="btnBoxNoChange">교체</button>
            </div>
        </div>
    </div>
</div>
<!--주자재 교체 모달 -->

<!-- 출하 취소 확인 모달 시작-->
<div class="modal fade" id="cancelCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel">출하 취소 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<!-- <h6>출하 취소 확인</h6> -->
      	<p>*해당 파레트로 출하된 제품들이 모두 출하 취소됩니다.</p>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger touch6" id="btnCancelCheck" data-dismiss="modal" style="min-width:70px;">출하 취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 출하 취소 확인 모달 끝-->


<!-- 관리자확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="checkAdminPopUpModal" tabindex="-1" role="dialog" aria-labelledby="checkAdminPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="width:50vh;">
			
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id=>관리자 확인</h5>
				<input type="hidden" id="modalGubun">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				
				<!-- 계정확인하는부분 -->
				<h6>관리자&조장 확인</h6>
				아이디 :
				<div class="input-sub m-0">
					<input type="text" id="userId" class="form-control touch6">
					<button type="button" class="btn btn-primary input-sub-search-md" id="searcAdminUser" onClick="userAuthModal('005')">
						<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
					</button>
				</div>
				비밀번호 :
				<input type="password" class="form-control touch6" id="userPassword" disabled>
				
				<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
				<button type="button" class="btn btn-success touch6 mt-1" id="btnAccountCheck" style="width: 100%;">계정확인</button>
				<!-- 계정확인하는부분 -->
			</div>
			
			<div class="modal-footer" style="padding-top: 0px;"></div>
		</div>
	</div>
</div>
<!-- 관리자확인 모달 종료-->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc0170';
	let currentHref = 'iosc0170';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","파레트라벨출력");

	let chooseDateFrom	= "${serverDateFrom}";
	let chooseDateTo	= "${serverDateTo}";
	let factoryCode		= "<%=factoryCode%>";
	let todayDate		= "${serverDateFrom}";
	
	let poSeq			= null;
	let poGroup			= null;
	let completeYn		= null;
	let boxNoList		= null;
	let scanPalletNo	= null;

	let orgGoodsCd		= null;
	let orgGoodsStatus	= null;
	let selRowId		= null;

	//공통코드 처리 시작
    var printWetherType=new Array();	//출력여부
	<c:forEach items="${printWetherType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		printWetherType.push(json);
    </c:forEach>
    
    var completeYnType=new Array();	//완공여부
    <c:forEach items="${completeYnType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		completeYnType.push(json);
    </c:forEach>
    
	var locationCode = new Array(); // 설치장소
	<c:forEach items="${locationCode}" var="info">
	var json = new Object();
	json.baseCd		= "${info.baseCd}";
	json.baseCdNm	= "${info.baseCdNm}";
	json.etc2		= "${info.etc2}";
	locationCode.push(json);
	</c:forEach>
	
	var goodsStatusCd=new Array();	//제품 출하상태
    <c:forEach items="${goodsStatus}" var="info">
		var json=new Object();
		if( "${info.baseCd}" != "001" ) {
			json.baseCd="${info.baseCd}";
			json.baseCdNm="${info.baseCdNm}";
			goodsStatusCd.push(json);
		}
    </c:forEach>
  	//공통코드 처리 끝
  	
 	$('#chooseDateFromCal').val(chooseDateFrom);
	$('#chooseDateToCal').val(chooseDateTo);
	
	selectBoxAppend(locationCode, "location", "", "2");
	selectBoxAppend_NameAdd(goodsStatusCd, "selGoodsStatus", "", "1", "상태");
 	
    //메인목록 조회
    $.fn.dataTable.ext.errMode = 'none';
	let palletTable = $('#palletTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row col-sm-12'<'col-md-9'l><'col-md-3'>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row col-sm-12'<'col-md-9'i><'col-md-2'p><'col-sm-12 col-md-6'>>B",
        language: lang_kor,
        paging: false,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: true,
        scrollX : true,
        lengthChange: false,
        scrollY: "68vh",
        scrollCollapse: true,
        ajax: {
            url: '<c:url value="/io/productShipmentDataList_iosc0170_F3"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: menuAuth,
	           	'chooseDateFrom'	: function() { return chooseDateFrom.replace(/-/g, '');				},
            	'chooseDateTo'		: function() { return chooseDateTo.replace(/-/g, '');				},
            	'approvalCd'	    : function() { return $("#approvalGubun option:selected").val();	},
            	'printWether'	    : function() { return $("#printWether option:selected").val();		},
            	'completeYn'	    : function() { return $("#selCompleteYn option:selected").val();	},
            	'goodsStatus'	    : function() { return $("#selGoodsStatus option:selected").val();	},
            	'scanPalletNo'	    : function() { return scanPalletNo;	},
            },
        },
        rowId: 'rowId',
        columns: [
        	{ data: 'completeYn',
           		render: function(data, type, row) {
           			if(data != null) {
           				if(data == 'Y') {
    						return '완공';
    					} else {
    						return "미료";
    					} 
             		}	
                }
            },//완공여부
            { data: 'goodsStatusNm'	},	//상태
            { data: 'locationNm'	},	//창고
            { data: 'dealCorpNm'	},	//거래처
            { data: 'poSeq'			},	//등록번호(PO) 
            { data: 'poNo'			},	//poNo
            { data: 'modelNo'		},	//모델번호
            { data: 'poGroup'		},	//파레트번호
            { data: 'poGubunNm'		},	//오더구분   
            { data: 'goodsNm'		},	//제품
            { data: 'qutyNm'		},	//재질 
            { data: 'boxCount',
                render: function(data, type, row) {					
                	if(data != "" && data != null ) {
						return data + "개";
					} else {
						return null;
					} 
          		}
			},//출고박스
			{ data: 'outputCnt'		},	//출고수량              
           	{ data: 'deliveryDate',
                render: function(data, type, row) {					
                	if(data != "" && data != null ) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return null;
					} 
          		}
			},//납기일
    		{ data: 'goodsOutDate',
                render: function(data, type, row) {					
					if(data != "" && data != null ) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return null;
					} 
          		}
    		},//출고일
    		{ data: 'locationInputDate',
                render: function(data, type, row) {
                	if(data != "" && data != null ) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return null;
					} 
          		}
			},//납기일
			{ data: 'customerPalletNo' }, //고객사 파레트 번호
        ],
        columnDefs: [
        	{ targets: [12] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [12], className: 'text-right' },
        	{ targets: "_all", "defaultContent": "-" },
        ],
        rowCallback: function (row, data) {
			if (data.disposeGubun > 0) {
				$(row).addClass('whiteRed');
			}
		},
        buttons: [
            { extend: 'copy',	title: '파레트라벨출력'	},
            { extend: 'excel',	title: '파레트라벨출력'	},
            { extend: 'print',	title: '파레트라벨출력'	}
        ],
    });
	
	//검색 기능 위치 변경
	/* $('#palletTable_filter').find('input[type=search]').eq(0).attr('id', 'palletSearch');
	$('#palletTable_filter').find('label').eq(0).attr('id', 'palletSearchLabel');
	
	$("#palletSearchLabel").insertAfter("#selCompleteYn");
 	$("#palletSearch").insertAfter("#palletSearchLabel"); */
	//검색 기능 위치 변경
	
	//틀 고정 시 thead, tbody 깨지는 현상 잡아주는 부분
  	palletTable.on('draw.dt', function(){
  		palletTable.columns.adjust();
	});
 	
 	//메인테이블 클릭 시(상세보기)
    $('#palletTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#palletTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        
        poSeq		= palletTable.row(this).data().poSeq;
        poGroup 	= palletTable.row(this).data().poGroup;
        completeYn	= palletTable.row(this).data().completeYn;
        orgGoodsCd	= palletTable.row(this).data().goodsCd;

        selRowId	= palletTable.row('.selected').id();
		
        if(palletTable.row(this).data().goodsStatus == '003'){
			$('#btnReturn').attr('disabled', false);
			$('#btnSwitching').attr('disabled', true);
			$('#btnCancel').attr('disabled', false);
		} else {
           	$('#btnReturn').attr('disabled', true);
           	$('#btnSwitching').attr('disabled', false);
           	$('#btnCancel').attr('disabled', true);
       	}
       	if(palletTable.row(this).data().goodsStatus == '002' || palletTable.row(this).data().goodsStatus == '004' || palletTable.row(this).data().goodsStatus == '005'){
       		$('#btnBoxDelete').attr('disabled', false);
        }else $('#btnBoxDelete').attr('disabled', true);
        
        $("#checkAll").prop("checked", false);
        
        $('#palletDtlTable').DataTable().ajax.reload( function () {});
    });

	let totalDtlCnt = 0;
	
	//상세 목록 조회
    let palletDtlTable = $('#palletDtlTable').DataTable({
    	dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
    	"<'row'<'col-sm-12'tr>>" +
    	"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
    	language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        searching: false,
        processing: true,
        autoWidth: true,
        scrollX : true,
        lengthChange: false,
        scrollY: "68vh",
        scrollCollapse: true,
        ajax: {
            url: '<c:url value="/io/productShipmentPalateDtlDataList_iosc0170_F3"/>',
            type: 'GET',
            data: {
            	'menuAuth'	: menuAuth,
            	'poSeq' 	: function() { return poSeq;	},
            	'poGroup' 	: function() { return poGroup;	},
             },             
        },
        rowId: '',
        columns: [
        	{
				render: function(data, type, row, meta) {
					return '<input type="checkbox" style="width:20px; height:20px" id="chk-' + meta.row + '" name="chk" value="'+ meta.row +'">' ;
				}
			},
        	{ 
	        	data: '',
				render: function(data, type, row, meta){
					return meta.row+1;
				}
			},
        	{ data: 'customerLotNo',
                render: function(data, type, row) {
                	
                	if( data != null && data != "" ) {
	                	if( data != "/") {
	                		
		                	let splitText = "";
							splitText = data.split("/");
							
							if(splitText.length == 3 ) {
								return splitText[0] + "<br>" + (splitText[1] == "" ? "-" : splitText[1]) + "<br>" + (splitText[2] == "" ? "-" : splitText[2]);
							} else if(splitText.length == 2 ) {
								return splitText[0] + "<br>" + (splitText[1] == "" ? "-" : splitText[1]);
							} else {
								return data;
							}
							
	                	} else {
	                		return "-"
	                	}
                	} else {
                		return "-";
                	}
          		}
        	},
            { data: 'boxNo'				},
            { data: 'goodsStatusNm'		},
            { data: 'faultyStatusNm'	},
            { data: 'outputCnt'			},
            { data: 'goodsDesc',
                render: function(data, type, row, meta) {
                	var html = "";
                	
                	if(data != null) {
						html = "<input type='text' class='form-control touch6' style='min-width: 100%;' value='"+data+"'>";
                	} else {
                		html = "<input type='text' class='form-control touch6' style='min-width: 100%;' value=''>";
                	}
                	
					return html;
          		}
			},
        ],
        columnDefs: [],
        order: [
//            [ 1, 'asc' ]
        ],
        columnDefs: [
        	{ targets: [0,1,2,3,4,5,7], className: 'text-center'			},
        	{ targets: [6], className: 'text-right'						},
        	{ targets: [6] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [0,2,3,4,5,6,7], orderable:false},
        ],
        buttons: [
        	{ extend: 'copy',	title: '파레트라벨출력(상세)'	},
            { extend: 'excel',	title: '파레트라벨출력(상세)'	},
            { extend: 'print',	title: '파레트라벨출력(상세)'	}
        ],
        rowCallback: function (row, data) {
        	
        	if (data.factCheck == "Y") {
				//$(row).addClass('skyYellow');
        		$(row).attr('style', 'background-color: #68ff68;');
			}
        	
			if (data.disposeGubun=="003") {
				$(row).addClass('whiteRed');
			}
		},
        drawCallback: function () {
        	totalDtlCnt = $('#palletDtlTable').DataTable().column(6,{ page: 'all'} ).data().sum();
		},
        /* rowCallback: function (row, data) {
            $($(row).find("td")[0]).attr("onclick", "event.cancelBubble=true");
        }, */
    });
	
	//틀 고정 시 thead, tbody 깨지는 현상 잡아주는 부분
  	palletDtlTable.on('draw.dt', function(){
  		palletDtlTable.columns.adjust();
	});
	
	//파레트번호스캔
	$("#scanPalletNo").keypress( function(e) {
		if (e.which == 13) {
			//키보드입력 말고 바코드로 스캔시 풀어주기
			if (!$.trim($('#scanPalletNo').val())) {
				toastr.warning('파레트 번호를 스캔해주세요!');
				$('#scanPalletNo').focus();
				return false;
			}
			
			scanPalletNo = $('#scanPalletNo').val();
			$('#btnCancel').attr('disabled', true);
			$('#palletTable').DataTable().ajax.reload();
		}
	});
	
	//삭제 버튼 클릭 시	
	function scanReset() {
		scanPalletNo	= null;
		$('#scanPalletNo').val("");
		$('#scanPalletNo').focus();
		
		$('#btnRetv').click();
	}
    
    
    //조회 버튼 클릭 시
    $('#btnRetv').on('click', function() {
	   	
	   	let dateFrom	= new Date($('#chooseDateFromCal').val());
		let dateTo		= new Date($('#chooseDateToCal').val());
		let dateDiff	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCal').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCal').focus();
			return false;
		}
		if (dateDiff >= 92) {
			toastr.warning("검색 가능 기간은 최대 세달입니다.");
			$('#chooseDateFromCal').focus();
			return false;
		}
		
		chooseDateFrom	= $('#chooseDateFromCal').val();
		chooseDateTo	= $('#chooseDateToCal').val();
		scanPalletNo	= null;
	   	
		$('#scanPalletNo').val("");
		$('#btnCancel').attr('disabled', true);
		
		$('#palletTable').DataTable().ajax.reload();
		$('#palletDtlTable').DataTable().clear().draw();
    });
    
  	//출력 여부 값 변경 시
	$('#printWether').on('change', function(){
		$('#palletTable').DataTable().ajax.reload();
		$('#palletDtlTable').DataTable().clear().draw();
	});
	
	//완공 여부 값 변경 시
	$('#selCompleteYn').on('change', function(){
		$('#btnCancel').attr('disabled', true);
		$('#palletTable').DataTable().ajax.reload();
		$('#palletDtlTable').DataTable().clear().draw();
	});
	
	$('#selGoodsStatus').on('change', function(){
		$('#btnCancel').attr('disabled', true);
		$('#palletTable').DataTable().ajax.reload();
		$('#palletDtlTable').DataTable().clear().draw();
	});
    
	
	
	
	
	
	
    //신규 파레트 & 기존 파레트 추가 영역
    
    let exceptBoxNo	= null;
    
    //신구 파레트 추가 버튼 클릭 시
	$('#btnNewPalletAdd').on('click', function() {
		
		$('#palletPopUpLabel').text('신규 파레트 추가');
		
		//$('#chooseDate').val("${serverDateFrom}");
		shiftTime();
		
		$('#btnSelpoSeqCode').removeClass('d-none');
		$('#btnPoLgesCode').removeClass('d-none');
		
		$('#deliveryDate').val('');
		$('#poGubunCd').val('');
		$('#goodsCd').val('');
		$('#poSeq').val('');
		$('#poModelNo').val('');
		$('#poNo').val('');
		
		$('#chooseDate').attr('disabled', false);
		$('#btnSelpoSeqCode').attr('disabled', false);
		$('#btnPoLgesCode').attr('disabled', false);
		$('#boxNo').attr('disabled', false);
		$('#addPallet').prop('checked', true);
		
		$('#poGroup').val('');
		
		$('#boxNo').val('');
		$('#secondCustomerLotNo').val('');
		$('#secondCustomerLotNo2').val('');
		$('#secondCustomerLotNo3').val('');
		
		$('#goodsProductInfoTable').DataTable().clear().draw();
		
		$('#newPalletPopUpModal').modal('show');
	});
    
    //박스 추가 버튼 클릭 시
	$('#btnBoxAdd').on('click', function() {
		
		if (!$('#palletTable tr').hasClass('selected')) {
			toastr.warning("파레트를 선택해주세요");
            return false;
        }
		if ( completeYn == null || completeYn == "" || completeYn == "Y" ) {
			toastr.warning("미료 파레트를 선택해주세요.");
            return false;
        }
		
		$('#palletPopUpLabel').text('박스 추가');
		
		exceptBoxNo = 'empty';
		
		$('#boxNo').attr('disabled', false);
		
		//$('#chooseDate').val("${serverDateFrom}");
		shiftTime();
		
		$('#btnSelpoSeqCode').addClass('d-none');
		$('#btnPoLgesCode').addClass('d-none');
		
		let data = palletTable.rows('.selected').data()[0];
		
		$('#dealCorpCd').val(data.dealCorpCd);
		$('#deliveryDate').val(data.deliveryDate);
		$('#poGubunCd').val(data.poGubunCd);
		$('#goodsCd').val(data.goodsCd);
		$('#poSeq').val(data.poSeq);
		//$('#poModelNo').val(data.poCode);
		$('#poModelNo').val(data.modelNo);
		$('#poNo').val(data.poNo);
		
		$('#addPallet').prop('checked', false);
		
		$('#poGroup').val(poGroup);
		
		$('#boxNo').val('');
		$('#secondCustomerLotNo').val('');
		$('#secondCustomerLotNo2').val('');
		$('#secondCustomerLotNo3').val('');
		
		$('#goodsProductInfoTable').DataTable().clear().draw();
		
		$('#newPalletPopUpModal').modal('show');
	});
    
	$('#newPalletPopUpModal').on('shown.bs.modal', function(e){
		$('#boxNo').focus();
		goodsProductInfoTable.columns.adjust();
	});
    
    
	let goodsCd			= null;
	let goodsNm			= null;
	let boxNo			= null;
	let packCnt			= null;
	let remainCnt 		= null;
	let customerLotNo	= null;
	let customerLotNo2	= null;
	let customerLotNo3	= null;
	let count 			= 0;
	
	$.fn.dataTable.ext.errMode = 'none';
	let goodsProductInfoTable = $('#goodsProductInfoTable').on('error.dt', function(e, settings, techNote, message) {
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
		scrollY: "50vh",
		scrollCollapse: true,
        lengthChange : true,
		ajax : {
			url : '<c:url value="/tm/preGoodsOutputEmptyList"/>',
			type : 'GET',
			data : {
				'menuAuth' : menuAuth,
			},
		},
		rowId : '',
		columns : [
			{
				render : function(data, type, row, meta) {
					var rowNo = meta.row + 1;
					if (rowNo == 1) {
						//$('#btnSave').attr('disabled', false);
					}
					return meta.row + 1;
				}
			},
			{
				data : 'goodsCd',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return goodsCd;
					}
				}
			},
			{
				data : 'goodsNm',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return goodsNm;
					}
				}
			},
			{
				data : 'boxNo',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return boxNo;
					}
				}
			},
			{
				data : 'packCnt',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return packCnt;
					}
				}
			},
			{
				data : 'remainCnt',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return remainCnt;
					}
				}
			},
			{
				data : 'customerLotNo',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return customerLotNo;
					}
				}
			}
			,{
				data : 'customerLotNo',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return customerLotNo2;
					}
				}
			}
			,{
				data : 'customerLotNo',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return customerLotNo3;
					}
				}
			}
		],
		columnDefs : [
			{ "className" : "text-center", "targets" : "_all" }
		],
		order : [ [ 0, 'desc' ] ],
		buttons : [],
		createdRow : function(row, data, dataIndex) {
			//$(row).attr('data-location-cd', locationCd);
		},
		drawCallback : function() {
			$('.mo_card tbody').css('font-size', '10px');
		},
	});

	//$('#goodsProductInfoTable').css('font-size', '12px' );
	
	//틀 고정 시 thead, tbody 깨지는 현상 잡아주는 부분
  	goodsProductInfoTable.on('draw.dt', function(){
  		goodsProductInfoTable.columns.adjust();
	});

	var lineCheck = false;
	$('#goodsProductInfoTable tbody').on( 'click', 'tr', function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			lineCheck = false;
		} else {
			$('#goodsProductInfoTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			lineCheck = true;
		}
	});
	
	//박스번호 스캔 시
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
				toastr.warning("포장일을 선택해주세요!");
				return false
			}
			if ($('#boxNo').val().trim().length != "18") {
				toastr.warning('제품 바코드가 아닙니다. 확인해주세요');
				$('#boxNo').focus();
				return false;
			}
			if ($("#poNo").val() == null || $("#poNo").val() == "") {
				toastr.warning('PO Number를 먼저 선택해주세요.');
				$('#btnSelpoSeqCode').focus();
				return false;
			}
			if($('#addPallet').prop('checked')) {
				
			} else {
				if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
					toastr.warning('추가로 적재할 파레트를 선택해 주세요!');
					return false;
				}
			}

			var cval = compareBarcodeNo($('#boxNo').val().trim());
			if (cval == false) {
				toastr.warning('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', { timeOut : 5000 });
				$('#boxNo').select();
				return false;
			}

			let restock = 'no';

			$.ajax({
				url : '<c:url value="/pd/goodsProductInfoData"/>',
				type : 'GET',
				data : {
					'menuAuth'	: menuAuth,
					'boxNo'		: function() { return $('#boxNo').val().trim();			},
					'poModelNo'	: function() { return $('#poModelNo').val(); 			},
					'poSeq'		: function() { return $("#poSeq").val(); 				},
					'poGroup'	: function() { return $('#poGroup').val();				},
					'addPallet'	: function() { return $('#addPallet').prop('checked');	},
					'restock'	: restock,
				},
				beforeSend : function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success : function(res) {
					let data = res.data;
					
					if (res.result == 'ok') { //제품상태 포장, 제품입고

						boxNo		= data.boxNo;
						goodsCd		= data.goodsCd;
						goodsNm		= data.goodsNm;
						packCnt		= data.packCnt;
						remainCnt	= data.remainCnt;
						
						$('#btnSave').attr('disabled', false);
						$('#btnCalendar').attr('disabled', true);
						$('#btnLineClear').attr('disabled', false);
						$('#btnAllClear').attr('disabled', false);
						
						$('#boxNo').attr('disabled',true);
						$('#secondCustomerLotNo').attr('disabled',false);
						$('#secondCustomerLotNo').focus();
						toastr.success('고객사 LotNo를 입력 해주세요.');
						
					} else if (res.result == 'fail') { //제품 출하
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#boxNo').select();
					} else if (res.result == 'error') { // BoxNo 조회 에러
						toastr.error(res.message, '', { timeOut : 5000 });
						$('#boxNo').select();
					}
				},
				complete : function() {}
			});
		}
	});
	
	//고객사 바코드1 스캔시
	$("#secondCustomerLotNo").keypress(function(e) {
		if (e.which == 13) {
			
			let poModelNo = $('#poModelNo').val().replaceAll('-','');
			
			if( poModelNo.indexOf('/') != "-1" ) {
				poModelNo = poModelNo.split('/');
				
				if( poModelNo[0].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( poModelNo[1].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo[0].length) != poModelNo[0] && $(this).val().substr(0, poModelNo[1].length) != poModelNo[1] ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
			} else {
				if( poModelNo.length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo.length) != poModelNo ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}				
			}
				
			$('#count').text(count);
			
			exceptBoxNo += "/" + boxNo;
			
			customerLotNo	= $('#secondCustomerLotNo').val();
			customerLotNo2	= "";
			customerLotNo3	= "";
			
			if( $('#dealCorpCd').val() == "00018" ) {
				//LGES인 경우
				$('#goodsProductInfoTable').DataTable().row.add({}).draw(false);

				$('#boxNo').attr('disabled', false);
				$('#secondCustomerLotNo').attr('disabled', true);
				
				$('#boxNo').val('');
				$('#secondCustomerLotNo').val('');
				$('#boxNo').focus();
				
				toastr.success('추가되었습니다.');
			} else {
				$('#boxNo').attr('disabled', true);
				$('#secondCustomerLotNo').attr('disabled', true);
				$('#secondCustomerLotNo2').attr('disabled', false);
				$('#secondCustomerLotNo3').attr('disabled', true);
				$('#secondCustomerLotNo2').focus();
				
				toastr.success('고객사 LotNo2를 입력 해주세요.');
			}
			
		}
	});
	
	//고객사 바코드2 스캔시
	$("#secondCustomerLotNo2").keypress(function(e) {
		if (e.which == 13) {
			
			let poModelNo = $('#poModelNo').val().replaceAll('-','');
			
			if( poModelNo.indexOf('/') != "-1" ) {
				poModelNo = poModelNo.split('/');
				
				if( poModelNo[0].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( poModelNo[1].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo[0].length) != poModelNo[0] && $(this).val().substr(0, poModelNo[1].length) != poModelNo[1] ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
			} else {
				if( poModelNo.length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo.length) != poModelNo ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}				
			}
			
			//같은 고객사 입력 시
			if( $('#secondCustomerLotNo').val() == $('#secondCustomerLotNo2').val() ) {
				toastr.warning("첫 번째 고객사 번호와 같은 고객사 번호입니다.");
				return false;
			}
			
			count += 1;
			$('#count').text(count);
			
			exceptBoxNo += "/" + boxNo;
			customerLotNo2 = $('#secondCustomerLotNo2').val();
			
			let data = palletTable.rows('.selected').data()[0];
			
			if( data.dealCorpCd != "00011" ) {
				$('#goodsProductInfoTable').DataTable().row.add({}).draw(false);

				$('#boxNo').attr('disabled', false);
				$('#secondCustomerLotNo').attr('disabled', true);
				$('#secondCustomerLotNo2').attr('disabled', true);
				$('#boxNo').val('');
				$('#secondCustomerLotNo').val('');
				$('#secondCustomerLotNo2').val('');
				$('#boxNo').focus();
				
				toastr.success('추가되었습니다.');
			} else {
				
				$('#boxNo').attr('disabled', true);
				$('#secondCustomerLotNo').attr('disabled', true);
				$('#secondCustomerLotNo2').attr('disabled', true);
				$('#secondCustomerLotNo3').attr('disabled', false);
				
				$('#secondCustomerLotNo3').focus();
				
				toastr.success('고객사 LotNo3을 입력 해주세요.');
			}
		}
	});
	
	//고객사 바코드3 스캔시
	$("#secondCustomerLotNo3").keypress(function(e) {
		if (e.which == 13) {
			
			let poModelNo = $('#poModelNo').val().replaceAll('-','');
			
			if( poModelNo.indexOf('/') != "-1" ) {
				poModelNo = poModelNo.split('/');
				
				if( poModelNo[0].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( poModelNo[1].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo[0].length) != poModelNo[0] && $(this).val().substr(0, poModelNo[1].length) != poModelNo[1] ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
			} else {
				if( poModelNo.length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo.length) != poModelNo ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}				
			}
			
			//같은 고객사 입력 시
			if( $('#secondCustomerLotNo').val() == $('#secondCustomerLotNo3').val() ) {
				toastr.warning("첫 번째 고객사 번호와 같은 고객사 번호입니다.");
				return false;
			}
			//같은 고객사 입력 시
			if( $('#secondCustomerLotNo2').val() == $('#secondCustomerLotNo3').val() ) {
				toastr.warning("두 번째 고객사 번호와 같은 고객사 번호입니다.");
				return false;
			}
			
			count += 1;
			$('#count').text(count);
			
			exceptBoxNo += "/" + boxNo;
			customerLotNo3 = $('#secondCustomerLotNo3').val();
			$('#goodsProductInfoTable').DataTable().row.add({}).draw(false);

			$('#boxNo').attr('disabled', false);
			$('#secondCustomerLotNo').attr('disabled', true);
			$('#secondCustomerLotNo2').attr('disabled', true);
			$('#secondCustomerLotNo3').attr('disabled', true);
			$('#boxNo').val('');
			$('#secondCustomerLotNo').val('');
			$('#secondCustomerLotNo2').val('');
			$('#secondCustomerLotNo3').val('');
			$('#boxNo').focus();
			
			toastr.success('추가되었습니다.');
		}
	});
	
	//추가버튼 클릭 시 
	$('#barcodeAdd').on('click', function() {
		
		if( $('#boxNo').val() == null || $('#boxNo').val() == "" ) {
			toastr.warning('바코드를 입력해주세요.');
			return false;
		}
		if( $('#boxNo').attr('disabled') == null || $('#boxNo').attr('disabled') ==  undefined ) {
			toastr.warning('바코드를 입력해주세요.');
			return false;
		}
		
		count += 1;
		$('#count').text(count);
		
		exceptBoxNo += "/" + boxNo;
		customerLotNo = $('#secondCustomerLotNo').val();
		customerLotNo2 = $('#secondCustomerLotNo2').val();
		customerLotNo3 = $('#secondCustomerLotNo3').val();
		$('#goodsProductInfoTable').DataTable().row.add({}).draw(false);

		$('#boxNo').attr('disabled', false);
		$('#secondCustomerLotNo').attr('disabled', true);
		$('#secondCustomerLotNo2').attr('disabled', true);
		$('#secondCustomerLotNo3').attr('disabled', true);
		$('#boxNo').val('');
		$('#secondCustomerLotNo').val('');
		$('#secondCustomerLotNo2').val('');
		$('#secondCustomerLotNo3').val('');
		$('#boxNo').focus();
		
		toastr.success('추가되었습니다.');
	});
	
	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#goodsProductInfoTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		$('#boxNo').val('');
		$('#boxNo').focus();
		count = 0;
		$('#count').text(count);
	});

	//라인 삭제
	$('#btnLineClear').on('click', function() {
		if (lineCheck == true) {
			$('#goodsProductInfoTable').DataTable().rows('.selected').remove().draw();
			$("#boxNo").val("");
			$("#boxNo").focus();
			
			var rowCnt = $('#goodsProductInfoTable').DataTable().data().count();
			
			if (rowCnt == 0) {
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
	
	
	//신규퍼레트 저장 버튼 클릭 시
	$('#btnNPASave').on('click', function(){
		if (!$.trim($('#chooseDate').val())) {
			toastr.warning('포장일을 선택해주세요.');
			return false;
		}
		
		if($('#poNo').val() == '' || $('#poNo').val() == null) {
			toastr.warning('PO Number를 선택해주세요.');
			$('#btnSelpoSeqCode').focus();
			return false;			
		}
		
		if($('#goodsProductInfoTable tbody').text() == '데이터가 없습니다.'){
			toastr.warning('박스 추가 후 저장 버튼을 눌러주세요.');
			$('#boxNo').focus();
			return false;			
		}
		
		//파레트 확인
		if($('#addPallet').prop('checked')) {
		} else {
			if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
				toastr.warning('추가로 적재할 파레트를 선택해 주세요!');
				return false;
			}
		}			
		if ($('#poModelNo').val() == null || $('#poModelNo').val() == '') {
			toastr.warning("해당 제품에 모델이 없습니다.<br> 제품코드관리에서 등록해주세요!");
			$('#poModelNo').focus();
			return false;
		}
	
		$('#my-spinner').show();
	
		createBarcodeNo();
	
		$.ajax({
			url : '<c:url value="/pd/updateProductLocation_F3"/>',
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
				console.log(data);
				if (res.result == 'ok') {
					
					$('#btnAllClear').attr('disabled', true);
					$('#btnLineClear').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
					$('#boxNo').attr('disabled', true);
					$('#btnSelpoSeqCode').attr('disabled', true);
					$('#btnPoLgesCode').attr('disabled', true);
					$('#addPallet').attr('disabled', true);
					
					//$('#btnCancel').addClass('d-none');
					$('#btnNew').removeClass('d-none');
					
					//$('#palletTable').DataTable().ajax.reload();
					
					if( $('#palletPopUpLabel').text() == "박스 추가" ) {
						sudel(palletTable.row('.selected').id());
						toastr.success('해당 파레트에 박스 추가되었습니다.');
					} else {
						sudel(data.poSeq+data.poGroup);
						toastr.success('신규 파레트포장되었습니다.<br>신규 파레트 번호가 선택되었습니다.');
					}
					
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
				$('#newPalletPopUpModal').modal('hide');
				$('#my-spinner').hide();
			}
		});
	});
	
	
	//완공 상태 
	
	//완공 상태  버튼 클릭 시
	$('#btnCompleteStatuse').on('click', function() {
		if (!$('#palletTable tr').hasClass('selected')) {
			toastr.warning("파레트를 선택해주세요");
            return false;
        }
		
		let data = palletTable.rows('.selected').data()[0];
		
		if (!(data.goodsStatus == "002" || data.goodsStatus == "004" || data.goodsStatus == "005") ) {
			toastr.warning("제품입고, 점검대기, 출하대기 상태만 변경 가능합니다.");
            return false;
        }
		
		if( palletDtlTable.data().length == 0 || $('#palletDtlTable tbody').text() == '데이터가 없습니다.' ) {
			toastr.warning("파레트를 다시 선택해주세요.");
            return false;
		}
		
		$('input[name="completeYn"]').prop('checked', false);
		$($('input[name="completeYn"]')[0].parentNode).attr('style', '');
		$($('input[name="completeYn"]')[1].parentNode).attr('style', '');
		
		$('#completeStatusePopUpModal').modal('show');
	});
	
	//미료&완공버튼 클릭 시_UI 설정
	$('input[name="completeYn"]').on('change', function() {
		$($('input[name="completeYn"]')[0].parentNode).attr('style', '');
		$($('input[name="completeYn"]')[1].parentNode).attr('style', '');
		
		if( $(this).attr('id') == "completeY" ) {
			$(this.parentNode).attr('style', 'border: 2px #0051ae solid;border-radius: 100px;display: flex;align-items: center;');
		} else {
			$(this.parentNode).attr('style', 'border: 2px #ff4242 solid;border-radius: 100px;display: flex;align-items: center;');
		}
	});
	
	//변경 버튼 클릭 시
	$('#btnCSChangeSave').on('click', function() {
		
		if( palletDtlTable.data().length == 0 || $('#palletDtlTable tbody').text() == '데이터가 없습니다.' ) {
			toastr.warning("파레트를 다시 선택해주세요.");
            return false;
		}
		if($('input[name="completeYn"]:checked').prop('checked') == null) {
			toastr.warning('완공취소&완공 여부를 선택 해주세요!');
			$('#completeN').focus();
			return false;
		}

		if(palletTable.rows('.selected').data()[0].disposeGubun > 0){
			toastr.warning('폐기지정된 Box가 포함되어 있습니다.폐기지정된 Box를 제외하고 다시 시도해주세요.');
			return false;
		}

		$('#palletDtlTable').DataTable().row('selected').data();
		
		$('#my-spinner').show();

		if (createBoxNo()) {
			$.ajax({
				url : '<c:url value="/pd/palletRelatedCompleteYn_F3"/>',
				type : 'POST',
				data : JSON.stringify(boxNoList),
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				beforeSend : function() {},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						
						$('#completeStatusePopUpModal').modal('hide');
						sudel(palletTable.row('.selected').id());
						toastr.success('변경되었습니다.');
						
						//완공으로 변경 시 라벨 출력
						if( $('input[name="completeYn"]:checked').val() == "Y" ) {
							$('#btnPrint').click();							
						}
						
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', { timeOut : 5000 });
					} else {
						toastr.warning(res.message, '', { timeOut : 5000 });
					}
				},
				complete : function() {
					$('#completeStatusePopUpModal').modal('hide');
					$('#my-spinner').hide();
				}
			});
		}
	});
	
	//위치지정 클릭 시
	$('#btnLocation').on('click', function() {
		
		if (!$('#palletTable tr').hasClass('selected')) {
			toastr.warning("파레트를 선택해주세요");
            return false;
        }
		if ( completeYn == null || completeYn == "" || completeYn == "N" ) {
			toastr.warning("완공 파레트를 선택해주세요.");
            return false;
        }
		if( palletDtlTable.data().length == 0 || $('#palletDtlTable tbody').text() == '데이터가 없습니다.' ) {
			toastr.warning("파레트를 다시 선택해주세요.");
            return false;
		}
		
		let data = palletTable.rows('.selected').data()[0];
		
		if ( data.goodsStatus == "003" ) {
			toastr.warning("제품출고 상태는 창고 지정을 할 수 없습니다.");
            return false;
        }
		
		$('#location').val("");
		$('#locationInputDate').val("${serverDateFrom}");
		
		$('#locationPopUpModal').modal('show');
	});
	
	
	//창고 지정 저장 버튼 클릭 시
	$('#btnLSave').on('click', function() {
		if (!$('#palletTable tr').hasClass('selected')) {
			toastr.warning("파레트를 선택해주세요");
            return false;
        }
		if ( completeYn == null || completeYn == "" || completeYn == "N" ) {
			toastr.warning("완공 파레트를 선택해주세요.");
            return false;
        }
		if( palletDtlTable.data().length == 0 || $('#palletDtlTable tbody').text() == '데이터가 없습니다.' ) {
			toastr.warning("파레트를 다시 선택해주세요.");
            return false;
		}
		
		let data = palletTable.rows('.selected').data()[0];
		
		if ( data.goodsStatus == "003" ) {
			toastr.warning("제품출고 상태는 창고 지정을 할 수 없습니다.");
            return false;
        }
		
		if($("#location").val() == null || $("#location").val() == "") {
			$("#boxNo").val("");
			toastr.warning("창고를 선택해주세요!");
			$("#location").focus();
			return false
		}
		
		if($("#locationInputDate").val() == null || $("#locationInputDate").val() == "") {
			toastr.warning("날짜를 선택해주세요!");
			$("#locationInputDate").focus();
			return false
		}

		if(palletTable.rows('.selected').data()[0].disposeGubun > 0){
			toastr.warning('폐기지정된 Box가 포함되어 있습니다.폐기지정된 Box를 제외하고 다시 시도해주세요.');
			return false;
		}

		
		
		$('#my-spinner').show();

		if (createBoxNo2()) {
			$.ajax({
				url : '<c:url value="/pd/palletRelatedCompleteYn_F3"/>',
				type : 'POST',
				data : JSON.stringify(boxNoList),
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				beforeSend : function() {},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						
						$('#locationPopUpModal').modal('hide');
						sudel(palletTable.row('.selected').id());
						toastr.success('저장되었습니다.');
						
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', { timeOut : 5000 });
					} else {
						toastr.warning(res.message, '', { timeOut : 5000 });
					}
				},
				complete : function() {
					$('#locationPopUpModal').modal('hide');
					$('#my-spinner').hide();
				}
			});
		}
	});


	//비고 저장 버튼 클릭 시
	$('#btnGoodsDescSave').on('click', function() {
		
		if (!$('#palletTable tr').hasClass('selected')) {
			toastr.warning("파레트를 선택해주세요");
            return false;
        }
		
		let goodsArray = new Array();
		
		$('#palletDtlTable tbody tr').each(function(idx, item) {
			var obj = new Object();
		    obj.boxNo = $(item).find('td').eq(3).text();
		    obj.goodsDesc = $(item).find('td').eq(7).find('input').val();
		    goodsArray.push(obj);
	    });
		
		$.ajax({
			url : '<c:url value="/io/goodsProductDescUpdate_F3"/>',
			type : 'POST',
			data : JSON.stringify(goodsArray),
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			beforeSend : function() {},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					sudel(palletTable.row('.selected').id());
					toastr.success('저장되었습니다.');					
				} else {
					toastr.warning(res.message, '', { timeOut : 5000 });
				}
			},
			complete : function() {}
		});
	});
	
	
	
	
	
	
	
	//변경&저장할 값 담아주는 부분(신규 파레트 추가, 박스 추가)
	function createBarcodeNo() {
		boxNoList = new Array();
		var idx = 0;
		
		$('#goodsProductInfoTable tbody tr').each(function() {
			var boxNo		= $(this).find('td').eq(3).html();
			var goodsInDate	= $("#chooseDate").val().replace(/-/g, '');
			
			var customerLotNo = $(this).find('td').eq(6).text() +"/"+ $(this).find('td').eq(7).text() +"/"+ $(this).find('td').eq(8).text();
			
			var rowData = new Object();
			rowData.menuAuth	= menuAuth;
			rowData.boxNo		= boxNo;
			rowData.goodsInDate	= goodsInDate;
			
			//파레트 포장 시 필요한 부분
			rowData.poSeq			= $("#poSeq").val();
			rowData.poModelNo		= $("#poModelNo").val().replaceAll('-', '');
			rowData.deliveryDate	= $("#deliveryDate").val();
			rowData.goodsCd			= $("#goodsCd").val();
			rowData.poGroup			= $('#poGroup').val();
			rowData.addPallet		= $('#addPallet').prop('checked');
			rowData.userOutputCnt	= removeCommas($(this).find('td').eq(4).html()).replace(/,/g, '');
			rowData.packCnt			= removeCommas($(this).find('td').eq(5).html()).replace(/,/g, '');
			rowData.customerLotNo	= customerLotNo;
			
			boxNoList.push(rowData);
		});
		//console.log(boxNoList);
		return idx;
	}
	
	//변경&저장할 값 담아주는 부분(완공 상태)
	function createBoxNo() {
		
		boxNoList	= new Array();
		
		$('#palletDtlTable tbody tr').each(function() {
			var boxNo1			= $(this).find('td').eq(2).html();
			var completeYn1		= $('input[name="completeYn"]:checked').val();

			var rowData = new Object();
			rowData.menuAuth			= menuAuth;
			rowData.boxNo1				= boxNo1;
			rowData.poSeq				= poSeq;
			rowData.poGroup				= poGroup;
			rowData.completeYn1			= completeYn1;
			rowData.locationCd			= null;
			rowData.locationInputDate	= null;
			
			boxNoList.push(rowData);
		});
		
		return true;
	}
	
	
	//변경&저장할 값 담아주는 부분(창고지정)
	function createBoxNo2() {
		boxNoList	= new Array();
		
		$('#palletDtlTable tbody tr').each(function() {
			var boxNo1			= $(this).find('td').eq(2).html();
			var locationCd		= $('#location option:selected').val();

			var rowData = new Object();
			rowData.menuAuth			= menuAuth;
			rowData.boxNo1				= boxNo1;
			rowData.poSeq				= poSeq;
			rowData.poGroup				= poGroup;
			rowData.completeYn1			= null;
			rowData.locationCd			= locationCd;
			rowData.locationInputDate	= $('#locationInputDate').val().replace(/-/g,'');
			
			rowData.logicOrder	= "";
			
			boxNoList.push(rowData);
		});
		
		return true;
	}
	
	
	//중복 예외처리 사용예정
	function compareBarcodeNo(boxNo) {
		var result = true;
		$('#goodsProductInfoTable tbody tr').each(function() {
			var tboxNo = $(this).find('td').eq(3).html();
			if (boxNo == tboxNo) {
				result = false;
				return result;
			}
		});
		return result;
	}
	
	
	let dealCorpCd;
	//PO Number 조회 팝업 시작
	let poPopUpTable;
	function selectPoCode(funDealCorpCd) {
		dealCorpCd = funDealCorpCd;
		if (poPopUpTable == null || poPopUpTable == undefined) {
			// 목록
			poPopUpTable = $('#poPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				ajax : {
					url : '<c:url value="/bs/purchaseOrderDataList"/>',
					type : 'GET',
					data : {
						'menuAuth'		: menuAuth,
						'dealCorpCd'	: function(){ return dealCorpCd;},
					},
				},
				rowId : 'poSeq',
				columns : [
					{
						data : 'deliveryDate',
						render : function(data, type, row) {
							return moment(data).format('YYYY-MM-DD');
						}
					},
					{ data : 'poNo'			},
					{ data : 'goodsNm'		},
					{ data : 'poQty'		},
					{ data : 'remainQty'	},
					{ data : 'poCode'		},
					{ data : 'dealCorpNm'		},
				],
				columnDefs : [
					{ targets : [ 0, 1, 2, 5, 6 ], className : "text-center" },
					{ targets : [ 3, 4 ], className : 'text-right-td' },
					{ targets : [ 3, 4 ], render : $.fn.dataTable.render.number(',') },
				],
				order : [ [ 0, 'desc' ] ]
			});
			
			$('#poPopUpTable tbody').on('click', 'tr', function() {
				var data = poPopUpTable.row(this).data();
				if (data.remainQty == 0) {
					toastr.warning("미출고수량이 0인 PO는 선택 하실 수 없습니다!")
				} else {
					
					$('#poSeq').val(data.poSeq);
					$('#poModelNo').val(data.modelNo);
					$('#poNo').val(data.poNo);
					$('#dealCorpCd').val(data.dealCorpCd);
					$('#deliveryDate').val(data.deliveryDate);
					$('#poGubunCd').val(data.poGubunCd);
					$('#goodsCd').val(data.goodsCd);
					$('#remainQty').text(addCommas(data.remainQty));
					$('#poPopUpModal').modal('hide');
					$('#boxNo').focus();
					exceptBoxNo = 'empty';
				}
			});
		} else {
			$('#poPopUpTable').DataTable().ajax.reload();
		}

		$('#poPopUpModal').modal('show');
	}
	//구매주문관리조회 팝업 종료
	
	//테이블 행  다시 잡아주기 sudel(palletTable.row('.selected').id());
	function sudel( palletRowId ) {
		
		let mainScrollCatch = $($('.dataTables_scrollBody')[0]).scrollTop();
		
		$('#palletTable').DataTable().ajax.reload(function(){
			if( palletRowId != null ) {
				$('#'+palletRowId).addClass('selected');
				$('#'+palletRowId).click();
			}
			palletTable.columns.adjust();
			$($('.dataTables_scrollBody')[0]).scrollTop(mainScrollCatch);
			$("#checkAll").prop("checked", false);
		});
	}
	
	
	
	
	
	
	
	
	
	
	
	
	//라벨 출력 버튼 클릭 시
    $('#btnPrint').on('click',function(){
		if(!$('#palletTable tbody tr').hasClass('selected')){
			toastr.warning('출력할 행을 선택해주세요.');
			return false;
		}
		
		let statusData = palletTable.rows('.selected').data()[0];
		
		if(statusData.goodsStatus == "004" || statusData.goodsStatus == "003"){
			toastr.warning('제품입고,점검대기 상태만 출력 가능합니다.');
			return false;
		}
		
		let data = palletTable.row('.selected').data();
		var array		= new Array();
		var printArr	= new Array();
		
		var poCount		= data.poGroup.substring((data.poGroup.length-2), data.poGroup.length);

		//고객사
		array.push(data.dealCorpNm);
		//납기일
		array.push(moment(data.deliveryDate).format('YYYY-MM-DD'));
		//모델명
		array.push(data.goodsNm);
		//palletNo(출력용)
		
		if( data.poCode.replaceAll('-','') == data.poGroup.substring(0, data.poCode.replaceAll('-','').length) ) {
			array.push(data.poGroup);
		} else {
			array.push(data.poCode.replaceAll('-', '') + data.deliveryDate + poCount);
		}
		
		//박스 수량
		//array.push(addCommas(data.boxCount));
		//파레트 순번
		array.push(parseInt(poCount));
		//파레트 수량
		array.push(addCommas(data.palletQty));
		//출하 총 수량
		array.push(addCommas(data.outputCnt));
		//array.push(data.completeYn=='Y' ? '완공' : '미료');
		//바코드 용
		array.push(data.poGroup);
		array.push("포장");
					
		printArr.push(array);
		
		labelPrint(printArr,1);

		$.ajax({
			url : '<c:url value="/io/productShipmentPrint_iosc0170_F3"/>',
			type : 'POST',
			data : {
				'poGroup' : poGroup,
				'poSeq'   : poSeq,
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					// 보기
					//toastr.success("출력되었습니다.");
					sudel(palletTable.row('.selected').id());
				} else {
					toastr.error(res.message);
				}
			},
		}); 
    });
	

	//라벨 출력 버튼 클릭 시
    $('#btnWaitPrint').on('click',function(){
		if(!$('#palletTable tbody tr').hasClass('selected')){
			toastr.warning('출력할 행을 선택해주세요.');
			return false;
		}
		
		let statusData = palletTable.rows('.selected').data()[0];
		
		if(statusData.goodsStatus != "004"){
			toastr.warning('출하대기인 상태만 출력 가능합니다.');
			return false;
		}
		
		let data = palletTable.row('.selected').data();
		var array		= new Array();
		var printArr	= new Array();
		
		var poCount		= data.poGroup.substring((data.poGroup.length-2), data.poGroup.length);

		//고객사
		array.push(data.dealCorpNm);
		//납기일
		array.push(moment(data.deliveryDate).format('YYYY-MM-DD'));
		//모델명
		array.push(data.goodsNm);
		//palletNo(출력용)
		
		if( data.poCode.replaceAll('-','') == data.poGroup.substring(0, data.poCode.replaceAll('-','').length) ) {
			array.push(data.poGroup);
		} else {
			array.push(data.poCode.replaceAll('-', '') + data.deliveryDate + poCount);
		}
		
		//박스 수량
		//array.push(addCommas(data.boxCount));
		//파레트 순번
		array.push(parseInt(poCount));
		//파레트 수량
		array.push(addCommas(data.palletQty));
		//출하 총 수량
		array.push(addCommas(data.outputCnt));
		//array.push(data.completeYn=='Y' ? '완공' : '미료');
		//바코드 용
		array.push(data.poGroup);
		array.push("출하대기");
					
		printArr.push(array);
		
		labelPrint(printArr,1);

		$.ajax({
			url : '<c:url value="/io/productShipmentPrint_iosc0170_F3"/>',
			type : 'POST',
			data : {
				'poGroup' : poGroup,
				'poSeq'   : poSeq,
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					// 보기
					//toastr.success("출력되었습니다.");
					sudel(palletTable.row('.selected').id());
				} else {
					toastr.error(res.message);
				}
			},
		}); 
    });
    
    
	//Do printing...
	function labelPrint(printList, count) {
		printLalCnt = 1;		
		printCnt	= 1;
		
		sendJson(printList);
	}
	
	function sendJson(printList) {
		var obj = {
			printCnt 	: printCnt,
            printLalCnt : printLalCnt,
            data 		: printList,
            paperSize 	: "pallet",
            printOrder 	: 1,
            company 	: "SLD",
            printType 	: "E",
            printNo 	: "1",
            reseverd6 	: "",
            reseverd7 	: ""
		};
		var send = JSON.stringify(obj);
		//console.log(send);
		sendMessage(send)
	}
	
	
	//파레트 삭제 버튼 클릭 시
	$('#btnPalletDelete').on('click', function() {
		if(!$('#palletTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 행을 선택해주세요.');
			return false;
		}

		if($('#palletTable').DataTable().row($('tr.selected')).data().goodsStatus == '003'){
			toastr.warning('출고된 파레트 입니다.<br>출하취소 후 진행해주세요.');
			return false;
		}
		
		$('#modalGubun').val("001");
		$('#checkAdminPopUpModal').modal('show');
		
		//$('#palletDeleteCheckPopUpModal').modal('show');
	});
	
	//모달 삭제 확인 버튼 클릭 시
	$('#btnModalPalletDelete').on('click', function(){
		if(!$('#palletTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 행을 선택해주세요.');
			return false;
		}
		
		//삭제
		$.ajax({
			url : '<c:url value="/io/palletDelete_F3"/>',
			type : 'POST',
			data : {
				'poSeq'   			: function() { return poSeq;		},
				'poGroup' 			: function() { return poGroup;		},
				'outputQty'  		: function() { return totalDtlCnt;	},
				'goodsCd'			: function() { return orgGoodsCd;	},	
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					
					poSeq	= null;
					poGroup	= null;
					$('#palletTable').DataTable().ajax.reload(function(){
						palletTable.columns.adjust();
					});
					$('#palletDtlTable').DataTable().ajax.reload(function(){
						palletTable.columns.adjust();
					});
					$('#palletDeleteCheckPopUpModal').modal('hide');
					
					toastr.success("삭제되었습니다.");
				} else {
					toastr.error(res.message);
				}
			},
		});
		//삭제
	});
	
	
	//박스 삭제 버튼 클릭 시
	$('#btnBoxDelete').on('click', function(){
		
		if( $('input:checkbox[name=chk]:checked').length == 0){
			toastr.warning('삭제할 체크박스를 선택해주세요.');
			return false;
		}
		if( $('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length ){
			toastr.warning('전체 삭제할 경우 파레트 삭제로 진행해주세요.');
			return false;
		}

		$('#modalGubun').val("003");
		$('#checkAdminPopUpModal').modal('show');
		//$('#boxDeleteCheckPopUpModal').modal('show');
	});

	//박스삭제모달 삭제버튼
	$('#btnModalBoxDelete').on('click',function(){

    	$('#my-spinner').show();

    	var delBoxList = new Array();

    	var nowDateTime = getTodayDateTime();

    	$('#palletDtlTable').DataTable().data().each(function(item, index){
			var tIdx = index;

			var chkTd = $('#palletDtlTable tbody tr').eq(tIdx).eq(0).find('td').children();

			if(chkTd.is(':checked')){
				var rowData = new Object();

				rowData.poSeq = poSeq;
				rowData.poGroup = poGroup;
				rowData.returnBoxNo = $('#palletDtlTable').DataTable().row(chkTd[0].value).data().boxNo;
				rowData.goodsStatus = $('#palletDtlTable').DataTable().row(chkTd[0].value).data().goodsStatus;
				rowData.faultyStatusDate = nowDateTime;
				rowData.faultyStatus = '011';
				rowData.disposeGubun = $('#palletDtlTable').DataTable().row(chkTd[0].value).data().disposeGubun;

				delBoxList.push(rowData);
			}
       	});

    	$.ajax({
			url : '<c:url value="/io/boxReturn_F3"/>',
			type : 'POST',
			datatype : 'json',
			data : JSON.stringify(delBoxList),
			contentType : "application/json; charset=UTF-8",
			async: false,
			success : function(res) {
				let data = res.result;
				if (data == "ok") {
					toastr.success('삭제 되었습니다.');
				} else if (data == "error") {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
				$('#palletTable').DataTable().ajax.reload();
				$('#palletDtlTable').DataTable().ajax.reload();
				$('#boxDeleteCheckPopUpModal').modal('hide');
				sudel(selRowId);
			}
		});
	});

	//박스삭제모달 삭제버튼
	$('#btnDisMove').on('click',function(){

		if( $('input:checkbox[name=chk]:checked').length == 0){
			toastr.warning('폐기이동할 체크박스를 선택해주세요.');
			return false;
		}
		if( $('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length ){
			toastr.warning('전체 폐기이동할 경우 파레트 삭제로 진행해주세요.');
			return false;
		}
		$('#modalGubun').val("006");
		$('#checkAdminPopUpModal').modal('show');
	});
    	
	$('#btnModalBoxDispose').on('click',function(){
		$('#my-spinner').show();
		var delBoxList = new Array();
        
    	var nowDateTime = getTodayDateTime();
        
    	$('#palletDtlTable').DataTable().data().each(function(item, index){
			var tIdx = index;
        
			var chkTd = $('#palletDtlTable tbody tr').eq(tIdx).eq(0).find('td').children();
        
			if(chkTd.is(':checked')){
				var rowData = new Object();
        
				rowData.poSeq = poSeq;
				rowData.poGroup = poGroup;
				rowData.returnBoxNo = $('#palletDtlTable').DataTable().row(chkTd[0].value).data().boxNo;
				rowData.goodsStatus = $('#palletDtlTable').DataTable().row(chkTd[0].value).data().goodsStatus;
				rowData.faultyStatusDate = nowDateTime;
				rowData.faultyStatus = '014';
				rowData.disposeGubun = $('#palletDtlTable').DataTable().row(chkTd[0].value).data().disposeGubun;
				rowData.dtlCount = $('#palletDtlTable').DataTable().data().count();
				delBoxList.push(rowData);
			}
       	});
        
    	$.ajax({
			url : '<c:url value="/io/boxDispose_F3"/>',
			type : 'POST',
			datatype : 'json',
			data : JSON.stringify(delBoxList),
			contentType : "application/json; charset=UTF-8",
			async: false,
			success : function(res) {
				let data = res.result;
				if (data == "ok") {
					toastr.success('폐기 되었습니다.');
				} else if (data == "error") {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
				$('#palletTable').DataTable().ajax.reload();
				$('#palletDtlTable').DataTable().ajax.reload();
				$('#boxDisposeCheckPopUpModal').modal('hide');
				sudel(selRowId);
			}
		});
	});
		
	
 	// 출하 취소 클릭
    $('#btnCancel').on('click', function() {
    	$('#modalGubun').val("002");
    	$('#checkAdminPopUpModal').modal('show');
    	//$('#cancelCheckPopupModal').modal('show');
    });

 	// 출하 취소 처리
    $('#btnCancelCheck').on('click', function(){

    	$('#my-spinner').show();

		var cancelList = new Array();

		var rowData = new Object();

		rowData.poSeq = poSeq;
		rowData.poGroup = poGroup;
		rowData.outputQty = totalDtlCnt;
		rowData.dtlCount = $('#palletDtlTable').DataTable().data().count();

		cancelList.push(rowData);
		
        $.ajax({
            url: '<c:url value="/io/palletOutputCancel_F3"/>',
            type: 'POST',
            datatype : 'json',
			data : JSON.stringify(cancelList),
			contentType : "application/json; charset=UTF-8",
			async: false,
            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
            },
            success: function (res) {
                let data = res.data;
                if ( res.result == "ok" ){
                    $('#btnCancel').attr('disabled', true);
                    toastr.success("출하가 취소되었습니다.");
                } else if ( res.reuslt == "fail" ){
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
                $('#btnCancel').attr('disabled', true);
				$('#btnReturn').attr('disabled', true);
                $('#palletTable').DataTable().ajax.reload( function () {});
                $('#palletDtlTable').DataTable().ajax.reload( function () {});
            },
            complete:function(){
            	$('#my-spinner').hide();
            	sudel(selRowId);
            }
        });
        
    });
	
	//전체 체크 박스 클릭 시
	$('#checkAll').on('click', function() {
		if($("#checkAll").prop("checked")) {
			$("input[name=chk]").prop("checked",true);
		} else {
			$("input[name=chk]").prop("checked",false);
		}
	});

    //checkBox디테일 설정
    $(document).on('click','input[name=chk]',function(e) {
    	if($('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length) {
    		$("#checkAll").prop("checked", true);
        } else {
        	$("#checkAll").prop("checked", false);
		}
	});
    
    //수정 버튼 클릭 시
    $('#btnEdit').on('click', function(){
		if( $('input:checkbox[name=chk]:checked').length == 0){
			toastr.warning('수정할 체크박스를 한개 씩 선택해주세요.');
			return false;
		}
	   	
		if( 1 < $('input:checkbox[name=chk]:checked').length){
			toastr.warning('수정은 체크박스를 한 개 만 선택해주세요.');
			return false;
		}
		
		$('#customerLotNoEdit').val("");
		$('#customerLotNo2Edit').val("");
		$('#customerLotNo3Edit').val("");
		$('#customerLotNoEdit').attr('disabled', false);
		$('#customerLotNo2Edit').attr('disabled', true);
		$('#customerLotNo3Edit').attr('disabled', true);
		
		let text = $( $( $('#palletDtlTable tbody tr').find('input:checkbox[name=chk]:checked')[0].parentNode.parentNode ).find('td')[2] ).html().replaceAll('<br>', '/');
		let text2 = $( $( $('#palletDtlTable tbody tr').find('input:checkbox[name=chk]:checked')[0].parentNode.parentNode ).find('td')[3] ).html().replaceAll('<br>', '/');
		
		$('#nowCustomerLotNoLabel').text("현재 고객사 번호 : " + text);
		$('#nowBoxNoLabel').text("현재 박스 번호 : " + text2);
		$('#customerLotNoEditPopUpModal').modal('show');
		
    });
    
    //모달 보여지고 나서
    $('#customerLotNoEditPopUpModal').on('shown.bs.modal', function(e){
		$('#customerLotNoEdit').focus();
	});
    
	//고객사 바코드1 스캔시
	$("#customerLotNoEdit").keypress(function(e) {
		if (e.which == 13) {
			
			let poModelNo = palletTable.rows('.selected').data()[0].modelNo.replaceAll('-','');
			
			if( poModelNo.indexOf('/') != "-1" ) {
				poModelNo = poModelNo.split('/');
				
				if( poModelNo[0].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( poModelNo[1].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo[0].length) != poModelNo[0] && $(this).val().substr(0, poModelNo[1].length) != poModelNo[1] ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
			} else {
				if( poModelNo.length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo.length) != poModelNo ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}				
			}
			
			customerLotNo = $('#customerLotNoEdit').val();
			$('#customerLotNoEdit').attr('disabled', true);
			$('#customerLotNo2Edit').attr('disabled', false);
			$('#customerLotNo3Edit').attr('disabled', true);
			
			$('#customerLotNo2Edit').focus();
			toastr.success('고객사 LotNo2를 입력 해주세요.');
		}
	});
	
	//고객사 바코드2 스캔시
	$("#customerLotNo2Edit").keypress(function(e) {
		if (e.which == 13) {
			
			let poModelNo = palletTable.rows('.selected').data()[0].modelNo.replaceAll('-','');
			
			if( poModelNo.indexOf('/') != "-1" ) {
				poModelNo = poModelNo.split('/');
				
				if( poModelNo[0].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( poModelNo[1].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo[0].length) != poModelNo[0] && $(this).val().substr(0, poModelNo[1].length) != poModelNo[1] ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
			} else {
				if( poModelNo.length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo.length) != poModelNo ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}				
			}
			
			//같은 고객사 입력 시
			if( $('#customerLotNoEdit').val() == $('#customerLotNo2Edit').val() ) {
				toastr.warning("첫 번째 고객사 번호와 같은 고객사 번호입니다.");
				return false;
			}
			
			customerLotNo2 = $('#customerLotNo2Edit').val();
			$('#customerLotNoEdit').attr('disabled', true);
			$('#customerLotNo2Edit').attr('disabled', true);
			$('#customerLotNo3Edit').attr('disabled', false);
			
			$('#customerLotNo3Edit').focus();
			toastr.success('고객사 LotNo3를 입력 해주세요.');
			
			//$('#btnModalCustomerLotNoChange').focus();
		}
	});
	
	//고객사 바코드3 스캔시
	$("#customerLotNo3Edit").keypress(function(e) {
		if (e.which == 13) {
			
			let poModelNo = palletTable.rows('.selected').data()[0].modelNo.replaceAll('-','');
			
			if( poModelNo.indexOf('/') != "-1" ) {
				poModelNo = poModelNo.split('/');
				
				if( poModelNo[0].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( poModelNo[1].length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo[0].length) != poModelNo[0] && $(this).val().substr(0, poModelNo[1].length) != poModelNo[1] ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
			} else {
				if( poModelNo.length > $(this).val().length ) { 
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}
				
				if( $(this).val().substr(0, poModelNo.length) != poModelNo ) {
					toastr.warning("해당 제품에 맞는 고객사 번호를 입력해주세요.");
					return false;
				}				
			}
			
			//같은 고객사 입력 시
			if( $('#customerLotNoEdit').val() == $('#customerLotNo3Edit').val() ) {
				toastr.warning("첫 번째 고객사 번호와 같은 고객사 번호입니다.");
				return false;
			}
			//같은 고객사 입력 시
			if( $('#customerLotNo2Edit').val() == $('#customerLotNo3Edit').val() ) {
				toastr.warning("두 번째 고객사 번호와 같은 고객사 번호입니다.");
				return false;
			}
			
			customerLotNo3 = $('#customerLotNo3Edit').val();
			$('#btnModalCustomerLotNoChange').focus();
		}
	});
    
	
    //모달 고객사LotNo 변경 버튼 클릭 시
    $('#btnModalCustomerLotNoChange').on('click', function(){
    	if( $('input:checkbox[name=chk]:checked').length == 0){
			toastr.warning('수정할 체크박스를 한개 씩 선택해주세요.');
			return false;
		}
	   	
		if( 1 < $('input:checkbox[name=chk]:checked').length){
			toastr.warning('수정은 체크박스를 한 개 만 선택해주세요.');
			return false;
		}
		
		let customerLotNoVal;
		customerLotNoVal = $('#customerLotNoEdit').val() == "" ? "" : $('#customerLotNoEdit').val() + "/" + $('#customerLotNo2Edit').val() + "/" + $('#customerLotNo3Edit').val(); 
		
		//고객사 번호 수정
		$.ajax({
			url : '<c:url value="/io/customerLotNoUpdate_F3"/>',
			type : 'POST',
			data : {
				'boxNo'   			: function() { return $('#nowBoxNoLabel').text().replace('현재 박스 번호 : ', '');		},
				'customerLotNo'		: function() { return customerLotNoVal;	},
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					
					$('#palletDtlTable').DataTable().ajax.reload(function(){
						palletDtlTable.columns.adjust();
					});
					$('#customerLotNoEditPopUpModal').modal('hide'); 
					$("#checkAll").prop("checked", false);
					toastr.success("변경되었습니다.");
				} else {
					toastr.error(res.message);
				}
			},
		});
		//고객사 번호 수정
    });

    let returnBoxNo		= null;

    //반품 클릭 시
    $('#btnReturn').on('click', function(){
    	if($('input:checkbox[name=chk]:checked').length == 0){
			toastr.warning('반품할 박스를 선택해주세요.');
			return false;
		}
    	if( $('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length ){
			toastr.warning('전체 반품인 경우,<br> 출하취소 후 파레트 삭제로 진행해주세요.');
			return false;
		}
    	
    	$('#modalGubun').val("004");
    	$('#checkAdminPopUpModal').modal('show');
    	//$('#boxReturnCheckPopUpModal').modal('show');
    });

    //반품확인 모달 반품 클릭 시
    $('#btnModalBoxReturn').on('click', function(){

    	$('#my-spinner').show();

    	var nowDateTime = getTodayDateTime();

    	var returnBoxList = new Array();

    	$('#palletDtlTable').DataTable().data().each(function(item, index){
			var tIdx = index;

			var chkTd = $('#palletDtlTable tbody tr').eq(tIdx).eq(0).find('td').children();

			if(chkTd.is(':checked')){
				var rowData = new Object();

				rowData.poSeq = poSeq;
				rowData.poGroup = poGroup;
				rowData.returnBoxNo = $('#palletDtlTable').DataTable().row(chkTd[0].value).data().boxNo;
				rowData.goodsStatus = $('#palletDtlTable').DataTable().row(chkTd[0].value).data().goodsStatus;
				rowData.faultyStatusDate = nowDateTime;
				rowData.faultyStatus = '003';
				rowData.dtlCount = $('#palletDtlTable').DataTable().data().count();

				returnBoxList.push(rowData);
			}
       	});

    	$.ajax({
			url : '<c:url value="/io/boxReturn_F3"/>',
			type : 'POST',
			datatype : 'json',
			data : JSON.stringify(returnBoxList),
			contentType : "application/json; charset=UTF-8",
			async: false,
			success : function(res) {
				let data = res.result;
				if (data == "ok") {
					toastr.success('반품처리 되었습니다.');
				} else if (data == "error") {
					toastr.error(res.message);
				}
				$('#boxReturnCheckPopUpModal').modal('hide');
				$('#my-spinner').hide();
				$('#palletTable').DataTable().ajax.reload();
				$('#palletDtlTable').DataTable().ajax.reload();
			},
			complete : function(){
				sudel(selRowId);
			}
		});
		
    });

	let switchingBoxNo = '';
	let switchYn = 0;
	
    //교체 버튼 클릭 시
    $('#btnSwitching').on('click', function(){
    	if($('input:checkbox[name=chk]:checked').length == 0){
			toastr.warning('교체할 박스를 선택해주세요.');
			return false;
		}
        
		if($('input[type=checkbox][name=chk]:checked').length > 1){
			toastr.warning('교체는 하나씩 해주세요.');
			return false;
		}
		
		switchingBoxNo = $('#palletDtlTable').DataTable().row($('input[type=checkbox][name=chk]:checked').val()).data().boxNo;
		switchYn = 0;

		$('#afterBoxNo').val('');
		$('#beforeBoxNo').text(switchingBoxNo);
		
		$('#modalGubun').val("005");
		$('#checkAdminPopUpModal').modal('show');
		//$('#boxChangeModal').modal('show');
    });

    $('#boxChangeModal').on('shown.bs.modal', function(e){
		$('#afterBoxNo').focus();
	});

    //투입될 박스
    $("#afterBoxNo").keypress(function (e) {

		//엔터키
    	if (e.which == 13){
	        if( $('#afterBoxNo').val() == "" ) {
	            toastr.warning('바코드를 먼저 스캔해주세요!');
	            return false;
	        }
	        if ($('#afterBoxNo').val().trim().length != "18") {
				toastr.warning('박스 바코드가 아닙니다. 확인해주세요');
				$('#afterBoxNo').focus();
				return false;
			}
	        
        	//한타 영타로 변환
	    	var engToKor = korTypeToEng($('#afterBoxNo').val());
	    	//변환대 영타가 소문자여서 대문자로 변환 후 비교
	    	$('#afterBoxNo').val(engToKor.toUpperCase());
	    	
	  	  	$.ajax({
	            url: '<c:url value="/io/goodsProductInfoRead"/>',
	            type: 'GET',
	            async: false,
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
	            	'boxNo'			: 		$("#afterBoxNo").val(),
	            	'goodsCd'		:		orgGoodsCd,
	            },
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						$('#afterBoxNo').attr('disabled', true);
						$('#btnBoxChangEdit').removeClass('d-none');
						toastr.success("추가되었습니다.");
						
						switchYn++;
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
						switchYn = 0;
					}
				},
				complete:function(){}
			});
        }
	});

    $('#btnBoxChangEdit').on('click',function(){
    	$('#afterBoxNo').attr('disabled', false);
    	$('#afterBoxNo').val('');
    	switchYn = 0;
   	});

	//모달 교체 버튼 클릭 시
	$('#btnBoxNoChange').on('click', function(){
		if(switchYn == 0){
			toastr.warning('교체 후(BoxNo)를 확인해주세요.');
			return false;
		}

		var nowDateTime = getTodayDateTime();

		var switchingBoxList = new Array();
		var rowData = new Object();
		
		let data = palletTable.rows('.selected').data()[0];

		rowData.poSeq = poSeq;
		rowData.poGroup = poGroup;
		rowData.switchingBoxNo = switchingBoxNo;
		rowData.goodsStatus = $('#palletDtlTable').DataTable().row($('input[type=checkbox][name=chk]:checked').val()).data().goodsStatus;
		rowData.faultyStatusDate = nowDateTime;
		rowData.newBoxNo = $('#afterBoxNo').val();
		rowData.faultyStatus = '012';
		rowData.locationInputDate = data.locationInputDate;

		switchingBoxList.push(rowData);
		
		$.ajax({
			url : '<c:url value="/io/boxSwitch_F3"/>',
			type : 'POST',
			datatype : 'json',
			data : JSON.stringify(switchingBoxList),
			contentType : "application/json; charset=UTF-8",
			async: false,
			success : function(res) {
				let data = res.result;
				if (data == "ok") {
					toastr.success('교체되었습니다.');
				} else if (data == "error") {
					toastr.error(res.message);
				}
				sudel(selRowId);
				$('#my-spinner').hide();
				//$('#palletDtlTable').DataTable().ajax.reload();
			},
			complete: function(){
				$('#afterBoxNo').attr('disabled', false);
				$('#btnBoxChangEdit').addClass('d-none');
				$('#boxChangeModal').modal('hide');
			},
		});
	});
	
	
	
	
	
	
	
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ작지 삭제,변경, 등록자 변경 시 계정 체크 코드 시작 ㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    $('#btnAccountCheck').on('click', function(){
		
    	if( $('#userId').val() == "" || $('#userId').val() == null ) {
            toastr.warning('아이디를 입력해 주세요!');
            $('#userId').focus();
            return false;
		}
		
		if( $('#userPassword').val() == "" || $('#userPassword').val() == null ) {
            toastr.warning('비밀번호를 입력해 주세요!');
            $('#userPassword').focus();
            return false;
		}
		
		authUserId	= $('#userId').val();
		userPw		= $('#userPassword').val();
		gubun		= '002';
		
		$('#my-spinner').show();
		
		//계정체크
		$.ajax({
			url : '<c:url value="/sm/authIdCheck"/>',
			type : 'POST',
			data : {
				'userNumber'    : function() { return userNumber;},
				'userId'        : function() { return authUserId;},
				'userPw'        : function() { return userPw;},
				'gubun'         : function() { return gubun;},
			},
			success : function(res) {
				let result = res.result;
				
				if ( result == 'ok' ) {
					toastr.success("확인되었습니다.");
					$('#userId').attr('disabled',true);
					$('#userPassword').attr('disabled',true);
					$('#btnAccountCheck').attr('disabled',true);
					$('#searcAdminUser').attr('disabled',true);
					$('#checkAdminPopUpModal').modal('hide');
					
					funModalGubun($('#modalGubun').val());
				} else if( result == 'fail' ) {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message);
				}
			},
			complete : function() {
				
				$('#my-spinner').hide();
			}
		});
		//계정체크
	});
	
	function funModalGubun(gubun) {
		//파레트 삭제: 001 출하 취소: 002 박스 삭제: 003 반품: 004 교체: 005
		if(gubun == "001"){
			$('#palletDeleteCheckPopUpModal').modal('show');
		} else if(gubun == "002"){
			$('#cancelCheckPopupModal').modal('show');
		} else if(gubun == "003"){
			$('#boxDeleteCheckPopUpModal').modal('show');
		} else if(gubun == "004"){
			$('#boxReturnCheckPopUpModal').modal('show');
		} else if(gubun == "005"){
			$('#boxChangeModal').modal('show');
		} else if(gubun == "006"){
			$('#boxDisposeCheckPopUpModal').modal('show');
		}
	}
	
	//관리자 확인 모달이 열릴 때
	$('#checkAdminPopUpModal').on('show.bs.modal', function() {
		$('#userId').val("");
		$('#userPassword').val("");
		
		$('#userId').attr('disabled',false);
		$('#userPassword').attr('disabled',false);
		$('#btnAccountCheck').attr('disabled',false);
		$('#searcAdminUser').attr('disabled',false);
	});
	
	//계정확인 사용자 조회
	let authGubunVal		= "";	//사용자 권한 코드
	let userNumber			= null;
	let userAuthPopUpTable	= null;
	function userAuthModal(gubunVal) {
		authGubunVal = gubunVal;
		if(userAuthPopUpTable == null || userAuthPopUpTable == undefined)   {
			userAuthPopUpTable = $('#userAuthPopUpTable').DataTable({
				language: lang_kor,
				lengthChange : false,
				paging: true,
				info: true,
				ordering: true,
				processing: true,
				autoWidth: false,
				pageLength: 20,
	            ajax: {
	                url: '<c:url value="/sm/userAuthDeleteList"/>',
	                type: 'GET',
	                data: {
	                	'menuAuth'	 	: 		menuAuth,
	                	'gubun'         :       function () { return authGubunVal; }
	                },
	            },
	            rowId: 'userNumber',
	            columns: [
	                { data : 'userNm'			}, 
	                { data : 'departmentNm'		}, 
	                { data : 'postNm'			}, 
	                { data : 'chargrDutyNm'		}, 
	                { data : 'teamNm'			}, 
	                { data : 'workplaceNm'		},
	            ],
	            columnDefs: [
	               { "targets": [0,1,2,3,4,5],  "className": "text-center"}
	            ],
	            //oSearch: {"sSearch": userNm},
	            order: [
	                [ 0, 'asc' ]
	            ],
			});
			
			$('#userAuthPopUpTable tbody').on('click', 'tr', function () {
				var data = userAuthPopUpTable.row( this ).data();
				
				userNumber = userAuthPopUpTable.row(this).data().userNumber;
				$('#workOrderChangeUserNm').val(data.userNm);	//사원명
	            $('#workOrderChangeUserNumber').val(data.userNumber);	//사원코드(hidden)
	            $('#userAuthPopUpWorkOrderModal').modal('hide'); 
	            $('#userId').val(data.userId);
	            $('#userId').attr('disabled',false);
	            $('#userPassword').attr('disabled',false);
	            
				$('#userAuthPopUpModal').modal('hide');
			});
			
		} else {
			//authGubunVal = gubunVal;
			$('#userAuthPopUpTable').DataTable().ajax.reload( function () {});
		}
        
    	$('#userAuthPopUpModal').modal('show');
	}
	

	function getTodayDateTime(){
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);

		var dateString = year + '-' + month  + '-' + day;
		
		var hours = ('0' + today.getHours()).slice(-2); 
		var minutes = ('0' + today.getMinutes()).slice(-2);
		var seconds = ('0' + today.getSeconds()).slice(-2); 

		var timeString = hours + ':' + minutes  + ':' + seconds;

		return dateString + " " + timeString;
	}
	
	function shiftTime(){

		//디폴트 값 지정
		var date 		= new Date(new Date().setHours(0,0,0,0));	//오늘날짜 00:00:00
		var secondDiff 	= parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		
		//날짜 표시
		//현재시간이 07:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘 날짜로 표시
		if (secondDiff >= 25200 && secondDiff <= 86399) {
			$('#chooseDate').val("${serverDateFrom}");	//생산 날짜
		}

		//현재시간이 00:00:00 ~ 06:59:59 이면 전표(생산)일자는 전 날짜로 표시
		if (secondDiff >= 0 && secondDiff <= 25199) {
			let minusOneday = new Date(new Date().setHours(0,0,0,0));
				minusOneday.setDate(minusOneday.getDate()-1);
				minusOneday = getDateType(minusOneday);
				
			$('#chooseDate').val(minusOneday);	//생산 날짜
		}
	}
	
	function getDateType(date) {
		return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
	}

	
	
	
	
	
</script>




<script>
	//웹 서버를 접속한다.
	var webSocket = new WebSocket("ws://localhost:8181");
	// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
	var messageTextArea = document.getElementById("installedPrinterName");
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		toastr.success('인쇄 서버에 연결되었습니다.')
		$('#wsStateView').text('연결됨');
		$('#wsStateView').css('color','#19FF00');
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		toastr.error('인쇄 서버가 종료되었습니다.')
		$('#wsStateView').text('연결끊김');
		$('#wsStateView').css('color','#FF0004');
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		console.log(message);
	};
	// 서버로 메시지를 전송하는 함수
	function sendMessage(cmd){
		if(webSocket.readyState == 1) {
			webSocket.send(cmd);
		} else {
			toastr.error('인쇄 서버와의 연결을 확인해주세요.');
			//webSocket = new WebSocket("ws://localhost:9998");
		}
	}
</script>

</body>
</html>
