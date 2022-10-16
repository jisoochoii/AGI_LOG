<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글보기</title>
<script src="/res/js/agiMain.js"></script>
<script src="https://use.fontawesome.com/releases/v6.1.2/js/all.js"></script>
<link rel="stylesheet" href="/res/css/agiMain.css">
<link rel="stylesheet" href="/res/css/post.css">
<!-- 알림창 꾸미기 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 네이버 스크립트 -->
<script	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<style>
.submitBtn{
	margin-left: 2rem;
	cursor:pointer;
}
.editBtn{
	margin-right:1rem;
	font-size:1.5rem;
}
.imgContainer > img{
	width: 100%;
    height: 100%;
}
.pContent{
overflow: auto;
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
			accessArea.innerHTML +="<span onclick=\"kakaoLogout();\">로그아웃</span>";
		} else if ("${ accessInfo.type }"== "naver") {
			accessArea.innerHTML +="<span onclick=\"naverLogout(); return false;\">로그아웃</span>";
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
function likeBtn(bCode, bDate, bType) {
	let clientData;
	let jobCode;
	if(bType=="0"){
		clientData = "ibCode=" + bCode + "&ibDate=" + bDate;
		jobCode = "InfoBoardLike";
	} else if(bType=="1") {
		clientData = "fbCode=" + bCode + "&fbDate=" + bDate + "&fbSuCode=" + document.getElementById("writer").value;;
		jobCode = "FreeBoardLike";
	}
	//InfoBoardLike, FreeBoardLike
	postAjaxJson(jobCode, clientData, "updLikes");
}

function updLikes(ajaxData){
	const ajax = JSON.parse(ajaxData);
	//좋아요 수
	let sLike = document.getElementsByClassName("sLike")[0];
	//좋아요 버튼
	let like = document.getElementsByClassName("likeBtn")[0];
	//정보게시판/자유게시판 좋아요 판단
	if(ajax.ibLike != undefined) {
		//내가 좋아요를 누른 게시글인 경우
		if(ajax.ibLike.like) {
			like.className = "likeBtn myLike";
		} else { //내가 좋아요를 안누른 게시글인 경우
			like.className = "likeBtn";
		}
		sLike.innerText = ajax.ibLike.likes;
	} else if(ajax.fbLike != undefined) {
		//내가 좋아요를 누른 게시글인 경우
		if(ajax.fbLike.like) {
			like.className = "likeBtn myLike";
		} else { //내가 좋아요를 안누른 게시글인 경우
			like.className = "likeBtn";
		}
		sLike.innerText = ajax.fbLike.likes;
	} else {
	}
}
/* 게시글 댓글 작업 */
	// 댓글 수정 버튼
function updateInput(fbCode, fbSuCode, fcCode, fcDate, fbDate){
	let fcContent = document.getElementsByClassName(fcDate)[0];
	
	fcContent.innerHTML = "";
	fcContent.innerHTML += "<input class ='updFbComment commentInput'/>";
	fcContent.innerHTML += "<button class='submitBtn btn' onClick='updateBoardComment(\"" + fbCode + "\",\"" + fbSuCode + "\",\"" + fcCode + "\",\"" + fcDate + "\",\"" + fbDate +"\")'>확인</button>";
}

// 자유게시판 댓글 전부 AJAX
// 1. 등록 완료
function insertBoardComment(fbCode, fbSuCode, fbDate) {
	const fbComment = document.getElementsByClassName("fbComment")[0].value;
	const clientData = "fcFbCode=" + fbCode + "&fcFbSuCode=" + fbSuCode + "&fcFbDate=" + fbDate + "&fcContent=" + fbComment;
	
	postAjaxJson("InsertBoardComment", clientData, "postComment");
}

// 2. 수정 완료
function updateBoardComment(fbCode, fbSuCode, fcCode, fcDate, fbDate) {
	const updFbComment = document.getElementsByClassName("updFbComment")[0].value;
	
	const clientData = "fcFbCode=" + fbCode + "&fcCode=" + fcCode + "&fcFbSuCode=" + fbSuCode + "&fcDate=" + fcDate + "&fcContent=" + updFbComment + "&fcFbDate=" + fbDate;
	postAjaxJson("UpdateBoardComment", clientData, "postComment");
}

// 3. 삭제 완료
function deleteBoardComment(fbCode, fbSuCode, fcCode, fcDate, fbDate) {
	console.log(fbCode, fbSuCode, fcCode, fcDate);
	
	const clientData = "fcFbCode=" + fbCode + "&fcCode=" + fcCode + "&fcFbSuCode=" + fbSuCode + "&fcDate=" + fcDate + "&fcFbDate=" + fbDate;
	
    // 경고
    swal({
        title: "댓글삭제",
        text: "댓글을 삭제하시겠습니까?",
        icon: "warning",
        buttons: true,
        dangerMode: true,
    })
        .then((willDelete) => {
            if (willDelete) {
            	postAjaxJson("DeleteBoardComment", clientData, "postComment");
            } else {
                swal("삭제를 취소하셨습니다.");
            }
    });
}

// CALLBACK
function postComment(ajaxData) {
	const ajax = JSON.parse(ajaxData);
	const fbComment = ajax.fbComment;
	const suCode = ajax.suCode;
	console.log(ajax);
	
	document.getElementsByClassName("fbComment")[0].value = "";
	
	let commentList = document.getElementById("commentList");

	commentList.innerHTML = "";
	let comment = "";

	for(i = 0; i < fbComment.length; i++){
		comment += "<div class = 'comment " + i + "'>";
		// 프로필 사진이 없을 경우 기본 이미지
		if(fbComment[i].suPhoto != null) {
			comment += "<img class='profileImage' src=" + fbComment[i].suPhoto + ">";
		} else {
			comment += "<img class='profileImage' src='/res/img/profile_default.png'>";
		}
		
		// 닉네임
		comment += "<div class = 'suNickname'>" + fbComment[i].suNickname + "</div>";

		// 댓글 내용
		comment += "<div class='fcContent " + fbComment[i].fcDate + "'>" + fbComment[i].fcContent + "</div>";

		// 수정 삭제 버튼
		if(suCode === fbComment[i].fcSuCode) {
			comment += "<i class='fa-solid fa-pen editBtn ' onClick='updateInput(" + fbComment[i].fcFbCode + "," + fbComment[i].fcFbSuCode + "," + fbComment[i].fcCode + "," + fbComment[i].fcDate +")'></i>";
			comment += "<i class='fa-solid fa-trash-can editBtn ' onClick='deleteBoardComment(" + fbComment[i].fcFbCode + "," + fbComment[i].fcFbSuCode + "," + fbComment[i].fcCode + "," + fbComment[i].fcDate +")'></i>";
		}
		comment += "</div>";
	}
	commentList.innerHTML = comment;

	swal("요청", "요청하신 작업을 완료하였습니다!", "success", { button: "완료"});
}
function updatePost(fbCode) {
	let form = document.getElementById("serverForm");
	
	form.appendChild(createInput("hidden","fbCode",fbCode,null,null));
	form.action = "MoveUpdateFBPost";
	form.method = "post";
	
	form.submit();
}
function deletePost(fbCode) {
	let form = document.getElementById("serverForm");
	
	// 경고
    swal({
        title: "삭제하시겠습니까?",
        text: "삭제된 게시글은 복구할 수 수 없습니다.",
        icon: "warning",
        buttons: true,
        dangerMode: true,
    })
        .then((willDelete) => {
            if (willDelete) {
            	form.appendChild(createInput("hidden","fbCode",fbCode,null,null));
            	form.action = "DeleteFBPost";
            	form.method = "post";
            	
            	form.submit();
            } else {
                swal("삭제를 취소하셨습니다.");
            }
    });
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
				<div class="postContent">
					${content}
					<!-- 댓글 내용 불러오기 -->
					${fbComment}
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