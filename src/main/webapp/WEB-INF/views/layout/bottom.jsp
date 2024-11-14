<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<!-- 삭제 모달 -->
<div class="modal modal-alert fade" id="deleteModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="deleteModal" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="exampleModalAlertWarningLabel" class="modal-title">
					<i class="fa fa-bullhorn text-warning mr-1"></i> 데이터 삭제
				</h5>
			</div>
			<div class="modal-body">
				<p>
					삭제된 데이터는 복구가 불가능합니다.<br>정말 삭제하시겠습니까?
				</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnDeleteConfirm">삭제</button>
				<button class="btn btn-danger d-none" id="btnDeleteConfirmLoading" type="button" disabled="">
					<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...
				</button>
				&nbsp;
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 삭제 모달 -->
<!-- 자재 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="matrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="matrlPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="matrlPopUpLabel">자재코드조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="matrlCdPopUpTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th>자재코드</th>
							<th>자재명</th>
							<th>이니셜</th>
							<th>재질</th>
							<th>구분(연질/경질)</th>
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
<!-- 자재 모달 종료-->

<!-- 거래처 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="dealCorpPopUpModal" tabindex="-1" role="dialog" aria-labelledby="dealCorpPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="dealCorpPopUpLabel">거래처정보조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="dealCorpPopUpTable" class="table table-bordered">
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

<!-- 제품 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="goodsPopUpModal" tabindex="-1" role="dialog" aria-labelledby="goodsPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="goodsPopUpLabel">제품코드조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="goodsCdPopUpTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th>제품코드</th>
							<th>제품명</th>
							<th>규격</th>
							<th>모델NO</th>
							<th>AL/Nicu</th>
							<th>AL/Nicu코드</th>
							<th>Film코드</th>
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
<!-- 제품 모달 종료-->

<!-- 설비 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="equipPopUpModal" tabindex="-1" role="dialog" aria-labelledby="equipPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="equipPopUpLabel">설비코드조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="equipCdPopUpTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th>설비코드</th>
							<th>설비명</th>
							<th>설비그룹</th>
							<th>설비분류</th>
							<th>모델명</th>
							<th>제조업체</th>
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
<!-- 설비 모달 종료-->

<!-- 담당자 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="userPopUpModal" tabindex="-1" role="dialog" aria-labelledby="userPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
				<h5 class="modal-title" id="userPopUpLabel">담당자조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="userPopUpTable" class="table table-bordered" style="padding-bottom: 0px;">
					<thead class="thead-light">
						<tr>
							<th>성명</th>
							<th>부서</th>
							<th>직위</th>
							<th>담당</th>
							<th>조편성</th>
							<th>사업장</th>
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
<!-- 담당자 모달 종료-->

<!-- 담당자 모달(권한있는 관리자&조장) 시작-->
<div class="modal fade bd-example-modal-lg" id="userAuthPopUpModal" tabindex="-1" role="dialog" aria-labelledby="userAuthPopUpModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg">
      <div class="modal-content">
         <div class="modal-header" style="padding-bottom:0px;">
            <h5 class="modal-title" id="userAuthPopUpLabel">담당자조회</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <hr class="text-secondary">
            <table id="userAuthPopUpTable" class="table table-bordered" style="padding-bottom: 0px;">
               <thead class="thead-light">
                  <tr>
                     <th>성명</th>
                     <th>부서</th>
                     <th>직위</th>
                     <th>담당</th>
                     <th>조편성</th>
                     <th>사업장</th>
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
<!-- 담당자 모달 종료-->

<!-- 자재입고(바코드)관련 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="barcodePopUpModal" tabindex="-1" role="dialog" aria-labelledby="barcodePopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
				<h5 class="modal-title" id="userPopUpLabel">자재입고 조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="barcodePopUpTable" class="table table-bordered" style="padding-bottom: 0px;">
					<thead class="thead-light">
						<tr>
							<th>가입고일</th>
							<th>자재상태</th>
							<th>자재코드</th>
							<th>자재명</th>
							<th>바코드</th>
							<th>공급업체</th>
							<th>입고일</th>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnBarcodeAdd">출하</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 자재입고(바코드)관련 모달 종료-->

<!-- 접수자 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="custPopUpModal" tabindex="-1" role="dialog" aria-labelledby="userPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="custPopUpLabel">접수자</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			<hr class="text-secondary">
				<table id="custPopUpTable" class="table table-bordered">
					<colgroup>
						<col width="15%">
						<col width="20%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="20%">
					</colgroup>
					<thead class="thead-light">
	                    <tr>
							<th style="min-width: 50px">성명</th>
							<th style="min-width: 60px">부서</th>
							<th style="min-width: 40px">직위</th>
							<th style="min-width: 60px">담당</th>
							<th style="min-width: 60px">사업장</th>
							<th style="min-width: 40px">비고</th>
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
<!-- 접수자 모달 종료-->

<!-- 제품명/모델명 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="productPopUpModal" tabindex="-1" role="dialog" aria-labelledby="itemPartPopUpLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="productPopUpLabel">제품명/모델명</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="productPopUpTable" class="table table-bordered">
					<colgroup>
							<col width="5%">
							<col width="15%">
							<col width="23%">
							<col width="7%">
							<col width="50%">
					</colgroup>
					<thead class="thead-light">
	                    <tr>
                            <th>No.</th>
                            <th>CODE</th>
                            <th>ITEM</th>
                            <th>구분</th>
                            <th>SERIES</th>
                        </tr>
                    </thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
			
				<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>		
<!-- 제품명/모델명 모달 종료-->

<!-- 개인정보 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="infoPopUpModal" tabindex="-1" role="dialog" aria-labelledby="infoPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="infoPopUpLabel">사용자 정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<hr class="text-secondary">
				<table class="table table-bordered" id="infoTable">
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="30%">
					</colgroup>
					<tr>
						<th>성명</th>
						<td>
							<input type="text" class="form-control" id="userNmModal" name="userNm" maxlength="10" disabled>
						</td>
						<th>메뉴팝업여부</th>
						<td>
							<select class="custom-select" id="menuPopUpYnModal" name="menuPopUpYn"></select>
						</td>

					</tr>
					<tr>
						<th>ID</th>
						<td>
							<input type="text" class="form-control" id="userIdModal" name="userId" maxlength="20" onpaste="return false;" oncopy="return false;" disabled>
						</td>
						<th>직위</th>
						<td>
							<input type="text" class="form-control" id="postCdModal" name="postCdModal" disabled>
						</td>
					</tr>
					<tr>
						<th>사업장</th>
						<td>
							<input type="text" class="form-control" id="workplaceCdModal" name="workplaceCdModal" disabled>
						</td>
						<th>담당</th>
						<td>
							<input type="text" class="form-control" id="chargrDutyModal" name="chargrDutyModal" disabled>
						</td>
					</tr>
					<tr>
						<th>부서</th>
						<td>
							<input type="text" class="form-control" id="departmentCdModal" name="departmentCdModal" disabled>
						</td>
						<th>조편성</th>
						<td>
							<input type="text" class="form-control" id="teamCdModal" name="teamCdModal" disabled>
						</td>
					</tr>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="menuPopupYnPopUpSave">저장</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 개인정보 모달 종료-->

<!-- 개인정보 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="passChangePopUpModal" tabindex="-1" role="dialog" aria-labelledby="passChangePopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="passChangePopUpLabel">사용자정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table class="table table-bordered" id="passChangeTable">
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="30%">
					</colgroup>
					<tr>
						<th>현재 비밀번호</th>
						<td>
							<input type="password" style="max-width: 100%;" class="form-control" id="nowPassword" name="nowPassword" disabled>
						</td>
					</tr>
					<tr>
						<th>비밀번호 변경</th>
						<td>
							<input type="password" style="max-width: 100%;" class="form-control" id="changePassword" name="changePassword" disabled>
						</td>
					</tr>
					<tr>
						<th>비밀번호 변경 확인</th>
						<td>
							<input type="password" style="max-width: 100%;" class="form-control" id="changePassword2" name="changePassword2" disabled>
						</td>
					</tr>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="passChangePopUpSave">저장</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 개인정보 모달 종료-->
<!-- 제품조회 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="itemPartPopUpModal" tabindex="-1" role="dialog" aria-labelledby="itemPartPopUpLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="itemPartPopUpLabel">품명조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="itemPartPopUpTable" class="table table-bordered">
					<colgroup>
							<col width="5%">
							<col width="14%">
							<col width="20%">
							<col width="7%">
							<col width="7%">
							<col width="7%">
							<col width="40%">
					</colgroup>
					<thead class="thead-light">
	                    <tr>
                            <th>No.</th>
                            <th>CODE</th>
                            <th>ITEM</th>
                            <th>구분</th>
                            <th>Type</th>
                            <th>Revision</th>
                            <th>SERIES</th>
                        </tr>
                    </thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer" id="itemPartModalFooterDiv">
			
<!-- 				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> -->
			</div>
		</div>
	</div>
</div>		
<!-- 제품조회 모달 종료-->

<!-- 날짜 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="dateSelectModal" tabindex="-1" role="dialog" aria-labelledby="dateSelectPopUpLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="dateSelectPopUpLabel">기간 조회</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div> 
            <label style="margin-left: 20px;" id="inWhsDateLabel"></label>
            <div class="modal-body">
                <hr class="text-secondary">            
              	<div class="calender">
			        <ul class="top">
			            <li class="year" id="selectDiv">
			                <select name="year" id="select-year">
			                    <option value="">년도선택</option>
			                </select>
			            </li>
			            <li class="day" id ="today" >오늘</li>
			            <li class="day" id ="yesterday" >전일</li>
			            <li class="day" id ="thisWeek" >주간</li>
			            <li class="day" id ="lastWeek" >전주</li>
			            <li class="day" id ="thisMonth" >당월</li>
			            <li class="day" id ="lastMonth" >전월</li>
			            <li class="day" id ="thisYear" >올해</li>
			        </ul>
			
			        <ul class="middle">
			            <li class="quarter" id = "quarter1" >1/4분기</li>
			            <li class="quarter" id = "quarter2" >2/4분기</li>
			            <li class="quarter" id = "quarter3" >3/4분기</li>
			            <li class="quarter" id = "quarter4" >4/4분기</li>
			            <li class="quarter" id = "firstHalf" >상반기</li>
			            <li class="quarter" id = "secondHalf" >하반기</li>
			            <li class="quarter" id = "lastYear" >전년도</li>
			            <li class="quarter" id = "lastYear2" >전전년도</li>
			        </ul>
			
			        <ul class="bottom">
			            <li class="month" id ="jan">1월</li>
			            <li class="month" id ="feb">2월</li>
			            <li class="month" id ="mar">3월</li>
			            <li class="month" id ="apr">4월</li>
			            <li class="month" id ="may">5월</li>
			            <li class="month" id ="jun">6월</li>
			            <li class="month" id ="jul">7월</li>
			            <li class="month" id ="aug">8월</li>
			            <li class="month" id ="sep">9월</li>
			            <li class="month" id ="oct">10월</li>
			            <li class="month" id ="nov">11월</li>
			            <li class="month" id ="dec">12월</li>
			        </ul>
			    </div>
	
	    <div class="btn-wrap">
	       <button id="datePick" data-dismiss="modal">확인</button>
	        <button data-dismiss="modal">취소</button>
	    </div>
                <hr class="text-secondary"> 
            </div>
        </div>
    </div>
</div>
<!-- 날짜 모달 종료-->
</div>

<!--
<footer class="app-footer">
<ul class="list-inline">
<li class="list-inline-item"><a class="text-muted" href="#">Support</a></li>
<li class="list-inline-item"><a class="text-muted" href="#">Help Center</a></li>
<li class="list-inline-item"><a class="text-muted" href="#">Privacy</a></li>
<li class="list-inline-item"><a class="text-muted" href="#">Terms of Service</a></li>
</ul>
<div class="copyright">Copyright &copy; 2018. All right reserved.</div>
</footer>
-->
<!-- /.wrapper -->
<div id="my-spinner">
	<div>
		<span> <img src="<c:url value='/resources/assets/images/loader.gif'/>">
		</span>
	</div>
</div>
</main>
<!-- /.app-main -->
</div>
<!-- /.app -->

<%@include file="../layout/script.jsp"%>

