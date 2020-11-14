<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>


<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MSXT - 登录/注册</title>

    <!-- Bootstrap core CSS -->
    <style type="text/css">
        @import url("<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css" />");
    </style>

    <!-- Custom fonts for this template -->
    <style type="text/css">
        @import url("<c:url value="/resources/vendor/fontawesome-free/css/all.min.css" />");
        @import url("<c:url value="/resources/vendor/simple-line-icons/css/simple-line-icons.css" />");
    </style>
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- ADD CSS HERE! -->
    <style type="text/css">
        @import url("<c:url value="/resources/css/landing-page.min.css" />");
        @import url("<c:url value="/resources/css/login-page.css" />");
    </style>

</head>

<body>

<script>

</script>

<!-- Navigation -->
<nav class="navbar navbar-light bg-light static-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value="/main/list.html" />">MSXT</a>
    </div>
</nav>

<!-- Icons Grid -->
<section class="features-icons bg-light text-center">
    <div class="container">
        <div class="overlay" id="overlay">
            <div class="sign-in" id="sign-in">
                <h1>欢迎回来!</h1>
                <p>我们等着招待您！</p>
                <button class="switch-button" id="slide-right-button">登录</button>
            </div>
            <div class="sign-up" id="sign-up">
                <h1>哈喽!您是新来的吗？</h1>
                <p>请输入您的个人信息，和我们一起开始旅程吧</p>
                <button class="switch-button" id="slide-left-button">免费注册</button>
            </div>
        </div>

        <div class="form">
            <div class="sign-in" id="sign-in-info">
                <h1>登录</h1>
                    <sf:form method="POST" action="/mxst/user/login.html" id="sign-in-form" commandName="user" >
                        <sf:input path="userName" type="text" placeholder="账号名"/>
                        <sf:input path="password" type="password" placeholder="密码"/>
                        <button class="control-button in" type="submit">登录</button>
                    </sf:form>
            </div>

            <div class="sign-up" id="sign-up-info">
                <h1>账号注册</h1>
                <sf:form method="POST" action="/mxst/user/register.html" id="sign-up-form" commandName="user">
                    <sf:input path="userName" type="text" placeholder="账号名"/>
                    <sf:input path="password" type="password" placeholder="密码"/>
                    <button class="control-button up" type="submit">注册</button>
                </sf:form>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 h-100 text-center text-lg-left my-auto">
                <ul class="list-inline mb-2">
                    <li class="list-inline-item">
                        <a href="#">About</a>
                    </li>
                    <li class="list-inline-item">&sdot;</li>
                    <li class="list-inline-item">
                        <a href="#">Contact</a>
                    </li>
                    <li class="list-inline-item">&sdot;</li>
                    <li class="list-inline-item">
                        <a href="#">Terms of Use</a>
                    </li>
                    <li class="list-inline-item">&sdot;</li>
                    <li class="list-inline-item">
                        <a href="#">Privacy Policy</a>
                    </li>
                </ul>
                <p class="text-muted small mb-4 mb-lg-0">&copy; 【2020移动互联网软件工程】 ：徐志威，宋吉载  All Rights Reserved.</p>
            </div>
            <div class="col-lg-6 h-100 text-center text-lg-right my-auto">
                <ul class="list-inline mb-0">
                    <li class="list-inline-item mr-3">
                        <a href="#">
                            <i class="fab fa-facebook fa-2x fa-fw"></i>
                        </a>
                    </li>
                    <li class="list-inline-item mr-3">
                        <a href="#">
                            <i class="fab fa-twitter-square fa-2x fa-fw"></i>
                        </a>
                    </li>
                    <li class="list-inline-item">
                        <a href="#">
                            <i class="fab fa-instagram fa-2x fa-fw"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>


<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="<c:url value="/resources/vendor/jquery/jquery.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>

<script>
    var overlay = document.getElementById("overlay");

    // Buttons to 'switch' the page
    var openSignUpButton = document.getElementById("slide-left-button");
    var openSignInButton = document.getElementById("slide-right-button");

    // The sidebars
    var leftText = document.getElementById("sign-in");
    var rightText = document.getElementById("sign-up");

    // The forms
    var accountForm = document.getElementById("sign-in-info")
    var signinForm = document.getElementById("sign-up-info");

    // Open the Sign Up page
    openSignUp = () =>{
        // Remove classes so that animations can restart on the next 'switch'
        leftText.classList.remove("overlay-text-left-animation-out");
        overlay.classList.remove("open-sign-in");
        rightText.classList.remove("overlay-text-right-animation");
        // Add classes for animations
        accountForm.className += " form-left-slide-out"
        rightText.className += " overlay-text-right-animation-out";
        overlay.className += " open-sign-up";
        leftText.className += " overlay-text-left-animation";
        // hide the sign up form once it is out of view
        setTimeout(function(){
            accountForm.classList.remove("form-left-slide-in");
            accountForm.style.display = "none";
            accountForm.classList.remove("form-left-slide-out");
        }, 700);
        // display the sign in form once the overlay begins moving right
        setTimeout(function(){
            signinForm.style.display = "flex";
            signinForm.classList += " form-right-slide-in";
        }, 200);
    }

    // Open the Sign In page
    openSignIn = () =>{
        // Remove classes so that animations can restart on the next 'switch'
        leftText.classList.remove("overlay-text-left-animation");
        overlay.classList.remove("open-sign-up");
        rightText.classList.remove("overlay-text-right-animation-out");
        // Add classes for animations
        signinForm.classList += " form-right-slide-out";
        leftText.className += " overlay-text-left-animation-out";
        overlay.className += " open-sign-in";
        rightText.className += " overlay-text-right-animation";
        // hide the sign in form once it is out of view
        setTimeout(function(){
            signinForm.classList.remove("form-right-slide-in")
            signinForm.style.display = "none";
            signinForm.classList.remove("form-right-slide-out")
        },700);
        // display the sign up form once the overlay begins moving left
        setTimeout(function(){
            accountForm.style.display = "flex";
            accountForm.classList += " form-left-slide-in";
        },200);
    }

    // When a 'switch' button is pressed, switch page
    openSignUpButton.addEventListener("click", openSignUp, false);
    openSignInButton.addEventListener("click", openSignIn, false);
</script>

</body>

</html>