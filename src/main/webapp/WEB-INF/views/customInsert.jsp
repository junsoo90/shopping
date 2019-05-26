<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel= "stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/custom.css">

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


<!-- 아이디 존재 ajax -->
<script type="text/javascript">
	
	var idcheck = false; 
	var overlap = false;
	
  	function checkId(){
  		var blank_pattern = /\s | /gi ;
  	
		var cId = $("#cId").val(); 
		// 제거 cId.replace(blank_pattern, "")
		
		if(!cId){
			alert("아이디를 입력해주세요");
			//name.setFocus();
			return false;
		}
		

      if(!fnChkByte(cId,50,"아이디")){
    	  cId.value = "";
    	  return false;
      }
    	idcheck = true;
	
        //userid 를 param.
    	var userid =  $("#cId").val(); 
    	$.ajax({
            async: true,
            type : 'POST',
            data : userid,
            url : "idcheck.do",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            
            success : function(data) {
            	
                if (data) {                    
                    alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
                    //아이디가 존제할 경우 빨깡으로 , 아니면 파랑으로 처리하는 디자인
                    $("#divInputId").addClass("has-error")
                    $("#divInputId").removeClass("has-success")
                    $("#cId").focus();
                    overlap = false;
                
                } else {
                    alert("사용가능한 아이디입니다.");
                    //아이디가 존제할 경우 빨깡으로 , 아니면 파랑으로 처리하는 디자인
                    $("#divInputId").addClass("has-success")
                    $("#divInputId").removeClass("has-error")
                    $("#cPass").focus();
                    //아이디가 중복하지 않으면  idck = 1 
                    overlap = true;
                }
            },
            error : function(error) {
                alert("error : " + error);
            }
        });
     
    }
</script>


<!-- 유효성 체크 -->
<script>

	function idKeyUp(obj){
		idcheck = false;
		overlap = false;
		blankCheck(obj);
	}
	
  	function check(){
  		if(!idcheck || !overlap){
  			alert("아이디 중복체크를 해주세요");
  			return false;
  		}
  		return validCheck();
  	}
  	
  	

  	function validCheck(){

  		
  		var cPass = $("#cPass").val(); 
  		var cPassConfirm = $("#cPassConfirm").val(); 
  		var cName = $("#cName").val(); 
  		var cAdd = $("#cAdd").val(); 
  		var cAddCode = $("#cAddCode").val(); 
  		var cAddDetail = $("#cAddDetail").val(); 
  		var phone1 = $("#phone1").val(); 
  		var phone2 = $("#phone2").val(); 
  		var phone3 = $("#phone3").val(); 
  	
  		if(!cPass){
  			alert("비밀번호를 입력해주세요");
  			//title.setFocus();
  			return false;
  		}else if(!cPassConfirm){
  			alert("확인 비밀번호를 입력해주세요");
  			//title.setFocus();
  			return false;
  		}else if(!cName){
  			alert("이름을 입력해주세요");
  			//title.setFocus();
  			return false;
  		}else if(!cAdd || !cAddCode){
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
  		
  		
  		var checkarr = new Array();
  		var checkarr_int = 0;

  		if(!fnChkByte(cPass, 100,"비밀번호")){
  			return false;
  		}
  		if(!fnChkByte(cPassConfirm,100,"비밀번호")){
  			return false;
  		}
  		if(!fnChkByte(cName,50,"이름")){
  			return false;
  		}
  		if(!fnChkByte(cAddDetail, 100,"상세주소")){
  			return false;
  		}
  		if(!fnChkByte(phone1,4,"핸드폰번호")){
  			return false;
  		}
  		if(!fnChkByte(phone2,4,"핸드폰번호")){
  			return false;
  		}
  		if(!fnChkByte(phone3,4,"핸드폰번호")){
  			return false;
  		}
  		
  		if(cPass != cPassConfirm){
  			alert("비밀번호가 다릅니다. 비밀번호를 확인해주세요");
  			return false;
  		} 
  		
  		return true;
  	}

	
  	
 </script>


<!-- fnChkByte -->
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
			if(cvalue == "핸드폰번호"){
				alert("핸드폰 번호는 4자 이하로 입력해 주세요");
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


<!-- goList -->
<script>
	function goList(){
		var keyWord = "${sessionScope.keyWord}";
		document.location.href="productList.do?pageNum=" + "${sessionScope.pageNum}"
				+ "&keyWord="+ encodeURI(encodeURIComponent(keyWord));
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


<!-- blankCheck -->
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
		<form action="customInsert.do" method="post">
		
			<div class="insert-div">
				<div class="insert-data inert-id-div">
					<span class="span-div">아이디</span>
					<div class="form-group">
						<input type="text" name="cId" id="cId"  onKeyup="idKeyUp(this);"/>
						<button type="button"  onclick="checkId();"> 중복체크 </button>
					</div>
				</div>
				
				<div class="insert-data insert-pass-div">
					<span class="span-div">비밀번호</span>
					<div class="form-group">
						<input class="form-control" name="cPass" id="cPass" type="text" />
					</div>
				</div>
				
				<div class="insert-data insert-passConfirm-div">
					<span class="span-div">비밀번호 확인</span>
					<div class="form-group">
						<input class="form-control" name="cPassConfirm" id="cPassConfirm"
							type="text" />
					</div>
				</div>
				
				<div class="insert-data insert-name-div">
					<span class="span-div">이름</span>
					<div class="form-group">
						<input class="form-control" name="cName" id="cName" type="text" onKeyup="blankCheck(this);"/>
					</div>
				</div>
					
				<div class="insert-data insert-add-div">
					<div class="insert-data">
						<span class="span-div">우편번호</span>
						<div class="form-group">
							<input class="form-control" display: inline;" name="cAddCode"
								id="cAddCode" type="text" readonly="readonly">
							<button type="button" class="btn btn-default"
								onclick="sample6_execDaumPostcode();">우편번호 찾기</button>
						</div>
					</div>
					
					<div class="insert-data">
						<span class="span-div">주소</span>
						<div class="form-group">
							<input class="form-control" name="cAdd" id="cAdd" type="text" size=30
								readonly="readonly" />
						</div>
					</div>
					
					<div class="insert-data">
						<span class="span-div">상세주소</span>
						<div class="form-group">
							<input class="form-control" name="cAddDetail" id="cAddDetail"
								onKeyup="blankCheck(this);" type="text" />
						</div>
					</div>
				</div>
				
				<div class="insert-data isnert-phone-div">
					<span class="span-div">전화번호</span>
					<div class="form-group">
						<input class="form-control" name="phone1" id="phone1" type="text"
							size=7 /> - 
							<input class="form-control" name="phone2" id="phone2"
							type="text" size=7  /> - 
							<input class="form-control" name="phone3"
							id="phone3" type="text" size=7 />
					</div>
				</div>
			</div>
			
			<div class="insert-data insert-btn-div">
			
				<div class="btn-div">
					<input type="submit" id="frm" name="frm" value="회원가입"
						onclick="return check();">
				</div>
				
				<div class="btn-div"> 
					<input type="button" value="목록으로"
						onclick="goList();">
				</div>
			</div>
		</form>
	</div>
</body>
</html>