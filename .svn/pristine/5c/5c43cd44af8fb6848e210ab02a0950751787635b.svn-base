<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js'></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css">
</head>


<!-- checkLogin -->
<script type="text/javascript">
	
	var idcheck = false; 
	var overlap = false;
	$("#login_result").remove();
	
  	function checkLogin(){
     	idcheck = true;
        //userid 를 param.
    	var userId = $("#userId").val();
        var userPass = $("#userPass").val();
        
    	var form_data = {
   			userId: userId,
   			userPass: userPass
    	};
    	
    	$.ajax({
            async: true,
            type : 'POST',
            data : form_data,
            url : "login.do",
            
            success : function(mav) {
            	$("#login_result").remove();
            	if(mav.msg){
            		//alert(mav.url);
            		location.href = mav.url;            			
            	}
            	else{
	                var source = $("#loginTemplate").html();
	        	    var template = Handlebars.compile(source);
	        	    var data  = [
	        	    	{
	        	    		result:mav.result,
	        	    		msg:mav.msg
	        	    	}
	        	    ];
	        	    alert(mav.result);
	        	    $("#div_result").append(template(data));
            	}
            },
            error : function(error) {
                alert("error : " + error);
            }
        });
     
    }
</script>


<body>

	<div class="nav-div">
		<%@ include file = "nav.jsp" %>
	</div>
	
	<div class="main-div">
		<h1> 로그인 </h1>
		<div class="input_area">
			<span> 아이디 </span> 
			<input type="text" class="input" id="userId"
				name="userId" required="required" />
		</div>

		<div class="input_area">
			<span>패스워드</span>
			<input type="text" class="input"
				id="userPass" name="userPass" required="required" />
		</div>
		
		<div id = "div_result" name = "div_result">
			
		</div>
	
		<div>
			<div class="btn">   
				<input type="button" id="signin_btn" name="signin_btn" 
					onclick="checkLogin();" value="로그인" />
			</div>
			
			<div class="btn">	
				<input type="button" value="아이디 찾기"
					onclick="location.href='${pageContext.request.contextPath}/idSearch.do'">
			</div>
			
			<div class="btn">	
				<input type="button" value="비밀번호 찾기"
					onclick="location.href='${pageContext.request.contextPath}/passSearch.do'">
			</div>
		</div>
		
		<script id="loginTemplate" type="text/x-handlebars-template">
		
    	{{#each .}}
			<div id="login_result" name="loin_result">
				<c:if test="{{msg}} == false">
					   <p style="color:#f00;">{{result}}</p>
				</c:if>
			</div>
   	 	{{/each}}
		
		</script>
	</div>
	
</body>
</html>