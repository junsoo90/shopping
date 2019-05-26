<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page import="java.util.*" %>
<%@ page import="com.custom.VO.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js'></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>


<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/cart.css">
</head>


<!-- goList -->
<script>

	function goList(){
		document.location.href="productList.do";
	}
</script>



<!-- checkBox All -->
<script type="text/javascript"> 

	function allCheckClick(){ 
		
			//만약 전체 선택 체크박스가 체크된상태일경우 
			if($("#allCheck").prop("checked")) { 
				//해당화면에 전체 checkbox들을 체크해준다
				$("input[type=checkbox]").prop("checked",true); 
				// 전체선택 체크박스가 해제된 경우
				
				var optionPriceId;
				totalPrice = 0;
				$("input:checkbox[name='cartCheckBox']:checked").each(function(){    
					var cartCnt = $(this).val();
					var cartId = "#opcnt" + cartCnt;
					var cnt = Number($(cartId).val());
					
					<c:forEach var="tempList" items="${cartList}">
					
						if(cartCnt == "${tempList.cartCnt}"){	
							var price = Number("${tempList.optionPrice}") * cnt;
							
							if(!totlaPriceConvert(price,"plus")){
								$("input[type=checkbox]").prop("checked",false); 
								document.getElementById('totalPrice').value = 0;
								totalPrice = 0;
								return false;
							}
						}
												
					</c:forEach>
				});
				
				
				
			} else { 
				//해당화면에 모든 checkbox들의 체크를해제시킨다. 
				
				$("input[type=checkbox]").prop("checked",false); 
				document.getElementById('totalPrice').value = 0;
				totalPrice = 0;
			} 
	}
		
	
</script>

<!-- cartDelete -->
<script>

	function cartDelete(){
	
		if(!checkedBoxComfirm())
			return false;
		var submitData = JSON.stringify(checkedList);
		$("input:checkbox[name='cartCheckBox']:checked").each(function(){    
			var cartCnt = Number($(this).val());
			var deleteTableTr = "#tr_" + cartCnt;	
			
			var optionPrice;
			var optionCnt;
			
			
			for(var i=0; i<checkedList.length; i++){
				if(checkedList[i].cartCnt == cartCnt){
					optionPrice = checkedList[i].optionPrice;
					optionCnt = checkedList[i].optionCnt;		
					break;
				}
			}
			
			var price = optionPrice * optionCnt;
			if(!totlaPriceConvert(price, "minus"))
				return false;
			
			
			$(deleteTableTr).remove();
			
		});
		
		$.ajax({
			type: "POST",
	        url: "cartDelete.do",
	        contentType: "application/json; charset=utf-8",
	        datatype: JSON,
	        data: submitData,
	        traditional: true,
	        
            success : function(data) {
                if (data == 'false') {  
                	
                } 
                else {
                }
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
		
	}
	
</script>

<!-- check Box-->
<script>
			
	var checkedList;
	// var fabric_seq = $('table tr').eq(i).find('input[type="text"]').val();

	// $("input:checkbox[name='aaaa']:checked").val()
	//$("input:checkbox[name='cartCheckBox']:checked")
	//$("input:text[numberOnly]")
	
	function checkedBoxComfirm(){
		checkedList = new Array();
		var tempTotalPrice = 0;
		var tempBol = true;
		
	    $("input:checkbox[name='cartCheckBox']:checked").each(function(){    
			var cartCnt = $(this).val();
			
			
			<c:forEach var="tempList" items="${cartList}">
				var json = new Object();
				
				var cartId = "#opcnt" + "${tempList.cartCnt}";
				var optionCnt = Number($(cartId).val());
				
				json.userId = "${tempList.userId}";
				json.pSeq = Number("${tempList.pSeq}");
				json.pName = "${tempList.pName}";
				
				json.savefilename = "${tempList.savefilename}";
				json.pOption = "${tempList.pOption}";
				json.optionPrice = Number("${tempList.optionPrice}");
				
				json.optionCnt = optionCnt;
				json.cartCnt = Number("${tempList.cartCnt}");
				json.deliveryCharge = Number($("#deliveryCharge").val());
				
				
				
				if(cartCnt == json.cartCnt)	{	
					//alert("cartCnt = " + cartCnt + " ,  json.cartCnt = " + json.cartCnt);
					
					tempTotalPrice += Number(optionCnt) * Number("${tempList.optionPrice}");
					if(tempTotalPrice > 2147483647){
						alert("구매 금액은 2,147,483,647원을 초과할 수 없습니다");
						tempBol = false;
						return tempBol;
					}
					checkedList.push(json);
	    		}
				
			</c:forEach>
		});
	    
	    return tempBol;
	}
	
	function checkBoxClick(cartCnt, optionPrice){

		var checkBoxVal = "#cartCheckBox" + cartCnt;
		
		var optionCntId = "#opcnt" + cartCnt;
		
		var optionCntVal = $(optionCntId).val();
		
		var price = Number(optionPrice) * Number(optionCntVal);
		
		// 체크박스가 체크되어 있을 때 체크 해제할 경우
		if($(checkBoxVal).prop("checked") == false){
			if(!totlaPriceConvert(price, "minus"))
				return false;
		}
		
		// 체크박스가 체크 되어 있지 않을 때 체크 할 경우
		else{
		
			var bol = totlaPriceConvert(price, "plus");
			if(!bol){
				var checkId = "cartCheckBox" + cartCnt;
				var checkConfrim = "input[id="+checkId+"]:checked";
				$(checkConfrim).prop("checked",false);
				return false;
			}
			
		}
		
		var allCheckCnt = $("input[name=cartCheckBox]").length;
		var checkCnt = $('input[name=cartCheckBox]:checked').length;
		
		if(allCheckCnt == checkCnt)
			$("#allCheck").prop("checked", true);
		else
			$("#allCheck").prop("checked", false);
		

	}
	
	function totlaPriceConvert(price, op){
		
		if(op == "minus")
			totalPrice = totalPrice - price;
		else if(op == "plus")
			totalPrice = totalPrice + price;
		
		if(totalPrice > 2147483647){
			alert("구매 금액은 2,147,483,647원을 초과할 수 없습니다");
			totalPrice = totalPrice - price;
			return false;
		}
		
		document.getElementById('totalPrice').value = addComma(totalPrice);
		return true;
	}
	
</script>


<!-- plus minus -->
<script>
	
	var totalPrice = 0;

	function minusClick(cartCnt, optionPrice){
		
		if(!checkedBoxComfirm())
			return false;
		
		var cartId = "opcnt" + cartCnt;
		var cnt = Number( $("#"+cartId).val() );
		
		if(cnt <= 1){
			alert("최소 1개를 선택해야 합니다");
			return false;
		}
		
		document.getElementById(cartId).value = cnt - 1;
		
		var checkBoxVal = "#cartCheckBox" + cartCnt;
		
		if($(checkBoxVal).prop("checked") == true){
			if(!totlaPriceConvert(Number(optionPrice), "minus"))
				return false;
		}
		return false;
		
	}
	
	function plusClick(cartCnt, optionStock, optionPrice){
		if(!checkedBoxComfirm())
			return false;
		
		var cartId = "opcnt" + cartCnt;
		var cnt = Number($("#"+cartId).val());
		
		if(cnt >= optionStock){
			alert("남은 재고는 " + optionStock + "개 입니다");
			return false;
		}
		
		var checkBoxVal = "#cartCheckBox" + cartCnt;
		
		if($(checkBoxVal).prop("checked") == true){
			if(!totlaPriceConvert(Number(optionPrice), "plus")){
				
				return false;
			}
			
		}
		document.getElementById(cartId).value = cnt + 1;
		
		return false;
	}
	
</script>


<!-- order click -->
<script>

	function selectOrder(){
		
		dataSubmit();
	}
	
	function allOrder(){
	
		$("input[type=checkbox]").prop("checked",true);
		if(!dataSubmit()){
			$("input[type=checkbox]").prop("checked",false);
			document.getElementById('totalPrice').value = 0;
			totalPrice = 0;
			return false;
		}
		
	}
	function dataSubmit(){
		if( !checkedBoxComfirm() )
			return false;
		
		
		if(checkedList <= 0){
			alert("구매하실 물품이 없습니다");
			return false;	
		}
		
		if(!stockCheck())
			return false;
		
		var submitData = JSON.stringify(checkedList);
		
		$.ajax({
			type: "POST",
	        url: "purchaseClick.do",
	        contentType: "application/json; charset=utf-8",
	        datatype: JSON,
	        data: submitData,
	        async:false,
	        
            success : function(data) {
                if (data == 'false') {  
                	//window.open("login.do", "loginPopup",
			 	//"width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
					alert("false");
                
                } else {
                	location.href = "purchase.do";
                	//$('#cartForm').submit();
                }
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
		
	}
</script>


<!-- Stock Check -->
<script>
	function stockCheck(){
		if(!checkedBoxComfirm())
			return false;
		
		var submitData = JSON.stringify(checkedList);
		var bol = true;
		$.ajax({
			type: "POST",
	        url: "stockCheck.do",
	        contentType: "application/json; charset=utf-8",
	        datatype: JSON,
	        data: submitData,
	        async:false,
	        
            success : function(mav) {
          
            	if(!mav.result){
            		alert(mav.msg);
            		bol = false;
            		return false;
            	}
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
		return bol;
	}
</script>


<!-- comma -->
<script>
	function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}
</script>


<body>
	<div class="nav-div">
		<%@ include file = "nav.jsp" %>
	</div>
	
	<div class="form-div">
		<form id="cartForm" name="cartForm" action="/purchase.do">
			<div class="cartTable-div">
				<table id = "cartTable" name ="cartTable">
					<tr class="table-nav-tr">
						<th class="checkbox-th">
							<input type="checkbox"
								name="allCheck" id="allCheck" onclick="allCheckClick()"></th>
						<th class="product-th">상품정보</th>
						<th class="cnt-th">수량</th>
						<th class="price-th">금액</th>
						<th class="delivery-th">배송비</th>
					</tr>
					
					<tbody>
						<c:forEach var="cartList" items="${cartList}" >
							<tr class="product-info-tr" id="tr_${cartList.cartCnt}" name="tr_${cartList.cartCnt}">
								<td class="product-checkbox-td">
									<input type="checkbox" class = "cartCheckBox" name = "cartCheckBox" 
										id="cartCheckBox${cartList.cartCnt}" value="${cartList.cartCnt}" 
										onclick="checkBoxClick(${cartList.cartCnt},${cartList.optionPrice})">
								</td>
								
								<td class="product-info-td">
									<div class="product-info-div">
										<div class="product-image">
											<img src="/admin/upload/${cartList.savefilename}" width="50" height="50"> 
										</div>
										
										<div class="product-select-option">
											<div class="product-pName">
												<a href="detail.do?seq=${cartList.pSeq}">${cartList.pName}</a> 
											</div>
											<div class="product-option">
												선택한 옵션 : 
												<span id="pOption" name="pOption">${cartList.pOption}</span>
											</div>
											
											<div class="product-price">
												가격 : 
												<span id="optionPrice" name="optionPrice">
													<fmt:formatNumber value="${cartList.optionPrice}" 
														pattern="#,###" />원
												</span>
											</div>
										</div>
										
									</div>
								</td>
			
								<td class="product-cnt">
									<div>
										<input type="button" name="btnMinus${cartList.cartCnt}" id="btnMinus${cartList.cartCnt}" 
											value = "-" onclick="minusClick('${cartList.cartCnt}', '${cartList.optionPrice}');"/>
									
										<input type="text" class = "optionData" id="opcnt${cartList.cartCnt}" name="opcnt${cartList.cartCnt}" 
											value="${cartList.optionCnt}" size=1 readonly="readonly"/>
										
										<input type="button" 
											value = "+" onclick="plusClick('${cartList.cartCnt}', '${cartList.optionStock}', '${cartList.optionPrice}');"/>
									</div>	
								</td>
			
				
			
								<td class="product-option-price">
									<div>
										<span id="optionPrice" name="optionPrice">
											<fmt:formatNumber value="${cartList.optionPrice * cartList.optionCnt}" 
												pattern="#,###" />원
										</span>
									</div>
								</td>
								
								<td class="product-delivery-price">
									<div>
										<span id="deliveryCharge-span" name="deliveryCharge-span">
											<fmt:formatNumber value="${cartList.deliveryCharge}" 
												pattern="#,###" />원
											<input type="hidden" id = "deliveryCharge" name="deliveryCharge" 
												value="${cartList.deliveryCharge}" />
										</span>
									</div>
								</td>
							</tr>
							
						</c:forEach>
						<c:if test="${count==0}">
						<tr>
							<td colspan="5" align="center">장바구니 내역이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
					
				
				
				</table>
				
				<div class="cartdelete-btn-div">
					<input type="button" class="btn" value="선택품목 삭제"
							onclick="cartDelete();">
				</div>
			</div>
			
			<div class="totalPrice">
				<span id="totalPruce"> 주문금액 : </span>
				 	<input type="text" name="totalPrice"  id="totalPrice" value=""
						readonly="readonly">
			</div>
						
			<div class="btn-bottom-div">
				<input type="button" class="btn btn-bottom" value="선택 구매하기"
					onclick="return selectOrder();">
			
				<input type="button" class="btn btn-bottom" value="전체 구매하기"
					onclick="return allOrder();">
			
				<input type="button" class="btn btn-bottom" value="목록"
					onclick="goList();">
			</div>					
		</form>		

	</div>
</body>
</html>