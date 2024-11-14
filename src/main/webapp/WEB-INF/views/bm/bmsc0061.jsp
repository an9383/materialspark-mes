<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>


<%@include file="../layout/body-top.jsp" %>

<div class="page has-sidebar has-sidebar-expand-lg">
	<div class="row">
	    <!-- 
	    <div class="page-inner">
	    -->
<!-- 	    <div class="col-md-6"> -->
		<div style="width:70%">	
			  <div class="card card-fluid">
                      <!-- .card-header -->
                      <div class="card-header pt-4">
                      <form>
                      <div class="row">
                        <form>
                        <!-- .form-group -->
                          <div class="form-group col-md-3">
                           <input type="text" class="form-control" placeholder="자재코드" id="tfDefault">
                          </div><!-- /.form-group -->
                        <!-- .form-group -->
                          <div class="form-group col-md-3">
                           <input type="text" class="form-control" placeholder="자재명" id="tfDefault">
                          </div><!-- /.form-group -->
                        <!-- .form-group -->
                        <div class="form-group col-md-2">
                          <button type="button" class="btn btn-subtle-primary"><span class="oi oi-magnifying-glass"></span></button>
                        </div><!-- /.form-group -->
                          <!-- .form-group -->
                          <div class="form-group col-md-4">                            
                             
                           </div><!-- /.form-group -->
                        </form>
                      </div>
                      </form>
                      </div><!-- /.card-header -->                      
                      <!-- .table-responsive -->
                      <div class="table-responsive">
                      
                        <!-- .table -->
                        <table class="table table-bordered" id="codeTable">
                          <!-- thead -->
                          <thead class="thead-">
                            <tr>
                              <th style="min-width:100px"> 자재코드 </th>
                              <th style="min-width:150px"> 자재명 </th>
                              <th style="min-width:50px"> 이니셜 </th>
                              <th style="min-width:50px"> 재질 </th>
                              <th style="min-width:120px"> 구분(연질/경질) </th>
                              <th style="min-width:80px"> 면취(압연)</th>
                              <th style="min-width:50px"> 두께 </th>
                              <th style="min-width:50px"> 폭 </th>
                              <th style="min-width:50px"> 너비 </th>
                              <th style="min-width:50px"> 길이 </th>
                              <th style="min-width:50px"> 피치 </th>
                            </tr>
                          </thead><!-- /thead -->
                          <!-- tbody -->
                          <tbody id="example">
                           
                          </tbody><!-- /tbody -->
                        </table><!-- /.table -->
                      </div><!-- /.table-responsive -->
                      <!-- .el-example -->
                      <div class="el-example mt-2">
                        <ul class="pagination pagination-sm justify-content-end">
                          <li class="page-item disabled">
                            <a class="page-link" href="#">«</a>
                          </li>
                          <li class="page-item active">
                            <a class="page-link" href="#">1</a>
                          </li>
                          <li class="page-item">
                            <a class="page-link" href="#">2</a>
                          </li>
                          <li class="page-item">
                            <a class="page-link" href="#">3</a>
                          </li>
                          <li class="page-item">
                            <a class="page-link" href="#">4</a>
                          </li>
                          <li class="page-item">
                            <a class="page-link" href="#">5</a>
                          </li>
                          <li class="page-item">
                            <a class="page-link" href="#">»</a>
                          </li>
                        </ul>
                      </div><!-- /.el-example -->
                    </div><!-- /.card -->
	    </div>
	
	    <!-- 사이드 페이지 -->
	    <!-- 
	    <div class="page-sidebar">
	    -->
	    
<!-- 	    <div class="col-md-6"> -->
		<div style="width:100%;">
		<div class="col-xl-6">
                    <!-- .card -->
                    <div class="card card-fluid">
                      <!-- .card-header -->
                      <div class="card-header p-1">
                        <div class="d-flex align-items-center">
                          <button type="button" class="btn btn-primary m-1" id="edit">등록</button>
                          <button type="button" class="btn btn-primary m-1" id="modify">수정</button>                         
                          
                        </div>
                      </div><!-- /.card-header -->
                      <!-- .table-responsive -->
                      <div class="table-responsive">
                        <!-- .table -->
                        <table class="table table-bordered" id="sub">
                          <!-- thead -->
                          <thead class="thead-">
                            <tr>
                              <th style="min-width:100px;">자재코드</th>
                              <td style="min-width:100px;"> <input type="text" class="form-control" name="matrlCd" id="matrlCd"  >                           
                              </td>
                            </tr>
                          </thead><!-- /thead -->
                          <!-- tbody -->
                          <tbody>
                            <!-- tr -->
                            <tr>
                              <th style="min-width:110px;vertical-align:middle;"> 자재명 </th>
                              <td style="min-width:150px;">
                                    <div class="m-1 row">
                                     <input type="text" class="form-control"  name="matrlNm" id="matrlNm"  >
                                     </div>
                              </td>
                              <th style="min-width:110px;">이니셜</th>
                              <td style="min-width:150px;"> <input type="text" class="form-control" name="matrlInitial" id="matrlInitial"  >
                              </td>
                            </tr><!-- /tr -->
                            <!-- tr -->
                            <tr>
                              <th> 재질 </th>
                                <td>
                                  <div class="row">
                                    <div class="col-md-7"><input type="text" class="form-control" name="quty" id="quty"   ></div>
                                    <div class="col-md-3">
                                      <button type="button" class="btn btn-subtle-primary"><span class="oi oi-magnifying-glass" ></span></button>
                                    </div>
                                  </div>
                                </td>
                              <th> 구분(연질/경질) </th>
                              <td>  
                                <select class="custom-select custom-select-sm" name="gubun" id="gubun">
                                  <option> </option>
                                  <option> H0 </option>
                                  <option> H1 </option>
                                </select>
                              </td>
                              
                            </tr><!-- /tr -->
                            <!-- tr -->
                            <tr>
                              <th> 두께 </th>
                              <td> <input type="text" class="form-control" name="thickness" id="thickness"   > </td>
                              <th> 면취  (압연)</th>
                              <td>
                                <select class="custom-select custom-select-sm" name="chamferYn" id="chamferYn" >
                                  <option> </option>
                                  <option> y</option>
                                  <option> n </option>
                                </select>
                              </td>
                            </tr><!-- /tr -->
                            <!-- tr -->
                            <tr>
                              <th> 폭 </th>
                              <td>
                                <input type="text" class="form-control" placeholder="Default" name="depth" id="depth"  >
                              </td>
                              <th> 너비 </th>
                              <td><input type="text" class="form-control" placeholder="Default" name="width" id="width"  ></td>
                            </tr><!-- /tr -->
                            <!-- tr -->
                            <tr>
                              <th> 길이 </th>
                              <td><input type="text" class="form-control" placeholder="Default" name="length" id="length"  ></td>
                              <th> 피치 </th>
                              <td><input type="text" class="form-control" placeholder="Default" name="pitch" id="pitch"  ></td>
                            </tr><!-- /tr -->
                            <!-- tr -->
                            <tr>
                              <th> 생산단위 </th>
                                <td>
                                  <div class="row">
                                    <div class="col-md-7">
                                    	<select class="custom-select custom-select-sm" name="productUnit" id="productUnit"  >
		                                  <option>  </option>
		                                  <option> m  </option>
		                                  <option> mm </option>
		                                  <option> km  </option>		                                  
		                                </select>
                                    </div>
                                    <div class="col-md-3">
                                      <button type="button" class="btn btn-subtle-primary"><span class="oi oi-magnifying-glass"></span></button>
                                    </div>
                                  </div>
                                </td>
                                <th> 재고단위 </th>
                                  <td>
                                    <div class="row">
                                      <div class="col-md-7">
                                      	<select class="custom-select custom-select-sm" name="invntrUnit" id="invntrUnit"  >
		                                  <option>  </option>
		                                  <option> g  </option>
		                                  <option> kg </option>
		                                  <option> t  </option>		                                  
		                                </select>                                      
                                      </div>
                                      <div class="col-md-3">
                                        <button type="button" class="btn btn-subtle-primary"><span class="oi oi-magnifying-glass"></span></button>
                                      </div>
                                    </div>
                                  </td>
                            </tr><!-- /tr -->
                            <!-- tr -->
                            <tr>
                              <th> 입고처 </th>
                                <td>
                                  <div class="row">
                                    <div class="col-md-7"><input type="text" class="form-control" placeholder="Default" name="dealCorpCd" id="dealCorpCd"  ></div>
                                    <div class="col-md-3">
                                      <button type="button" class="btn btn-subtle-primary"><span class="oi oi-magnifying-glass"></span></button>
                                    </div>
                                  </div>
                                </td>
                                <th> 유수명주기
                                </th>
                                <td><input type="text" class="form-control" placeholder="Default" name="lifeCycle" id="lifeCycle"  ></td>
                            </tr><!-- /tr -->
                            <!-- tr -->
                            <tr>
                              <th> 체크 1 </th>
                              <td><input type="text" class="form-control" placeholder="Default" name="etc1" id="etc1"  ></td>
                              <th> 체크 2 </th>
                              <td><input type="text" class="form-control" placeholder="Default" name="etc2" id="etc2"  ></td>
                            </tr><!-- /tr -->
                            <!-- tr -->
                            <tr>
                              <th> 상태유무</th>
                              <td>
                                <select class="custom-select custom-select-sm" name="statusYn" id="statusYn"  >
                                  <option> </option>
                                  <option> y </option>
                                  <option> n </option>
                                </select>
                              </td>
                              <th> 비고 </th>
                              <td><input type="text" class="form-control" placeholder="Default" name="matrlDesc" id="matrlDesc"  ></td>
                            </tr><!-- /tr -->
                          </tbody><!-- /tbody -->
                        </table><!-- /.table -->
                        <div id="cc"></div>
                      </div><!-- /.table-responsive -->
                    </div><!-- /.card -->
                  </div><!-- /grid column -->
	    
	    </div>
    </div>
</div>

<%@include file="../layout/bottom.jsp" %>

 <script>
    	$(document).ready(function(){
    		$("#sub input").prop("readonly", true);
    		$("#sub select option").not(":selected").attr("disabled", "disabled");
    		
    		onClick();    		
    	});
		
	    $(document).on('click','#save',function(){ //저장 버튼 클릭시
	    	if ( !$.trim($('#matrlCd').val()) || !$.trim($('#matrlNm').val()) ){
	    		alert('자재코드와 명을 입력해주세요.');		       
		        return false;
	    	} else{
	    		$.ajax({
					url: '<c:url value="/save"/>',
					type: 'POST',
					datatype: 'json',
					data: {
					
						'matrlCd' : $('#matrlCd').val(),
						'matrlNm' : $('#matrlNm').val(),
						'matrlInitial' : $('#matrlInitial').val(),
						'quty' : $('#quty').val(),
						'thickness' : $('#thickness').val(),
						'depth' : $('#depth').val(),
						'length' : $('#length').val(),
						'width' : $('#width').val(),
						'pitch' : $('#pitch').val(),
						'gubun' : $('#gubun').val(),
						'chamferYn' : $('#chamferYn').val(),
						'invntrUnit' : $('#invntrUnit').val(),
						'dealCorpCd' : $('#dealCorpCd').val(),
						'lifeCycle' : $('#lifeCycle').val(),
						'etc1' : $('#etc1').val(),
						'etc2' : $('#etc2').val(),
						'statusYn' : $('#statusYn').val(),
						'matrlDesc' : $('#matrlDesc').val(),
						'productUnit' : $('#productUnit').val()				
					},
					success: function(result){
						
						if ( !$.trim($('#matrlCd').val()) || !$.trim($('#matrlNm').val()) ){
					        alert('자재코드와 자재명을 입력해주세요');		       
					        return false;
					    } else {						
							alert("success!");
							$('#codeTable').DataTable().ajax.reload();
							$('#save').hide();
							$("#sub input").prop("readonly", true);
							$("#sub select option").not(":selected").attr("disabled", "disabled");
							$('#edit').attr('disabled', false);
							$('#modify').attr('disabled', false);
							onClick();
					
					    }
					}
				});		
	    	}
		});
	
	    $('#codeTable').DataTable({ //데이터 테이블 출력
			'ajax': {
				url: '<c:url value="/data"/>',
				type: 'GET',
				data: {},
			},
			columns: [
				{ data: 'matrlCd'},
				{ data: 'matrlNm'},
				{ data: 'matrlInitial'},
				{ data: 'quty'},
				{ data: 'gubun'},
				{ data: 'chamferYn'},
				{ data: 'thickness'},
				{ data: 'depth'},
				{ data: 'width'},
				{ data: 'length'},
				{ data: 'pitch'},	
				
			],
			order: [
				[ 0, 'desc' ],
			],
		});
	    
	 
	 function onClick(){
		$('#example').on( 'click','tr', function () { // 데이터 테이블 라인 클릭시
			$(this).toggleClass('selected');	
			var val = new Array();
	        for(i=0; i < 11; i++){
	        	val[i] = $(this).closest('tr').find('td:eq(' + i + ')').text(); // amend the index as needed
		       
	        }
	        console.log(val);
	        $.ajax({
				url: '<c:url value="/sideData"/>',
				type: 'POST',
				datatype: 'json',
				data: {
					'matrlCd' : val[0],
					'matrlNm' : val[1],					
				},
				success: function(result){
					console.log(result);					
					$('#matrlCd').val(result.matrlCd);
					$('#matrlNm').val(result.matrlNm);
					$('#matrlInitial').val(result.matrlInitial);
					$('#quty').val(result.quty);
					$('#thickness').val(result.thickness);
					$('#depth').val(result.depth);
					$('#length').val(result.length);
					$('#width').val(result.width);
					$('#pitch').val(result.pitch);
					$('#gubun').val(result.gubun);
					$('#chamferYn').val(result.chamferYn);
					$('#lifeCycle').val(result.lifeCycle);
					$('#etc1').val(result.etc1);
					$('#etc2').val(result.etc2);
					$('#statusYn').val(result.statusYn);
					$('#matrlDesc').val(result.matrlDesc);
					$('#productUnit').val(result.productUnit);
			
				}
			});			       
	        
		});      
	 }
	
		$('#modify').on('click',function(){ //수정 버튼 클릭 시	
			
			if ( !$.trim($('#matrlCd').val()) || !$.trim($('#matrlNm').val()) ){
		        alert('수정할 목록을 선택해 주세요.');		       
		        return false;
		    } else {
				var dynamicTag = '<input type="button" id="save" class="btn btn-primary m-1" value="저장"/>';
				$('#cc').html(dynamicTag);
				$('#sub input').prop("readonly", false);
				$('#matrlCd').prop("readonly", true);
				$('#matrlNm').prop("readonly", true);
				$("#sub select option").attr('disabled', false);
				$('#edit').attr('disabled', true);				
			}
		});
		
		$('#edit').on('click',function(){ //수정 버튼 클릭 시	
					
		        alert('등록할 정보를 입력해주세요');		       
		       	var dynamicTag = '<input type="button" id="save" class="btn btn-primary m-1" value="저장"/>';
				$('#cc').html(dynamicTag);
				$("#sub input").prop("readonly", false);
				$("#sub select option").attr('disabled', false);
				$("td input").val("");
				$('select').find('option:first').attr('selected', 'selected');
				$('#modify').attr('disabled', true);
				$('#example').off('click');
			
		});
		
		$('#ex_file').change(function(){
			var filename = $('#ex_file')[0].files[0].name; //파일이름
			$.ajax({
				url: '<c:url value="/fileload"/>',
				type: 'POST',
				datatype: 'json',
				data: {
					'filename' : filename									
				},
				success: function(result){
					alert("excel등록!");
				}
				
			});			       
		});
			
		

		
	   
    </script>

</body>
</html>
