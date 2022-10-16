<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>육아정보</title>
<script src="/res/js/agiMain.js"></script>
<script src="https://use.fontawesome.com/releases/v6.1.2/js/all.js"></script>
<link rel="stylesheet" href="/res/css/agiMain.css">
<link rel="stylesheet" href="/res/css/infoBoard.css">
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 네이버 스크립트 -->
<script	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<style>
.backList{
    position: absolute;
    left: 40px;
}
</style>
<script>

Kakao.init('2afdabad57ed92e1cc9de5bd4baed321');
function getInfo() {
	/* 테마 이미지 or 단순색상 */
	let body = document.getElementById("body");
	
	let suTheme = "${accessInfo.suTheme}";
	let sideMenu = document.querySelector(".side-menu");
	if(suTheme != ""){
		if(suTheme.indexOf("#") == 0){
			//단순색상
			/* 테마 사용자값으로 설정 */
			//배경css제거
			body.className = "";
			
			let color = suTheme.split(":");

			body.style.background = color[0];
			sideMenu.style.background= color[1];

		}else{
			//배경이미지
			body.style.background = "none";
			body.className = "bgImage"+suTheme;
			sideMenu.style.background= "whitesmoke";

		}
	}
	
	let accessArea = document.getElementById("accessArea");
	if ("${accessInfo.type}"!= null&&"${accessInfo.type}"!="") {
		accessArea.innerHTML = "";
		accessArea.innerHTML = "<span onclick=\"movePage('MoveMyPage')\"> ${accessInfo.suNickName}님 </span>";
		if ("${accessInfo.type}"== "kakao") {
			accessArea.innerHTML +="<span onclick=\"kakaoLogout();\">로그아웃</span>"
		} else if ("${ accessInfo.type }"== "naver") {
			accessArea.innerHTML +="<span onclick=\"naverLogout(); return false;\">로그아웃</span>"
		} else {
			accessArea.innerHTML += "<span onclick=\"movePage('MoveCompanyLoginPage')\">기업회원</span>";
		}
	}
}
function openPopUp() {
	testPopUp = window
		.open("https://nid.naver.com/nidlogin.logout",
			"_blank",
			"toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp() {
	testPopUp.close();
}

function naverLogout() {
    openPopUp();
    setTimeout(function () {
        closePopUp();
        logout();
    }, 1000);
}
function kakaoLogout() {
	if (Kakao.Auth.getAccessToken()) {
		Kakao.API.request({
			url: '/v1/user/unlink',
			success: function(response) {
				logout();
			},
			fail: function(error) {
				console.log(error)
			},
		})
		Kakao.Auth.setAccessToken(undefined)
	}
}
function boardContent(data1){
	let form = document.getElementById("serverForm");
	
	form.appendChild(createInput("hidden","ibCode",data1,null,null));

	
	form.action = "MoveShowPost";
	form.method = "post";
	form.submit();
}
function changeSort(){
	let form = document.getElementById("serverForm");
	let postSelect = document.getElementById("infoBoardSelect");
	//option값을 저장
	let ibSorts = postSelect.options[postSelect.selectedIndex].value;
	let optionText = postSelect.options[postSelect.selectedIndex].text;
	form.appendChild(createInput("hidden","ibSort",ibSorts,null,null));

	form.action = "MoveInfoBoard";
	form.method = "get";
	form.submit();
}
function pageNum(num){
	let form = document.getElementById("serverForm");
	form.appendChild(createInput("hidden","page",num,null,null));
	
	form.action = "MovePageNum";
	form.method = "get";
	form.submit();
}

window.onpageshow = function(event) {
	let form = document.getElementById("serverForm");
    if(event.persisted || (window.performance && window.performance.navigation.type == 2)) {
       	
        form.action = "MoveInfoBoard";
        form.method = "get";
    	form.submit();
    } 
}
</script>
</head>
<body onload="getInfo()" id="body">
</head>
<body>
	<div id="background">
		<div id="top">
			<div id="accessArea">
				<span onclick="movePage('MoveLoginPage')">로그인</span>
                <span onclick="movePage('MoveJoinPage')">회원가입</span>
                <span onclick="movePage('MoveCompanyLoginPage')">기업회원</span>
			</div>
			<div id="logo" onclick="movePage('MoveMainPage')"><span id="txt">아기-로그</span>
				<img src="/res/img/logo.png" alt="images">
			</div>
			<div id="mainMenuArea">
				<ul id="mainMenuList">
					<li class="mainMenu" onclick="movePage('MoveDailyDiaryPage')">육아일기</li>
					<li class="mainMenu" onclick="movePage('MoveMapPage')">지도</li>
					<li class="mainMenu" onclick="movePage('MoveCalendarPage')">캘린더</li>
					<li class="mainMenu" onclick="movePage('MoveBoardPage')">게시판</li>
					<li class="mainMenu" onclick="movePage('MoveMyPage')">마이페이지</li>
				</ul>
			</div>
		</div>
		<div id="middle">
			<div id="leftArea">
				<!-- navigator -->
				<!-- ------------------------------------------------------------------------ -->


				<nav class="side-menu">
					<ul class="menus">
						<li class="nav-text"><span>게시판</span></li>
						<li class="nav-sText" onclick="movePage('MoveBoardPage')"><span>자유게시판</span></li>
						<li class="nav-sText" onclick="movePage('MoveInfoBoard')"><span>육아정보</span></li>
					</ul>
				</nav>

				<!-- ------------------------------------------------------------------------ -->
			</div>
			<div id="rightArea" class="scrollBar">
				<div class="infoBoard">
					<div class="infoBoardH">육아정보 게시판</div>
					${bebeBoardList}
					<div class="paging">${pagingList}</div>
				</div>
			</div>
		</div>
		<div class="modal">
            <div class="modal_body">
				<div class="modal_head">
					<i class="fa-solid fa-xmark closeBtn editBtn"></i><br />
				</div>
				<div class="modal_content"></div>
				<div class="modal_foot"></div>
            </div>
        </div>
	</div>
	<form id="serverForm"></form>
</body>

</html>