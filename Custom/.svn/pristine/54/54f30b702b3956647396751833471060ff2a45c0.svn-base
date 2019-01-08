<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">

</head>


<body>
<%@ include file = "nav.jsp" %>

<table width="1000" border="1" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<th style="font-family: Gulim; font-size: 12px;">사진</th>
				<th style="font-family: Gulim; font-size: 12px;">물품이름</th>
				<th style="font-family: Gulim; font-size: 12px;">가격</th>
			</tr>
			
		<tbody>
			<c:forEach var="product" items="${list}">
				<tr>
					<td width="70" style="font-family: Gulim; font-size: 12px;">
						 <img src="${product.filelocation}" width="50" height="50"
							 onclick="location.href='detail.do?seq=${product.pSeq}'">
					</td>				
					<td width="70" style="font-family: Gulim; font-size: 12px;">${product.pSeq}</td>				
					<td align="center" width="70" style="font-family: Gulim; font-size: 12px;">
						<a href="detail.do?seq=${product.pSeq}">${product.pName}</a>
						
					</td>
					<td align="center" width="30" style="font-family: Gulim; font-size: 12px;"><fmt:formatNumber value="${product.pPrice}" pattern="#,###"/>원 ~</td>
				</tr>
			</c:forEach>
			<c:if test="${count==0}">
				<tr>
					<td colspan="5" align="center" style="font-family: Gulim; font-size: 12px;">게시물이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
</body>
</html>