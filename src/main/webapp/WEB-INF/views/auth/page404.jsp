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
			<img src="<c:url value='/resources/assets/images/error3.png'/>">
		</div>
		<div class="p-5 error_cont">
			<h5>죄송합니다.</h5>
			<h4 class="mb-5 error_title">
				요청하신 페이지를 <span class="b">찾을 수 없습니다.</span>
			</h4>
			<p>방문하시려는 페이지의 주소가 잘못 입력되었거나,</p>
			<p>페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.</p>
			<p>입력하신 주소가 정확한지 다시 한번 확인해주시기 바랍니다.</p>
			<!--
			<p>서비스 이용 중 문의사항이나 불편하셨던 점은 <a href="">문의하기</a>를 이용해주세요.</p>
			<p>감사합니다.</p>
			-->
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