<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<title>POP 모니터링 이상알람!</title>
<%@include file="../layout/top.jsp" %>

<body>
<div class="app" style="height: 100%;">
	<div class="center_card" style="margin:50px;">
		<textarea class="form-control text-left" style="max-width:600px; height:850px; resize:none;" id="cMonitoringAlarm" disabled></textarea>
	</div>
</div>
<script>

	//처음 팝업이 열릴시에만 값 세팅
	document.getElementById("cMonitoringAlarm").value = window.opener.document.getElementById("pMonitoringAlarm").value;
	document.getElementById("cMonitoringAlarm").scrollTop = document.getElementById("cMonitoringAlarm").scrollHeight;
	
</script>
</body>
</html>