<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/custom.css">
</head>

<script src='https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.min.js'></script>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript"
	src="http://t1.daumcdn.net/postcode/api/core/181211/1544591062721/181211.js"></script>


<!-- 주소 -->
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    //document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('cAddCode').value = data.zonecode;
                document.getElementById("cAdd").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("cAddDetail").focus();
            }
        }).open();
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


<!-- 회원탈퇴 -->
<script>

	function customDelete(){
		var cId = $("#cId").val(); 
		var cInputOldPass = $("#cInputOldPass").val();
		
		var data = {
	        	cId: cId,
	        	cInputOldPass: cInputOldPass
	    	};
		
		if(!confirm("정말로 탈퇴 하시겠습니까?"))
			return false;
		
		$.ajax({
            async: true,
            type : 'POST',
            data : JSON.stringify(data),
            url : "customDelete.do",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            
            success : function(data) {
            	alert("회원정보가 삭제 되었습니다");
               	location.href = "${sessionScope.url }";
            },
            error : function(error) {
                alert("error : " + error);
            }
        });
     return false;
    }
		
	
	
</script>

<!-- 회원 정보 수정 -->
<script>

	function customUpdate(){

		var cId = $("#cId").val(); 
		var cInputOldPass = $("#cInputOldPass").val();
		var cChangePass = $("#cChangePass").val(); 
	
		var cName = $("#cName").val(); 
		var cAdd = $("#cAdd").val(); 
		var cAddCode = $("#cAddCode").val(); 
		var cAddDetail = $("#cAddDetail").val(); 
		var cPhone1 = $("#phone1").val(); 
		var cPhone2 = $("#phone2").val(); 
		var cPhone3 = $("#phone3").val();
		
		if(cChangePass == "" || cChangePass == null)
			cChangePass = cInputOldPass;
			
	  	var data = {
	        	cId: cId,
	        	cInputOldPass: cInputOldPass,
	        	cChangePass: cChangePass,
	        	cName: cName,
	        	cAdd: cAdd,
	        	cAddCode : cAddCode,
	        	cAddDetail : cAddDetail,
	        	cPhone1 : cPhone1,
	        	cPhone2 : cPhone2,
	        	cPhone3 : cPhone3
	    	};
	  
	  	
		$.ajax({
            async: true,
            type : 'POST',
            data : JSON.stringify(data),
            dataType : "json",
            url : "customUpdate.do",
            contentType: "application/json; charset=UTF-8",
            
            success : function(data) {
            	
               	alert("회원정보가 변경되었습니다");
               	location.href = "${sessionScope.url }";
              
            },
            error : function(error) {
                alert("error : " + error);
            }
        });
     
	    
	}
</script>


<!-- 유효성 -->
<script>

	function check(url){
		
		var blank_pattern = /\s | /gi ;
		 		
		var cId = $("#cId").val(); 
		var cChangePass = $("#cChangePass").val(); 
		var cChangePassConfirm = $("#cChangePassConfirm").val();
		var cInputOldPass = $("#cInputOldPass").val();
	
		var cName = $("#cName").val(); 
		var cAdd = $("#cAdd").val(); 
		var cAddCode = $("#cAddCode").val(); 
		var cAddDetail = $("#cAddDetail").val(); 
		var phone1 = $("#phone1").val(); 
		var phone2 = $("#phone2").val(); 
		var phone3 = $("#phone3").val(); 
  		
  		if(!cInputOldPass){
  			alert("기존 비밀번호를 입력해주세요");
  			//title.setFocus();
  			return false;
  		}if(!cAdd || !cAddCode){
  			alert("주소를 입력해주세요");
  			//title.setFocus();
  			return false;
  		}else if(!cAddDetail){
  			alert("상세주소를 입력해주세요");
  			//title.setFocus();
  			return false;
  		}else if(!phone1 || !phone2 || !phone3){
  			alert("핸드폰 번호를 입력해주세요");
  			//title.setFocus();
  			return false;
  		}
  		
  	/*
  		if (inputOldPass.replace(blank_pattern, '') == "") {
  			alert("비밀번호는 공백으로만 사용할 수 없습니다 ");
  			return false;
  		}
  		if (cOldPass.replace(blank_pattern, '') == "") {
  			alert("비밀번호는 공백으로만 사용할 수 없습니다 ");
  			return false;
  		}
  		
  		*/
  		
  		if (cAddDetail.replace(blank_pattern, '') == "") {
  			alert("상세주소는 공백을 사용할 수 없습니다 ");
  			return false;
  		}
  		else if (phone1.replace(blank_pattern, '') == "" ||
  				phone3.replace(blank_pattern, '') == "" ||
  				phone3.replace(blank_pattern, '') == "") {
  			alert("전화번호는 공백을 사용할 수 없습니다 ");
  			return false;
  		}
  		
  		var checkarr = new Array();
  		var checkarr_int = 0;
  		
  		if(!fnChkByte(cChangePass, 100,"비밀번호")
			|| !fnChkByte(cChangePassConfirm, 100,"비밀번호")
			|| !fnChkByte(cInputOldPass, 100,"비밀번호")
			|| !fnChkByte(cName,50,"이름")
			|| !fnChkByte(cAddDetail,100,"상세주소")
			|| !fnChkByte(phone1, 10,"핸드폰번호")
			|| !fnChkByte(phone2, 10,"핸드폰번호")
			|| !fnChkByte(phone3, 10,"핸드폰번호") 
			)
  		{
  			return false;
  		}
  		
  		
  		if(cChangePass != cChangePassConfirm){
  			alert("변경하려는 비밀번호가 다릅니다. 비밀번호를 확인해주세요");
  			return false;
  		}
  		passCheck(url, cId, cInputOldPass);
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
			alert(cvalue + "은(는) 한글 " + (maxByte / 2) +
					"자 / 영문 " + maxByte
					+ "자를 초과 입력할 수 없습니다.");
			str2 = str.substr(0, rlen); //문자열 자르기
			obj.value = str2;
			//fnChkByte1(obj, maxByte);
			return false;
		}
		
		
			return true;
	}
</script>


<!-- 비밀번호 ajax -->
<script>
	
	var idcheck = false; 
	var overlap = false;
	
  	function passCheck(url, cId, cInputOldPass){
  		var cChangePass = $("#cChangePass").val(); 
  		
  		var bol = true;
  		
      	idcheck = true;
        //userid 를 param.
        var data = {
        	cId: cId
        	,cInputOldPass: cInputOldPass
       		,cChangePass: cChangePass
    	};
        
       $.ajax({
            async: true,
            type : 'POST',
            data : JSON.stringify(data),
            url : "passCheck.do",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            
            success : function(data) {
                if (data) {
                	if(url == "update"){
                		customUpdate();
                	}
                	else if(url == "delete"){
                		customDelete();
                	}
                	
                } else {
                	alert("기존 비밀번호가 일치하지 않습니다. 비밀번호를 확인해 주세요");
                	bol = false;
                }
                
            },
            error : function(error) {
                alert("error : " + error);
            }
        });
       
     return bol;
    }
</script>


<!-- 숫자 -->
<script>
	$(document).ready(function(){
		$("#phone1").keyup(function(event){
			if (!(event.keyCode>=48 && event.keyCode<=57 ||
					event.keyCode>=96 && event.keyCode<=105 ||
					event.keyCode==8)) {
				alert("숫자만 입력해주세요");
		        var inputVal = $(this).val();
		        event.returnValue=false;
		        $(this).val(inputVal.replace(/[^0-9]/gi,''));
		        
			}  
		});
		
		
		$("#phone2").keyup(function(event){
			if (!(event.keyCode>=48 && event.keyCode<=57 ||
					event.keyCode>=96 && event.keyCode<=105 ||
					event.keyCode==8)) {
				alert("숫자만 입력해주세요");
		        var inputVal = $(this).val();
		        event.returnValue=false;
		        $(this).val(inputVal.replace(/[^0-9]/gi,''));
		        
			}  
		});
		$("#phone3").keyup(function(event){
			if (!(event.keyCode>=48 && event.keyCode<=57 ||
					event.keyCode>=96 && event.keyCode<=105 ||
					event.keyCode==8)) {
				alert("숫자만 입력해주세요");
		        var inputVal = $(this).val();
		        event.returnValue=false;
		        $(this).val(inputVal.replace(/[^0-9]/gi,''));
		        
			}  
		});
	});

</script>


<!-- blank check -->
<script>
	
	function blankCheck(obj){
	
	    var pattern = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/
    	
	    if (!pattern.test(obj.value)) {
   		    alert("영문자와 한글,숫자만을 입력하세요");
   			obj.value = "";
   			obj.focus();
   		    return false;
    	}
	    		
	}
	
</script>


<body>

	<div class="nav-div">
		<%@ include file = "nav.jsp" %>
	</div>
	
	
	<div class="form-div">
		<div class="insert-div">
			<div class="insert-data inert-id-div">
				<span class="span-div">아이디</span>
				<div class="form-group">
					<input type="text" name="cId" id="cId" value = ${customVo.cId }
					readonly="readonly"/>
				</div>
			</div>
			
			<div class="insert-data insert-oldpass-div">
				<span class="span-div">기존 비밀번호</span>
				<div class="form-group">
					<input class="form-control" name="cInputOldPass" id="cInputOldPass" type="text" />
				</div>
			</div>
			
			<div class="insert-data insert-changepass-div">				
				<span class="span-div">변경할 비밀번호</span>
				<div class="form-group">
					<input class="form-control" name="cChangePass" id="cChangePass" type="text" />
				</div>
			</div>
			
			<div class="insert-data insert-changepassConfirm-div">
				<span class="span-div">변경할 비밀번호 확인</span>
				<div class="form-group">
					<input class="form-control" name="cChangePassConfirm" id="cChangePassConfirm"
						type="text" />
				</div>
			</div>
			
			<div class="insert-data insert-name-div">
				<span class="span-div">이름</span>
				<div class="form-group">
					<input class="form-control" name="cName" id="cName" type="text" 
					value = ${customVo.cName } onKeyup="blankCheck(this);"/>
				</div>
			</div>
			
			<div class="insert-data insert-add-div">
				<div class="insert-data">
					<span class="span-div">우편번호</span>
					<div class="form-group">
						<input class="form-control" display: inline;" name="cAddCode"
							id="cAddCode" type="text" 
							value = '${customVo.cAddCode }' readonly="readonly">
						<button type="button" class="btn btn-default"
							onclick="sample6_execDaumPostcode();">우편번호 찾기</button>
					</div>
				</div>
				<div class="insert-data">
					<span class="span-div">주소</span>
					<div class="form-group">
						<input class="form-control" name="cAdd" id="cAdd" type="text" size=20
							value ='${customVo.cAdd}' readonly="readonly" />
							
					</div>
				</div>
				
				<div class="insert-data">
					<span class="span-div">상세주소</span>
					<div class="form-group">
						<input class="form-control" name="cAddDetail" id="cAddDetail"
							type="text" value = '${customVo.cAddDetail }' onKeyup="blankCheck(this);" />
					</div>
				</div>
			</div>
			
			<div class="insert-data isnert-phone-div">
				<span class="span-div">전화번호</span>
				<div class="form-group">
					<input class="form-control" name="phone1" id="phone1" type="text"
						size=7 value = ${customVo.cPhone1 } numberOnly /> - 
						<input class="form-control" name="phone2" id="phone2"
						type="text" size=7 value = ${customVo.cPhone2 } numberOnly /> - 
						<input class="form-control" name="phone3"
						id="phone3" type="text" size=7 value = ${customVo.cPhone3 } numberOnly />
				</div>
			</div>
		</div>
		
		<div class="insert-data insert-btn-div">
			<div class="btn-div">
				<input type="button" id="frm" name="frm" value="수정하기"
					onclick="return check('update');">
			</div>
			
			<div class="btn-div">
				<input type="button" id="customDelete" name="customDelete" value="회원 탈퇴하기"
					onclick="return check('delete');">
			</div>
			
			<div class="btn-div"> 
				<input type="button" value="목록으로"
					onclick="goList();">
			</div>
		</div>
	</div>	
	
</body>
</html>