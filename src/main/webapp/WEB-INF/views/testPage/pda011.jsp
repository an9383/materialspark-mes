<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>
<%@include file="../layout/script.jsp" %>

<!-- /.app -->
<div class="app pda_mo_wrap">
	<main>
		<div id="messageBox" class="alert alert-danger has-icon d-none"	role="alert">
			<div class="alert-icon">
				<span class="fa fa-info"></span>
			</div>
			<h5>오류</h5>
			<span id="message"></span>
		</div>
		<div class="container-fluid" id="main">
			<div class="text-center p-5 mt-5">
				<img src="<c:url value='/resources/assets/images/mo_main_logo.png'/>">
			</div>
			<div class="p-4">
				<form class="login-form" id="loginForm">
					<!-- .form-group -->
					<div class="form-group">
						<input style="max-width: 100%" type="text" id="inputUser" class="form-control-lg" placeholder="아이디" autofocus="">
					</div>
					<!-- /.form-group -->
					<!-- .form-group -->
					<div class="form-group">
						<input style="max-width: 100%" type="password" id="inputPassword" class="form-control-lg" placeholder="비밀번호">
					</div>
					<!-- /.form-group -->
					<!-- .form-group -->
					<div class="form-group text-center">
						<div class="custom-control custom-control-inline custom-checkbox">
							<input type="checkbox" class="custom-control-input" id="">
							<label class="custom-control-label" for="remember-me">자동 로그인</label>
						</div>
					</div>
					<!-- /.form-group -->
					<!-- recovery links -->
					<div class="text-center pt-3">
						<a href="auth-recovery-username.html" class="link">아이디 찾기</a>
						<span class="mx-2">·</span> <a href="auth-recovery-password.html" class="link">비밀번호 찾기</a>
					</div>
					<!-- /recovery links -->
					<!-- .form-group -->
					<div class="form-group mt-4">
						<button class="login_btn btn btn-lg btn-block" type="submit">로그인</button>
						<!-- <button class="login_btn btn btn-lg btn-block">로그인</button> -->
					</div>
					<!-- /.form-group -->
				</form>
				<!-- /.auth-form -->
			</div>
		</div>
	</main>
</div>
<!-- /.app -->

<script>
currentPage = "login";

$('#loginForm').parsley();

$('#loginForm').submit(function(e){
    e.preventDefault(e);
	//alert("login_ajax")
    $.ajax({
        type: 'POST',
        url: '<c:url value="/pd/login_ajax"/>',
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
                $(location).attr('href', '<c:url value="/pda012"/>');
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
