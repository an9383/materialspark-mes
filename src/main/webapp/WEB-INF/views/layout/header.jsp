<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>


<header class="app-header app-header-dark">
    <!-- .top-bar -->
    <div class="top-bar">
          <!-- .top-bar-brand -->
          <div class="top-bar-brand">
            <!-- toggle aside menu -->
            <button class="hamburger hamburger-squeeze mr-2" id="aside-menu" type="button" style="background:#30318b!important;" data-toggle="aside-menu" aria-label="toggle aside menu"><span class="hamburger-box"><span class="hamburger-inner"></span></span></button> <!-- /toggle aside menu -->
            <a href="/main"><img src="/resources/assets/images/logo/daerim_logo.jpg" alt="homepage" class="dark-logo" style="width: auto; height: 30px;"/>
             </a>
          </div><!-- /.top-bar-brand -->

        <!-- .top-bar-list -->
        <div class="top-bar-list">
            <!-- .top-bar-item -->
            <div class="top-bar-item px-2 d-md-none d-lg-none d-xl-none">
                <!-- toggle menu -->
                <button class="hamburger hamburger-squeeze" type="button" data-toggle="aside" aria-label="toggle menu">
                  <span class="hamburger-box">
                    <span class="hamburger-inner"></span>
                  </span>
                </button>
                <!-- /toggle menu -->
            </div>
            <!-- /.top-bar-item -->

            <!-- .top-bar-item -->
            <div class="top-bar-item top-bar-item-right px-0 d-none d-sm-flex">
                <!-- .nav -->
                <ul class="header-nav nav">
                    <!-- "../layout/header-notifications.jsp" -->
                    <!-- "../layout/header-messages.jsp" -->
                    <!-- "../layout/header-sheets.jsp" -->
                </ul>
                <!-- /.nav -->
                
				
                <!-- .btn-account -->
                <div class="dropdown d-flex">
                    <button class="btn-account d-none d-md-flex" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="user-avatar user-avatar-md">
                            <%-- <img src="<c:url value='/resources/assets/images/avatars/profile.jpg'/>" alt=""> --%>
                        </span>
                        <span class="account-summary pr-lg-4 d-none d-lg-block">
                            <span class="account-name" style="color:#000000;">${sessionScope.userNm}</span>
<%--                             <span class="account-description">${sessionScope.rank}</span> --%>
                        </span>
                    </button>
                    <!-- .dropdown-menu -->
                    <div class="dropdown-menu">
                        <div class="dropdown-arrow ml-3"></div>
                        <h6 class="dropdown-header d-none d-md-block d-lg-none">${sessionScope.name}</h6>
                        <!-- <a class="dropdown-item" href="#"><span class="dropdown-icon oi oi-envelope-closed"></span>쪽지</a> -->
                        <!-- <a class="dropdown-item" href="user-profile.html"><span class="dropdown-icon oi oi-person"></span> 사용자정보</a> -->
                        <a class="dropdown-item" href="#" id="info"><span class="dropdown-icon oi oi-person"></span> 사용자정보</a>
                        <a class="dropdown-item" href="#" id="passChange"><span class="dropdown-icon oi oi-person"></span> 비밀번호변경</a>
                        <a class="dropdown-item" href="<c:url value="/auth/logout"/>"><span class="dropdown-icon oi oi-account-logout"></span> 로그아웃</a>
                        <!--
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Help Center</a>
                        <a class="dropdown-item" href="#">Ask Forum</a>
                        <a class="dropdown-item" href="#">Keyboard Shortcuts</a>
                        -->
                    </div>
                    <!-- /.dropdown-menu -->
                </div>
                <!-- /.btn-account -->
            </div>
            <!-- /.top-bar-item -->
        </div>
        <!-- /.top-bar-list -->
    </div>
    <!-- /.top-bar -->
</header>
