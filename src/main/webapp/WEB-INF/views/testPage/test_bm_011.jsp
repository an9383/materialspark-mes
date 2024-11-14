<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

    <!-- ============================================================== -->
      <div class="page-wrapper" id="page-wrapper">
        <!--header ============================================================== -->
             <header class="page-title-bar row">
              <nav aria-label="breadcrumb" class="breadcrumb-padding">
               <ol class="breadcrumb">
                <li class="breadcrumb-item">
                  <a href="#">공정실적관리</a>
                </li>
                <li class="breadcrumb-item active">생산실적라벨발행 </li>
               </ol>
              </nav>
             </header>      
          <!-- #main============================================================== -->
          <div class="container-fluid" id="main">
            <div class="card top_sortbox p-3">
                <h6>기종</h6>
             <div class="row">
             <button class="btn btn-outline-primary btn-lg mr-2">PSEV</button>
             <button class="btn btn-outline-primary btn-lg mr-2 active">LIFT</button>
             <button class="btn btn-outline-primary btn-lg mr-2">P260</button>
             <button class="btn btn-outline-primary btn-lg mr-2">H200</button>
             <button class="btn btn-outline-primary btn-lg mr-2">E370</button>
          </div>
            </div>
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list" id="" style="width:50%;">
                      <div class="card">
                        <div class="row col-sm-12 mb-3 p-0">
                              <div class="form-group input-sub col-md-3 m-0 p-0 mr-2">
                                <input class="form-control" type="text" id="startDate" name="startDate" value=""/>
                                <button onclick="fnPopUpCalendar(startDate,startDate,'yyyy-mm-dd');"  class="btn btn-secondary input-sub-search" type="button">
                                 <span class="oi oi-calendar"></span>
                                </button> 
                              </div>
                              <div class="form-group input-sub col-md-3 m-0 p-0">
                                <input class="form-control" type="text" placeholder="작지번호 SCAN">
                              </div>
                            <div class="ml-5 row float-right alert-primary">
                              <h6 class="p-1 mr-3 mb-0">포장수량</h6>
                              <h5 class="mb-0">1,000</h5>
                            </div>
                            <button type="button" class="btn btn-primary float-right ml-5" id="">포장 <span class="oi oi-arrow-right"></span></button>
                    </div>
                        <!-- .table-responsive -->
                          <div class="table-responsive">
                              <table id="matrlCdTable" class="table table-bordered">
                                 <thead class="thead-light">
                                  <tr>
                                   <th style="min-width:10px;">순번</th>
                                   <th style="min-width:90px;">작지번호</th>
                                   <th style="min-width:50px;">제품명</th>
                                   <th style="min-width:120px;">Lot NO</th>
                                   <th style="min-width:50px;">양품</th>
                                   <th style="min-width:50px;">해외1</th>
                                   <th style="min-width:50px;">해외2</th>
                                   <th style="min-width:50px;">국내</th>
                                  </tr>
                                 </thead>
                                 <tbody>
                                     <tr>
                                         <td>1</td>
                                         <td>20200410-001</td>
                                         <td>AL H0 0.2*45압연</td>
                                         <td>LS23AL-200419O0</td>
                                         <td>2,800</td>
                                         <td>1,000</td>
                                         <td>1,000</td>
                                         <td>800</td>
                                     </tr>
                                     <tr>
                                         <td>1</td>
                                         <td>20200410-001</td>
                                         <td>AL H0 0.2*45압연</td>
                                         <td>LS23AL-200419O0</td>
                                         <td>2,800</td>
                                         <td><input type="text" class="form-control-xs"></td>
                                         <td><input type="text" class="form-control-xs"></td>
                                         <td><input type="text" class="form-control-xs"></td>
                                     </tr>
                                </tbody>
                              </table>
                          </div>
                       <!-- /.table-responsive -->
                      </div>
                      <button type="button" class="btn btn-primary float-right" id="">저장</button>
                      <button type="button" class="btn btn-primary float-right mr-2" id="">스티커인쇄</button>
                  </div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
                    <div class="right-list right-70" id="myrSidenav" style="width:49%;">
                      <div class="card" id="formBox">
                        <div class="card-body col-sm-12 pt-0">
                        	<button type="button" class="btn btn-danger float-left" id=""><span class="oi oi-arrow-left"></span> 복원</button>
                            <button type="button" class="btn btn-primary float-right" id="">저장</button>
                            <button class="btn btn-primary d-none" id="" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
                            <button type="button" class="btn btn-warning float-right mr-1" id="">스티커인쇄</button>
                            <button class="btn btn-warning d-none" id="" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
                        </div>	
                    <div class="col-12 row p-0 table-td-center">       
                      <div class="table-responsive col-4">
                        <table class="table table-bordered">
                            <colgroup>
                                <col width="60%">
                                <col width="40%">
                            </colgroup>
                            <tr>
                                <th>BOX NO</th>
                                <th>해외1</th> 
                            </tr>
                            <tr>
                                <td>A20200709-001</td>
                                <td>1000</td>
                            </tr>                   	                        		                        	                        		                        	                        	                        
                        </table>
                      </div>                	                    
                      <div class="table-responsive col-4">
                        <table class="table table-bordered">
                            <colgroup>
                                <col width="60%">
                                <col width="40%">
                            </colgroup>
                            <tr>
                                <th>BOX NO</th>
                                <th>해외2</th> 
                            </tr>
                            <tr>
                                <td>A20200709-001</td>
                                <td>1000</td>
                            </tr>                  	                        		                        	                        		                        	                        	                        
                        </table>
                      </div> 
                      <div class="table-responsive col-4">
                        <table class="table table-bordered">
                            <colgroup>
                                <col width="60%">
                                <col width="40%">
                            </colgroup>
                            <tr>
                                <th>BOX NO</th>
                                <th>국내</th> 
                            </tr>
                            <tr>
                                <td>A20200709-001</td>
                                <td>1000</td>
                            </tr>                 	                        		                        	                        		                        	                        	                        
                        </table>
                      </div> 
                </div>
                </div>
                    <div class="mt-2 content-footer-auto"> 
                        <div class="row col-12 p-0">
                        <div class="table-responsive col-4">
                          <table class="table table-bordered">
                              <colgroup>
                                  <col width="60%">
                                  <col width="40%">
                              </colgroup>
                              <tr>
                                  <th>합계</th>
                                  <th class="alert-red">2,500</th> 
                              </tr>              	                        		                        	                        		                        	                        	                        
                          </table>
                        </div> 
                        <div class="table-responsive col-4">
                          <table class="table table-bordered">
                              <colgroup>
                                  <col width="60%">
                                  <col width="40%">
                              </colgroup>
                              <tr>
                                  <th>합계</th>
                                  <th class="alert-red">2,500</th> 
                              </tr>              	                        		                        	                        		                        	                        	                        
                          </table>
                        </div> 
                        <div class="table-responsive col-4">
                          <table class="table table-bordered">
                              <colgroup>
                                  <col width="60%">
                                  <col width="40%">
                              </colgroup>
                              <tr>
                                  <th>합계</th>
                                  <th class="alert-red">3,600</th> 
                              </tr>              	                        		                        	                        		                        	                        	                        
                          </table>
                        </div> 
                        </div>
                    </div>	
                      <!--// 등록, 수정 -->
                  </div><!-- .right-sidebar -->
              </div><!-- /.row -->
            </div><!-- / #main  -->
        </div><!-- /.page-wrapper -->
    </div><!-- /.app -->
<!------------기초추가모달------------>
<div class="modal fade" id="mod-basicadd" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header modal-header-colored">
          <h3 class="modal-title">기초코드추가</h3>
          <button class="close md-close" type="button" data-dismiss="modal" aria-hidden="true"><span class="mdi mdi-close">       </span></button>
        </div>
        <div class="modal-body">
          <!-- .table-responsive -->
         <h6 class="modal-subtitle">구분 타이틀1</h6>
         <div class="">
           <table id="matrlCdTable" class="table table-bordered">
              <thead class="thead-light">

              </thead>
              <tbody>
                <tr>
                    <th>표면처리</th>
                    <td><select id="surfaceTrtmtCd" class="custom-select custom-select-lg" ></select></td>
                    <th>적정재고</th>
                    <td><input type="text" class="form-control-lg" placeholder="숫자만 입력"></td>
                </tr>
                <tr>
                    <th>생산단위</th>
                    <td><select id="productUnitCd" class="custom-select custom-select-lg"></select></td>
                    <th>재고단위</th>
                    <td><select id="tmUnitCd" class="custom-select custom-select-lg"></select></td>
                </tr>
                <tr>
                    <th>입고처</th>
                    <input type="hidden" class="form-control-lg" id="dealCorpCd" name="dealCorpCd">
                    <td>
                      <div class="input-sub m-0">
                       <input type="text" class="form-control-lg" id="dealCorpNm"  name="dealCorpNm">
                         <button class="btn btn-primary input-sub-search-lg" type="button">
                          <span class="oi oi-magnifying-glass"></span>
                         </button>
                      </div>
                      </td>
                    <th>유수명주기</th>
                    <td><input type="text" class="form-control-lg" id="lifeCycle"  name="lifeCycle"></td>
                </tr>	
                <tr>
                    <th>체크1</th>
                    <td><input type="text" class="form-control-lg" id="etc1"  name="etc1"></td>
                    <th>체크2</th>
                    <td><input type="text" class="form-control-lg" id="etc2"  name="etc2"></td>
                </tr>		                                                
                <tr>
                    <th>사용여부</th>
                    <td><select id="useYnCd" class="custom-select custom-select-lg"></select></td>
                    <th>비고</th>
                    <td><input type="text" class="form-control-lg" id="matrlDesc"  name="matrlDesc"></td>
                </tr>	

             </tbody>
           </table>
         </div>
         <!-- /.table-responsive -->
         <h6 class="modal-subtitle">구분 타이틀2</h6>
          <!-- .table-responsive -->
          <div class="">
            <table id="" class="table table-bordered table-td-center">
              <thead class="thead-light">
               <table id="matrlCdTable" class="table table-bordered">
                  <thead class="thead-light">
                    
                  </thead>
                  <tbody>
                    <tr>
                        <th>표면처리</th>
                        <td><select id="surfaceTrtmtCd" class="custom-select custom-select-lg"></select></td>
                        <th>적정재고</th>
                          <td class="input-sub"><input type="text" class="form-control-lg" placeholder="숫자만 입력"></td>
                    </tr>
                    <tr>
                        <th>생산단위</th>
                        <td><select id="productUnitCd" class="custom-select custom-select-lg"></select></td>
                        <th>재고단위</th>
                        <td><select id="tmUnitCd" class="custom-select custom-select-lg"></select></td>
                    </tr>
                    <tr>
                        <th>입고처</th>
                        <input type="hidden" class="form-control-lg" id="dealCorpCd" name="dealCorpCd">
                        <td>
                          <div class="input-sub m-0">
                           <input type="text" class="form-control-lg" id="dealCorpNm"  name="dealCorpNm">
                             <button class="btn btn-primary input-sub-search-lg" type="button">
                              <span class="oi oi-magnifying-glass"></span>
                             </button>
                          </div>
                          </td>
                        <th>유수명주기</th>
                        <td><input type="text" class="form-control-lg" id="lifeCycle"  name="lifeCycle"></td>
                    </tr>	
                    <tr>
                        <th>체크1</th>
                        <td><input type="text" class="form-control-lg" id="etc1"  name="etc1"></td>
                        <th>체크2</th>
                        <td><input type="text" class="form-control-lg" id="etc2"  name="etc2"></td>
                    </tr>		                                                
                    <tr>
                        <th>사용여부</th>
                        <td><select id="useYnCd" class="custom-select custom-select-lg"></select></td>
                        <th>비고</th>
                        <td><input type="text" class="form-control-lg" id="matrlDesc"  name="matrlDesc"></td>
                    </tr>	
                    
                  </tbody>
            </table>
          </div>
       <!-- /.table-responsive -->
         <div class="modal-footer">
            <button class="btn btn-space btn-secondary" type="button" data-dismiss="modal">취소</button>
            <button class="btn btn-space btn-primary" type="button" data-dismiss="modal">저장</button>
         </div>
        </div>
      </div>  
    </div>
  </div>
<!------------/기초추가모달------------>

<%@include file="../layout/bottom.jsp" %>

<script>


</script>

</body>
</html>
