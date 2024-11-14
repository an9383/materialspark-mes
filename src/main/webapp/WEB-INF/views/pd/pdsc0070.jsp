<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/topPda.jsp" %>

<!-- .app -->
<div class="app pda_mo_wrap">
	<header class="pda_mo_hd text-center">
		<a class="mo_logout p-2" href="<c:url value="/pd/logout"/>"><img class="mr-2" src="/resources/assets/images/mo_logout_wh.png">
			<span class="text-middle">로그아웃</span></a>
			<%
				if(factoryCode.equals("001")) {
			%>
					<img class="p-2 text-center" src="<c:url value='/resources/assets/images/mologo_sm_wh_001.png'/>">
			<%
				} else if(factoryCode.equals("002")) {
			%>
					<img class="p-2 text-center" src="<c:url value='/resources/assets/images/mologo_sm_wh_001.png'/>">
			<%
				} else if(factoryCode.equals("003")) {
			%>
					<img class="p-2 text-center" src="<c:url value='/resources/assets/images/soul-logo-white.png'/>" style="width: 123px; height: auto;">
			<%
				}
			%>
	</header>
	<main>
		<div class="container-fluid" id="main">
			<div class="login_inf">
				<div class="login_inf_fp text-center">
					<ul class="p-0 mb-1">
						<li><img src="/resources/assets/images/profile_img.png"> </li>
						<li class="login_inf_name">${userNm}님 안녕하세요!</li>
						<li class="login_inf_id">로그인 ID : ${userId}</li>
					</ul>
					<div>
						<label style="padding: 0px;margin-top: 0px;margin-left: 50%;">
							<a href="/resources/assets/file/Naver SmartBoard Keyboard Search Draw Translate_v1.3.1_apkpure.com.apk">한국어(키보드) 다운</a>
						</label>
					</div>
				</div>
				<div class="main_btn_list row">
					<ul class="">
						<li><div><a href="<c:url value="pdsc0010"/>"><img src="/resources/assets/images/pda_list_img1.png"> <h6 class="pda_list_name">자재 창고이동</h6></a></div></li>
						<li><div><a href="<c:url value="pdsc0020"/>"><img src="/resources/assets/images/pda_list_img2.png"> <h6 class="pda_list_name">자재출고</h6></a></div></li>
				<!-- 솔브레인SLD일 경우 제품입고페이지 pdsc3030 -->
				<%
					if(factoryCode.equals("001")) {
				%>
						<li><div><a href="<c:url value="pdsc0030"/>"><img src="/resources/assets/images/pda_list_img3.png"> <h6 class="pda_list_name">제품입고</h6></a></div></li>
				<%
					} else if(factoryCode.equals("002")) {
				%>
						<li><div><a href="<c:url value="pdsc0030"/>"><img src="/resources/assets/images/pda_list_img3.png"> <h6 class="pda_list_name">제품입고</h6></a></div></li>
						<%-- <li><div><a href="<c:url value="pdsc2030"/>"><img src="/resources/assets/images/pda_list_img3.png"> <h6 class="pda_list_name">(트레이)제품입고</h6></a></div></li> --%>
				<%
					} else if(factoryCode.equals("003")) {
				%>
						<li><div><a href="<c:url value="pdsc3030"/>"><img src="/resources/assets/images/pda_list_img3.png"> <h6 class="pda_list_name">파레트 포장</h6></a></div></li>
						<li><div><a href="<c:url value="pdsc3050"/>"><img src="/resources/assets/images/pda_list_img3.png"> <h6 class="pda_list_name">미료&완공 지정</h6></a></div></li>
						<li><div><a href="<c:url value="pdsc3060"/>"><img src="/resources/assets/images/pda_list_img3.png"> <h6 class="pda_list_name">창고위치지정</h6></a></div></li>
				<%
					}
				%>
				
				<%
					if(factoryCode.equals("001")) {
				%>
						<li><div><a href="<c:url value="pdsc0040"/>"><img src="/resources/assets/images/pda_list_img4.png"> <h6 class="pda_list_name">제품출고</h6></a></div></li>
				<%
					} else if(factoryCode.equals("002")) {
				%>
						<li><div><a href="<c:url value="pdsc0040"/>"><img src="/resources/assets/images/pda_list_img4.png"> <h6 class="pda_list_name">제품출고</h6></a></div></li>
						<%-- <li><div><a href="<c:url value="pdsc2040"/>"><img src="/resources/assets/images/pda_list_img4.png"> <h6 class="pda_list_name">(트레이)제품출고</h6></a></div></li> --%>
				<%
					} else if(factoryCode.equals("003")) {
				%>
						<li><div><a href="<c:url value="pdsc3040"/>"><img src="/resources/assets/images/pda_list_img4.png"> <h6 class="pda_list_name">제품출고</h6></a></div></li>
				<%
					}
				%>
						
						<li><div><a href="<c:url value="pdsc0050"/>"><img src="/resources/assets/images/pda_list_img5.png"> <h6 class="pda_list_name">재고실사(자재)</h6></a></div></li>
						<li><div><a href="<c:url value="pdsc0060"/>"><img src="/resources/assets/images/pda_list_img6.png"> <h6 class="pda_list_name">재고실사(제품)</h6></a></div></li>
						<li><div><a href="<c:url value="pdsc0100"/>"><img src="/resources/assets/images/pda_list_img7.png"> <h6 class="pda_list_name">자재상태 확인</h6></a></div></li>
						<li><div><a href="<c:url value="pdsc0110"/>"><img src="/resources/assets/images/pda_list_img8.png"> <h6 class="pda_list_name">제품상태 확인</h6></a></div></li>
						
				<% 
					if(factoryCode.equals("003")) {
				 %>
				 		<li><div><a href="<c:url value="pdsc0120"/>"><img src="/resources/assets/images/pda_list_img8.png"> <h6 class="pda_list_name">자재부적합현황 확인</h6></a></div></li>
				 		<li><div><a href="<c:url value="pdsc3100"/>"><img src="/resources/assets/images/pda_list_img8.png"> <h6 class="pda_list_name">자재 상태 변경</h6></a></div></li>
				 		<li><div><a href="<c:url value="pdsc3090"/>"><img src="/resources/assets/images/pda_list_img8.png"> <h6 class="pda_list_name">제품입고 전 스캔</h6></a></div></li>
				 		<li><div><a href="<c:url value="pdsc3070"/>"><img src="/resources/assets/images/pda_list_img8.png"> <h6 class="pda_list_name">파레트라벨 매핑 등록</h6></a></div></li>
				 		<li><div><a href="<c:url value="pdsc3080"/>"><img src="/resources/assets/images/pda_list_img8.png"> <h6 class="pda_list_name">출하대기체크</h6></a></div></li>
				 <%
					}
				 %>
						
						
					</ul>
				</div>
			</div>
		</div>
	</main>
</div>
<!-- /.app -->

<script>
	//$(document).attr("title","PDA Main");
</script>

</body>
</html>
