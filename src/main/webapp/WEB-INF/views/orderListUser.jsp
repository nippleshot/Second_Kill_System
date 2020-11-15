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

    <title>MSXT - 订单列表</title>

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
        @import url("<c:url value="/resources/css/order-list.css" />");
    </style>


</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-light bg-light static-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value="/main/list/user.html?userId=${userId}&userName=${userName}&userBalance=${userBalance}" />">MSXT</a>
        <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                <c:out value="${userName}"/>
            </button>
            <div class="dropdown-menu">
                <a class="dropdown-item">我的余额 ： <c:out value="${userBalance}"/> </a>
                <a class="dropdown-item" href="/msxt/user/charge.html?userId=${userId}">充值金额</a>
                <a class="dropdown-item" href="/msxt/user/myList.html?userId=${userId}&userName=${userName}&userBalance=${userBalance}">我的订单</a>
                <a class="dropdown-item" href="<c:url value="/main/list/user.html?userId=${userId}&userName=${userName}&userBalance=${userBalance}" />">主页面</a>
                <a class="dropdown-item" href="<c:url value="/main/list.html" />">退出</a>
            </div>
        </div>
    </div>
</nav>



<!-- Icons Grid -->
<section class="features-icons bg-light">
    <div class="container">
        <div class="row col-md-13 col-md-offset-2 custyle">
            <table class="table table-striped custab">

                <thead>
                <tr>
                    <th>订单编号</th>
                    <th>订单创建时间</th>
                    <th>用户编号</th>
                    <th>商品编号</th>
                    <th>购买数量</th>
                    <th>总价</th>
                    <th>是否付款</th>

                </tr>
                </thead>
                <c:forEach items="${orders}" var="orderInfo" >
                    <tr>
                        <td><c:out value="${orderInfo.orderId}" /></td>
                        <td><c:out value="${orderInfo.createTime}" /></td>
                        <td><c:out value="${orderInfo.userId}" /></td>
                        <td><c:out value="${orderInfo.productId}" /></td>
                        <td><c:out value="${orderInfo.num}" /></td>
                        <td><c:out value="$${orderInfo.totalPrice}" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${orderInfo.paid eq true}">
                                    付款成功
                                </c:when>
                                <c:otherwise>
                                    <sf:form method="post" action="/msxt/user/myList.html?userId=${userId}&orderId=${orderInfo.orderId}">
                                    <button class='btn btn-info btn-xs' type="submit">
                                        <span class="glyphicon glyphicon-edit"></span>
                                        支付
                                    </button>
                                    </sf:form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
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
                <p class="text-muted small mb-4 mb-lg-0">&copy; 【2020移动互联网软件工程】 ：徐志威，宋吉载   All Rights Reserved.</p>
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