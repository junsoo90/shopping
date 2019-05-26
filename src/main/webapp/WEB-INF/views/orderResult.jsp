<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<!-- goList -->
<script>
	function goList(){
		document.location.href="productList.do";
	}
	
	function goOrderList(){
		document.location.href="orderList.do";
	}
</script>

<style>
	.result-div{
		margin-left: 30%;
		margin-right: 30%;
		margin-top: 10%;
		float:left;
	}
	
	.result-text{
		font-size: 20px;
	}
	
	.result-btn{
		margin: 10%;
		float: left;
	}
	button{
		font-size: 20px;
		margin: 10%;
	}
</style>

<body>
	<div class="nav-div">
		<%@ include file="nav.jsp"%>
	</div>
	
	<div class="result-div">
		<div class="result-text">
			<h1> 결제가 완료되었습니다. </h1>
		</div>
		
		<div class="result-btn">
			<input type="button" value="목록"
					onclick="goList();">
					
			<input type="button" value="구매목록"
					onclick="goOrderList();">
		</div>
	</div>
</body>
</html>