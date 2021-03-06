<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js'></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>


<html>
<head>

<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/productDetail.css">
</head>

<!-- option add -->
<script>
	var totalPrice = Number(0);
	var optionCount = 0;
	var stock = parseInt(document.getElementById('pStock').value);
	
	var insertOptionList;

	function chageSelect() {
		
		var selectCnt = $('#selectBox').val();
		var savefilename = $('#location').val();
		
		//alert('${vo.savefilename}');
		$('#selectBox').val("-1").prop("selected", true);
		
		optionCount++;
		
		if(insertOptionList == null || insertOptionList == ''){
			insertOptionList= new Array();
		}
		
		var list = new Array();
		<c:forEach var="optionlist" items="${optionlist}">
			var json2 = new Object();
			json2.pSeq = "${vo.pSeq}";
			json2.pName = "${vo.pName}";
			json2.pOption = "${optionlist.pOption}";
			json2.savefilename = '${vo.savefilename}';
			json2.savefilename = "${vo.savefilename}";
			json2.optionCnt = 1;
			json2.optionCount = optionCount;
			json2.optionPrice = "${optionlist.optionPrice}";
			json2.optionStock = "${optionlist.optionStock}";
			json2.deliveryCharge = $("#deliveryCharge").val();
			list.push(json2);
			
		</c:forEach>
		
		var select = list[selectCnt];
		if(list[selectCnt].optionStock <= 0){
			alert("매진한 상품입니다. 다른 옵션을 선택해 주세요");
			return false;
		}
			
		for( var i=0; i<insertOptionList.length; i++){
			if( insertOptionList[i].pOption == select.pOption ){
				alert("이미 선택한 옵션입니다");
				optionCount--;
				return false;
			}
				
		}
		totalPrice = totalPrice + Number(list[selectCnt].optionPrice);
		
		if(totalPrice > 2147483647){
			alert("구매 금액은 2,147,483,647원을 초과할 수 없습니다");
			return false;
		}
		
		insertOptionList.push(list[selectCnt]);	
		
		
		insertOption(list[selectCnt]);
		
	}
	
	function insertOption(select){
		
	    var source = $("#optionTemplate").html();
	    var template = Handlebars.compile(source);
	    var data  = [
	    	{
	    		pSeq:select.pSeq,
				pName:select.pName,
				pOption:select.pOption,
				optionCnt:select.optionCnt,
		    	optionCount:select.optionCount,
		    	optionStock:addComma(select.optionStock),
		    	optionPrice:addComma(select.optionPrice),
		    	savefilename:select.savefilename
	    	}
	    ];
	    
	 
	    //if(insertOptionList.length == 1 && totalPrice < 50000)
	    	//totalPrice += Number($("#deliveryCharge").val());
	    
		document.getElementById('totalPrice').value = addComma(totalPrice);
		
		
	    $("#ulSelectList").append(template(data));
	    
	}
	

</script>


<!-- plus minus -->
<script>
	function minusClick(input, optionCount){
		var index = Number( findIndex(input) );
		input = "opcnt" + input;
		//var btnPlus = "btnMinus"+ pOption;
		
		if(insertOptionList[index].optionCnt == 1){
			alert("수량은 최소 1개 입니다;");
			return false;
		}
		
		insertOptionList[index].optionCnt--;
		document.getElementById(input).value = insertOptionList[index].optionCnt;
		
		
		totalPrice = totalPrice - Number(insertOptionList[index].optionPrice);
		
		document.getElementById('totalPrice').value = addComma(totalPrice);
		return false;
		
	}
	
	function plusClick(input, optionCount, optionStock){
		var index = Number( findIndex(input) );
		input = "opcnt" + input;
	
		//var btnPlus = "btnPlus"+ pOption;
		
		totalPrice = totalPrice + Number(insertOptionList[index].optionPrice);
	
		if(insertOptionList[index].optionCnt >= optionStock){
			alert("남은 재고는 " + optionStock + "개 입니다");
			return false;
		}
		
		if(totalPrice > 2147483647){
			alert("구매 금액은 2,147,483,647원을 초과할 수 없습니다");
			totalPrice = totalPrice - Number(insertOptionList[index].optionPrice);
			return false;
		}
		
		insertOptionList[index].optionCnt++;
		
		document.getElementById(input).value =  Number(insertOptionList[index].optionCnt);
		
		
		document.getElementById('totalPrice').value = addComma(totalPrice);
		
		return false;
	}
	
	function deleteOption(input, optionCount){
		
		var index = Number( findIndex(input) );
		var deleteOption = "#oplist_" + input;
		
		var price = insertOptionList[index].optionPrice;
		var cnt = insertOptionList[index].optionCnt;
		//alert(optionCount + " , " + deleteOption + " , " + price + " , " + cnt);
		
		$(deleteOption).remove();

		for(var i=index; i<insertOptionList.length-1; i++){
			insertOptionList[i] = insertOptionList[i+1];
		}
		insertOptionList.pop();
		//alert("totalPrice = " + totalPrice);
		
		totalPrice = totalPrice - price * cnt;
		//alert("totalPrice = " + totalPrice);
		
		//if(insertOptionList.length == 0)
	    	//totalPrice -= Number($("#deliveryCharge").val());
	    
		document.getElementById('totalPrice').value = addComma(totalPrice);
		return false;
	}
	
	function findIndex(input){
		
		for(var i=0; i<insertOptionList.length; i++){
			if(insertOptionList[i].pOption == input)
				return i;
		}	
		return -1;
	}
	
</script>


<!-- cartClick / purchaseClick -->
<script>

	var form = document.detailform;

	function check(){
		if(insertOptionList == null || optionCount <= 0
				|| insertOptionList.length <= 0){
			alert("옵션을 선택해 주세요");
			return false;
		}
		var session = "<%=session.getAttribute("custom") %>";
		
		if(session == 'null' || session == null)
			alert("로그인이 필요합니다.");
		return ;
	}
	
	function cartClick(){
		if(!stockCheck())
			return false;
		
		var bol = check();
		if( bol == false )
			return false;
	
		var submitData = JSON.stringify(insertOptionList);
		
		$.ajax({
			type: "POST",
	        url: "cartInCheck.do",
	        datatype: JSON,
	        contentType: "application/json; charset=utf-8",
	        data: submitData,
	        async:false,
            success : function(data) {
                if (data == 'false') {  
                	//window.open("login.do", "loginPopup",
			 	//"width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
                	location.href = "login.do";
                } 
                else if(data == 'exist'){
                	alert("이미 장바구니에 있는 제품을 선택하셨습니다. 확인 부탁드립니다.");
                	return false;
                } 
                
                else {
                	location.href = "cartIn.do";
                }
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
	}
	
	function puchaseClick(){
	
		if(!stockCheck()){
			return false;
		}
		var bol = check();
		if( bol == false)
			return false;
		var submitData = JSON.stringify(insertOptionList);

		$.ajax({
	        type: "POST",
	        url: "purchaseCheck.do",
	        datatype: JSON,
	        contentType: "application/json; charset=utf-8",
	        data: submitData,
	        async:false,
	        success : function(data) {
	        	
            	if (data == 'false') {   
            		location.href = "login.do";
            		
            	} 
            	else {
            		location.href = "purchaseClick.do";
            		//$('#detailform').submit();
	         	} 
             },
             error:function(request,status,error){
                 alert("message:"+request.responseText+"\n"+"error:"+error);
              }
	    });
	}
	
</script>



<!-- Stock Check -->
<script>
	function stockCheck(){
		var submitData = JSON.stringify(insertOptionList);
	
		var bol = true;
		$.ajax({
			type: "POST",
	        url: "stockCheck.do",
	        contentType: "application/json; charset=utf-8",
	        datatype: JSON,
	        async:false,
	        data: submitData,
	        
	        
            success : function(mav) {
            	if(!mav.result){
            		alert(mav.msg);
            		bol = false;
            	}
            },
            error:function(status,error){
                alert("message:"+request.responseText+"\n"+"error:"+error);
             }
        });
		return bol;
	}
</script>

<!-- goList -->
<script>
	function goList(){
		var keyWord = "${sessionScope.keyWord}";
		document.location.href="productList.do?pageNum=" + "${sessionScope.pageNum}"
				+ "&keyWord="+ encodeURI(encodeURIComponent(keyWord));
	}
</script>



<!-- comma -->
<script>
	function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}
</script>

<!-- imageChange -->
<script>
	function imageChange(savefilename){
		var src = "/admin/upload/"+savefilename;
		$(".main-image").attr("src", src);
		
	}
	
</script>



<body>
	<div class="nav-div">	
		<%@ include file = "nav.jsp" %>
	</div>
	
	<div class="form-div">
		<form name = "detailform">

			<div class="product-option">
				<div class="image-div">
					<div class="main-image-div">
						<img class="main-image" src="/admin/upload/${vo.savefilename}" 
							width="600px" height="400px">
					</div>
					<div class="sub-image-div">
						<c:forEach var="photolist" items="${photolist}" varStatus="i">
							<img class="sub-image" src="/admin/upload/${photolist.savefilename}" 
							onclick="imageChange('${photolist.savefilename}');">
						</c:forEach>
					</div> 
				</div>
				
				<div class="product-option-div">
					
					<div class="pName-div">
						<span class="product-name">${vo.pName }</span>
						<input type="hidden" name="pName" id="pName" value="${vo.pName }"
							readonly="readonly">
					</div>
					
					<div class="pPrice-div">
						<span class="sale_price">
							<fmt:formatNumber value="${vo.pPrice}" pattern="#,###"/>원 
						</span>
						<input type="hidden" name="pPrice" id="pPrice" value="${vo.pPrice }"
							readonly="readonly">
						<br>
					</div>
					
					<div class="pOption-div">
						<select name="selectBox" id="selectBox"
							class="selectBox" onchange="chageSelect()">
							<option class="option" value=-1>옵션을 선택하세요</option>
							<c:forEach var="list" items="${optionlist}" varStatus="i">
								
								<option class="option" value="${list.optionCnt-1}">
									
									<em> 옵션 : ${list.pOption}</em>
									<em> 가격 : <fmt:formatNumber value="${list.optionPrice}" pattern="#,###"/>원</em>
									<em> 수량 : <fmt:formatNumber value="${list.optionStock}" pattern="#,###"/>개</em>
									<c:if test="${list.optionStock <= 0}">
										[매진]
									</c:if>
								</option>
							</c:forEach> 
						</select>
						<br>
					</div>
					
					
					<div class="selsetLit-div">
						<div id="selectList">
							<ul id="ulSelectList">
							</ul>
						</div>
					</div>
					
					<div class="price-div">
					
						<div class="delivery-price-div">
						
							<span> 배송비 </span>		
							<span> <fmt:formatNumber value="${vo.deliveryCharge}" pattern="#,###"/> </span>
										
							<input type="hidden" class="price" name="deliveryCharge" id="deliveryCharge" 
								value="${vo.deliveryCharge}" readonly="readonly">					
						</div>
					
						<div class=total-price-div>
							<span> 총 가격 </span>
							<input type="text" class="price" name="totalPrice" id="totalPrice" value="0" 
								readonly="readonly">원						
						</div>
					</div>
							
					<div class="btn-div">
						<div class="btn-purchase">
							<input type="button" class="btn-div-option" value="구매하기"
								onclick="return puchaseClick();">
						</div>
						
						<div class="btn-cart">
							<input type="button" class="btn-div-option" value="장바구니에 넣기" 
								onclick="return cartClick();">
						</div>
						
						<div class="btn-productList">
							<input type="button" class="btn-div-option" value="목록"
								onclick="goList();">
						</div>
					</div>			
				</div>
				
			</div>
			
			<div class="product-detail-div">			
				<input type="text" class="product-detail" name="pDetail" value="${vo.pDetail }"
					readonly="readonly">					
			</div>
			
			
			
				<script id="optionTemplate" type="text/x-handlebars-template">
		{{#each .}}
			<li class="oplist" name="oplist_{{pOption}}" id="oplist_{{pOption}}">
				
				<div>
	        		<span> 옵션 : </span>
					<span> {{pOption}} </span>
					<input type="hidden" id="op{{pOption}}" name="op{{pOption}}" 
						value="{{pOption}}" readonly="readonly"/>
				</div>
				
				<div>
	        		<span> 가격 : </span>
					<span> {{optionPrice}} </span>
					<input type="hidden" id="price{{pOption}}" name="price{{pOption}}" 
						value="{{optionPrice}}"  pattern="#,###" readonly="readonly"/>
				</div>
				
				
 				<div>
					<span> 수량 : </span>
					
					<input type="button" name="btnMinus{{pOption}}" id="btnMinus{{pOption}}" value = "-" onClick="minusClick('{{pOption}}', {{optionCount}});"/>
										
					<input type="text" class = "optionData" id="opcnt{{pOption}}" name="opcnt{{pOption}}" value="{{optionCnt}}" size=1 readonly="readonly"/>
					
					<input type="button" name="btnPlus{{pOption}}" id="btnPlus{{pOption}}" value = "+" onClick="plusClick( '{{pOption}}', {{optionCount}}, {{optionStock}});"/>
						
					<input type="button" name="optionDelete{{pOption}}" id="optionDelete{{pOption}}" value = "x" onClick="deleteOption('{{pOption}}', {{optionCount}});"/>
				</div>
			</li>
   	 	{{/each}}
		
		</script>
					<!-- <button name="optionDelete" id="optionDelete" onclick="optionDelete({{optionCount}});">x</button> -->
					
					
				
		</form>
	</div>

</body>
</html>