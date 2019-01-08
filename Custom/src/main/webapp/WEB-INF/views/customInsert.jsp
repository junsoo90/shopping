<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript"
	src="http://t1.daumcdn.net/postcode/api/core/181211/1544591062721/181211.js"></script>


<script>
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
						//alert(fullRoadAddr);
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if (fullRoadAddr !== '') {
							fullRoadAddr += extraRoadAddr;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('cAddCode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('cAdd').value = fullRoadAddr;
					
						//document.getElementById('cAddDetail').value = data.jibunAddress;

						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							//예상되는 도로명 주소에 조합형 주소를 추가한다.
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';

						} else {
							document.getElementById('guide').innerHTML = '';
						}
					}
				}).open();
	}
	

    //idck 버튼을 클릭했을 때 
  
</script>

<!-- 아이디 존재 ajax -->
<script type="text/javascript">
	
	var idcheck = false; 
	var overlap = false;
	
  	function checkId(){
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
                    overlap = true;
                
                } else {
                    alert("사용가능한 아이디입니다.");
                    //아이디가 존제할 경우 빨깡으로 , 아니면 파랑으로 처리하는 디자인
                    $("#divInputId").addClass("has-success")
                    $("#divInputId").removeClass("has-error")
                    $("#cPass").focus();
                    //아이디가 중복하지 않으면  idck = 1 
                    overlap = false;
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
  	function check(){
  		if(!idcheck){
  			alert("아이디 중복체크를 해주세요");
  			return false;
  		}
  		if(overlap){
  			alert("아이디가 중복됩니다. 다른 아이디를 입력후 중복체크를 해주세요");
  			return false;
  		}
  		return validCheck();
  	}
  	
  	

  	function validCheck(){

  		var blank_pattern = /\s | /gi ;
  		
  		var cId = $("#cId").val(); 
  		var cPass = $("#cPass").val(); 
  		var cPassConfirm = $("#cPassConfirm").val(); 
  		var cName = $("#cName").val(); 
  		var cAdd = $("#cAdd").val(); 
  		var cAddCode = $("#cAddCode").val(); 
  		var cAddDetail = $("#cAddDetail").val(); 
  		var phone1 = $("#phone1").val(); 
  		var phone2 = $("#phone2").val(); 
  		var phone3 = $("#phone3").val(); 
  		
  		if(!cId){
  			alert("아이디를 입력해주세요");
  			//name.setFocus();
  			return false;
  		}
  		else if(!cPass){
  			alert("비밀번호를 입력해주세요");
  			//title.setFocus();
  			return false;
  		}else if(!cPassConfirm){
  			alert("확인 비밀번호를 입력해주세요");
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
  		
  		if (cId.replace(blank_pattern, '') == "") {
  			alert("아이디는 공백을 사용할 수 없습니다 ");
  			return false;
  		}
  			
  		else if (cPass.replace(blank_pattern, '') == "") {
  			alert("비밀번호는 공백으로만 사용할 수 없습니다 ");
  			return false;
  		}
  		else if (cAddDetail.replace(blank_pattern, '') == "") {
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

  		checkarr[checkarr_int++] = fnChkByte(cId,50,"아이디");
  		checkarr[checkarr_int++] = fnChkByte(cPass,100,"비밀번호");
  		checkarr[checkarr_int++] = fnChkByte(cPassConfirm,100,"비밀번호");
  		checkarr[checkarr_int++] = fnChkByte(cName,50,"이름");
  		checkarr[checkarr_int++] = fnChkByte(cAddDetail,50,"상세주소");
  		checkarr[checkarr_int++] = fnChkByte(phone1,10,"핸드폰번호");
  		checkarr[checkarr_int++] = fnChkByte(phone2,10,"핸드폰번호");
  		checkarr[checkarr_int++] = fnChkByte(phone3,10,"핸드폰번호");
  		
  		for(var i=0; i<checkarr_int; i++){
  			//alert(checkarr[i]);
  			if(checkarr[i] == false)
  				return false;
  		}	
  		
  		if(cPass != cPassConfirm){
  			alert("비밀번호가 다릅니다. 비밀번호를 확인해주세요");
  			return false;
  		}
  		return true;
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

<body>
	<form action="insert.do" method="post">
		<label>아이디</label>
		<div class="divInputId">
			<input type="text" name="cId" id="cId" />
			<button type="button" onclick="checkId();">중복체크
		</div>

		<label>비밀번호</label>
		<div class="form-group">
			<input class="form-control" name="cPass" id="cPass" type="text" />
		</div>

		<label>비밀번호 확인</label>
		<div class="form-group">
			<input class="form-control" name="cPassConfirm" id="cPassConfirm"
				type="text" />
		</div>

		<label>이름</label>
		<div class="form-group">
			<input class="form-control" name="cName" id="cName" type="text" />
		</div>

		<label>우편번호</label>
		<div class="form-group">
			<input class="form-control" display: inline;" name="cAddCode"
				id="cAddCode" type="text" readonly="readonly">
			<button type="button" class="btn btn-default"
				onclick="sample4_execDaumPostcode();">우편번호 찾기</button>
		</div>

		<label>주소</label>
		<div class="form-group">
			<input class="form-control" name="cAdd" id="cAdd" type="text" size=30
				readonly="readonly" />
		</div>

		<label>상세주소</label>
		<div class="form-group">
			<input class="form-control" name="cAddDetail" id="cAddDetail"
				type="text" />
		</div>

		<label>전화번호</label>
		<div class="form-group">
			<input class="form-control" name="phone1" id="phone1" type="text"
				size=7 /> - <input class="form-control" name="phone2" id="phone2"
				type="text" size=7 /> - <input class="form-control" name="phone3"
				id="phone3" type="text" size=7 />
		</div>

		<input type="submit" id="frm" name="frm" value="회원가입"
			onclick="return check();"> 
		<input type="button" value="목록으로"
			onclick="location.href='${pageContext.request.contextPath}/productList.do'">
	</form>

</body>
</html>