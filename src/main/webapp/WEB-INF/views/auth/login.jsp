<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>
<body>
<%-- 
    <!-- .auth -->
    <main class="auth">
        <header id="auth-header" class="auth-header" style="background-image: url(<c:url value='/resources/assets/images/illustration/img-1.png'/>);">
            <h1>MES</h1>
        </header>

        <form class="auth-form" id="loginForm">
            <div id="messageBox" class="alert alert-danger has-icon d-none" role="alert">
                <div class="alert-icon">
                    <span class="fa fa-info"></span>
                </div>
                <h5>오류</h5>
                <span id="message"></span>
            </div>
            <div class="form-group">
                <div class="form-label-group">
                    <input type="text" name="userId" id="userId" class="form-control" placeholder="아이디" autofocus required>
                    <label for="userId">아이디</label>
                </div>
            </div>
            <div class="form-group">
                <div class="form-label-group">
                    <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호" required>
                    <label for="password">비밀번호</label>
                </div>
            </div>
            <div class="form-group">
                <button class="btn btn-lg btn-primary btn-block btn-login" type="submit">로그인</button>
                <button class="btn btn-lg btn-primary btn-block d-none btn-loading" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...</button>
            </div>
        </form>
    </main> --%>
    
<!-- .app -->
<div class="app">
  <div id="messageBox" class="alert alert-danger has-icon d-none" role="alert">
      <div class="alert-icon">
          <span class="fa fa-info"></span>
      </div>
      <h5>오류</h5>
      <span id="message"></span>
  </div>   
    <div class="container-fluid" id="main">
     <div class="row login_card">
        <div class="col-md-6 login_left pl-0" style="background-image: url(../resources/assets/images/daerim_login.png);">
        </div>
          <div class="col-md-6">
            <h4 class="login-header">로그인</h4>
            <form class="login-form"  id="loginForm">
              <!-- .form-group -->
              <div class="form-mb">
                  <input style="max-width:100%" type="text" id="inputUser" class="form-control-lg" placeholder="아이디" autofocus=""> 
              </div><!-- /.form-group -->
              <!-- .form-group -->
               <div class="form-mb form-password">
                  <input style="max-width:100%" type="password" id="inputPassword" class="form-control-lg" placeholder="비밀번호">
                  <i class="fa fa-eye-slash fa-lg"></i>
              </div><!-- /.form-group -->
              <!-- .form-group -->
              <div class="form-mb">
                <button class="login_btn btn btn-lg btn-primary btn-block" type="submit">로그인</button>
              </div><!-- /.form-group -->
              <!-- .form-group -->
              <!-- <div class="form-mb text-center">
                <div class="custom-control custom-control-inline custom-checkbox">
                  <input type="checkbox" class="custom-control-input" id="remember-me"> <label class="custom-control-label" for="remember-me">자동 로그인</label>
                </div>
              </div> --><!-- /.form-group -->
              <!--recoverylinks-->
              <!--  <div class="text-center pt-3">
                <a href="#" class="link">아이디 찾기</a> <span class="mx-2">·</span> <a href="#" class="link">비밀번호 찾기</a>
               </div> --><!-- /recovery links -->
            </form><!-- /.auth-form -->
          </div>
    </div>
  </div>
</div><!-- /.app -->
    <%@include file="../layout/script.jsp" %>
    <script>
        currentPage = "login";

        $('#loginForm').parsley();

        $("#loginForm").submit(function(e){
            e.preventDefault(e);
			//alert("login_ajax")
            $.ajax({
                type: 'POST',
                url: '<c:url value="/auth/login_ajax"/>',
                dataType: 'json',
                data: {
                    userId: $('#inputUser').val(),
                    userPw: $('#inputPassword').val(),
                },
                beforeSend: function() {
                    $('.btn-login').addClass('d-none');
                    $('.btn-loading').removeClass('d-none');
                },
                success: function (res) {
                    if (res.result === 'ok') {
                        $(location).attr('href', '<c:url value="/main"/>');
                    } else {
                        $('#password').val('');
                        $('#message').text(res.message);
                        $('#messageBox').removeClass('d-none');
                    }
                },
                complete:function(){
                    $('.btn-login').removeClass('d-none');
                    $('.btn-loading').addClass('d-none');
                }
            });
        });
    </script>
</body>
</html>
