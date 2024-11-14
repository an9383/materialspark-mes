<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>

<body>
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
	                <div class="col-md-6 login_left pl-0" style="background-image: url(<c:url value="/resources/assets/images/login_bg2.png"/>);">
	                  <h6 class="login_title">Nice to see you</h6>
					<%
						if(factoryCode.equals("001")) {
					%>
							<h1><img src="<c:url value="/resources/assets/images/materials_wh_lg_001.png"/>"></h1>
							<p class="login_deco"></p>
							<p class="login_text">머티리얼즈 파크 싱글</p>
					<%	
						} else if(factoryCode.equals("002")) {
					%>
							<h1><img src="<c:url value="/resources/assets/images/materials_wh_lg_001.png"/>"></h1>
							<!--<label style="color: #feffff;font-size: 25px;position: absolute;top: 235px;left: 341px;">2</label>-->
							<p class="login_deco"></p>
							<p class="login_text">머티리얼즈 파크 듀얼</p>
					<%
						} else if(factoryCode.equals("003")) {
					%>
							<h1><img src="<c:url value="/resources/assets/images/materials_wh_lg_003.png"/>"></h1>
							<p class="login_deco"></p>
							<p class="login_text">솔브레인(SLD)</p>
					<%	
						}
					%>
	                </div>
	                <div class="col-md-6">
	                  <h4 class="login-header">로그인</h4>
	                  <form class="login-form"  id="loginForm">
	                    <!-- .form-group -->
	                    <div class="form-mb">
	                        <input style="max-width:100%" type="text" id="inputUser" class="form-control-lg" placeholder="아이디 - Web"> 
	                    </div><!-- /.form-group -->
	                    <!-- .form-group -->
	                    <div class="form-mb">
	                        <input style="max-width:100%" type="password" id="inputPassword" class="form-control-lg" placeholder="비밀번호">
	                    </div><!-- /.form-group -->
	                    <!-- .form-group -->
	                    <div class="form-mb">
	                      <button class="login_btn btn btn-lg btn-primary btn-block" type="submit">로그인</a></button>
	                    </div><!-- /.form-group -->
	                    <!-- .form-group -->
	                    
	                    <!-- 
	                    <div class="form-mb text-center mt-3">
	                      <div class="custom-control custom-control-inline custom-checkbox">
	                        <input type="checkbox" class="custom-control-input" id="rememberMe" name="rememberMe"> <label class="custom-control-label" for="rememberMe">자동 로그인</label>
	                      </div>
	                    </div>
	                     -->
	                    
	                    <!-- /.form-group -->
	                    </div><!-- /.form-group -->
	                    <!-- 
	                    <div class="text-center pt-3">
	                      <a href="#" class="link">아이디 찾기</a> <span class="mx-2">·</span> <a href="#" class="link">비밀번호 찾기</a>
	                    </div>
	                     -->
	                  </form><!-- /.auth-form -->
	                </div>
	          </div>
	        </div>
	    </div><!-- /.app -->
	    
	    
<%-- 	    
<c:choose>
    <c:when test="${isMobile eq 'web'}">
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
	                <div class="col-md-6 login_left pl-0" style="background-image: url(/resources/assets/images/login_bg2.png);">
	                  <h6 class="login_title">Nice to see you</h6>
	                  <h1><img src="/resources/assets/images/materials_wh_lg.png"></h1>
	                  <p class="login_deco"></p>
	                  <p class="login_text">머티리얼즈 파크</p>
	                </div>
	                <div class="col-md-6">
	                  <h4 class="login-header">로그인</h4>
	                  <form class="login-form"  id="loginForm">
	                    <!-- .form-group -->
	                    <div class="form-mb">
	                        <input style="max-width:100%" type="text" id="inputUser" class="form-control-lg" placeholder="아이디 - WEB"> 
	                    </div><!-- /.form-group -->
	                    <!-- .form-group -->
	                    <div class="form-mb">
	                        <input style="max-width:100%" type="password" id="inputPassword" class="form-control-lg" placeholder="비밀번호">
	                    </div><!-- /.form-group -->
	                    <!-- .form-group -->
	                    <div class="form-mb">
	                      <button class="login_btn btn btn-lg btn-primary btn-block" type="submit">로그인</a></button>
	                    </div><!-- /.form-group -->
	                    <!-- .form-group -->
	                    
	                    <!-- 
	                    <div class="form-mb text-center mt-3">
	                      <div class="custom-control custom-control-inline custom-checkbox">
	                        <input type="checkbox" class="custom-control-input" id="rememberMe" name="rememberMe"> <label class="custom-control-label" for="rememberMe">자동 로그인</label>
	                      </div>
	                    </div>
	                     -->
	                    
	                    <!-- /.form-group -->
	                    </div><!-- /.form-group -->
	                    <!-- 
	                    <div class="text-center pt-3">
	                      <a href="#" class="link">아이디 찾기</a> <span class="mx-2">·</span> <a href="#" class="link">비밀번호 찾기</a>
	                    </div>
	                     -->
	                  </form><!-- /.auth-form -->
	                </div>
	          </div>
	        </div>
	    </div><!-- /.app -->
 </c:when>
    <c:otherwise>
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
								<div class="form-mb">
									<input style="max-width: 100%" type="text" id="inputUser" class="form-control-lg" placeholder="아이디 - MOBILE">
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
    </c:otherwise>
</c:choose>
 --%>

<%@include file="../layout/script.jsp" %>

<script>
	var isMobile = "${isMobile}";
	//var mobile = (/iphone|ipad|ipod|android/i.test(navigator.userAgent.toLowerCase()));
	//var isMobile = false;

	// PC 환경
	//     var filter = "win16|win32|win64|mac";

	//     if (navigator.platform) {
	//         isMobile = filter.indexOf(navigator.platform.toLowerCase()) < 0;
	//     }

	currentPage = "login";

	$('#loginForm').parsley();

	var loginUrl = '<c:url value="/main"/>';
	if (isMobile == "mobile") {
		loginUrl = '<c:url value="/pdsc0070"/>';
	}

	$("#loginForm").submit(function(e) {
		e.preventDefault(e);
		$.ajax({
			type : 'POST',
			url : '<c:url value="/auth/login_ajax"/>',
			dataType : 'json',
			data : {
				userId		:	$('#inputUser').val(),
				userPw		:	$('#inputPassword').val(),
				rememberMe	:	$('input:checkbox[name="rememberMe"]').is(":checked"),
			},
			beforeSend : function() {
				$('.btn-login').addClass('d-none');
				$('.btn-loading').removeClass('d-none');
			},
			success : function(res) {
				if (res.result === 'ok') {
					$(location).attr('href', loginUrl);
				} else if (res.result === 'fail') {
					$('#password').val('');
					$('#message').text(res.message);
					$('#messageBox').removeClass('d-none');
					setTimeout(function() {
						$('#messageBox').addClass('d-none');
					}, 5000);
				} else if (res.result === 'error') {
					$('#password').val('');
					$('#message').text(res.message);
					$('#messageBox').removeClass('d-none');
					setTimeout(function() {
						$('#messageBox').addClass('d-none');
					}, 5000);
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
