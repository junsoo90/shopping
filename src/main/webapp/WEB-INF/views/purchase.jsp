<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js'></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/purchase.css">
</head>

<!-- goList -->
<script>
	function goList(){
		document.location.href="productList.do";
	}
</script>


<!-- delRequest chageSelect() -->
<script>

	function reqeustChageSelect(){
	
		var selectCnt = $('#reqeustSelectBox').val();
		
		
		if(selectCnt == 0){
			alert("배송시 요청사항을 선택해 주세요");
			return false;
		}
		if(selectCnt == 6){
			document.getElementById("delRequestMsg").value = "";
			$('#delRequestText').show();
		}
		
		else{
			var target = document.getElementById("reqeustSelectBox");
			var text = target.options[target.selectedIndex].text;
			document.getElementById("delRequestMsg").value = text;
			
			$('#delRequestText').hide();
		}
	}
	
</script>

<!-- radio -->
<script>

	function payTypeChange(){
		jQuery('.payTypeContent .payBox').hide();
		
		var radioVal = $('input[name="payType"]:checked').val();
	  
	  	var showBox = "." + radioVal + "Box";
	  	
	  	jQuery(showBox).show();
	    
	    //.bankBox, .cardBox 
	}

</script>


<!-- validCheck -->
<script>
	
	function validCheck(){
		var blank_pattern = /\s | /gi ;
		var delRequestMsg = $('#delRequestMsg').val();
		
		if($('#reqeustSelectBox').val() == 0){
			alert("배송시 요청사항을 선택해 주세요");
			return false;
		}
		
		if( $('#delRequestMsg').val() == null || $('#delRequestMsg').val() == ""){
			alert("요청사항을 입력해주세요");
			return false;
		}
		
		var bankNum = $('#bankNum').val();
		if( $("input:radio[name=payType]:checked").val() != undefined) {
			
			if($("input:radio[name=payType]:checked").val() == 'bank'){
				if( bankNum == null || $('#bankNum').val() == ""
						|| bankNum == undefined){
					alert("계좌번호를 입력해주세요");
					return false;
				}
				
				var pattern = /^[0-9]*$/
				
			    if (!pattern.test(bankNum)) {
			    	alert("계좌번호는 숫자만 입력할 수 있습니다");
			    	 $('#bankNum').val(bankNum.replace(pattern,''));
			    	return false;
			    }
				
				if(!fnChkByte(bankNum, 30, "계좌번호")){
			    	  return false;
				 }
			}
		}
		else{
			alert("결제 방식을 선택해 주세요");
			return false;
		}
		
		if (delRequestMsg.replace(blank_pattern, '') == "") {
			alert("요청사항에 공백을 사용할 수 없습니다 ");
			return false;
		}
		
		 if(!fnChkByte(delRequestMsg, 200, "요청사항"))
	    	  return false;
		 
		
		 if(!stockCheck())
			 return false;
	}
	
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
  			if(cvalue == '계좌번호'){
  				alert("계좌번호 은(는) 숫자 " + (maxByte / 2)
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



<!-- Stock Check -->
<script>
	function stockCheck(){
		var purchaseList = new Array();
		<c:forEach var="tempList" items="${sessionScope.purchaseList}">
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
			
			purchaseList.push(json);
		</c:forEach>
		
		var submitData = JSON.stringify(purchaseList);
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

<style>
	.payTypeContent .payBox, #delRequestText{ display: none; }
	
</style>


<body>
	<div class="nav-div">
		<%@ include file = "nav.jsp" %>
	</div>
	
	<div class="form-div">
	
		<form id="purchaseForm" name="purchaseForm" action="orderPay.do">
			
			<!-- 주문내역 -->
			<div class="orderList-div">
				
				<table id = "purchaseTable" name ="purchaseTable">
					<tr class="table-nav-tr">
						<th class="product-th">상품정보</th>
						<th class="cnt-th">수량</th>
						<th class="price-th">금액</th>
						<th class="delivery-th">배송비</th>
					</tr>
				
					<tbody>
						<c:forEach var="purchaseList" items="${sessionScope.purchaseList}" varStatus="status" >
					
							<tr class="product-info-tr">
							
								<td class="product-info-td">
									<div class="product-info-div">
										<div class="product-image">
											<img src="/admin/upload/${purchaseList.savefilename}" width="50" height="50">
										</div>
										
										<div class="product-select-option">
											<div class="product-pName">
												<a href="detail.do?seq=${purchaseList.pSeq}">${purchaseList.pName}</a> 
											</div>
											
											<div class="product-option">
												선택한 옵션 : 
												<span id="pOption" name="pOption">${purchaseList.pOption}</span>
											</div>
										
											<div class="product-price">
												가격 : 
												<span id="optionPrice" name="optionPrice">
													<fmt:formatNumber value="${purchaseList.optionPrice}" 
														pattern="#,###" />원
												</span>
											</div>
										</div>
									</div>
									
								</td>
			
									
								<td class="product-cnt">
									<div>
										<span id="cnt" name="cnt">${purchaseList.optionCnt}</span>
									</div>
								</td>
			
			
								<td class="product-option-price">
									<span id="optionPrice" name="optionPrice">
										<fmt:formatNumber value="${purchaseList.optionPrice * purchaseList.optionCnt}" 
											pattern="#,###" />원
									</span>
								</td>
								
								<c:if test="${status.first==true}">
									<td rowspan="${purchaseListSize }" class="product-delivery-price">
										<span id="deliveryCharge " name="deliveryCharge">
											<fmt:formatNumber value="${deliveryCharge}" 
												pattern="#,###" />원
										</span>
									</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
			<!-- 주문금액 -->
			<div class="orderPrice-div">
				<div class="orderPrice-price-div">
					<span class="text-orderPrice"> 주문금액 : </span> 
					
					<span class="text-orderPrice" id="totalPrice" name="totalPrice">
						<fmt:formatNumber value="${orderPrice}" 
							pattern="#,###" />원
					</span>
				</div>
				
				<div class="orderPrice-price-operation-div">
					<span class="text-orderPrice">+ </span>
				</div>
				
				<div class="orderPrice-price-div">
					<span class="text-orderPrice"> 배송비 : </span>
					
					<span class="text-orderPrice" id="totalPrice" name="totalPrice">
						<fmt:formatNumber value="${deliveryCharge }" 
							pattern="#,###" />원
					</span>
				</div>
				
				<div class="orderPrice-price-operation-div">
					<span class="text-orderPrice" > = </span>
				</div>
				
				<div class="orderPrice-price-div">						
					<span class="text-orderPrice" > 결제금액 : </span>
					
					<span class="text-orderPrice" id="totalPrice" name="totalPrice">
						<fmt:formatNumber value="${sessionScope.totalPrice}" 
							pattern="#,###" />원
					</span>
				</div>
			</div>
			
			
			<!-- 배송지 -->
			<div class="orderDelivery-div" >
				<div class="delivery-main-div">
					<p> 배송지 </p>
				</div>
				
				<div class="delivert-info-div">
					<table class="delivery-info-table" id="delivery-info-table">
						<tr>
							<td class="table-td-1"> 이름 </td>
							<td class="table-td-2"><span> ${custom.cName } </span> </td>
						</tr>
						
						<tr>	
							<td class="table-td-1"> 배송주소 </td>
							<td class="table-td-2">
								<span> ${custom.cAddCode } </span> <br>
								<span> ${custom.cAdd } </span> <br>
								<span> ${custom.cAddDetail } </span> 
							</td>
						</tr>
						
						<tr>
							<td class="table-td-1"> 연락처 </td>
							
							<td class="table-td-2">
								<span>${custom.cPhone1 } - ${custom.cPhone2 } - ${custom.cPhone3 }</span>
							 </td>
						</tr>
						
						<tr>
							<td class="table-td-1"> 요청사항 </td>
							
							<td class="table-td-2"> 
								<select name="reqeustSelectBox" id="reqeustSelectBox"
									class="reqeustSelect" onchange="reqeustChageSelect()">
										<option value="0"><span class="requestMsg1"> 요청사항을 입력해주세요</span></option>
										<option value="1"><span class="requestMsg1"> 배송 전 연락 부탁 드립니다</span></option>
										<option value="2"><span class="requestMsg2"> 파손위험이 있는 상품이니 조심히 다뤄주세요 </span>
										<option value="3"><span class="requestMsg3"> 부재시 경비실에 맡겨주세요</span>	
										<option value="4"><span class="requestMsg4"> 문앞에 놓아 주세요</span>	</option>	
										<option value="5"><span class="requestMsg5"> 부재시 핸드폰으로 연락주세요</span></option>	
										<option value="6"><span class="requestMsg6"> 직접입력</span></option>
								</select>
								
								<div id="delRequest" name = "delRequest">
									
									<div id="delRequestText" name="delRequestText">
										<input type='text' id='delRequestMsg' name='delRequestMsg'>
									</div>
								</div>
							
							</td>
						</tr>
					</table>
				</div>
			</div>
			
		
			<!-- 결제정보 -->
			<div class="order-pay-div">
				<p>결제정보</p>
					<table class="order-pay-table" id="order-pay-table">
						<tr> 
							<td class="table-td-1">총 가격</td>
							<td class="table-td-2">
								<span id="totalPrice" name="totalPrice">
									<fmt:formatNumber value="${sessionScope.totalPrice}" 
										pattern="#,###" />원
								</span>
							</td>
							
						</tr>
						<tr>
							<td class="table-td-1">결제방법</td>
							<td class="table-td-2">
								<div id="payTypeList" name="payTypeList">
									<ul>
										<li>
											<input class="type-selector-radio" 
												type="radio" name="payType" id="payTypeCard" value="card" onchange="payTypeChange()">
												<span> 카드결제 </span>
										</li>
										
										<li>
											<input class="type-selector-radio" 
												type="radio" name="payType" id="payTypeBank" value="bank" onchange="payTypeChange()">
												<span> 계좌이체 </span>
										</li>
									</ul>
								</div>
								
								<div class ="payTypeContent" id="payTypeContent" name="payTypeContent">
								
									<!-- 신용카드결제 -->
									<div class="cardBox payBox" id="cardBox">
										<select name="payTypeCardSelectBox" id="payTypeCardSelectBox"
											class="cardSelect" onchange="chageCard()">
										
											<option value="삼성카드"> 삼성카드 </option>
											<option value="신한카드"> 신한카드  </option>	
											<option value="우리카드"> 우리카드  </option>	
											<option value="BC카드"> BC카드  </option>	
											<option value="국민카드">  KB국민카드  </option>
										
										</select>	
									</div>
								
									<!-- 계좌이체 -->
									<div class="bankBox payBox" id="bankBox">
										<select name="payTypeBankSelectBox" id="payTypeBankSelectBox"
												class="bankSelect" onchange="chageBank()">
											
											<option value="kbBank"> <span> 국민은행 </span> </option>
											<option value="shinhanBank"> <span> 신한은행 </span> </option>	
											<option value="wooriBank"> <span> 우리은행 </span> </option>	
											<option value="ibkBank"> <span> 기업은행 </span> </option>
											
										</select>
										<div>
											<span> 계좌번호 입력 </span> 
											<input type="text" id="bankNum" 
												name="bankNum" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
										</div>
										
									</div>
								
								</div>
								
							</td>
						</tr>
						
					</table>
			
			</div>
			
			<!-- 버튼 -->
			<div class="btn-bottom-div">
				<input type="submit" value="결제하기"
					onclick="return validCheck();">
			
			
				<input type="button" value="목록"
					onclick="goList();">
			</div>
		
		</form>		
	</div>
</body>
</html>