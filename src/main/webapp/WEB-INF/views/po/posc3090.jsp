<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<!-- #main============================================================== -->
	
	<div style="z-index: 11;position: fixed;top: 50%;left: 50%;transform: translate(-50%, -50%);" id="sudel">
		<button type="button" class="btn btn-primary float-right mr-4 touch6" id="btnWorkOrd4F" style="margin-top:3px;width: 25vh;height: 15vh; font-size: 25px;" onClick="location.href='posc3120';">
			6층<br>작업지시선택
		</button>
		<button type="button" class="btn btn-primary float-right mr-4 touch6" id="btnWorkOrd6F" style="margin-top:3px;width: 25vh;height: 15vh; font-size: 25px;" onClick="location.href='posc3010';">
			4층<br>작업지시선택
		</button>
	</div>
	
	<div style="background: #eeeeee;position: fixed;width: 207vh;height: 107vh;left: 0px;top: 5%; z-index: 10;" id="main"></div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>
	let menuAuth = 'posc3090';
	let currentHref = 'posc3090';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","작업지시선택(P)");
	
	$('#mySidenav').remove();
</script>

</body>
</html>
