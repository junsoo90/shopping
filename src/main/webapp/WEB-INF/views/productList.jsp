<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLEncoder"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<html>
<head>
<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/productList.css">
<meta charset="UTF-8">

</head>

<!-- 검색 -->
<script>

	function searchClick(){
		var keyWord = $('#keyWord').val();
		//alert(keyWord);
		
		if(!fnChkByte(keyWord, 30,"검색어"))
    		return false;
		
		document.location.href="productList.do?pageNum=1"
				+ "&keyWord="+ encodeURI(encodeURIComponent(keyWord));
		return true;
	}
</script>


<!-- checkByte -->
<script>
	function fnChkByte(obj, maxByte, cvalue) {
		var str = obj.toString();
		//var str_len = str.length;

		var rbyte = 0;
		var rlen = 0;
		var one_char = "";
		var str2 = "";

		for (var i = 0; i < str.length; i++) {
			one_char = str.charAt(i);

			if (escape(one_char).length > 4) {
				rbyte += 3; //한글2Byte
			} else {
				rbyte++; //영문 등 나머지 1Byte
			}

			if (rbyte <= maxByte) {
				rlen = i + 1; //return할 문자열 갯수
			}
		}
		if (rbyte > maxByte) {
			if(cvalue == '전화번호'){
				alert(cvalue + "은(는) 숫자 " + maxByte					
						+ "자를 초과 입력할 수 없습니다.");
			}
			else{
				alert(cvalue + "은(는) 한글 " + (maxByte / 2) +
						"자 / 영문 " + maxByte
						+ "자를 초과 입력할 수 없습니다.");
			}
			str2 = str.substr(0, rlen); //문자열 자르기
			obj.value = str2;
			//fnChkByte1(obj, maxByte);
			return false;
		}
		
		
			return true;
	}
</script>



<body>
	<div class="nav-div">
		<%@ include file = "nav.jsp" %>
	</div>
	
	<div class="body-div">
		<div class="list-div">
			<c:forEach var="product" items="${list}">
				<div>
					<ul class="productList">
						<li>
							<div class="list-photo">
								<img src="/admin/upload/${product.savefilename}"
								 width="50" height="50"
								 	onclick="location.href='detail.do?seq=${product.pSeq}'">
							</div>
							
							<div class="list-pNmae">
								<a href="detail.do?seq=${product.pSeq}">${product.pName}</a>
							</div>
							
							<div class="list-pPrice">
								<fmt:formatNumber value="${product.pPrice}" pattern="#,###"/>원 ~</td>
							</div>
									
						</li>
					</ul>
					
				</div>
			</c:forEach>
			<c:if test="${count==0}">
				상품내역이 없습니다.
			</c:if>
		</div>
		
		<div class="search-nav-div">
			<div class="paging-div">
				<a href="${pageContext.request.contextPath}/productList.do?keyField=${keyField }&keyWord=${keyWord }&pageNum=1" style="text-decoration: none">처음</a>
					${pagingHtml}
				<a href="${pageContext.request.contextPath}/productList.do?keyField=${keyField }&keyWord=${keyWord }&pageNum=${endPage}" style="text-decoration: none">끝</a>
			</div>
			<br>
			
			<div class="search-div">
				<input type ="text" id="keyWord" name = "keyWord"/>
				<input type = "button" value="검색" onClick="searchClick();"/>
			</div>
		</div>
		
	</div>
	
	<div class="bottom-div">
		
	</div>
	
</body>
</html>