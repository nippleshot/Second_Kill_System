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

    <title>MSXT - µçÉÌÃëÉ±</title>

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
        <a class="navbar-brand" href="<c:url value="/main/list.html" />">MSXT</a>
        <button class="btn btn-primary" onClick="location.href='<c:url value="/user/login.html" />'">µÇÂ¼ / ×¢²á</button>
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
                    <c:when test="${product.value == 1}">
                        <div class="col-md-3 col-sm-6">
                            <div class="product-grid4">
                                <div class="product-image4">
                                    <a href="#">
                                        <img class="pic-1" src="<c:out value="${product.key.photo}"/>" >
                                    </a>

                                    <span class="product-new-label">ÃëÉ±¿ªÊ¼</span>
                                </div>
                                <div class="product-content">
                                    <h3 class="title"><c:out value="${product.key.productName}"/></h3>
                                    <div class="price">
                                        <c:out value="${product.key.priceSpike}"/>
                                        <span><c:out value="${product.key.price}"/></span>
                                    </div>
                                    <a class="add-to-cart" onClick='alert("ÇëµÇÂ¼/×¢²á"); return false'>Á¢¼´¹ºÂò</a>
                                </div>
                            </div>
                        </div>
                    </c:when>

                    <c:when test="${product.value == 2}">
                        <div class="col-md-3 col-sm-6">
                            <div class="product-grid4">
                                <div class="product-image4">
                                    <a href="#">
                                        <img class="pic-1" src="<c:out value="${product.key.photo}"/>" >
                                    </a>

                                    <span class="product-new-label">ÒÑÊÛóÀ</span>
                                </div>
                                <div class="product-content">
                                    <h3 class="title"><c:out value="${product.key.productName}"/></h3>
                                    <div class="price">
                                        <c:out value="${product.key.priceSpike}"/>
                                        <span><c:out value="${product.key.price}"/></span>
                                    </div>
                                    <a class="add-to-cart" href="void(0);" onClick='alert("ÇëµÇÂ¼/×¢²á"); return false'>ÒÑÊÛóÀ</a>
                                </div>
                            </div>
                        </div>
                    </c:when>

                    <c:when test="${product.value == 3}">
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
                                        <c:out value="${product.key.priceSpike}"/>
                                        <span><c:out value="${product.key.price}"/></span>
                                    </div>
                                    <a class="add-to-cart" href="void(0);" onClick='alert("ÇëµÇÂ¼/×¢²á"); return false'>»î¶¯½áÊø</a>
                                </div>
                            </div>
                        </div>
                    </c:when>

                    <c:when test="${product.value == 4}">
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
                                        <c:out value="${product.key.priceSpike}"/>
                                        <span><c:out value="${product.key.price}"/></span>
                                    </div>
                                    <a class="add-to-cart" href="void(0);" onClick='alert("ÇëµÇÂ¼/×¢²á"); return false'>»î¶¯Ã»¿ª</a>
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
                <p class="text-muted small mb-4 mb-lg-0">&copy; ¡¾2020ÒÆ¶¯»¥ÁªÍøÈí¼þ¹¤³Ì¡¿ £ºÐìÖ¾Íþ£¬ËÎ¼ªÔØ   All Rights Reserved.</p>
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