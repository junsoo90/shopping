<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<ul>
		<c:if test="${custom == null}">
			<li><a href="${pageContext.request.contextPath}/login.do">로그인</a></li>
			<li><a href="${pageContext.request.contextPath}/customInsert.do">회원가입</a></li>
		</c:if>
		<c:if test="${custom != null}">
			<li>${custom.cId}님 환영합니다.</li>
			<li><a href="${pageContext.request.contextPath}/cart.do">장바구니</a></li>
			<li><a href="${pageContext.request.contextPath}/logout.do">로그아웃</a></li>
		</c:if>
		<li><a href="${pageContext.request.contextPath}/productList.do">목록으로</a></li>
	</ul>
	
</body>
</html>