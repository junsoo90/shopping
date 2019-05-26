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

<script>
	function goList(){
		var keyWord = "${sessionScope.keyWord}";
		document.location.href="productList.do";
	}
</script>

<style>
	.empty-div{
		margin-left : 30%;
		margin-right : 30%;
		margin-top : 10%;
		width: 100%;
		height: 100%;
		float:left;
	}
	.nav-div{
	
	}
</style>

<body>

	<div class="nav-div">
		<%@ include file = "nav.jsp" %>
	</div>
	<div class="empty-div"> 
		찾을수 없는 페이지입니다.
		<div class="btn-productList">
			<input type="button" class="btn-div-option" value="목록"
				onclick="goList();">
		</div>
	</div>
</body>
</html>