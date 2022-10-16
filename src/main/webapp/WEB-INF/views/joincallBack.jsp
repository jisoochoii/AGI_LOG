<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 로그인</title>
</head>
<body>
	<script type="text/javascript"
		src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
		charset="utf-8"></script>
	<script type="text/javascript"
		src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("GgJuJh_y9P_xFKb5fSQj",
				"YOUR_CALLBACK_URL");
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			
			let form = document.getElementById("serverForm");
			form.action="MoveJoinFormPage";
			form.method="post";
			
			form.appendChild(createInput("hidden","suCode",naver_id_login.oauthParams.access_token,null,null));
			form.appendChild(createInput("hidden","suEmail",naver_id_login.getProfileData('email'),null,null));
			form.appendChild(createInput("hidden","suNickName",naver_id_login.getProfileData('nickname'),null,null));
			
			form.submit();
		}
	</script>
	<form id="serverForm"></form>
</body>
</html>