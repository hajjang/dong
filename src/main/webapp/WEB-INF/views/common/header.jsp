<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>동네한바퀴</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/js.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animation.css" />
<!-- 카카오 맵 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea166326e5dc5657d4a2feb24b4cfe0b&libraries=services"></script>
</head>
<style>
#headerImgDiv{
	width: 100%;
	text-align: center;
	margin-bottom: 50px;
}
#bogiImg{
	width:20px;
	height: 20px;
}
#headerMenu{
	width:30px;
	height: 30px;
}
#saleImg{
	width:35px;
	height: 40px;
    margin-left: 20px;
}
#shopImg{
	width:35px;
	height: 40px;
	margin-left: 20px;
}
#chatImg{
	width:38px;
	height: 40px;
	margin-left: 20px;
}
#button-addon2{
    height: 38px;
}
 ul{list-style:none; margin:0px; padding:0px; }
.one{float:left;}/* 전체 메뉴를 float 시킴 */
.one > li{float:left;}   /*1단 메뉴를 일렬로 늘어놓기 */
.one ul{display:none;}  /*2단, 3단 메뉴를 숨기기 */
.one li:hover > ul {display:block; background: white; z-index: 1;}  /*주 메뉴에 마우스 오버했을 때 부 메뉴 드러내기 */
.two{position:absolute; left:0px; top: 35px; }  /*2단 메뉴 절대 위치*/
.three{position:absolute;left:90px; top: 0px;}  /*3단 메뉴 절대 위치*/

ul li a{text-decoration:none; display:block; width:90px;height: 30px;line-height: 30px;text-align:center;} 
.one  li {width:90px;}  
one li:hover{background-color:#EAEAEA;}
a{
	text-decoration: none !important;
	color: black;
}
#categoryDiv {position:relative; margin-left:5px; zoom:1;} 
#categoryDiv:before, #header:after{content: " "; display: block; clear: both;}
#categoryDiv:after{clear: both;} 
#contents{width:50%; height: 300px; float:left ;margin:5px;}
</style>

<body>
<header>
<nav class="navbar navbar-expand-md navbar-light bg-light">

	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<!-- 회원 -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					회원
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">

					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberEnroll.do">회원가입</a>
					<c:if test="${memberLoggedIn == null }">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
					</c:if>
					<c:if test="${memberLoggedIn != null }">
						<a class="dropdown-item"
							href="${pageContext.request.contextPath }/member/memberLogOut.do">로그아웃</a>
					</c:if>
					<a class="dropdown-item" href="${pageContext.request.contextPath }/member/chargePoint.do">포인트 충전</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/findPassword.do">비밀번호
						찾기</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/findId.do">아이디 찾기</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberView.do">내 정보</a>
					<c:if test="${memberLoggedIn != null }">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberBye.do">회원 탈퇴</a>
					</c:if>
				</div>
			</li>

			<!-- 커뮤니티 -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					커뮤니티
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="${pageContext.request.contextPath}/board/boardList.do">게시글</a>
				</div>
			</li>

			<!-- 커뮤니티 -->
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">
					상점
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">

					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/shopView.do">내 상점</a>

				</div>
			</li>

		</ul>
	</div>
</nav>


<div id="headerImgDiv">
	<a href="${pageContext.request.contextPath}">
		<img id="headerImg" src="${pageContext.request.contextPath}/resources/images/header.PNG"/>
	</a>
</div>


<div class="container">
	<div class="row">
	
		<%-- <!--카테고리아이콘-->
		<div class="col-md-1">
			<div class="btn-group" id="categoryDiv">
				<a style="color:white;" class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
					<img id="headerMenu" src="${pageContext.request.contextPath}/resources/images/menuImg.PNG"/>
				</a>
				
				<div class="dropdown-menu">
					<a class="dropdown-item" href="#">의류</a> 
					<a class="dropdown-item" href="#">디지털</a> 
					<a class="dropdown-item" href="#">유아동</a>
					<a class="dropdown-item" href="#">뷰티</a>
					<a class="dropdown-item" href="#">운동</a>
					<a class="dropdown-item" href="#">재능</a>
					<a class="dropdown-item" href="#">구인구직</a>
				</div>
			</div>
		</div> --%>
		
		<div id="categoryDiv"> 
			<ul class="one"> 
  				<li>
  					<div id="menuImgDiv">
  					<a href="#"><img id="headerMenu" src="${pageContext.request.contextPath}/resources/images/menuImg.PNG"/></a>
    				</div>
    				<ul class="two">
    					<li><a href="">카테고리</a></li>
    					<hr />
       					<li><a href="#">패션</a>
       						<ul class="three">
         						<li><a href="#">여성패션</a>
         							<ul class="three">
         								<li><a href="#">티셔츠</a></li>
         								<li><a href="#">치마</a></li>
         								<li><a href="#">바지</a></li>
         								<li><a href="#">바지</a></li>
         								<li><a href="#">바지</a></li>
         								<li><a href="#">바지</a></li>
         								<li><a href="#">바지</a></li>
         								<li><a href="#">바지</a></li>
       								</ul>
         						</li>
         						<li><a href="#">sub3-2</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
       						</ul>
       					</li>
       					<li><a href="#">sub2</a>
       						<ul class="three">
         						<li><a href="#">sub3-1</a></li>
         						<li><a href="#">sub3-2</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
       						</ul>
       					</li>
       					<li><a href="#">sub3</a>
        					<ul class="three">
         						<li><a href="#">sub3-1</a>
         							<ul class="three">
         								<li><a href="#">sub3-1</a></li>
         								<li><a href="#">sub3-2</a></li>
         								<li><a href="#">sub3-3</a></li>
         								<li><a href="#">sub3-3</a></li>
         								<li><a href="#">sub3-3</a></li>
         								<li><a href="#">sub3-3</a></li>
       								</ul>
         						</li>
         						<li><a href="#">sub3-2</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
         						<li><a href="#">sub3-3</a></li>
       						</ul>
       					</li>
       					<li><a href="">메뉴이다</a></li>
       					<li><a href="">메뉴이다</a></li>
       					<li><a href="">메뉴이다</a></li>
       					<li><a href="">메뉴이다</a></li>
       					<li><a href="">메뉴이다</a></li>
    				</ul>
  				</li>
			</ul>
		</div>
		
	
		<!--검색창-->
		<div class="input-group col-md-7">
  			<input type="text" class="form-control" placeholder="검색어를 입력하세요" aria-label="Recipient's username" aria-describedby="button-addon2">
  			<div class="input-group-append">
    			<button class="btn btn-outline-secondary" type="button" id="button-addon2">
    				<img id="bogiImg" src="${pageContext.request.contextPath}/resources/images/bogi.png"/>
    			</button>
 			</div>
		</div>
		
		<!--메뉴-->
		<div>
			<a style="color:black; text-decoration: none;" href=""><img id="saleImg" src="${pageContext.request.contextPath}/resources/images/sale.PNG"/> 판매하기</a>
		</div>
		<div>
			<a style="color:black; text-decoration: none;" href="${pageContext.request.contextPath}/shop/shopView.do"><img id="shopImg" src="${pageContext.request.contextPath}/resources/images/shop.PNG"/> 내 상점</a>
		</div>
		<div>
			<a style="color:black; text-decoration: none;"href=""><img id="chatImg" src="${pageContext.request.contextPath}/resources/images/chat.PNG"/> 동네톡</a>
		</div>
	</div>
</div>	


	</header>

<!-- <script>
$("#categoryDiv .dropdown-toggle").click(function(){
	$.ajax({
		url:"${pageContext.request.contextPath}/common/header",
		dataType: "json",
		type: "GET",
		success: data => {
			console.log("성공");
		},
		error: (x,s,e)=>{
			console.log("실패",x,s,e);
		}
	});
});


</script> -->




<section>
	<div class="container" id="section">
	
	
	
	
	