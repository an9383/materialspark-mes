<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- ============================================================== -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">공정실적관리(POP)</a></li>
				<li class="breadcrumb-item active">생산실적라벨발행</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<!--  
           <div class="card top_sortbox p-3">
                <h6>기종</h6>
             <div class="row">
             <button class="btn btn-outline-primary btn-lg mr-2">PSEV</button>
             <button class="btn btn-outline-primary btn-lg mr-2 active">LIFT</button>
             <button class="btn btn-outline-primary btn-lg mr-2">P260</button>
             <button class="btn btn-outline-primary btn-lg mr-2">H200</button>
             <button class="btn btn-outline-primary btn-lg mr-2">E370</button>
          </div> 
            </div> -->
            
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="" style="width: 60%">
				<div class="card">
					<div class="row">
						<div class="row col-sm-9 mb-3 p-0">
							<div class="form-group input-sub col-md-1 m-0 mr-2 p-0">
								<select class="custom-select custom-select-md" style="width: 120px" id="selGoodsCd">-선택-</select>
							</div>
							<div class="form-group input-sub col-md-1 m-0 mr-2 p-0">
								<input class="form-contro touch6" type="text" id="ordDate" name="ordDate" style="width: 120px;" value="" disabled />
								<button onclick="fnPopUpCalendar(ordDate,ordDate,'yyyy-mm-dd');" class="btn btn-secondary input-sub-search" type="button" style="width:30px; height:30px;">
									<span class="oi oi-calendar" style="font-size:15px;"></span>
								</button>
							</div>
							<div class="row">
								<button type="button" class="btn btn-primary float-left touch6 mr-3" id="btnSearch">조회</button>
								<input class="form-control ml-3 mr-3 touch6 d-none" type="text" id="barcodeWorkOrdLotNo" style="width:150px;" placeholder="생산LotNo 스캔">
								<input type="hidden" class="form-control" id="workOrdNo" name="workOrdNo">
								<!-- <input type="hidden" class="form-control" id="ordLotNo" name="ordLotNo"> -->
								<input type="hidden" class="form-control" id="packOrdLotNoList" name="packOrdLotNoList">
								<input type="hidden" class="form-control" id="goodsNm" name="goodsNm">
								<input type="hidden" class="form-control" id="goodsCd" name="goodsCd">
								<input type="hidden" class="form-control" id="workOrdLotNo" name="workOrdLotNo">
								<input type="hidden" class="form-control" id="outputCnt" name="outputCnt">
								<input type="hidden" class="form-control" id="totalInspectCnt" name="totalInspectCnt">
								<input type="hidden" class="form-control" id="userOutputCnt" name="userOutputCnt">
								<input type="hidden" class="form-control" id="totalFaultyCnt" name="totalFaultyCnt">
								<input type="hidden" class="form-control" id="packUnitCnt" name="packUnitCnt">
								<input type="hidden" class="form-control" id="appearAbrfCnt" name="appearAbrfCnt">
								<input type="hidden" class="form-control" id="appearAbrsCnt" name="appearAbrsCnt">
								<input type="hidden" class="form-control" id="appearDmsCnt" name="appearDmsCnt">
							</div>
							<div class="row float-right alert-primary" style="margin-left: 20%;">
								<h5 class="p-1 mr-3 mb-0">포장수량</h5>
								<h4 class="mb-0" id="packCnt"></h4>
							</div>
						</div>
						<div class="row col-sm-3">
							<button type="button" class="btn btn-primary float-right touch6 d-none" id="btnWorkOrdLotNoLineDelete">라인삭제</button>
							<button type="button" class="btn btn-primary float-right touch6 ml-3" id="btnPackAdd">포장 대기 <span class="oi oi-arrow-right"></span></button>
						</div>
					</div>
					<div class="col-md-12" style="overflow:scroll; padding:0px; min-height:235px; max-height:235px;">
						<div class="table-responsive">
							<table id="workOrderTable" class="table table-bordered">
								<colgroup>
									<col width="5%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th style="min-width: 30px;" class="text-center">순번</th>
										<th style="min-width: 120px;" class="text-center">작지번호</th>
										<th style="min-width: 80px;" class="text-center">제품명</th>
										<th style="min-width: 120px;"class="text-center">생산LotNo</th>
										<th style="min-width: 70px;" class="text-center">생산수량</th>
										<th style="min-width: 70px;" class="text-center">검사수량</th>
										<th style="min-width: 70px;" class="text-center">양품수량</th>
										<th style="min-width: 70px;" class="text-center">불량수량</th>
										<!-- 
										<th style="min-width: 50px; max-width: 70px;" class="text-center">해외1</th>
										<th style="min-width: 50px; max-width: 70px;" class="text-center">해외2</th>
										<th style="min-width: 50px; max-width: 70px;" class="text-center">국내</th>
										 -->
									</tr>
								</thead>
							</table>
						</div>
					</div>
					<hr>
				</div>
				<div class="card" id="formBox" style="margin-bottom: 0px;">
					<div class="card-body col-sm-12 pt-0">
						<button type="button" class="btn btn-danger float-right touch6 ml-5" id="btnPackCancel">제품 복원↗</button>
						<!-- <button type="button" class="btn btn-primary float-right touch6" id="btnPackError" disabled>에러복구</button> -->
						<button type="button" class="btn btn-primary float-left touch6 mr-1" id="btnClear">선택 초기화</button>
						<%
							if(factoryCode.equals("001")) {
						%>
						<button type="button" class="btn btn-warning float-right touch6 mr-1" id="btnPrint3">스티커 인쇄2</button>
						<button type="button" class="btn btn-warning float-right touch6 mr-1" id="btnPrint">스티커 인쇄1</button>
						<%
							} else if(factoryCode.equals("002") || factoryCode.equals("003")) {
						%>
						<button type="button" class="btn btn-warning float-right touch6 mr-5" id="btnPrint3">스티커 인쇄</button>
						<%
							}
						%>
						<select class="custom-select custom-select-md ml-3 float-left" style="width:120px" id="printYn">
							<option value="N">미발행</option>
							<option value="Y">재발행</option>
						</select>
						<!-- JSPrinter
                            <div class="row float-right">
								
								<label class="checkbox">
									<input type="checkbox" id="useDefaultPrinter" />
									<strong>기본프린터로 인쇄</strong>
								</label>
								
								<div id="installedPrinters">
									<label for="installedPrinterName">인쇄 프린터:</label>
									<select class="custom-select custom-select-sm" name="installedPrinterName" id="installedPrinterName"></select>
								</div>
								&nbsp;
								<button class="btn btn-primary" id="btnPrint2">바코드 인쇄</button>
								&nbsp;
							</div>
						-->
					</div>
					<div id="scrollDiv" style="overflow:auto;">
						<div class="col-12 row p-0 table-td-center" style="overflow:scroll; padding:0px; min-height:100px; max-height:420px;">
							<div class="table-responsive col-4">
								<table id="boxNo1Table" class="table table-bordered">
									<colgroup>
										<col width="40%">
										<col width="40%">
										<col width="20%">
									</colgroup>
									<thead class="thead-light">
										<tr>
											<th>포장번호</th>
											<th>생산LotNo</th>
											<th>해외1</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<td colspan="2" style="text-align:center">합계</td>
											<td id="sum1" style="text-align: right">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<div class="table-responsive col-4">
								<table id="boxNo2Table" class="table table-bordered">
									<colgroup>
										<col width="40%">
										<col width="40%">
										<col width="20%">
									</colgroup>
									<thead class="thead-light">
										<tr>
											<th>포장번호</th>
											<th>생산LotNo</th>
											<th>해외2</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<td colspan="2" style="text-align:center">합계</td>
											<td id="sum2" style="text-align: right">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
							<div class="table-responsive col-4">
								<table id="boxNo3Table" class="table table-bordered">
									<colgroup>
										<col width="40%">
										<col width="40%">
										<col width="20%">
									</colgroup>
									<thead class="thead-light">
										<tr>
											<th>포장번호</th>
											<th>생산LotNo</th>
											<th>국내</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<td colspan="2" style="text-align:center">합계</td>
											<td id="sum3" style="text-align: right">0</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /.left-list -->
			
				<div class="col-12 num_keypad d-none" style="position: absolute; left: 106vh; right: 0; top: 28vh; bottom: 52vh;
												 width: 50vh; z-index: 30; border: 1px solid #5000ff;" id="screenKeyboard">
					<table class="table table-bordered" >                                
						<tr>
							<td id="number5" style="height:1px; width:100px;">5</td>
							<td id="number6" style="height:1px; width:100px;">6</td>
							<td id="number7" style="height:1px; width:100px;">7</td>
							<td id="number8" style="height:1px; width:100px;">8</td>
							<td id="number9" style="height:1px; width:100px;">9</td>
							<td id="backSpace" style="height:1px; width:100px;">←<br>(BS)</td>
						</tr>
						<tr>
							<td id="number0" style="height:59px; width:100px;">0</td>
							<td id="number1" style="height:59px; width:100px;">1</td>
							<td id="number2" style="height:59px; width:100px;">2</td>
							<td id="number3" style="height:59px; width:100px;">3</td>
							<td id="number4" style="height:59px; width:100px;">4</td>
							<td id="enter" style="height:59px; width:100px;">ENT</td>
						</tr>
					</table>
				</div>
			
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-70" id="myrSidenav" style="width:39%; padding-bottom:0px;">
				<div id="scrollDiv" style="overflow:auto;">
					<div class="col-12 row p-0 table-td-center">
						<!-- <button type="button" class="btn btn-danger float-right touch6 mr-1" id="btnRealPack">라벨발행</button> -->
						<div class="card-body col-sm-12 p-2">
							<div class="row">
								<div class="col-md-4">
									<button type="button" class="btn btn-primary float-left touch6" id="btnWorkOrdLotNoUnpack">←포장 대기 복원</button>
								</div>
								<div class="col-md-4">
									<input type="checkBox" class="float-right mr-5" id="btnTempPackAdd" style="width:25px;height:25px;">
									<label for="btnTempPackAdd" class="float-right ml-3" style="height:35px; font-size:20px; padding-right:5px;">포장하기</label>
								</div>
								<div class="col-md-4">
									<div id="divPackButton" class="d-none row">
										<!-- 
										<input id="ordGubun001" name="ordGubunCheck" type="radio" value="001" style="width:25px; height:25px;"><label for="ordGubun001" class="ml-1 mr-2" style="height:35px; font-size:20px;">해외1</label><br/>
										<input id="ordGubun002" name="ordGubunCheck" type="radio" value="002" style="width:25px; height:25px;"><label for="ordGubun002" class="ml-1 mr-2" style="height:35px; font-size:20px;">해외2</label><br/>
										<input id="ordGubun003" name="ordGubunCheck" type="radio" value="003" style="width:25px; height:25px;"><label for="ordGubun003" class="ml-1 mr-2" style="height:35px; font-size:20px;">국내</label><br/>
										 -->
										<button type="button" class="btn btn-primary float-right ml-5 touch6" id="btnRealPackAdd">포장 실행↙</button>
									</div>		
								</div>
							</div>
						</div>
						
						<div class="table-responsive col-12" style="min-height:300px;">
							<table id="unBoxNoTotalTable" class="table table-bordered">
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<!-- <th>순번</th> -->
										<th>제품명</th>
										<th>생산LotNo</th>
										<th>총 수량</th>
										<th>잔여수량</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="2" style="text-align:center">합계</td>
										<td id="unBoxAdmPackSum" style="text-align: right">0</td>
										<td id="unBoxAdmRemainSum" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
						
						<div id="divUnBoxNoTotalTableDtl" class="table-responsive col-12" style="min-height:300px;">
							<table id="unBoxNoTotalTableDtl" class="table table-bordered">
								<colgroup>
									<%-- <col width="10%"> --%>
									<col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<!-- <th>포장번호</th> -->
										<!-- <th>순번</th> -->
										<th>생산LotNo</th>
										<th>포장 대기전표일자</th>
										<th>총 수량</th>
										<th>잔여수량</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="2" style="text-align:center">합계</td>
										<td id="unBoxDtlSum" style="text-align: right">0</td>
										<td id="unBoxDtlRemainSum" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
						
						<div id="divPackWorkOrdLotNoList" class="table-responsive col-12 d-none" style="min-height:300px;">
							<div class="ml-3 row float-center alert-primary" style="margin-bottom: 5px;">
								<h5 class="p-1 mr-3 mb-0">완제품수량</h5>
								<h4 class="mb-0 mr-4" id="countPackBoxNo">-</h4>
								<h5 class="p-1 mr-3 mb-0">잔여수량</h5>
								<h4 class="mb-0 mr-4" id="countPackRemainCnt">-</h4>
							</div>
							
							<table class="table table-bordered">
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="30%">
									<col width="30%">
								</colgroup>
								<tr>
									<th class="touch6"></th>
									<th class="touch6">해외1</th>
									<th class="touch6">해외2</th>
									<th class="touch6">국내</th>
								</tr>
								<tr>
									<th class="touch6">완제품 수량</th>
									<td><input type="text" class="form-control number-float0 text-right touch6" max="999" min="0" id="ordGubun1" value="0"></td>
									<td><input type="text" class="form-control number-float0 text-right touch6" max="999" min="0" id="ordGubun2" value="0"></td>
									<td><input type="text" class="form-control number-float0 text-right touch6" max="999" min="0" id="ordGubun3" value="0"></td>
								</tr>
							</table>
							
							<table id="packWorkOrdLotNoList" class="table table-bordered " style="margin-top: 6px;">
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>순번</th>
										<th>제품명_포장</th>
										<th>생산LotNo</th>
										<th>총 수량</th>
										<th>잔여수량</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						
						<%-- 
						<div class="table-responsive col-12" style="min-height:300px;">
							<table id="unBoxNo1Table" class="table table-bordered">
								<colgroup>
									<col width="30%">
									<col width="40%">
									<col width="30%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<!-- <th>포장번호</th> -->
										<th>제품명</th>
										<th>생산LotNo</th>
										<th>포장 대기수량(해외2)</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="2" style="text-align:center">합계</td>
										<td id="unBoxSum1" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<div class="table-responsive col-12" style="min-height:300px;">
							<table id="unBoxNo2Table" class="table table-bordered">
								<colgroup>
									<col width="30%">
									<col width="40%">
									<col width="30%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<!-- <th>포장번호</th> -->
										<th>제품명</th>
										<th>생산LotNo</th>
										<th>포장 대기수량(해외2)</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="2" style="text-align:center">합계</td>
										<td id="unBoxSum2" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<div class="table-responsive col-12" style="min-height:300px;">
							<table id="unBoxNo3Table" class="table table-bordered">
								<colgroup>
									<col width="30%">
									<col width="40%">
									<col width="30%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<!-- <th>포장번호</th> -->
										<th>제품명</th>
										<th>생산LotNo</th>
										<th>포장 대기수량(국내)</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="2" style="text-align:center">합계</td>
										<td id="unBoxSum3" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
						 --%>
					</div>
				</div>
			</div>
			<!--// 등록, 수정 -->
		</div>
		<!-- .right-sidebar -->
	</div>
	<!-- /.row -->
</div>
<!-- / #main  -->
</div>
<!-- /.page-wrapper -->
</div>
<!-- /.app -->
<!-- 포장 확인 모달 시작-->
<div class="modal fade" id="packCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">포장 대기 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>포장 대기 상태로 변경하시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnPackAddCheck" data-dismiss="modal" style="min-width: 70px;">포장</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnPackAddCheckCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 포장 확인 모달 종료 -->
<!-- 복원 확인 모달 시작-->
<div class="modal fade " id="packCancelCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="packCancelCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:600px;">
		<div class="modal-content">
			<div class="modal-header">
				<div class="row">
					<h5 class="modal-title mr-1">포장번호 복원대상 확인</h5>
					<!-- 
					<h5 class="modal-title mr-1" id="unpublishWorkOrd1"></h5>
					<h5 class="modal-title" id="unpublishWorkOrd2"></h5>
					-->
				</div>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 id="goodsNmCheck"></h6>
				<p style="margin-bottom: 0px;">*선택하신 포장번호 정보가 삭제되며 포장 수량만큼 각 생산LotNo로 복구됩니다!</p>
				<p>*선택하신 포장번호의 이력들도 삭제됩니다!</p>
				<div style="max-height:420px; overflow:scroll;">
					<table id="checkUnPackListTable" class="table table-bordered">
						<colgroup>
							<col width="20%">
							<col width="25%">
							<col width="25%">
							<col width="20%">
							<col width="10%">
						</colgroup>
						<thead class="thead-light">
							<tr>
								<th class="text-center">포장번호</th>
								<th class="text-center">생산LotNo</th>
								<th class="text-center">제품명</th>
								<th class="text-center">수량</th>
								<th class="text-center">구분</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="3" style="text-align:center">합계</td>
								<td id="checkUnPackSum" style="text-align: right">0</td>
								<td></td>
							</tr>
						</tfoot>
					</table>
				</div>
				<!-- 
				<p style="margin-bottom: 0px;">*선택한 제품 또는 포장번호 중 가장 최근 포장내역이 복원됩니다!</p>
				<p style="margin-bottom: 0px;">*다른 PC에서 해당 제품 포장 시 복원대상 작지가 변경 될 수 있습니다. 대상작지를 다시한번 확인해 주세요!</p>
				<p>ex) 포장1을 10:20분에, 포장2를 10:23분에 수행 후 복원 버튼 클릭 시 포장2 복원, 복원버튼 한번더 클릭 시 포장1을 복원</p>
				 -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnPackCancelCheck" data-dismiss="modal" style="min-width: 70px;">제품 복원</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnPackCancelCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 복원 확인 모달 종료 -->
<!-- 에러 복구 확인 모달 시작-->
<div class="modal fade" id="packErrorCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="packErrorCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">에러복구 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>에러복구 하시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnPackErrorCheck" data-dismiss="modal" style="min-width: 70px;">복구</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnPackErrorCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 에러 복구 모달 종료 -->
<!-- 분할포장 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="divisonBoxNoModal" tabindex="-1" role="dialog" aria-labelledby="equipPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom: 0px;">
				<h5 class="modal-title" id="divisonBoxNolabel">포장 분할</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<!-- <input type="hidden" id="divisionBoxNo" name="divisionBoxNo"> -->
			<input type="hidden" id="divisionGoodsCd" name="divisionGoodsCd">
			<input type="hidden" id="divisionOrdGubun" name="divisionOrdGubun">
			<!-- <input type="hidden" id="divisionWorkOrdNo" name="divisionWorkOrdNo"> -->
			<!-- <input type="hidden" id="divisionPackDtlCnt" name="divisionPackDtlCnt"> -->
			<div class="modal-body">
				<hr class="text-secondary">
				<!-- <h5>포장 분할기능 준비중입니다.</h5> -->
				<div class="row col-sm-12">
					<div class="row alert-primary col-sm-6">
						<h4 class="mr-2 mb-0">작지 번호 -</h4>
						<h4 class="mr-2 mb-0" id="divisionWorkOrdNo"></h4>
					</div>
					<div class="row alert-primary col-sm-6">
						<h4 class="mr-2 mb-0">포장 번호 -</h4>
						<h4 class="mr-2 mb-0" id="orignalBoxNo"></h4>
					</div>
				</div>
				<div class="row col-sm-12">
					<div class="row alert-primary col-sm-6">
						<h4 class="mr-2 mb-0">제품 명 -</h4>
						<h4 class="mr-2 mb-0" id="divisionGoodsNm"></h4>
					</div>
					<div class="row alert-primary col-sm-6">
						<h4 class="mr-2 mb-0">오더 구분 -</h4>
						<h4 class="mr-2 mb-0" id="divisionOrdGubunNm"></h4>
					</div>
				</div>
				<div class="row col-sm-12">
					<div class="row alert-primary col-sm-6">
						<h4 class="mr-2 mb-0">포장 수량 -</h4>
						<h4 class="mr-2 mb-0" id="divisionPackDtlCnt"></h4>
					</div>
					<div class="row alert-primary col-sm-6">
						<h4 class="mr-2 mb-0"></h4>
						<h4 class="mr-2 mb-0" id=""></h4>
					</div>
				</div>
				<br>
				<table class="table table-bordered mb-2">
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="25%">
						<col width="25%">
					</colgroup>
					<tr>
						<th id="divisionBoxNo1" style="font-size:20px;">?</th>
						<td>
							<input type="text" min=0 class="form-control number-float0_2" id="divisionPackCnt1" name="divisionPackCnt1" value="0" style="font-size:20px;">
						</td>
						<th id="divisionBoxNo2" style="font-size:20px;">?</th>
						<td>
							<input type="text" min=0 class="form-control number-float0_2" id="divisionPackCnt2" name="divisionPackCnt2" value="0" style="font-size:20px;">
						</td>
					</tr>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer" style="min-width:70px;padding-top: 0px;">
				<div class="card-body" style="overflow:hidden; padding:0px;">
					<div class="row">
						<div class="col-md-4">
							<button type="button" class="btn btn-danger float-left touch6 mr-1" id="btnDivisionPackCancel">분할 취소</button>
						</div>
						<div class="col-md-8">
							<button type="button" class="btn btn-secondary float-right touch6 mr-1" data-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary float-right touch6 mr-1" id="btnDivisonCheck" data-dismiss="modal" style="width:70px;">분할</button>
							<button type="button" class="btn btn-warning float-right mr-1 touch6 mr-1" id="btnDivisionPrint2">분할2 인쇄</button>
							<button type="button" class="btn btn-warning float-right mr-1 touch6 mr-1" id="btnDivisionPrint1">분할1 인쇄</button>
							<select class="custom-select custom-select-md float-right mr-1 mr-1" id="choosePrintLocation" style="width:100px;">
								<option value="">선택</option>
								<option value="001">작업대1</option>
								<option value="002">작업대2</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 분할포장 모달 종료-->
<!-- 포장 포장 확인 모달 시작-->
<div class="modal fade" id="packTempCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">포장 확인</h5>
    		    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
		<div class="modal-body">
			<h6>포장 실행 하시겠습니까?</h6> 
			<p>*선택하신 생산LotNo 순으로 포장됩니다!</p>
		</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnPackTempAddCheck" data-dismiss="modal" style="min-width:70px;">포장 실행</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnPackTempAddCheckCancel" data-dismiss="modal" style="min-width:70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 포장 포장 확인 모달 종료 -->
<!-- 포장 대기 복원 확인 모달 시작-->
<div class="modal fade" id="unpackUnpackCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">포장 대기 복원 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 id="unpackUnpackTitle"></h6>
				<p>*해당 생산LotNo의 포장대기 상태의 생산전표번호들이 외관검사 완료 시점으로 복원됩니다!</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnWorkOrdLotNoUnpackCheck" data-dismiss="modal" style="min-width: 70px;">포장 대기 복원</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 포장 대기 복원 확인 모달 종료 -->

<%@include file="../layout/bottom.jsp"%>

<%-- 
<script src="<c:url value='/resources/JSPrint/JSPrintManager-master/scripts/zip.js'/>"></script>
<script src="<c:url value='/resources/JSPrint/JSPrintManager-master/scripts/zip-ext.js'/>"></script>
<script src="<c:url value='/resources/JSPrint/JSPrintManager-master/scripts/deflate.js'/>"></script>
<script src="<c:url value='/resources/JSPrint/JSPrintManager-master/scripts/JSPrintManager.js'/>"></script>
 --%>
<%-- <script src="<c:url value='/resources/JSPrint/bluebird-master/bluebird.js'/>"></script> --%>

<script>

	let menuAuth = 'posc3030';
	let currentHref = 'posc3030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","생산실적라벨발행");
	uiProc(true);	
	
	//공통코드 처리 시작
	var goodsCode = new Array(); // 설비분류
    <c:forEach items="${goodsCode}" var="info">
		var json=new Object();
		json.baseCd="${info.goodsCd}";
		json.baseCdNm="${info.goodsNm}";
		json.packUnitNm="${info.packUnitNm}";
		goodsCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    //목록
    var ordDateCal =  "${serverDate}";
    $("#ordDate").val(ordDateCal);
    var barcodeWorkOrdLotNo = "";
    var barcodeGoodsCd = ""
    $("#packCnt").text("000");
    selectBoxAppend(goodsCode, "selGoodsCd", "" , "1");
    var boxNo = '';
    var boxTableNo = '';
    var goodsNm = '';
	var printYn = 'N';
	var boxNoData = '';
	var factoryCode = "<%=factoryCode%>";
	
    $('#barcodeWorkOrdLotNo').focus();
	//console.log("${ip}");
	//console.log("${port}");
	//$('input[type=checkbox]').change(function() {
	$("#btnTempPackAdd").change(function() {
		if ($("#selGoodsCd option:selected").val() == '') {
			toastr.warning('포장할 제품을 선택해주세요!', '', {timeOut: 7000});
			$("#btnTempPackAdd").prop('checked', false);
			$('#selGoodsCd').focus();
			return false;
		}
		
		if ($('#btnTempPackAdd').is(':checked')) {
			$('#divUnBoxNoTotalTableDtl').addClass('d-none');
			$('#divPackWorkOrdLotNoList').removeClass('d-none');
			$('#btnRealPackAdd').removeClass('d-none');
			$('#divPackButton').removeClass('d-none');
			$('#btnWorkOrdLotNoUnpack').addClass('d-none');
			$('#ordGubun1').val('0');
			$('#ordGubun2').val('0');
			$('#ordGubun3').val('0');
			$('#countPackBoxNo').text('-');
			$('#countPackRemainCnt').text('-');
			//$('#packWorkOrdLotNoList').DataTable().clear().draw();
			
		} else {
			workOrdLotNoDtl = null;
			packDtlCnt = null;
			packRemainCnt = null;
			$('#ordGubun1').val('0');
			$('#ordGubun2').val('0');
			$('#ordGubun3').val('0');
			$('#divUnBoxNoTotalTableDtl').removeClass('d-none');
			$('#divPackWorkOrdLotNoList').addClass('d-none');
			$('#btnRealPackAdd').addClass('d-none');
			$('#divPackButton').addClass('d-none');
			$('#btnWorkOrdLotNoUnpack').removeClass('d-none');
		}
		tempPackAddArray = [];
		$('input:radio[name=ordGubunCheck]').prop('checked', false);
		$('input:radio[name=ordGubunCheck]').attr('disabled', false);
		$('#unBoxNoTotalTable').find('tr.selected').removeClass('selected');
		$('#unBoxNoTotalTableDtl').DataTable().clear().draw();
		//$('#workOrderTable').find('tr.selected').removeClass('selected');
		//$('#boxNo1Table').find('tr.selected').removeClass('selected');
		//$('#boxNo2Table').find('tr.selected').removeClass('selected');
		//$('#boxNo3Table').find('tr.selected').removeClass('selected');
	});
	
    $("#barcodeWorkOrdLotNo").keypress(function (e) {
        if (e.which == 13) {
        	if ( !$.trim($('#barcodeWorkOrdLotNo').val()) ) {
                toastr.warning('작지번호를 스캔해주세요!');
                $('#barcodeWorkOrdLotNo').focus();
                return false;
            }
        	workOrdLotNoDtl = null;
        	packDtlCnt 		= null;
			packRemainCnt	= null;
        	ordDateCal 		= $("#ordDate").val();
	    	var engToKor = korTypeToEng( $.trim($('#barcodeWorkOrdLotNo').val()) );
	    	//변환대 영타가 소문자여서 대문자로 변환 후 비교
	    	$('#barcodeWorkOrdLotNo').val(engToKor.toUpperCase());
	    	
        	var cval = compareBarcodeNo($('#barcodeWorkOrdLotNo').val());
            if(cval == false) {
            	toastr.warning('이미 추가된 생산LotNO 입니다.<br/>바코드정보를 확인해 주세요.', '', {timeOut: 5000});
                return false;              
            }
			
            $('#my-spinner').show();
        	
	  	  	$.ajax({
	            url: '<c:url value="/po/workOrdGoodsPackScan"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 		: 		menuAuth,
	            	'workOrdLotNo'		: 		$("#barcodeWorkOrdLotNo").val(),
	            },
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
							barcodeWorkOrdLotNo = data.workOrdLotNo;
							barcodeGoodsCd		= data.goodsCd;
							goodsCd				= data.goodsCd;
							$("#ordDate").val(res.serverDate);
							$("#workOrdNo").val(data.workOrdNo);
							$("#workOrdLotNo").val(data.workOrdLotNo);
							$("#packOrdLotNoList").val(data.packOrdLotNoList);
							//$("#ordLotNo").val(data.ordLotNo);
							$("#goodsNm").val(data.goodsNm);
							$("#goodsCd").val(data.goodsCd);
							$("#selGoodsCd").val(data.goodsCd);
							$("#outputCnt").val(data.totalCnt);
							$("#totalInspectCnt").val(data.totalCnt);
							$("#userOutputCnt").val(data.userOutputCnt);
							$("#totalFaultyCnt").val(data.totalFaultyCnt);
							//$("#appearAbrfCnt").val(data.appearAbrfCnt);
							//$("#appearAbrsCnt").val(data.appearAbrsCnt);
							//$("#appearDmsCnt").val(data.appearDmsCnt);
							$("#appearAbrfCnt").val('0');
							$("#appearAbrsCnt").val('0');
							$("#appearDmsCnt").val('0');
							$("#packUnitCnt").val(data.packUnitNm);																		
							$("#packCnt").text(data.packUnitNm);
							
							$('#workOrderTable').DataTable().row.add({}).draw(false);
							$("#barcodeWorkOrdLotNo").val("");
							printYn = $("#printYn option:selected").val();
							toastr.success("추가되었습니다.");
							
					} else if (res.result == 'fail') {
						toastr.warning(res.message);
						$('#barcodeWorkOrdLotNo').select();
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				},
				complete:function() {
					$('#boxNo1Table').DataTable().ajax.reload( function () {});
		    		$('#boxNo2Table').DataTable().ajax.reload( function () {});
		    		$('#boxNo3Table').DataTable().ajax.reload( function () {});    
		    		$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});
		    		//$('#unBoxNo1Table').DataTable().ajax.reload( function () {});
		    		//$('#unBoxNo2Table').DataTable().ajax.reload( function () {});
		    		//$('#unBoxNo3Table').DataTable().ajax.reload( function () {});
					$('#my-spinner').hide();
				}
			});      	
        }
    });    

	function compareBarcodeNo(barcodeNo) {
		var result = true;
		$('#workOrderTable tbody tr').each(function(){
		 	var tbarcodeNo= $(this).find('td').eq(3).html();
			if(barcodeNo == tbarcodeNo) {
				result = false;
				return result;
			}
		});

		return result;
	} 

	$.fn.dataTable.ext.errMode = 'none';
	let workOrderTable = $('#workOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: true,
		processing: true,
		searching: false,
		autoWidth: false,
        ajax: {
            url: '<c:url value="/po/workOrderPackDataEmptyList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
                'ordLotNo'		:		function() { return barcodeWorkOrdLotNo; }, 
                'goodsCd'		:		function() { return barcodeGoodsCd; },
                'workOrdDate'	:		function() { return ordDateCal.replace(/-/g, ''); }
            	//'ordDate' : function() { return ordDateCal.replace(/-/g, ''); },
            },
        },
        rowId: 'equipCd',
		columns: [
			{
		       data: "workOrdNo",
		       render: function (data, type, row, meta) {
		           return meta.row + 1;
		       }    
		    },
        	{ 
	        	data: 'workOrdNo', 
	    		render: function(data, type, row, meta) {	
// 	    			if(data != null) {
	    				return data;
// 	    			} else {
// 						return  $("#workOrdNo").val();
// 	    			}
	    		}
    		},			
        	{ 
	        	data: 'goodsNm', 
	    		render: function(data, type, row, meta) {	
// 	    			if(data != null) {
// 	    				return data;
	    				return data
				    				+ '<input type="hidden" id="goodsCd" name="goodsCd" value="' + row['goodsCd'] + '">' 
				    				+ '<input type="hidden" id="packUnitCnt" name="packUnitCnt" value="' + row['packUnitNm'] + '">'  
				    				+ '<input type="hidden" id="packOrdLotNoList" name="packOrdLotNoList" value="' + row['packOrdLotNoList'] + '">';
// 	    			} else {
// 						return  $("#goodsNm").val() 
// 			    					+ '<input type="hidden" id="goodsCd" name="goodsCd" value="' + $("#goodsCd").val() + '">' 
// 			    					+ '<input type="hidden" id="packUnitCnt" name="packUnitCnt" value="' + $("#packUnitCnt").val() + '">'  
// 			    					+ '<input type="hidden" id="packOrdLotNoList" name="packOrdLotNoList" value="' + $("#packOrdLotNoList").val() + '">';
// 	    			}
	    		}
    		},
        	{ 
	        	data: 'workOrdLotNo', 
	    		render: function(data, type, row, meta) {	
// 	    			if(data != null) {
	    				return data;
// 	    			} else {
// 						return  $("#workOrdLotNo").val();
// 	    			}
	    		}
    		},
    		{ 
	        	data: 'outputCnt', 
	    		render: function(data, type, row, meta) {	
// 	    			if(data != null) {
	    				return addCommas(row['totalCnt']);	//Enter event시 totalCnt 값을 넣어줌 
// 	    			} else {
// 	    				return addCommas($("#outputCnt").val());
// 	    			}
	    		}
    		},
    		{
	        	data: 'totalInspectCnt', 
	    		render: function(data, type, row, meta) {	
// 	    			if(data != null) {
	    				return addCommas(row['totalCnt']);
// 	    			} else {
// 	    				return addCommas($("#totalInspectCnt").val());
// 	    			}
	    		}
    		},
        	{
	        	data: 'userOutputCnt', 
	    		render: function(data, type, row, meta) {	
// 	    			if(data != null) {
// 	    				return data;
	    				return  '<input type="text" class="form-control text-right userOutputCnt" style="min-width:40px max-width:50px" id="userOutputCnt" name="userOutputCnt" value="'+addCommas((parseInt(row['totalCnt']) - parseInt(row['totalFaultyCnt'])))+'">';
// 	    			} else {
// 	    				return  '<input type="text" class="form-control text-right userOutputCnt" style="min-width:40px max-width:50px" id="userOutputCnt" name="userOutputCnt" value="'+addCommas($("#userOutputCnt").val())+'">';
// 	    			}
	    		}
    		},
    		{ 
	        	data: 'totalFaultyCnt', 
	    		render: function(data, type, row, meta) {	
// 	    			if(data != null) {
	    				return data;
// 	    			} else {
// 						return addCommas($("#totalFaultyCnt").val());
// 	    			}
	    		}
    		},
        	//{ 
	        //	data: 'appearAbrfCnt', 
	    	//	render: function(data, type, row, meta) {	
	    	//		if(data != null) {
	    	//			return data;
	    	//		} else {
			//			return '<input type="text" class="form-control text-right number-float0" style="min-width:40px max-width:50px" id="appearAbrfCnt" name="appearAbrfCnt" value="'+addCommas($("#appearAbrfCnt").val())+'">';
	    	//		}
	    	//	}
    		//},
        	//{ 
	        //	data: 'appearAbrsCnt', 
	    	//	render: function(data, type, row, meta) {	
	    	//		if(data != null) {
	    	//			return data;
	    	//		} else {
			//			return '<input type="text" class="form-control text-right number-float0" style="min-width:40px max-width:50px" id="appearAbrsCnt" name="appearAbrsCnt" value="'+addCommas($("#appearAbrsCnt").val())+'">';
	    	//		}
	    	//	}
    		//},
        	//{ 
	        //	data: 'appearDmsCnt', 
	    	//	render: function(data, type, row, meta) {	
	    	//		if(data != null) {
	    	//			return data;
	    	//		} else {
			//			return  '<input type="text" class="form-control text-right number-float0" style="min-width:40px max-width:50px" id="appearDmsCnt" name="appearAbrsCnt" value="'+addCommas($("#appearDmsCnt").val())+'">';
	    	//		}
	    	//	}
    		//},
		],
        columnDefs: [
        	{ targets: [4,5,6,7] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [4,5,6,7], className: 'text-right' },
        	{ targets: [0,1,2,3], className: 'text-center' },
        ],		
		order: [
			[ 0, 'desc' ],
		],
// 	    "drawCallback": function( settings ) {
// 	    	//$('#workOrderTable tbody tr td').css('height','50px');
// 	    	$('#workOrderTable_paginate').html("&nbsp;");
// 	    	$('#workOrderTable tbody tr td').css('height','40px');
// 	    }
    });

	var workOrdIndex; 
	var packOrdLotNoList = null;
	$('#workOrderTable tbody').on('click', 'tr', function () {
		//if ($('#btnTempPackAdd').is(':checked')) {
		//	toastr.warning('포장 대기 포장 체크시 생산LotNo를 포장 할 수 없습니다!', '', {timeOut: 5000});
		//} else {
			if ($(this).hasClass('selected')) {
				//$(this).removeClass('selected');
			} else {
				$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
				$(this).addClass('selected');
				//var packCnt = workOrderTable.row( this ).data().packUnitNm; 
				//$("#packCnt").text(packCnt);
				
				$("#packCnt").text(workOrderTable.rows('.selected').data()[0].packUnitNm);	//작지선택 시 마다 포장수량 값 넣어주기
			
				var $row 			= $(this).closest('tr');
				workOrdNo 			= $row.find('td').eq(1).html();
				goodsCd 			= $row.find('#goodsCd').val();
				//ordLotNo 			= $row.find('td').eq(3).html();
				workOrdLotNo 		= $row.find('td').eq(3).html();
				packUnitCnt 		= $row.find('#packUnitCnt').val().replace(/[^\.0-9]/g,"");
				packTotalCnt	 	= removeCommas($row.find('td').eq(4).html());
				userOutputCnt 		= $row.find('#userOutputCnt').val().replace(/[^\.0-9]/g,"");
				//appearOutputCnt 	= $row.find('td').eq(4).html().replace(/,/g, '');
				//appearAbrfCnt 	= $row.find('#appearAbrfCnt').val().replace(/[^\.0-9]/g,"");
				//appearAbrsCnt	 	= $row.find('#appearAbrsCnt').val().replace(/[^\.0-9]/g,"");
				//appearDmsCnt 		= $row.find('#appearDmsCnt').val().replace(/[^\.0-9]/g,"");
				packOrdLotNoList	= $row.find('#packOrdLotNoList').val();	//해당 생산LotNo로 미포장될 생산전표번호들
				
				$('#packCnt').val(packUnitCnt);
				ordDateCal = $("#ordDate").val();
				$("#selGoodsCd").val(goodsCd);
				printYn = $("#printYn option:selected").val();
				$('#boxNo1Table').DataTable().ajax.reload( function () {});
				$('#boxNo2Table').DataTable().ajax.reload( function () {});
				$('#boxNo3Table').DataTable().ajax.reload( function () {});
				$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});
				//$('#unBoxNo1Table').DataTable().ajax.reload( function () {});
				//$('#unBoxNo2Table').DataTable().ajax.reload( function () {});
				//$('#unBoxNo3Table').DataTable().ajax.reload( function () {});
			}
		//}
	});

	//포장시 선입선출 정보출력 테이블
	$.fn.dataTable.ext.errMode = 'none';
	let packWorkOrdLotNoList = $('#packWorkOrdLotNoList').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
    });
    
	//var ordLotNo;
	var goodsCd;
	var workOrdLotNo;
	var packUnitCnt;
	var userOutputCnt;
	//var appearAbrfCnt;
	//var appearAbrsCnt;
	//var appearDmsCnt;
	//var appearOutputCnt;
	var goodsCd;
	var packTotalCnt = 0;

	/*
	$('#workOrderTable').on('keyup', 'input#userOutputCnt', function(e) {
		if (e.which == 13) {
			var $row = $(this).closest("tr");
			//alert($row);
			userOutputCnt = $row.find('#userOutputCnt').val().replace(/[^\.0-9]/g,"");
			//appearAbrfCnt = $row.find('#appearAbrfCnt').val().replace(/[^\.0-9]/g,"");
			//appearAbrsCnt = $row.find('#appearAbrsCnt').val().replace(/[^\.0-9]/g,"");
			//appearDmsCnt = $row.find('#appearDmsCnt').val().replace(/[^\.0-9]/g,"");
			//appearOutputCnt = $row.find('td').eq(4).html().replace(/,/g, '');
			
			if(userOutputCnt == null || userOutputCnt == "" || userOutputCnt == "0" || userOutputCnt == "00") {
				 toastr.warning('양품수량을 입력해 주세요.');
				 $row.find('#userOutputCnt').select();
				 return false;
			}
			//if(appearAbrfCnt == null || appearAbrfCnt == "") {
			//	 toastr.warning('해외1 수량을 입력해 주세요.');
			//	 $row.find('#appearAbrfCnt').focus();
			//	 return false;
			//}
			//if(appearAbrsCnt == null || appearAbrsCnt == "") {
			//	 toastr.warning('해외2 수량을 입력해 주세요.');
			//	 $row.find('#appearAbrsCnt').focus();
			//	 return false;
			//}
			//
			//if(appearDmsCnt == null || appearDmsCnt == "") {
			//	 toastr.warning('국내 수량을 입력해 주세요.');
			//	 $row.find('#appearDmsCnt').focus();
			//	 return false;
			//}
			//
			//var total = parseInt(appearAbrfCnt) + parseInt(appearAbrsCnt) + parseInt(appearDmsCnt);
			//if(userOutputCnt == total) {
			//	var workOrdNo = $row.find('td').eq(1).html();
			//	var workOrdLotNo = $row.find('td').eq(3).html();
			//	//updateWorkOrdCnt(workOrdNo, ordLotNo, userOutputCnt, appearAbrfCnt, appearAbrsCnt, appearDmsCnt);
			//} else {
			//	toastr.warning('해외1+해외2+국내 수량이 전체 양품수량과 동일하지 않습니다.<br/> 정확한 수량을 입력해 주세요.');
			//}
		}
	});

	
	$('#workOrderTable').on('keyup', 'input#appearAbrfCnt', function(e) {
		if (e.which == 13) {
			var $row = $(this).closest("tr");
			//alert($row);
			userOutputCnt = $row.find('#userOutputCnt').val().replace(/[^\.0-9]/g,"");
			appearAbrfCnt = $row.find('#appearAbrfCnt').val().replace(/[^\.0-9]/g,"");
			appearAbrsCnt = $row.find('#appearAbrsCnt').val().replace(/[^\.0-9]/g,"");
			appearDmsCnt = $row.find('#appearDmsCnt').val().replace(/[^\.0-9]/g,"");
			//appearOutputCnt = $row.find('td').eq(4).html().replace(/,/g, '');
			
			if(userOutputCnt == null || userOutputCnt == "" || userOutputCnt == "0") {
				 toastr.warning('양품수량을 입력해 주세요.');
				 $row.find('#userOutputCnt').select();
				 return false;
			}
			if(appearAbrfCnt == null || appearAbrfCnt == "") {
				 toastr.warning('해외1 수량을 입력해 주세요.');
				 $row.find('#appearAbrfCnt').focus();
				 return false;
			}
			if(appearAbrsCnt == null || appearAbrsCnt == "") {
				 toastr.warning('해외2 수량을 입력해 주세요.');
				 $row.find('#appearAbrsCnt').focus();
				 return false;
			}
			
			if(appearDmsCnt == null || appearDmsCnt == "") {
				 toastr.warning('국내 수량을 입력해 주세요.');
				 $row.find('#appearDmsCnt').focus();
				 return false;
			}
			
			var total = parseInt(appearAbrfCnt) + parseInt(appearAbrsCnt) + parseInt(appearDmsCnt);
			if(userOutputCnt == total) {
				var workOrdNo = $row.find('td').eq(1).html();
				var workOrdLotNo = $row.find('td').eq(3).html();
				//updateWorkOrdCnt(workOrdNo, ordLotNo, userOutputCnt, appearAbrfCnt, appearAbrsCnt, appearDmsCnt);
			} else {
				toastr.warning('해외1+해외2+국내 수량이 전체 양품수량과 동일하지 않습니다.<br/> 정확한 수량을 입력해 주세요.');
			}
		}
	});
	
	$('#workOrderTable').on('keyup', 'input#appearAbrsCnt', function(e) {
		if (e.which == 13) {
			var $row = $(this).closest("tr");
			//alert($row);
			userOutputCnt = $row.find('#userOutputCnt').val().replace(/[^\.0-9]/g,"");
			appearAbrfCnt = $row.find('#appearAbrfCnt').val().replace(/[^\.0-9]/g,"");
			appearAbrsCnt = $row.find('#appearAbrsCnt').val().replace(/[^\.0-9]/g,"");
			appearDmsCnt = $row.find('#appearDmsCnt').val().replace(/[^\.0-9]/g,"");
			//appearOutputCnt = $row.find('td').eq(4).html().replace(/,/g, '');
			
			if(userOutputCnt == null || userOutputCnt == "" || userOutputCnt == "0") {
				 toastr.warning('양품수량을 입력해 주세요.');
				 $row.find('#userOutputCnt').select();
				 return false;
			}
			if(appearAbrfCnt == null || appearAbrfCnt == "") {
				 toastr.warning('해외1 수량을 입력해 주세요.');
				 $row.find('#appearAbrfCnt').focus();
				 return false;
			}
			if(appearAbrsCnt == null || appearAbrsCnt == "") {
				 toastr.warning('해외2 수량을 입력해 주세요.');
				 $row.find('#appearAbrsCnt').focus();
				 return false;
			}
			
			if(appearDmsCnt == null || appearDmsCnt == "") {
				 toastr.warning('국내 수량을 입력해 주세요.');
				 $row.find('#appearDmsCnt').focus();
				 return false;
			}
			
			var total = parseInt(appearAbrfCnt) + parseInt(appearAbrsCnt) + parseInt(appearDmsCnt);
			if(userOutputCnt == total) {
				var workOrdNo = $row.find('td').eq(1).html();
				var workOrdLotNo = $row.find('td').eq(3).html();
				//updateWorkOrdCnt(workOrdNo, ordLotNo, userOutputCnt, appearAbrfCnt, appearAbrsCnt, appearDmsCnt);
			} else {
				toastr.warning('해외1+해외2+국내 수량이 전체 양품수량과 동일하지 않습니다.<br/> 정확한 수량을 입력해 주세요.');
			}
		}
	});	    

	$('#workOrderTable').on('keyup', 'input#appearDmsCnt', function(e) {
		if (e.which == 13) {
			var $row = $(this).closest("tr");
			//alert($row);
			userOutputCnt = $row.find('#userOutputCnt').val().replace(/[^\.0-9]/g,"");
			appearAbrfCnt = $row.find('#appearAbrfCnt').val().replace(/[^\.0-9]/g,"");
			appearAbrsCnt = $row.find('#appearAbrsCnt').val().replace(/[^\.0-9]/g,"");
			appearDmsCnt = $row.find('#appearDmsCnt').val().replace(/[^\.0-9]/g,"");
			//appearOutputCnt = $row.find('td').eq(4).html().replace(/,/g, '');
			
			if(userOutputCnt == null || userOutputCnt == "" || userOutputCnt == "0") {
				 toastr.warning('양품수량을 입력해 주세요.');
				 $row.find('#userOutputCnt').select();
				 return false;
			}
			if(appearAbrfCnt == null || appearAbrfCnt == "") {
				 toastr.warning('해외1 수량을 입력해 주세요.');
				 $row.find('#appearAbrfCnt').focus();
				 return false;
			}
			if(appearAbrsCnt == null || appearAbrsCnt == "") {
				 toastr.warning('해외2 수량을 입력해 주세요.');
				 $row.find('#appearAbrsCnt').focus();
				 return false;
			}
			
			if(appearDmsCnt == null || appearDmsCnt == "") {
				 toastr.warning('국내 수량을 입력해 주세요.');
				 $row.find('#appearDmsCnt').focus();
				 return false;
			}
			
			var total = parseInt(appearAbrfCnt) + parseInt(appearAbrsCnt) + parseInt(appearDmsCnt);
			if(userOutputCnt == total) {
				var workOrdNo = $row.find('td').eq(1).html();
				var workOrdLotNo = $row.find('td').eq(3).html();
				//updateWorkOrdCnt(workOrdNo, ordLotNo, userOutputCnt, appearAbrfCnt, appearAbrsCnt, appearDmsCnt);
			} else {
				toastr.warning('해외1+해외2+국내 수량이 전체 양품수량과 동일하지 않습니다.<br/> 정확한 수량을 입력해 주세요.');
			}
		}
	});
	*/

	//function updateWorkOrdCnt(workOrdNo, ordLotNo, userOutputCnt, appearAbrfCnt, appearAbrsCnt, appearDmsCnt)
	//{
	//     $.ajax({
	//		url: '<c:url value="/po/updateWorkOrdAppearCnt"/>',
	//		type: 'POST',
	//		data: {
	//			'menuAuth'	 		: 		menuAuth,
	//			'workOrdNo'   		:       workOrdNo,
	//			'ordLotNo'   		:       ordLotNo,
	//			'userOutputCnt'		: 		userOutputCnt,
	//			'appearAbrfCnt'		: 		appearAbrfCnt,                
	//			'appearAbrsCnt'   	:       appearAbrsCnt,
	//			'appearDmsCnt'    	:       appearDmsCnt,
	//		},
	//		beforeSend: function() {
	//		   // $('#btnAddConfirm').addClass('d-none');
	//		   // $('#btnAddConfirmLoading').removeClass('d-none');
	//		},
	//		success: function (res) {
	//			let data = res.data;
	//			if (res.result == 'ok') {
	//				toastr.success(res.message);
	//				//$('#workOrderTable').DataTable().ajax.reload( function () {});
	//				//if (tempPack == '1') {
	//			   	//	toastr.success('수정되었습니다.');
	//				//}
	//			} else if (res.result == 'fail') {
	//				toastr.warning(res.message, '', {timeOut: 5000});
	//			} else if (res.result == 'error') {
	//				toastr.error(res.message, '', {timeOut: 5000});
	//			}
	//		},
	//		complete:function() {
	//			$('#btnAddConfirm').removeClass('d-none');
	//			$('#btnAddConfirmLoading').addClass('d-none');
	//		}
	// 	});
	//}
	
	$('#selGoodsCd, #printYn').change(function() {
		boxNo = '';
		goodsCd = '';
		goodsNm = '';
		goodsCd = $("#selGoodsCd option:selected").val();
		printYn = $("#printYn option:selected").val();
		ordDateCal = $("#ordDate").val();
		$("#barcodeWorkOrdLotNo").val('');
		for (var i=0; i<goodsCode.length; i++) {
			if (goodsCd == goodsCode[i].baseCd) {
				$('#packCnt').text(goodsCode[i].packUnitNm);
				break;
			}
		}
		$('#unBoxNoTotalTableDtl').DataTable().clear().draw();
		$('#boxNo1Table').DataTable().ajax.reload( function () {});
		$('#boxNo2Table').DataTable().ajax.reload( function () {});
		$('#boxNo3Table').DataTable().ajax.reload( function () {});
		$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});

		$('#unBoxNoTotalTableDtl').DataTable().clear().draw();
		$('#divUnBoxNoTotalTableDtl').removeClass('d-none');
		$('#divPackWorkOrdLotNoList').addClass('d-none');
		$('#divPackButton').addClass('d-none');
		$('input:radio[name=ordGubunCheck]').prop('checked', false);
		$('input:radio[name=ordGubunCheck]').attr('disabled', false);
		$("#btnTempPackAdd").prop('checked', false) ;
		
		//$('#unBoxNo1Table').DataTable().ajax.reload( function () {});
		//$('#unBoxNo2Table').DataTable().ajax.reload( function () {});
		//$('#unBoxNo3Table').DataTable().ajax.reload( function () {});
	});
	
	$('#btnSearch').click(function() {
		goodsCd 	= $("#selGoodsCd option:selected").val();
		printYn 	= $("#printYn option:selected").val();
		ordDateCal 	= $("#ordDate").val();
		tempPackAddArray = [];
		$('#boxNo1Table').DataTable().ajax.reload( function () {});
		$('#boxNo2Table').DataTable().ajax.reload( function () {});
		$('#boxNo3Table').DataTable().ajax.reload( function () {});
		$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});
		$('#unBoxNoTotalTableDtl').DataTable().clear().draw();
		$('#workOrderTable').DataTable().ajax.reload();
		//$('#unBoxNo1Table').DataTable().ajax.reload( function () {});
		//$('#unBoxNo2Table').DataTable().ajax.reload( function () {});
		//$('#unBoxNo3Table').DataTable().ajax.reload( function () {});
	});

	//생산LotNo 라인삭제
	$('#btnWorkOrdLotNoLineDelete').on('click', function() {
    	$('#workOrderTable').DataTable().rows('.selected').remove().draw();
    	$("#barcodeWorkOrdLotNo").val("");
    	$("#barcodeWorkOrdLotNo").focus();
    });

	//var tempPackAdd = false;
  	//포장실행버튼 클릭 시
  	$('#btnPackAdd').on('click', function() {
  	  	//포장 대기 포장
		//if ($('#btnTempPackAdd').is(':checked')) {
		//	if (tempPackAddArray == null || tempPackAddArray.length == 0) {
		//		toastr.warning('포장할 포장 대기 제품을 선택해주세요!', '', {timeOut: 7000});
		//		return false;
		//	}
        //	var tempPackDtlCntSum = 0;
        //	if (tempPackAddArray.length > 0) {
	    //    	for (var i=0; i<tempPackAddArray.length; i++) {
        //			tempPackDtlCntSum += tempPackAddArray[i].packDtlCnt;
	    //    	}
	    //    }
		//	
        //	if (parseInt($('#packCnt').text()) > tempPackDtlCntSum) {
        //		toastr.warning('선택되어있는 포장 대기 수량만으로는 완제품 1박스가 포장되지 않습니다.<br>선택하신 잔여수량을 확인해 주세요!', '', {timeOut: 7000});
        //		return false;
        //	}
        //
        //	//포장 대기 한개만 선택하였을 경우 완제품이 여러개 나올 수 있음 
        //    if (tempPackAddArray.length != 1) {
        //    	if (parseInt($('#packCnt').text()) * 2 <= tempPackDtlCntSum) {
        //    		tempPackAddArray = [];
        //			$('#boxNo1Table').find('tr.selected').removeClass('selected');
        //			$('#boxNo2Table').find('tr.selected').removeClass('selected');
        //			$('#boxNo3Table').find('tr.selected').removeClass('selected');
        //			toastr.warning('선택되어있는 미포장수량을 포장하였을 경우 완제품이 2박스 이상 포장됩니다!<br>다중선택 시 1개의 완제품만 포장 할 수 있습니다!', '', {timeOut: 7000});
        //			return false;
    	//        }
		//	}
		//	$('#packTempCheckPopupModal').modal('show');
		//	
		////생산LotNo 포장
		//} else {
			workOrdNo = $("#workOrderTable").find(".selected").find('td').eq(1).html();
			workOrdLotNo = $("#workOrderTable").find(".selected").find('td').eq(3).html();
			goodsCd = $("#workOrderTable").find(".selected").find('#goodsCd').val();
			
			if(workOrdLotNo == null || workOrdLotNo == "" || goodsCd == null || goodsCd == "") {
				toastr.warning("라벨 발행할 작지를 선택해 주세요.");
			  	return false;
			}
			
			//if(ordLotNo == null || ordLotNo == "" || goodsCd == null || goodsCd == ""
			//	  	|| packUnitCnt == null || appearOutputCnt == null || appearOutputCnt == ""
			//    	|| appearAbrfCnt == null || appearAbrfCnt == ""  || appearAbrsCnt == null || appearAbrsCnt == ""	) {
			userOutputCnt = $("#workOrderTable").find(".selected").find("#userOutputCnt").val().replace(/[^\.0-9]/g,"");
			packUnitCnt = $("#workOrderTable").find(".selected").find('#packUnitCnt').val().replace(/[^\.0-9]/g,"");
			//appearAbrfCnt = $("#workOrderTable").find(".selected").find("#appearAbrfCnt").val().replace(/[^\.0-9]/g,"");
			//appearAbrsCnt = $("#workOrderTable").find(".selected").find("#appearAbrsCnt").val().replace(/[^\.0-9]/g,""); 
			//appearDmsCnt = $("#workOrderTable").find(".selected").find("#appearDmsCnt").val().replace(/[^\.0-9]/g,"");
			//appearOutputCnt = $("#workOrderTable").find(".selected").find("td:eq(4)").text().replace(/,/g, '');
			
			if (userOutputCnt == null || userOutputCnt == "" || userOutputCnt == "0" || userOutputCnt == "00") {
				toastr.warning('양품수량을 입력해 주세요.');
				$row.find('#userOutputCnt').select();
				return false;
			}
			//if(appearAbrfCnt == null || appearAbrfCnt == "") {
			//	toastr.warning('해외1 수량을 입력해 주세요.');
			//	$row.find('#appearAbrfCnt').focus();
			//	return false;
			//}
			//if(appearAbrsCnt == null || appearAbrsCnt == "") {
			//	toastr.warning('해외2 수량을 입력해 주세요.');
			//	$row.find('#appearAbrsCnt').focus();
			//	return false;
			//}
			//
			//if(appearDmsCnt == null || appearDmsCnt == "") {
			//	toastr.warning('국내 수량을 입력해 주세요.');
			//	$row.find('#appearDmsCnt').focus();
			//	return false;
			//}
			
			//var total = parseInt(appearAbrfCnt) + parseInt(appearAbrsCnt) + parseInt(appearDmsCnt);
			//if(userOutputCnt == total) {
				$('#packCheckPopupModal').modal('show');
			//} else {
			//	toastr.warning('해외1+해외2+국내 수량이 전체 양품수량과 동일하지 않습니다.<br/> 정확한 수량을 입력해 주세요.');
			//	return false;
			//}
		//}
    });

	//포장실행버튼 클릭 시
  	$('#btnRealPackAdd').on('click', function() {
  	  	//포장 대기 포장
		if ($('#btnTempPackAdd').is(':checked')) {
			if (tempPackAddArray == null || tempPackAddArray.length == 0) {
				toastr.warning('포장할 포장 대기 제품을 선택해주세요!', '', {timeOut: 7000});
				return false;
			}
			//if (parseInt($('#countPackBoxNo').text()) == 0) {
			//	toastr.warning('완제품수량이 1개이상이여야 포장하실 수 있습니다!', '', {timeOut: 7000});
			//	return false;
			//}
			
			//if (!$('input:radio[name=ordGubunCheck]').is(':checked')) {
			//	toastr.warning('포장할 오더구분을 선택해 주세요!', '', {timeOut: 7000});
			//	return false;
			//}
			
        	var tempPackDtlCntSum = 0;
        	if (tempPackAddArray.length > 0) {
	        	for (var i=0; i<tempPackAddArray.length; i++) {
        			tempPackDtlCntSum += tempPackAddArray[i].packRemainCnt;
	        	}
	        }
			
        	if (parseInt($('#packCnt').text()) > tempPackDtlCntSum) {
        		toastr.warning('선택되어있는 포장 대기 수량만으로는 완제품 1박스가 포장되지 않습니다.<br>선택하신 잔여수량을 확인해 주세요!', '', {timeOut: 7000});
        		return false;
        	}

        	if (parseInt($('#ordGubun1').val()) + parseInt($('#ordGubun2').val()) + parseInt($('#ordGubun3').val()) != parseInt($('#countPackBoxNo').text())) {
        		toastr.warning('포장할 오더구분 별 완제품수량을 확인해주세요!', '', {timeOut: 7000});
        		return false;
            }
            
        	tempPackAddArray[0].ordGubun001 = parseInt($('#ordGubun1').val());
        	tempPackAddArray[0].ordGubun002 = parseInt($('#ordGubun2').val());
        	tempPackAddArray[0].ordGubun003 = parseInt($('#ordGubun3').val());
        	
        	
        	//포장 대기 한개만 선택하였을 경우 완제품이 여러개 나올 수 있음 
            //if (tempPackAddArray.length != 1) {
            //	if (parseInt($('#packCnt').text()) * 2 <= tempPackDtlCntSum) {
            //		tempPackAddArray = [];
        	//		$('#boxNo1Table').find('tr.selected').removeClass('selected');
        	//		$('#boxNo2Table').find('tr.selected').removeClass('selected');
        	//		$('#boxNo3Table').find('tr.selected').removeClass('selected');
        	//		toastr.warning('선택되어있는 미포장수량을 포장하였을 경우 완제품이 2박스 이상 포장됩니다!<br>다중선택 시 1개의 완제품만 포장 할 수 있습니다!', '', {timeOut: 7000});
        	//		return false;
    	    //    }
			//}
			
			$('#packTempCheckPopupModal').modal('show');
			
		//생산LotNo 포장
		} else {
			workOrdNo = $("#workOrderTable").find(".selected").find('td').eq(1).html();
			workOrdLotNo = $("#workOrderTable").find(".selected").find('td').eq(3).html();
			goodsCd = $("#workOrderTable").find(".selected").find('#goodsCd').val();
			
			if(workOrdLotNo == null || workOrdLotNo == "" || goodsCd == null || goodsCd == "") {
				toastr.warning("라벨 발행할 작지를 선택해 주세요.");
			  	return false;
			}
			
			//if(ordLotNo == null || ordLotNo == "" || goodsCd == null || goodsCd == ""
			//	  	|| packUnitCnt == null || appearOutputCnt == null || appearOutputCnt == ""
			//    	|| appearAbrfCnt == null || appearAbrfCnt == ""  || appearAbrsCnt == null || appearAbrsCnt == ""	) {
			userOutputCnt = $("#workOrderTable").find(".selected").find("#userOutputCnt").val().replace(/[^\.0-9]/g,"");
			packUnitCnt = $("#workOrderTable").find(".selected").find('#packUnitCnt').val().replace(/[^\.0-9]/g,"");
			//appearAbrfCnt = $("#workOrderTable").find(".selected").find("#appearAbrfCnt").val().replace(/[^\.0-9]/g,"");
			//appearAbrsCnt = $("#workOrderTable").find(".selected").find("#appearAbrsCnt").val().replace(/[^\.0-9]/g,""); 
			//appearDmsCnt = $("#workOrderTable").find(".selected").find("#appearDmsCnt").val().replace(/[^\.0-9]/g,"");
			//appearOutputCnt = $("#workOrderTable").find(".selected").find("td:eq(4)").text().replace(/,/g, '');
			
			if (userOutputCnt == null || userOutputCnt == "" || userOutputCnt == "0" || userOutputCnt == "00") {
				toastr.warning('양품수량을 입력해 주세요.');
				$row.find('#userOutputCnt').select();
				return false;
			}
			//if(appearAbrfCnt == null || appearAbrfCnt == "") {
			//	toastr.warning('해외1 수량을 입력해 주세요.');
			//	$row.find('#appearAbrfCnt').focus();
			//	return false;
			//}
			//if(appearAbrsCnt == null || appearAbrsCnt == "") {
			//	toastr.warning('해외2 수량을 입력해 주세요.');
			//	$row.find('#appearAbrsCnt').focus();
			//	return false;
			//}
			//
			//if(appearDmsCnt == null || appearDmsCnt == "") {
			//	toastr.warning('국내 수량을 입력해 주세요.');
			//	$row.find('#appearDmsCnt').focus();
			//	return false;
			//}
			
			//var total = parseInt(appearAbrfCnt) + parseInt(appearAbrsCnt) + parseInt(appearDmsCnt);
			//if(userOutputCnt == total) {
				$('#packCheckPopupModal').modal('show');
			//} else {
			//	toastr.warning('해외1+해외2+국내 수량이 전체 양품수량과 동일하지 않습니다.<br/> 정확한 수량을 입력해 주세요.');
			//	return false;
			//}
		}
    });
    
  	//tempPack가 1이면 작지 숫자입력후 엔터입력 이벤트, 2이면 작지 스캔후 해당 작지 클릭(파란줄) 후 바로 포장버튼 클릭
  	//그냥 단순히 수정되었습니다. success 알림 표시/미표시 하게하려는것임.
  	//var tempPack='1';
	// 포장확인버튼 클릭 시
  	$('#btnPackAddCheck').on('click', function() {
  		//tempPack='2';
  		//임시저장은 포장로직 초반에 포함되어 있음
		//updateWorkOrdCnt(ordLotNo, userOutputCnt, appearAbrfCnt, appearAbrsCnt, appearDmsCnt);
		
		//$.ajax({
		//    url: '<c:url value="/po/goodsLabelPublish"/>',
		//    type: 'POST',
		//    data: {
		//   		'menuAuth'	 		: 		menuAuth,
		//   		'workOrdNo'   		:       workOrdNo,
		//    	'ordLotNo'   		:       ordLotNo,
		//    	'goodsCd'			: 		goodsCd,
		//    	'packCnt'			: 		packUnitCnt,		     		     	
		//    	'userOutputCnt'		: 		userOutputCnt,
		//    	'appearAbrfCnt'		: 		appearAbrfCnt,                
		//    	'appearAbrsCnt'   	:       appearAbrsCnt,
		//    	'appearDmsCnt'    	:       appearDmsCnt,
		//    	//'packDate' 			: 		function() { return ordDateCal.replace(/-/g, ''); },
		//    },
		//    beforeSend: function() {
		//		$('#my-spinner').show();
		//		btnAllDisabled(true);
		//    },
		//    success: function (res) {
		//        let data = res.data;
		//        if (res.result == 'ok') {
		//      		//ordLotNo = "";
		//      		goodsCd = data.goodsCd;
		//      		//ordLotNo = "";
		//      		//packUnitCnt = "";    
		//      		appearAbrfCnt = "";
		//      		appearAbrsCnt = "";
		//      		appearDmsCnt = "";
		//      		userOutputCnt = "";
		//      		ordDateCal = data.packDate;
		//      		$("#ordDate").val(ordDateCal);
		//      		printYn = $("#printYn option:selected").val();
		//	      	$('#workOrderTable').DataTable().rows('.selected').remove().draw();
		//	   		
		//	   		toastr.success('정상적으로 라벨이 발행 되었습니다.');
		//        } else if (res.result == 'fail') {
		//        	toastr.warning(res.message, '', {timeOut: 5000});
		//        } else if (res.result == 'label') {
		//        	toastr.warning(res.message, '', {timeOut: 5000});
		//       	 	$('#workOrderTable').DataTable().rows('.selected').remove().draw();
		//        } else if (res.result == 'errorlabel') { 
		//        	printYn = $("#printYn option:selected").val();
		//	   		toastr.error(res.message, '', {timeOut: 5000});
		//    	} else {
		//    		toastr.error(res.message, '', {timeOut: 5000});
		//        }
		//        $('#my-spinner').hide();	
		//    },
		//    complete:function(){
		//    	$('#boxNo1Table').DataTable().ajax.reload( function () {});
		//   		$('#boxNo2Table').DataTable().ajax.reload( function () {});
		//   		$('#boxNo3Table').DataTable().ajax.reload( function () {});
		//   		$('#unBoxNo1Table').DataTable().ajax.reload( function () {});
		//		$('#unBoxNo2Table').DataTable().ajax.reload( function () {});
		//		$('#unBoxNo3Table').DataTable().ajax.reload( function () {});
		//        $('#btnAddConfirm').removeClass('d-none');
		//        $('#btnAddConfirmLoading').addClass('d-none');
		//        btnAllDisabled(false);
		//		//tempPack='1';
  	  	//		$('#my-spinner').hide();
		//    }
	 	//});

		$.ajax({
		    url: '<c:url value="/po/goodsUnpackPublish"/>',
		    type: 'POST',
		    data: {
		   		'menuAuth'	 		:		menuAuth,
		   		'workOrdNo'   		:		function() { return workOrdNo; },
		    	'workOrdLotNo'   	:		function() { return workOrdLotNo; },
		    	'packOrdLotNoList'	:		function() { return packOrdLotNoList; },
		    	'goodsCd'			:		function() { return goodsCd; },
		    	'packCnt'			:		function() { return packUnitCnt; },
		    	'packTotalCnt'		:		function() { return packTotalCnt; },
		    	'userOutputCnt'		:		function() { return userOutputCnt; },
		    },
		    beforeSend: function() {
				$('#my-spinner').show();
				btnAllDisabled(true);
		    },
		    success: function (res) {
		        let data = res.data;
		        if (res.result == 'ok') {
		      		workOrdNo = '';
		      		workOrdLotNo = '';
		      		packOrdLotNoList = '';
		      		goodsCd = data.goodsCd;
		      		userOutputCnt = "";
		      		packTotalCnt = 0;
		      		ordDateCal = res.frontToday;
		      		$("#ordDate").val(ordDateCal);
		      		printYn = $("#printYn option:selected").val();
			      	$('#workOrderTable').DataTable().rows('.selected').remove().draw();
			   		toastr.success(res.message);
			   		
		        } else if (res.result == 'fail') {
		        	toastr.warning(res.message, '', {timeOut: 5000});
		        } else if (res.result == 'label') {
		        	toastr.warning(res.message, '', {timeOut: 5000});
		       	 	$('#workOrderTable').DataTable().rows('.selected').remove().draw();
		        } else if (res.result == 'errorlabel') { 
		        	printYn = $("#printYn option:selected").val();
			   		toastr.error(res.message, '', {timeOut: 5000});
		    	} else {
		    		toastr.error(res.message, '', {timeOut: 5000});
		        }
		    },
		    complete:function() {
				$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});
				btnAllDisabled(false);
				$('#unBoxNoTotalTableDtl').DataTable().clear().draw();
				$('#divUnBoxNoTotalTableDtl').removeClass('d-none');
				$('#divPackWorkOrdLotNoList').addClass('d-none');
				$('#divPackButton').addClass('d-none');
				$('input:radio[name=ordGubunCheck]').prop('checked', false);
				$('input:radio[name=ordGubunCheck]').attr('disabled', false);
				$("#btnTempPackAdd").prop('checked', false) ;
				$('#my-spinner').hide();
			}
	 	});
  	});

  	$('#btnPackAddCheckCancel').on('click', function() {
  		$('#packCheckPopupModal').modal('hide');
  	});

	//미포장수량 포장 실행
  	$('#btnPackTempAddCheck').on('click', function() {
  		//$('#my-spinner').show();
		//제품 포장
		
  		useGoodsPackSystem('goodsProductPack');
		
  		//$('#my-spinner').hide();
  	});


	function useGoodsPackSystem(type) {
		$('#my-spinner').show();
		var tryCount = 1;

		//제품 포장 처리
		if (type == 'goodsProductPack') {
			//statusGoodspackUsing 001:정상처리, 002:포장시스템 사용중, 003:포장정보변경, 004:시스템오류
			var goodsPackStatusCode = goodsProductPack(tryCount);
			//최대 2번더 시도 총 3회 시도
			if (goodsPackStatusCode == '002') {
				$('#my-spinner').show();
				setTimeout(function() {
					tryCount++;
					goodsPackStatusCode = goodsProductPack(tryCount);
					
					if (goodsPackStatusCode == '002') {
						$('#my-spinner').show();
						setTimeout(function() {
							tryCount++;
							goodsPackStatusCode = goodsProductPack(tryCount);
						}, 3000)
					}
					
				}, 3000)
			}

			//포장정상 처리 되었을때에만 Datatables Reload
			if (goodsPackStatusCode == '001') {
				$('#boxNo1Table').DataTable().ajax.reload( function () {});
				$('#boxNo2Table').DataTable().ajax.reload( function () {});
				$('#boxNo3Table').DataTable().ajax.reload( function () {});
				$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});
				$('#unBoxNoTotalTableDtl').DataTable().clear().draw();
				$('#btnTempPackAdd').trigger('click');
			} else {
				$('#btnSearch').trigger('click');
			}

		//제품 복원 처리
		} else if (type == 'goodsProductUnPack') {
			//statusGoodspackUsing 001:정상처리, 002:포장시스템 사용중, 003:포장정보변경, 004:시스템오류
			var goodsUnPackStatusCode = goodsProductUnPack(tryCount);
			//최대 2번더 시도 총 3회 시도
			if (goodsUnPackStatusCode == '002') {
				$('#my-spinner').show();
				setTimeout(function() {
					tryCount++;
					goodsUnPackStatusCode = goodsProductUnPack(tryCount);
					
					if (goodsUnPackStatusCode == '002') {
						$('#my-spinner').show();
						setTimeout(function() {
							tryCount++;
							goodsUnPackStatusCode = goodsProductUnPack(tryCount);
						}, 3000)
					}
					
				}, 3000)
			}

			//복원정상 처리 되었을때에만 Datatables Reload
			if (goodsUnPackStatusCode == '001') {
				boxNoData = '';
				if ($('#btnTempPackAdd').is(':checked')) {
					$('#btnTempPackAdd').trigger('click');
				}
				$('#boxNo1Table').DataTable().ajax.reload( function () {});
				$('#boxNo2Table').DataTable().ajax.reload( function () {});
				$('#boxNo3Table').DataTable().ajax.reload( function () {});
				$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});
				$('#unBoxNoTotalTableDtl').DataTable().ajax.reload( function () {});
				btnAllDisabled(false);
			} else {
				$('#btnSearch').trigger('click');
			}
			
		} else {
			//예외처리 추가하기
		}
		//$('#my-spinner').hide();

	}
	
	//제품 포장 실행
	function goodsProductPack(tryCount) {

		var tempGoodsPackStatusCode = '';
		
		$.ajax({
			url: '<c:url value="/po/goodsTempLabelPublish"/>',
			type: 'POST',
			async: false,
			data: JSON.stringify(tempPackAddArray),
			dataType:"json",
			contentType : "application/json; charset=UTF-8",
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
                let data = res.data;
				tempGoodsPackStatusCode = res.goodsPackStatusCode;
				if (res.result == 'ok') {
					tempPackAddArray = [];
					boxNo = '';
				    goodsCd = '';
				    goodsNm = '';
                	goodsCd = $("#selGoodsCd option:selected").val();
                	printYn = $("#printYn option:selected").val();
                	ordDateCal = $("#ordDate").val();
                	toastr.success(res.message);
                //사용중
                } else if (res.result == 'using') {
					if (tryCount == 1 || tryCount == 2) {
						toastr.warning(res.message + '<br> 잠시만 기다려주세요! (' + tryCount + '/3)', '', {timeOut: 5000});
					} else if (tryCount == 3) {
						toastr.warning(res.message + '<br> 잠시 후 다시 시도해 주세요! (' + tryCount + '/3)', '', {timeOut: 5000});
					}
				//제품포장 Lock
                } else if (res.result == 'lock') {
                	toastr.warning(res.message, '', {timeOut: 5000});
                } else if (res.result == 'fail') {
                    toastr.warning(res.message, '', {timeOut: 5000});
                } else {
                    toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function() {
            	$('#my-spinner').hide();
            }
  		});

  		return tempGoodsPackStatusCode;
	}


	//제품 복원 실행
	function goodsProductUnPack(tryCount) {
		
		var tempGoodsUnPackStatusCode = '';
		$.ajax({
			url: '<c:url value="/po/boxNoUnpublish"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'	 		: 		menuAuth,
				'goodsCd'	 		: 		function() { return goodsCd; },
				'boxNoData' 		: 		function() { return boxNoData; },
			},
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
				let data = res.data;
				tempGoodsUnPackStatusCode = res.goodsUnPackStatusCode;
				if (res.result == 'ok') {
					if ($('#btnTempPackAdd').is(':checked')) {
						$('#btnTempPackAdd').trigger('click');
					}
					toastr.success(res.message, '', {timeOut: 5000});  
				//사용중
                } else if (res.result == 'using') {
					if (tryCount == 1 || tryCount == 2) {
						toastr.warning(res.message + '<br> 잠시만 기다려주세요! (' + tryCount + '/3)', '', {timeOut: 5000});
					} else if (tryCount == 3) {
						toastr.warning(res.message + '<br> 잠시 후 다시 시도해 주세요! (' + tryCount + '/3)', '', {timeOut: 5000});
					}
				//제품포장 Lock
                } else if (res.result == 'lock') {
                	toastr.warning(res.message, '', {timeOut: 5000});
                } else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if(res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function() {
				$('#my-spinner').hide();
			}
		});

  		return tempGoodsUnPackStatusCode;
	}

	//복원버튼 클릭 시
  	$('#btnPackCancel').on('click', function() {
		//if (goodsCd == null || goodsCd == "") {
		//	toastr.warning("복원할 제품정보를 선택해 주세요.");
		//	$('#selGoodsCd').focus();
		//	return false;
		//}
		if ($('#selGoodsCd option:selected').text() == '전체') {
			toastr.warning("복원할 제품정보를 선택해 주세요.");
			$('#selGoodsCd').focus();
			return false;
		}
		//if ($('#btnTempPackAdd').is(':checked')) {
		//	toastr.warning('포장 대기 포장 체크시 복원기능을 사용 할 수 없습니다!', '', {timeOut: 5000});
		//	$('#btnTempPackAdd').focus();
		//	return false;
		//}
		
		if ($('#selGoodsCd option:selected').text() == '선택') {
			$('#goodsNmCheck').text( goodsNm + ' 제품을 복원하시겠습니까?');
		} else {
			$('#goodsNmCheck').text($('#selGoodsCd option:selected').text() + ' 제품을 복원하시겠습니까?');
		}
		
		boxNoData = '';
		boxNoData = createBoxDataList();	//선택한 boxNo 중복없이 데이터생성
        //console.log(boxNoData);

        if (boxNoData == '') {
			toastr.warning('복원할 포장번호를 선택해주세요!')
			return false;
		}

        $('#checkUnPackListTable').DataTable().clear().draw();
		$('#checkUnPackListTable').DataTable().ajax.reload( function () {});

		$('#packCancelCheckPopupModal').modal('show');
		
		//$.ajax({
		//	url: '<c:url value="/po/goodsLabelUnpublishCheck"/>',
		//	type: 'POST',
		//	data: {
		//		'goodsCd'			: 		function() { return goodsCd; },
		//	},
		//	beforeSend: function() {
		//		$('#my-spinner').show();
		//	},
		//	success: function (res) {
		//		let data = res.data;
		//		if (res.result == 'ok') {
		//			$('#unpublishWorkOrd1').text("작업지시 : " + data.workOrdNo + "    생산 LotNo : ");
		//			$('#unpublishWorkOrd2').text(data.ordLotNo);
		//			if (data.gubun == 'D') {
		//				$('#unpublishWorkOrd2').css('color', 'red');
		//			} else if (data.gubun == 'N') {
		//				$('#unpublishWorkOrd2').css('color', 'blue');
		//			}
		//			$('#packCancelCheckPopupModal').modal('show');
		//		} else if (res.result == 'unlabel') {
		//			toastr.warning(res.message, '', {timeOut: 5000});
		//		} else if (res.result == 'fail') {
		//			toastr.warning(res.message, '', {timeOut: 5000});
		//		} else if (res.result == 'error') {
		//			toastr.error(res.message, '', {timeOut: 5000});
		//		} else {
		//			toastr.error(res.message, '알수없는 상태값 - 관리자 문의 요망', {timeOut: 5000});
		//		}
		//	},
		//	complete:function() {
		//		 $('#my-spinner').hide();
		//	}
	 	//});
    });

	//복원모달 복원 클릭 시
  	$('#btnPackCancelCheck').on('click', function() {
  		boxNoData = '';
		boxNoData = createBoxDataList();	//선택한 boxNo 중복없이 데이터생성
		if (boxNoData == '') {
			toastr.warning('복원할 포장번호를 선택해 주세요!');
			return false;
		}
		$('#my-spinner').show();
		useGoodsPackSystem('goodsProductUnPack');
		
	});
	
  	//복원모달 취소 클릭 시
  	$('btnPackCancelCancel').on('click', function() {
  		$('#packCancelCheckPopupModal').modal('hide');
  	});

	//에러복구 클릭 시
  	$('#btnPackError').on('click', function() {
  		$('#packErrorCheckPopupModal').modal('show');
    });

	//에러복구 복원 클릭 시
  	//$('#btnPackErrorCheck').on('click', function() {
  	//  	
  	//	btnAllDisabled(true);
    //
  	//	$.ajax({
	//	     url: '<c:url value="/po/goodsLabelPublishError"/>',
	//	     type: 'POST',
	//	     data: {
	//	     	'menuAuth'			: 		menuAuth,
	//	     	//'workOrdNo'   		:       workOrdNo,
	//	     	//'goodsCd'			: 		goodsCd,
	//	     	//'ordLotNo'			: 		ordLotNo,
	//	     	'packCnt'			: 		0, //packUnitCnt,		     		     	
	//	     	'appearOutputCnt'	: 		0, //appearOutputCnt,
	//	     	'appearAbrfCnt'		: 		0, //appearAbrfCnt,                
	//	     	'appearAbrsCnt'   	:       0, //appearAbrsCnt,
	//         	'appearDmsCnt'    	:       0, //appearDmsCnt,
	//         	'packDate' 			: 		function() { return ordDateCal.replace(/-/g, ''); },
	//	     },
	//	     beforeSend: function() {
	//	    	 $('#my-spinner').show();
	//	     },
	//	     success: function (res) {
	//	         let data = res.data;
	//	         if (res.result == 'ok') {
	//	       	   	toastr.success('정상적으로 오류 복구 되었습니다.');
	//	       		workOrdNo = data.workOrdNo;
	//	       		goodsCd = data.goodsCd;
	//	       		ordLotNo = data.ordLotNo;
	//	       		packUnitCnt = data.packCnt;    
	//	       		appearAbrfCnt = data.appearAbrfCnt;
	//	       		appearAbrsCnt = data.appearAbrsCnt;
	//	       		appearDmsCnt = data.appearDmsCnt;
	//	       		//appearOutputCnt = data.appearOutputCnt;
	//	       		outputCnt = data.outputCnt;
	//	       		totalInspectCnt = data.totalInspectCnt;
	//	       		userOutputCnt = data.userOutputCnt;
	//	       		totalFaultyCnt = data.totalFaultyCnt;
    //
	//	       		$("#workOrdNo").val(data.workOrdNo);
	//	       		$("#ordLotNo").val(data.ordLotNo);
	//	       		$("#goodsNm").val(data.goodsNm);
	//	       		$("#goodsCd").val(data.goodsCd);
	//	       		$("#packUnitCnt").val(data.packUnitNm);
	//	       		$("#outputCnt").val(data.totalCnt);
	//	       		$("#totalInspectCnt").val(data.totalCnt);
	//	       		$("#userOutputCnt").val(data.userOutputCnt);
	//	       		$("#totalFaultyCnt").val(data.totalFaultyCnt);
	//	       		$("#appearAbrfCnt").val(data.appearAbrfCnt);
	//	       		$("#appearAbrsCnt").val(data.appearAbrsCnt);
	//	       		$("#appearDmsCnt").val(data.appearDmsCnt);
	//	       		
	//	       		//ordDateCal = data.packDate;
	//	       		//$("#ordDate").val(ordDateCal);
	//	       		printYn = $("#printYn option:selected").val();
	//				$('#workOrderTable').DataTable().row.add({}).draw(false);
	//	         } else if(res.result == 'unlabel') { 
	//	        	 toastr.warning(res.message, '', {timeOut: 5000});
	//	         } else if(res.result == 'errorlabel') { 
	//	        	 toastr.error(res.message, '', {timeOut: 5000});
	//	     	 } else {
	//	     		toastr.error(res.message, '', {timeOut: 5000});
	//	         }
	//	         $('#my-spinner').hide();
	//	     },
	//	     complete:function(){
	//			$('#boxNo1Table').DataTable().ajax.reload( function () {});
	//			$('#boxNo2Table').DataTable().ajax.reload( function () {});
	//			$('#boxNo3Table').DataTable().ajax.reload( function () {});
	//			$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});
	//			//$('#unBoxNo1Table').DataTable().ajax.reload( function () {});
	//			//$('#unBoxNo2Table').DataTable().ajax.reload( function () {});
	//			//$('#unBoxNo3Table').DataTable().ajax.reload( function () {});
	//			btnAllDisabled(false);
	//			$('#my-spinner').hide();
	//	     }
	// 	});
  	//});

  	//에러복구 취소 클릭 시
  	//$('btnPackErrorCancel').on('click', function() {
  	//	$('#packErrorCheckPopupModal').modal('hide');
  	//});


	//포장 대기 복원 클릭 시
  	$('#btnWorkOrdLotNoUnpack').on('click', function() {
		if (workOrdLotNoDtl == null || workOrdLotNoDtl == '') {
			toastr.warning('포장 대기 복원할 생산LotNo를 선택해 주세요!', '', {timeOut: 7000});
			return false;
		}
		$('#unpackUnpackTitle').text('대상 생산LotNo : ' + workOrdLotNoDtl);
  		$('#unpackUnpackCheckPopupModal').modal('show');
  	});

	//포장 대기 복원 실행
	$('#btnWorkOrdLotNoUnpackCheck').on('click', function() {
		if (workOrdLotNoDtl == null || workOrdLotNoDtl == '') {
			toastr.warning('포장 대기 복원할 생산LotNo를 선택해 주세요!', '', {timeOut: 7000});
			return false;
		}

		$.ajax({
			url: '<c:url value="/po/workOrdLotNoUnpack"/>',
			type: 'POST',
			data: {
				'menuAuth'			: 		menuAuth,
				'workOrdLotNo' 		: 		function() { return workOrdLotNoDtl; },
				'packDtlCnt' 		: 		function() { return packDtlCnt; },
				'packRemainCnt' 	: 		function() { return packRemainCnt; },
			},
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					//이거 PULL받고 고쳐야함
					$('#barcodeWorkOrdLotNo').val(workOrdLotNoDtl);
			  		var press = jQuery.Event("keypress");
			  		press.ctrlKey = false;
			  		press.which = 13;
			  		$("#barcodeWorkOrdLotNo").trigger(press);
			  		
					toastr.success(res.message, '', {timeOut: 5000});
				} else if(res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if(res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#unBoxNoTotalTable').DataTable().ajax.reload( function () {});
				$('#unBoxNoTotalTableDtl').DataTable().clear().draw();
				btnAllDisabled(false);
		  		workOrdLotNoDtl = null;
		  		$('#workOrderTable').DataTable().ajax.reload();
				$('#my-spinner').hide();
			}
		});
	});
  	
  	$.fn.dataTable.ext.errMode = 'none';
	let boxNo1Table = $('#boxNo1Table').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
		//select: {
		//	style: 'os',
		//	info: false,
		//	toggleable : true,	//false시 초기화 후 선택안됨
        //},
		//scrollY : "600px",
		//lengthChange: false,
        //pageLength: 20,
        ajax: {
            url: '<c:url value="/po/goodsPackList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	:	menuAuth,
                //'ordLotNo'	:	function() { return ordLotNo; },
                'goodsCd'	:	function() { return goodsCd; }, 
                'ordGubun'	:	'001', 
                'printYn'	:	function() { return printYn; },
            	'packDate'	:	function() { return ordDateCal.replace(/-/g, ''); },
            },
        },
        rowId: 'boxNo',
		columns: [
			{
		    	data: "boxNo",
	    		render: function(data, type, row, meta) {
    				if(row['disuseYn'] == 'Y') {
    					let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					return html;
    				} else if(row['printYn'] == 'Y') {
    					let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					return html;
    				} else {
    					return data;
	    			}
	    		}
		    },
		    { data: 'workOrdLotNo' },
			{ data: 'packDtlCnt' },
		],
        columnDefs: [
        	{ targets: [0,1,2], className: 'text-center' },
        	{ targets: [2], render: $.fn.dataTable.render.number( ',' )},
        ],
		order: [
			//[ 0, 'desc' ],
		],
		drawCallback: function (row, data, index) {
			var sum1 = $('#boxNo1Table').DataTable().column(2,{ page: 'all'} ).data().sum();           
			$('#sum1').html(sum1.toLocaleString());
			$('#boxNo1Table tbody tr td').css('height','25px');
        },
        //분할 상태
        rowCallback: function (row, data) {
            if ( data.divisionYn == 'D' ) {
                $(row).addClass('skyYellow');
            } else if ( data.divisionYn == 'M' ) {
                $(row).addClass('skyBlue');
            }
        },
    });

  	$.fn.dataTable.ext.errMode = 'none';
	let boxNo2Table = $('#boxNo2Table').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
        //select: {
		//	style: 'os',
		//	info: false,
		//	toggleable : true,	//false시 초기화 후 선택안됨
        //},
		//scrollY : "600px",
		//lengthChange: false,
        //pageLength: 20,
        ajax: {
            url: '<c:url value="/po/goodsPackList"/>',
            type: 'GET',
            data: {
				'menuAuth'	:	menuAuth,
				//'ordLotNo'	:	function() { return ordLotNo; },
				'goodsCd'	:	function() { return goodsCd; },
				'ordGubun'	:	'002',
				'printYn'	:	function() { return printYn; },
				'packDate'	:	function() { return ordDateCal.replace(/-/g, ''); },
            },
        },
        rowId: 'boxNo',
		columns: [
			{
		    	data: "boxNo",
	    		render: function(data, type, row, meta) {	
    				if(row['disuseYn'] == 'Y') {
    					let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					return html;
    				} else if(row['printYn'] == 'Y') {
    					let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					return html;
    				} else {
    					return data;
	    			}
	    		}
		    },
		    { data: 'workOrdLotNo' },
			{ data: 'packDtlCnt' },
		],
        columnDefs: [
        	{ targets: [0,1,2], className: 'text-center' },
        	{ targets: [2] , render: $.fn.dataTable.render.number( ',' )},
        ],
		order: [
			//[ 0, 'desc' ],
		],
		drawCallback: function () {
            var sum3 = $('#boxNo2Table').DataTable().column(2,{ page: 'all'} ).data().sum();           
            $('#sum2').html(sum3.toLocaleString());
            $('#boxNo2Table tbody tr td').css('height','25px');
        },
		//분할 상태
        rowCallback: function (row, data) {
            if ( data.divisionYn == 'D' ) {
                $(row).addClass('skyYellow');
            } else if ( data.divisionYn == 'M' ) {
                $(row).addClass('skyBlue');
            }
        },
	});

  	$.fn.dataTable.ext.errMode = 'none';
	let boxNo3Table = $('#boxNo3Table').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
        //select: {
		//	style: 'os',
		//	info: false,
		//	toggleable : true,	//false시 초기화 후 선택안됨
        //},
		//scrollY : "600px",
		//lengthChange: false,
        //pageLength: 20,
        ajax: {
            url: '<c:url value="/po/goodsPackList"/>',
            type: 'GET',
            data: {
				'menuAuth'	:	menuAuth,
				//'ordLotNo'	:	function() { return ordLotNo; },
				'goodsCd'	:	function() { return goodsCd; },
				'ordGubun'	:	'003',
				'printYn'	:	function() { return printYn; },
				'packDate'	:	function() { return ordDateCal.replace(/-/g, ''); },
            },
        },
        rowId: 'boxNo',
		columns: [
			{
		    	data: "boxNo",
	    		render: function(data, type, row, meta) {	
    				if(row['disuseYn'] == 'Y') {
    					let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					return html;
    				} else if(row['printYn'] == 'Y') {
    					let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					return html;
    				} else {
    					return data;
	    			}
	    		}
		    },
		    { data: 'workOrdLotNo' },
			{ data: 'packDtlCnt' },
		],
        columnDefs: [
        	{ targets: [0,1,2], className: 'text-center' },
        	{ targets: [2] , render: $.fn.dataTable.render.number( ',' )},
        ],
		order: [
			//[ 0, 'desc' ],
		],
		drawCallback: function () {
            var sum3 = $('#boxNo3Table').DataTable().column(2,{ page: 'all'} ).data().sum();           
            $('#sum3').html(sum3.toLocaleString());
            $('#boxNo3Table tbody tr td').css('height','25px');
        },
		//분할 상태
        rowCallback: function (row, data) {
            if ( data.divisionYn == 'D' ) {
                $(row).addClass('skyYellow');
            } else if ( data.divisionYn == 'M' ) {
                $(row).addClass('skyBlue');
            }
        },
	});

	var tempPackAddArray = new Array();
	//해외1 미포장&폐기유무 확인
	$('#boxNo1Table tbody').on('click', 'tr', function () {
		//미포장 포장 선택O
		//if ($('#btnTempPackAdd').is(':checked')) {
		//	if ($(this).hasClass('selected')) {
		//		for (var i=0; i<tempPackAddArray.length; i++) {
		//			if (boxNo1Table.row(this).data().ordLotNo == tempPackAddArray[i].ordLotNo) {
		//				tempPackAddArray.splice(i, 1);
		//				break;
		//			}
		//		}
		//		$(this).removeClass('selected');
		//		
		//	} else {
		//		if ($(this).find("td:eq(0)").text() != '미포장') {
	    //    		toastr.warning("미포장 포장 체크 시 미포장 제품만 선택하실 수 있습니다!");
	    //    	} else if (boxNo1Table.row(this).data().disuseYn == 'Y') {
		//			toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
	    //    	} else if ($(this).hasClass("skyYellow")) {
		//			toastr.warning("분할된 제품은 선택하실 수 없습니다!");
		//		} else {
		//        	var tempPackDtlCntSum = 0;
		//        	if (tempPackAddArray.length > 0) {
		//	        	for (var i=0; i<tempPackAddArray.length; i++) {
		//        			tempPackDtlCntSum += tempPackAddArray[i].packDtlCnt;
		//		        }
		//	        }
		//        	//선택한 행만으로 포장이 가능할 경우
		//        	if (parseInt($('#packCnt').text()) < tempPackDtlCntSum) {
		//        		toastr.warning('선택되어있는 미포장 수량만으로 완제품을 1개 포장할 수 있습니다!', '', {timeOut: 5000});
		//	        	
		//	        } else {
		//	        	$(this).addClass('selected');
		//				if ($('#boxNo2Table tbody tr.selected').length > 0) {
		//					$('#boxNo2Table').find('tr.selected').removeClass('selected');
		//					tempPackAddArray = [];
		//				}
		//				if ($('#boxNo3Table tbody tr.selected').length > 0) {
		//					$('#boxNo3Table').find('tr.selected').removeClass('selected');
		//					tempPackAddArray = [];
		//				}
		//				
		//				var json=new Object();
		//				json.goodsCd = $("#selGoodsCd option:selected").val();
		//				json.workOrdNo = boxNo1Table.row(this).data().workOrdNo;
		//				json.ordLotNo = boxNo1Table.row(this).data().ordLotNo;
		//				json.packDtlCnt = boxNo1Table.row(this).data().packDtlCnt;
		//				json.ordGubun = '001';
		//				json.packUnitNm = $('#packCnt').text();
		//				tempPackAddArray.push(json);
		//			}
		//		}
		//	}
		//	
		////미포장 포장 선택X
		//} else {
			if ($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				ordLotNo = '';
				boxNo = '';
				goodsCd = '';
				goodsNm = '';
			} else {
				if ($(this).find("td:eq(0)").text() == '미포장') {
	        		toastr.warning("미포장 제품은 선택하실 수 없습니다!");
	        	} else if (boxNo1Table.row(this).data().disuseYn == 'Y') {
					toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
	        	} else if ($(this).hasClass("skyYellow")) {
					toastr.warning("분할된 제품은 선택하실 수 없습니다!");
				} else {
		        	$(this).addClass('selected');
		        	ordLotNo = boxNo1Table.row(this).data().ordLotNo;
		        	boxNo = boxNo1Table.row(this).data().boxNo;
		            goodsCd = boxNo1Table.row(this).data().goodsCd;
		            goodsNm = boxNo1Table.row(this).data().goodsNm;
		            boxTableNo = '해외1';
				}
	        }
		//}
    });
	
	//해외2 미포장&폐기유무 확인
	$('#boxNo2Table tbody').on('click', 'tr', function () {
		//미포장 포장 선택O
		//if ($('#btnTempPackAdd').is(':checked')) {
		//	if ($(this).hasClass('selected')) {
		//		for (var i=0; i<tempPackAddArray.length; i++) {
		//			if (boxNo2Table.row(this).data().ordLotNo == tempPackAddArray[i].ordLotNo) {
		//				tempPackAddArray.splice(i, 1);
		//				break;
		//			}
		//		}
		//		$(this).removeClass('selected');
		//		
		//	} else {
		//		if ($(this).find("td:eq(0)").text() != '미포장') {
	    //    		toastr.warning("미포장 포장 체크 시 미포장 제품만 선택하실 수 있습니다!");
	    //    	} else if ( boxNo2Table.row(this).data().disuseYn == 'Y' ) {
		//			toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
	    //    	} else if ($(this).hasClass("skyYellow")) {
		//			toastr.warning("분할된 제품은 선택하실 수 없습니다!");
		//		} else {
		//        	var tempPackDtlCntSum = 0;
		//        	if (tempPackAddArray.length > 0) {
		//	        	for (var i=0; i<tempPackAddArray.length; i++) {
		//        			tempPackDtlCntSum += tempPackAddArray[i].packDtlCnt;
		//		        }
		//	        }
		//        	//선택한 행만으로 포장이 가능할 경우
		//        	if (parseInt($('#packCnt').text()) < tempPackDtlCntSum) {
		//        		toastr.warning('선택되어있는 미포장 수량만으로 완제품을 1개 포장할 수 있습니다!', '', {timeOut: 5000});
		//	        	
		//	        } else {
		//	        	$(this).addClass('selected');
		//				if ($('#boxNo1Table tbody tr.selected').length > 0) {
		//					$('#boxNo1Table').find('tr.selected').removeClass('selected');
		//					tempPackAddArray = [];
		//				}
		//				if ($('#boxNo3Table tbody tr.selected').length > 0) {
		//					$('#boxNo3Table').find('tr.selected').removeClass('selected');
		//					tempPackAddArray = [];
		//				}
		//				
		//				var json=new Object();
		//				json.goodsCd = $("#selGoodsCd option:selected").val();
		//				json.workOrdNo = boxNo2Table.row(this).data().workOrdNo;
		//				json.ordLotNo = boxNo2Table.row(this).data().ordLotNo;
		//				json.packDtlCnt = boxNo2Table.row(this).data().packDtlCnt;
		//				json.ordGubun = '002';
		//				json.packUnitNm = $('#packCnt').text();
		//				tempPackAddArray.push(json);
		//			}
		//		}
		//	}
		//	
		////미포장 포장 선택X
		//} else {
			if ($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				ordLotNo = '';
				boxNo = '';
				goodsCd = '';
				goodsNm = '';
			} else {
				if ($(this).find("td:eq(0)").text() == '미포장') {
	        		toastr.warning("미포장 제품은 선택하실 수 없습니다!");
	        	} else if (boxNo2Table.row(this).data().disuseYn == 'Y') {
					toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
	        	} else if ($(this).hasClass("skyYellow")) {
					toastr.warning("분할된 제품은 선택하실 수 없습니다!");
				} else {
		        	$(this).addClass('selected');
		        	ordLotNo = boxNo2Table.row(this).data().ordLotNo;
		        	boxNo = boxNo2Table.row(this).data().boxNo;
		            goodsCd = boxNo2Table.row(this).data().goodsCd;
		            goodsNm = boxNo2Table.row(this).data().goodsNm;
		            boxTableNo = '해외2';
				}
	        }
		//}
    });
    
	//국내 미포장&폐기유무 확인
	$('#boxNo3Table tbody').on('click', 'tr', function () {
		//미포장 포장 선택O
		//if ($('#btnTempPackAdd').is(':checked')) {
		//	if ($(this).hasClass('selected')) {
		//		for (var i=0; i<tempPackAddArray.length; i++) {
		//			if (boxNo3Table.row(this).data().ordLotNo == tempPackAddArray[i].ordLotNo) {
		//				tempPackAddArray.splice(i, 1);
		//				break;
		//			}
		//		}
		//		$(this).removeClass('selected');
		//		
		//	} else {
		//		if ($(this).find("td:eq(0)").text() != '미포장') {
	    //    		toastr.warning("미포장 포장 체크 시 미포장 제품만 선택하실 수 있습니다!");
	    //    	} else  if (boxNo3Table.row(this).data().disuseYn == 'Y') {
		//			toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
	    //    	} else if ($(this).hasClass("skyYellow")) {
		//			toastr.warning("분할된 제품은 선택하실 수 없습니다!");
		//		} else {
		//        	var tempPackDtlCntSum = 0;
		//        	if (tempPackAddArray.length > 0) {
		//	        	for (var i=0; i<tempPackAddArray.length; i++) {
		//        			tempPackDtlCntSum += tempPackAddArray[i].packDtlCnt;
		//		        }
		//	        }
		//        	//선택한 행만으로 포장이 가능할 경우
		//        	if (parseInt($('#packCnt').text()) < tempPackDtlCntSum) {
		//        		toastr.warning('선택되어있는 미포장 수량만으로 완제품을 1개 포장할 수 있습니다!', '', {timeOut: 5000});
		//	        	
		//	        } else {
		//	        	$(this).addClass('selected');
		//				if ($('#boxNo1Table tbody tr.selected').length > 0) {
		//					$('#boxNo1Table').find('tr.selected').removeClass('selected');
		//					tempPackAddArray = [];
		//				}
		//				if ($('#boxNo2Table tbody tr.selected').length > 0) {
		//					$('#boxNo2Table').find('tr.selected').removeClass('selected');
		//					tempPackAddArray = [];
		//				}
		//				
		//				var json=new Object();
		//				json.goodsCd = $("#selGoodsCd option:selected").val();
		//				json.workOrdNo = boxNo3Table.row(this).data().workOrdNo;
		//				json.ordLotNo = boxNo3Table.row(this).data().ordLotNo;
		//				json.packDtlCnt = boxNo3Table.row(this).data().packDtlCnt;
		//				json.ordGubun = '003';
		//				json.packUnitNm = $('#packCnt').text();
		//				tempPackAddArray.push(json);
		//			}
		//		}
		//	}
		//	
		////미포장 포장 선택X
		//} else {
			if ($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				ordLotNo = '';
				boxNo = '';
				goodsCd = '';
				goodsNm = '';
			} else {
				if ($(this).find("td:eq(0)").text() == '미포장') {
	        		toastr.warning("미포장 제품은 선택하실 수 없습니다!");
	        	} else if ( boxNo3Table.row(this).data().disuseYn == 'Y' ) {
					toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
	        	} else if ($(this).hasClass("skyYellow")) {
					toastr.warning("분할된 제품은 선택하실 수 없습니다!");
				} else {
		        	$(this).addClass('selected');
		        	ordLotNo = boxNo3Table.row(this).data().ordLotNo;
		        	boxNo = boxNo3Table.row(this).data().boxNo;
		            goodsCd = boxNo3Table.row(this).data().goodsCd;
		            goodsNm = boxNo3Table.row(this).data().goodsNm;
		            boxTableNo = '국내';
				}
			}
		//}
    });

	
	$('#btnPrint').on('click', function() {
		if ($('#btnTempPackAdd').is(':checked')) {
			toastr.warning('미포장 포장 체크시 라벨인쇄를 할 수 없습니다!', '', {timeOut: 5000});
			$('#btnTempPackAdd').focus();
			return false;
		}
		
		boxNoData = '';
		boxNoData = createBoxDataList();	//선택한 boxNo 중복없이 데이터생성
        //console.log(boxNoData);

		if (boxNoData == '') {
			toastr.warning('인쇄할 포장번호를 선택해주세요!')
			return false;
		}
		
		$('#my-spinner').show();

		url = '<c:url value="/po/barcodePrint"/>';
		
		
		$.ajax({
			url : url,
            //url: '<c:url value="/po/barcodePrint"/>',
            type: 'POST',
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'boxDataArray'	 	: 		function() {return boxNoData;},
				/* 
            	'boxNo'				: 		function(){return boxNo;},
            	'ordGubun'  		: 		function(){return boxTableNo;},
            	'goodsCd'  			: 		function(){return goodsCd;},
            	'goodsNm'  			: 		function(){return goodsNm;},
            	 */
            },
			success: function (res) {
				if (res.result == 'ok') {
					//$('#boxNo1Table > tbody  > tr').each(function(index, tr) {
					//	if( boxNo == $(this).find("td:eq(0)").text()) {
					//		$(this).css("color", "blue");
					//		$(this).css("font-weight", "bold");
					//	}
					//})
					//$('#boxNo2Table > tbody  > tr').each(function(index, tr) {
					//	if( boxNo == $(this).find("td:eq(0)").text()) {
					//		$(this).css("color", "blue");
					//		$(this).css("font-weight", "bold");
					//	}
					//})
					//$('#boxNo3Table > tbody  > tr').each(function(index, tr) {
					//	if( boxNo == $(this).find("td:eq(0)").text()) {
					//		$(this).css("color", "blue");
					//		$(this).css("font-weight", "bold");
					//	}
					//})
					toastr.success("라벨이 발행되었습니다.");
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
					
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function() {
				$('#btnSearch').trigger('click');
				boxNo = '';
		        goodsCd = '';
		        goodsNm = '';
				$('#my-spinner').hide();
			}
		});
	});
	

	var url = '';
	
	$('#btnPrint3').on('click', function() {
		if ($('#btnTempPackAdd').is(':checked')) {
			toastr.warning('미포장 포장 체크시 라벨인쇄를 할 수 없습니다!', '', {timeOut: 5000});
			$('#btnTempPackAdd').focus();
			return false;
		}
		
		boxNoData = '';
		boxNoData = createBoxDataList();	//선택한 boxNo 중복없이 데이터생성
        //console.log(boxNoData);
        
		if (boxNoData == '') {
			toastr.warning('인쇄할 포장번호를 선택해주세요!')
			return false;
		}
		
		//var url = '';
		url = '';
		if (factoryCode == "001") {
			url = '<c:url value="/po/barcodePrint3"/>';
		} else if (factoryCode == "002" || factoryCode == "003") {
			url = '<c:url value="/po/barcodePrint3_F3"/>';
		} else {
			toastr.warning('잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!')
			return false;
		}
		
		$('#my-spinner').show();
		
		$.ajax({
            url: url,
            type: 'POST',
            async : false,
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'boxDataArray'	 	: 		function() {return boxNoData;},
				/* 
            	'boxNo'				: 		function(){return boxNo;},
            	'ordGubun'  		: 		function(){return boxTableNo;},
            	'goodsCd'  			: 		function(){return goodsCd;},
            	'goodsNm'  			: 		function(){return goodsNm;},
            	 */
            },
			success: function (res) {
				if (res.result == 'ok') {
					if (factoryCode == "001") {
						toastr.success("라벨이 발행되었습니다.");
					} else if (factoryCode == "002" || factoryCode == "003") {
						labelPrint(res.printList);
					} else {
						toastr.warning('잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!')
						return false;
					}
					//$('#boxNo1Table > tbody  > tr').each(function(index, tr) {
					//	if( boxNo == $(this).find("td:eq(0)").text()) {
					//		$(this).css("color", "blue");
					//		$(this).css("font-weight", "bold");
					//	}
					//})
					//$('#boxNo2Table > tbody  > tr').each(function(index, tr) {
					//	if( boxNo == $(this).find("td:eq(0)").text()) {
					//		$(this).css("color", "blue");
					//		$(this).css("font-weight", "bold");
					//	}
					//})
					//$('#boxNo3Table > tbody  > tr').each(function(index, tr) {
					//	if( boxNo == $(this).find("td:eq(0)").text()) {
					//		$(this).css("color", "blue");
					//		$(this).css("font-weight", "bold");
					//	}
					//})
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
					
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#btnSearch').trigger('click');
				boxNo = '';
		        goodsCd = '';
		        goodsNm = '';
				$('#my-spinner').hide();
			}
		});
	});
	
   	function uiProc(flag)
   	{
        $("#barcodeNo").attr("disabled",flag);                
        $("#btnDelete").attr("disabled",flag); 
        $("#btnSave").attr("disabled",flag);       
        $("#barcodeNo").val("");
   	}
   	
/* 	//WebSocket settings
   	JSPM.JSPrintManager.auto_reconnect = true;
   	JSPM.JSPrintManager.start();
   	JSPM.JSPrintManager.WS.onStatusChanged = function () {
   	    if (jspmWSStatus()) {
   	        //get client installed printers
   	        JSPM.JSPrintManager.getPrinters().then(function (myPrinters) {
   	            var options = '';
   	            for (var i = 0; i < myPrinters.length; i++) {
   	                options += '<option>' + myPrinters[i] + '</option>';
   	            }
   	            $('#installedPrinterName').html(options);
   	        });
   	    }
   	};

   	//Check JSPM WebSocket status
   	function jspmWSStatus() {
   	    if (JSPM.JSPrintManager.websocket_status == JSPM.WSStatus.Open)
   	        return true;
   	    else if (JSPM.JSPrintManager.websocket_status == JSPM.WSStatus.Closed) {
   	        alert('JSPrintManager (JSPM) is not installed or not running! Download JSPM Client App from https://neodynamic.com/downloads/jspm');
   	        return false;
   	    }
   	    else if (JSPM.JSPrintManager.websocket_status == JSPM.WSStatus.Blocked) {
   	        alert('JSPM has blocked this website!');
   	        return false;
   	    }
   	}

   	//Do printing...
   	function print() {
   	    if (jspmWSStatus()) {
   	        //Create a ClientPrintJob
   	        var cpj = new JSPM.ClientPrintJob();
   	        //Set Printer type (Refer to the help, there many of them!)
   	        if ($('#useDefaultPrinter').prop('checked')) {
   	            cpj.clientPrinter = new JSPM.DefaultPrinter();
   	        } else {
   	            cpj.clientPrinter = new JSPM.InstalledPrinter($('#installedPrinterName').val());
   	        }
   	        //Set content to print...

		console.log("boxNo :" + boxNo);
		var cmds  = "{D0720,1010,0500|}" //인쇄시작 사이즈(외관 포함)
			cmds += "{AY;+04,0|}";
			cmds += "{AX;-020,+000,+00|}";
			cmds += "{C|}";
			cmds += image      //이미지    x 700 y 120 가로 230px 세로 68px";
			cmds += image2     //이미지    x 427 y 330 가로 208px 세로 208px";
			cmds += "{LC;0015,0045,1000,0495,1,5|}";	//라인두께 5로 네모를 그린다.";
			cmds += "{LC;0015,0220,1000,0220,0,4|}";
			cmds += "{LC;0690,0270,1000,0270,0,4|}";
			cmds += "{LC;0690,0045,0690,0495,0,4|}";	//세로줄";
			cmds += "{PV01;0030,0080,0040,0040,01,0,+000,00,B=SPECIFICATION|}";
			cmds += "{PV11;0025,0260,0040,0040,01,0,+000,00,B=LOT NO : -|}";
			cmds += "{PV12;0025,0375,0030,0040,01,0,+000,00,B=포장번호 : " + boxNo +  "|}";
			cmds += "{PV13;0025,0485,0040,0040,01,0,+000,00,B=TYPE   : " + boxTableNo + " |}";
			cmds += "{PV22;0725,0260,0050,0040,01,0,+000,00,B=APPROVED|}";            
			cmds += "{PV23;" + descLocation + ",0035,0035,01,0,+000,00,B=" + desc + "|}";
			cmds += "{PV24;" + matrlNmLocation + ",0040,0040,01,0,+000,00,B=(" + matrlNm + ")|}";
			cmds += "{PV24;0730,00115,0030,0030,01,0,+000,00,B= " + boxNo + "|}";
			cmds += "{XB03;0765,0055,9,3,01,0,0030|}";	//바코드 설정 9:128
			cmds += "{RB03;"+boxNo+"|}";	//바코드 출력
			cmds += "{XS;I,0001,0002C4001|}";
   	        cpj.printerCommands = cmds;
   	        
   	        //Send print job to printer!
   	        cpj.sendToClient();
   	        toastr.success("라벨이 발행되었습니다.");
   	    }
   	}
 */
   	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});
   		
 	// 바코드인쇄2 클릭 시
	var matrlNm = null;
	var matrlNmLocation = null;
	var goodsNm = null;
	var disuseYn = null;
	var desc = null;
	var descLocation = null;
	var image = null;
	var image2 = null;
	/* 
  	$('#btnPrint2').on('click', function() {

  	  	//자재명 판단  	  	
  	  	if (goodsCd.substr(0,1) == "A"){
  	  		desc = "Cathode Tab";
  	  		descLocation = "0750,0375";
  	  		matrlNm = "Al";
  	  		matrlNmLocation = "0815,0425";
  	  	} else if (goodsCd.substr(0,1) == "N"){
  	  		desc = "Anode Tab"; 
  	  		descLocation = "0765,0375";
  	  		matrlNm = "NiCu";
  	  		matrlNmLocation = "0795,0425";
  	  	}

  	  	//제품별 이미지 판단
  	  	//이미지 형식 bmp 필수
  	  	//이미지    x 700 y 120 가로 230px 세로 68px"; 
		//이미지    x 427 y 330 가로 208px 세로 208px";

  		if( goodsNm.indexOf("DE/SK") != -1) {
  	  		console.log("DE/SK");
  			image = "{XQ;01,0,L|}";
  			image2= "{XQ;02,0,L|}";
  		}
  		else if( goodsNm.indexOf("E370") != -1) {
  			console.log("E370");
  			image = "{XQ;03,0,L|}";
  			image2= "{XQ;04,0,L|}";
  		}
  		else if( goodsNm.indexOf("HE370") != -1) {
  			//image = "{XQ;05,0,L|}";
  			//image2= "{XQ;06,0,L|}";
  		}
  		else if( goodsNm.indexOf("N60") != -1) {
  			//image = "{XQ;07,0,L|}";
  			//image2= "{XQ;08,0,L|}";
  		}
  		else if( goodsNm.indexOf("H200") != -1) {
  			image = "{XQ;09,0,L|}";
  			image2= "{XQ;10,0,L|}";
  		}
  		else if( goodsNm.indexOf("P260") != -1) {
  			image = "{XQ;11,0,L|}";
  			image2= "{XQ;12,0,L|}";
  		}
  		else if( goodsNm.indexOf("P395") != -1) {
  			//image = "{XQ;13,0,L|}";
  			//image2= "{XQ;14,0,L|}";
  		}
  		else if( goodsNm.indexOf("E623") != -1) {
  			//image = "{XQ;15,0,L|}";
  			//image2= "{XQ;16,0,L|}";
  		}
  		else if( goodsNm.indexOf("E556") != -1) {
  			//image = "{XQ;17,0,L|}";
  			//image2= "{XQ;18,0,L|}";
  		}
  		else if( goodsNm.indexOf("P740") != -1) {
  			//image = "{XQ;19,0,L|}";
  			//image2= "{XQ;20,0,L|}";
  		}
  		else if( goodsNm.indexOf("PSEV") != -1) {
  			//image = "{XQ;21,0,L|}";
  			//image2= "{XQ;22,0,L|}";
  		}
  		print();
    });
	*/

	$(document).on('keyup','.userOutputCnt', function(event) {
		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 189)	) {
			$('.number-float0').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
			toastr.warning('양수(+)만 입력해주세요.');
			$(this).val("0");
 			$(this).select();
			event.preventDefault();
			return false;
		}
    
		//selectIndex = $('#workOrderTable').find('tr.selected').index();
		
		//사용자 입력 양품수량
		var userOutputCnt = removeCommas($("#workOrderTable").find(".selected").find('#userOutputCnt').val());
		//alert(appearOutputCnt);
		
 		var temp = $(this).val();
 		temp = removeCommas(temp);
		
 		if ($(this).attr("maxlength") < temp.length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
		if ( event.which == 110 || event.which == 190 ) {
			toastr.warning('정수만 입력 가능합니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
		var _pattern2 = /^\d*[.]\d{1}$/;
        if (_pattern2.test( temp)) {
        	toastr.warning("정수만 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}
 		//if ( parseFloat(userOutputCnt) < parseFloat(temp)) {
 		if ( parseFloat(userOutputCnt) > parseFloat(99999)) {
 			toastr.warning('최대 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;1
		}
 		if ( parseFloat('0') > parseFloat(temp)) {
 			toastr.warning('최소 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
		
        $(this).val(addCommas(temp));
	});

	function btnAllDisabled(flag){
		$("#btnSearch").attr("disabled", flag);
		$("#btnPackAdd").attr("disabled", flag);
		$("#btnPackCancel").attr("disabled", flag); 
		$("#btnPrint").attr("disabled", flag);
		$("#btnPrint3").attr("disabled", flag);
		//$("#btnPackError").attr("disabled",flag);
	}

	$('#btnClear').on('click', function(){
		$('#btnSearch').trigger('click');
	});

	$.fn.dataTable.ext.errMode = 'none';
	let unBoxNoTotalTable = $('#unBoxNoTotalTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
		ajax: {
			url: '<c:url value="/po/goodsUnPackList"/>',
			type: 'GET',
			data: {
				'menuAuth'	:	menuAuth,
				'goodsCd'	:	function() { return goodsCd; },
			},
		},
		rowId: 'boxNo',
		columns: [
			//{
			//	render: function(data, type, row, meta) {
			//		return '<input type="checkbox" id="packCheck-' + meta.row + '"name=packCheck style=width:25px;height:25px;">' ;
			//	}
			//},
			//{
			//	data: "workOrdNo",
			//	render: function (data, type, row, meta) {
			//		return meta.row + 1;
			//	}
			//},
			{ data: 'goodsNm' },
			{ data: 'workOrdLotNo' },
			{ data: 'packDtlCnt' },
			{ data: 'packRemainCnt' },
		],
		columnDefs: [
			{ targets: [0,1,2,3], className: 'text-center' },
			{ targets: [2,3] , render: $.fn.dataTable.render.number( ',' )},
		],
		order: [
			//[ 0, 'desc' ],
		],
		drawCallback: function (row, data, index) {
			var unBoxAdmPackSum = $('#unBoxNoTotalTable').DataTable().column(2, { page:'all'}).data().sum();
			var unBoxAdmRemainSum = $('#unBoxNoTotalTable').DataTable().column(3, { page:'all'}).data().sum();           
			$('#unBoxAdmPackSum').html(unBoxAdmPackSum.toLocaleString());
			$('#unBoxAdmRemainSum').html(unBoxAdmRemainSum.toLocaleString());
			$('#unBoxNoTotalTable tbody tr td').css('height','35px');
		},
    });

	var workOrdLotNoDtl = null;
	var packDtlCnt = null;
	var packRemainCnt = null;
    $('#unBoxNoTotalTable tbody').on('click', 'tr', function () {
    	//미포장 포장 선택O
		if ($('#btnTempPackAdd').is(':checked')) {
			//if (!$('input:radio[name=ordGubunCheck]').is(':checked')) {
			//	toastr.warning('포장할 오더구분을 선택해 주세요!', '', {timeOut: 7000});
			//	return false;
			//}
        	//var tempPackDtlCntSum = 0;
        	//var tempPackUnitNm = 0;
        	//if (tempPackAddArray.length > 0) {
	        //	for (var i=0; i<tempPackAddArray.length; i++) {
        	//		tempPackDtlCntSum += tempPackAddArray[i].packDtlCnt;
        	//		tempPackUnitNm = tempPackAddArray[i].packUnitNm;
		    //    }
	        //}
            //
        	////지금까지 선택 행의 잔여수량 % 포장수량 + 지금 선택 한 행의 잔여수량 < 완제품수량 일경우()
        	//parseInt(tempPackDtlCntSum % tempPackUnitNm) + unBoxNoTotalTable.row(this).data().packRemainCnt;
        	
			$('input:radio[name=ordGubunCheck]').attr('disabled', true);
			
			
			if ($(this).hasClass('selected')) {
				for (var i=0; i<tempPackAddArray.length; i++) {
					if (unBoxNoTotalTable.row(this).data().workOrdLotNo == tempPackAddArray[i].workOrdLotNo) {
						tempPackAddArray.splice(i, 1);
						break;
					}
				}
				$(this).removeClass('selected');
				
			} else {
				//if ($(this).find("td:eq(0)").text() != '미포장') {
	        	//	toastr.warning("미포장 포장 체크 시 미포장 제품만 선택하실 수 있습니다!");
	        	//} else if (unBoxNoTotalTable.row(this).data().disuseYn == 'Y') {
				//	toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
	        	//} else if ($(this).hasClass("skyYellow")) {
				//	toastr.warning("분할된 제품은 선택하실 수 없습니다!");
				//} else {
		        	//var tempPackDtlCntSum = 0;
		        	//if (tempPackAddArray.length > 0) {
			        //	for (var i=0; i<tempPackAddArray.length; i++) {
		        	//		tempPackDtlCntSum += tempPackAddArray[i].packDtlCnt;
				    //    }
			        //}
		        	////선택한 행만으로 포장이 가능할 경우
		        	//if (parseInt($('#packCnt').text()) < tempPackDtlCntSum) {
		        	//	toastr.warning('선택되어있는 미포장 수량만으로 완제품을 1개 포장할 수 있습니다!', '', {timeOut: 5000});
			        //	
			        //} else {
			        	$(this).addClass('selected');
						//if ($('#unBoxNoTotalTable tbody tr.selected').length > 0) {
						//	$('#unBoxNoTotalTable').find('tr.selected').removeClass('selected');
						//	tempPackAddArray = [];
						//}
						//if ($('#unBoxNoTotalTable tbody tr.selected').length > 0) {
						//	$('#unBoxNoTotalTable').find('tr.selected').removeClass('selected');
						//	tempPackAddArray = [];
						//}
						
						var json=new Object();
						//json.goodsCd = $("#selGoodsCd option:selected").val();
						json.goodsCd = unBoxNoTotalTable.row(this).data().goodsCd;
						json.goodsNm = unBoxNoTotalTable.row(this).data().goodsNm;
						//json.ordGubun = $("input[name='ordGubunCheck']:checked").val();
						json.workOrdNo = unBoxNoTotalTable.row(this).data().workOrdNo;
						json.workOrdLotNo = unBoxNoTotalTable.row(this).data().workOrdLotNo;
						json.packDtlCnt = unBoxNoTotalTable.row(this).data().packDtlCnt;
						json.packRemainCnt = unBoxNoTotalTable.row(this).data().packRemainCnt;
						json.ordGubun001 = 0;
						json.ordGubun002 = 0;
						json.ordGubun003 = 0;
						//json.ordGubun = '001';
						json.packUnitNm = $('#packCnt').text();
						tempPackAddArray.push(json);
					//}
				//}
			}
			var sumPackRemainCnt = 0;
			var tempPackUnitNm = 0;
			$('#packWorkOrdLotNoList > tbody').empty();	//초기화
			for (let i=0; i<tempPackAddArray.length; i++) {
				let html = "<tr><td class='text-center'>" + (parseInt(i) + 1) + "</td>";
					html += "<td class='text-center'>" + tempPackAddArray[i].goodsNm + "</td>";
					html += "<td class='text-center'>" + tempPackAddArray[i].workOrdLotNo + "</td>";
					html += "<td class='text-center'>" + addCommas(tempPackAddArray[i].packDtlCnt) + "</td>";
					//if (agtEquipList[i].ordGubun == 'D') {
					//	/* html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>"; */
					//	html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
					//} else if (agtEquipList[i].ordGubun == 'N') {
					//	/* html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>"; */
					//	html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
					//} else {
					//	/* html += "<td class='text-center'>" + agtEquipList[i].ordLotNo + "</td>"; */
					//	html += "<td class='text-center'>" + agtEquipList[i].workOrdNo + "</td>";
					//}
					html += "<td class='text-center'>" + addCommas(tempPackAddArray[i].packRemainCnt) + "</td>";
					html += "</tr>" 
					sumPackRemainCnt += tempPackAddArray[i].packRemainCnt;
					tempPackUnitNm = tempPackAddArray[i].packUnitNm;
				$('#packWorkOrdLotNoList').append(html);
			}

			if (parseInt(sumPackRemainCnt) != 0) {
				$('#countPackBoxNo').text(parseInt(sumPackRemainCnt / tempPackUnitNm));
				$('#countPackRemainCnt').text(addCommas(parseInt(sumPackRemainCnt % tempPackUnitNm)));
			} else {
				$('#countPackBoxNo').text('-');
				$('#countPackRemainCnt').text('-');
			}
			//console.log(sumPackRemainCnt);
			//console.log(parseInt(sumPackRemainCnt / tempPackUnitNm));
			//console.log(parseInt(sumPackRemainCnt % tempPackUnitNm));
			//console.log(tempPackAddArray);
		
		//미포장 포장 선택X
		} else {
			if ($(this).hasClass('selected')) {
	    		$(this).removeClass('selected');
	    	} else {
	    		$('#unBoxNoTotalTable').DataTable().$('tr.selected').removeClass('selected');
	    		$(this).addClass('selected');
	    		workOrdLotNoDtl = unBoxNoTotalTable.row(this).data().workOrdLotNo;
	    		packDtlCnt = unBoxNoTotalTable.row(this).data().packDtlCnt;
	    		packRemainCnt = unBoxNoTotalTable.row(this).data().packRemainCnt; 
	    		$('#unBoxNoTotalTableDtl').DataTable().ajax.reload( function () {});
	    	}
		}
	});
	
	//생산LotNo기준 미포장전표목록
	$.fn.dataTable.ext.errMode = 'none';
	let unBoxNoTotalTableDtl = $('#unBoxNoTotalTableDtl').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
		ajax: {
			url: '<c:url value="/po/goodsUnPackListDtl"/>',
			type: 'GET',
			data: {
				'menuAuth'		:	menuAuth,
				'goodsCd'		:	function() { return goodsCd; },
				'workOrdLotNo'	:	function() { return workOrdLotNoDtl; },
			},
		},
		columns: [
			//{
			//	data: "workOrdNo",
			//	render: function (data, type, row, meta) {
			//		return meta.row + 1;
			//	}
			//},
			{ data: 'workOrdLotNo' },
			{
		    	data: "packNumber",
	    		render: function(data, type, row, meta) {
   					if (data == 'UNP') {
    					let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">복원</p>';
    					return html;
    				} else {
    					return data;
	    			}
	    		}
		    },
			{ data: 'packDtlCnt' },
			{ data: 'packRemainCnt' },
		],
		columnDefs: [
			{ targets: [0,1,2,3], className: 'text-center' },
			{ targets: [2,3] , render: $.fn.dataTable.render.number( ',' )},
		],
		order: [
			//[ 0, 'desc' ],
		],
		drawCallback: function (row, data, index) {
			var unBoxDtlSum = $('#unBoxNoTotalTableDtl').DataTable().column(2, { page:'all'}).data().sum();
			var unBoxDtlRemainSum = $('#unBoxNoTotalTableDtl').DataTable().column(3, { page:'all'}).data().sum();           
			$('#unBoxDtlSum').html(unBoxDtlSum.toLocaleString());
			$('#unBoxDtlRemainSum').html(unBoxDtlRemainSum.toLocaleString());
		},
    });


	
	$.fn.dataTable.ext.errMode = 'none';
	let checkUnPackListTable = $('#checkUnPackListTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
		//select: {
		//	style: 'os',
		//	info: false,
		//	toggleable : true,	//false시 초기화 후 선택안됨
        //},
		//scrollY : "600px",
		//lengthChange: false,
        //pageLength: 20,
        ajax: {
            url: '<c:url value="/po/checkUnPackList"/>',
            type: 'GET',
            data: {
				'menuAuth'		:	menuAuth,
				'boxNoData' 	:	function() { return boxNoData; },
            },
        },
        rowId: 'boxNo',
		columns: [
			{
		    	data: "boxNo",
	    		render: function(data, type, row, meta) {	
    				if(row['disuseYn'] == 'Y') {
    					let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					return html;
    				} else if(row['printYn'] == 'Y') {
    					let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					return html;
    				} else {
    					return data;
	    			}
	    		}
		    },
		    { data: 'workOrdLotNo' },
		    { data: 'goodsNm' },
		    { data: 'packDtlCnt' },
			{ data: 'ordGubunNm' },
		],
        columnDefs: [
        	{ targets: [0,1,2,4], className: 'text-center' },
        	{ targets: [3], className: 'text-right' },
        	{ targets: [3], render: $.fn.dataTable.render.number( ',' )},
        ],		
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function (row, data, index) {
			var checkUnPackSum = $('#checkUnPackListTable').DataTable().column(3, { page:'all'}).data().sum();           
			$('#checkUnPackSum').html(addCommas(checkUnPackSum));
		},
    });
    
	/*
	$.fn.dataTable.ext.errMode = 'none';
	let unBoxNo1Table = $('#unBoxNo1Table').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
		ajax: {
			url: '<c:url value="/po/goodsUnPackList"/>',
			type: 'GET',
			data: {
				'menuAuth'	:	menuAuth,
				'goodsCd'	:	function() { return goodsCd; },
				'ordGubun'	:	'001',
			},
		},
		rowId: 'boxNo',
		columns: [
			//{
		    //	data: "boxNo",
			//	render: function(data, type, row, meta) {
			//		return '미포장';
			//	}
			//},
			{ data: 'goodsNm' },
			{ data: 'workOrdLotNo' },
			{ data: 'packDtlCnt' },
		],
		columnDefs: [
			{ targets: [0,1,2], className: 'text-center' },
			{ targets: [2] , render: $.fn.dataTable.render.number( ',' )},
		],
		order: [
			//[ 0, 'desc' ],
		],
		drawCallback: function (row, data, index) {
			var unBoxSum1 = $('#unBoxNo1Table').DataTable().column(2, { page:'all'}).data().sum();           
			$('#unBoxSum1').html(unBoxSum1.toLocaleString());
		},
    });

	$.fn.dataTable.ext.errMode = 'none';
	let unBoxNo2Table = $('#unBoxNo2Table').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
		ajax: {
			url: '<c:url value="/po/goodsUnPackList"/>',
			type: 'GET',
			data: {
				'menuAuth'	:	menuAuth,
				'goodsCd'	:	function() { return goodsCd; },
				'ordGubun'	:	'002',
			},
		},
		rowId: 'boxNo',
		columns: [
			//{
		    //	data: "boxNo",
			//	render: function(data, type, row, meta) {
			//		return '미포장';
			//	}
			//},
			{ data: 'goodsNm' },
			{ data: 'workOrdLotNo' },
			{ data: 'packDtlCnt' },
		],
		columnDefs: [
			{ targets: [0,1,2], className: 'text-center' },
			{ targets: [2] , render: $.fn.dataTable.render.number( ',' )},
		],
		order: [
			//[ 0, 'desc' ],
		],
		drawCallback: function (row, data, index) {
			var unBoxSum2 = $('#unBoxNo2Table').DataTable().column(2, { page:'all'}).data().sum();           
			$('#unBoxSum2').html(unBoxSum2.toLocaleString());
		},
    });

	$.fn.dataTable.ext.errMode = 'none';
	let unBoxNo3Table = $('#unBoxNo3Table').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
		ajax: {
			url: '<c:url value="/po/goodsUnPackList"/>',
			type: 'GET',
			data: {
				'menuAuth'	:	menuAuth,
				'goodsCd'	:	function() { return goodsCd; },
				'ordGubun'	:	'003',
			},
		},
		rowId: 'boxNo',
		columns: [
			//{
		    //	data: "boxNo",
			//	render: function(data, type, row, meta) {
			//		return '미포장';
			//	}
			//},
			{ data: 'goodsNm' },
			{ data: 'workOrdLotNo' },
			{ data: 'packDtlCnt' },
		],
		columnDefs: [
			{ targets: [0,1,2], className: 'text-center' },
			{ targets: [2] , render: $.fn.dataTable.render.number( ',' )},
		],
		order: [
			//[ 0, 'desc' ],
		],
		drawCallback: function (row, data, index) {
			var unBoxSum3 = $('#unBoxNo3Table').DataTable().column(2, { page:'current'}).data().sum();           
			$('#unBoxSum3').html(unBoxSum3.toLocaleString());
		},
    });
    */
	
	/* 
	var wsManager = new WebSocket("ws://localhost:8181");
	
	wsManager.onopen = function(message){
	   console.log('websocket onopen');
	};
	// 소켓 접속이 끝나면 호출되는 함수
	wsManager.onclose = function(message){
	   console.log('websocket onclose: ' + message);
	   
	   $('#serverDownModal').on('hidden.bs.modal', function (e) {
	      console.log('hidden');
	      window.location.reload();
	   });
	   
	   $('#serverDownModal').modal('show');
	   
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	wsManager.onerror = function(message){
	   console.log('websocket onerror');
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	wsManager.onmessage = function(message){
	   console.log('onmessage : ' + message);
	};
	// 서버로 메시지를 전송하는 함수
	function sendMessage(cmd){
		if(wsManager.readyState == 1) {
	      console.log('cmd : ' + cmd);
	      wsManager.send(cmd);
	   } else {
	      console.log('연결 끊김');
	   }
	}

	var cmd  = "{D0720,1010,0500|}" //인쇄시작 사이즈(외관 포함)
		cmd += "{AY;+04,0|}";
		cmd += "{AX;-020,+000,+00|}";
		cmd += "{C|}";
		cmd += "{XQ;01,0,L|}";
		cmd += "{XQ;02,0,L|}";
		cmd += "{LC;0015,0045,1000,0495,1,5|}";	//라인두께 5로 네모를 그린다.";
		cmd += "{LC;0015,0220,1000,0220,0,4|}";
		cmd += "{LC;0690,0270,1000,0270,0,4|}";
		cmd += "{LC;0690,0045,0690,0495,0,4|}";	//세로줄";
		cmd += "{PV01;0030,0080,0040,0040,01,0,+000,00,B=SPECIFICATION|}";
		cmd += "{PV11;0025,0260,0040,0040,01,0,+000,00,B=LOT NO : -|}";
		cmd += "{PV12;0025,0375,0030,0040,01,0,+000,00,B=포장번호 : 박스번호 |}";
		cmd += "{PV13;0025,0485,0040,0040,01,0,+000,00,B=TYPE   : 오더구분 |}";
		cmd += "{PV22;0725,0260,0050,0040,01,0,+000,00,B=APPROVED|}";            
		//cmd += "{PV23;" + descLocation + ",0035,0035,01,0,+000,00,B= 기타 |}";
		//cmd += "{PV24;" + matrlNmLocation + ",0040,0040,01,0,+000,00,B=(" + matrlNm + ")|}";
		cmd += "{PV24;0730,00115,0030,0030,01,0,+000,00,B= 박스번호|}";
		cmd += "{XB03;0765,0055,9,3,01,0,0030|}";	//바코드 설정 9:128
		cmd += "{RB03;박스번호|}";	//바코드 출력
		cmd += "{XS;I,0001,0002C4001|}";

	var cmdArr = new Array(); // 설비분류
	cmdArr.push(cmd);
		
	var obj = {
			mesGubun	: "100",
			printCd		: "100",
			printVer	: "",
			printNo		: "1",
			printNm		: "TOSHIBA",
			cmdCnt 		: 1,	//명령어 반복 횟수
			cmd			: cmdArr,
			reseverd1	: "",
			reseverd2	: "",
			reseverd3	: "",
			reseverd4	: "",
			reseverd5	: "",
			reseverd6	: "",
			reseverd7	: ""
	};
	 */
	
	//sendMessage(cmd);
	//sendMessage(obj);
	
	
	//var send = JSON.stringify(obj);
      
	//console.log(send);
	 
	//sendMessage(send);
	
	//cmdCnt = 1;
	//cmd = [""];
	//printVer = "";
	//printNo = "1";
	//console.log('라벨인쇄');
	
	//var longclick;
	//포장 분할 기능(1초이상 길게 클릭시)

	//$('#boxNo1Table tbody, #boxNo2Table tbody, #boxNo3Table tbody').on('mousedown', 'tr', function () {
    //
    //	let divisionBoxNo = $(this).attr('id');									//선택 boxNo
    //	let boxNoTableId = $(this).parent().parent().attr('id');				//선택 boxNo의 table구분
    //	let rowNumber = $('#'+boxNoTableId).find("#"+divisionBoxNo).index();	//해당 boxNo의 아이디로 row번호를 찾음
    //	
    //    longclick = setTimeout(function() {
    //        //폐기유무 확인
    //    	if ( boxNoTableId == 'boxNo1Table' ){
    //    		if (boxNo1Table.row(rowNumber).data().disuseYn == 'Y') {
    //    			toastr.warning("폐기된 제품은 분할 할 수 없습니다!");
    //    			return false;
    //        	}
    //		} else if ( boxNoTableId == 'boxNo2Table' ){
    //			if (boxNo2Table.row(rowNumber).data().disuseYn == 'Y') {
    //    			toastr.warning("폐기된 제품은 분할 할 수 없습니다!");
    //    			return false;
    //        	}
    //		} else if ( boxNoTableId == 'boxNo3Table' ){
    //			if (boxNo3Table.row(rowNumber).data().disuseYn == 'Y') {
    //    			toastr.warning("폐기된 제품은 분할 할 수 없습니다!");
    //    			return false;
    //        	}
    //		}
    //        
	//		$.ajax({
	//            url: '<c:url value="po/divisionBoxNoCheck"/>',
	//            type: 'GET',
	//            data: {
	//            	'menuAuth'	 	: 		menuAuth,
	//            	'boxNo'			: 		function() { return divisionBoxNo; },
	//            },
	//			success: function (res) {
	//				let data = res.data;//체크는 하지만 실제 분할 할때 같은 goodCd, boxNo인지, 혼합되었는지 다시 검증 해야함
    //
	//				//최초 분할 시
	//				if (res.result == 'ok') {
	//					toastr.success(res.message);
	//					//$('#divisonBoxNolabel').html('포장 분할 - ' + divisionBoxNo);
	//					$('#divisonBoxNoModal').modal('show');
	//					$('#divisionGoodsCd').val(data[0].goodsCd);
	//					$('#divisionOrdGubun').val(data[0].ordGubun);
	//					
	//					$('#divisionWorkOrdNo').text(data[0].ordLotNo);
	//					$('#orignalBoxNo').text(data[0].boxNo);
	//					$('#divisionGoodsNm').text(data[0].goodsNm);
	//					$('#divisionOrdGubunNm').text(data[0].ordGubunNm);
	//					$('#divisionPackDtlCnt').text(data[0].packDtlCnt);
    //
	//					$('#divisionPackCnt1').attr("max", data[0].packDtlCnt);
	//					$('#divisionPackCnt2').attr("max", data[0].packDtlCnt);
	//					$('#divisionPackCnt1').val("0");
	//					$('#divisionPackCnt2').val("0");
	//					$('#divisionBoxNo1').text("?");
	//					$('#divisionBoxNo2').text("?");
	//					$("#btnDivisonCheck").attr("disabled", false);
	//					$("#divisionPackCnt1").attr("disabled", false);
	//					$("#divisionPackCnt2").attr("disabled", false);
	//					$("#btnDivisionPrint1").addClass("d-none");
	//					$("#btnDivisionPrint2").addClass("d-none");
	//					$("#btnDivisionPackCancel").addClass("d-none");
	//					$("#choosePrintLocation").addClass("d-none");
    //
	//				//분할 제품 선택 시
	//				} else if ( res.result == 'print' ){
	//					toastr.success(res.message);
	//					$('#divisonBoxNoModal').modal('show');
	//					$('#divisionGoodsCd').val(data[0].goodsCd);
	//					$('#divisionOrdGubun').val(data[0].ordGubun);
	//					
	//					$('#divisionWorkOrdNo').text(data[0].ordLotNo);
	//					$('#orignalBoxNo').text(data[0].orignalBoxNo);
	//					$('#divisionGoodsNm').text(data[0].goodsNm);
	//					$('#divisionOrdGubunNm').text(data[0].ordGubunNm);
	//					$('#divisionPackDtlCnt').text(data[0].packUnitNm);						
    //
	//					$('#divisionPackCnt1').val(res.data[0].packCnt);
	//					$('#divisionPackCnt2').val(res.data[1].packCnt);
	//					$('#divisionBoxNo1').text(res.data[0].boxNo);
	//					$('#divisionBoxNo1').css({"color":"black", "font-size":"20px"});
	//					$('#divisionBoxNo2').css({"color":"black", "font-size":"20px"});
	//					if ( res.data[0].printYn == 'Y' ){
	//						$('#divisionBoxNo1').css({"color":"blue", "font-size":"20px"});
	//					}
	//					if ( res.data[1].printYn == 'Y' ){
	//						$('#divisionBoxNo2').css({"color":"blue", "font-size":"20px"});
	//					}
	//					$('#divisionBoxNo2').text(res.data[1].boxNo);
	//					$("#btnDivisonCheck").attr("disabled", true);
	//					$("#divisionPackCnt1").attr("disabled", true);
	//					$("#divisionPackCnt2").attr("disabled", true);
	//					$("#btnDivisionPrint1").removeClass("d-none");
	//					$("#btnDivisionPrint2").removeClass("d-none");
	//					$("#btnDivisionPackCancel").removeClass("d-none");
	//					$("#choosePrintLocation").removeClass("d-none");
	//					$("#choosePrintLocation").val("");
	//					
	//				} else if ( res.result == 'fail' ){
	//					toastr.warning(res.message);
    //
	//				//새로고침이 필요한 경우
	//				} else if ( res.result == 'researchFail' ){
	//					toastr.warning(res.message);
	//					printYn = $("#printYn option:selected").val();
	//					$('#boxNo1Table').DataTable().ajax.reload( function () {});
	//					$('#boxNo2Table').DataTable().ajax.reload( function () {});
	//					$('#boxNo3Table').DataTable().ajax.reload( function () {});
    //
	//				} else {
	//					toastr.error(res.message);
	//				}
	//			},
	//			complete:function(){
	//				//$('#searchDay').val("true")
	//			}
	//		});
    //
	//	} , 1000);
	//	
	//	return false;
	//});

	//$('#boxNo1Table tbody, #boxNo2Table tbody, #boxNo3Table tbody').on('mouseup', 'tr', function () {
	//    clearTimeout(longclick);
	//});

	//$('#btnDivisonCheck').on('click', function(){
	//	if ($('#divisionPackCnt1').val() == "0"){
	//		toastr.warning("첫번째 분할 포장수량을 입력해주세요!");
	//		$('#divisionPackCnt1').select();
	//		return false;
	//	}
	//	if ($('#divisionPackCnt2').val() == "0"){
	//		toastr.warning("두번째 분할 포장수량을 입력해주세요!");
	//		$('#divisionPackCnt2').select();
	//		return false;
	//	}
	//	if ( parseInt($('#divisionPackCnt1').val()) + parseInt($('#divisionPackCnt2').val()) != parseInt($('#divisionPackDtlCnt').text()) ) {
	//		toastr.warning("합계 포장수량이 " + $('#divisionPackDtlCnt').text() +"이 아닙니다.<br> 수량을 확인해주세요!");
	//		$('#divisionPackCnt1').select();
	//		return false;
	//	}
    //
    //
	//	$.ajax({
    //        url: '<c:url value="/po/divisionBoxNo"/>',
    //        type: 'GET',
    //        data: {
    //        	'menuAuth'	 		: 		menuAuth,
    //        	'boxNo'				: 		function() { return $('#orignalBoxNo').text(); },		//원장 boxNo
    //        	'goodsCd'			: 		function() { return $('#divisionGoodsCd').val(); },		//제품번호
    //        	'ordGubun'			: 		function() { return $('#divisionOrdGubun').val(); },	//오더구분
    //        	'ordLotNo'			: 		function() { return $('#divisionWorkOrdNo').text(); },	//작지번호
    //        	//'packDtlCnt'		: 		function() { return $('#divisionPackDtlCnt').text(); },	//포장수량
    //        	'divisionPackCnt1'	: 		function() { return $('#divisionPackCnt1').val(); },	//원장 분할포장수량
    //        	'divisionPackCnt2'	: 		function() { return $('#divisionPackCnt2').val(); },	//서브 분할포장수량
    //        },
	//		success: function (res) {
	//			let data = res.data;//체크는 하지만 실제 분할 할때 같은 goodCd, boxNo인지, 혼합되었는지 다시 검증 해야함
	//			if (res.result == 'ok') {
	//				toastr.success(res.message);
	//				$('#divisionBoxNo1').text(res.divisionBoxNo1);
	//				$('#divisionBoxNo2').text(res.divisionBoxNo2);
	//				$("#divisionPackCnt1").attr("disabled", true);
	//				$("#divisionPackCnt2").attr("disabled", true);
	//				$("#btnDivisonCheck").attr("disabled", true);
    //
	//				
	//			} else if ( res.result == 'fail' ){
	//				toastr.warning(res.message, '', {timeOut: 5000});
	//			//새로고침이 필요한 경우
	//			} else if ( res.result == 'researchFail' ){
	//				toastr.warning(res.message, '', {timeOut: 5000});
	//			} else {
	//				toastr.error(res.message);
	//			}
	//		},
	//		complete:function(){
	//			printYn = $("#printYn option:selected").val();
	//			$('#boxNo1Table').DataTable().ajax.reload( function () {});
	//			$('#boxNo2Table').DataTable().ajax.reload( function () {});
	//			$('#boxNo3Table').DataTable().ajax.reload( function () {});
	//		}
	//	});
	//});
	
	//분할포장 입력 예외처리(정수만)
	$('.number-float0_2').keyup(function (event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109)	) {
			toastr.warning('양수(+)만 입력해주세요.');
			$(this).val("");
			$(this).val("0");
 			$(this).select();
			event.preventDefault();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}

 		var temp = $(this).val();
 		temp = removeCommas(temp);
		
 		if ($(this).attr("maxlength") < temp.length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat(temp)) {
 			toastr.warning('최대 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat(temp)) {
 			toastr.warning('최소 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
		if ( event.which == 110 || event.which == 190 ) {
			toastr.warning('정수만 입력 가능합니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
		// .개수 세기
		if ( $(this).val().split('.').length > 1  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		var _pattern2 = /^\d*[.]\d{1}$/;
        if (_pattern2.test( temp)) {
        	toastr.warning("정수만 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}

        //$(this).val() = addCommas(temp);
	});

	//분할인쇄1 클릭 시
	//$('#btnDivisionPrint1').on('click', function(){
    //    if ( $("#choosePrintLocation option:selected").val() == "" ) {
    //        toastr.warning('인쇄 위치를 선택해 주세요.');
    //        $('#choosePrintLocation').focus();
    //        return false;
    //    }
    //    
	//	$('#my-spinner').show();
	//	
	//	$.ajax({
	//        url: '<c:url value="/po/divisionPrint"/>',
	//        type: 'POST',
	//        data: {
	//        	'menuAuth'				: 		menuAuth,
	//        	'boxNo' 				: 		function(){ return $("#divisionBoxNo1").text(); },
	//        	'choosePrintLocation'	:		function(){ return $("#choosePrintLocation option:selected").val(); },
	//        },
	//		success: function (res) {
	//			if (res.result == 'ok') {
	//				$('#divisionBoxNo1').css({"color":"blue", "font-size":"20px"});
	//				toastr.success("라벨이 발행되었습니다.");
	//			} else {
	//				toastr.error(res.message, '', {timeOut: 5000});
	//			}
	//		},
	//		complete:function(){
	//			$('#my-spinner').hide();
	//		}
	//	});
	//});

	//분할인쇄2 클릭 시
	//$('#btnDivisionPrint2').on('click', function(){
    //    if ( $("#choosePrintLocation option:selected").val() == "" ) {
    //        toastr.warning('인쇄 위치를 선택해 주세요.');
    //        $('#choosePrintLocation').focus();
    //        return false;
    //    }
    //    
	//	$('#my-spinner').show();
	//	
	//	$.ajax({
	//        url: '<c:url value="/po/divisionPrint"/>',
	//        type: 'POST',
	//        data: {
	//        	'menuAuth'				: 		menuAuth,
	//        	'boxNo' 				: 		function(){ return $("#divisionBoxNo2").text(); },
	//        	'choosePrintLocation'	:		function(){ return $("#choosePrintLocation option:selected").val(); },
	//        },
	//		success: function (res) {
	//			if (res.result == 'ok') {
	//				$('#divisionBoxNo2').css({"color":"blue", "font-size":"20px"});
	//				toastr.success("라벨이 발행되었습니다.");
	//			} else {
	//				toastr.error(res.message, '', {timeOut: 5000});
	//			}
	//		},
	//		complete:function(){
	//			$('#my-spinner').hide();
	//		}
	//	});
	//});


	//포장 분할 취소
	//$('#btnDivisionPackCancel').on('click', function(){
    //
	//	$('#my-spinner').show();
	//	
	//	$.ajax({
    //        url: '<c:url value="/po/divisionBoxNoCancle"/>',
    //        type: 'GET',
    //        data: {
    //        	'menuAuth'	 		: 		menuAuth,
	//			'boxNo'				: 		function() { return $('#orignalBoxNo').text(); },		//원장 boxNo
    //        	'goodsCd'			: 		function() { return $('#divisionGoodsCd').val(); },		//제품번호
    //        	'ordGubun'			: 		function() { return $('#divisionOrdGubun').val(); },	//오더구분
    //        	'ordLotNo'			: 		function() { return $('#divisionWorkOrdNo').text(); },	//작지번호
    //        },
	//		success: function (res) {
	//			let data = res.data;
	//			if (res.result == 'ok') {
	//				$('#divisonBoxNoModal').modal('hide');
	//				printYn = $("#printYn option:selected").val();
	//				$('#boxNo1Table').DataTable().ajax.reload( function () {});
	//				$('#boxNo2Table').DataTable().ajax.reload( function () {});
	//				$('#boxNo3Table').DataTable().ajax.reload( function () {});
	//				toastr.success(res.message);
	//			} else if ( res.result == 'fail' ){
	//				toastr.warning(res.message, '', {timeOut: 5000});
	//			//새로고침이 필요한 경우
	//			} else if ( res.result == 'researchFail' ){
	//				toastr.warning(res.message, '', {timeOut: 5000});
	//			} else {
	//				toastr.error(res.message);
	//			}
	//		},
	//		complete:function(){
	//			$('#my-spinner').hide();
	//		}
	//	});
	//});
	
	//선택한 포장번호 데이터로생성	
	function createBoxDataList() {
		var tempBoxData = '';
        $('#boxNo1Table > tbody > tr').each(function(index, tr) {
			if( $(this).hasClass('selected') ) {
				boxNo = $(this).find("td:eq(0)").text();
				//혼합 BoxNo를 다중선택시 중복인쇄 방지
				tempBoxData = tempBoxData.replace("/" + boxNo, "");
				tempBoxData += "/" + boxNo;
			}
		})
		$('#boxNo2Table > tbody > tr').each(function(index, tr) {
			if( $(this).hasClass('selected') ) {
				boxNo = $(this).find("td:eq(0)").text();
				//혼합 BoxNo를 다중선택시 중복인쇄 방지
				tempBoxData = tempBoxData.replace("/" + boxNo, "");
				tempBoxData += "/" + boxNo;
			}
		})
		$('#boxNo3Table > tbody > tr').each(function(index, tr) {
			if( $(this).hasClass('selected') ) {
				boxNo = $(this).find("td:eq(0)").text();
				//혼합 BoxNo를 다중선택시 중복인쇄 방지
				tempBoxData = tempBoxData.replace("/" + boxNo, "");
				tempBoxData += "/" + boxNo;
			}
		})

		return tempBoxData;
	}
	
	/*****************************웬소켓 프린터 인쇄 시작****************************/
	let labelArray = new Array();
	var paperSize = null;
	var printCnt = null;
	var printOrder = null;
	var printCnt = 1;
	var printVer = "";
	var printNo = "1";
	var strPrintText = [""];
	
	//Do printing...
	function labelPrint(printList) {
		// 0 boxNo - 1 제품정보 - 2 lotNo1 - 3 lotNo2 - 4 lotNo3 - 5 TYPE	- 6 setpAvg	- 7 desc - 8 workOrdCnt - 9 packUnitNm - 10 image
	    sendJson(printList);
	}
	function sendJson(printList) {
		var obj = {
				printCnt : printList.length,
				printLalCnt : 0,
				data : printList,
				paperSize : "97_47",
				printOrder : 0,
				company : "SLD",
				reseverd4 : "",
				reseverd5 : "",
				reseverd6 : "",
				reseverd7 : ""
		};
		var send = JSON.stringify(obj);
		//console.log(send);
		sendMessage(send);
	
		printCnt = 1;
		labelArray = [];
		printVer = "";
		printNo = "1";
		paperSize = "";
		//console.log('라벨인쇄');
	}

	if (factoryCode == "002" || factoryCode == '003') {
		//웹 서버를 접속한다.
		var webSocket = new WebSocket("ws://localhost:8181");
		// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
		var messageTextArea = document.getElementById("installedPrinterName");
	}
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		if (factoryCode == "002" || factoryCode == '003') {
			toastr.success('인쇄 서버에 연결되었습니다.')
			$('#wsStateView').text('연결됨');
			$('#wsStateView').css('color','#19FF00');
		}
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		if (factoryCode == "002" || factoryCode == '003') {
			toastr.error('인쇄 서버가 종료되었습니다.')
			$('#wsStateView').text('연결끊김');
			$('#wsStateView').css('color','#FF0004');
		}
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		if (factoryCode == "002" || factoryCode == '003') {
			toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
		}
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		if (factoryCode == "002" || factoryCode == '003') {
			if(message.data == "이 문자열이 보이면 성공!") {
				toastr.success("라벨이 발행되었습니다.");
			} else {
				toastr.warning("오류가 발생하였습니다.");
			}
		}
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

	/*****************************웬소켓 프린터 인쇄 끝****************************/
	
	//화상키보드 기능
	
	$('input[name=userOutputCnt]').on('click', function(){
		console.log("asdla");
		$('#screenKeyboard').removeClass('d-none');
	});
	
	
	//화상키보드 기능
    
</script>
</body>
</html>
