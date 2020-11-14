<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>


<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MSXT - 电商秒杀</title>

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
        @import url("<c:url value="/resources/css/main_grid4.css" />");
    </style>

</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-light bg-light static-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value="/main/list/manager.html?managerId=${managerId}&managerName=${managerName}" />">MSXT</a>
        <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                <c:out value="${managerName}"/>
            </button>
            <div class="dropdown-menu">
                <a class="dropdown-item" href="<c:url value="/product/list.html?managerId=${managerId}&managerName=${managerName}" />">商品管理</a>
                <a class="dropdown-item">订单管理</a>
                <a class="dropdown-item" href="<c:url value="/main/list.html" />">退出</a>
            </div>
        </div>
    </div>
</nav>

<!-- Masthead -->
<header class="masthead text-white text-center">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-xl-9 mx-auto">
                <h1 class="mb-5">Best Deal  <p class="list-inline-item">&sdot;</p>  Great Price</h1>
            </div>
        </div>
    </div>
</header>

<!-- Icons Grid -->
<section class="features-icons bg-light text-center">
    <div class="container">
        <div class="row">

            <c:forEach items="${allProduct}" var="product" >
                <c:choose>
                    <c:when test="${product.value eq true}">
                            <div class="col-md-3 col-sm-6">
                                <div class="product-grid4">
                                    <div class="product-image4">
                                        <a href="#">
                                            <img class="pic-1" src="<c:out value="${product.key.photo}"/>" >
                                        </a>

                                        <span class="product-new-label">秒杀开始</span>
                                    </div>
                                    <div class="product-content">
                                        <h3 class="title"><c:out value="${product.key.productName}"/></h3>
                                        <div class="price">
                                            <c:out value="${product.key.priceSpike}"/>
                                            <span><c:out value="${product.key.price}"/></span>
                                        </div>
                                        <a class="add-to-cart" href="/order?userId=${managerId}&productId=${product.key.productId}">立即购买</a>
                                    </div>
                                </div>
                            </div>
                    </c:when>

                    <c:when test="${product.value eq false}">
                            <div class="col-md-3 col-sm-6">
                                <div class="product-grid4">
                                    <div class="product-image4">
                                        <a href="#">
                                            <img class="pic-1" src="<c:out value="${product.key.photo}"/>" >
                                        </a>
                                    </div>
                                    <div class="product-content">
                                        <h3 class="title"><c:out value="${product.key.productName}"/></h3>
                                        <div class="price">
                                            <c:out value="${product.key.price}"/>
                                        </div>
                                        <a class="add-to-cart" href="/order?userId=${managerId}&productId=${product.key.productId}">立即购买</a>
                                    </div>
                                </div>
                            </div>
                    </c:when>
                </c:choose>
            </c:forEach>
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

</body>

</html>