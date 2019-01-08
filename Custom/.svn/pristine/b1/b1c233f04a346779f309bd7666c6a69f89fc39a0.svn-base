<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js'></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>


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
</script>

<!-- checkBox All -->
<script type="text/javascript"> 

	$(function(){ //전체선택 체크박스 클릭 
		$("#allCheck").click(function(){ 
			//만약 전체 선택 체크박스가 체크된상태일경우 
			if($("#allCheck").prop("checked")) { 
				//해당화면에 전체 checkbox들을 체크해준다
				$("input[type=checkbox]").prop("checked",true); 
				// 전체선택 체크박스가 해제된 경우 
			} else { 
				//해당화면에 모든 checkbox들의 체크를해제시킨다. 
				$("input[type=checkbox]").prop("checked",false); 
			} 
		}) 
	}) 
		
	
</script>

<!-- check data -->
<script>
			
	var orderList = new Array();
	// var fabric_seq = $('table tr').eq(i).find('input[type="text"]').val();

	// $("input:checkbox[name='aaaa']:checked").val()
	function checkedBox(){
		
	    $("input[name=cartCheckBox]:checked").each(function(){    
			var count = $(this).val();

			<c:forEach var="tempList" items="${cartList}">
				var json = new Object();
				json.userId = "${tempList.userId}";
				json.pSeq = "${tempList.pSeq}";
				json.pName = "${tempList.pName}";
				json.filelocation = "${tempList.filelocation}";
				json.pOption = "${tempList.pOption}";
				json.optionPrice = "${tempList.optionPrice}";
				json.cnt = "${tempList.cnt}";
				json.carState = "${tempList.carState}";
				
				if(count==json.cnt)				
					orderList.push(json);
			</c:forEach>
			
		});
	}
</script>


<!-- order click -->

<script>

	function selectOrder(){
		
		dataSubmit();
	}
	
	function allOrder(){
		$("input[type=checkbox]").prop("checked",true);
		dataSubmit();
	}
	
	function dataSubmit(){
		checkedBox();
		var submitData = JSON.stringify(orderList);
		
		$.ajax({
			type: "POST",
	        url: "purchaseClick.do",
	        contentType: "application/json; charset=utf-8",
	        datatype: JSON,
	        data: submitData,
	        traditional: true,
	        
            success : function(data) {
                if (data == 'false') {  
                	//window.open("login.do", "loginPopup",
			 	//"width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
					alert("asdf");
                
                } else {
                    
                }
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
	}
</script>
<%@ include file="nav.jsp"%>
<body>
	<form id="cartForm" name="cartForm">
		<table id = "cartTable" name ="cartTable"
			width="1000" border="1" cellpadding="0" cellspacing="0"
			align="center">
	
			<tr>
				<th align="center" width="3"><input type="checkbox"
					name="allCheck" id="allCheck"></th>
				<th style="font-family: Gulim; font-size: 12px;">상품정보</th>
				<th style="font-family: Gulim; font-size: 12px;">수량</th>
				<th style="font-family: Gulim; font-size: 12px;">금액</th>
				<th style="font-family: Gulim; font-size: 12px;">배송비</th>
				<th style="font-family: Gulim; font-size: 12px;">주문</th>
			</tr>
	
			<tbody>
				<c:forEach var="cartList" items="${cartList}" varStatus="status">
					<tr>
						<td align="center" width="3">
						<input type="checkbox" name = "cartCheckBox" id="cartCheckBox" value=${status.count }>
						</td>
						<td width="70" style="font-family: Gulim; font-size: 12px;">
							<img src="${cartList.filelocation}" width="50" height="50"> 
							<br>
								<a href="detail.do?seq=${cartList.pSeq}">${cartList.pName}</a> 
							<br>
							선택한 옵션 : 
							<span id="pOption" name="pOption">${cartList.pOption}</span>
						</td>
	
						<td align="center" width="30"
							style="font-family: Gulim; font-size: 12px;">
							<span id="cnt" name="cnt">${cartList.cnt}</span>
						</td>
	
	
						<td align="center" width="30"
							style="font-family: Gulim; font-size: 12px;">
							<span id="optionPrice" name="optionPrice">
								<fmt:formatNumber value="${cartList.optionPrice}" 
									pattern="#,###" />원
							</span>
						</td>
						
						<td align="center" width="30"
							style="font-family: Gulim; font-size: 12px;">
							<span id="cartState" name="cartState">
								${cartList.cartState}
							</span>
						</td>
	
						<td align="center" width="30"
							style="font-family: Gulim; font-size: 12px;">
							<span id="cartState" name="cartState">
								${cartList.cartState}
							</span>
						</td>
	
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
	
		<div>
			<label> 주문금액 : </label>
				<input type="text" name="totalPrice" id="totalPrice" value = 0
					readonly="readonly">
			<br>
			<br>
			
		</div>
		
			<input type="button" value="선택 구매하기"
				style="font-family: Gulim; font-size: 12px;"
				onclick="selectOrder();">
		
			<input type="button" value="전체 구매하기"
				style="font-family: Gulim; font-size: 12px;"
				onclick="allOrder();">
		
			<input type="button" value="목록"
				style="font-family: Gulim; font-size: 12px;"
				onclick="goList();">
	</form>		
</body>
</html>