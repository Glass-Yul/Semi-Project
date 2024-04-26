<%@page import="data.user.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 그 이상의 감동</title>
<link rel="shortcut icon" href="../img/common/favicon.ico"
	type="image/x-icon">
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />
<link rel="stylesheet" href="../resource/css/nice_select.css">
<link rel="stylesheet" href="../resource/css/swiper.css">
<link rel="stylesheet" href="../resource/css/reset.css">
<link rel="stylesheet" href="../resource/css/style.css">
</head>
<%
String myid = (String) session.getAttribute("username");
System.out.println(myid);
%>
<!-- pop-up -->
<div class=top_banner>
	<div>
		<img alt="" src="../img/common/top_banner.png">
	</div>
	<div class="btn">
		<img alt="" src="../img/common/x_btn.png">
	</div>
</div>
<!-- //pop-up -->

<!-- top_btn -->
<div class="top_btn">
	<div class="btn"></div>
	<div class="link">
		<a href="../reservation/reservationForm.jsp">예매하기</a>
	</div>
</div>
<!-- //top_btn -->

<!-- header -->
<header id="header">
	<div class="content">
		<div>
			<div class="logo">
				<a href="../index.jsp"> <img alt="" src="../img/common/logo.png">
				</a>
			</div>
			<div class="memberinfo">
				<ul>

					<%
					if (myid == null) {
					%>
					<li><a href="../log/loginForm.jsp"> <img alt=""
							src="../img/common/login.png"> <span>로그인</span>
					</a></li>
					<%
					}
					%>
					<%
					if (myid != null) {
					%>
					<li><a href="../log/logoutAction.jsp"> <img alt=""
							src="../img/common/logout.png"> <span>로그아웃</span>
					</a></li>
					<%
					}
					%>
					<%
					if (myid == null) {
					%>
					<li><a href="../join_membership/joinForm.jsp"> <img alt=""
							src="../img/common/sign_up.png"> <span>회원가입</span>
					</a></li>
					<%
					}
					%>

					<%
					if (myid == null) {
					%>
					<li><a href="../log/loginForm.jsp"> <img alt=""
							src="../img/common/mypage.png"> <span>MY PAGE</span>
					</a></li>
					<%
					}
					%>
					<%
					if (myid != null) {
					%>
					<li><a href="../mypage/myHome.jsp"> <img alt=""
							src="../img/common/mypage.png"> <span>MY PAGE</span>
					</a></li>
					<%
					}
					%>
					<li><a href="../customer/faq.jsp"> <img alt=""
							src="../img/common/customer.png"> <span>고객센터</span>
					</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="nav">
		<div>
			<nav>
				<ul>
					<li class="hidden_logo"><a href="../index.jsp"><img alt=""
							src="../img/common/wh_logo.png"></a></li>
					<li><a href="../movie/movieShowRate.jsp">영화</a></li>
					<li><a href="../ticket/ticket.jsp">극장</a></li>
					<li class="active"><a
						href="../reservation/reservationForm.jsp">예매</a></li>
					<li><a href="javascript:;">스토어</a></li>
					<li><a href="javascript:;">이벤트</a></li>
					<li><a href="javascript:;">혜택</a></li>
				</ul>
			</nav>
			<div class="search">
				<input placeholder="영화를 검색해보세요">
				<button type="button">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-search header_search"
						viewBox="0 0 16 16">
  <path
							d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
</svg>
				</button>
			</div>
		</div>
	</div>
</header>
<!-- //header -->