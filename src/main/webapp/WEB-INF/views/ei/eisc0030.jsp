<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
      <div class="page-wrapper" id="page-wrapper">
        <!--header ============================================================== -->
        <header class="page-title-bar row">
          <nav aria-label="breadcrumb" class="breadcrumb-padding">
           <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="#">페이지 없음</a>
            </li>
            <li class="breadcrumb-item active">페이지 없음</li>
           </ol>
          </nav>
         </header>       
          <!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list" id="left-list">
                    <div class="card">
                     <h3>설비연동 - 가동시간 페이지와 합쳐진 페이지입니다.</h3>
                     <a href="/eisc0010"><h5>가동시간으로 이동하기</h5></a>
                     <!-- .table-responsive -->
                     <div class="table-responsive">
                     </div>
                     <!-- /.table-responsive -->
                    </div>
                  </div><!-- /.left-list -->
              </div><!-- /.row -->
            </div><!-- / #main  -->
        </div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>


</script>

</body>
</html>
