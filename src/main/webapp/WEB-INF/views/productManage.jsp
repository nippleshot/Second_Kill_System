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

    <title>MSXT - ��Ʒ����</title>

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
        @import url("<c:url value="/resources/css/manage-page.css" />");
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
                <a class="dropdown-item" href="<c:url value="/order/list.html?managerId=${managerId}&managerName=${managerName}" />">��������</a>
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
                <thead>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#product_add"><i class="fa fa-plus"></i> �����Ʒ</button>
                <tr>
                    <th>��Ʒ��</th>
                    <th>ͼƬ</th>
                    <th>��Ʒ��</th>
                    <th>��Ʒ���</th>
                    <th style="width: 18%;">��ɱ��ʼ/����ʱ��</th>
                    <th>ԭ��</th>
                    <th>�ۿۼ�</th>
                    <th>�����</th>
                    <th class="text-center">����</th>
                </tr>
                </thead>

                <c:forEach items="${allProduct}" var="productInfo" >
                    <tr>
                        <td><c:out value="${productInfo.key.productId}"/></td>
                        <td>
                            <div class="product-image4">
                                <a href="#">
                                    <img class="pic-1" src="<c:out value="${productInfo.key.photo}"/>">
                                </a>
                            </div>
                        </td>
                        <td><c:out value="${productInfo.key.productName}"/></td>
                        <td><c:out value="${productInfo.key.description}"/></td>
                        <td><c:out value="${productInfo.key.startTime}"/><br/><c:out value="${productInfo.key.endTime}"/></td>
                        <td><c:out value="${productInfo.key.price}"/></td>
                        <td><c:out value="${productInfo.key.priceSpike}"/></td>
                        <td><c:out value="${productInfo.key.stock}"/></td>
                        <td class="text-center">
                            <button class='btn btn-info btn-xs' data-toggle="modal" data-target="#product_fix" data-id="<c:out value="${productInfo.key.productId}"/>" data-url="<c:out value="${productInfo.key.photo}"/>" data-name="<c:out value="${productInfo.key.productName}"/>" data-description="<c:out value="${productInfo.key.description}"/>" data-ori="<c:out value="${productInfo.key.price}"/>" data-sale="<c:out value="${productInfo.key.priceSpike}"/>" data-stock="<c:out value="${productInfo.key.stock}"/>" >
                                <span class="glyphicon glyphicon-edit"></span>
                                �޸�
                            </button>
                            <br/><br/>
                            <sf:form method="POST" action="/msxt/product/list/delete.html?productId=${productInfo.key.productId}&managerId=${managerId}&managerName=${managerName}">
                            <button class="btn btn-danger btn-xs" type="submit">
                                <span class="glyphicon glyphicon-remove"></span>
                                ɾ��
                            </button>
                            </sf:form>
                        </td>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>

    <div class="modal fade" id="product_add">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <a href="#" data-dismiss="modal" class="class pull-right"><span class="glyphicon glyphicon-remove"></span></a>
                    <h3 class="modal-title">�������Ʒ</h3>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <sf:form method="POST" action="/msxt/product/list/add.html?managerId=${managerId}&managerName=${managerName}" commandName="productInfo">
                        <div class="col-md-12 product_content">
                            <table class="table table-striped custab" style="width: 80%;">
                                <thead>
                                <tr>
                                    <th> </th>
                                    <th>��������Ʒ��������Ϣ</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>
                                        ͼƬ��URL��
                                    </td>
                                    <td>
                                        <sf:input path="photo" type="text" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��Ʒ��
                                    </td>
                                    <td>
                                        <sf:input path="productName" type="text" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��Ʒ���
                                    </td>
                                    <td>
                                        <sf:textarea path="description" cols="48" rows="8" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��ɱ��ʼ
                                    </td>
                                    <td>
                                        <sf:input path="startTime" type="datetime-local" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��ɱ����
                                    </td>
                                    <td>
                                        <sf:input path="endTime" type="datetime-local" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ԭ��
                                    </td>
                                    <td>
                                        <sf:input path="price" type="number" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        �ۿۼ�
                                    </td>
                                    <td>
                                        <sf:input path="priceSpike" type="number" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        �����
                                    </td>
                                    <td>
                                        <sf:input path="stock" type="number" required="required"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-12 text-center">
                            <button class='btn btn-info btn-xs' type="submit" style="background:#007bff">
                                <span class="glyphicon glyphicon-edit"></span>
                                ���
                            </button>
                            <button data-dismiss="modal" class="btn btn-danger btn-xs">
                                <span class="glyphicon glyphicon-remove"></span>
                                ȡ��
                            </button>
                        </div>
                        </sf:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="product_fix">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <a href="#" data-dismiss="modal" class="class pull-right"><span class="glyphicon glyphicon-remove"></span></a>
                    <h3 class="modal-title">�޸���Ʒ��Ϣ</h3>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <sf:form method="POST" action="/msxt/product/list/fix.html?managerId=${managerId}&managerName=${managerName}" commandName="productInfo">

                            <sf:input path="productId" type="hidden" id="product_id"/>
                        <div class="col-md-12 product_content">
                            <table class="table table-striped custab" style="width: 80%;">
                                <thead>
                                <tr>
                                    <th> </th>
                                    <th>��������Ʒ��������Ϣ</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>
                                        ͼƬ(URL)
                                    </td>
                                    <td>
                                        <sf:input path="photo" id="photo" type="text" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��Ʒ��
                                    </td>
                                    <td>
                                        <sf:input path="productName" id="product_name" type="text" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��Ʒ���
                                    </td>
                                    <td>
                                        <sf:textarea path="description" cols="48" rows="8" id="description" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��ɱ��ʼ
                                    </td>
                                    <td>
                                        <sf:input path="startTime" type="datetime-local" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��ɱ����
                                    </td>
                                    <td>
                                        <sf:input path="endTime" type="datetime-local" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ԭ��
                                    </td>
                                    <td>
                                        <sf:input path="price" type="number" id="price_original" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        �ۿۼ�
                                    </td>
                                    <td>
                                        <sf:input path="priceSpike" type="number" id="price_sale" required="required"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        �����
                                    </td>
                                    <td>
                                        <sf:input path="stock" type="number" id="stock" required="required"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-12 text-center">
                            <button class='btn btn-info btn-xs' type="submit">
                                <span class="glyphicon glyphicon-edit"></span>
                                �޸�
                            </button>
                            <button data-dismiss="modal" class="btn btn-danger btn-xs">
                                <span class="glyphicon glyphicon-remove"></span>
                                ȡ��
                            </button>
                        </div>
                        </sf:form>
                    </div>
                </div>
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
<script>
    $('#product_fix').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var id = button.data('id')
        var photo = button.data('url') // Extract info from data-* attributes
        var product_name = button.data('name')
        var description = button.data('description')
        var price_original = button.data('ori')
        var price_sale = button.data('sale')
        var stock = button.data('stock')
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this)
        modal.find('.modal-body #product_id').val(id)
        modal.find('.modal-body #photo').val(photo)
        modal.find('.modal-body #product_name').val(product_name)
        modal.find('.modal-body #description').val(description)
        modal.find('.modal-body #price_original').val(price_original)
        modal.find('.modal-body #price_sale').val(price_sale)
        modal.find('.modal-body #stock').val(stock)
    })
</script>

</body>

</html>
