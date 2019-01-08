<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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

<!-- option add -->
<script>
	var totalPrice = Number(0);
	var optionCount = 0;
	var stock = parseInt(document.getElementById('pStock').value);
	
	var insertOptionList;

	
	
	function chageSelect() {
	
		var selectCnt = $('#selectBox').val();
		
		var filelocation = $('#location').val();
		
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
			json2.filelocation = filelocation;
			json2.cnt = 1;
			json2.optionCount = optionCount;
			json2.optionPrice = "${optionlist.optionPrice}";
			json2.optionStock = "${optionlist.optionStock}";
			
			list.push(json2);
			
		</c:forEach>
		
		var select = list[selectCnt];
		
		for( var i=0; i<insertOptionList.length; i++){
			if( insertOptionList[i].pOption == select.pOption ){
				alert("이미 선택한 옵션입니다");
				optionCount--;
				return false;
			}
				
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
		    	cnt:select.cnt,
		    	optionCount:select.optionCount,
		    	optionStock:select.optionStock,
		    	optionPrice:select.optionPrice,
		    	filelocation:select.filelocation
	    	}
	    ];
	    
	    totalPrice = totalPrice + Number(select.optionPrice);
		document.getElementById('totalPrice').value = totalPrice;
		
		
	    $("#ulSelectList").append(template(data));
	    
	}
	

</script>

<!-- plus minus -->
<script>
	function minusClick(input, optionCount){
		var index = Number( findIndex(input) );
		
		input = "opcnt" + input;
		var btnPlus = "btnMinus"+ pOption;
		
		if(insertOptionList[index].cnt == 1){
			alert("수량은 최소 1개 입니다;");
			return false;
		}
		
		insertOptionList[index].cnt--;
		document.getElementById(input).value = insertOptionList[index].cnt;
		
		
		totalPrice = totalPrice - Number(insertOptionList[index].optionPrice);
		document.getElementById('totalPrice').value = totalPrice;
		return false;
		
	}
	
	function plusClick(input, optionCount, optionStock){
		var index = Number( findIndex(input) );
	
		input = "opcnt" + input;
		var btnPlus = "btnPlus"+ pOption;
		
		if(insertOptionList[index].cnt >= optionStock){
			alert("남은 재고는 " + optionStock + "개 입니다");
			return false;
		}
		
		insertOptionList[index].cnt++;
		
		document.getElementById(input).value =  Number(insertOptionList[index].cnt);
		
		totalPrice = totalPrice + Number(insertOptionList[index].optionPrice);
		document.getElementById('totalPrice').value = totalPrice;
		return false;
	}
	
	function deleteOption(input, optionCount){
		
		var index = Number( findIndex(input) );
		var deleteOption = "#oplist_" + input;
		
		var price = insertOptionList[index].optionPrice;
		var cnt = insertOptionList[index].cnt;
		//alert(optionCount + " , " + deleteOption + " , " + price + " , " + cnt);
		
		$(deleteOption).remove();

		for(var i=index; i<insertOptionList.length-1; i++){
			insertOptionList[i] = insertOptionList[i+1];
		}
		insertOptionList.pop();
		
		totalPrice = totalPrice - price * cnt;
		document.getElementById('totalPrice').value = totalPrice;
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
		if(insertOptionList == null || optionCount <= 0){
			alert("옵션을 선택해 주세요");
			return false;
		}
			
		var session = "<%=session.getAttribute("custom") %>";
		
		if(session == 'null' || session == null)
			alert("로그인이 필요합니다.");
		return ;
	}
	
	function cartClick(){
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
	        traditional: true,
	        
            success : function(data) {
                if (data == 'false') {  
                	//window.open("login.do", "loginPopup",
			 	//"width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
                	location.href = "login.do";
                } else {
                	location.href = "cartIn.do";
                }
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
             }
        });
	}
	
	function puchaseClick(){
		 
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
	        traditional: true,
       		
	        success : function(data) {
            	if (data) {   
            		 $('#detailform').submit();
            	} 
            	else {
            		location.href = "login.do";
	         	} 
             },
             error:function(request,status,error){
                 alert("message:"+request.responseText+"\n"+"error:"+error);
              }
	    });
	}
	
</script>

<!-- goList -->
<script>
	function goList(){
		document.location.href="productList.do";
	}
</script>


<%@ include file = "nav.jsp" %>
<body>	

	<form name = "detailform" action="puchase.do">
		<input type="hidden" name="seq" id="pSeq" value="${vo.pSeq}">
		<br>
		
		<img src="${filelocation}" width="50" height="50">
		<br>
		
		<input type="hidden" name="location" id="location" value="${filelocation}">
						
		<label>물품명</label>
		<input type="text" name="pName" id="pName" value="${vo.pName }"
			readonly="readonly">
		<br>
		<label>가격</label>
		<input type="text" name="pPrice" id="pPrice" value="${vo.pPrice }" pattern="#,###"
			readonly="readonly">
		<br>
	
		<label>옵션</label>
		<select name="selectBox" id="selectBox" style="width: 200px;"
			class="select" onchange="chageSelect()">
			<c:forEach var="list" items="${optionlist}" varStatus="i">
				<option value="${list.optionCnt}">
					<em> 옵션 : ${list.pOption}</em>
					<em> 가격 : ${list.optionPrice}원</em>
					<em> 수량 : ${list.optionStock}개</em>
				</option>
			</c:forEach> 
		</select>
		<br>
		<div id="selectList">
			<ul id="ulSelectList">
			</ul>
		</div>
		<script id="optionTemplate" type="text/x-handlebars-template">
		
    	{{#each .}}
			<li class="oplist" name="oplist_{{pOption}}" id="oplist_{{pOption}}">
        		<label> 옵션 : </label>
				<input type="text" id="op{{pOption}}" name="op{{pOption}}" value="{{pOption}}" readonly="readonly"/>
				<br>
				
   				<label> 가격 : </label>
				<input type="text" id="price{{pOption}}" name="price{{pOption}}" value="{{optionPrice}}"  pattern="#,###" readonly="readonly"/>
				<br>
 				
				<label> 수량 : </label>
				<input type="button" name="btnMinus{{pOption}}" id="btnMinus{{pOption}}" value = "-" onclick="minusClick( {{pOption}}, {{optionCount}});"/>
					
				<input type="text" class = "optionData" id="opcnt{{pOption}}" name="opcnt{{pOption}}" value="{{cnt}}" size=1 readonly="readonly"/>
				
				<input type="button" name="btnPlus{{pOption}}" id="btnPlus{{pOption}}" value = "+" onclick="plusClick( {{pOption}}, {{optionCount}}, {{optionStock}});"/>
					
				<input type="button" name="optionDelete{{pOption}}" id="optionDelete{{pOption}}" value = "x" onclick="deleteOption({{pOption}}, {{optionCount}});"/>
			
			</li>
   	 	{{/each}}
		
		</script>
		<!-- <button name="optionDelete" id="optionDelete" onclick="optionDelete({{optionCount}});">x</button> -->		
		<label>총 가격</label>
		<input type="text" name="totalPrice" id="totalPrice" value="0" pattern="#,###"
			readonly="readonly">원
		
		<br>
		
		<label>상세보기</label>
		<input type="text" name="pDetail" value="${vo.pDetail }"
			readonly="readonly">
		<br>
	
	
		<input type="button" value="구매하기"
			style="font-family: Gulim; font-size: 12px;"
			onclick="puchaseClick();">
	
		<input type="button" value="장바구니에 넣기"
			style="font-family: Gulim; font-size: 12px;"
			onclick="cartClick();">
	
		<input type="button" value="목록"
			style="font-family: Gulim; font-size: 12px;"
			onclick="goList();">
		</form>
</body>
</html>