<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<!--         <header class="page-title-bar row">
          <nav aria-label="breadcrumb" class="breadcrumb-padding">
           <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="#">Main</a>
            </li>
            <li class="breadcrumb-item active">Main</li>
           </ol>
          </nav>
         </header>   -->
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list" style="width: 100%;">
				<!-- 
				<video muted autoplay loop style="position: absolute; top: 0; left: 0; width: auth; height: 100%;">
					<source src="/resources/assets/videos/testVideo3.mp4" type="video/mp4">
					<strong>Your browser does not support the video tag.</strong>
				</video>
				 -->
				<%
					if(factoryCode.equals("001")) {
				%>
						<img src="<c:url value="/resources/assets/images/main_001.png"/>" style="position: absolute; top: 0; left: 0; width: auth; height: 100%;" />
				<%	
					} else if(factoryCode.equals("002")) {
				%>
						<img src="<c:url value="/resources/assets/images/main_001.png"/>" style="position: absolute; top: 0; left: 0; width: auth; height: 100%;" />
				<%
					} else if(factoryCode.equals("003")) {
				%>
						<img src="<c:url value="/resources/assets/images/main_003.png"/>" style="position: absolute; top: 0; left: 0; width: auth; height: 100%;" />
				<%	
					}
				%>
			</div>
			<!-- /.left-list -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>


</script>

</body>
</html>
