<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>

<!-- .app -->
<div class="app pda_mo_wrap">
	<header class="pda_mo_hd text-center">
		<a class="mo_logout p-2" href="#"> <img class="mr-2" src="/resources/assets/images/mo_logout_wh.png">
		<span class="text-middle">로그아웃</span>
		</a> <img class="p-2 text-center" src="/resources/assets/images/mologo_sm_wh.png">
	</header>
	<main>
		<div class="container-fluid" id="main">
			<div class="login_inf">
				<div class="login_inf_fp text-center">
					<ul class="p-0">
						<li><img src="/resources/assets/images/profile_img.png"> </li>
						<li class="login_inf_name">${userNm}님 안녕하세요!</li>
						<li class="login_inf_id">로그인 ID : ${userId}</li>
					</ul>
				</div>
				<div class="main_btn_list row">
					<ul class="">
						<li><a href="<c:url value="pdsc0010"/>"><img src="/resources/assets/images/pda_list_img1.png"> <h6 class="pda_list_name">자재입고</h6></a></li>
						<li><a href="#"><img src="/resources/assets/images/pda_list_img2.png"> <h6 class="pda_list_name">자재출고</h6></a></li>
						<li><a href="#"><img src="/resources/assets/images/pda_list_img3.png"> <h6 class="pda_list_name">제품입고</h6></a></li>
						<li><a href="#"><img src="/resources/assets/images/pda_list_img4.png"> <h6 class="pda_list_name">제품출고</h6></a></li>
						<li><a href="#"><img src="/resources/assets/images/pda_list_img5.png"> <h6 class="pda_list_name">자재재고실사</h6></a></li>
						<li><a href="#"><img src="/resources/assets/images/pda_list_img6.png"> <h6 class="pda_list_name">제품재고실가</h6></a></li>
					</ul>
				</div>
			</div>
		</div>
	</main>
</div>
<!-- /.app -->

<script>

</script>

</body>
</html>
