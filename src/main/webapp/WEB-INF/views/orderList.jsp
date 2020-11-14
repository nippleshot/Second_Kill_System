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

    <title>MSXT - �����б�</title>

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
        <a class="navbar-brand" href="<c:url value="/main/list/manager.html?managerId=${managerId}&managerName=${managerName}" />">MSXT</a>
        <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                <c:out value="${managerName}"/>
            </button>
            <div class="dropdown-menu">
                <a class="dropdown-item" href="<c:url value="/product/list.html?managerId=${managerId}&managerName=${managerName}" />">��Ʒ����</a>
                <a class="dropdown-item" href='<c:url value="/order/list.html" />'>��������</a>
                <a class="dropdown-item" href="<c:url value="/main/list/manager.html?managerId=${managerId}&managerName=${managerName}" />">��ҳ��</a>
                <a class="dropdown-item" href="<c:url value="/main/list.html" />">�˳�</a>
            </div>
        </div>
    </div>
</nav>



<!-- Icons Grid -->
<section class="features-icons bg-light">
    <div class="container">
        <div class="row col-md-13 col-md-offset-2 custyle">
            <table class="table table-striped custab">

                <section class="search-sec">
                    <div class="container">
                        <form action="#" method="post" novalidate="novalidate">
                            <div class="row" style="width:150%">
                                <div class="col-lg-12">
                                    <div class="row">
                                        <sf:form method="POST">
                                            <div class="col-lg-4 col-md-4 col-sm-12 p-0">
                                                <input type="text" class="form-control search-slt" name="userId" placeholder="�û����">
                                            </div>
                                            <div class="col-lg-4 col-md-4 col-sm-12 p-0">
                                                <input type="text" class="form-control search-slt" name="productId" placeholder="��Ʒ���">
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                                <button type="submit" class="btn btn-danger wrn-btn">����</button>
                                            </div>
                                        </sf:form>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </section>

                <thead>
                <tr>
                    <th>�������</th>
                    <th>��������ʱ��</th>
                    <th>�û����</th>
                    <th>��Ʒ���</th>
                    <th>��������</th>
                    <th>�ܼ�</th>
                    <th>�Ƿ񸶿�</th>

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
                                <c:when test="${orderInfo.paid eq true}">����ɹ�</c:when>
                                <c:otherwise>��δ����</c:otherwise>
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
                <p class="text-muted small mb-4 mb-lg-0">&copy; ��2020�ƶ�������������̡� ����־�����μ���   All Rights Reserved.</p>
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