<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="/res/js/agiMain.js"></script>
<script src="https://use.fontawesome.com/releases/v6.1.2/js/all.js"></script>
<link rel="stylesheet" href="/res/css/agiMain.css">
<!-- 알림창 꾸미기 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
#middle {
	display: flex;
	position: relative;
	justify-content: space-evenly;
	align-items: center;
}
	.mBtnP {
    height: 2.3rem;
    width: 8rem;
    box-shadow: 0px 5px 0px 0px rgb(239 157 171);
    background-color: rgb(255, 194, 204);
    font-size: 1.1rem;
    color: dimgray;
	}

	.mBtnP:hover {
		background-color: rgb(255, 234, 238);
	}

	.mBtnG {
		height: 2.3rem;
		width: 8rem;
		box-shadow: 0px 5px 0px 0px rgb(182, 182, 182);
		font-size: 1.1rem;
		color: dimgray;
		background: gainsboro;
	}

	.mBtnG:hover {
		background-color: rgb(255, 234, 238);
	}
	.mBtnX{    
		color: dimgray;
   		background: gainsboro;
   		height: 2.3rem;
   	 	width: 13rem;
   	 	box-shadow: 0px 5px 0px 0px rgb(182 182 182);
    	font-size: 1.1rem;
   		
	}
	#line{    
	position: absolute;
    border-left: 4px solid #C0C0C0;
    height: 60%;
    left: 50%;
    transform: translateX(-50%);
	}
	#left{
		margin-left: 3%;
		position: relative;
		height: 75%;
		width: 45%;
	}
	#right{
	display: flex;
    position: relative;
    height: 75%;
    width: 40%;
    align-items: center;
	}
	.west{
		height: 100%;
		width: 35%;
		float: left;
	}
	.sideWest{
		position: absolute;
    	margin-top: -11%;
    	margin-left: 4%;
	}
	.east{
		height: 100%;
		width: 65%;
		float: right;
	}
	.profile{
		border:  1px solid #C0C0C0;
		width: 200px;
		height: 200px;
		border-radius: 100%;
		margin: 3% 3%;
		margin-bottom: 17%;
	}
	.subBtn{
		margin-top: 15%;
		margin-left: 19%;
	}
	.tableDiv{
		width: 100%;
		height: 60%;
		font-size: 1.7rem;
		margin-top: 2.3rem;
		
	}
	table{
		border-spacing: 18px;
		width: 100%;
 	 	border-collapse: separate;
 	 	color:#616161;
	}
	table td {
		width: 80px;
	}
	.moveLeft{
    margin-top: -10%;
    font-size: 3rem;
    position: absolute;
    left: -3rem;
    cursor: pointer;
    color : #616161;
    display:none;
	}
	.moveRight{
    margin-top: -10%;
    font-size: 3rem;
    position: absolute;
    right: 0;
    cursor: pointer;
    color : #616161;
    display:none;
	}
	.insBabyTable{
		margin-left: 11%;
		margin-top: 3rem;
		font-size: 1.5rem;
		
	}
	.tdValue{
		text-align: left;
		padding-top: 4%;
	}
	.tdName{
		padding-top: 4%;
		text-align: right;
	}
	.modal{
		color: dimgray;
	}
	.name{
		font-size: 1.4rem;
		margin: 1%;
		color: dimgray;
	}
	.mBtnO {
    height: 2.5rem;
    width: 13rem;
    box-shadow: 0px 5px 0px 0px rgb(239 157 171);
    background-color: rgb(255, 194, 204);
    font-size: 1.1rem;
    color: dimgray;
	}
	.modal_foot{
position: relative;
    display: flex;
    margin: 13% auto;
    justify-content: space-between;
    width: 70%;
	}
	.modal_head{
		font-size: 3rem;
		height: 8%;
	}
	.modal_content{
		height: 70%;
	}
	.close{
		float:right;
	}
	.dateInput{
		width: 70%;
	}
	.editImage{
		width: 25%;
		height: 10%;
		position: relative;
		bottom: 17%;
		left: 68%;
		background-color:#fff1f1;
		border-radius: 400px;
	}
	.editImage:active{
		transform: translate(0px, 1px);
    -webkit-transform: translate(0px, 3px);
	}
	.profileImage{
	max-width: 100%;
    max-height: 100%;
    height: 100%;
    width: 100%;
    border-radius: 100%;}
    
    svg:not(:host).svg-inline--fa, svg:not(:root).svg-inline--fa {
    overflow: visible;
    box-sizing: content-box;
    background: none;
	}
	.theme{
	text-align: center;
	border-radius: 100px;
    border: 3px solid lightgray;
    width: 13%;
    height: 60%;
	display: inline-grid;
	margin-left: 3%;
	margin-top: 10%;
	}
	#themeList{
	order: 1px solid #000000;
    width: 100%;
    height: 30%;
    display: block;
    margin-top: 10%;
	}
	.checked::after{
	content: "✔";
    font-size: 425%;
    line-height: 16%;
    color: black;
	}
	#themeModalFoot{
	position: relative;
    display: flex;
    margin: 13% auto;
    justify-content: space-between;
    width: 80%;
    top: -15%;
    }
#address .profileInput {
	width: 50%;
}
#address {
	padding-right: 12%;
	box-sizing: border-box;
}
</style>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 네이버 스크립트 -->
<script	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<!-- 주소검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
//길이 체크
function isCharLengthCheck(text, minimum, maximum) {
	let result = false;
	if (maximum != null) {
		if (text.length >= minimum && text.length <= maximum) result = true;
	}
	else {
		if (text.length >= minimum) result = true;
	}
	return result;
}
Kakao.init('2afdabad57ed92e1cc9de5bd4baed321');
function getInfo() {
	/* 테마 이미지 or 단순색상 */
	let body = document.getElementById("body");
	let suTheme = "${accessInfo.suTheme}";
	
	if(suTheme != ""){
		if(suTheme.indexOf("#") == 0){
			//단순색상
			/* 테마 사용자값으로 설정 */
			//배경css제거
			body.className = "";
			let color = suTheme.split(":");
			body.style.background = color[0];
		}else{
			//배경이미지
			body.style.background = "none";
			body.className = "bgImage"+suTheme;
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
	
	//처음화면에서 필요없는 버튼숨기기
	let editConfirmBtn1 = document.getElementById("editConfirmBtn1");
	let editConfirmBtn2 = document.getElementById("editConfirmBtn2");
	
	editConfirmBtn1.style.display = "none";
	editConfirmBtn2.style.display = "none";
	
	//back에서 가져온 정보로 화면에 뿌려줌 => 부모정보, 아이정보
	let pImage = document.getElementById("pImage");
	let parentName = document.getElementById("parentName");
	let parentNickName = document.getElementById("parentNickName");
	let address = document.getElementById("address");
	
	//부모사진이 없으면 기본이미지 띄워줌
	
	if(!"${mypageInfo.suPhoto}" == ""){
		pImage.innerHTML = "<img class='profileImage' src=\'"+"${mypageInfo.suPhoto}"+"\'>";
	}else{
		pImage.innerHTML = "<img class='profileImage' src='/res/img/profile_default.png'>";
		//bImage.innerHTML = "<img class='profileImage' src='"+"/res/img/profile_default.png"+"'>";
	}
	
	parentName.innerText="${mypageInfo.suName}";
	parentNickName.innerText="${mypageInfo.suNickName}";
	address.innerText="${mypageInfo.suAddress}";
	
	let bImage = document.getElementById("bImage");
	let bbName = document.getElementById("bbName");
	let babyBirthDay = document.getElementById("bbBirthday");
	let bbHeight = document.getElementById("bbHeight");
	let bbWeight = document.getElementById("bbWeight");

	//아이사진이 없으면 기본이미지 띄워줌
	if(!"${mypageInfo.babyList[0].bbPhoto}" == ""){
		bImage.innerHTML = "<img class='profileImage' src='"+"${mypageInfo.babyList[0].bbPhoto}"+"'>";
	}else{ 
		bImage.innerHTML = "<img class='profileImage' src='"+"/res/img/profile_default.png"+"'>";
	}
	bbName.innerText="${mypageInfo.babyList[0].bbName}";
	babyBirthDay.innerText="${mypageInfo.babyList[0].bbBirthday}";
	bbHeight.innerText="${mypageInfo.babyList[0].bbHeight}"+"cm";
	bbWeight.innerText="${mypageInfo.babyList[0].bbWeight}"+"kg";
	
	//내 밑으로 두아이 이상이라면 '>' 버튼 보여줌
	if("${mypageInfo.babyList.size()}">1){
		let getBabyInfo = document.getElementById("getBabyInfo");
		getBabyInfo.style.display="block";
	}	
	if("${message}"!=""){
		swal("${title}", "${message}", "success", { button: "확인"});
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
//마이페이지 다른아이 프로필로 변경 :: '>' 가장 처음 클릭
function getBabyInfo(){
	// 맨처음 아이에서 다음아이 프로필 넘기는 버튼 눌렀을 때.한번만 사용함 이때 서버에가서 아이정보 json으로 다 가져옴
	let getBabyInfo = document.getElementById("getBabyInfo");
	getBabyInfo.remove();
	
	postAjaxJson("GetBabyInfo","","callbackGetBabyInfo");
}
//마이페이지 다른아이 프로필로 변경 :: 콜백함수
function callbackGetBabyInfo(jsonData){
	//위 함수에 상응하는 콜백함수
	
	// 첫아이는 <버튼을,마지막 아이는 >버튼을 숨겨줘야 하기 총 아이가 몇명인지 구함 
	// babyNum전역변수로 올린것도 같은이유.
	let babyCount = "${mypageInfo.babyList.size()}";
	
	// 가져온 모든 아이 정보가 담긴 배열을 전역변수에 저장.
	babyInfo = JSON.parse(jsonData);
	
	babyNum++;
	
	let babyImage = document.getElementById("bImage");
	let bbName = document.getElementById("bbName");
	let babyBirthDay = document.getElementById("bbBirthday");
	let bbHeight = document.getElementById("bbHeight");
	let bbWeight = document.getElementById("bbWeight");
	
	if(!babyInfo.babyList[babyNum].bbPhoto == ""){
		babyImage.innerHTML = "<img class=\"profileImage\" src='"+babyInfo.babyList[1].bbPhoto+"'>";
	}else{					

		babyImage.innerHTML = "<img class='profileImage' src='/res/img/profile_default.png'>";
	}
	
	bbName.innerText = babyInfo.babyList[babyNum].bbName;
	babyBirthDay.innerText=babyInfo.babyList[babyNum].bbBirthday;
	bbHeight.innerText=babyInfo.babyList[babyNum].bbHeight+"cm";
	bbWeight.innerText=babyInfo.babyList[babyNum].bbWeight+"kg";
	
	let num = babyNum;
	num++;

	
	if(babyCount>num){
		// 왼쪽 div 보여지게하고 오른쪽 div는 삭제후 새로 만들어서 넣어주기
		let minus = document.getElementById("minus");
		minus.style.display = "block";
		
		let plus = document.getElementById("plus");
		plus.style.display = "block";
	}else{
		// 오른쪽 div없어지고 왼쪽 div만 보여지게 함
		let minus = document.getElementById("minus");
		minus.style.display = "block";
		let plus = document.getElementById("plus");
		plus.style.display = "none";
	}
}
//마이페이지 현재보이는 아이프로필을 다른아이로 변경 :: >,<버튼 클릭
function changeBaby(number){
	
	let size = "${mypageInfo.babyList.size()}"; 

	if(number=="1"){ //플러스'>' 눌렀을 때
		
		if(babyNum>=0){
			babyNum++;
			
			let babyImage = document.getElementById("bImage");
			let bbName = document.getElementById("bbName");
			let babyBirthDay = document.getElementById("bbBirthday");
			let bbHeight = document.getElementById("bbHeight");
			let bbWeight = document.getElementById("bbWeight");
			
			if(!babyInfo.babyList[babyNum].bbPhoto == ""){
				babyImage.innerHTML = "<img class=\"profileImage\" src='"+babyInfo.babyList[babyNum].bbPhoto+"'>";
			}else{
				babyImage.innerHTML = "<img class='profileImage' src='/res/img/profile_default.png'>";
			}

			bbName.innerText = babyInfo.babyList[babyNum].bbName;
			babyBirthDay.innerText=babyInfo.babyList[babyNum].bbBirthday;
			bbHeight.innerText=babyInfo.babyList[babyNum].bbHeight+"cm";
			bbWeight.innerText=babyInfo.babyList[babyNum].bbWeight+"kg";
			
			let num = babyNum;
			num++;
			
			//마지막 아기일때 플러스'>'버튼만 막아주면 됨
			
			if(size == num){
				let plus = document.getElementById("plus");
				plus.style.display="none";
				let minus = document.getElementById("minus");
				minus.style.display="block";
			}else{
				let plus = document.getElementById("plus");
				plus.style.display="block";
				let minus = document.getElementById("minus");
				minus.style.display="block";
			}
		}
		
	}else{ //마이너스'<' 눌렀을떄
		babyNum--;
	
		let babyImage = document.getElementById("bImage");
		let bbName = document.getElementById("bbName");
		let babyBirthDay = document.getElementById("bbBirthday");
		let bbHeight = document.getElementById("bbHeight");
		let bbWeight = document.getElementById("bbWeight");

		if(!babyInfo.babyList[babyNum].bbPhoto == ""){
			babyImage.innerHTML = "<img class=\"profileImage\" src='"+babyInfo.babyList[babyNum].bbPhoto+"'>";
		}else{
			babyImage.innerHTML = "<img class='profileImage' src='/res/img/profile_default.png'>";
		}		
		bbName.innerText = babyInfo.babyList[babyNum].bbName;
		babyBirthDay.innerText=babyInfo.babyList[babyNum].bbBirthday;
		bbHeight.innerText=babyInfo.babyList[babyNum].bbHeight+"cm";
		bbWeight.innerText=babyInfo.babyList[babyNum].bbWeight+"kg";
		
		//가장 첫번째 아기일 때 <버튼만 막아주면 됨
		if(babyNum==0){
			let plus = document.getElementById("plus");
			plus.style.display="block";
			let minus = document.getElementById("minus");
			minus.style.display="none";
		}else{
			let plus = document.getElementById("plus");
			plus.style.display="block";
			let minus = document.getElementById("minus");
			minus.style.display="block";
		}
	}

}
let babyInfo;
let babyNum = 0;
//부모프로필변경 :: 부모쪽 프로필변경 클릭 :: 관련없는 다른 버튼들 지워주기
function changeParentProfile(){
	//부모 프로필 수정버튼 눌렀을 때
	//닉네임
	let parentNickName = document.getElementById("parentNickName");
	//주소
	let address = document.getElementById("address");
	//수정가능한 부분을 인풋박스로 바꿔줌 
	parentNickName.innerHTML = "<input type=\"text\" name='suNickName' class=\"profileInput\" onchange=\"change()\" placeholder=\"${mypageInfo.suNickName}\">"
					+"<input type = \"button\" value=\"중복체크\" class=\"checkBtn btn\" onclick = \"checkOverlap()\">";
	address.innerHTML = "<input type =\"text\" name =\"suAddress\" class=\"profileInput\" placeholder=\"${mypageInfo.suAddress}\" readonly/>"
					+"<input type = \"button\" value=\"주소검색\" id = \"checkSuAddress\" class=\"checkBtn btn\" onclick = \"checkAddress()\">";
	
	// 아이쪽 <,>버튼을 숨겨줌 0:숨김 1:나타남
	cover("1");
	
	// 부모 프로필 수정과 관련되지 않은 버튼들 없애주기
	let editConfirmBtn1 = document.getElementById("editConfirmBtn1");
	let leftWest = document.getElementById("leftWest");
	let rightWest = document.getElementById("rightWest");	

	editConfirmBtn1.style.display = "block";
	leftWest.style.display =  "none";
	rightWest.style.display = "none";
}
let check = false;
//닉네임 중복체크
function checkOverlap() {
	//0:? 1:닉네임
	let nickName = document.getElementsByName("suNickName")[0];
	if(nickName.value!=""){
		let clientData = "code=1&suNickName="+nickName.value;
		postAjaxJson("CheckPersonalOverlap",clientData,"callBackOverlap");
	} else {
		swal("중복체크", "변경할 닉네임을 입력하세요!", "waring", { button: "확인"});
	}
}
//중복체크 콜백
function callBackOverlap(ajaxData) {
	if(ajaxData=="ok"){
		swal("중복체크", "사용 가능한 닉네임입니다!", "success", { button: "확인"});
		check = true;
	}
	else {
		swal("중복체크", "사용 불가능한 닉네임입니다!", "error", { button: "확인"});
		check = false;
	}
}
//닉네임 중복체크 후 다시 변경 시
function change() {
	check = false;
}
/* 주소 검색 API */
function checkAddress() {
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementsByName("suAddress")[0].value = data.bname; // 주소 넣기
            }
        }).open();
}
//부모프로필변경 :: 수정완료버튼 클릭
function changeParentInfo(){
	let nickName = document.getElementsByName("suNickName")[0];
	let address = document.getElementsByName("suAddress")[0];
	let form = document.getElementById("serverForm");
	if((nickName.value==""&&address.value=="")){
		nickName.focus();
	}else if(nickName.value!=""&&!isCharLengthCheck(nickName.value,"1","20")){
		nickName.focus();
	}
	else{
		form.appendChild(createInput("hidden","suNickName",nickName.value,null,null));
		form.appendChild(createInput("hidden","suAddress",address.value,null,null));
		form.action = "ChangeParentInfo";
		form.method = "post";
		
		form.submit();
	}
}
//부모 프로필 변경 :: 취소 :: 수정하지않고 취소 눌렀을 때 텍스트박스 = > 원상복구
function parentEditCancel(){
	let editConfirmBtn1 = document.getElementById("editConfirmBtn1");
	let leftWest = document.getElementById("leftWest");
	let rightWest = document.getElementById("rightWest");
	
	editConfirmBtn1.style.display = "none";
	leftWest.style.display = "block";
	rightWest.style.display = "block";
	// <,> 보여주기
	cover("0");
	
	let parentNickName = document.getElementById("parentNickName");
	let address = document.getElementById("address");
	
	parentNickName.innerText="${mypageInfo.suNickName}";
	address.innerText="${mypageInfo.suAddress}";
}
let bbName = "";
let bbBirthday = "";
//아이프로필변경 :: 아이쪽 프로필변경 클릭 :: 관련없는 다른 버튼들 지워주기
function changeBabyProfile(){

	let editConfirmBtn2 = document.getElementById("editConfirmBtn2");
	let leftWest = document.getElementById("leftWest");
	let rightWest = document.getElementById("rightWest");
	
	editConfirmBtn2.style.display = "block";
	leftWest.style.display = "none";
	rightWest.style.display = "none";
	// <,> 가려주기
	cover("1");
	
	// 현재 저장된 프로필 값 input박스 value로 넣어 사용자에게 보여주기
	let bbBirthdayTd = document.getElementById("bbBirthday");
	
	bbBirthday = bbBirthdayTd.innerText;
	bbBirthdayTd.innerHTML = "<input type=\"date\" name='bbBirthday' class=\"profileInput dateInput\" value=\""+bbBirthday+"\">";

}
//아이프로필변경 :: 수정완료버튼 클릭
function changeBabyInfo(){
	let babyNumber;
	let bbNameInput = document.getElementsByName("bbName")[0];
	let bbBirthdayInput = document.getElementsByName("bbBirthday")[0];
	let form = document.getElementById("serverForm");
	

	if(babyInfo == null){
		babyNumber = "${mypageInfo.babyList[0].bbCode}";
		
	}else{
		babyNumber = babyInfo.babyList[babyNum].bbCode;
	}
	
	form.appendChild(createInput("text","bbCode",babyNumber,"",""));
	form.appendChild(bbBirthdayInput);
	
	form.action = "ChangeBabyInfo";
	form.method = "post";
	
	form.submit();
}

//아이 프로필 변경 :: 취소 :: 수정하지않고 취소 눌렀을 때 텍스트박스 = > 원상복구
function babyEditCancel(){
	
	let editConfirmBtn2 = document.getElementById("editConfirmBtn2");
	let leftWest = document.getElementById("leftWest");
	let rightWest = document.getElementById("rightWest");
	
	editConfirmBtn2.style.display = "none";
	leftWest.style.display = "block";
	rightWest.style.display = "block";
	// <,> 보여주기
	cover("0");
	
	let bbBirthdayTd = document.getElementById("bbBirthday");
	
	bbBirthdayTd.innerText = bbBirthday;
}
//아이정보 <왼쪽 >오른쪽 버튼 가려주기
function cover(number){
	let getBabyInfo = document.getElementById("getBabyInfo");
	let minus = document.getElementById("minus");
	let plus = document.getElementById("plus");
	
	
	if(number==1){
		
		minus.style.opacity = "0%";
	
		if(babyInfo == null){
			getBabyInfo.style.opacity = "0%";
			
		}else{
			plus.style.opacity = "0%";
		}
	}else{
		
		minus.style.opacity = "100%";
		
		if(babyInfo == null){
			getBabyInfo.style.opacity = "100%";
			
		}else{
			plus.style.opacity = "100%";
		}
	}
}

//아이추가 :: 모달창 구성
function insertBabyModal(){
	let modal = document.querySelector(".modal");
	let modalHead = document.querySelector(".modal_head");
	let modalContent = document.querySelector(".modal_content");
	let modalFoot = document.querySelector(".modal_foot");


	modal.style.display = "block";
	modalHead.innerHTML = "<div class='insBabyTitle'>아이 추가</div>";
	modalContent.innerHTML = "<table class='insBabyTable'><tr><td class='tdName'><span class='name'>아이 이름 :</span></td><td class='tdValue'><input class='mBasicInput name'type='text' name='bbName' placeholder='이름' required></td></tr>"
							+"<tr><td class='tdName'><span class='name'>출생일 :</span></td><td class='tdValue'><input class='mBasicInput name' type='date' name='bbBirthday' placeholder='출생일' required></td></tr>"
							+"<tr><td class='tdName'><span class='name'>키 :</span></td><td class='tdValue'><input class='mMiniInput name'type='text' name='bbHeight' placeholder='cm' required></td></tr>"
							+"<tr><td class='tdName'><span class='name'>몸무게 :</span></td><td class='tdValue'><input type='text' class='mMiniInput name' name='bbWeight' placeholder='kg' required></td></tr></table>";
	modalFoot.innerHTML = "<button class='mBtnX' onclick='modalClose()'>취소</button><button class='mBtnO' onclick='insertBabyInfo()'>추가</button>";


}
//아이 추가 :: 아이 추가 제출
function insertBabyInfo(){
	let form = document.getElementById("InsertBabyInfo");
	let bbName = document.getElementsByName("bbName")[0];
	let bbBirthday = document.getElementsByName("bbBirthday")[0];
	let bbHeight = document.getElementsByName("bbHeight")[0];
	let bbWeight = document.getElementsByName("bbWeight")[0];
	//이름 글자 제한
	if(!isCharLengthCheck(bbName.value,"1","20")){

		swal("경고", "아이 이름은 1자~20자 사이로 입력해 주세요!", "error", { button: "확인"});
		bbName.focus();
		return;
	}
	form.action = "InsertBabyInfo";
	form.method = "post";
	
	form.submit();
	modalClose();
}
//모달닫기
function modalClose(){
	let modal = document.querySelector(".modal");
	let modalHead = document.querySelector(".modal_head");
	let modalContent = document.querySelector(".modal_content");
	let modalFoot = document.querySelector(".modal_foot");
	
	modal.style.display="none";
	modalHead.innerHTML = "";
	modalContent.innerHTML = "";
	modalFoot.innerHTML = "";
}
//프로필사진 변경 :: 카메라모양하고 hidden처리한 input type="file" 연결
function onClickUpload(num) {
	if(num == "1"){
		//부모프사 :: 파일 선택하는 인풋 연결
		let imgInput = document.getElementsByName("file")[0];
		imgInput.click();
	}else{
		//아이프사 :: 파일 선택하는 인풋 연결
		let imgInput = document.getElementsByName("file")[1];
		imgInput.click();
	}
}
//프로필사진 변경 :: 파일 선택하고 해당 파일, 필요한 정보 서버로 전송
function submitPhoto(num){
	if(num == "1"){
		//부모프사
		let imgInput = document.getElementsByName("file")[0];
		let form = document.getElementById("clientData");
		
		//폼에 담아 서버전송
		form.appendChild(imgInput);
		form.appendChild(createInput("hidden","suCode","${mypageInfo.suCode}",null,null));
		form.action = "UploadParentImage";
		form.method = "post";
		form.enctype = "multipart/form-data";
		form.submit();
	}else{
		//아이프사
		let imgInput = document.getElementsByName("file")[1];
		let form = document.getElementById("clientData");
		
		//아이코드
		if(babyInfo == null){
			babyCode = "${mypageInfo.babyList[0].bbCode}";
		}else{
			babyCode = babyInfo.babyList[babyNum].bbCode;
		}
		//폼에 담아 서버전송
		form.appendChild(imgInput);
		form.appendChild(createInput("hidden","bbCode",babyCode,"",""));
		form.action = "UploadBabyImage";
		form.method = "post";
		form.enctype = "multipart/form-data";
		form.submit();
	}
}
/* 테마변경 */
function clickChangeTheme(){
	let themeModal = document.getElementById("changeThemeModal")
	themeModal.style.display = "block";
}
let theme ="";
function selectTheme(num){
	let themeList = document.getElementById("themeList");
	let child = themeList.childNodes;
	let modalFoot = document.getElementById("themeModalFoot");
	
	for(idx=0;idx<20;idx++){
		if(idx == num){
			if(child[num].classList.contains("checked")){
				child[num].classList.remove("checked");
				theme = num;
				modalFoot.innerHTML="<button class=\'mBtnX\' onclick=\'themeModalClose()\'>취소</button><button class=\'mBtnO\' onclick=\'changeTheme(\'0\')\'>변경</button>";
			}else{
				child[num].classList.add("checked");
				modalFoot.innerHTML="<button class=\'mBtnX\' onclick=\'themeModalClose()\'>취소</button><button class=\'mBtnO\' onclick=\'changeTheme("+num+")\'>변경</button>";
			}
		}else{
			child[idx].className="theme";
		
		}
	}
}
function themeModalClose(){
	let themeModal = document.getElementById("changeThemeModal")
	themeModal.style.display = "none";
	let modalFoot = document.getElementById("themeModalFoot");
	//현재테마로 설정 변경하고
	
	//버튼도 다시 0으로 설정
	modalFoot.innerHTML="<button class=\'mBtnX\' onclick=\'themeModalClose()\'>취소</button><button class=\'mBtnO\' onclick=\'changeTheme(\'0\')\'>변경</button>";
}
function changeTheme(num){
	let clientData = "";
	switch(num){
	case 1 : //핑크
		clientData = "suTheme=#fff1f1:#ffd4d4";
		break;
	case 3 : //노랑
		clientData = "suTheme=#F9F5E0:#F5EECB";
		break;
	case 5 : //파랑
		clientData = "suTheme=#E5F0F8:#D1E4F3";
		break;
	case 7 : //보라
		clientData = "suTheme=#E0E4F9:#CBD2F5";
		break;
	case 9 : //초록
		clientData = "suTheme=#F1F9E0:#E7F5CB";
		break;
	case 11 : //1
		clientData = "suTheme=1";
		break;
	case 13 : //2
		clientData = "suTheme=2";
		break;
	case 15 : //3
		clientData = "suTheme=3";
		break;
	case 17 : //4
		clientData = "suTheme=4";
		break;
	case 19 : //5
		clientData = "suTheme=5";
		break;
	}
	postAjaxJson("ChangeTheme",clientData,"callBackTheme");
	
}
function callBackTheme(theme){
	swal("테마변경", "테마변경을 완료하였습니다!", "success", { button: "확인"});
	//let middle = document.getElementById("middle");
	let body = document.getElementById("body");
	let sideMenu = document.querySelector(".side-menu");
	
	if(theme.indexOf("#") == 0){
		//단순색상
		body.className = "";
		let color = theme.split(":");
		
		body.style.background = color[0];
	}else{
		//단순이미지
		body.style.background = "none";
		body.className = "bgImage"+theme;
		
	}
	themeModalClose();
}
</script>
</head>
<body onload="getInfo()">
</head>
<body id="body">
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
			<div id="left">
				<div  class="west">
					<div class="profile" id="pImage"></div>
					<i class="fa-solid fa-camera editImage mUpdBtn" id="parentImage" onclick="onClickUpload('1')" ></i>					
					<div id="leftWest"  class="sideWest">
						<div class="subBtn">
							<button class="mBtnP btn" onclick="changeParentProfile()">프로필 수정</button>
						</div>
						<div class="subBtn">
							<button class="mBtnG btn" onclick="clickChangeTheme()">테마 변경</button>
						</div>
					</div>
				</div>
				<div id="leftEast" class="east">
					<div class="tableDiv">
						<table >
							<tr>
								<td><span >이름</span></td>
								<td colspan="2" id="parentName"></td>
							</tr>
							<tr>
								<td><span >닉네임</span></td>
								<td colspan="2" id="parentNickName"></td>
							</tr>
							<tr>
								<td><span>주소</span></td>
								<td colspan="2" id="address"></td>
							</tr>
						</table>
					</div>
					<diV id="editConfirmBtn1">
					<button class="subBtn mBtnG btn" onclick="parentEditCancel()">취소</button>
					<button class="mBtnP btn" onclick="changeParentInfo()">수정완료</button>
					</div>
				</div>
			</div>

			<div id="line"></div>
			
			<div id="right">
				<div class="moveLeft" id="minus" onclick="changeBaby('-1')">◁</div>
				<div class="west">
					<div class="profile" id="bImage"></div>
					<i class="fa-solid fa-camera editImage mUpdBtn" id="babyImage" onclick="onClickUpload('2')" ></i>					
					<div id="rightWest" class="sideWest">
						<div class="subBtn">
							<button class="mBtnP btn" onclick="changeBabyProfile()" >프로필 수정</button>
						</div>
						<div class="subBtn">
							<button class="mBtnG btn" onclick="insertBabyModal()">아이 추가</button>
						</div>
					</div>
				</div>
				<div id="rightEast" class="east">
					<div class="tableDiv">
						<table >
							<tr>
								<td><span >이름</span></td>
								<td colspan="2" id="bbName"></td>
							</tr>
							<tr>
								<td><span>생일</span></td>
								<td colspan="2" id="bbBirthday"></td>
		
							</tr>
							<tr>
								<td><span>키</span></td>
								<td colspan="2" id="bbHeight"></td>
							</tr>
							<tr>
								<td><span>몸무게</span></td>
								<td colspan="2" id="bbWeight"></td>
							</tr>
						</table>
					</div>
					<div id="editConfirmBtn2">
						<button class="subBtn mBtnG btn" onclick="babyEditCancel()">취소</button>
						<button class="mBtnP btn" onclick="changeBabyInfo()">수정완료</button>
					</div>
				</div>
				<div class="moveRight" id="getBabyInfo" onclick="getBabyInfo()">▷</div>
				<div class="moveRight" id="plus" style="display:none;" onclick="changeBaby('1')">▷</div>
			</div>
		</div>
		<div class="modal">
            <div class="modal_body">
            	<form id="InsertBabyInfo">
				<div class="modal_head">
					<i class="fa-solid fa-xmark closeBtn editBtn"></i><br />
				</div>
				<div class="modal_content"></div>
				<div class="modal_foot"></div>
				</form>
            </div>
        </div>
        <div class="modal" id="changeThemeModal" style="display : none;" >
            <div class="modal_body">
				<div class="modal_head">테마선택
				</div>
				<div class="modal_content">
					<div id ="themeList">
					<div class="theme" style="background-color:#fff1f1;" onclick="selectTheme('1')">&nbsp;</div>
					<div class="theme" style="background-color:#F9F5E0;" onclick="selectTheme('3')">&nbsp;</div>
					<div class="theme" style="background-color:#E5F0F8;" onclick="selectTheme('5')">&nbsp;</div>
					<div class="theme" style="background-color:#E0E4F9;" onclick="selectTheme('7')">&nbsp;</div>
					<div class="theme" style="background-color:#F1F9E0;" onclick="selectTheme('9')">&nbsp;</div>
					<div class="theme" style="background-image:url('/res/img/background1.jpg');  background-size : cover;" onclick="selectTheme('11')">&nbsp;</div>
					<div class="theme" style="background-image:url('/res/img/background2.jpg');  background-size : cover;" onclick="selectTheme('13')">&nbsp;</div>
					<div class="theme" style="background-image:url('/res/img/background3.jpg');  background-size : cover;" onclick="selectTheme('15')">&nbsp;</div>
					<div class="theme" style="background-image:url('/res/img/background4.jpg');  background-size : cover;" onclick="selectTheme('17')">&nbsp;</div>
					<div class="theme" style="background-image:url('/res/img/background5.jpg');  background-size : cover;" onclick="selectTheme('19')">&nbsp;</div>
					</div>
				</div>
				<div class="modal_foot" id="themeModalFoot"><button class='mBtnX' onclick='themeModalClose()'>취소</button><button class='mBtnO' onclick='changeTheme(0)'>변경</button></div>
            </div>
        </div>
	</div>
	<form id="clientData" ></form>
	<input style="visibility: hidden;" type="file" name="file" onchange="submitPhoto('1');" accept="image/*">
	<input style="visibility: hidden;" type="file" name="file" onchange="submitPhoto('2');" accept="image/*">
	<form id="serverForm"></form>
<script>
</script>
</body>
</html>