<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
        <!--header ============================================================== -->
             <header class="page-title-bar">
              <nav aria-label="breadcrumb">
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
                  <!--======================== .left-list ========================-->
                  <div class="col-md-12 matrl-top-list">
                    <div class="card card-fluid">
                      <!-- .card-header -->
                      <div class="card-header card-tab">
                        <!-- .nav-tabs -->
                             <button type="button" class="btn btn-warning float-right mr-1" id="">수정</button>
                             <button class="btn btn-warning d-none" id="" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
                             <button type="button" class="btn btn-primary float-right mr-1" id="" data-toggle="modal" data-target="#mod-add">작지입력</button>
                             <button class="btn btn-primary d-none" id="" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>

                        <h6 class="mb-3 ml-0">설비명</h6>
                        <ul class="nav nav-tabs card-header-tabs">
                          <li class="nav-item">
                            <a class="nav-link active show" data-toggle="tab" href="#LD1A">LD1A</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#LD1B">LD1B</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#LD2A">LD2A</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#LD2B">LD2B</a>
                          </li>
                        </ul><!-- /.nav-tabs -->
                      </div><!-- /.card-header -->
                      <!-- .card-body
                      <div class="card-body">
                        <div id="myTabContent" class="tab-content">
                          <div class="tab-pane fade active show" id="">
                            <p> Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui. </p>
                          </div>
                          <div class="tab-pane fade" id="L1B">
                            <p> Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. </p>
                          </div>
                          <div class="tab-pane fade" id="">
                            <p> Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. </p>
                          </div>
                          <div class="tab-pane fade" id="">
                            <p> Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. </p>
                          </div>
                        </div>
                      </div>
                      .card-body -->
                    </div><!-- /.card -->
                    <!------------작지입력모달------------>
                            <div class="modal fade" id="mod-add" tabindex="-1" role="dialog">
                              <div class="modal-dialog">
                                <div class="modal-content">
                                  <div class="modal-header modal-header-colored">
                                    <h3 class="modal-title">작지발행</h3>
                                    <button class="close md-close" type="button" data-dismiss="modal" aria-hidden="true"><span class="mdi mdi-close">       </span></button>
                                  </div>
                                  <div class="modal-body">
                                    <!-- .table-responsive -->
                                      <div class="table-responsive">
                                          <table id="" class="table table-bordered table-td-center">
                                             <thead class="thead-light">
                                              <tr>
                                               <th style="min-width:60px;">설비명</th>
                                               <th style="min-width:160px;">제품(기종)</th>
                                               <th style="min-width:80px;">재질</th>
                                               <th style="min-width:60px;">규격</th>
                                               <th style="min-width:80px;">표면처리</th>
                                               <th style="min-width:90px;">근무조</th>
                                              </tr>
                                             </thead>
                                             <tbody>
                                              <tr>
                                                  <td>LD1A</td>
                                                  <td>DE/SK</td>
                                                  <td>Nicu</td>
                                                  <td>0.3X45-PP9.5X55-47P</td>
                                                  <td>DC-1114</td>
                                                  <td>A</td>
                                              </tr>
                                              <tr>
                                                  <th colspan="3">LOT NO</th>
                                                  <th colspan="3">작지번호</th>
                                              </tr>
                                              <tr>
                                                <td colspan="3">LD1AAl-200420D1</td>
                                                <td colspan="3">LD1A200420-002</td>
                                              </tr>
                                            </tbody>
                                          </table>
                                      </div>
                                   <!-- /.table-responsive -->
                                   <div class="row">
                                     <div class="col-4">
                                     <label>Barcode</label>
                                     <div class="form-group input-sub">
                                      <input type="text" class="form-control" placeholder="scan">
                                     </div>
                                     </div>
                                     <div class="col-4">
                                      <label>거래처</label>
                                       <div class="form-group input-sub">
                                        <input type="text" class="form-control" placeholder="SK">
                                        <button class="btn btn-secondary input-sub-search" type="button">
                                         <span class="oi oi-magnifying-glass"></span>
                                        </button> 
                                       </div>
                                     </div>
                                     <div class="col-4">
                                      <label>담당</label>
                                       <div class="input-sub col-6">
                                        <input type="text" class="form-control" placeholder="홍길동">
                                        <button class="btn btn-secondary input-sub-search" type="button">
                                         <span class="oi oi-magnifying-glass"></span>
                                        </button> 
                                       </div>
                                     </div>
                                    </div><!--/.row-->
                                  <div class="modal-footer">
                                      <button class="btn btn-space btn-secondary" type="button" data-dismiss="modal">취소</button>
                                      <button class="btn btn-space btn-info" type="button" data-dismiss="modal">저장</button>
                                  </div>
                                    <!-- .table-responsive -->
                                    <h6 class="mb-3">자재투입내역</h6>
                                      <div class="table-responsive">
                                          <table id="" class="table table-bordered table-td-center">
                                             <thead class="thead-light">
                                              <tr>
                                               <th style="min-width:60px;">재질</th>
                                               <th style="min-width:160px;">자재명</th>
                                               <th style="min-width:80px;">표면처리</th>
                                               <th style="min-width:60px;">LOT</th>
                                               <th style="min-width:80px;">투입증량</th>
                                               <th style="min-width:80px;">삭제</th>
                                              </tr>
                                             </thead>
                                             <tbody>
                                              <tr>
                                                  <td>Nicu</td>
                                                  <td>NiCU1020 H0 0.3*45 압연</td>
                                                  <td>DC-1114</td>
                                                  <td>MCS0A20CF001 </td>
                                                  <td>25.3</td>
                                                  <td><button class="btn btn-secondary">삭제</button></td>
                                              </tr>
                                              <tr>
                                                  <td>DNP</td>
                                                  <td>0.1x11.5</td>
                                                  <td></td>
                                                  <td>FDD9J9L21S01 </td>
                                                  <td>4.26</td>
                                                  <td><button class="btn btn-secondary">삭제</button></td>
                                                </tr>
                                            </tbody>
                                          </table>
                                      </div>
                                   <!-- /.table-responsive -->
                                   </div>
                                 </div>  
                                  </div>
                                </div>
                      <!------------/작지입력모달------------>
                      <div class="card">
                            <div class="card-body col-sm-12">
                              <!--=====================-->
                              <div class="row">
                                <div class="form-group input-sub">
                                  <input type="text" class="form-control" placeholder="일자를 입력해주세요">
                                  <button class="btn btn-secondary input-sub-search" type="button">
                                   <span class="oi oi-calendar"></span>
                                  </button> 
                                </div>
                                <div class="form-group input-sub">
                                 <input type="text" class="form-control" placeholder="기계그룹을 입력해주세요">
                                 <button class="btn btn-secondary input-sub-search" type="button">
                                  <span class="oi oi-magnifying-glass"></span>
                                 </button> 
                                </div>
                                <label class="input-label">주야</label>
                                <div class="form-group input-sub">
                                 <select id="inlineFormCustomSelect" class="custom-select">
                                  <option selected>전체</option>
                                  <option value="1">주간</option>
                                  <option value="1">야간</option>
                                 </select>
                                </div>
                                <div class="form-group input-sub">
                                  <button type="button" class="btn btn-primary float-right mr-1" id="">조회</button>
                                  <button class="btn btn-primary d-none" id="" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
                                </div>
                             </div>
                            <!--=====================-->
                           </div>
                            <!--=====================-->
                        <!-- .table-responsive -->
                          <div class="table-responsive">
                              <table id="matrlCdTable" class="table table-bordered table-td-center">
                                 <thead class="thead-light">
                                  <tr>
                                   <th style="min-width:40px;">체크</th>
                                   <th style="min-width:120px;">제품(기종)</th>
                                   <th style="min-width:45px;">재질</th>
                                   <th style="min-width:150px;">규격</th>
                                   <th style="min-width:70px;">표면처리</th>
                                   <th style="min-width:50px;">거래처</th>
                                   <th style="min-width:150px;">LOT NO</th>
                                   <th style="min-width:120px;">작지번호</th>
                                   <th style="min-width:45px;">상태</th>
                                   <th style="min-width:45px;">근무조</th>
                                   <th style="min-width:100px;">담당</th>
                                  </tr>
                                 </thead>
                                 <tbody>
                                     <tr>
                                         <td>
                                             <label class="d-block"></label>
                                             <div class="m-0 custom-control custom-control-inline custom-checkbox">
                                               <input type="checkbox" class="custom-control-input" id="ckb1">
                                               <label class="custom-control-label" for="ckb1"></label>
                                             </div>
                                         </td>
                                         <td>
                                          <div class="input-sub">
                                           <input type="text" class="form-control" placeholder="">
                                           <button class="btn btn-secondary input-sub-search" type="button">
                                            <span class="oi oi-magnifying-glass"></span>
                                           </button> 
                                          </div>
                                        </td>
                                         <td>AL</td>
                                         <td>0.3X45-PP9.5X55-47P</td>
                                         <td>DC-1114</td>
                                         <td>SK</td>
                                         <td>LD1AAl-200420D0</td>
                                         <td>LD1A200420-001</td>
                                         <td>완결</td>
                                         <td>A</td>
                                         <td>홍길동,홍길동</td>
                                     </tr>
                                     <tr>
                                         <td>
                                             <label class="d-block"></label>
                                             <div class="m-0 custom-control custom-control-inline custom-checkbox">
                                               <input type="checkbox" class="custom-control-input" id="ckb1">
                                               <label class="custom-control-label" for="ckb1"></label>
                                             </div>
                                         </td>
                                         <td>
                                          <div class="input-sub">
                                           <input type="text" class="form-control" placeholder="">
                                           <button class="btn btn-secondary input-sub-search" type="button">
                                            <span class="oi oi-magnifying-glass"></span>
                                           </button> 
                                          </div>
                                        </td>
                                         <td>Nicu</td>
                                         <td>0.3X45-PP9.5X55-47P</td>
                                         <td>DC-1114</td>
                                         <td>SK</td>
                                         <td>LD1AAl-200420D1</td>
                                         <td>LD1A200420-002</td>
                                         <td>발행</td>
                                         <td>A</td>
                                         <td>홍길동</td>
                                     </tr>
                                     <tr>
                                         <td>
                                             <label class="d-block"></label>
                                             <div class="m-0 custom-control custom-control-inline custom-checkbox">
                                               <input type="checkbox" class="custom-control-input" id="ckb1">
                                               <label class="custom-control-label" for="ckb1"></label>
                                             </div>
                                         </td>
                                         <td>
                                          <div class="input-sub">
                                           <input type="text" class="form-control" placeholder="">
                                           <button class="btn btn-secondary input-sub-search" type="button">
                                            <span class="oi oi-magnifying-glass"></span>
                                           </button> 
                                          </div>
                                        </td>
                                         <td>Nicu</td>
                                         <td>0.3X45-PP9.5X55-47P</td>
                                         <td>DC-1114</td>
                                         <td></td>
                                         <td></td>
                                         <td></td>
                                         <td></td>
                                         <td>B</td>
                                         <td></td>
                                     </tr>
                                     <tr>
                                         <td>
                                             <label class="d-block"></label>
                                             <div class="m-0 custom-control custom-control-inline custom-checkbox">
                                               <input type="checkbox" class="custom-control-input" id="ckb1">
                                               <label class="custom-control-label" for="ckb1"></label>
                                             </div>
                                         </td>
                                         <td>
                                          <div class="input-sub">
                                           <input type="text" class="form-control" placeholder="">
                                           <button class="btn btn-secondary input-sub-search" type="button">
                                            <span class="oi oi-magnifying-glass"></span>
                                           </button> 
                                          </div>
                                        </td>
                                         <td>Nicu</td>
                                         <td>0.3X45-PP9.5X55-47P</td>
                                         <td>DC-1114</td>
                                         <td></td>
                                         <td></td>
                                         <td></td>
                                         <td></td>
                                         <td>B</td>
                                         <td></td>
                                     </tr>
                                </tbody>
                              </table>
                          </div>
                       <!-- /.table-responsive -->
                      </div>
                  </div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
                  <div class="col-md-12 matrl-bottom-list" id="">
                      <!-- <h6> 자재 정보 <span id="formText"></span></h6> -->
                      <!-- 등록, 수정 -->
                      <div class="card" id="formBox">
                              <div class="card-body col-sm-12">
                                <h6>자재투입내역</h6>
                               </div>	
                                          
                          <form id="form">
                            <!-- .table-responsive -->
                              <div class="table-responsive">
                                  <table id="" class="table table-bordered table-td-center">
                                     <thead class="thead-light">
                                      <tr>
                                       <th style="min-width:60px;">재질</th>
                                       <th style="min-width:160px;">자재명</th>
                                       <th style="min-width:80px;">표면처리</th>
                                       <th style="min-width:60px;">LOT</th>
                                       <th style="min-width:80px;">투입중량</th>
                                       <th style="min-width:90px;">Barcode NO</th>
                                      </tr>
                                     </thead>
                                     <tbody>
                                         <tr>
                                             <td>Nicu</td>
                                             <td>NiCU1020 H0 0.3*45 압연</td>
                                             <td>DC-1114</td>
                                             <td>MCS0A20CF001 </td>
                                             <td>25.3</td>
                                             <td>MCS0A20CF001</td>
                                         </tr>
                                    </tbody>
                                  </table>
                              </div>
                           <!-- /.table-responsive -->               	                    
                          </form>
                      </div>
                              <div class="mt-2">
                                  <button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
                                  <button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
                              </div>	
                      <!--// 등록, 수정 -->
                  </div><!-- .right-sidebar -->
            </div><!-- / #main  -->
        </div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>


</script>

</body>
</html>
