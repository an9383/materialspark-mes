<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">출하검사현황</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table id="stateTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th style="min-width:10px; vertical-align:middle;" class="text-center" rowspan="2">
									<input type="checkbox" id="checkAll" name="checkAll" style="min-width: 10px; width: 20px; height: 20px;">
								</th>
		                        <th rowspan="2" style="min-width: 70px">생산일</th>
		                        <th rowspan="2" style="min-width: 70px">합불 시간</th>
		                        <th rowspan="2" style="min-width: 70px">월별</th>
		                        <th rowspan="2" style="min-width: 70px">주별</th>
		                        <th rowspan="2" style="min-width: 70px">검사일</th>
		                        <th rowspan="2" style="min-width: 80px">생산작업자</th>
		                        <th rowspan="2" style="min-width: 50px">검사자</th>
		                        <th rowspan="2" style="min-width: 50px">합불판정</th>
		                        <th rowspan="2" style="min-width: 50px">주/야구분</th>
		                        <th rowspan="2" style="min-width: 50px">설비명</th>
		                        <th rowspan="2" style="min-width: 100px">트레이번호</th>
		                        <th rowspan="2" style="min-width: 100px">주재료</th>		                  
		                        <th rowspan="2" style="min-width: 50px">제품</th>
		                        <th rowspan="2" style="min-width: 50px">재질</th>
		                        <th rowspan="2" style="min-width: 70px" class="text-center">검사수량</th>
		                        <th rowspan="2" style="min-width: 70px" class="text-center">양품수량</th>
		                        <th rowspan="2" style="min-width: 70px" class="text-center">불량수량</th>
		                        <th rowspan="2" style="min-width: 50px">부적합<br>TRAY<br>번호</th>
		                        <th rowspan="2" style="min-width: 50px" class="text-center">샘플수량</th>
		                        
		                        <th rowspan="2" style="min-width: 50px" class="text-center">중량(kg)</th>
		                        <th rowspan="2" style="min-width: 50px" class="text-center">중량판정</th>
		                        
		                        <th rowspan="2" style="min-width: 50px" class="text-center">검사방법</th>
		                        <th rowspan="2" style="min-width: 50px" class="text-center">재검유형</th>
		                        <th rowspan="2" style="min-width: 50px">불량유형</th>
		                        
		                        <th rowspan="2" style="min-width: 200px">요약불량유형</th>
		                        
		                        <th rowspan="2" style="min-width: 100px" class="text-center">원자재성</th>
		                        <th rowspan="2" style="min-width: 100px" class="text-center">공정성</th>
		                        
		                        <th colspan="13" style="min-width: 70px;" class="text-center" class="text-center" id="metalHd">메탈부 불량</th>
								<th colspan="15" style="min-width: 70px;" class="text-center" class="text-center" id="filmHd">필름부 불량</th>
							</tr>
							<tr id="appearFaultyWeekHd">
							
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="" style="text-align: center">합계</td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>								
								<td colspan="" style="text-align: center"></td>	
								<td colspan="" id="sumInsp"		name="sumInsp"		style="text-align: right">0</td>
								<td colspan="" id="sumOutput"	name="sumOutput"	style="text-align: right">0</td>
								<td colspan="" id="sumFaulty"	name="sumFaulty"	style="text-align: right">0</td>
								<td colspan="" style="text-align: center"></td>	
								<td colspan="" id="sumSample"	name="sumSample"	style="text-align: right">0</td>
								
								<td colspan="" id= "sumThreeTrayWeight" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>
								<td colspan="" style="text-align: center"></td>	
								
								
								<td id="gubunFaultySum1"></td>
								<td id="gubunFaultySum2"></td>
								
								
								<td colspan="" id="sum1" style="text-align: right">0</td>
								<td colspan="" id="sum2" style="text-align: right">0</td>
								<td colspan="" id="sum3" style="text-align: right">0</td>
								<td colspan="" id="sum4" style="text-align: right">0</td>
								<td colspan="" id="sum5" style="text-align: right">0</td>
								<td colspan="" id="sum6" style="text-align: right">0</td>
								<td colspan="" id="sum7" style="text-align: right">0</td>
								<td colspan="" id="sum8" style="text-align: right">0</td>
								<td colspan="" id="sum9" style="text-align: right">0</td>
								<td colspan="" id="sum10" style="text-align: right">0</td>
								<td colspan="" id="sum11" style="text-align: right">0</td>
								<td colspan="" id="sum12" style="text-align: right">0</td>
								<td colspan="" id="sum13" style="text-align: right">0</td>
								<td colspan="" id="sum14" style="text-align: right">0</td>
								<td colspan="" id="sum15" style="text-align: right">0</td>
								<td colspan="" id="sum16" style="text-align: right">0</td>
								<td colspan="" id="sum17" style="text-align: right">0</td>
								<td colspan="" id="sum18" style="text-align: right">0</td>
								<td colspan="" id="sum19" style="text-align: right">0</td>
								<td colspan="" id="sum20" style="text-align: right">0</td>
								<td colspan="" id="sum21" style="text-align: right">0</td>
								<td colspan="" id="sum22" style="text-align: right">0</td>
								<td colspan="" id="sum23" style="text-align: right">0</td>
								<td colspan="" id="sum24" style="text-align: right">0</td>
								<td colspan="" id="sum25" style="text-align: right">0</td>
								<td colspan="" id="sum26" style="text-align: right">0</td>
								<td colspan="" id="sum27" style="text-align: right">0</td>
								<td colspan="" id="sum28" style="text-align: right">0</td>
								<td colspan="" id="sum29" style="text-align: right">0</td>
								<td colspan="" id="sum30" style="text-align: right">0</td>
								<td colspan="" id="sum31" style="text-align: right">0</td>
								<td colspan="" id="sum32" style="text-align: right">0</td>
								<td colspan="" id="sum33" style="text-align: right">0</td>
								<td colspan="" id="sum34" style="text-align: right">0</td>
								<td colspan="" id="sum35" style="text-align: right">0</td>
								<td colspan="" id="sum36" style="text-align: right">0</td>
								<td colspan="" id="sum37" style="text-align: right">0</td>
								<td colspan="" id="sum38" style="text-align: right">0</td>
								<td colspan="" id="sum39" style="text-align: right">0</td>
								<td colspan="" id="sum40" style="text-align: right">0</td>
								<td colspan="" id="sum41" style="text-align: right">0</td>
								<td colspan="" id="sum42" style="text-align: right">0</td>
								<td colspan="" id="sum43" style="text-align: right">0</td>
								<td colspan="" id="sum44" style="text-align: right">0</td>
								<td colspan="" id="sum45" style="text-align: right">0</td>
								<td colspan="" id="sum46" style="text-align: right">0</td>
								<td colspan="" id="sum47" style="text-align: right">0</td>
								<td colspan="" id="sum48" style="text-align: right">0</td>
								<td colspan="" id="sum49" style="text-align: right">0</td>
								<td colspan="" id="sum50" style="text-align: right">0</td>
								<td colspan="" id="sum51" style="text-align: right">0</td>
								<td colspan="" id="sum52" style="text-align: right">0</td>
								<td colspan="" id="sum53" style="text-align: right">0</td>
								<td colspan="" id="sum54" style="text-align: right">0</td>
								<td colspan="" id="sum55" style="text-align: right">0</td>
								<td colspan="" id="sum56" style="text-align: right">0</td>
								<td colspan="" id="sum57" style="text-align: right">0</td>
								<td colspan="" id="sum58" style="text-align: right">0</td>
								<td colspan="" id="sum59" style="text-align: right">0</td>
								<td colspan="" id="sum60" style="text-align: right">0</td>
								<td colspan="" id="sum61" style="text-align: right">0</td>
								<td colspan="" id="sum62" style="text-align: right">0</td>
								<td colspan="" id="sum63" style="text-align: right">0</td>
								<td colspan="" id="sum64" style="text-align: right">0</td>
								<td colspan="" id="sum65" style="text-align: right">0</td>
								<td colspan="" id="sum66" style="text-align: right">0</td>
								<td colspan="" id="sum67" style="text-align: right">0</td>
								<td colspan="" id="sum68" style="text-align: right">0</td>
								<td colspan="" id="sum69" style="text-align: right">0</td>
								<td colspan="" id="sum70" style="text-align: right">0</td>
								<td colspan="" id="sum71" style="text-align: right">0</td>
								<td colspan="" id="sum72" style="text-align: right">0</td>
								<td colspan="" id="sum73" style="text-align: right">0</td>
								<td colspan="" id="sum74" style="text-align: right">0</td>
								<td colspan="" id="sum75" style="text-align: right">0</td>
								<td colspan="" id="sum76" style="text-align: right">0</td>
								<td colspan="" id="sum77" style="text-align: right">0</td>
								<td colspan="" id="sum78" style="text-align: right">0</td>
								<td colspan="" id="sum79" style="text-align: right">0</td>
								<td colspan="" id="sum80" style="text-align: right">0</td> 
								<td colspan="" id="sum81" style="text-align: right">0</td> 
								<td colspan="" id="sum82" style="text-align: right">0</td>
								<td colspan="" id="sum83" style="text-align: right">0</td>
								<td colspan="" id="sum84" style="text-align: right">0</td>
								<td colspan="" id="sum85" style="text-align: right">0</td>
								<td colspan="" id="sum86" style="text-align: right">0</td>
								<td colspan="" id="sum87" style="text-align: right">0</td>
								<td colspan="" id="sum88" style="text-align: right">0</td>
								<td colspan="" id="sum89" style="text-align: right">0</td>
								<td colspan="" id="sum90" style="text-align: right">0</td> 
								<td colspan="" id="sum91" style="text-align: right">0</td> 
								<td colspan="" id="sum92" style="text-align: right">0</td>
								<td colspan="" id="sum93" style="text-align: right">0</td>
								<td colspan="" id="sum94" style="text-align: right">0</td>
								<td colspan="" id="sum95" style="text-align: right">0</td>
								<td colspan="" id="sum96" style="text-align: right">0</td>
								<td colspan="" id="sum97" style="text-align: right">0</td>
								<td colspan="" id="sum98" style="text-align: right">0</td>
								<td colspan="" id="sum99" style="text-align: right">0</td>
								<td colspan="" id="sum100" style="text-align: right">0</td>
								<td colspan="" id="sum101" style="text-align: right">0</td>
								<td colspan="" id="sum102" style="text-align: right">0</td>
								<td colspan="" id="sum103" style="text-align: right">0</td>
								<td colspan="" id="sum104" style="text-align: right">0</td>
								<td colspan="" id="sum105" style="text-align: right">0</td>
								<td colspan="" id="sum106" style="text-align: right">0</td>
								<td colspan="" id="sum107" style="text-align: right">0</td>
								<td colspan="" id="sum108" style="text-align: right">0</td>
								<td colspan="" id="sum109" style="text-align: right">0</td>
								<td colspan="" id="sum110" style="text-align: right">0</td>
								<td colspan="" id="sum111" style="text-align: right">0</td>
								<td colspan="" id="sum112" style="text-align: right">0</td>
								<td colspan="" id="sum113" style="text-align: right">0</td>
								<td colspan="" id="sum114" style="text-align: right">0</td>
								<td colspan="" id="sum115" style="text-align: right">0</td>
								<td colspan="" id="sum116" style="text-align: right">0</td>
								<td colspan="" id="sum117" style="text-align: right">0</td>
								<td colspan="" id="sum118" style="text-align: right">0</td>
								<td colspan="" id="sum119" style="text-align: right">0</td>
								<td colspan="" id="sum120" style="text-align: right">0</td>
								<td colspan="" id="sum121" style="text-align: right">0</td>
								<td colspan="" id="sum122" style="text-align: right">0</td>
								<td colspan="" id="sum123" style="text-align: right">0</td>
								<td colspan="" id="sum124" style="text-align: right">0</td>
								<td colspan="" id="sum125" style="text-align: right">0</td>
								<td colspan="" id="sum126" style="text-align: right">0</td>
								<td colspan="" id="sum127" style="text-align: right">0</td>
								<td colspan="" id="sum128" style="text-align: right">0</td>
								<td colspan="" id="sum129" style="text-align: right">0</td>
								<td colspan="" id="sum130" style="text-align: right">0</td>
								<td colspan="" id="sum131" style="text-align: right">0</td>
								<td colspan="" id="sum132" style="text-align: right">0</td>
								<td colspan="" id="sum133" style="text-align: right">0</td>
								<td colspan="" id="sum134" style="text-align: right">0</td>
								<td colspan="" id="sum135" style="text-align: right">0</td>
								<td colspan="" id="sum136" style="text-align: right">0</td>
								<td colspan="" id="sum137" style="text-align: right">0</td>
								<td colspan="" id="sum138" style="text-align: right">0</td>
								<td colspan="" id="sum139" style="text-align: right">0</td>
								<td colspan="" id="sum140" style="text-align: right">0</td>
							</tr>
						</tfoot>
					</table>
				</div>
			<!-- /.table-responsive -->
			
			
				<!-- .table-responsive -->
				<div class="d-none" style="/* position: fixed;left: 500px;bottom: 40px; */width: 480px;" id="infoDiv">
					<table class="table table-bordered ml-3">
						<thead class="thead-light">
							<tr>
		                        <th>전체 출하 검사</th>
		                        <th>Major 부적합 건수</th>
		                        <th>Minor 부적합 건수</th>
		                        <th>총 부적합 건수</th>
		                        <th>뷸량률</th>
							</tr>
						</thead>
						<tbody>
							<tr style="background: #5ac0ff;color: black;">
								<td id="totalCount">...</td>
								<td id="majorCount">...</td>
								<td id="minorCount">...</td>
								<td id="totalFaultyCount">...</td>
								<td id="faultyPercent">...</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- /.table-responsive -->
			
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<!-- 이상발생 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="abnormalPopUpModal" tabindex="-1" role="dialog" aria-labelledby="abnormalPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin-right: 60%;">
		<div class="modal-content" style="width: 315%;">
			<div class="modal-header">
				<h5 class="modal-title">이상발생 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				
				<div class="table-responsive" style="height: 78vh; border-bottom: 1px solid #e3e3e3;" id="inDiv">	
					<form id="form" method="post" enctype="multipart/form-data">	
						<table id="abnormalTableAdm" class="table table-bordered" style="text-align: center">
							<thead class="thead-light">
								<tr>			
									<th>이상 발생 번호</th>
									<th>이상 발생 일자</th>	
									<th>이상 발생 공정</th>								
									<th>이상 발생 내용</th>
									<th>담당자</th>
									<th>격리여부</th>
									<th>종결문서</th>													
								</tr>							
							</thead>
							<tr>			
								<td><input type="text" id="abnormalNo" class="form-control" placeholder="자동채번" value="" style="max-width:100%;" disabled></td>
								<td><input type="date" id="abnormalDate" class="form-control" value="" style="max-width:100%;"></td>
								<td><select class="custom-select" id="abnormalPrcss"></select></td>								
								<td><input type="text" id="abnormalDesc" class="form-control" value="" style="max-width:100%;"></td>
								<td> <div class="input-sub m-0" style=" max-width:100%;">
					    				 <input type="text" class="form-control" style="border:none; max-width:100%;" id="managerNm" value=""  disabled>
					    				 <input type="hidden" id="manager" value="">
					    				 <button type="button" class="btn btn-primary input-sub-search" id="btnSelChargr" onClick="selectChargr();" >
					    				 <span class="oi oi-magnifying-glass"></span>
					    				 </button>
					    				 </div>
		    					</td>
								<td><select class="custom-select" id="isolationYn"></select></td>
								<td><div class="custom-file" id="fileDiv">
									
										<input type="file" class="custom-file-input" id="file" name="file"  />
							 			<label class="custom-file-label" for="file" id="fileLabel">파일을 선택해주세요.</label>
									</div>
								</td>													
							</tr>
						</table>	
					</form>
					
					<table id="abnormalTable" class="table table-bordered" style="text-align: center">
						<thead class="thead-light">
							<tr>											
								<th>생산일</th>
								<th>검사일</th>
								<th>생산작업자</th>								
								<th>검사자</th>
								<th>설비명</th>
								<th>트레이번호</th>
								<th>이상발생수량</th>
								<th>담당부서</th>								
								<th>해당 불량 발생 수량</th>								
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
				
				
				<!-- /.table-responsive -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary float-right mr-1" id="btnInAddSave" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnInAddCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 가입고 등록 모달 종료 -->


<%@include file="../layout/bottom.jsp" %>
<style>
.skyYellow2{
  background-color: #FFFF99 !important;
}
</style>
<script>

	let menuAuth = 'qmsc0190';
	let currentHref = 'qmsc0190';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "출하검사현황");
	
	let serverDateFrom 	= "${serverDateFrom}";
	let chooseDate1 	= "${serverDateFrom}";
	let chooseDate2 	= "${serverDate}";
	let reInspStatusArr = ['001', '003'];
	let dateCheck = '001';
	let inspStatus = '';
	let equipCd = '';
	let tableIdx = 0;
	let lotNo = '';
	
	let factoryCode = "<%=factoryCode%>";
	
	//공통코드 처리 시작
    let equipCode = new Array(); // 설비코드
    <c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";	
		equipCode.push(json);
    </c:forEach>
    
    let inspStatusCode = new Array(); // 검사상태
    <c:forEach items="${inspStatus}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		inspStatusCode.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    var goodsFaultyBigNameCd=new Array();	//엣지검사 대분류
    <c:forEach items="${goodsFaultyBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyBigNameCd.push(json);
    </c:forEach>
    
	var systemCommonCode=new Array();	//외관검사 소분류
    <c:forEach items="${systemCommonCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";
		json.etc4="${info.etc4}";
		json.etc5="${info.etc5}";		
		systemCommonCode.push(json);
    </c:forEach>

	var departmentCode=new Array();	//부서
    <c:forEach items="${departmentCode}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";	
		departmentCode.push(json);
    </c:forEach>

	var abnormalPrcssCode=new Array();	//이상발생 공정
    <c:forEach items="${abnormalPrcssCode}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";		
		abnormalPrcssCode.push(json);
    </c:forEach>

	var isolationCode =new Array();	//OK / NG   
	var json=new Object();
	json.baseCd="001";
	json.baseCdNm="YES";		
	isolationCode.push(json);
	json=new Object();
	json.baseCd="002";
	json.baseCdNm="NO";		
	isolationCode.push(json);
    
   
    $('#metalHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmHd').text(goodsFaultyBigNameCd[1].baseCdNm);
	headerCreate();
	$('#my-spinner').show();

	selectBoxAppend(isolationCode, "isolationYn", "", "");
	selectBoxAppend(abnormalPrcssCode, "abnormalPrcss", "", "");

	
	let gubunFaultySum1 = 0;
	let gubunFaultySum2 = 0;
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let stateTable = $('#stateTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        language: lang_kor,
        paging: true,
        info: true,
        processing: true,
        autoWidth: false,       
        pageLength: 20,
        scrollX: true,
        scrollY: "54vh",
        fixedColumns: {
        	 leftColumns: 11
        },
        scrollCollapse: true,
        lengthChange : true,
        
        ajax: {
            url: '<c:url value="/qm/shipInspStatusTempListF3"/>',
            type: 'GET',
            data: {//            
            	//'reInspStatusArr'	:	function() { return reInspStatusArr; },
            	'matrlLotNo'		:	function() { return lotNo;},
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },
				'dateCheck'			:	function() { return dateCheck; },
				'equipCd'			:	function() { return equipCd; },
				'inspStatus'		:	function() { return inspStatus; },
            },
            beforeSend: function() {
				gubunFaultySum1 = 0;
				gubunFaultySum2 = 0;
			},
        },
        rowId: 'idx',
        columns: [
        	{
	    		render: function(data, type, row, meta) {
		    		if(row['disStatus'] != '002'){
		    			return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width: 20px; height: 20px;" disabled>';
			    	} else{
			    		return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width: 20px; height: 20px;">';
				    }
					
	    		}
			},
        	{
        		data: 'productDate',
        		render : function(data, type, row, meta){
        			if(data != null & data != ''){
        				return moment(data).format('YYYY-MM-DD');
        			} else {
        				return '';
        			}
        		},
				'className' : 'text-center'
        	},
        	
        	{
        		data: 'updDate',
        		render : function(data, type, row, meta){
        			if(data != null & data != ''){
        				return moment(data).format('YYYY-MM-DD HH:mm:ss');
        			} else {
        				return '';
        			}
        		},
				'className' : 'text-center'
        	},
        	
        	//{ data: 'updDate', 'className' : 'text-center' },
        	
        	{ data: 'productDateMm', 'className' : 'text-center' },
        	{ data: 'productDateWw', 'className' : 'text-center' },
        	
        	{
        		data: 'inspDate',
        		render : function(data, type, row, meta){
        			if(data != null & data != ''){			
        				return moment(data).format('YYYY-MM-DD');
        			} else {
        				return '';
        			}
        		},
				'className' : 'text-center'
        	},
        	{
        		data: 'trayWorkerIdNm',
				'className' : 'text-center'
        	},
        	{
        		data: 'inspChargrNm',
				'className' : 'text-center'
        	},
        	{
        		data: 'inspStatus',
				'className' : 'text-center',
				render: function(data, type, row) {
					if(data == '001'){
						return '합격';
					} else{
						return '불합격';
					}
					
				}
					
        	},
        	{
        		data: 'dayNightCd',
				'className' : 'text-center',
				render: function(data, type, row) {
					if(data == 'D'){
						return '주간';
					} else{
						return '야간';
					}
					
				}
			
        	},
        	{
        		data: 'equipNm',
				'className' : 'text-center'
        	},
         	{
        		data: 'labelLotNoSeq',
				'className' : 'text-center'
        	},
        	{
        		data: 'matrlLotNo',
				'className' : 'text-center'
        	},
           	{
        		data: 'goodsNm',
				'className' : 'text-center'
        	},
        	{
        		data: 'qutyNm',
				'className' : 'text-center'
        	},
        	{
        		data: 'inspProductQty',
				'className' : 'text-right'
        	},       
        	{
        		data: 'productQty',
				'className' : 'text-right'
        	},
        	{
        		data: 'faultyCnt',
				'className' : 'text-right'
        	},
        	{
        		data: 'faultyTrayNo',
				'className' : 'text-center'
        	},
        	{
        		data: 'sampleCnt',
				'className' : 'text-right'
        	},
        	
        	
        	{
        		data: 'threeTrayWeight',
				'className' : 'text-right'
        	},
        	{
        		data: 'threeTrayWeightCheck',
				'className' : 'text-center'
        	},
        	
        	/* {
        		data: 'threeTrayWeightCheck',
        			render: function(data, type, row) {
        				if( row['threeTrayWeight'] == "0.000" ) {
        					return "미 입력";
        				} else {
        					return data;
        				}
        			},
				'className' : 'text-center'
        	}, */
        	
        	
        	{
        		data: 'reInspSystem',
				'className' : 'text-center',
				render: function(data, type, row) {
					if(data == '001'){
						return '재검사';
					} else if(data == '002'){
						return '재작업';
					}  else{
						return '';
					}
					
				}
					
        	},
        	{
        		data: 'inspGubun',
				'className' : 'text-center',
				render: function(data, type, row) {
					if(data == '001'){
						return '출하재검';
					} else if(data == '002'){
						return '부분재검';
					} else if(data == '003'){
						return '전수재검';
					} else{
						return '';
					}
					
				}
					
        	},
        	
        	{
        		data: 'faultyGubun',
				'className' : 'text-center',
				render: function(data, type, row) {
					if(data == '001'){
						return 'major';
					} else if(data == '002'){
						return 'minor';
					} else{
						return '';
					}
					
				}
        	},
        	{ data: 'inspDesc',
				'className' : 'text-center',
				render: function(data, type, row) {
					if(data == ' MMS:0' || data == "" || data == null) {
						return '-';
					} else{
						return data;
					}
					
				}
        	},
        	
        	
        	//원자재성불량
        	{
        		render: function(data, type, row) {
					let rowDataSum = 0;
					
					let minColspan = parseInt($('#metalHd').attr('colspan'));
					
 	        		Object.keys(row).forEach(function(key) {
 	        			if ( key.startsWith("faulty") && typeof row[key] !== 'function' && row[key] != null && row[key] != 'null' ) {
 	        				if ( parseInt(key.replaceAll("faulty", "")) <= minColspan ) {
 	        					rowDataSum += parseInt(row[key]);
 	        					/* if( row[key] != 0) {
 	        						console.log(key, row[key]);         	        						
 	        					} */
 	        				}
 	        			}
 	        		});
 	        		gubunFaultySum1 += rowDataSum;
         	        return rowDataSum;
        		}
        	},
        	//공정성 불량
        	{
        		render: function(data, type, row) {
					let rowDataSum = 0;
					
					let minColspan = parseInt($('#metalHd').attr('colspan'));
					let maxColspan = parseInt($('#filmHd').attr('colspan')) + minColspan;
					
   	        		Object.keys(row).forEach(function(key) {
   	        			if ( key.startsWith("faulty") && typeof row[key] !== 'function' && row[key] != null && row[key] != 'null' ) {
   	        					if( parseInt(key.replaceAll("faulty", "")) > minColspan && parseInt(key.replaceAll("faulty", "")) <= maxColspan ) {
   	        					
   	        					rowDataSum += parseInt(row[key]);
   	        				}
   	        			}
   	        		});
   	        		gubunFaultySum2 += rowDataSum;
         	        return rowDataSum;
        		}
        	},
        	
        	
        	
        	/*
        	{ data: 'faulty1',
        		render: function(data, type, row) {
            		if(data == 'null'){
            			return 0;
                	} else{
                		return addCommas(data);
                    }                	
        		}
        	},
        	.
        	.
        	.
        	{ data: 'faulty140',
        		render: function(data, type, row) {
            		if(data == 'null'){
            			return 0;
                	} else{
                		return addCommas(data);
                    }                	
        		}
        	},
        	*/
        	
			<c:forEach var="i" begin="1" end="140">
				{ data: 'faulty${i}',
					render: function(data, type, row) {
	            		if(data == 'null') {
	            			return 0;
	                	} else{
	                		return addCommas( (data != "null" && data != null && data != "") ? parseInt(data) : 0);
	                    }                	
	        		}
				},
			</c:forEach>
        	
        ],
        //15 /16 17추가됨/ sudelSudel
        columnDefs: [
        	{ targets: [15,16,17,21,22,23,24,25,26,27,28,29
            	,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51
            	,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73
            	,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95
            	,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113
            	,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,
            	141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161], render: $.fn.dataTable.render.number( ',' ) },
            	
            	{ targets: [15,16,17, 20,21,22,23,24,25,26,27,28,29
                	,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51
                	,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73
                	,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95
                	,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113
                	,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,
                	141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161], className: 'text-right' }, 
                	{ "targets": [0], "orderable" : false },
        ],
        order: [
             [ 1, 'asc' ], [ 3, 'asc' ], [ 9, 'asc' ]
        ],
        
        buttons: ['copy', 'excel', 'print'],
        rowCallback: function (row, data) {
			if (data.disStatus=="004" || data.disStatus=="001") {
				$(row).addClass('whiteRed');
			}
			if (data.disStatus=="003") {
				$(row).addClass('skyYellow2');
			}
		},
      
        drawCallback: function () {
        	$('#stateTable tfoot').remove();			

        	let sumInsp				= $('#stateTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			let sumOutput			= $('#stateTable').DataTable().column(16,{ page: 'all'} ).data().sum();
			let sumFaulty			= $('#stateTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			let sumSample   		= $('#stateTable').DataTable().column(19,{ page: 'all'} ).data().sum();
			let sumThreeTrayWeight	= $('#stateTable').DataTable().column(20,{ page: 'all'} ).data().sum();
			
			$('#sumInsp').html(addCommas(sumInsp));
            $('#sumOutput').html(addCommas(sumOutput));
            $('#sumFaulty').html(addCommas(sumFaulty));
            $('#sumSample').html(addCommas(sumSample));
            $('#sumThreeTrayWeight').html(addCommas(sumThreeTrayWeight.toFixed(3)));
            
        	//let faulty1	 = $('#stateTable').DataTable().column(19,{ page: 'all'} ).data().sum();
			//let faulty1	 = $('#stateTable').DataTable().column(20,{ page: 'all'} ).data().sum();
			//let faulty2	 = $('#stateTable').DataTable().column(21,{ page: 'all'} ).data().sum();
			
			$('#gubunFaultySum1').html(addCommas(gubunFaultySum1/3));
			$('#gubunFaultySum2').html(addCommas(gubunFaultySum2/3));
			
			/*
			let faulty1	 = $('#stateTable').DataTable().column(26,{ page: 'all'} ).data().sum();
			.
			.
			.
			let faulty139 = $('#stateTable').DataTable().column(164,{ page: 'all'} ).data().sum();
			*/
			
			/*
			$('#sum1').html(addCommas(faulty1));
            .
            .
            .
            $('#sum139').html(addCommas(faulty139));
            */
			
			//컬럼 추가 시 for문 도 수정
			let stateFaultyArray = new Array();
			
            for(var i=0; i<140; i++){
            	stateFaultyArray[i] = $('#stateTable').DataTable().column( (28+i) ,{ page: 'all'} ).data().sum();	//컬럼 추가될떄 column값도 늘려주기
            } 

			for(var i=0; i<140; i++){
				$('#sum'+ (i+1) ).html(addCommas(stateFaultyArray[i]));
			}
			//컬럼 추가 시 for문 도 수정
		   	$('input[name=checkAll]').on('click', function(){
				if($('input[name=checkAll]').eq(length-1).prop("checked")) { 	
					$(".DTFC_LeftBodyWrapper input[type=checkbox]:checkbox:not(:disabled)").prop("checked", true); 
				} else { 
					$(".DTFC_LeftBodyWrapper input[type=checkbox]").prop("checked",false);
				}
		    });

		   	if(factoryCode != '003'){
				$('#btnWarning').addClass('d-none');
			}
        }
	});
	
	$('#infoDiv').insertAfter('.btn.btn-secondary.buttons-print');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[0]).attr('style', 'height: 25px;');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[1]).attr('style', 'height: 25px;');
	$($('.dt-buttons.btn-group.flex-wrap').find('button')[2]).attr('style', 'height: 25px;');

	stateTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		stateTable.columns.adjust();
	});
	
	if( factoryCode != "003" ){
		stateTable.column( 0 ).visible( false );
		stateTable.column( 3 ).visible( false );
		stateTable.column( 4 ).visible( false );
		
		stateTable.column( 20 ).visible( false );
		stateTable.column( 21 ).visible( false );
		
		stateTable.column( 26 ).visible( false );
		stateTable.column( 27 ).visible( false );
		
	}

	var html1 = '<div class="row">';
	html1 += '<select class="custom-select mr-2" id="dateCheck" style="width:80px;">';
	html1 += '<option value="001">생산일</option>';
	html1 += '<option value="002">검사일</option>';
	
	if(factoryCode == "003") {
		html1 += '<option value="003">생산월</option>';
		html1 += '<option value="004">생산주</option>';
	}
	
	html1 += '</select>';
	
	//기간
	html1 += '<div class="row" id="inputPeriod">';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input type="date" class="form-control" style="width:97px;" id="chooseDateFrom" name="chooseDateFrom" />';
	html1 += '</div>';
	
	html1 += '<label class="input-label-sm ml-2">~</label>';
	
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input type="date" class="form-control" style="width:97px;" id="chooseDateTo" name="chooseDateTo" />';
	html1 += '</div>&nbsp;&nbsp;';
	html1 += '</div>';
	
	//생산월
	html1 += '<div class="form-group input-sub m-0 row d-none" id="inputMonth">';
	html1 += '<input type="month" class="form-control" id="chooseMonth" name="chooseMonth" />';
	html1 += '</div>&nbsp;&nbsp;';
	
	//생산주
	html1 += '<div class="form-group input-sub m-0 row d-none" id="inputWeek">';
	html1 += '<input type="week" class="form-control" id="chooseWeek" name="chooseWeek" />';
	html1 += '</div>&nbsp;&nbsp;';
	
	html1 += '<div class="multipleSelection pos-real mr-2">';
	html1 += '<label class="input-label-sm ml-1">설비명</label>';
	html1 += '<select class="custom-select custom-select1 w-120" id="equipCd">';
	html1 += '</select>';
	html1 += '</div>';
	
	html1 += '<label class="input-label-sm ml-1">검사상태</label><select class="custom-select" id="inspStatusSelect" style="width:80px;"></select>';
	
	html1 += '&nbsp;&nbsp;<label class="input-label-sm ml-1">자재LOT</label>';
	html1 += '<div class="form-group-100 mr-4">';
	html1 += '<input type="text" class="form-control" id="matrlLotNo" style="min-width:130px;">';
	html1 += '</div>';

	html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
	html1 += '&nbsp;<button type="button"  class="btn btn-success ml-2" id="btnExcelDownload">excel</button>';
	html1 += '&nbsp;<button type="button" class="btn btn-warning ml-2" id="btnWarning">이상발생</button>';
	
	/* html1 += '<div class="d-none" style="position: fixed;top: 8.5%;left: 59%;background-color: lightpink;display: flex;flex-direction: column;color: black;font-size: 15px; padding: 0px 15px 0px 15px;" id="infoDiv" title="요약정보" >';
	html1 += '<label id="totalCount">전체 출하 검사 Lot : ...</label>';
	html1 += '<div> <label id="majorCount">major 부적합 건수 : ...</label> <label class="ml-3" id="totalFaultyCount">총 부적합 건수 : ...</label> </div>';
	html1 += '<div> <label id="minorCount">minor 부적합 건수 : ...</label> <label class="ml-3" id="faultyPercent">불량률 : ...</label> </div>';
	html1 += '</div>'; */
	
	html1 += '</div>';
	
	$('#stateTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	 selectBoxAppend(inspStatusCode, "inspStatusSelect", "" , "1");  
	 selectBoxAppend(equipCode, "equipCd", "" , "1");
	 
	//조회 버튼 클릭
	$('#btnRetv').on('click', function() {
		
		if( factoryCode != "003" ) {
	    	chooseDate1 = $('#chooseDateFrom').val();
	  		chooseDate2 = $('#chooseDateTo').val();
	  		dateCheck = $('#dateCheck').val();
		} else {
			
			dateCheck = $('#dateCheck').val();
			lotNo = $('#matrlLotNo').val();
			if( dateCheck == "003" ) {
				chooseDate1 = $('#chooseMonth').val().split('-')[0];
				chooseDate2	= $('#chooseMonth').val().split('-')[1];
			} else if( dateCheck == "004" ) {
				chooseDate1 = $('#chooseWeek').val().split('-')[0]
				chooseDate2	= $('#chooseWeek').val().split('-')[1].replace('W', '')
			} else {
				chooseDate1 = $('#chooseDateFrom').val();
		  		chooseDate2 = $('#chooseDateTo').val();	
		  		
			}
		}
  		
  		inspStatus	= $('#inspStatusSelect').val();
  		equipCd		= $('#equipCd').val();
  		
  		$('#stateTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});
	
	//생산일 날짜 변경 시
	$('#dateCheck').on('change', function(){
		
		let date	= new Date(serverDateFrom);
		let year	= date.getFullYear();
		let week	= moment(date).isoWeek();
		let isoWeek = year + '-W' + week;
		let isMonth	= moment(serverDateFrom).format('YYYY-MM');
		
		
		if( $(this).val() == "003" ) {
			//월별
			if( $('#chooseMonth').val() == '' ) {
				$('#chooseMonth').val(isMonth);
			}
			$('#inputPeriod').addClass('d-none');
			$('#inputMonth').removeClass('d-none');
			$('#inputWeek').addClass('d-none');
			
		} else if( $(this).val() == "004" ) {
			//주차별
			if( $('#chooseWeek').val() == '' ) {
				$('#chooseWeek').val(isoWeek);
			}
			$('#inputPeriod').addClass('d-none');
			$('#inputMonth').addClass('d-none');
			$('#inputWeek').removeClass('d-none');
			
		} else {
			//기간
			$('#inputPeriod').removeClass('d-none');
			$('#inputMonth').addClass('d-none');
			$('#inputWeek').addClass('d-none');
		}
	});

	
	//컬럼 감추기
	columnVisibleFun('stateTable', systemCommonCode.length, stateTable);
	//columnVisibleFun('stateTable', systemCodeLength, stateTable);
	
	/* stateTable.on('draw.dt', function(){
		if(factoryCode == "003") {
			summaryInformation();
		}
	});
	
	if(factoryCode == "003") {
		$('#infoDiv').removeClass('d-none');
	} */
	
	
	
	
	//엑셀 버튼 클릭 시
  	$('#btnExcelDownload').on('click',function(){
  		$('#my-spinner').show();

  		//헤더 정보
  		let fixedHeader = new Array();
  		for( var i=0; i<($($('#stateTable thead tr')[0]).find('th').length -2); i++) {
  		    fixedHeader.push( $($('#stateTable thead tr')[0]).find('th')[i].innerText.replaceAll('\n', '') );
  		}
  		//헤더 정보
  		
  		//컬럼 data 속성에 대한 정보
  		let columnData	= stateTable.columns().data();
  		let dataName	= "";
  		let fixedColumn = new Array();
  		
  		$(columnData).each(function(index) {
  			dataName = stateTable.settings().init().columns[index].data;
  		    if( dataName == "faulty1" ) {
  		        return false;
  		    } else {
  		    	fixedColumn.push( dataName );
  		    }
  		});
  	//컬럼 data 속성에 대한 정보
  	  	
  		$.ajax({
            url: '<c:url value="/qm/shipInspExcelDownload"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
				'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },
				'dateCheck'			:	function() { return dateCheck;		},
				'equipCd'			:	function() { return equipCd;		},
				'inspStatus'		:	function() { return inspStatus;		},
            	'fixedHeader'		:	function() { return fixedHeader;	},
            	'fixedColumn'		:	function() { return fixedColumn;	},
            },
            success: function (res) {
            	let data = res.data;
				if (res.result == 'ok') {
					var filename = "출하검사현황.xlsx";
	            	var blob = new Blob([base64ToArrayBuffer(res.blob)], {type : 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'});
	            	const path = window.URL.createObjectURL(blob)
	            	const link = document.createElement('a')
	            	link.href = path
	            	link.setAttribute('download',filename);
	            	link.click();
	            	$('#my-spinner').hide();
				} else {
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#my-spinner').hide();
				}
            	
            }
        });
 	});
	
  	function base64ToArrayBuffer(base64) {
        const binaryString = window.atob(base64); // Comment this if not using base64
        const bytes = new Uint8Array(binaryString.length);
        return bytes.map((byte, i) => binaryString.charCodeAt(i));
   	}
   	
	// 컴럼 숨김 처리 함수
  	function columnVisibleFun(tableNm, codeLength, domTableId) {
		let frontTdNum = 0;	//전체 테이블 개수
		
		for( var i=0; i<$('#'+tableNm+' thead tr').eq(0).find('th').length; i++) {
	   		if( $('#'+tableNm+' thead tr').eq(0).find('th').eq(i).attr('rowspan') == 2) {
	   			frontTdNum++;
	   		}
		}
		
		frontTdNum += $('#'+tableNm+' thead tr').eq(1).find('th').length;

		let codeNum = $('#'+tableNm+' thead tr').eq(1).find('th').length - codeLength;

		codeNum = frontTdNum - codeNum;
		
		//★제거
		for( var i=0; i<frontTdNum; i++) {
		    if( i >= codeNum ) {
		    	domTableId.column( i ).visible( false );
		    }
		};
	}
	
	

	//컴럼 숨김 처리 함수
  	function columnVisibleFun(tableNm, codeLength, domTableId) {
		let frontTdNum = 0;	//전체 테이블 개수
		let systemCodeLength = 0;
		for( var i=0; i<$('#'+tableNm+' thead tr').eq(0).find('th').length; i++) {
	   		if( $('#'+tableNm+' thead tr').eq(0).find('th').eq(i).attr('rowspan') == 2) {
	   			frontTdNum++;
	   		}
		}

		$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '001'){
    			systemCodeLength++;
    			
        	}
    		if(item.etc1 == '002'){
    			systemCodeLength++;
    			
        	}  
    
		});
		frontTdNum += $('#'+tableNm+' thead tr').eq(1).find('th').length;

	
		//let codeNum = $('#'+tableNm+' thead tr').eq(1).find('th').length - codeLength;
		let codeNum = $('#'+tableNm+' thead tr').eq(1).find('th').length;
		let countCol = 0; 
		codeNum =  codeNum + 24;
		//codeNum = frontTdNum - codeNum;
		countCol = 140 - systemCommonCode.length;
		//★제거
		for( var i=codeNum; i<=167; i++) {		   
		    domTableId.column( i ).visible( false );
		    
		};
		
		
		if(factoryCode != '003'){
			
			domTableId.column( 3 ).visible( false );
			domTableId.column( 4 ).visible( false );
			
			domTableId.column( 19 ).visible( false );
			domTableId.column( 22 ).visible( false );
			domTableId.column( 25 ).visible( false );
		}
	}

	//헤더 생성
	function headerCreate(){   			
		var metal = '';
    	var film = '';

		var metalIdx = 0;
		var filmIdx = 0;

		
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
    			
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
    			
        	}  
    
		});
    	metal = metal + film;
        $('#metalHd').attr('colspan', metalIdx);   
        $('#filmHd').attr('colspan', filmIdx);        
       

        $('#appearFaultyWeekHd').html(metal);        
	}
	
	
	//요약정보 표시
	function summaryInformation() {
		
// 		console.time("sudel");
		//필요한 값만 담아주기
		var sudelArray = new Array();
		$.each(stateTable.data(),function(idx, itm){
		    var obj = new Object();
		    obj.labelLotNo = itm.labelLotNoSeq;
		    obj.faultyGubun = itm.faultyGubun;
		    
		    sudelArray.push(obj);
		});
		//필요한 값만 담아주기

		//중복제거
		/* var result = sudelArray.filter(function(item1, idx1) {
		    return sudelArray.findIndex(function(item2, idx2) {
		        return item1.labelLotNo == item2.labelLotNo
		    }) == idx1;
		}); */
		//중복제거
		
		//개수 구하기
		let majorCount = 0;
		let minorCount = 0;
		let totalCount = sudelArray.length;
		let totalFaultyCount = 0;
		
		for(var i=0; i<totalCount; i++) {
		    if( sudelArray[i].faultyGubun == "001" ) {
		        majorCount++;
		    } else if( sudelArray[i].faultyGubun == "002" ) { 
		        minorCount++;
		    }
		}
		
		totalFaultyCount = majorCount + minorCount;
		
		//화면단 표시
		/* $('#totalCount').text('전체 출하 검사 Lot : ' + addCommas(totalCount) +'건');
		$('#majorCount').text('Major 부적합 건수 : ' + addCommas(majorCount) +'건');
		$('#minorCount').text('Minor 부적합 건수 : ' + addCommas(minorCount) +'건');
		$('#totalFaultyCount').text('총 부적합 건수 : ' + addCommas( totalFaultyCount ) +'건');
		
		$('#faultyPercent').text('불량률 : ' + ( ( totalFaultyCount / totalCount ) *100 ).toFixed(2) +'%'); */
		
		$('#totalCount').text(addCommas(totalCount) +'건');
		$('#majorCount').text(addCommas(majorCount) +'건');
		$('#minorCount').text(addCommas(minorCount) +'건');
		$('#totalFaultyCount').text(addCommas( totalFaultyCount ) +'건');
		
		$('#faultyPercent').text(( ( totalFaultyCount / totalCount ) *100 ).toFixed(2) +'%');
		//화면단 표시
	}

	//제 3공장 관련 테이블
	$.fn.dataTable.ext.errMode = 'none';
	let abnormalTable = $('#abnormalTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    language: lang_kor,
	    searching: false,
	    destroy: true,
	    paging: false,
	    info: true,		    
	    ordering: false,
	    processing: true,
	    autoWidth: false,
	    pageLength: false,		    		
	    'ajax' : {
	        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: menuAuth,
	        	
	        }		       
	    },
	    columns: [		 
	    	   	
	    	{ data: 'productDate',
	    		render: function(data, type, row, meta) {
	    			if(data != null && data != "") {
	    				return moment(data).format("YYYY-MM-DD");
	    			} else {
						return '<input type="text" id="productDate" class="form-control" name="productDate" value="" style="max-width:100%;">' ;
	    			}
	    		}
			},
	    	{ data: 'inspDate',
				render: function(data, type, row, meta) {
	    			if(data != null && data != "") {
	    				return moment(data).format("YYYY-MM-DD");
	    			} else {
						return '<input type="text" id="inspDate" class="form-control" name="inspDate" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'trayWorkerIdNm',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "") {
	    				return data;
	    			} else {
						return '<input type="text" id="trayWorkerIdNm" class="form-control" name="trayWorkerIdNm" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},	    	
	    	{ data: 'inspChargrNm',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "") {
	    				return data;
	    			} else {
						return '<input type="text" id="inspChargrNm" class="form-control" name="inspChargrNm" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'equipNm',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "") {
	    				return data;
	    			} else {
						return '<input type="text" id="equipNm" class="form-control" name="equipNm" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'labelLotNo',
	    		render: function(data, type, row, meta) {			    			
	    			if(data != null && data != "") {
	    				return data;
	    				//pad(data, 5);
	    			} else {
						return '<input type="text" id="labelLotNo" class="form-control" name="labelLotNo" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'faultyCnt',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "") {
	    				return data;
	    			} else {
						return '<input type="text" id="faultyCnt" class="form-control" name="faultyCnt" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'departmentCd',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "") {
	    				return selectBoxHtml2(departmentCode, 'departmentCd', data, row, meta);
	    			} else {
						return selectBoxHtml2(departmentCode, 'departmentCd', data, row, meta);
	    			}
	    		}
	    	},    	
	    
	    	{ data: 'abnormalCnt',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return data;
	    			} else {
						return '<input type="text" id="abnormalCnt" class="form-control" name="abnormalCnt" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	
	    ],
	    columnDefs: [
	    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }		    
	    	,{ targets: [6], render: $.fn.dataTable.render.number( ',' ) },
            	
            	{ targets: [6], className: 'text-right' }, 	
	    ],
	});

	$('#abnormalTable tbody').on('click', 'tr', function () {
		tableIdx = $('#abnormalTable').DataTable().row(this).index();    	
    });
	
	$('#btnWarning').on('click',function(){
		var dataArray = new Array();
		var checkbox = $(".DTFC_LeftBodyWrapper input[name=chk]:checked");
		var checkboxCnt = 0;
		var errorFlag = false;
		$('#abnormalTable').DataTable().clear().draw();
		$('#form').each(function(){
	            this.reset();
	    });
		$('#fileLabel').text('파일을 선택해주세요.');
	        
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			var tr 			= checkbox.parent().parent().eq(i);			
			var td 			= tr.children();
			var rowData 	= new Object();
			var data = $('#stateTable').DataTable().row(tr).data();
			
			if(data.nextGubun == '001'){
				$('#abnormalTable').DataTable().row.add({				
					 'abnormalPrcss'		: ''
					, 'abnormalDesc'		: ''
					, 'productDate'		: data.productDate
					, 'inspDate'		: data.inspDate
					, 'trayWorkerIdNm'	: data.trayWorkerIdNm
					, 'trayWorkerId'	: data.trayWorkerId
					, 'inspChargr'		: data.inspChargr
					, 'inspChargrNm'	: data.inspChargrNm
					, 'equipNm'			: data.equipNm
					, 'labelLotNo'		: data.labelLotNoSeq
					, 'faultyCnt'		: addCommas(data.inspProductQty)
					, 'departmentCd'	: data.departmentCd
					, 'manager'			: ''
					, 'isolationCd'		: ''
					, 'fileNm'			: ''
					, 'abnormalCnt'		: data.faultyCnt			
				}).draw(false);
				checkboxCnt++;
			}
		});
		let today = new Date();
		
		$('#abnormalDate').val(moment(today).format("YYYY-MM-DD"));
		if( checkboxCnt == 0){
			toastr.warning("트레이를 선택해주세요.");			
			return false;
		}
		$('#btnInAddSave').attr('disabled',false);
		$('#abnormalPopUpModal').modal('show');
		
	});


	$('#btnInAddSave').on('click',function(){
		//$('#my-spinner').show();

		var check = true;

		//if($('#abnormalNo').val() == null ||$('#abnormalNo').val() == ""){
		//	toastr.warning("이상발생번호를 입력해주세요.");		
		//	check = false;
		//	return false;
		//	
		//}	
		
		if($('#abnormalDate').val() == null ||$('#abnormalDate').val() == ""){
			toastr.warning("이상발생일자를 입력해주세요.");		
			check = false;
			return false;
			
		}		
		
		if($('#abnormalPrcss').val() == null ||$('#abnormalPrcss').val() == ""){
			toastr.warning("이상발생공정를 입력해주세요.");		
			check = false;
			return false;
			
		}	

		if($('#abnormalDesc').val() == null ||$('#abnormalDesc').val() == ""){
			toastr.warning("이상발생내용을 입력해주세요.");		
			check = false;
			return false;
			
		}	
		if($('#manager').val() == null ||$('#manager').val() == ""){
			toastr.warning("담당자를 입력해주세요.");		
			check = false;
			return false;
			
		}	
		if($('#isolationYn').val() == null ||$('#isolationYn').val() == ""){
			toastr.warning("격리여부를 입력해주세요.");		
			check = false;
			return false;
			
		}	
	


		if($('#file').val() == null || $('#file').val() == ""){
			toastr.warning("종결문서를 등록해주세요.");		
			check = false;
			return false;
		} else {						
			
			var formData = new FormData(document.getElementById("form")); 
	     	var str = $('#file').val();
	  		console.log(str.substring(str.lastIndexOf(".")+1));
	  	
	  		formData.set("abnormalNo", $("#abnormalNo").val());
	  		formData.set("abnormalDate", $("#abnormalDate").val().replace(/-/g,""));
	  		formData.set("abnormalPrcss", $("#abnormalPrcss").val());	  		
	  		formData.set("abnormalDesc", $("#abnormalDesc").val());
	  		formData.set("manager", $("#manager").val());
	  		formData.set("isolationYn", $("#isolationYn").val());
	  		
	  		if(str.substring(str.lastIndexOf(".")+1)=="pdf"){
		  		 $.ajax({
		  			url : '<c:url value="qm/goodsDisposeAdmCreate"/>',
					type : 'POST',
					data : formData,
					processData : false,
					contentType : false,
					async: false,
			    	success: function (result) {		    		
				    	if(result.result == 'ok'){
				    		var dataArray = new Array();
				    		var checkbox = $(".DTFC_LeftBodyWrapper input[name=chk]:checked");
				    		var checkboxCnt = 0;
				    		var errorFlag = false;
				    		
				    		// 체크된 체크박스 값을 가져온다
				    		checkbox.each(function(i) {
				    			var tr 			= checkbox.parent().parent().eq(i);			
				    			var td 			= tr.children();
				    			var rowData 	= new Object();					    			
				    			var data = $('#stateTable').DataTable().row(tr).data();
				    			if(data.nextGubun == '001'){
					    			rowData.abnormalDate = $("#abnormalDate").val().replace(/-/g,"");
					    			rowData.abnormalNo = result.data;
					    			rowData.labelLotNo 	= data.labelLotNoSeq;	
					    			rowData.equipCd 	= data.equipCd;
					    			rowData.workChargr = data.trayWorkerId;
					    			rowData.inspctChargr = data.inspChargr;
					    			rowData.goodsCd = data.goodsCd;
					    			rowData.matrlLotNo = data.matrlLotNo;
					    			rowData.filmLotNo = data.filmLotNo;
					    			rowData.inspctDate = data.inspDate;
					    			rowData.productDate = data.productDate;
					    			rowData.productQty = data.productQty;
					    			rowData.abnormalCnt = data.inspProductQty;
					    			rowData.departmentCd = $('select[name=departmentCd]').eq(checkboxCnt).val();
					    			rowData.faultyCnt = data.faultyCnt;			
	
					    			dataArray.push(rowData);
					    			checkboxCnt += 1;
				    			}
				    		});		
				    		
				    		if( checkboxCnt == 0){
				    			toastr.warning("선택된 트레이가 없습니다.");
				    			$('#my-spinner').hide();
				    			return false;
				    		}
				            $.ajax({
				                url: '<c:url value="/qm/goodsDisposeDtlCreate"/>',
				                type: 'POST',
				                dataType: 'json',
				                async: false,
				                data : JSON.stringify(dataArray),
				                contentType : "application/json; charset=UTF-8",          
				                success: function (res) {              
				                    if (res.result == 'ok') {
				                    	toastr.success("처리되었습니다.");
				                		$('#stateTable').DataTable().ajax.reload( function () {});
				                		$("input[name=checkAll]").prop("checked", false);
				                		$("#checkAll").prop("checked", false);
				                		$('#btnInAddSave').attr('disabled',true);
				                    } else {
				                    	toastr.error(res.message, '', {timeOut: 5000});
				                    }
				                },
				                complete:function(){
					                
				                	$('#my-spinner').hide();
				                	
				                }
				            });
					    } else{
					    	toastr.error(res.message, '', {timeOut: 5000});
						}
			    	}
		   		}); 
		   	
		   	} else{    		
			   	toastr.warning("올바른파일을 넣어주세요.");
		   		return false;
		   		check = false;
		   	}			   			   			
		   	
		}



		
	
	});
	
	function selectBoxHtml2(obj, id, sVal, row, meta)
	{
		//$('#'+ id).empty();
		//var shtml = '<select id="'+ id +'" class="mySelect" data-col="' + meta.col + '" onChange="locateChange()"><option value="">선택</option>';
		var shtml = '<select class="custom-select" name="'+ id +'" data-col="' + meta.col + '" disabled><option value="">선택</option>';
		//var shtml = '<select class="mySelect" data-col="' + meta.col + '" ><option value="">선택</option>';
		
		var option;
		for(key in obj) {
			var tmp; 
			if(obj[key].baseCd == sVal ) {
				tmp = "<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>";
			} else {
				tmp = "<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>";
			}	
			option += tmp;
		}
		var ehtml = '</select>';
		return shtml + option + ehtml;
	}	

  	//담당 조회
   	var userPopUpTable;
   	function selectChargr()
   	{
		if(userPopUpTable == null || userPopUpTable == undefined)	{
			userPopUpTable = $('#userPopUpTable').DataTable({		        
				language: lang_kor,
		        lengthChange : false,
		        destroy:true,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
				//ordering: false,
				ajax : {
					url : '<c:url value="/sm/matrlUserDataList"/>',
					type : 'GET',
					data : { 
							'menuAuth' : menuAuth,
						}
				},
				rowId : 'userNm',
				columns : 
					
					[ 
						{data : 'userNm'}, 
						{data : 'departmentNm'},
						{data : 'postNm'},
						{data : 'chargrDuty'},
						{data : 'teamNm'},				
						{data : 'workplaceNm'}					
					
				],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		       
			});
			$('#userPopUpTable tbody').on('click', 'tr', function () {

		    	var data = userPopUpTable.row( this ).data();
		    	$('#manager').val(data.userNumber);
		    	$('#managerNm').val(data.userNm);									
				$('#userPopUpModal').modal('hide');			
		    });
			
			
		}
		$('#userPopUpModal').modal('show');
			
   	}

	//checkBox디테일 설정
    $(document).on('click','.DTFC_LeftBodyWrapper input[name=chk]',function(e){
    	if($('.DTFC_LeftBodyWrapper input:checkbox[name=chk]:checked').length == ($('.DTFC_LeftBodyWrapper input:checkbox[name=chk]').length - $('.DTFC_LeftBodyWrapper input:checkbox[name=chk]:disabled').length)){
    		$("input[name=checkAll]").prop("checked", true);
        }else{
        	$("input[name=checkAll]").prop("checked", false);
		}
	});

	
</script>

</body>
</html>