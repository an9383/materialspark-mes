
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<aside class="app-aside app-aside-expand-md app-aside-light" id="mySidenav">
    <!-- .aside-content -->
    <div class="aside-content">
        <!-- .aside-header -->
        <header class="aside-header d-block d-md-none">
            <!-- .btn-account -->
            <button class="btn-account" type="button" data-toggle="collapse" data-target="#dropdown-aside">
                <span class="user-avatar user-avatar-lg">
                    <%-- <img src="<c:url value='/resources/assets/images/favicon.png'/>" alt=""> --%>
                </span>
                <span class="account-icon">
                    <span class="fa fa-caret-down fa-lg"></span>
                </span>
                <span class="account-summary">
                    <span class="account-name">${userNm}</span>
                <%-- <span class="account-description">${department}</span> 부서번호 --%>
                </span>
            </button>
            <!-- /.btn-account -->
            <!-- .dropdown-aside -->
            <div id="dropdown-aside" class="dropdown-aside collapse">
                <!-- dropdown-items -->
                <div class="pb-3">
					<!--
                    <a class="dropdown-item" href="/auth/profile">
                        <span class="dropdown-icon oi oi-person"></span> 사용자정보
                    </a>
                     -->
                    <a class="dropdown-item" href="<c:url value='/auth/logout'/>">
                        <span class="dropdown-icon oi oi-account-logout"></span> 로그아웃
                    </a>
                </div>
                <!-- /dropdown-items -->
            <!-- /.dropdown-aside -->
        </header>
        <!-- /.aside-header -->
        <!-- .aside-menu -->
        <div class="aside-menu overflow-hidden">
            <!-- .stacked-menu -->
            <nav id="stacked-menu" class="stacked-menu">
                <!-- .menu -->
                <ul class="menu">
					
					
					<c:forEach var="topMenuList" items="${userAuth}">
	                    <c:if test="${topMenuList.upperMenuId == null}">
							<li class="menu-item has-child"   id="${topMenuList.menuId}">
		                        <a href="#" class="menu-link">
		                            <span class="menu-icon far fa-file-alt"></span>
		                            <span class="menu-text">${topMenuList.menuNm}</span>
		                        </a>
		                        <ul class="menu">      
		                        	<c:forEach var="subMenuList" items="${userAuth}">                  	
										<c:if test="${subMenuList.upperMenuId ne null && subMenuList.upperMenuId eq topMenuList.menuId}">
											<c:if test="${menuPopupYn eq '001'}">
												<li class="menu-item">
					                                <a href="<c:url value="${subMenuList.menuPath}"/>" target="_blank" id="${subMenuList.menuId}" class="menu-link <c:url value="${subMenuList.menuPath}"/>" tabindex="-1">${subMenuList.menuNm}</a>
					                            </li>
				                            </c:if>
				                            <c:if test="${menuPopupYn eq '002'}">
												<li class="menu-item">
					                                <a href="<c:url value="${subMenuList.menuPath}"/>"id="${subMenuList.menuId}" class="menu-link <c:url value="${subMenuList.menuPath}"/>" tabindex="-1">${subMenuList.menuNm}</a>
					                            </li>
				                            </c:if>
										</c:if>	
									</c:forEach>				
		                        </ul>
		                    </li>
	                    </c:if>
					</c:forEach>
					
					<%-- 
					<!-- 기준정보관리 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">기준정보관리</span>
                        </a>
                        <ul class="menu"><!-- <li class="menu-subhead">기준정보관리</li> -->
                            <li class="menu-item">
                                <a href="<c:url value="bmsc0060"/>" id="bmsc0060" class="menu-link" tabindex="-1">자재코드관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="bmsc0010"/>" id="bmsc0010" class="menu-link" tabindex="-1">제품코드관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="bmsc0020"/>" id="bmsc0020" class="menu-link" tabindex="-1">거래처정보관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="bmsc0030"/>" id="bmsc0030" class="menu-link" tabindex="-1">설비정보관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="bmsc0040"/>" id="bmsc0040" class="menu-link" tabindex="-1">BOM정보관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="bmsc0050"/>" id="bmsc0050" class="menu-link" tabindex="-1">시스템공통코드관리</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 기준정보관리 -->
					
                    <!-- 시스템관리 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">시스템관리</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="smsc0010"/>" id="smsc0010" class="menu-link" tabindex="-1">사용자관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="smsc0020"/>" id="smsc0020" class="menu-link" tabindex="-1">사용자그룹관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="smsc0030"/>" id="smsc0030" class="menu-link" tabindex="-1">사용자권한관리</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 시스템관리 -->

                    <!-- 입출고관리 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">입출고관리</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="iosc0010"/>" id="iosc0010" class="menu-link" tabindex="-1">입고요청(가입고)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="iosc0020"/>" id="iosc0020" class="menu-link" tabindex="-1">자재입고(바코드)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="iosc0030"/>" id="iosc0030" class="menu-link" tabindex="-1">입고현황관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="iosc0040"/>" id="iosc0040" class="menu-link" tabindex="-1">자재투입(재고_출고량)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="iosc0050"/>" id="iosc0050" class="menu-link" tabindex="-1">제품출고요청(PO기준 미출고현황)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="iosc0060"/>" id="iosc0060" class="menu-link" tabindex="-1">제품출하(일보)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="iosc0070"/>" id="iosc0070" class="menu-link" tabindex="-1">출고현황관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="iosc0080"/>" id="iosc0080" class="menu-link" tabindex="-1">반품등록현황</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="iosc0090"/>" id="iosc0090" class="menu-link" tabindex="-1">선입선출관리</a>
                            </li> 
                            <li class="menu-item">
                                <a href="<c:url value="iosc0100"/>" id="iosc0100" class="menu-link" tabindex="-1">바코드출고관리</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 입출고관리 -->
                    
                     <!-- 생산관리 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">생산관리</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="wmsc0010"/>" id="wmsc0010" class="menu-link" tabindex="-1">작업지시</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="wmsc0020"/>" id="wmsc0020" class="menu-link" tabindex="-1">생산실적관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="wmsc0030"/>" id="wmsc0030" class="menu-link" tabindex="-1">작업일보관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="wmsc0040"/>" id="wmsc0040" class="menu-link" tabindex="-1">생산현황조회</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="wmsc0050"/>" id="wmsc0050" class="menu-link" tabindex="-1">설비가동/비가동 관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="wmsc0060"/>" id="wmsc0060" class="menu-link" tabindex="-1">LOT추적</a>
                            </li> 
                            <li class="menu-item">
                                <a href="<c:url value="wmsc0070"/>" id="wmsc0070" class="menu-link" tabindex="-1">불량내역조회(전체)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="wmsc0080"/>" id="wmsc0080" class="menu-link" tabindex="-1">불량내역조회(상세)</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 생산관리 -->   

                     <!-- 공정실적관리(POP) -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">공정실적관리(POP)</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="posc0010"/>" id="posc0010" class="menu-link" tabindex="-1">작업지시선택</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="posc0020"/>" id="posc0020" class="menu-link" tabindex="-1">생산실적수집</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="posc0030"/>" id="posc0030" class="menu-link" tabindex="-1">생산실적라벨발행</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="posc0040"/>" id="posc0040" class="menu-link" tabindex="-1">공정이동관리(초중종물등록)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="posc0050"/>" id="posc0050" class="menu-link" tabindex="-1">불량등록</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="posc0060"/>" id="posc0060" class="menu-link" tabindex="-1">비가동사유등록</a>
                            </li>    
                        </ul>
                    </li>
                    <!--// 공정실적관리(POP) -->   
                    
                     <!-- 설비연동 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">설비연동</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="eisc0010"/>" id="eisc0010" class="menu-link" tabindex="-1">가동시간</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="eisc0020"/>" id="eisc0020" class="menu-link" tabindex="-1">생산실적</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="eisc0030"/>" id="eisc0030" class="menu-link" tabindex="-1">제조조건</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="eisc0040"/>" id="eisc0040" class="menu-link" tabindex="-1">Fool Proof</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 설비연동 -->  

                     <!-- 품질관리 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">품질관리</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="qmsc0010"/>" id="qmsc0010" class="menu-link" tabindex="-1">불량정보관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="qmsc0020"/>" id="qmsc0020" class="menu-link" tabindex="-1">수입검사관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="qmsc0030"/>" id="qmsc0030" class="menu-link" tabindex="-1">자주검사관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="qmsc0040"/>" id="qmsc0040" class="menu-link" tabindex="-1">초중종물관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="qmsc0050"/>" id="qmsc0050" class="menu-link" tabindex="-1">엣지검사</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="qmsc0060"/>" id="qmsc0060" class="menu-link" tabindex="-1">외관검사</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="qmsc0070"/>" id="qmsc0070" class="menu-link" tabindex="-1">성적서관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="qmsc0080"/>" id="qmsc0080" class="menu-link" tabindex="-1">불량집계현황(일자)</a>
                            </li>
							<li class="menu-item">
                                <a href="<c:url value="qmsc0090"/>" id="qmsc0090" class="menu-link" tabindex="-1">불량집계현황(기간)</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 품질관리 -->                    
 
                      <!-- 재고관리 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">재고관리</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="tmsc0010"/>" id="tmsc0010" class="menu-link" tabindex="-1">재고실사및조정</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="tmsc0020"/>" id="tmsc0020" class="menu-link" tabindex="-1">창고별재고관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="tmsc0030"/>" id="tmsc0030" class="menu-link" tabindex="-1">품목별재고관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="tmsc0040"/>" id="tmsc0040" class="menu-link" tabindex="-1">적정재고관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="tmsc0050"/>" id="tmsc0050" class="menu-link" tabindex="-1">재고현황관리(자재)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="tmsc0060"/>" id="tmsc0060" class="menu-link" tabindex="-1">초기재고관리-제품</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="tmsc0070"/>" id="tmsc0070" class="menu-link" tabindex="-1">제품재고관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="tmsc0080"/>" id="tmsc0080" class="menu-link" tabindex="-1">재고현황관리(제품)</a>
                            </li>                                                        
                        </ul>
                    </li>
                    <!--// 재고관리 -->
                    
                    <!-- 설비관리 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">설비관리</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="emsc0010"/>" id="emsc0010" class="menu-link" tabindex="-1">설비보전이력관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="emsc0020"/>" id="emsc0020" class="menu-link" tabindex="-1">제조조건관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="emsc0030"/>" id="emsc0030" class="menu-link" tabindex="-1">정기검사관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="emsc0040"/>" id="emsc0040" class="menu-link" tabindex="-1">설비고장/수리이력관리</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 설비관리 -->
                    
                     <!-- PDA -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">PDA</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="pdsc0010"/>" id="pdsc0010" class="menu-link" tabindex="-1">자재입고</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="pdsc0020"/>" id="pdsc0020" class="menu-link" tabindex="-1">자재투입</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="pdsc0030"/>" id="pdsc0030" class="menu-link" tabindex="-1">제품입고</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="pdsc0040"/>" id="pdsc0040" class="menu-link" tabindex="-1">제품출고</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="pdsc0050"/>" id="pdsc0050" class="menu-link" tabindex="-1">재고실사(자재)</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="pdsc0060"/>" id="pdsc0060" class="menu-link" tabindex="-1">재고실사(제품)</a>
                            </li>
                        </ul>
                    </li>
                    <!--// PDA -->                                                                              
 
                     <!-- 모니터링 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">모니터링</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="mmsc0010"/>" id="mmsc0010" class="menu-link" tabindex="-1">공정별진행현황</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="mmsc0020"/>" id="mmsc0020" class="menu-link" tabindex="-1">설비가동/비가동현황</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="mmsc0030"/>" id="mmsc0020" class="menu-link" tabindex="-1">설비제조조건현황</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 모니터링 --> 
                    
                     <!-- 영업관리 -->
                    <li class="menu-item has-child">
                        <a href="#" class="menu-link">
                            <span class="menu-icon far fa-file-alt"></span>
                            <span class="menu-text">영업관리</span>
                        </a>
                        <ul class="menu">
                            <li class="menu-item">
                                <a href="<c:url value="bssc0010"/>" id="bssc0010" class="menu-link" tabindex="-1">영업관리</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="bssc0020"/>" id="bssc0020" class="menu-link" tabindex="-1">영업일보</a>
                            </li>
                            <li class="menu-item">
                                <a href="<c:url value="bssc0030"/>" id="bssc0030" class="menu-link" tabindex="-1">영업현황</a>
                            </li>
                        </ul>
                    </li>
                    <!--// 모니터링 -->                     
                     --%>   
                     
                                                                       
                </ul><!-- /.menu -->
            </nav>
            <!-- /.stacked-menu -->
        </div>
        <!-- /.aside-menu -->
    </div>
    <!-- /.aside-content -->
</aside>