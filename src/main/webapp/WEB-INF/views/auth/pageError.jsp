<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>

<%@include file="../layout/header.jsp" %>

<body>
<div class="app" style="height: 100%;">
	<div class="center_card">
		<div class="error_img">
			<img src="<c:url value='/resources/assets/images/error.png'/>">
		</div>
		<div class="p-5 error_cont">
			<h5>죄송합니다.</h5>
			<h4 class="mb-5 error_title">
				시스템 에러가 발생하였습니다.<br><span class="b">인터넷 연결을 확인하시고 잠시 후 다시 시도해 주세요.</span>
			</h4>
			<div class="return_box">
				<a class="return_mainBtn" href="<c:url value='/main'/>">메인으로 이동</a>
			</div>
		</div>
	</div>
</div>
<script>

</script>
</body>
</html>