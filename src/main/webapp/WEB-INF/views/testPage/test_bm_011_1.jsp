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
                <li class="breadcrumb-item">
                  <a href="#">기준정보관리</a>
                </li>
                <li class="breadcrumb-item active">자재코드관리 </li>
               </ol>
              </nav>
             </header>      
          <!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="card top_sortbox p-3">
               <div class="row">
                 <div class="m-1">
                    <label class="input-label-sm">일자</label>
                    <div class="input-sub-md">
                      <input class="form-control" type="text" id="startDate" name="startDate" value=""/>
                      <button onclick="fnPopUpCalendar(startDate,startDate,'yyyy-mm-dd');"  class="btn btn-primary input-sub-search" type="button">
                       <span class="oi oi-calendar"></span>
                      </button> 
                    </div>
                 </div>
                 <div class=" m-1">
                    <label class="input-label-sm">거래처</label>
                 <div class="input-sub-md">
                  <input type="text" class="form-control" id=""  name="">
                  <button class="btn btn-primary input-sub-search" type="button">
                   <span class="oi oi-magnifying-glass"></span>
                  </button>
                 </div>
                 </div>
                 <div class=" m-1">
                    <label class="input-label-sm">제품</label>
                 <div class="input-sub-md">
                  <input type="text" class="form-control" id=""  name="">
                  <button class="btn btn-primary input-sub-search" type="button">
                   <span class="oi oi-magnifying-glass"></span>
                  </button>
                 </div>
                 </div>
                 <div class=" m-1">
                 <label class="input-label-sm">검사담당</label>
                 <div class="input-sub-md">
                  <input type="text" class="form-control" id=""  name="">
                  <button class="btn btn-primary input-sub-search" type="button">
                   <span class="oi oi-magnifying-glass"></span>
                  </button>
                 </div>
                 </div>
                 <div class=" m-1">
                    <label class="input-label-sm">재질</label>
                 <div class="input-sub-md">
                    <select id="" class="custom-select custom-select-sm">
                        <option>1</option>
                        <option>3</option>
                        <option>4</option>
                    </select>
                 </div>
                 </div>
                 <div class=" m-1">
                    <label class="input-label-sm">작지번호</label>
                 <div class="input-sub-md">
                  <input type="text" class="form-control" id=""  name="">
                 </div>
               </div>
               <button class="btn btn-primary btn-lg pl-4 pr-4">조회</button>
            </div>
              </div>
              <div class="row">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list" style="width:40%;">
                      <div class="card">
                          <!--
                        <div class="row mb-3 float-right">
                           <button type="button" class="btn btn-outline-primary mr-2" id="">입력</button>
                           <button type="button" class="btn btn-outline-primary mr-2" id="">수정</button>
                           <button type="button" class="btn btn-primary" id="">저장</button>
                        </div>-->
                        <!-- .table-responsive -->
                          <div class="table-responsive">
                              <table id="" class="table table-bordered">
                                 <thead class="thead-light">
                                  <tr>
                                   <th style="min-width:60px;">일자</th>
                                   <th style="min-width:110px;">규격</th>
                                   <th style="min-width:110px;">Lot NO</th>
                                   <th style="min-width:60px;">투입량</th>
                                   <th style="min-width:60px;">생산량</th>
                                   <th style="min-width:60px;">불량</th>
                                   <th style="min-width:60px;">검사자</th>
                                  </tr>
                                 </thead>
                                 <tbody>
                                     <tr>
                                         <td>04-20</td>
                                         <td>AL H0 0.2*45압연</td>
                                         <td>LS23AL-200419D0</td>
                                         <td>2,350</td>
                                         <td>2,300</td>
                                         <td>50</td>
                                         <td>홍길동</td>
                                     </tr>
                                </tbody>
                              </table>
                          </div>
                       <!-- /.table-responsive -->
                      </div>
                           <button type="button" class="btn btn-success float-right" id="">Excel</button>
                  </div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->

                    <div class="right-list" id="" style="width:59%;">
                      <!-- <h6> 자재 정보 <span id="formText"></span></h6> -->
          
                      <!-- 등록, 수정 -->
                      <div class="card" id="formBox">
                        <div class="row mb-3 float-right">
                           <button type="button" class="btn btn-primary mr-2" id="">등록</button>
                           <button type="button" class="btn btn-warning" id="">수정</button>
                        </div>    
                    <form id="form">
                     <div class="table-responsive p-0">
                         <div class="row">
                        <table class="table table-bordered col-7 mr-3">
                            <colgroup>
                                <col width="30%">
                                <col width="20%">
                                <col width="20%">
                                <col width="30%">	                            
                            </colgroup>
                            <tr>
                                <th>검사일</th>
                                <td colspan="3"><input type="text" class="form-control" id="" name=""></td>
                            </tr>
                            <tr>
                                <th>Barcode NO</th>
                                <td><input type="text" class="form-control" id=""  name=""></td>
                                <th>검사담당</th>
                                <td><input type="text" class="form-control" id=""  name=""></td>
                            </tr>
                            <tr>
                                <th>제품(기종)</th>
                                <td><input type="text" class="form-control" id=""  name=""></td>
                                <th>재질</th>
                                <td><input type="text" class="form-control" id=""  name=""></td>
                            </tr>
                        </table>
                        <table class="table table-bordered col-4">
                            <colgroup>
                                <col width="30%">
                                <col width="60%">
                            </colgroup>
                            <tr>
                                <th>투입량</th>
                                <td><input type="text" class="form-control" id="" name=""></td>
                            </tr>
                            <tr>
                                <th>생산량</th>
                                <td><input type="text" class="form-control" id="" name=""></td>
                            </tr>
                            <tr class="font-red">
                                <th>불량</th>
                                <td><input type="text" class="form-control font-red" id="" name=""></td>
                            </tr>
                        </table>
                         </div>
                     </div>
                     <div class="row col-12 p-0">
                            <table class="table table-bordered">
                            <tr>
                                <th colspan="2">메탈부</th>
                                <th colspan="2">필름부</th>
                                <th colspan="2">기타</th>
                            </tr>
                            <tr>
                                <th>MMB</th>
                                <th>MMS</th> 
                                <th>PFS</th>
                                <th>F꺾임</th>
                                <th>치수</th>
                                <th>컷팅</th>
                            </tr>
                            <tr>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                            </tr>	
                            <tr>
                                <th>PMS</th>
                                <th>M찍힘</th>
                                <th>뜯김</th>
                                <th>표면기포</th>
                                <th>필름눌림</th>
                                <th>필름폭</th>
                            </tr>
                            <tr>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                            </tr>
                            <tr>
                                <th>P찍힘</th>
                                <th>M찍힘</th>
                                <th>엣지기포</th>
                                <th>테프론</th>
                                <th>레이어</th>
                                <th>기타</th>
                            </tr>
                            <tr>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                            </tr>
                            <tr>
                                <th>M오염</th>
                                <th>도금박리</th>
                                <th>P오염</th>
                                <th>F뭉침</th>
                                <th></th>
                                <th></th>
                            </tr>
                            <tr>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                            </tr>
                            <tr>
                                <th>총두께</th>
                                <th>M꺾임</th>
                                <th>필름겹침</th>
                                <th>미진접</th>
                                <th></th>
                                <th></th>
                            </tr>
                            <tr>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                                <td><input type="button" data-toggle="modal" data-target="#mod-num" class="form-control" id=""  name=""></td>
                            </tr>
                        </table>
                     </div>                	                    
                    </form>
                </div>
                              <div class="mt-2">
                                  <button type="button" class="btn btn-primary float-right" id="btnSave">저장</button>
                                  <button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
                              </div>	
                      <!--// 등록, 수정 -->
                  </div><!-- .right-sidebar -->
              </div><!-- /.row -->
            </div><!-- / #main  -->
        </div><!-- /.page-wrapper -->
<!------------기초추가모달------------>
<div class="modal fade" id="mod-num" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header modal-header-colored">
          <h3 class="modal-title">메탈부 - MMB</h3>
          <button class="close md-close" type="button" data-dismiss="modal" aria-hidden="true"><span class="mdi mdi-close">       </span></button>
        </div>
        <div class="modal-body text-center">
            <div class="col-8 num_keypad">
            <div>
                <input type="number" class="form-control-md mb-3">
            </div>
                <table class="table table-bordered">
                <tr>
                    <td>7</td>
                    <td>8</td>
                    <td>9</td>
                    <td style="width: 50px;">BS</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>5</td>
                    <td>6</td>
                    <td rowspan="3">ENT</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                </tr>
                <tr>
                    <td colspan="2">0</td>
                    <td>.</td>
                </tr>
                </table>
        </div>
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
