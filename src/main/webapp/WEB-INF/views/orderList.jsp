<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>

<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js'></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/orderList.css">

<!-- deliveryConfirm -->
<script>

	function deliveryConfirm(purchaseSeq){
	
		$.ajax({
			type: "POST",
	        url: "deliveryConfirm.do",
	        contentType: "application/json; charset=utf-8",
	        data: purchaseSeq,
	        traditional: true,
	        
            success : function(data) {
            	if(data){
	            	var btndeliveryConfirm = "#deliveryConfirmBtn" + purchaseSeq;
	        		var btndeliveryConfirmLabel = "#deliveryConfirmLabel" +  purchaseSeq;
	        		
	        		$(btndeliveryConfirm).hide();
	        		$(btndeliveryConfirmLabel).show();
           	 	}
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
		
		
		
	}
</script>
	
	
<!-- 검색 -->
<script>

	var searchKeyWord;
	function searchClick(){
		var orderKeyWord = $('#orderKeyWord').val();
		
		document.location.href="orderList.do?"
				+ "orderKeyWord="+ encodeURI(encodeURIComponent(orderKeyWord));
		return true;
	}
	
	function orderSearch(){
		orderKeyWord = $('#searchSelectBox').val();
		
		document.location.href="orderList.do?"
			+ "orderKeyWord="+ encodeURI(encodeURIComponent(orderKeyWord));
		return true;
	}
	
	
	function chageSelect(){
		
		 
	}
	
</script>


<!-- 환불 -->
<script>
	function refundReqeust(purchaseSeq){

		$.ajax({
			type: "POST",
	        url: "refundReqeust.do",
	        contentType: "application/json; charset=utf-8",
	        data: purchaseSeq,
	        traditional: true,
	        
            success : function(data) {
            	if(data){
	            	var refundReqestBtn = "#refundReqestBtn" + purchaseSeq;
	        		var refundCancelBtn = "#refundCancelBtn" +  purchaseSeq;
	        		
	        		$(refundReqestBtn).hide();
	        		$(refundCancelBtn).show();
           	 	}
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
	}
	
	
	function refundCancel(purchaseSeq){
		
		$.ajax({
			type: "POST",
	        url: "refundCancel.do",
	        contentType: "application/json; charset=utf-8",
	        data: purchaseSeq,
	        traditional: true,
	        
            success : function(data) {
            	if(data){
            		var refundReqestBtn = "#refundReqestBtn" + purchaseSeq;
	        		var refundCancelBtn = "#refundCancelBtn" +  purchaseSeq;
	        		
	        		$(refundCancelBtn).hide();
	        		$(refundReqestBtn).show();
           	 	}
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
		
	}
</script>


</head>

<body>

	<div class="nav-div">
		<%@ include file = "nav.jsp" %>
	</div>
	
	<div class="order-form-div">
		<div class="order-product-div">
			<div class="ordercnt-div">
				<span>주문건수 : ${count } </span>
			</div>
			<table class="orderTable" border="1" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<th class="ordertable-th ordertable-date">날짜</th>
					<th class="ordertable-th ordertable-product">상품정보</th>
					<th class="ordertable-th ordertable-cnt">수량</th>
					<th class="ordertable-th ordertable-price">가격</th>
					<th class="ordertable-th ordertable-state">상태</th>
					<th class="ordertable-th ordertable-confirm">확인/신청</th>
				</tr>
					
				<tbody>
					<c:forEach var="orderList" items="${orderList}" varStatus='status'>
						<tr>
							<td>${orderList.orderDate}</td>
							<td >
						
								<div class="select-image">
									<img src="/admin/upload/${orderList.savefilename}" width="50" height="50"
										onclick="location.href='detail.do?seq=${orderList.pSeq}'">
									
								</div>
								<div class="select-option">
									<div class="select-option-pName select-option">
										<span>물품명 : ${orderList.pName}</span>
									</div>
									<div class="select-option-option select-option"> 
									
										<span id="pOption" name="pOption">	선택한 옵션 : ${orderList.pOption}</span>
									</div>
									<div class="select-option-price select-option">
										
										<span id="optionPrice" name="optionPrice">가격 : 
											<fmt:formatNumber value="${orderList.optionPrice}" 
												pattern="#,###" />원
										</span>
									</div>
								</div>
							</td>
		
							<td>
								<span id="cnt" name="cnt">${orderList.optionCnt}</span>
							</td>
		
		
							<td>
								<span id="optionPrice" name="optionPrice">
									<fmt:formatNumber value="${orderList.optionPrice * orderList.optionCnt}" 
										pattern="#,###" />원
								</span>
							</td>
							
							<td>
								<span id="cartState" name="cartState">
									${orderList.orderState}
								</span>
							</td>
		
							<td >
								<div id="deliveryCheck">
									<c:set var="name" value="홍길동" />
									
									<c:if test ="${orderList.orderState == '환불요청'}">
										<div id="refundCancelBtn${orderList.purchaseSeq}">
											<input type="button" 
												value="환불요청취소" onclick="refundCancel('${orderList.purchaseSeq}');">
										</div>
										
										<div id="refundReqestBtn${orderList.purchaseSeq}"  style="display:none;">
											<input type="button" 
												value="환불요청" onclick="refundReqeust('${orderList.purchaseSeq}');">
										</div>
									</c:if>
									
									<c:if test ="${orderList.orderState == '환불요청취소'}">
										<div id="refundReqestBtn${orderList.purchaseSeq}">
											<input type="button" 
												value="환불요청" onclick="refundReqeust('${orderList.purchaseSeq}');">
										</div>
										<div id="refundCancelBtn${orderList.purchaseSeq}" style="display:none;">
											<input type="button" 
												value="환불요청취소" onclick="refundCancel('${orderList.purchaseSeq}');">
										</div>
									</c:if>
									<c:if test ="${orderList.orderState == '배송완료' ||
													orderList.orderState == '배송완료(수취확인)'}">
										<c:choose>
										    <c:when test="${orderList.orderStateCheck == 0}">
											    <div id="deliveryConfirmBtn${orderList.purchaseSeq}" >
													<input type="button" 
														value="수취확인" onclick="deliveryConfirm('${orderList.purchaseSeq}');">
												</div>
												 <div id="deliveryConfirmLabel${orderList.purchaseSeq}" 
													style="display:none;">
													<label> 수취확인 </label>
												</div>
												
												<c:choose>
													<c:when test="${orderList.refund == 1}">
														<div id="refundReqestBtn${orderList.purchaseSeq}">
															<input type="button" 
																value="환불요청" onclick="refundReqeust('${orderList.purchaseSeq}');">
														</div>
														 <div id="refundCancelBtn${orderList.purchaseSeq}"  style="display:none;">
															<input type="button" 
																value="환불요청취소" onclick="refundCancel('${orderList.purchaseSeq}');">
														</div>
													</c:when>
												
													<c:otherwise>
													    <div id="refundCancelBtn${orderList.purchaseSeq}">
															<input type="button" 
																value="환불요청취소" onclick="refundCancel('${orderList.purchaseSeq}');">
														</div>
														
														<div id="refundReqestBtn${orderList.purchaseSeq}"  style="display:none;">
															<input type="button" 
																value="환불요청" onclick="refundReqeust('${orderList.purchaseSeq}');">
														</div>
													</c:otherwise>
												</c:choose>
											</c:when>
												
										    
										    <c:otherwise>
											    <div id="deliveryConfirmLabel${orderList.purchaseSeq}">
													<label> 수취확인 </label>
												</div>
												<c:choose>
													<c:when test="${orderList.refund == 1}">
														<div id="refundReqestBtn${orderList.purchaseSeq}">
															<input type="button" 
																value="환불요청" onclick="refundReqeust('${orderList.purchaseSeq}');">
														</div>
														 <div id="refundCancelBtn${orderList.purchaseSeq}" style="display:none;">
															<input type="button" 
																value="환불요청취소" onclick="refundCancel('${orderList.purchaseSeq}');">
														</div>
													</c:when>
													<c:otherwise>
													    <div id="refundCancelBtn${orderList.purchaseSeq}">
															<input type="button" 
																value="환불요청취소" onclick="refundCancel('${orderList.purchaseSeq}');">
														</div>
														
														<div id="refundReqestBtn${orderList.purchaseSeq}" style="display:none;">
															<input type="button" 
																value="환불요청" onclick="refundReqeust('${orderList.purchaseSeq}');" >
														</div>
													</c:otherwise>
												</c:choose>
										    </c:otherwise>
										</c:choose>
									</c:if>
									
								</div>
							
							</td>
						</tr>
					</c:forEach>
					
					<c:if test="${count==0}">
						<tr>
							<td colspan="6" align="center" >주문내역이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		
		<div class="order-pay-div">
			<table align ="center">
					<tr>
						<td><a href="${pageContext.request.contextPath}/orderList.do?keyField=${keyField }&orderKeyWord=${orderKeyWord }&pageNum=1">처음</a></td>
						<td align="center">${pagingHtml}</td>
						<td><a href="${pageContext.request.contextPath}/orderList.do?keyField=${keyField }&orderKeyWord=${orderKeyWord }&pageNum=${endPage}" >끝</a></td>
						
					</tr>
					
				<tr>
					<td colspan='3'>
						<select name="searchSelectBox" id="searchSelectBox"
							onchange="chageSelect()">
							<option value=""></option>
							<option value="배송준비중">배송준비중</option>
							<option value="배송중">배송중</option>
							<option value="배송완료">배송완료</option>
							<option value="배송완료(수취확인)">배송완료(수취확인)</option>
							<option value="환불요청">환불요청</option>
							<option value="환불요청취소">환불요청취소	</option>
							<option value="환불완료">환불완료</option>
						</select>
						<input type="button" value="검색" onclick="orderSearch();"/>
					</td>
				</tr>
			</table>
		</div>
	
	</div>
</body>
</html>