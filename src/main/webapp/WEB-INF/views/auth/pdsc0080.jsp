<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>

<body>

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
							<%
								if(factoryCode.equals("001")) {
							%>
									<img src="<c:url value='/resources/assets/images/mo_main_logo_001.png'/>">
							<%
								} else if(factoryCode.equals("002")) {
							%>
									<img src="<c:url value='/resources/assets/images/mo_main_logo_001.png'/>">
							<%
								} else if(factoryCode.equals("003")) {
							%>
									<img src="<c:url value='/resources/assets/images/mo_main_logo_004.png'/>" style="width: 155px; height: auto;">
							<%
								}
							%>
						</div>
						<div class="p-4">
							<form class="login-form" id="loginForm">
								<div class="form-mb">
									<input style="max-width: 100%" type="text" id="inputUser" class="form-control-lg" placeholder="아이디 - Mobile">
								</div>
								<div class="form-group">
									<input style="max-width: 100%" type="password" id="inputPassword" class="form-control-lg" placeholder="비밀번호">
								</div>
								
								<!-- 
			                    <div class="form-mb text-center mt-3">
			                      <div class="custom-control custobit
			                      m-control-inline custom-checkbox">
			                        <input type="checkbox" class="custom-control-input" id="rememberMe" name="rememberMe"> <label class="custom-control-label" for="rememberMe">자동 로그인</label>
			                      </div>
			                    </div>
			                     -->
			                    
								<div class="form-mb mt-4">
									<button class="login_btn btn btn-lg btn-block" type="submit">로그인</button>
									<!-- <button class="login_btn btn btn-lg btn-block">로그인</button> -->
								</div>
							</form>
							<!-- /.auth-form -->
						</div>
					</div>
			</main>
		</div>
		<!-- /.app -->
    
<%@include file="../layout/script.jsp" %>

<script>

	currentPage = "login";
	$('#loginForm').parsley();

	var loginUrl = '<c:url value="/pdsc0070"/>';

	$("#loginForm").submit(
			function(e) {
				e.preventDefault(e);
				//alert("login_ajax")
				$.ajax({
					type : 'POST',
					url : '<c:url value="/auth/login_ajax"/>',
					dataType : 'json',
					data : {
						userId : $('#inputUser').val(),
						userPw : $('#inputPassword').val(),
						rememberMe : $('input:checkbox[name="rememberMe"]').is(":checked"),
					},
					beforeSend : function() {
						$('.btn-login').addClass('d-none');
						$('.btn-loading').removeClass('d-none');
					},
					success : function(res) {
						if (res.result === 'ok') {
							$(location).attr('href', loginUrl);
						} else {
							$('#password').val('');
							$('#message').text(res.message);
							$('#messageBox').removeClass('d-none');
						}
					},
					complete : function() {
						$('.btn-login').removeClass('d-none');
						$('.btn-loading').addClass('d-none');
					}
				});
			});
</script>
</body>
</html>
