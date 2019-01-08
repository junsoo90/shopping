<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js'></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


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
	
		<div class="input_area">
			<label for="cId">아이디</label> <input type="text" id="userId"
				name="userId" required="required" />
		</div>

		<div class="input_area">
			<label for="cPass">패스워드</label> <input type="text"
				id="userPass" name="userPass" required="required" />
		</div>

		<input type="button" id="signin_btn" name="signin_btn" onclick="checkLogin();" value="로그인" />

		<div id = "div_result" name = "div_result">
			
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
	<input type="button" value="목록으로"
			onclick="location.href='${pageContext.request.contextPath}/productList.do'">
	
	
</body>
</html>