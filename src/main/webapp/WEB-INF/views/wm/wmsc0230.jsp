<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%pageContext.setAttribute("newLineChar", "\n");%>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">월별FP현황</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="row">
					<div class="row col-sm-6" style="margin-bottom:5px;">
						&nbsp;<label class="input-label-sm">계획 월</label>
						<input type="date" class="form-control mr-1" id="inWhsDateCal" style="width:130px;"></input>
					
	    				<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv">조회</button>
	    				
	    				&nbsp;<label class="input-label-sm gubun d-none">숨기기</label>
						<input type="checkbox" class="form-control mr-1 gubun d-none" id="gubun" style="width:24px;">
						&nbsp;<label class="input-label-sm gubun d-none">(DualCapa, TacTime, Second)</label>
	    				
	    				

	    			</div>
	    			<div class="col-sm-6" style="margin-bottom:5px;">	    				    			
	    				<button type="button" class="btn btn-primary float-right mr-1" id="btnTheory">목표</button>
	    				<button type="button" class="btn btn-primary float-right mr-1" id="btnDailyInven">기종별 일일재고 예상실적 입력</button>
	    				<button type="button" class="btn btn-primary float-right mr-1" id="btnDailyInvenReal">전월재고 입력</button>
					   
	    			</div>
	    		</div>
	    		<div class="card-header card-tab">
					<ul class="nav nav-tabs card-header-tabs">
						<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">일일실적</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">기종별</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">FP</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">기종별 일일재고</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab5">기종별 일일재고 예상실적</a></li>
					
					</ul>
				</div>
				<div id="tab1View">
					<div class="table-responsive" style="padding-bottom: 5px;">
						<table id="productionPlanMainTable" class="table table-bordered">
							
							<thead class="thead-light">
								<tr id="planHeaderMain"></tr>
								
								
							</thead>
						</table>
						<br><br>
						<div class="row">
						<div class="col-sm-6">
							<table id="yoyack" class="table table-bordered">
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>최고기록수량(New record)</th>
										<td id="data1"></td>
										<th>최고기록(가동률)</th>
										<td id="data2"></td>
									</tr>								
									<tr>
										<th>일시</th>
										<td id="data3"></td>
										<th>일시</th>
										<td id="data4"></td>
									</tr>	
									<tr>
										<th>전일 주간 근무자</th>
										<td id="data5"></td>
										<th>주간 장비 가동 대수</th>
										<td id="data6"></td>
									</tr>
									<tr>
										<th>전일 야간 근무자</th>
										<td id="data7"></td>
										<th>야간 장비 가동 대수</th>
										<td id="data8"></td>
									</tr>					
									
									
								</thead>
							</table>
							
						</div>
						<div class="col-sm-6">
						<table id="yoyack2" class="table table-bordered">
								<colgroup>
									<col width="33%">
									<col width="33%">
									<col width="33%">						
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>이론 CAPA</th>
										<th>설비 수</th>
										<th>수량</th>							
									</tr>
									<tr>
										<td id="theoryCapaRead"></td>
										<td id="theoryEquipCntRead"></td>
										<td id="theoryPlanCntRead"></td>					
									</tr>
									<tr>
										<th>목표수량</th>
										<th>설비 수</th>
										<th>수량</th>							
									</tr>
									<tr>
										<td id="dualCapaRead"></td>
										<td id="equipCntRead"></td>
										<td id="planCntRead"></td>						
									</tr>				
									
									
								</thead>
							</table>
						</div>
						</div>
						
					</div>
					
				</div>
				
				<div id="tab2View" class="d-none">
					<div class="secondTable" style="padding-bottom: 5px;">
						<table id="productionPlanGijongTable" class="table table-bordered">
							
							<thead class="thead-light">
								<tr id="planHeaderGijong"></tr>
							</thead>
							<tfoot>
									<tr>
										<td>합계</td>										
										<td></td>			
										<td colspan="" id="sumEquip" style="text-align: right">0</td>
										<td></td>									
										<td colspan="" id="sumGijong" style="text-align: right">0</td>										
										<c:forEach var="item" begin="1" end="31" step="1">
									        <td colspan="" id="faulty${item}" style="text-align: right">0</td>	
								    	</c:forEach>
								    </tr>
							</tfoot>
						</table>
					</div>
				</div>
				<div id="tab3View"  class="d-none">
					<div class="thirdTable" style="padding-bottom: 5px;">
						<table id="productionPlanDtlTable" class="table table-bordered">
							
							<thead class="thead-light">
								<tr id="planHeaderDtl"></tr>								
							</thead>
						</table>
					</div>
				</div>
				<div id="tab4View" class="d-none">
					<div class="fourthTable" style="padding-bottom: 5px;">
						<table id="gijongDailyTable" class="table table-bordered">
							
							<thead class="thead-light">
								<tr id="planHeaderGijongDaily"></tr>
							</thead>
						
						</table>
						<div class="row">
						<div class="col-sm-6">
							
						</div>
						<div class="col-sm-6">
							<table id="gijongDailySumTable" class="table table-bordered">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">								
					
							</colgroup>	
							<thead class="thead-light">			
													
							<tr>
								<th>AL</th>
								<td id="alRealSum"></td>
								<th>재고일수</th>
								<td id="alRealStock"></td>
							</tr>
							<tr>
								<th>NICU</th>
								<td id="niRealSum"></td>
								<th>재고일수</th>
								<td id="niRealStock"></td>
							</tr>	
							<tr>	
								<th>출하실적</th>
								<td id="outputRealSum"></td>						
								<th>합계 재고일수</th>
								<td id="niRealStockSum"></td>
							</tr>	
							</thead>			
							</table>
						</div>
						</div>
						
					</div>
				</div>
				<div id="tab5View" class="d-none">
					<div class="fifthTable" style="padding-bottom: 5px;">
						<table id="gijongDailyTable2" class="table table-bordered">
							
							<thead class="thead-light">
								<tr id="planHeaderGijongDaily2"></tr>
							</thead>
						
						</table>
						
						<div class="row">
						<div class="col-sm-6">
							
						</div>
						<div class="col-sm-6">
							<table id="gijongDailySumTable2" class="table table-bordered">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">								
					
							</colgroup>	
							<thead class="thead-light">			
													
							<tr>
								<th>AL</th>
								<td id="alPlanSum"></td>
								<th>재고일수</th>
								<td id="alPlanStock"></td>
							</tr>
							<tr>
								<th>NICU</th>
								<td id="niPlanSum"></td>
								<th>재고일수</th>
								<td id="niPlanStock"></td>
							</tr>	
							<tr>	
								<th>출하실적</th>
								<td id="outputPlanSum"></td>						
								<th>합계 재고일수</th>
								<td id="niPlanStockSum"></td>
							</tr>	
							</thead>			
							</table>
						</div>
						</div>
					</div>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->


<!-- 목표 모달 시작 -->
<div class="modal fade" id="theoryPopupModal" tabindex="-1" role="dialog" aria-labelledby="theoryPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:750px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="theoryModalLabel">목표수량입력</h5>			
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			
			<div class="modal-body">
					
							<button type="button" class="btn btn-primary float-right" id="btnLoading"  style="min-width: 70px; margin-bottom:5px;">불러오기</button>	
					
					<table id="theoryInputTable" class="table table-bordered">
						<tr>
							<th>이론 CAPA</th>
							<th>설비 수</th>
							<th>수량</th>							
						</tr>
						<tr>
							<td><input type="text" class="form-control text-right number-float0" id="theoryCapa" value="0"></td>
							<td><input type="text" class="form-control text-right number-float0" id="theoryEquipCnt" value="0"></td>
							<td><input type="text" class="form-control text-right number-float0" id="theoryPlanCnt" value="0"></td>						
						</tr>
						<tr>
							<th>목표수량</th>
							<th>설비 수</th>
							<th>수량</th>							
						</tr>
						<tr>
							<td><input type="text" class="form-control text-right number-float0" id="dualCapa" value="0"></td>
							<td><input type="text" class="form-control text-right number-float0" id="equipCnt" value="0"></td>
							<td><input type="text" class="form-control text-right number-float0" id="planCnt" value="0"></td>							
						</tr>
					</table>					
				
			</div>
			<div class="modal-footer">
				
				<button type="button" class="btn btn-primary mr-2" id="btnSave"   data-dismiss="modal" style="min-width: 70px;">저장</button>				
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 목표 모달 끝 -->

<!-- 기종별 일일재고 모달 시작 -->
<%-- <div class="modal fade" id="dailyInvenPopupModal" tabindex="-1" role="dialog" aria-labelledby="dailyInvenPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="dailyInvenModalLabel">기종별 일일재고</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="">							
    				<label class="input-label-sm float-left ml-3">일자</label>
    				<input type="month" class="form-control float-left ml-3"  style="width:120px;" id="invenDate" value="" >	    	
    				<button type="button" class="btn btn-primary float-left ml-1" name="modalRetv" id="modelRetv">조회</button>
    				
					<button type="button" class="btn btn-warning float-right mr-1" name="rowDelete" id="rowDelete" value="">열삭제</button>
					<button type="button" class="btn btn-primary float-right mr-1" name="rowAdd" id="rowAdd" value="">열추가</button>	
					<button type="button" class="btn btn-primary float-right mr-1" name="btnCreateStock" id="btnCreateStock">월마감</button>				
				</div>
					<br>
					<br>
				<div class="col-sm-12">	
					<table class="table table-bordered">
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="24%">						
						
								</colgroup>
								<thead>
									<tr>								
										<th>제품명</th>
										<td><select id="goodsCdGj" class="custom-select"></select></td>																
										<th>전월재고</th>		
										<td><input type="text" class="form-control number-float0" id="lastMonthStock" value="0"  style="border:none; width:100%;"></td>															
									</tr>
								</thead>
					</table>
				</div>						

					<div class="">							
					
						<table class="table table-bordered" id="dailyInvenTable">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">								
					
							</colgroup>
							<thead>
								<tr>
									<th>납품처</th>																
									<th>구분</th>
									<th>일자</th>
									<th>수량</th>													
								</tr>
							</thead>
						</table>
					</div>
				
				<br>			
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-1" id="btnSaveDailyInven" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				
			</div>
		</div>
	</div>
</div> --%>
<!-- 기종별 일일재고 모달 끝 -->
<!-- 작업자 등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="planManPopUpModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="planManPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin-right: 60%;">
		<div class="modal-content" style="width: 315%;">
			<div class="modal-header">
				<h5 class="modal-title">예상실적 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">				
				<!-- .table-responsive -->
				<div class="">							
    				<label class="input-label-sm float-left ml-3">일자</label>
    				<input type="month" class="form-control float-left ml-3"  style="width:120px;" id="invenDate" value="" >	    	
    				<button type="button" class="btn btn-primary float-left ml-1" name="modalRetv" id="modelRetv">조회</button>
    				
					<button type="button" class="btn btn-warning float-right mr-1" name="rowDelete" id="rowDelete" value="">열삭제</button>
					<button type="button" class="btn btn-primary float-right mr-1" name="rowAdd" id="rowAdd" value="">열추가</button>	
						
				</div>
					<br>
					<br>
				<div class="planManModal" style="height: 78vh; border-bottom: 1px solid #e3e3e3;" id="planManDiv">			
					<table id="planManTable" class="table table-bordered" style="text-align: center">						
						<thead class="thead-light">
							<tr id="planHeaderMan"></tr>
						</thead>						
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary float-right mr-1" id="btnSaveDailyInven" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnInAddCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 작업자 등록 모달 종료 -->

<!-- 기종별 일일재고(실데이터) 모달 시작 -->
<div class="modal fade" id="dailyInven2PopupModal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="dailyInven2PopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="dailyInven2ModalLabel">실데이터 전월재고</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="">							
    				<label class="input-label-sm float-left ml-3">일자</label>
    				<input type="month" class="form-control float-left ml-3"  style="width:120px;" id="invenDateReal" value="" >	    	
    				<button type="button" class="btn btn-primary float-left ml-1" name="modalRetvReal" id="modelRetvReal">조회</button>
    				
    				<button type="button" class="btn btn-primary float-right mr-1" name="btnCreateStockReal" id="btnCreateStockReal">월마감</button> 	
    				<button type="button" class="btn btn-danger float-right mr-1" name="btnDeleteStockReal" id="btnDeleteStockReal">삭제</button> 		
    		
				</div>
					<br>
					<br>
				<div class="col-sm-12">	
					<table class="table table-bordered">
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="24%">						
						
								</colgroup>
								<thead>
									<tr>								
										<th>제품명</th>
										<td><select id="goodsCdGjReal" class="custom-select"></select></td>																
										<th>전월재고</th>		
										<td><input type="text" class="form-control number-float0" id="lastMonthStockReal" value="0"  style="border:none; width:100%;"></td>															
									</tr>
								</thead>
					</table>
				</div>	
				<br>			
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-1" id="btnSaveDailyInven2" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				
			</div>
		</div>
	</div>
</div>
<!-- 기종별 일일재고 모달 끝 -->
<!-- 메모 모달 시작-->
<div class="modal fade" id="memoPopUpModal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="memoPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog style="min-width:650px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="memoPopUpLabel">메모</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<textarea class="form-control dayText day touch3" style="max-width:100%; height:300px; padding-bottom: 0px; resize:none; font-size: 18px;" id="memo" name="memo" maxlength="400" placeholder="최대 글자 수 400자"></textarea>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6"  id="btnMemoSave" data-dismiss="modal" style="min-width:70px;">저장</button>
				<button type="button" class="btn btn-secondary touch6" data-dismiss="modal" style="min-width:70px;">닫기</button>				
			</div>
		</div>
	</div>
</div>
<!-- 메모 모달 종료-->

<%@include file="../layout/bottom.jsp"%>

<style>

#planHeaderGijong th:first-child { position: sticky; left: 0; z-index: 1;}
#planHeaderGijong th:nth-child(2) { position: sticky; left: 112px; z-index: 1;}
#productionPlanGijongTable td:first-child { position: sticky; left: 0; z-index: 1;}
#productionPlanGijongTable td:nth-child(2) { position: sticky; left: 112px; z-index: 1;}



</style>


<script>

	let menuAuth = 'wmsc0230';
	let currentHref = 'wmsc0230';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","월별FP현황");	
    var inWhsDateCal = "${serverDate}";  

	var temp = true;
	let editGubun = false;
	//var aa = 0;
	var dayCount = 0;	//해당 월의 일자 수
	let alRealData = 0; //al 재고 합계
	let niRealData = 0; //ni 재고 합계
	let alEquipCntReal = 0; //운영대수 합계
	let niEquipCntReal = 0; //운영대수 합계
	let dataSumsubReal = 0; //합계 합계
	let outputSumReal = 0; //출하실적 합계

	let alPlanData = 0; //al 재고 합계
	let niPlanData = 0; //ni 재고 합계
	let alEquipCntPlan = 0; //운영대수 합계
	let niEquipCntPlan = 0; //운영대수 합계
	let dataSumsubPlan = 0; //합계 합계
	let outputSumPlan = 0; //출하실적 합계
	

	//공통코드 시작
	var goodsCodeList = new Array();
    <c:forEach items="${goodsCodeList}" var="info">
	var json = new Object();
	json.baseCd="${info.goodsCd}";
	json.baseCdNm="${info.goodsNm}";
	goodsCodeList.push(json);
	</c:forEach>

	var goodsCodeList2 = new Array();
    <c:forEach items="${goodsCodeList}" var="info">
	var json = new Object();
	json.baseCd="${info.goodsCd}";
	json.baseNm="${info.goodsNm}";
	goodsCodeList2.push(json);
	</c:forEach>
	
	var outGubunCode = new Array();
	var json = new Object();
	json.baseCd="001";
	json.baseNm="출하계획";
	outGubunCode.push(json);
	json = new Object();
	json.baseCd="002";
	json.baseNm="출하실행";
	outGubunCode.push(json);
	
	
	$('#my-spinner').show();

    var equipCodeList = new Array();
    let tableIdx = '';
    let selectedTab = 'tab1View';
	let equipCd = '';
	let goodsCd = '';
	let planDate = '';
	let countNm = '';
	let memoGubun = '';
	let gubun = '001';

	
	//월별 일자 생성
	createHeader();
	createHeaderGijong();
	createHeaderDtl();
	createHeaderDaily1();
	createHeaderDaily2();
	createHeaderMan();
	
    // 목록
	$.fn.dataTable.ext.errMode = 'none';


	let monthProductPresentTableOrigin = $('#productionPlanMainTable').parent().html();
	let monthProductPresentTable = monthProductPresentTableFunc();
	

	let monthProductPresentTableOrigin2 = $('#productionPlanGijongTable').parent().html();
	let monthProductPresentTable2; //= monthProductPresentTableFunc2();


	let monthProductPresentTableOrigin3 = $('#productionPlanDtlTable').parent().html();
	let monthProductPresentTable3;// = monthProductPresentTableFunc3();

	let monthProductPresentTableOrigin4 = $('#gijongDailyTable').parent().html();
	let monthProductPresentTable4;// = monthProductPresentTableFunc3();

	let monthProductPresentTableOrigin5 = $('#gijongDailyTable2').parent().html();
	let monthProductPresentTable5;// = monthProductPresentTableFunc3();

	let monthProductPresentTableOrigin6 = $('#planManTable').parent().html();
	let monthProductPresentTable6;
	
	
	$('#inWhsDateCal').val(inWhsDateCal);
	 selectBoxAppend(goodsCodeList, "goodsCdGj", "" , "2");
	 selectBoxAppend(goodsCodeList, "goodsCdGjReal", "" , "2");


    $('#btnRetv').on('click', function() {

    	$('#my-spinner').show();
    	//$('[data-toggle="popover"]').popover('hide');
    	inWhsDateCal =  $('#inWhsDateCal').val();
    	temp = true;
    	if(selectedTab == 'tab1View'){
    		$('.table-responsive').html(monthProductPresentTableOrigin);
        	createHeader().then(()=>{
    		
           		monthProductPresentTable = monthProductPresentTableFunc();       	
            });
        	
            
        } else if(selectedTab == 'tab2View'){
        	$('.secondTable').html(monthProductPresentTableOrigin2);
        	createHeaderGijong().then(()=>{
    		
           		monthProductPresentTable2 = monthProductPresentTableFunc2();       	
            });
        } else if(selectedTab == 'tab3View'){
        	gubun = ($('#gubun').is(":checked")) ? '' : "001";
        	$('.thirdTable').html(monthProductPresentTableOrigin3);        	
        	createHeaderDtl().then(()=>{
    		
           		monthProductPresentTable3 = monthProductPresentTableFunc3();       	
            });
        } else if(selectedTab == 'tab4View'){        	
        	$('.fourthTable').html(monthProductPresentTableOrigin4);        	
        	createHeaderDaily1().then(()=>{
    		
           		monthProductPresentTable4 = monthProductPresentTableFunc4();       	
            });
        } else{        	
        	$('.fifthTable').html(monthProductPresentTableOrigin5);        	
        	createHeaderDaily2().then(()=>{
    		
           		monthProductPresentTable5 = monthProductPresentTableFunc5();       	
            });
        }
    	
		
		
    });

	// 탭 시작 ------------
	$("#tab1").on("click", function() {
		$("#"+selectedTab).addClass("d-none");
		$("#tab1View").removeClass("d-none");		
		selectedTab = "tab1View";
		$('.gubun').addClass('d-none');
		$('.table-responsive').html(monthProductPresentTableOrigin);
    	createHeader().then(()=>{
		
       		monthProductPresentTable = monthProductPresentTableFunc();     
       		
        });
		
	});
	
	$("#tab2").on("click", function() {
		$("#"+selectedTab).addClass("d-none");
		$("#tab2View").removeClass("d-none");		
		$('.gubun').addClass('d-none');
		selectedTab = "tab2View";
		$('.secondTable').html(monthProductPresentTableOrigin2);
    	createHeaderGijong().then(()=>{
		
       		monthProductPresentTable2 = monthProductPresentTableFunc2();       	
        });
		
	});
	
	$("#tab3").on("click", function() {
		$("#"+selectedTab).addClass("d-none");
		$("#tab3View").removeClass("d-none");		
		gubun = '';
		$('#gubun').attr('checked',true);
		selectedTab = "tab3View";
		$('.gubun').removeClass('d-none');
		$('.thirdTable').html(monthProductPresentTableOrigin3);
    	createHeaderDtl().then(()=>{
		
       		monthProductPresentTable3 = monthProductPresentTableFunc3();       	
        });
	});

	$("#tab4").on("click", function() {
		$("#"+selectedTab).addClass("d-none");
		$("#tab4View").removeClass("d-none");
		selectedTab = "tab4View";
		$('.gubun').addClass('d-none');
		$('.fourthTable').html(monthProductPresentTableOrigin4);
		createHeaderDaily1().then(()=>{
		
       		monthProductPresentTable4 = monthProductPresentTableFunc4();       	
        });
	});

	$("#tab5").on("click", function() {
		$("#"+selectedTab).addClass("d-none");
		$("#tab5View").removeClass("d-none");
		selectedTab = "tab5View";
		$('.gubun').addClass('d-none');
		$('.fifthTable').html(monthProductPresentTableOrigin5);
		createHeaderDaily2().then(()=>{
		
       		monthProductPresentTable5 = monthProductPresentTableFunc5();       	
        });
	});
	

    function createHeader(){
		return new Promise((resolve, reject)=> {
			$.ajax({
				url: '<c:url value="wm/createMonthPlanHeader"/>',
				type: 'GET',  
				async: false,
				data: {
					'menuAuth'	:	menuAuth,
					'planDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				},
				success: function(res){
					var data = res.data;
					if (res.result="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						//var planHeader = '<th class="text-center" style="vertical-align:middle; min-width:100px;">라인</th>';
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:130px;">구분</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:130px;">구분</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">누적실적</th>';
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						//$('#planHeader').html(planHeader);
						$('#planHeaderMain').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});
					}
				}
			});
		});		
    }

    function createHeaderGijong(){
		return new Promise((resolve, reject)=> {
			$.ajax({
				url: '<c:url value="wm/createMonthPlanHeader"/>',
				type: 'GET',  
				async: false,
				data: {
					'menuAuth'	:	menuAuth,
					'planDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				},
				success: function(res){
					var data = res.data;
					if (res.result="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px; max-width:112px;">기종</th>';
						planHeader += '<th class="text-center t2"style="vertical-align:middle; min-width:100px; max-width:112px;">재질</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">설비</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">수량</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">누적실적</th>';
					
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center giday' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center giday' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center giday' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center giday' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						//$('#planHeader').html(planHeader);
						$('#planHeaderGijong').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});
					}
				}
			});
		});
    }

    function createHeaderDtl(){
		return new Promise((resolve, reject)=> {
			$.ajax({
				url: '<c:url value="wm/createMonthPlanHeader"/>',
				type: 'GET',  
				async: false,
				data: {
					'menuAuth'	:	menuAuth,
					'planDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				},
				success: function(res){
					var data = res.data;
					if (res.result="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">설비</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">제품</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">구분</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">누적실적</th>';
					
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center dtlday' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center dtlday' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center dtlday' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center dtlday' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						//$('#planHeader').html(planHeader);
						$('#planHeaderDtl').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});
					}
				}
			});
		});
    }

    function createHeaderDaily1(){
		return new Promise((resolve, reject)=> {
			$.ajax({
				url: '<c:url value="wm/createMonthPlanHeader"/>',
				type: 'GET',  
				async: false,
				data: {
					'menuAuth'	:	menuAuth,
					'planDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				},
				success: function(res){
					var data = res.data;
					if (res.result="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						var planHeader = '';//'<th class="text-center"style="vertical-align:middle; min-width:100px;">규격</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">품목</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">납품처</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">구분</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">재질</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">전월재고</th>';
					
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center dailyday' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center dailyday' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center dailyday' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center dailyday' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">월말 예측재고</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">당월 출하실적</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">현재고일수</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">재고일수</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">운영대수</th>';
						//$('#planHeader').html(planHeader);
						$('#planHeaderGijongDaily').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});
					}
				}
			});
		});
    }

    function createHeaderDaily2(){
		return new Promise((resolve, reject)=> {
			$.ajax({
				url: '<c:url value="wm/createMonthPlanHeader"/>',
				type: 'GET',  
				async: false,
				data: {
					'menuAuth'	:	menuAuth,
					'planDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				},
				success: function(res){
					var data = res.data;
					if (res.result="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						var planHeader = '';//'<th class="text-center"style="vertical-align:middle; min-width:100px;">규격</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">품목</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">납품처</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">구분</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">재질</th>';
						 planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">전월재고</th>';
					
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center daily2day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center daily2day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center daily2day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center daily2day' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">월말 예측재고</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">당월 출하실적</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">현재고일수</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">재고일수</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">운영대수</th>';
						//$('#planHeader').html(planHeader);
						$('#planHeaderGijongDaily2').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});
					}
				}
			});
		});
    }
    
    function monthProductPresentTableFunc(){
        //console.log("난 테이블이야")
        let tempTableData = $('#productionPlanMainTable').on( 'error.dt', function ( e, settings, techNote, message ) {
        		if(techNote == 7) {
        			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
        			location.href = "/";
        		}
        	}).DataTable({
                dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
        				"<'row'<'col-sm-12'tr>>" +
        				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        																	//B
                language: lang_kor,
                paging: false,
                info: true,       
                ordering: false,
                processing: true,
                autoWidth: false,
                scrollX : false,
                pageLength: false,
                searching: false,
                //destroy: true, 
        		//header 고정
        		scrollY: '45vh',
        		scrollX: true,
        		fixedColumns: {
        			leftColumns: 2
        		},
        		ajax: {
                    url: '<c:url value="/wm/monthProductionPlanSumList"/>',
                    type: 'POST',
                    data: {
                    	'menuAuth'		:		menuAuth,
                    	'fpDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},                    
                    },
                    /*
                    success : function(res) {
                        console.log(res);
                    }
                    */
                },
                columns: [
                	//{ data: 'equipLineNm', },
                	{ data: 'gubunNm' ,name:'ggg'   		},
                	{ data: 'goodsCd' ,name:'ggg'          },
                	{ data: 'dataSum' ,
    	         		render: function(data, type, row) {
    	         			if(row["goodsCd"] == '가동률' || row["goodsCd"] == '수율'){
	        					if(data != null){
	        						return parseFloat(data).toFixed(1)+'%';
	        					}
    	        			} else if(row["goodsCd"] == '확정 계획 대비' && data != null){
        	        			if(data > 0){
        	        				return '<span style="color:blue">'+addCommas(parseFloat(data).toFixed(0))+' </span>';
            	        		} else{            	        			
            	        			return '<span style="color:red">'+addCommas(parseFloat(data).toFixed(0))+' </span>';
                	        		
                	        	}
								
    	        			} else if(row["goodsCd"] == '운영 계획 대비' && data != null){
    	        				if(data > 0){
        	        				return '<span style="color:blue">'+addCommas(parseFloat(data).toFixed(0))+' </span>';
            	        		} else{            	        			
            	        			return '<span style="color:red">'+addCommas(parseFloat(data).toFixed(0))+' </span>';
                	        		
                	        	}
    	        			}    	        			
    	        			else{
    	        				if(data != null){
        	        				return addCommas(parseFloat(data).toFixed(0));
            	        		}
        	        		}													
	               		}
               		},                	
        			<c:forEach var="item" begin="1" end="31" step="1">
               		{ data: 'fpDate${item}' ,
    	         		render: function(data, type, row) {
	        				if(row["goodsCd"] == '가동률' || row["goodsCd"] == '수율'){
	        					if(data != null){
	        						return parseFloat(data).toFixed(1)+'%';
	        					}
								
    	        			} else if(row["goodsCd"] == '확정 계획 대비' && data != null){
    	        				
        	        				if(data != null){
                	        			let diffData = data.split('/');     
                	        			if(diffData[1] != null && diffData[1] != ''){
                	        				diffData[1] = '★';
                    	        		}            	        			
            	        				if(diffData[0] > 0){
                	        				return '<span style="color:red;">'+diffData[1]+'</span>'+ '<span style="color:blue;" name="fpDate${item}">'+addCommas(parseFloat(diffData[0]).toFixed(0))+' </span>'
                	        				
                    	        		} else{            	        			
                    	        			return '<span style="color:red;">'+diffData[1]+'</span>'+ '<span style="color:red;" name="fpDate${item}">'+addCommas(parseFloat(diffData[0]).toFixed(0))+' </span>'

                        	        	}
                	        		} else{
                	        			return '<span></span><span style="color:red;font-size: 1.2em; font-weight:bold;" name="fpDate${item}">'+' </span>';
                    	        	}       
        	        			
								
    	        			} else if(row["goodsCd"] == '운영 계획 대비' && data != null){
    	        				if(data != null){
            	        			let diffData = data.split('/');    
            	        			if(diffData[1] != null && diffData[1] != ''){
            	        				diffData[1] = '★';
                	        		}             	        			
        	        				if(diffData[0] > 0){
            	        				return '<span style="color:red;">'+diffData[1]+'</span>'+ '<span style="color:blue;" name="fpDate${item}">'+addCommas(parseFloat(diffData[0]).toFixed(0))+' </span>'
            	        				
                	        		} else{            	        			
                	        			return '<span style="color:red;">'+diffData[1]+'</span>'+ '<span style="color:red;font-size: " name="fpDate${item}">'+addCommas(parseFloat(diffData[0]).toFixed(0))+' </span>'

                    	        	}
            	        		} else{
            	        			return '<span></span><span style="color:red;font-size: 1.2em; font-weight:bold;" name="fpDate${item}">'+' </span>';
                	        	} 
    	        			}
    	        			else{
    	        				if(data != null){
        	        				return addCommas(parseFloat(data).toFixed(0));
            	        		}
        	        		}								
	               		}

        	         },    		
        			</c:forEach>
                ],
        		
                columnDefs: [
                	
                	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], className: 'text-right-td' },
                	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], render: $.fn.dataTable.render.number( ',' ) },
                ],
          		rowsGroup: [ 'ggg:name'],
          		 buttons: [
         			{
         			    extend: 'copy',
         				title: 'FP현황(일일실적)',
         			},
         			{
         				 extend: 'excel',        		         
         			    title: 'FP현황(일일실적)',
         			   
         			    exportOptions: {
         			    	columns: ':visible'
         			    
         			    	
         			    }        			    
         			},
         			{
         			    extend: 'print',
         			    title: 'FP현황(일일실적)',
         			}
         		],
         		createdRow: function (row, data, dataIndex) {
        			var cnt = 3;    
        			    		
	           		if(data["goodsCd"] == '운영 계획 대비' || data["goodsCd"] == '확정 계획 대비'){
	           			<c:forEach var="item" begin="1" end="31" step="1">
	           			
	           				if(data['fpDate${item}'] != null ){
	               				
	           					var diffData = data['fpDate${item}'].split('/');
	           					if(diffData[1] != ''){
	           						$(row).find('td').eq(cnt).attr('title', diffData[1]);	             			          	
	       	            			$(row).find('td').eq(cnt).attr('data-toggle', "tooltip");	
	       	            			$(row).find('td').eq(cnt).attr('data-placement', "bottom");        	            		
	       	          
	       	            			$(row).find('td').eq(cnt).tooltip('update');
	       	            		
	                   			}  					
	   	            				            
	               			}
	           				
	           			            			
	            			cnt ++;
	           			</c:forEach>
            		}
         		},
        		drawCallback:function( settings){
        			//var api = this.api();
        			//api.fixedColumns().update();
        			var selectDate = inWhsDateCal.replace(/-/g,"").substring(6,8);
        			
        			$.each($('#productionPlanMainTable tr'),function(index, item){
        		/* 		if($('.day27').text()==""){
        					$(this).find('th').eq(29).addClass('d-none');
        					$(this).find('td').eq(29).addClass('d-none');
        				}
        				if($('.day28').text()==""){
        					$(this).find('th').eq(30).addClass('d-none');
        					$(this).find('td').eq(30).addClass('d-none');
        				}
        				if($('.day29').text()==""){
        					$(this).find('th').eq(31).addClass('d-none');
        					$(this).find('td').eq(31).addClass('d-none');
        				}
        				if($('.day30').text()==""){
        					$(this).find('th').eq(32).addClass('d-none');
        					$(this).find('td').eq(32).addClass('d-none');
        				}
        				if($('.day31').text()==""){
        					$(this).find('th').eq(33).addClass('d-none');
        					$(this).find('td').eq(33).addClass('d-none');
        				}
        				 */
        				if(index == $('#productionPlanMainTable').DataTable().data().count() - 1){
                        	$('#my-spinner').hide();
                        }
        				//$(this).find('th').eq(parseInt(selectDate)+1).attr('style',"border-right-color:yellow; border-weight:10px;");  
        				$(this).find('td').eq(parseInt(selectDate)+1).attr('style',"border-right-color:red;");  
        				$(this).find('td').eq(parseInt(selectDate)+2).attr('style',"border-right-color:red;");        	
        				
        			});
        			//$('#productionPlanMainTable').rowspan(0);
        			//$('#productionPlanMainTable').rowspan(1);
        			if($('.day27').text()==""){
       					$('#productionPlanMainTable').DataTable().column(29).visible(false);
       					
       				}
       				if($('.day28').text()==""){
       					$('#productionPlanMainTable').DataTable().column(30).visible(false);
       					
       				}
       				if($('.day29').text()==""){
       					$('#productionPlanMainTable').DataTable().column(31).visible(false);
       					
       				}
       				if($('.day30').text()==""){
       					$('#productionPlanMainTable').DataTable().column(32).visible(false);
       					
       				}
       				if($('.day31').text()==""){
       					
       					$('#productionPlanMainTable').DataTable().column(33).visible(false);
       				}

        			$.ajax({
                		url: '<c:url value="wm/monthProductionPlanSummaryData"/>',
            			type: 'POST',  
            			async: false,
            			data: {
            				'menuAuth'	:	menuAuth,
            				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
            				'cplGubun'	:	function(){return "001";},				
            			},
                        success: function (res) {
                            let list1 = res.list1;
                            let list2 = res.list2;
                            let list3 = res.list3;
                            let list4 = res.list4;                            
                            
                            
                            if (res.result == 'ok') { 
                                if(list1.length != 0){
                                	$('#data1').text(addCommas(list1[0].sumOutputCnt));
                                	$('#data3').text(list1[0].day_ + "일");

                                	if(list1[0].day_.substring(0,1) == '0'){
    									list1[0].day_ = list1[0].day_.substring(1,2);	
    								}
                                }

                                if(list2.length != 0){
                                	$('#data2').text(parseFloat(list2[0].maxValue).toFixed(1) + "%");
                                	$('#data4').text(list2[0].day_ + "일");
                                }
                                if(list3.length != 0){
                                	$('#data5').text(list3[0].productMan);								
    								$('#data7').text(list3[1].productMan);
                                }
                                if(list4.length != 0){
    								$('#data6').text(list4[0].gubunCnt + "대");							
    								$('#data8').text(list4[1].gubunCnt + "대");
                                }
                                
                            } else{ //에러
                            	toastr.error(res.message, '', {timeOut: 5000});
                            }
                        },
                        complete:function(){
                        		                            
                        }
                    });
        			theoryDataRead();  
        			if (temp) {
        				toastr.success('조회되었습니다');        				
        				temp = false;
        			}


        		}
            });

        return tempTableData;
    }

    function monthProductPresentTableFunc2(){
        //console.log("난 테이블이야")
        let tempTableData = $('#productionPlanGijongTable').on( 'error.dt', function ( e, settings, techNote, message ) {
        		if(techNote == 7) {
        			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
        			location.href = "/";
        		}
        	}).DataTable({
                dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
        				"<'row'<'col-sm-12'tr>>" +
        				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        																	//B
                language: lang_kor,
                paging: false,
                info: false,       
                ordering: false,
                processing: true,
                autoWidth: false,             
                pageLength: false,
                searching: false,
                //destroy: true, 
        		//header 고정
        		scrollY: '67vh',
        		scrollX: true,
        		/* fixedColumns: {
        			leftColumns: 2
        		}, */
        		ajax: {
                    url: '<c:url value="/wm/monthProductionPlanGijongList"/>',
                    type: 'POST',
                    data: {
                    	'menuAuth'		:		menuAuth,
                    	'fpDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},                    	
                    },
                    /*
                    success : function(res) {
                        console.log(res);
                    }
                    */
                },
                columns: [                	
                	{ data: 'gijongNm',name:'ggg'},
                	{ data: 'qutyNm',name:'ggg'},
                	{ data: 'equipCd'},
                	{ data: 'gubunNm'},
                	{ data: 'dataSum'},
        			<c:forEach var="item" begin="1" end="31" step="1">
    	         	{ data: 'fpDate${item}'
    	         		
        	         	
    	    		},    		
        		</c:forEach>
                ],
        		
                columnDefs: [
                	{ targets: [0], className: 't1' },
                	{ targets: [1], className: 't2' },
                	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35], className: 'text-right-td' },
                	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35], render: $.fn.dataTable.render.number( ',' ) },
                ],
                rowsGroup: ['ggg:name'],
                buttons: [
        			{
        			    extend: 'copy',
        				title: 'FP현황(기종별)',
        			},
        			{
        				 extend: 'excel',        		         
        			    title: 'FP현황(기종별)',
        			   
        			    exportOptions: {
        			    	columns: ':visible'
        			    
        			    	
        			    }        			    
        			},
        			{
        			    extend: 'print',
        			    title: 'FP현황(기종별)',
        			}
        		],
        	
        		drawCallback:function( settings){
        			//var api = this.api();
        			//api.fixedColumns().update();        
        			//컬럼 추가 시 for문 도 수정
        			var selectDate = inWhsDateCal.replace(/-/g,"").substring(6,8);
        			let shipInsSumDateArray = new Array();
        			let planArray = new Array();
        			let prodArray = new Array();
        			
        			
         			$('#productionPlanGijongTable').attr('style', 'margin-top: -1px !important;');

					let gijongGubun = '';
					var colorStat = false;
					let  sumGijong = 0;
					for(var i=0; i<32; i++){
            			
						shipInsSumDateArray[i] = 0;
						planArray[i] = 0;
						prodArray[i] = 0;
        			}
        			$.each($('#productionPlanGijongTable tr'),function(index, item){
        				
        				
        				if(index == $('#productionPlanGijongTable').DataTable().data().count() - 1){
                        	$('#my-spinner').hide();
                        	
                        }
						if(gijongGubun != $(this).find('td').eq(0).text()){
							gijongGubun = $(this).find('td').eq(0).text();
							colorStat = !colorStat;
							
						}
						if(colorStat){
	        				$(this).css('background-color','#F2F2F2');
	        				$(this).find('.t1').css('background-color','#F2F2F2');
	    					$(this).find('.t2').css('background-color','#F2F2F2');
	            		} else{
	            			$(this).css('background-color','#ffffff');
	            			$(this).find('.t1').css('background-color','#ffffff');
	    					$(this).find('.t2').css('background-color','#ffffff');
	    					
	                	}
						
						if($(this).find('td').eq(3).text() == '계획수량'){	                		
	                		for(var i=0; i<32; i++){
		                		if($(this).find('td').eq(4+i).text()!=''){                		
		                			planArray[i] = parseInt(removeCommas($(this).find('td').eq(4+i).text()));
			                	}
	                		}
		                }
						
	                	if($(this).find('td').eq(3).text() == '생산수량'){
	                		sumGijong += parseInt(removeCommas($(this).find('td').eq(4).text()));
	                		for(var i=0; i<31; i++){
		                		if($(this).find('td').eq(5+i).text()!=''){			                		
        							shipInsSumDateArray[i] += parseInt(removeCommas($(this).find('td').eq(5+i).text())); 
        												        							
			                	}		                		
	                		}
	                		for(var i=0; i<32; i++){
		                		if($(this).find('td').eq(4+i).text()!=''){			                		
		                			prodArray[i] = parseInt(removeCommas($(this).find('td').eq(4+i).text()));    

									if((prodArray[i] - planArray[i]) > 0){
										$(this).find('td').eq(4+i).html('<span style="color:blue">'+$(this).find('td').eq(4+i).text()+'</span>');
		    						}
									if((prodArray[i] - planArray[i]) < 0){
										$(this).find('td').eq(4+i).html('<span style="color:red">'+$(this).find('td').eq(4+i).text()+'</span>');
		    						}	
        												        							
			                	}		                		
	                		}
	                		
		                }
	                	$(this).find('td').eq(parseInt(selectDate)+3).attr('style',"border-right-color:red;");  
        				$(this).find('td').eq(parseInt(selectDate)+4).attr('style',"border-right-color:red;");   
        				
        			});					

        			if($('.giday27').text()==""){
       					$('#productionPlanGijongTable').DataTable().column(31).visible(false);
       					
       				}
       				if($('.giday28').text()==""){
       					$('#productionPlanGijongTable').DataTable().column(32).visible(false);
       					
       				}
       				if($('.giday29').text()==""){
       					$('#productionPlanGijongTable').DataTable().column(33).visible(false);
       					
       				}
       				if($('.giday30').text()==""){
       					$('#productionPlanGijongTable').DataTable().column(34).visible(false);
       					
       				}
       				if($('.giday31').text()==""){
       					
       					$('#productionPlanGijongTable').DataTable().column(35).visible(false);
       				}
        			//$('#productionPlanGijongTable').rowspan(0);
        			//$('#productionPlanGijongTable').rowspan(1);
					$('#productionPlanGijongTable tfoot').remove();
        			let  sumEquip         = $('#productionPlanGijongTable').DataTable().column(2,{ page: 'all'} ).data().sum();
         			//let  sumGijong         = $('#productionPlanGijongTable').DataTable().column(4,{ page: 'all'} ).data().sum();

        			$('#sumEquip').html(addCommas(sumEquip));
        			$('#sumGijong').html(addCommas(parseInt(sumGijong)));

        			
        			
             
        			for(var i=0; i<31; i++){
            			//if(isNaN(shipInsSumDateArray[i] )){
            			//	shipInsSumDateArray[i] = 0;
                		//}
        				$('#faulty'+ (i+1) ).html(addCommas(parseInt(shipInsSumDateArray[i])));
            			//$('#faulty'+ (i+1) ).html(shipInsSumDateArray[i]);
        			}

        			$('.dataTables_scrollBody').css({
        	    		'overflow-y': 'scroll'		
        		    });
        			
        			if (temp) {
        				toastr.success('조회되었습니다');
        				temp = false;
        			}
        			


        		}
            });

        return tempTableData;
    }

    function monthProductPresentTableFunc3(){
        //console.log("난 테이블이야")
        let colorStat = false;
        let gijongGubun = '';
        let planArray = new Array();
		let prodArray = new Array();
		let selectDate = inWhsDateCal.replace(/-/g,"").substring(6,8);
		for(var i=0; i<32; i++){ 
			planArray[i] = 0;
			prodArray[i] = 0;
		} 
		
        let tempTableData = $('#productionPlanDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
        		if(techNote == 7) {
        			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
        			location.href = "/";
        		}
        	}).DataTable({
                dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
        				"<'row'<'col-sm-12'tr>>" +
        				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>> B",
        																	//
                language: lang_kor,
                paging: false,
                info: false,       
                ordering: false,
                processing: true,
                autoWidth: false,             
                pageLength: false,
                searching: false,
                //destroy: true, 
        		//header 고정
        		scrollY: '67vh',
        		scrollX: true,
        		//serverSide: true,
        		
        		fixedColumns: {
        			leftColumns: 3
        		},
        		ajax: {
                    url: '<c:url value="/wm/monthProductionPlanDtlList"/>',
                    type: 'POST',
                    data: {
                    	'menuAuth'		:		menuAuth,
                    	'fpDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},     
                    	'gubun'			: function(){return gubun;},
                    },
     
                },
                columns: [
                	{ data: 'equipNm',name:'ggg' ,
                		render: function(data, type, row) {
                			return '<span style="font-size: 1.2em; font-weight:bold;">'+data+' </span>';
                		}
                    },
                	{ data: 'goodsNm',name:'ggg' ,
                    	render: function(data, type, row) {
                			return '<span style="font-size: 1.2em; font-weight:bold;">'+data+' </span>';
                		}
                    },
                	{ data: 'gubunNm' },
                	{ data: 'dataSum' ,
    	         		render: function(data, type, row) {
    	         			if(row["gubunNm"] == '가동률' || row["gubunNm"] == '수율' ){
		        				if(data != null){
		        					return data+'%';
			        			}
								
    	        			} else if(row["gubunNm"] == '차이량' && data != null){
        	        			if(data > 0){
        	        				return '<span style="color:blue;font-size: 1.2em; font-weight:bold;">'+addCommas(data)+' </span>';
            	        		} else{            	        			
            	        			return '<span style="color:red;font-size: 1.2em; font-weight:bold;">'+addCommas(data)+' </span>';
                	        		
                	        	}
								
    	        			} else if(row["gubunNm"] == '당일합계(생산)' && data != null){
        	        		
        	        		  return '<span style="font-size: 1.2em; font-weight:bold;">'+addCommas(data)+' </span>';
            	        
    	        			} else{
        	        			if(data != null){
        	        				return addCommas(parseFloat(data).toFixed(0));
            	        		}
    	        				
        	        		}								
	               		}
               		},
        			<c:forEach var="item" begin="1" end="31" step="1">
    	         	{ data: 'fpDate${item}',
    	         		render: function(data, type, row) {
	        				if(row["gubunNm"] == '가동률' || row["gubunNm"] == '수율' ){
		        				if(data != null){
		        					return data+'%';
			        			}
								
    	        			} else if(row["gubunNm"] == '차이량'){   
    	        				if(data != null){
            	        			let diffData = data.split('/');   
            	        			if(diffData[1] != null && diffData[1] != ''){
            	        				diffData[1] = '★';
                	        		}         	        			
        	        				if(diffData[0] > 0){
            	        				return '<span style="color:red;">'+diffData[1]+'</span>'+ '<span style="color:blue;font-size: 1.2em; font-weight:bold;" name="fpDate${item}">'+addCommas(diffData[0])+' </span>'
            	        				
                	        		} else{            	        			
                	        			return '<span style="color:red;">'+diffData[1]+'</span>'+ '<span style="color:red;font-size: 1.2em; font-weight:bold;" name="fpDate${item}">'+addCommas(diffData[0])+' </span>'

                    	        	}
            	        		} else{
            	        			return '<span></span><span style="color:red;font-size: 1.2em; font-weight:bold;" name="fpDate${item}">'+' </span>';
                	        	}       
    	        			} else if(row["gubunNm"] == '생산 조(주간)' || row["gubunNm"] == '생산 조(야간)'){   
    	        				if(data != null){
            	        			let diffData = data.split('/');   
            	        			if(diffData[1] != null && diffData[1] != ''){
            	        				diffData[1] = '★';
                	        		}         	        			
        	        			
            	        			return '<span style="color:red;">'+diffData[1]+'</span>'+ '<span name="fpDate${item}">'+diffData[0]+' </span>'            	        				
                	        		
            	        		} else{
            	        			return '<span></span><span style="color:red;font-size: 1.2em; font-weight:bold;" name="fpDate${item}">'+' </span>';
                	        	}       
    	        			} else if(row["gubunNm"] == '당일합계(생산)' && data != null){
            	        		
          	        		  return '<span style="font-size: 1.2em; font-weight:bold;">'+addCommas(data)+' </span>';
              	        
      	        			} else{
    	        				if(data != null){
        	        				return addCommas(data);
            	        		}
        	        		}								
	               		}
    	    		},    		
        		</c:forEach>
                ],
        		
                columnDefs: [
                	
                	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34], className: 'text-right-td' },
                	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34], render: $.fn.dataTable.render.number( ',' ) },
                ],
                rowsGroup: ['ggg:name'],
                buttons: [
        			{
        			    extend: 'copy',
        				title: 'FP현황(FP)',
        			},
        			{
        				 extend: 'excel',        		         
        			    title: 'FP현황(FP)',
        			   
        			    exportOptions: {
        			    	columns: ':visible'
        			    
        			    	
        			    }        			    
        			},
        			{
        			    extend: 'print',
        			    title: 'FP현황(FP)',
        			}
        		],
        		createdRow: function (row, data, dataIndex) {
        			var cnt = 4;    
        			    		
            		if(data["gubunNm"] == '차이량' || data["gubunNm"] == '생산 조(주간)' || data["gubunNm"] == '생산 조(야간)'){
            			<c:forEach var="item" begin="1" end="31" step="1">
            			
            				if(data['fpDate${item}'] != null ){
                				
            					var diffData = data['fpDate${item}'].split('/');
            					if(diffData[1] != ''){
            						$(row).find('td').eq(cnt).attr('title', diffData[1]);	             			          	
        	            			$(row).find('td').eq(cnt).attr('data-toggle', "tooltip");	
        	            			$(row).find('td').eq(cnt).attr('data-placement', "bottom");        	            		
        	          
        	            			$(row).find('td').eq(cnt).tooltip('update');
        	            			
                    			}  					
    	            				            
                			}
            				
            			            			
	            			cnt ++;
            			</c:forEach>
            		}
            		if(gijongGubun != $(row).find('td').eq(0).text()){
						gijongGubun = $(row).find('td').eq(0).text();
						colorStat = !colorStat;
						
						
					}
            		if(colorStat){
        				$(row).css('background-color','#F2F2F2');
            		} else{
            			$(row).css('background-color','#ffffff');	            			
                	}

            		if($(row).find('td').eq(2).text() == '계획수량(변경)'){	                		
                		for(var i=0; i<32; i++){
	                		if($(row).find('td').eq(3+i).text()!=''){                		
	                			planArray[i] = parseInt(removeCommas($(row).find('td').eq(3+i).text()));
		                	}
                		}
	                }
					
                	if($(row).find('td').eq(2).text() == '당일합계(검사)'){
                		for(var i=0; i<32; i++){
	                		if($(row).find('td').eq(3+i).text()!=''){			                		
	                			prodArray[i] = parseInt(removeCommas($(row).find('td').eq(3+i).text()));    

								if((prodArray[i] - planArray[i]) > 0){
									$(row).find('td').eq(3+i).html('<span style="color:blue;font-size:1.2em; font-weight:bold;">'+$(row).find('td').eq(3+i).text()+'</span>');
	    						}
								if((prodArray[i] - planArray[i]) < 0){
									$(row).find('td').eq(3+i).html('<span style="color:red;font-size:1.2em; font-weight:bold;">'+$(row).find('td').eq(3+i).text()+'</span>');
	    						}	
    												        							
		                	}		                		
                		}
                		
	                }
    			
                	$(row).find('td').eq(parseInt(selectDate)+2).attr('style',"border-right-color:red;");  
    				$(row).find('td').eq(parseInt(selectDate)+3).attr('style',"border-right-color:red;");   
            	
        		},        	
        		drawCallback:function( settings){
        			//var api = this.api();
        			//api.fixedColumns().update();
        			// $.each($('#productionPlanDtlTable tr'),function(index, item){
        		
        				//if(index == $('#productionPlanDtlTable').DataTable().data().count() - 1){
                        //	$('#my-spinner').hide();
                        //}
        			//});					

       				if($('.dtlday27').text()==""){
       					$('#productionPlanDtlTable').DataTable().column(30).visible(false);
       					
       				}
       				if($('.dtlday28').text()==""){
       					$('#productionPlanDtlTable').DataTable().column(31).visible(false);
       					
       				}
       				if($('.dtlday29').text()==""){
       					$('#productionPlanDtlTable').DataTable().column(32).visible(false);
       					
       				}
       				if($('.dtlday30').text()==""){
       					$('#productionPlanDtlTable').DataTable().column(33).visible(false);
       					
       				}
       				if($('.dtlday31').text()==""){
       					
       					$('#productionPlanDtlTable').DataTable().column(34).visible(false);
       				}

       				if($('#productionPlanDtlTable tbody').find('tr').eq(0).find('td').eq(2).text() == '생산 조(주간)'){
       					$('#productionPlanDtlTable tbody').find('tr').eq(0).attr('style','position: sticky; top: 0px; background-color:white;');
       					$('#productionPlanDtlTable tbody').find('tr').eq(1).attr('style','position: sticky; top: 29px; background-color:white;');
           			}
       			
        			if (temp) {
        				toastr.success('조회되었습니다');
        				temp = false;
        			} 

        			
        			$('#my-spinner').hide();
        		
        		}
            });
        //$('#productionPlanDtlTable').rowspan(0);
		//$('#productionPlanDtlTable').rowspan(1);


        return tempTableData;
    }

    function monthProductPresentTableFunc4(){
    	alRealData = 0;
    	niRealData = 0;
    	alEquipCntReal = 0;
    	niEquipCntReal = 0;
    	outputSumReal = 0;
        //console.log("난 테이블이야")
        let tempTableData = $('#gijongDailyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
        		if(techNote == 7) {
        			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
        			location.href = "/";
        		}
        	}).DataTable({
                dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
        				"<'row'<'col-sm-12'tr>>" +
        				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        																	//B
                language: lang_kor,
                paging: false,
                info: false,       
                ordering: false,
                processing: true,
                autoWidth: false,             
                pageLength: false,
                searching: false,
                //destroy: true, 
        		//header 고정
        		scrollY: '58vh',
        		scrollX: true,
        		 fixedColumns: {
        			leftColumns: 4
        		},
        		ajax: {
                    url: '<c:url value="/wm/gijongDailyPlan1"/>',
                    type: 'POST',
                    data: {
                    	'menuAuth'		:		menuAuth,
                    	'fpDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},
                    	                  	
                    },        
                },
                columns: [                	
                /* 	{ data: 'model',name:'aaa' ,
                		render: function(data, type, row) {
                			return '<span style="font-size: 1.2em; font-weight:bold;">'+data+' </span>';
                		}
                    }, */
                	{ data: 'gijongNm',name:'bbb' ,
                    	render: function(data, type, row) {
                			return '<span style="font-size: 1.2em; font-weight:bold;">'+data+' </span>';
                		}
                    },
                	{ data: 'dealCorpNm',name:'ccc' },
                	{ data: 'gubun' ,name:'ddd',
    	         		render: function(data, type, row) {
    	         			if(data == '1' ){
		        				return '<span style="color:red"> 출하계획 </span>';
    	        			} else if(data == '2'){
    	        				return '<span style="color:red"> 출하실행 </span>';
    	        			} else if(data == '3'){        	        		
    	        				return '<span style="font-weight:bold;"> 재고량 </span>';
            	        
    	        			}							
	               		}
               		},
               		{ data: 'qutyNm' },
               		{ data: 'lastMonthStock' },
        			<c:forEach var="item" begin="1" end="31" step="1">
    	         		{ data: 'fpDate${item}',
    	       	         	render: function(data, type, row) {
    		         			if(data != null && data != '0' ){
    		         				if(row['gubun'] != '3'){
    		         					data = data / 2;
        		        				return addCommas(Math.floor(data));
    		         				} else{
    		         					return addCommas(data);
        		         			}
        		         			
    		        			}							
    	               		}
	               		},    		
        			</c:forEach>
    	         	{ data: 'sumOutputCnt',
	       	         	render: function(data, type, row) {
		         			if(data != null && data != '0' ){
		        				return addCommas(data);
		        			}							
	               		}
               		}, //월말 예측재고
       	         	{ data: 'dataSum',
	       	         	render: function(data, type, row) {
		         			if(data != null && data != '0'  ){
		         				data = data/2;
		        				return addCommas(parseFloat(data).toFixed(0));
		        			}							
	               		}
               		},   	 //당월 출하실적	
               		{ data: 'planCnt2',
    	         		render: function(data, type, row) {
    	         			if(data != null && data != '0E-19' ){
    	         				if(row['equipCd'] != null && row['equipCd'] != '0'){
        	         				data = data/row['equipCd'];
    		        				return addCommas(parseFloat(data).toFixed(0));
            	         		}    
    	        			}							
	               		}
               		 }, //재고일수
   	         		{ data: 'planCnt',
    	         		render: function(data, type, row) {
    	         			if(data != null && data != '0E-19' ){
        	         			if(row['equipCd'] != null && row['equipCd'] != '0'){
        	         				data = data/row['equipCd'];
    		        				return addCommas(parseFloat(data).toFixed(0));
            	         		}    	         				
    	        			}							
	               		}
               		 }, //재고일수
	         		{ data: 'equipCd',
    	         		render: function(data, type, row) {
    	         			if(data != null && data != '0'  ){
		        				return data;
    	        			}							
	               		}
	               	}, // 운영대수
                ],
        		
                columnDefs: [             
                	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40], className: 'text-right-td' },
                	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40], render: $.fn.dataTable.render.number( ',' ) },
                ],
                rowsGroup: ['aaa:name','bbb:name','ccc:name','ddd:name'],
               
                buttons: [
        			{
        			    extend: 'copy',
        				title: 'FP현황(기종별일일재고)',
        			},
        			{
        				extend: 'excelHtml5',  
	       	           	 text: 'Excel',  
	       	           	 charset: 'UTF-8',
	       	           	  bom: true ,
	       					title: 'FP현황(기종별일일재고)',				
	       					 footer: true,
	       					customize: function(xlsx) {
	       		                var sheet = xlsx.xl.worksheets['sheet1.xml'];
	       		                $('row[r=2] c', sheet).remove();   //2번째 행 데이터 삭제
	       		                $('row[r=4] c', sheet).attr( 's', '2' ); //4번째행에 데이터테이블 헤더 있으니까 스타일 변경
	       		                   function createNode( doc, nodeName, opts ) {
	       		                   var tempNode = doc.createElement( nodeName );
	       		                       if ( opts ) {
	       		                      if ( opts.attr ) {
	       		                              $(tempNode).attr( opts.attr );
	       		                            }
	       	
	       		                            if ( opts.children ) {
	       		                              $.each( opts.children, function ( key, value ) {
	       		                                   tempNode.appendChild( value );
	       		                              } );
	       		                            }
	       	
	       		                            if ( opts.text !== null && opts.text !== undefined ) {
	       		                              tempNode.appendChild( doc.createTextNode( opts.text ) );
	       		                            }
	       		                       }
	       		                       return tempNode;
	       		                }
	       		            },
	       	            	customizeData: function(data){
	       	                 let gapCell = new Array();   //header만큼에 공백을 추가 해주는 부분
	       	                for(var i=0; i<data.header.length; i++){
	       	                   gapCell.push(' ');
	       	                   
	       	                 }
	       	                //거꾸로 감, 제일 위에가 제일 밑으로 감
	       	                 let desc = [
	       	                    ''
	       	               	];
	       	
	       	                 data.body.unshift(data.header);   //헤더 맨 아래 부분
	       	                 for (var i = 0; i < desc.length; i++) {
	       	                     data.body.unshift(desc[i]);
	       	                 };
	       	               
	       	                 data.body[0] = [
	       	                	'AL',$('#alRealSum').text(),'','재고일수',$('#alRealStock').text(),'',
	       	                	'NICU',$('#niRealSum').text(),'','재고일수',$('#niRealStock').text(),'',
	       	                	'출하실적',$('#outputRealSum').text(),'','합계 재고일수',$('#niRealStockSum').text()
	       	                 ];
		       	            /*  data.body[data.body.length+1] = [
		       	            	
		       	             ];
		       	             data.body[data.body.length+2] = [
		       	            	
	      	                 ]; */
	       		                
	       	             }, 
        			   
        			    exportOptions: {
        			    	columns: ':visible'
        			    
        			    	
        			    }        			    
        			},
        			{
        			    extend: 'print',
        			    title: 'FP현황(기종별일일재고)',
        			}
        		],
        		createdRow: function (row, data, dataIndex) {
        			
        			
        			if(data["gubun"] == '3' ){
        				$(row).css('background-color','#C2E0B4');	
        				  
            		}
            		if(data["qutyNm"] == 'AL'){
            			alRealData += parseInt(data["sumOutputCnt"]);   
            			
            			dataSumsubReal = parseInt(data["dataSumSub"]);
            			if(data["equipCd"] != '0' && data["equipCd"] != null){
            				alEquipCntReal += parseInt(data["equipCd"]);
                		}
                	}
            		if(data["qutyNm"] == 'Nicu' ){
            			niRealData +=  parseInt(data["sumOutputCnt"]);  
            			dataSumsubReal = parseInt(data["dataSumSub"]);
            			if(data["equipCd"] != '0' && data["equipCd"] != null){
            				niEquipCntReal += parseInt(data["equipCd"]);
                		}
            			
                	}
            		if(data["dataSum"] != '0' && data["dataSum"] != null){
            			outputSumReal += parseInt(data["dataSum"]); 
                	}
            		
            		
         		
        		},
        	
        		drawCallback:function( settings){
        		
    
         			$('#gijongDailyTable').attr('style', 'margin-top: -1px !important;');


        			if($('.dailyday27').text()==""){
       					$('#gijongDailyTable').DataTable().column(31).visible(false);
       					
       				}
       				if($('.dailyday28').text()==""){
       					$('#gijongDailyTable').DataTable().column(32).visible(false);
       					
       				}
       				if($('.dailyday29').text()==""){
       					$('#gijongDailyTable').DataTable().column(33).visible(false);
       					
       				}
       				if($('.dailyday30').text()==""){
       					$('#gijongDailyTable').DataTable().column(34).visible(false);
       					
       				}
       				if($('.dailyday31').text()==""){       					
       					$('#gijongDailyTable').DataTable().column(35).visible(false);
       				}        			

        			$('.dataTables_scrollBody').css({
        	    		'overflow-y': 'scroll'		
        		    });
        			
        			if (temp) {
        				toastr.success('조회되었습니다');
        				temp = false;
        			}

					$('#alRealSum').text(addCommas((alRealData)));
					$('#alRealStock').text(parseFloat(addCommas((alRealData / (dataSumsubReal * alEquipCntReal)))).toFixed(0) );
					$('#niRealSum').text(addCommas((niRealData)));
					$('#niRealStock').text( parseFloat(addCommas((niRealData / (dataSumsubReal * niEquipCntReal)))).toFixed(0)  );
					$('#outputRealSum').text(addCommas((outputSumReal)));
					$('#niRealStockSum').text( parseFloat(addCommas((alRealData + niRealData) / (dataSumsubReal * (niEquipCntReal + alEquipCntReal)))).toFixed(0) );
        			
        			$('#my-spinner').hide();

        		}
            });

        return tempTableData;
    }

    function monthProductPresentTableFunc5(){
    	alPlanData = 0;
    	niPlanData = 0;
    	alEquipCntPlan = 0;
    	niEquipCntPlan = 0;
    	outputSumPlan = 0;
        //console.log("난 테이블이야")
        let tempTableData = $('#gijongDailyTable2').on( 'error.dt', function ( e, settings, techNote, message ) {
        		if(techNote == 7) {
        			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
        			location.href = "/";
        		}
        	}).DataTable({
                dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
        				"<'row'<'col-sm-12'tr>>" +
        				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        																	//B
                language: lang_kor,
                paging: false,
                info: false,       
                ordering: false,
                processing: true,
                autoWidth: false,             
                pageLength: false,
                searching: false,
                //destroy: true, 
        		//header 고정
        		scrollY: '58vh',
        		scrollX: true,
        		 fixedColumns: {
        			leftColumns: 4
        		},
        		ajax: {
                    url: '<c:url value="/wm/gijongDailyPlan2"/>',
                    type: 'POST',
                    data: {
                    	'menuAuth'		:		menuAuth,
                    	'fpDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},
                    	                  	
                    },        
                },
                columns: [                	
                /* 	{ data: 'model',name:'aaa' ,
                		render: function(data, type, row) {
                			return '<span style="font-size: 1.2em; font-weight:bold;">'+data+' </span>';
                		}
                    }, */
                    { data: 'gijongNm',name:'bbb' ,
                    	render: function(data, type, row) {
                			return '<span style="font-size: 1.2em; font-weight:bold;">'+data+' </span>';
                		}
                    },
                	{ data: 'dealCorpNm',name:'ccc' },
                	{ data: 'gubun' ,name:'ddd',
    	         		render: function(data, type, row) {
    	         			if(data == '1' ){
		        				return '<span style="color:red"> 출하계획 </span>';
    	        			} else if(data == '2'){
    	        				return '<span style="color:red"> 출하실행 </span>';
    	        			} else if(data == '3'){        	        		
    	        				return '<span style="font-weight:bold;"> 재고량 </span>';
            	        
    	        			}							
	               		}
               		},
               		{ data: 'qutyNm' },
               		{ data: 'lastMonthStock' },
        			<c:forEach var="item" begin="1" end="31" step="1">
    	         		{ data: 'fpDate${item}',
    	       	         	render: function(data, type, row) {
    		         			if(data != null && data != '0' ){
    		         				if(row['gubun'] != '3'){
    		         					data = data / 2;
        		        				return addCommas(Math.floor(data));
    		         				} else{
    		         					return addCommas(Math.floor(data));
        		         			}
        		         			
    		        			}							
    	               		}
	               		},    		
        			</c:forEach>
    	         	{ data: 'sumOutputCnt',
	       	         	render: function(data, type, row) {
		         			if(data != null && data != '0' ){
		        				return addCommas(data);
		        			}							
	               		}
               		}, //월말 예측재고
       	         	{ data: 'dataSum',
	       	         	render: function(data, type, row) {
		         			if(data != null && data != '0'  ){
		         				data = data/2;
		        				return addCommas(parseFloat(data).toFixed(0));
		        			}							
	               		}
               		},   	 //당월 출하실적	
               		{ data: 'planCnt2',
    	         		render: function(data, type, row) {
    	         			if(data != null && data != '0E-19' ){
    	         				if(row['equipCd'] != null && row['equipCd'] != '0'){
        	         				data = data/row['equipCd'];
    		        				return addCommas(parseFloat(data).toFixed(0));
            	         		}    
    	        			}							
	               		}
               		 }, //재고일수
   	         		{ data: 'planCnt',
    	         		render: function(data, type, row) {
    	         			if(data != null && data != '0E-19' ){
    	         				if(row['equipCd'] != null && row['equipCd'] != '0'){
        	         				data = data/row['equipCd'];
    		        				return addCommas(parseFloat(data).toFixed(0));
            	         		}    
    	        			}							
	               		}
               		 }, //재고일수
	         		{ data: 'equipCd',
    	         		render: function(data, type, row) {
    	         			if(data != null && data != '0'  ){
		        				return data;
    	        			}							
	               		}
	               	}, // 운영대수
                ],
        		
                columnDefs: [             
                	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40], className: 'text-right-td' },
                	{ targets: [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40], render: $.fn.dataTable.render.number( ',' ) },
                ],
                rowsGroup: ['aaa:name','bbb:name','ccc:name','ddd:name'],
               
                buttons: [
        			{
        			    extend: 'copy',
        				title: 'FP현황(기종별)',
        			},
        			{
        				extend: 'excelHtml5',  
	       	           	 text: 'Excel',  
	       	           	 charset: 'UTF-8',
	       	           	  bom: true ,
	       					title: 'FP현황(기종별일일재고 예상실적)',				
	       					 footer: true,
	       					customize: function(xlsx) {
	       		                var sheet = xlsx.xl.worksheets['sheet1.xml'];
	       		                $('row[r=2] c', sheet).remove();   //2번째 행 데이터 삭제
	       		                $('row[r=4] c', sheet).attr( 's', '2' ); //4번째행에 데이터테이블 헤더 있으니까 스타일 변경
	       		                   function createNode( doc, nodeName, opts ) {
	       		                   var tempNode = doc.createElement( nodeName );
	       		                       if ( opts ) {
	       		                      if ( opts.attr ) {
	       		                              $(tempNode).attr( opts.attr );
	       		                            }
	       	
	       		                            if ( opts.children ) {
	       		                              $.each( opts.children, function ( key, value ) {
	       		                                   tempNode.appendChild( value );
	       		                              } );
	       		                            }
	       	
	       		                            if ( opts.text !== null && opts.text !== undefined ) {
	       		                              tempNode.appendChild( doc.createTextNode( opts.text ) );
	       		                            }
	       		                       }
	       		                       return tempNode;
	       		                }
	       		            },
	       	            	customizeData: function(data){
	       	                 let gapCell = new Array();   //header만큼에 공백을 추가 해주는 부분
	       	                for(var i=0; i<data.header.length; i++){
	       	                   gapCell.push(' ');
	       	                   
	       	                 }
	       	                //거꾸로 감, 제일 위에가 제일 밑으로 감
	       	                 let desc = [
	       	                    ''
	       	               	];
	       	
	       	                 data.body.unshift(data.header);   //헤더 맨 아래 부분
	       	                 for (var i = 0; i < desc.length; i++) {
	       	                     data.body.unshift(desc[i]);
	       	                 };
	       	               
	       	                 data.body[0] = [
	       	                	'AL',$('#alPlanSum').text(),'','재고일수',$('#alPlanStock').text(),'',
	       	                	'NICU',$('#niPlanSum').text(),'','재고일수',$('#niPlanStock').text(),'',
	       	                	'출하실적',$('#outputPlanSum').text(),'','합계 재고일수',$('#niPlanStockSum').text()
	       	                 ];
		       	            /*  data.body[data.body.length+1] = [
		       	            	
		       	             ];
		       	             data.body[data.body.length+2] = [
		       	            	
	      	                 ]; */
	       		                
	       	             }, 
        			   
        			    exportOptions: {
        			    	columns: ':visible'
        			    
        			    	
        			    }        			    
        			},
        			{
        			    extend: 'print',
        			    title: 'FP현황(기종별)',
        			}
        		],
        		createdRow: function (row, data, dataIndex) {
        			if(data["gubun"] == '3' ){
        				$(row).css('background-color','#C2E0B4');	     
            		}
        			if(data["qutyNm"] == 'AL'){
            			alPlanData += parseInt(data["sumOutputCnt"]);   
            			
            			dataSumsubPlan = parseInt(data["dataSumSub"]);
            			if(data["equipCd"] != '0' && data["equipCd"] != null){
            				alEquipCntPlan += parseInt(data["equipCd"]);
                		}
                	}
            		if(data["qutyNm"] == 'Nicu' ){
            			niPlanData +=  parseInt(data["sumOutputCnt"]);  
            			dataSumsubPlan = parseInt(data["dataSumSub"]);
            			if(data["equipCd"] != '0' && data["equipCd"] != null){
            				niEquipCntPlan += parseInt(data["equipCd"]);
                		}
            			
                	}
            		if(data["dataSum"] != '0' && data["dataSum"] != null){
            			outputSumPlan += parseInt(data["dataSum"]); 
                	}
        		},
        	
        		drawCallback:function( settings){
        		
    
         			$('#gijongDailyTable2').attr('style', 'margin-top: -1px !important;');


        			if($('.daily2day27').text()==""){
       					$('#gijongDailyTable2').DataTable().column(31).visible(false);
       					
       				}
       				if($('.daily2day28').text()==""){
       					$('#gijongDailyTable2').DataTable().column(32).visible(false);
       					
       				}
       				if($('.daily2day29').text()==""){
       					$('#gijongDailyTable2').DataTable().column(33).visible(false);
       					
       				}
       				if($('.daily2day30').text()==""){
       					$('#gijongDailyTable2').DataTable().column(34).visible(false);
       					
       				}
       				if($('.daily2day31').text()==""){       					
       					$('#gijongDailyTable2').DataTable().column(35).visible(false);
       				}        			

        			$('.dataTables_scrollBody').css({
        	    		'overflow-y': 'scroll'		
        		    });

        			$('#alPlanSum').text(addCommas((alPlanData)));
					$('#alPlanStock').text(parseFloat(addCommas((alPlanData / (dataSumsubPlan * alEquipCntPlan)))).toFixed(0) );
					$('#niPlanSum').text(addCommas((niPlanData)));
					$('#niPlanStock').text( parseFloat(addCommas((niPlanData / (dataSumsubPlan * niEquipCntPlan)))).toFixed(0)  );
					$('#outputPlanSum').text(addCommas((outputSumPlan)));
					$('#niPlanStockSum').text( parseFloat(addCommas((alPlanData + niPlanData) / (dataSumsubPlan * (niEquipCntPlan + alEquipCntPlan)))).toFixed(0) );
        			
        			if (temp) {
        				toastr.success('조회되었습니다');
        				temp = false;
        			}
        			
        			$('#my-spinner').hide();

        		}
            });

        return tempTableData;
    }

    
    $('#btnTheory').on('click', function() {
    	$.ajax({
			url: '<c:url value="wm/createMonthSumDataRead"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"").substring(0,6);},
			},
			success: function(res){	
				var data = res.data; 		
				if (res.result="ok"){
					if(data != null){
						 $('#theoryCapa').val((data.theoryCapa == null) ? "0" : addCommas(data.theoryCapa));
						 $('#theoryEquipCnt').val((data.theoryEquipCnt == null) ? "0" : addCommas(data.theoryEquipCnt));
						 $('#theoryPlanCnt').val((data.theoryPlanCnt == null) ? "0" : addCommas(data.theoryPlanCnt));
						 $('#dualCapa').val((data.dualCapa == null) ? "0" : addCommas(data.dualCapa));
						 $('#equipCnt').val((data.equipCnt == null) ? "0" : addCommas(data.equipCnt));
						 $('#planCnt').val((data.planCnt == null) ? "0" : addCommas(data.planCnt));
					}
				} else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			}
		});
    	$('#theoryPopupModal').modal('show');
    });

    $('#btnSave').on('click', function() {
    	$.ajax({
			url: '<c:url value="wm/createMonthSumData"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"").substring(0,6);},
				'theoryCapa'		:	function(){return $('#theoryCapa').val().replace(/,/g,"");},
				'theoryEquipCnt'	:	function(){return $('#theoryEquipCnt').val().replace(/,/g,"");},
				'theoryPlanCnt'		:	function(){return $('#theoryPlanCnt').val().replace(/,/g,"");},
				'dualCapa'			:	function(){return $('#dualCapa').val().replace(/,/g,"");},
				'equipCnt'			:	function(){return $('#equipCnt').val().replace(/,/g,"");},
				'planCnt'			:	function(){return $('#planCnt').val().replace(/,/g,"");},
			},
			success: function(res){			
				if (res.result="ok"){
					toastr.success("저장되었습니다");
					theoryDataRead();
				} else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			}
		});
    });

   function theoryDataRead(){
    	$.ajax({
			url: '<c:url value="wm/createMonthSumDataRead"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"").substring(0,6);},
			},
			success: function(res){	
				var data = res.data; 		
				if (res.result="ok"){
					if(data != null){
						 $('#theoryCapaRead').text(addCommas(data.theoryCapa));
						 $('#theoryEquipCntRead').text(data.theoryEquipCnt);
						 $('#theoryPlanCntRead').text(addCommas(data.theoryPlanCnt));
						 $('#dualCapaRead').text(addCommas(data.dualCapa));
						 $('#equipCntRead').text(data.equipCnt);
						 $('#planCntRead').text(addCommas(data.planCnt));	
					}	
					
				} else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			}
		});
    }

   $('#btnLoading').on('click', function() {
		
	

		let d = new Date($('#inWhsDateCal').val());
		let sel_month = -1; // 월을 조절하시면 됩니다. -1이면 전달을 +1이면 다음달을..
		d.setMonth(d.getMonth() + sel_month ); 

		let year    = d.getFullYear();
		let month   = ('0' + (d.getMonth() +  1 )).slice(-2);
		let day     = ('0' + d.getDate()).slice(-2);
		dt = year+"-"+month+"-"+day;
		
	   
	    $.ajax({
			url: '<c:url value="wm/createMonthSumDataRead"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return year+month;},
			},
			success: function(res){	
				var data = res.data; 		
				if (res.result="ok"){
					toastr.success("지난달 데이터를 불러왔습니다.");
					if(data != null){
					 $('#theoryCapa').val((data.theoryCapa == null) ? "0" : addCommas(data.theoryCapa));
					 $('#theoryEquipCnt').val((data.theoryEquipCnt == null) ? "0" : addCommas(data.theoryEquipCnt));
					 $('#theoryPlanCnt').val((data.theoryPlanCnt == null) ? "0" : addCommas(data.theoryPlanCnt));
					 $('#dualCapa').val((data.dualCapa == null) ? "0" : addCommas(data.dualCapa));
					 $('#equipCnt').val((data.equipCnt == null) ? "0" : addCommas(data.equipCnt));
					 $('#planCnt').val((data.planCnt == null) ? "0" : addCommas(data.planCnt));
					 
					}
					
				} else{ //에러
               	toastr.error(res.message, '', {timeOut: 5000});
               }
			}
		});
   });

   $('#btnDailyInven').on('click', function() {
	   $('#invenDate').val(inWhsDateCal.substring(0,7));
	   $('.planManModal').html(monthProductPresentTableOrigin6);
   		createHeaderMan().then(()=>{
   		
      		monthProductPresentTable6 = monthProductPresentTableFunc6();       	
       });

		
   		$('#planManPopUpModal').modal('show');
   });

   $('#btnDailyInvenReal').on('click', function() {
	   $('#dailyInven2PopupModal').modal('show');		   			
		$('#invenDateReal').val(inWhsDateCal.substring(0,7));
		
   });
   
 	/* let dailyInvenTable =$('#dailyInvenTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	        if(techNote == 7) {
	            toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.");
	            setTimeout(function() {
	            	location.href = "/wmsc0220";
	            	}, 1000);    
	        }
	     } ).DataTable({ 
			language : lang_kor,
			paging : true,
			searching: false,
			info : false,   			
			ordering : false,
			processing : true,
			autoWidth : false,
			lengthChange : false,
			pageLength : 20,
			ajax : {
				url : '<c:url value="wm/dailyInvenList"/>',
				type : 'GET',
				data : {					
					'fpDate'  :	 function(){return $('#invenDate').val().replace(/-/g,"");},
					'goodsCd':	 function(){return $('#goodsCdGj').val();},					
					'menuAuth'	: 	menuAuth,
				},
			},
		
			columns : [ 	
				{data : 'dealCorpCd',
					render: function(data, type, row, meta) {	   				
						var value ="";
						if(data!=null){
							value = '<input type="text" class="form-control" style="border:none; max-width:100%;" name="dealCorpNm" value="'+data+'" disabled>';		
							
						} else{
							value = '<input type="text" class="form-control" name="dealCorpNm" value=""  style="border:none; width:100%; " disabled>';
						}								
						
		    			var html = '<div class="input-sub m-0">';
		    				 html += value;
		    				 html += '<input type="hidden"  name="dealCorpCd" value="'+row['dealCorpCd']+'">';
		    				 html += '<button type="button" class="btn btn-primary input-sub-search" name="btnSelBuyCorp" onClick="selectDealCorpCode();" >';
		    				 html += '<span class="oi oi-magnifying-glass"></span>';
		    				 html += '</button>' ;
		    				 html += '</div>' ;
						return html;
					}
				},	
			
				{data : 'outGubun',
					render: function(data, type, row, meta) {	
						let html = '';						
						return selectBoxHtml2(outGubunCode,"outGubun", data, row, meta);						
	    			}
				},	

				{data : 'fpDate',
					render: function(data, type, row, meta) {
						let defaultDate = $('#inWhsDateCal').val();	
						if(data!=null){
		    				return '<input type="date" class="form-control" name="fpDate" value="'+moment(data).format("YYYY-MM-DD")+'"  style="border:none; width:100%;" >' ;	
						} else{
							return '<input type="date" class="form-control" name="fpDate" value="'+moment(defaultDate).format("YYYY-MM-DD")+'"  style="border:none; width:100%;">';	
						}								
	    			}
				},	
				
				{data : 'outputCnt',
					render: function(data, type, row, meta) {							
						if(data!=null){
		    				return '<input type="text" class="form-control number-float0" name="outputCnt" value="'+data+'"  style="border:none; width:100%;" >' ;	
						} else{
							return '<input type="text" class="form-control number-float0" name="outputCnt" value="0"  style="border:none; width:100%;">';	
						}		    			
		    		}
				},
			],
	        order: [
	            [ 0, 'asc' ]
	        ],
	        drawCallback: function(){   		        	
		      
			}
		});	

 */
 	let diIdx = '';
 	$(document).on('click','#planManTable_wrapper tbody tr', function(event) {   
 		if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#planManTable').DataTable().$('tr.selected').removeClass('selected');
        	$('#planManTable_wrapper tr.selected').removeClass('selected');
            $(this).addClass('selected');
            diIdx = $('#planManTable').DataTable().row(this).index();		
        }
        
 		
	  });

 	$('#rowDelete').on('click', function () {
 		$('#planManTable').DataTable().rows(diIdx).remove().draw();
 		 diIdx = '';
 	});

 	$('#modelRetv').on('click', function () {	
 		
 		   $('.planManModal').html(monthProductPresentTableOrigin6);
 	   		createHeaderMan().then(()=>{
 	   		
 	      		monthProductPresentTable6 = monthProductPresentTableFunc6();       	
 	       });
 		
 	
 		             
 	});

 	$('#modelRetvReal').on('click', function () {	
 	 	
 		$('#dailyInvenTable').DataTable().ajax.reload();  
 		$.ajax({
			url: '<c:url value="wm/dailyInvenRead"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'  :	 function(){return $('#invenDateReal').val().replace(/-/g,"");},
				'goodsCd':	 function(){return $('#goodsCdGjReal').val();},
				'gubun'		: '001',
			},
			success: function(res){	
				var data = res.data; 		
				if (res.result="ok"){
					if(data != null){						
						$('#lastMonthStockReal').val(addCommas(data.lastMonthStock));
					} else{						
						$('#lastMonthStockReal').val("0");
					}
				} else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			}
		});
 		             
 	});

 	$(document).on('change','#goodsCdGj', function () {
 		$('#dailyInvenTable').DataTable().ajax.reload();  
 		$.ajax({
			url: '<c:url value="wm/dailyInvenRead"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'  :	 function(){return $('#invenDate').val().replace(/-/g,"");},
				'goodsCd':	 function(){return $('#goodsCdGj').val();},
				'gubun'		: '002',
			},
			success: function(res){	
				var data = res.data; 		
				if (res.result="ok"){
					if(data != null){						
						$('#lastMonthStock').val(addCommas(data.lastMonthStock));
					} else{						
						$('#lastMonthStock').val("0");
					}
				} else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			}
		});
 	});

 	$(document).on('change','#goodsCdGjReal', function () {
 		  
 		$.ajax({
			url: '<c:url value="wm/dailyInvenRead"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'  :	 function(){return $('#invenDateReal').val().replace(/-/g,"");},
				'goodsCd':	 function(){return $('#goodsCdGjReal').val();},
				'gubun'		: '001',
			},
			success: function(res){	
				var data = res.data; 		
				if (res.result="ok"){
					if(data != null){						
						$('#lastMonthStockReal').val(addCommas(data.lastMonthStock));
					} else{						
						$('#lastMonthStockReal').val("0");
					}
				} else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			}
		});
 	});

	$('#btnSaveDailyInven').on('click', function () {
		let dataList = new Array();
		let fpDate1 = $('#invenDate').val().replace(/-/g,"");
		let check = true;

		if ( !$.trim($('#invenDate').val()) ) {
	            toastr.warning('일자를 입력해 주세요.');
	            $('#invenDate').focus();
	            return false;
	    }  	
        	
		if($('#planManTable').DataTable().data().count() != 0){
			$('#planManTable tbody tr').each(function(index,item){
				var rowData = new Object();
				if ( !$.trim($(this).find('select[name=goodsCdGj]').val()) ) {
		            toastr.warning('제품을 선택해 주세요.');
		            $(this).find('select[name=goodsCdGj]').focus();
		            check=false;
		            return false;
		   		 }
				if ( !$.trim($(this).find('input[name=dealCorpCd]').val()) ) {
		            toastr.warning('납품처를 입력해 주세요.');
		            $(this).find('input[name=dealCorpCd]').focus();
		            check=false;
		            return false;
		   		 }
				var goodsCd =  $(this).find('select[name=goodsCdGj]').val();
				var dealCorpCd =  $(this).find('input[name=dealCorpCd]').val();
				rowData.goodsCd = goodsCd;
				rowData.dealCorpCd = dealCorpCd;
				rowData.fpDate = $('#invenDate').val().replace(/-/g,"");
				rowData.outGubun = '001';
				rowData.count1 = ($(this).find('input[name=fpDate1]').val()!=null && $(this).find('input[name=fpDate1]').val()!="") ? $(this).find('input[name=fpDate1]').val().replace(/,/g,"") : "";   
				rowData.count2 = ($(this).find('input[name=fpDate2]').val()!=null && $(this).find('input[name=fpDate2]').val()!="") ? $(this).find('input[name=fpDate2]').val().replace(/,/g,"") : "";   
				rowData.count3 = ($(this).find('input[name=fpDate3]').val()!=null && $(this).find('input[name=fpDate3]').val()!="") ? $(this).find('input[name=fpDate3]').val().replace(/,/g,"") : "";   
				rowData.count4 = ($(this).find('input[name=fpDate4]').val()!=null && $(this).find('input[name=fpDate4]').val()!="") ? $(this).find('input[name=fpDate4]').val().replace(/,/g,"") : "";   
				rowData.count5 = ($(this).find('input[name=fpDate5]').val()!=null && $(this).find('input[name=fpDate5]').val()!="") ? $(this).find('input[name=fpDate5]').val().replace(/,/g,"") : "";   
				rowData.count6 = ($(this).find('input[name=fpDate6]').val()!=null && $(this).find('input[name=fpDate6]').val()!="") ? $(this).find('input[name=fpDate6]').val().replace(/,/g,"") : "";   
				rowData.count7 = ($(this).find('input[name=fpDate7]').val()!=null && $(this).find('input[name=fpDate7]').val()!="") ? $(this).find('input[name=fpDate7]').val().replace(/,/g,"") : "";   
				rowData.count8 = ($(this).find('input[name=fpDate8]').val()!=null && $(this).find('input[name=fpDate8]').val()!="") ? $(this).find('input[name=fpDate8]').val().replace(/,/g,"") : "";   
				rowData.count9 = ($(this).find('input[name=fpDate9]').val()!=null && $(this).find('input[name=fpDate9]').val()!="") ? $(this).find('input[name=fpDate9]').val().replace(/,/g,"") : "";   
				rowData.count10 = ($(this).find('input[name=fpDate10]').val()!=null && $(this).find('input[name=fpDate10]').val()!="") ? $(this).find('input[name=fpDate10]').val().replace(/,/g,"") : "";   
				rowData.count11 = ($(this).find('input[name=fpDate11]').val()!=null && $(this).find('input[name=fpDate11]').val()!="") ? $(this).find('input[name=fpDate11]').val().replace(/,/g,"") : "";   
				rowData.count12 = ($(this).find('input[name=fpDate12]').val()!=null && $(this).find('input[name=fpDate12]').val()!="") ? $(this).find('input[name=fpDate12]').val().replace(/,/g,"") : "";   
				rowData.count13 = ($(this).find('input[name=fpDate13]').val()!=null && $(this).find('input[name=fpDate13]').val()!="") ? $(this).find('input[name=fpDate13]').val().replace(/,/g,"") : "";   
				rowData.count14 = ($(this).find('input[name=fpDate14]').val()!=null && $(this).find('input[name=fpDate14]').val()!="") ? $(this).find('input[name=fpDate14]').val().replace(/,/g,"") : "";   
				rowData.count15 = ($(this).find('input[name=fpDate15]').val()!=null && $(this).find('input[name=fpDate15]').val()!="") ? $(this).find('input[name=fpDate15]').val().replace(/,/g,"") : "";   
				rowData.count16 = ($(this).find('input[name=fpDate16]').val()!=null && $(this).find('input[name=fpDate16]').val()!="") ? $(this).find('input[name=fpDate16]').val().replace(/,/g,"") : "";   
				rowData.count17 = ($(this).find('input[name=fpDate17]').val()!=null && $(this).find('input[name=fpDate17]').val()!="") ? $(this).find('input[name=fpDate17]').val().replace(/,/g,"") : "";   
				rowData.count18 = ($(this).find('input[name=fpDate18]').val()!=null && $(this).find('input[name=fpDate18]').val()!="") ? $(this).find('input[name=fpDate18]').val().replace(/,/g,"") : "";   
				rowData.count19 = ($(this).find('input[name=fpDate19]').val()!=null && $(this).find('input[name=fpDate19]').val()!="") ? $(this).find('input[name=fpDate19]').val().replace(/,/g,"") : "";   
				rowData.count20 = ($(this).find('input[name=fpDate20]').val()!=null && $(this).find('input[name=fpDate20]').val()!="") ? $(this).find('input[name=fpDate20]').val().replace(/,/g,"") : "";   
				rowData.count21 = ($(this).find('input[name=fpDate21]').val()!=null && $(this).find('input[name=fpDate21]').val()!="") ? $(this).find('input[name=fpDate21]').val().replace(/,/g,"") : "";   
				rowData.count22 = ($(this).find('input[name=fpDate22]').val()!=null && $(this).find('input[name=fpDate22]').val()!="") ? $(this).find('input[name=fpDate22]').val().replace(/,/g,"") : "";   
				rowData.count23 = ($(this).find('input[name=fpDate23]').val()!=null && $(this).find('input[name=fpDate23]').val()!="") ? $(this).find('input[name=fpDate23]').val().replace(/,/g,"") : "";   
				rowData.count24 = ($(this).find('input[name=fpDate24]').val()!=null && $(this).find('input[name=fpDate24]').val()!="") ? $(this).find('input[name=fpDate24]').val().replace(/,/g,"") : "";   
				rowData.count25 = ($(this).find('input[name=fpDate25]').val()!=null && $(this).find('input[name=fpDate25]').val()!="") ? $(this).find('input[name=fpDate25]').val().replace(/,/g,"") : "";   
				rowData.count26 = ($(this).find('input[name=fpDate26]').val()!=null && $(this).find('input[name=fpDate26]').val()!="") ? $(this).find('input[name=fpDate26]').val().replace(/,/g,"") : "";   
				rowData.count27 = ($(this).find('input[name=fpDate27]').val()!=null && $(this).find('input[name=fpDate27]').val()!="") ? $(this).find('input[name=fpDate27]').val().replace(/,/g,"") : "";   
				rowData.count28 = ($(this).find('input[name=fpDate28]').val()!=null && $(this).find('input[name=fpDate28]').val()!="") ? $(this).find('input[name=fpDate28]').val().replace(/,/g,"") : "";   
				rowData.count29 = ($(this).find('input[name=fpDate29]').val()!=null && $(this).find('input[name=fpDate29]').val()!="") ? $(this).find('input[name=fpDate29]').val().replace(/,/g,"") : "";   
				rowData.count30 = ($(this).find('input[name=fpDate30]').val()!=null && $(this).find('input[name=fpDate30]').val()!="") ? $(this).find('input[name=fpDate30]').val().replace(/,/g,"") : "";   
				rowData.count31 = ($(this).find('input[name=fpDate31]').val()!=null && $(this).find('input[name=fpDate31]').val()!="") ? $(this).find('input[name=fpDate31]').val().replace(/,/g,"") : "";
				 
				dataList.push(rowData);
			});
		} else{
			toastr.warning('데이터를 입력해 주세요.');
			return false;
		}
		
		if(check){
			$('#my-spinner').show();
			$.ajax({
	            url: '<c:url value="/wm/dailyInvenCreate"/>',
	            type: 'POST',
	            data: JSON.stringify(dataList),
	            dataType:"json",
	            contentType : "application/json; charset=UTF-8",      
	   
	            success: function (res) {
	                let data = res.data;      
	                if (res.result == 'ok') {
	                	$('#gijongDailyTable2').DataTable().ajax.reload( function () {$('#gijongDailyTable2').DataTable().columns.adjust();});
	                	$('#planManTable').DataTable().ajax.reload( function () {$('#planManTable').DataTable().columns.adjust();});    
	                	
	                	            	
	                	toastr.success("저장되었습니다.");
						
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            }
	        });
		}
		

		
	});

	$('#btnSaveDailyInven2').on('click', function () {
		let dataList = new Array();
		let fpDate1 = $('#invenDateReal').val().replace(/-/g,"");
		let goodsCd = $('#goodsCdGjReal').val();
		let lastMonthStock = $('#lastMonthStockReal').val().replace(/,/g,"");
		

		if ( !$.trim($('#invenDateReal').val()) ) {
	            toastr.warning('일자를 입력해 주세요.');
	            $('#invenDateReal').focus();
	            return false;
	        }  
		if ( !$.trim($('#goodsCdGjReal').val()) ) {
            toastr.warning('제품명을 선택해 주세요.');
            $('#goodsCdGjReal').focus();
            return false;
        }
             
        if ( !$.trim($('#lastMonthStockReal').val()) ) {
            toastr.warning('전월재고를 입력해 주세요.');
            $('#lastMonthStockReal').focus();
            return false;
        }

		$('#my-spinner').show();
		$.ajax({
            url: '<c:url value="/wm/dailyInvenCreateReal"/>',
            type: 'POST',
            data: {
					'fpDate' : function(){return fpDate1;},
					'goodsCd' : function(){return goodsCd;},
					'lastMonthStock' : function(){return lastMonthStock;},
					'gubun'		: '001',
            },
            async: false,           
            success: function (res) {
                let data = res.data;      
                if (res.result == 'ok') {
                	toastr.success("저장되었습니다.");					
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });
		
		

		
	});

 	 
 	function selectBoxHtml2(obj, id, sVal, row, meta)
	{
	
		var shtml = '<select class="custom-select" name="'+ id +'" data-col="' + meta.col + '"><option value="">선택</option>';
		
		
		var option;
		for(key in obj) {
			var tmp; 
			if(obj[key].baseCd == sVal ) {
				tmp = "<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseNm+"</option>";
			} else {
				tmp = "<option value="+obj[key].baseCd+">"+obj[key].baseNm+"</option>";
			}	
			option += tmp;
		}
		var ehtml = '</select>';
		return shtml + option + ehtml;
	}	

	//거래처정보조회 팝업 시작
   	var dealCorpPopUpTable = null;
   	function selectDealCorpCode()
   	{
   	   	//var url="/cmsc0020";
		//window.open(url, "거래처정보조회팝업", "width=1200,height=800,left=600");
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
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
		            [ 0, 'asc' ]
		        ],

		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });
		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable.row( this ).data();
				$('input[name="dealCorpCd"]').eq(diIdx).val(data.dealCorpCd);
				$('input[name="dealCorpNm"]').eq(diIdx).val(data.dealCorpNm);
				//$('#planManTable').DataTable().draw();
                $('#dealCorpPopUpModal').modal('hide');

                
		    });
		} else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload();
		}
		$('#dealCorpPopUpModal').modal('show');
   	}
	//거래처정보조회 팝업 종료  

	$('#rowAdd').on('click', function() {		
		$('#planManTable').DataTable().row.add({}).draw();
		
	});


	   let resizeTimer = false;    
	   $(window).on('resize', function(e) {
	        if( !resizeTimer ) {
	         $(window).trigger('resizestart');     
	      }
	      clearTimeout(resizeTimer);
	      resizeTimer = setTimeout(function() {
	         resizeTimer = false;
	         $(window).trigger('resizeend');
	      }, 50);
	   }).on('resizeend', function(){
	      dataTableDrawAll(); 
	   });
   
	 function dataTableDrawAll() {
		 $('.dataTables_wrapper').each(function(index, node) {
	         let datatableId = $(node).attr('id').split('_')[0];
	         $('#'+datatableId).DataTable().draw(false).columns.adjust();
	      });
	 }


	 $(document).on('dblclick','#productionPlanDtlTable tbody tr td',function(){

	        if($('#productionPlanDtlTable').DataTable().row(this).data().gubunNm == '차이량'){
	        	
	        	equipCd = $('#productionPlanDtlTable').DataTable().row(this).data().equipCd;	        
	        	goodsCd = $('#productionPlanDtlTable').DataTable().row(this).data().goodsCd;	        	   	
	        	countNm = $(this).find('span').eq(1).attr('name');
	        	var day = countNm.substring(6);        	
	        	planDate = $('#inWhsDateCal').val().replace(/-/g,"").substring(0,6) + day.padStart(2,'0');
	        	memoGubun = '001';
	        	$('#memo').val("");
	        	
	        	$.ajax({
	    	   		url: '<c:url value="wm/memoMonthProductionMemo"/>',
	    			type: 'GET',
	    			async: false,
	    			data: {
	    				'menuAuth'	:	menuAuth,	    				
	    				'planDate'	:	function(){return planDate;},
	    				'equipCd'	:	function(){return equipCd;},
	    				'goodsCd'	:	function(){return goodsCd;},
	    				'memoGubun'	:	function(){return memoGubun;},
	    			},
	    			success: function(res){
	    				var data = res.data;
	    				if (res.result=="ok"){	
	        				if(data != null){
	        					$('#memo').val(data.memo);
	        					
	            			}				
	    					
	    				}    				
	    			}
	    		});
	        	
	        	$('#memoPopUpModal').modal('show');
	        }

	        if($('#productionPlanDtlTable').DataTable().row(this).data().gubunNm == '생산 조(주간)' ){
	        	
	        	equipCd = $('#productionPlanDtlTable').DataTable().row(this).data().equipCd;	        
	        	goodsCd = $('#productionPlanDtlTable').DataTable().row(this).data().goodsCd;	        	   	
	        	countNm = $(this).find('span').eq(1).attr('name');
	        	var day = countNm.substring(6);        	
	        	planDate = $('#inWhsDateCal').val().replace(/-/g,"").substring(0,6) + day.padStart(2,'0');
	        	memoGubun = '004';
	        	$('#memo').val("");
	        	
	        	$.ajax({
	    	   		url: '<c:url value="wm/memoMonthProductionMemo"/>',
	    			type: 'GET',
	    			async: false,
	    			data: {
	    				'menuAuth'	:	menuAuth,	    				
	    				'planDate'	:	function(){return planDate;},
	    				'equipCd'	:	function(){return equipCd;},
	    				'goodsCd'	:	function(){return goodsCd;},
	    				'memoGubun'	:	function(){return memoGubun;},
	    			},
	    			success: function(res){
	    				var data = res.data;
	    				if (res.result=="ok"){	
	        				if(data != null){
	        					$('#memo').val(data.memo);
	        					
	            			}				
	    					
	    				}    				
	    			}
	    		});
	        	
	        	$('#memoPopUpModal').modal('show');
	        }


	        if($('#productionPlanDtlTable').DataTable().row(this).data().gubunNm == '생산 조(야간)' ){
	        	
	        	equipCd = $('#productionPlanDtlTable').DataTable().row(this).data().equipCd;	        
	        	goodsCd = $('#productionPlanDtlTable').DataTable().row(this).data().goodsCd;	        	   	
	        	countNm = $(this).find('span').eq(1).attr('name');
	        	var day = countNm.substring(6);        	
	        	planDate = $('#inWhsDateCal').val().replace(/-/g,"").substring(0,6) + day.padStart(2,'0');
	        	memoGubun = '005';
	        	$('#memo').val("");
	        	
	        	$.ajax({
	    	   		url: '<c:url value="wm/memoMonthProductionMemo"/>',
	    			type: 'GET',
	    			async: false,
	    			data: {
	    				'menuAuth'	:	menuAuth,	    				
	    				'planDate'	:	function(){return planDate;},
	    				'equipCd'	:	function(){return equipCd;},
	    				'goodsCd'	:	function(){return goodsCd;},
	    				'memoGubun'	:	function(){return memoGubun;},
	    			},
	    			success: function(res){
	    				var data = res.data;
	    				if (res.result=="ok"){	
	        				if(data != null){
	        					$('#memo').val(data.memo);
	        					
	            			}				
	    					
	    				}    				
	    			}
	    		});
	        	
	        	$('#memoPopUpModal').modal('show');
	        }
	    	
	    	
			
	    });

	 
	 $(document).on('dblclick','#productionPlanMainTable tbody tr td',function(){

	        if($('#productionPlanMainTable').DataTable().row(this).data().goodsCd == '운영 계획 대비'){
	        	equipCd ='';	        
	        	goodsCd ='';		        		   	
	        	countNm = $(this).find('span').eq(1).attr('name');
	        	var day = countNm.substring(6);        	
	        	planDate = $('#inWhsDateCal').val().replace(/-/g,"").substring(0,6) + day.padStart(2,'0');
				memoGubun = '003';
	        	$('#memo').val("");
	        	
	        	$.ajax({
	    	   		url: '<c:url value="wm/memoMonthProductionMemo"/>',
	    			type: 'GET',
	    			async: false,
	    			data: {
	    				'menuAuth'	:	menuAuth,	    				
	    				'planDate'	:	function(){return planDate;},
	    				'memoGubun'	:	function(){return memoGubun;},
	    			},
	    			success: function(res){
	    				var data = res.data;
	    				if (res.result=="ok"){	
	        				if(data != null){
	        					$('#memo').val(data.memo);
	        					
	            			}				
	    					
	    				}    				
	    			}
	    		});
	        	
	        	$('#memoPopUpModal').modal('show');
	        }

   			if($('#productionPlanMainTable').DataTable().row(this).data().goodsCd == '확정 계획 대비'){
   				equipCd ='';	        
	        	goodsCd ='';	        		   	
	        	countNm = $(this).find('span').eq(1).attr('name');
	        	var day = countNm.substring(6);        	
	        	planDate = $('#inWhsDateCal').val().replace(/-/g,"").substring(0,6) + day.padStart(2,'0');
	        	memoGubun = '002';
	        	$('#memo').val("");
	        	
	        	$.ajax({
	    	   		url: '<c:url value="wm/memoMonthProductionMemo"/>',
	    			type: 'GET',
	    			async: false,
	    			data: {
	    				'menuAuth'	:	menuAuth,	    				
	    				'planDate'	:	function(){return planDate;},
	    				'memoGubun'	:	function(){return memoGubun;},
	    			},
	    			success: function(res){
	    				var data = res.data;
	    				if (res.result=="ok"){	
	        				if(data != null){
	        					$('#memo').val(data.memo);
	        					
	            			}				
	    					
	    				}    				
	    			}
	    		});
	        	
	        	$('#memoPopUpModal').modal('show');
	        }

	    });

	    
	    $('#btnMemoSave').on('click',function(){    

	   		$.ajax({
		   		url: '<c:url value="wm/createMonthProductionMemo"/>',
				type: 'POST',
				async: false,
				data: {
					'menuAuth'	:	menuAuth,					
					'goodsCd'	:	function(){return goodsCd;},	
					'equipCd'	:	function(){return equipCd;},
					'planDate'	:	function(){return planDate;},
					'memoGubun'	:	function(){return memoGubun;},			
					'memo'		:	$('#memo').val(),
				},
				success: function(res){
					var data = res.data;
					if (res.result=="ok"){					
						$('[data-toggle="popover"]').popover('hide');
						toastr.success("저장되었습니다.");  
						if(memoGubun == '001' || memoGubun == '004' || memoGubun == '005'){
							$('#productionPlanDtlTable').DataTable().ajax.reload();
						} else{
							$('#productionPlanMainTable').DataTable().ajax.reload();
						}
					
					}
					$('#memoPopUpModal').modal('hide');
				}
			});
	    });

	    $('#btnCreateStock').on('click',function(){    

	   		$.ajax({
		   		url: '<c:url value="wm/createNextMonthStock"/>',
				type: 'POST',
				async: false,
				data: {
					'menuAuth'	:	menuAuth,			
					'fpDate'	:	function(){return $('#invenDate').val().replace(/-/g,"");},
					'gubun'		:	function(){return '002';},
				},
				success: function(res){
					var data = res.data;
					if (res.result == "ok"){	
						toastr.success("저장되었습니다.");
					} else{
						toastr.error(res.message);
					}
				
				}
			});
	    });

	    $('#btnCreateStockReal').on('click',function(){    

	   		$.ajax({
		   		url: '<c:url value="wm/createNextMonthStock"/>',
				type: 'POST',
				async: false,
				data: {
					'menuAuth'	:	menuAuth,			
					'fpDate'	:	function(){return $('#invenDateReal').val().replace(/-/g,"");},
					'gubun'		:	function(){return '001';},
				},
				success: function(res){
					var data = res.data;
					if (res.result == "ok"){	
						toastr.success("저장되었습니다.");
					} else{
						toastr.error(res.message);
					}
				
				}
			});
	    });

	    $('#btnDeleteStockReal').on('click',function(){    

	   		$.ajax({
		   		url: '<c:url value="wm/dailyInvenCreateRealDelete"/>',
				type: 'POST',
				async: false,
				data: {
					'menuAuth'	:	menuAuth,			
					'fpDate'	:	function(){return $('#invenDateReal').val().replace(/-/g,"");},
					'gubun'		:	function(){return '001';},
					'goodsCd'	:	function(){return $('#goodsCdGjReal').val()}
				},
				success: function(res){
					var data = res.data;
					if (res.result == "ok"){	
						$('#lastMonthStockReal').val("0");
						toastr.success("저장되었습니다.");
					} else{
						toastr.error(res.message);
					}
				
				}
			});
	    });

		function createHeaderMan(){
			return new Promise((resolve, reject)=> {
				$.ajax({
					url: '<c:url value="wm/createMonthPlanHeader"/>',
					type: 'GET',  
					async: false,
					data: {
						'menuAuth'	:	menuAuth,
						'planDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
					},
					success: function(res){
						var data = res.data;
						if (res.result="ok"){
							dayCount = res.dayCount;
							//toastr.success(dayCount);
							var data = res.data;
							var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">제품</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">납품처</th>';
						
						
							for (var i=0; i<data.length; i++) {
								//존재하지 않는 날짜
								if (data[i].day == 0) {
									planHeader += '<th class="text-center mday' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
								//토요일
								} else if (data[i].day == 7) {
									planHeader += '<th class="text-center mday' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
								//일요일
								} else if (data[i].day == 1)
									planHeader += '<th class="text-center mday' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
								//그외
								else {
									planHeader += '<th class="text-center mday' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
								}
							}
							//$('#planHeader').html(planHeader);
							$('#planHeaderMan').html(planHeader).promise().done(function(){
								//console.log('create header end');
								resolve();
							});
						}
					}
				});
			});
	    }

	    function monthProductPresentTableFunc6(){
	        //console.log("난 테이블이야")
	        let tempTableData = $('#planManTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	        		if(techNote == 7) {
	        			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
	        			location.href = "/";
	        		}
	        	}).DataTable({
	                dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
	        				"<'row'<'col-sm-12'tr>>" +
	        				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
	        																	//B
	                language: lang_kor,
	                paging: false,
	                info: false,       
	                ordering: false,
	                processing: true,
	                autoWidth: false,             
	                pageLength: false,
	                searching: false,
	                //destroy: true, 
	        		//header 고정
	        		scrollY: '73vh',
	        		scrollX: true,
	        		//fixedColumns: {
	        		//	leftColumns: 2
	        		//},
	        		ajax: {
	                    url: '<c:url value="/wm/dailyInvenList"/>',
	                    type: 'POST',
	                    data: {
	                    	'menuAuth'		:		menuAuth,
	                    	'fpDate' 		 :	 function(){return $('#invenDate').val().replace(/-/g,"");},       	
	                    },
	                    /*
	                    success : function(res) {
	                        console.log(res);
	                    }
	                    */
	                },
	                columns: [
	                	{ data: 'goodsCd',
	                		render: function(data, type, row, meta) {	
	    						let html = '';						
	    						return selectBoxHtml2(goodsCodeList2,"goodsCdGj", data, row, meta);						
	    	    			}
						},
	                	{data : 'dealCorpCd',
							render: function(data, type, row, meta) {	   				
								var value ="";
								if(data!=null){
									value = '<input type="text" class="form-control" style="border:none; max-width:100%;" name="dealCorpNm" value="'+row['dealCorpNm']+'" disabled>';		
									
								} else{
									value = '<input type="text" class="form-control" name="dealCorpNm" value=""  style="border:none; width:100%; " disabled>';
								}								
								
				    			var html = '<div class="input-sub m-0">';
				    				 html += value;
				    				 html += '<input type="hidden"  name="dealCorpCd" value="'+row['dealCorpCd']+'">';
				    				 html += '<button type="button" class="btn btn-primary input-sub-search" name="btnSelBuyCorp" onClick="selectDealCorpCode();" >';
				    				 html += '<span class="oi oi-magnifying-glass"></span>';
				    				 html += '</button>' ;
				    				 html += '</div>' ;
								return html;
							}
						},	
	        			<c:forEach var="item" begin="1" end="31" step="1">
	    	         	{ data: 'fpDate${item}' ,
	    	        		render: function(data, type, row) {
	        	       
	    	        			if(data == null || data == 'null'){        	        			
	    	                		let html = '<input type="text" class="form-control text-center" id="'+row["goodsCd"]+row["dealCorpCd"]+'fpDate${item}" name="fpDate' + '${item}'+ '" value = ' + "" + '>';
									return html;    	                			
	    	                	} else{ 
	    	                		let html = '<input type="text" class="form-control text-center" id="'+row["goodsCd"]+row["dealCorpCd"]+'fpDate${item}" name="fpDate' + '${item}'+ '" value = ' + addCommas(Math.floor(data)) + '>';    	                    		
									return html;
	    	                	}
	    	                    
	    	        		}
	    	    		},    		
	        		</c:forEach>
	                ],
	        		
	                columnDefs: [
	                	
	                	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], className: 'text-right-td' },
	                ],
	               
	        	
	        		drawCallback:function( settings){
	        			//var api = this.api();
	        			//api.fixedColumns().update();
	        			$.each($('#planManTable tr'),function(index, item){
	        				if($('.mday27').text()==""){
	        					$(this).find('th').eq(28).addClass('d-none');
	        					$(this).find('td').eq(28).addClass('d-none');
	        				}
	        				if($('.mday28').text()==""){
	        					$(this).find('th').eq(29).addClass('d-none');
	        					$(this).find('td').eq(29).addClass('d-none');
	        				}
	        				if($('.mday29').text()==""){
	        					$(this).find('th').eq(30).addClass('d-none');
	        					$(this).find('td').eq(30).addClass('d-none');
	        				}
	        				if($('.mday30').text()==""){
	        					$(this).find('th').eq(31).addClass('d-none');
	        					$(this).find('td').eq(31).addClass('d-none');
	        				}
	        				if($('.mday31').text()==""){
	        					$(this).find('th').eq(32).addClass('d-none');
	        					$(this).find('td').eq(32).addClass('d-none');
	        				}
	        				
	        				if(index == $('#planManTable').DataTable().data().count() - 1){
	                        	$('#my-spinner').hide();
	                        }
	        			});					
	        			
	        			if (temp) {
	        				toastr.success('조회되었습니다');
	        				temp = false;
	        			}


	        		}
	            });

	        return tempTableData;
	    }

	    $('select[name=goodsCdGj]').on('change',function(){
	    	//$('#planManTable').DataTable().draw();
		});
</script>

</body>
</html>